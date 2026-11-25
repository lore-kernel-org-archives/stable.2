Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608346;
	b=uQwzqW6uv+TK6s5NH8oH5lEsLnFSe1hmeG+09yUJvTKTulXE4O7rvU/Qja92+/YEFL1v
	 DRwBzVvY7lkgz9AjYxacPF3zrqcldMqhh2wPFNKFbg+BsgX2//XZP13jCS9Tyd4BhUgGa
	 sm1L4rdiPxecS2KfCMk6yURSIogbcQsjI994DM57SeAF0yY7FP0knxUyAdDSDki3qUvH8
	 aaCz+zWQeR9VzpvPHPHRH1+6XDjlHsieZGq76h68jjQwOqMt5qnqbRjpcCkyYBWyriGF5
	 LW9wjIvzpOQaV4xAd2JrJ4eryfHSFAmD9D5jUBuuG81aDdyuhbI6TsXe7WgxbFwAITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608346;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/6QhYAPdz4EKmjtocuJ+KKl2Pq7WLGEOyg1n1DDFqTM=;
	b=LF6DTpcAVKEhst8KCtNoxzkYWI0V8tBPutYuHe8cJNw/XoinQ3zdPkT8sxLnKTN4Vi3w
	 q3+Q5P0UFsG6rZzIWgwrV52Gx0pXudE6M3KNa6iKuskymrKa5/0D7V7YgR0GJ1vOFuv9W
	 3tZyzFxKrF761soMILcas/Ftts0WhxUL7cUn6REdHo7Zx0eaD0nuozceu/0aQ5F8i2g4+
	 5JgAlPWD32NKeTPY5RnmGppfy7UTo6oPOTM6fuMEfojeeMrfvb3WbWAlUDRILnh3EvePv
	 b0sFi4a2cBb3FU/mhV9cLO3FO7qrAzneFvHl3AriwHtWEil3WHp2Ap8MM7mcdhXpNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PTYtVqkh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABE606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PTYtVqkh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2A41F000C4;
	Wed, 25 Nov 2026 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608345;
	bh=/6QhYAPdz4EKmjtocuJ+KKl2Pq7WLGEOyg1n1DDFqTM=;
	h=Subject:To:Cc:From:Date;
	b=PTYtVqkhgZUu10R6cmejHjYBIH2rUThPndAmbLNRZhg3f7LYw3vlaJIw3o4SeWgMF
	 ALXSVMuiYkaIYv3kY0NHSn3IqxQzhGc+WVxc7gDoCKw4e3H0lCXDqyj7oDCXqGOoL8
	 DpAGxj3FPwiBJJTBlmAfMMwc8VsHUsy1g3g3AvIw=
Subject: FAILED: patch "[PATCH] serial: core: respect runtime PM when sending x_char" failed to apply to 6.12-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,hvilleneuve@dimonoff.com,jirislaby@kernel.org,johan@kernel.org,john.ogness@linutronix.de,kmehltretter@gmail.com,stable@kernel.org,tony.lindgren@linux.intel.com,u.kleine-koenig@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:32:22 +0100
Message-ID: <2026112522-crinkly-seducing-d403@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 84da8238f7bd3025fc16da32c4cd9992c95a783b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112522-crinkly-seducing-d403@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84da8238f7bd3025fc16da32c4cd9992c95a783b Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 12:06:28 +0100
Subject: [PATCH] serial: core: respect runtime PM when sending x_char
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__uart_start() calls the start_tx operation only if the port is runtime
active.  Otherwise it asks for a resume, and
serial_port_runtime_resume() starts the transmitter.

uart_send_xchar() calls start_tx at once, under the port lock, whatever
the state of the device.  With 8250_omap, serial8250_start_tx() then
calls pm_runtime_get_sync() for a suspended device: that sleeps, and
omap8250_runtime_resume() takes the port lock again.  A tcflow(TCIOFF)
on an idle port is enough, if autosuspend has been enabled.  It was
allowed as long as that driver used pm_runtime_irq_safe().

Share the part of __uart_start() that deals with runtime PM.  A stopped
transmission still does not hold up an XON or XOFF character.  Let a
pending x_char count as work for serial_port_runtime_resume(), and keep
the port from being suspended with it.

Fixes: 8700a7ea5519 ("serial: 8250_omap: Drop pm_runtime_irq_safe()")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-2-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..b06d2649be34 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -135,17 +135,11 @@ static void uart_stop(struct tty_struct *tty)
 	uart_port_unlock_deref(port, flags);
 }
 
-static void __uart_start(struct uart_state *state)
+static void uart_port_start_tx(struct uart_port *port)
 {
-	struct uart_port *port = state->uart_port;
-	struct serial_port_device *port_dev;
+	struct serial_port_device *port_dev = port->port_dev;
 	int err;
 
-	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
-		return;
-
-	port_dev = port->port_dev;
-
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
 	if (err < 0 && err != -EINPROGRESS) {
@@ -164,6 +158,16 @@ static void __uart_start(struct uart_state *state)
 	pm_runtime_put_autosuspend(&port_dev->dev);
 }
 
+static void __uart_start(struct uart_state *state)
+{
+	struct uart_port *port = state->uart_port;
+
+	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
+		return;
+
+	uart_port_start_tx(port);
+}
+
 static void uart_start(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -718,8 +722,9 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 	else {
 		guard(uart_port_lock_irqsave)(port);
 		port->x_char = ch;
-		if (ch)
-			port->ops->start_tx(port);
+		/* It goes out even if the transmission is stopped */
+		if (ch && !(port->flags & UPF_DEAD))
+			uart_port_start_tx(port);
 	}
 	uart_port_deref(port);
 }
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 2fc48cd63f6c..f2f7cdd3a54c 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -23,8 +23,8 @@
 /* Only considers pending TX for now. Caller must take care of locking */
 static int __serial_port_busy(struct uart_port *port)
 {
-	return !uart_tx_stopped(port) &&
-		!kfifo_is_empty(&port->state->port.xmit_fifo);
+	return port->x_char || (!uart_tx_stopped(port) &&
+		!kfifo_is_empty(&port->state->port.xmit_fifo));
 }
 
 static int serial_port_runtime_resume(struct device *dev)

