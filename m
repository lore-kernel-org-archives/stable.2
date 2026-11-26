Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705746;
	b=kgo9WfK/Zo5qqhXLZ9cDA6RNUZ8HssN9UiWbChte8CMJoXXhc3ZhN1Slio3Bupk0f68B
	 yEXGBpL6kyQPkpBdXKBd4V6w+znF+C+hs+mI1sAsnaPvqTCR25P75Y2sm3seI0rKIFiLW
	 XS8H55j0pzQzoigoMcWNPrOb0aizTg7NtOoiCSVLRieHOIyFrG8j1rmimn6cMX21DuoPn
	 9LeVwlUlKWMwl2GRXszEvbooj7G0b2yhjcKR6wGPSy55cH9M1EacekGkW78n3UF6YlIKE
	 0WMBnqJ904zw//qluLWWUWc17y5wideKkkkIf9tnWvuZpp/G9DBWg+HktKfX1A6GzXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h0PQMbOwYrk8ZaowZv4J5qiC0avt9zfGvb70ySOTrnU=;
	b=eNaTyvMSEBaPGfySy6dhMPl2OLiH4WGoUooqzTOzvnIAaS0gMyKSfuqISLrldpN/QnPL
	 y1EhA1NOhuDZ+4P0tuiykhAAJhoTw3P12YPvzCjwoV9cwmR92iXzb3FWJ8Aojs/GsweVG
	 FsF5mKeKAe//WQszkeA+6y6O3OghXI4rjgB5yntASjv6VxUYTbnLiFte3w4dctkKbrrUZ
	 CrMjrd3RCL5X0inoCcMAW8fkh62DUfj9LfNMAGywMM5hMqxhWl/3oyHfzOtF7miAVmFLc
	 GiwRnz7k5zWvGB8dEUtjDk45oZawslDle1rusS5kThK4+FIEItKxYDekrEH0xst1Hbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iQL/vODS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A1606A684
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQL/vODS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B471F000CF;
	Thu, 26 Nov 2026 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705746;
	bh=h0PQMbOwYrk8ZaowZv4J5qiC0avt9zfGvb70ySOTrnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQL/vODSingoNKWqWxXrCcuI0EYnMWHVTt1CIk1Hdy2YVdgcZmykEqvgNoWirgOoM
	 UOx9iOZ99G96D/QbnDHQkLR7MjTKeNFSDL4crCaeYoR7CniWfne3HRhmLfP03LOtKl
	 njMVCfnYMbmC3IgH/9lQZI4pC/We5Is2Nd1JsVGyzIjQm3H0+RRoqczVjqB65nziBq
	 QLb5v7DNqfYofL0S66ZQo/x52yWHqVDAVVgTsPO4OGI6JF1+X4VxuPPL69u85byaA8
	 Vk0NL27IqWzRhvJtUrKLOFjVUmqzcke3ZeGcHUKoC7ADHTxwAIwpYn+enTvuKAEc9c
	 yE2jRc5LWe0dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] serial: core: respect runtime PM when sending x_char
Date: Thu, 26 Nov 2026 10:09:03 -0500
Message-ID: <20261126150849.2244395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112522-crinkly-seducing-d403@gregkh>
References: <2026112522-crinkly-seducing-d403@gregkh>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 84da8238f7bd3025fc16da32c4cd9992c95a783b ]

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
[ sashal: Kept the tree's explicit uart_port_lock_irqsave/unlock_irqrestore calls in uart_send_xchar() instead of upstream's guard(uart_port_lock_irqsave), with the new uart_port_start_tx() call placed inside the lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 25 +++++++++++++++----------
 drivers/tty/serial/serial_port.c |  4 ++--
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c9f32c39d6f2e..cc14b2a109d89 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -134,17 +134,11 @@ static void uart_stop(struct tty_struct *tty)
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
@@ -163,6 +157,16 @@ static void __uart_start(struct uart_state *state)
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
@@ -725,8 +729,9 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 	else {
 		uart_port_lock_irqsave(port, &flags);
 		port->x_char = ch;
-		if (ch)
-			port->ops->start_tx(port);
+		/* It goes out even if the transmission is stopped */
+		if (ch && !(port->flags & UPF_DEAD))
+			uart_port_start_tx(port);
 		uart_port_unlock_irqrestore(port, flags);
 	}
 	uart_port_deref(port);
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 85285c56fabff..b873220862d2e 100644
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
-- 
2.53.0

