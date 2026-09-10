const RESEND_BASE = "https://api.resend.com";
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
};

function json(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { "Content-Type": "application/json", ...CORS },
  });
}

async function resend(path, method, env, payload) {
  return fetch(`${RESEND_BASE}${path}`, {
    method,
    headers: {
      Authorization: `Bearer ${env.RESEND_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });
}

async function handleSubscribe(body, env) {
  const email = String(body.email || "").trim().toLowerCase();
  if (!EMAIL_RE.test(email)) {
    return json({ error: "Please enter a valid email address." }, 400);
  }

  const res = await resend(`/audiences/${env.RESEND_AUDIENCE_ID}/contacts`, "POST", env, { email });
  if (!res.ok) {
    const text = await res.text();
    // Already subscribed — treat as success
    if (res.status === 409 || res.status === 422) {
      return json({ ok: true });
    }
    console.error("Resend contacts error:", res.status, text);
    return json({ error: "Could not subscribe right now. Please try again later." }, 502);
  }
  return json({ ok: true });
}

async function handleContact(body, env) {
  const name = String(body.name || "").trim().slice(0, 100);
  const email = String(body.email || "").trim().slice(0, 200);
  const message = String(body.message || "").trim().slice(0, 5000);

  if (!name || !EMAIL_RE.test(email) || !message) {
    return json({ error: "Please fill in your name, a valid email, and a message." }, 400);
  }

  const res = await resend("/emails", "POST", env, {
    from: env.CONTACT_FROM || "onboarding@resend.dev",
    to: [env.CONTACT_TO],
    reply_to: email,
    subject: `New message from ${name} via javaded.com`,
    text: `Name: ${name}\nEmail: ${email}\n\n${message}`,
  });

  if (!res.ok) {
    console.error("Resend email error:", res.status, await res.text());
    return json({ error: "Could not send your message right now. Please try again later." }, 502);
  }
  return json({ ok: true });
}

export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, { status: 204, headers: CORS });
    }
    if (request.method !== "POST") {
      return json({ error: "Method not allowed" }, 405);
    }

    let body;
    try {
      body = await request.json();
    } catch {
      return json({ error: "Invalid request." }, 400);
    }

    // Honeypot: bots fill hidden fields. Pretend success, do nothing.
    if (body.website) {
      return json({ ok: true });
    }

    const { pathname } = new URL(request.url);
    try {
      if (pathname === "/subscribe") {
        return await handleSubscribe(body, env);
      }
      if (pathname === "/contact") {
        return await handleContact(body, env);
      }
    } catch (err) {
      console.error("Worker error:", err);
      return json({ error: "Something went wrong. Please try again later." }, 500);
    }

    return json({ error: "Not found" }, 404);
  },
};
