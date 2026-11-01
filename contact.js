
(() => {
  const form = document.getElementById('contactForm');
  const status = document.getElementById('contactStatus');

  if (!form || !status) return;

  form.addEventListener('submit', async (event) => {
    event.preventDefault();

    const button = form.querySelector('button[type="submit"]');
    const name = form.elements.name.value.trim();
    const email = form.elements.email.value.trim();
    const message = form.elements.message.value.trim();

    if (!name || !email || !message) {
      status.textContent = 'Please complete all fields.';
      return;
    }

    const cfg = window.SMA_CONFIG || {};

    if (!window.supabase || !cfg.SUPABASE_URL || !cfg.SUPABASE_ANON_KEY) {
      status.textContent = 'Message service is not configured.';
      return;
    }

    button.disabled = true;
    status.textContent = 'Sending your message...';

    try {
      const client = window.supabase.createClient(
        cfg.SUPABASE_URL,
        cfg.SUPABASE_ANON_KEY
      );

      const { error } = await client
        .from('client_messages')
        .insert([{ name, email, message }]);

      if (error) throw error;

      status.textContent = 'Thank you! Your message has been sent to SMA.';
      form.reset();
    } catch (error) {
      console.error(error);
      status.textContent = 'Message could not be sent. Please try again.';
    } finally {
      button.disabled = false;
    }
  });
})();
