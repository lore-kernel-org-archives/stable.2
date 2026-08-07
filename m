Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CF371898
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073692; cv=none; b=Uo5cb8+FKfVu/kc7WS+qbAWYEYyJaYTWoq+OvibXzU2vuxfdRXgEWANzsV8wJ4sRyECxA9Oh9mYeVodZiiTupA4BIHgOMHvvzohP/ivg4dmb/VTHLDpLq/mIPLEBV1l53ayztD+GC+Zh53M4PsM/VMtjoLJY7x0C6+xHyd5oegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073692; c=relaxed/simple;
	bh=M741F+ROLfzvRErnpjfC+lSlVzO7TRAzpVVUJtqEoII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svXU9/wc7HkRpUM+DdqsISNtbQaeZZD91ldgwaYAi8vFl/2loLGUmOQ+frdTF7bp1nKrI75HzoYp13/OZEo5neaMxuvPh3z5AaVSsin4nztKlaUV6lg7vrDj46nfZWAkn2MMhu36NbW2A6MrCnfj7UgpEK97UP5n5POrvGJeQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+utKRYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+utKRYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929981F000E9;
	Fri,  7 Aug 2026 03:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786073691;
	bh=+RQZ4DOiWqnm4v0RHlgMx9kMZ7U+eh1uDNSoigieo4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+utKRYfJUi2ocYvKsxdBkdXz2iLhnUZVjGdIty4cQgAxoLs3GpZzCHqW5ZiOk45H
	 Fj8IE6BbeTsn6lnFR8CXCs59lOgSXQzRlqzvDLqK3XFqe8a1lqqaQH8IGp5KdtHxuj
	 T5MrFbitlDCKgz6N4Qeaa9YX5QMP8492T1vQ+lRtBY9hZFuDoMY2yvaj0XDNibNw2K
	 /MGqPun9BzF3RvqtPVFme1Ftw/usrYkTZElhE8kVJO0nB1allmibs5pgaQouXCqaMR
	 rLloVuZR9K+k+/jQEl8a0dk/VfmSeHFEOo0csYlM50TSpk59oMQOMOFXGe78F1Ws1X
	 Fc7aTJpNd1J5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] sc16is7xx: Properly resume TX after stop
Date: Thu,  6 Aug 2026 23:34:44 -0400
Message-ID: <20260807033449.1725763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072914-sandbar-very-7f7d@gregkh>
References: <2026072914-sandbar-very-7f7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Moń <tomasz.mon@camlingroup.com>

[ Upstream commit cc4c1d05eb10c3ad4c6315f1897bc56b1e7429aa ]

sc16is7xx_stop_tx() clears THRI bit and thus disables THRI interrupt.
This makes it possible for transmission to cease indefinitely when more
than 64 characters are being sent.

The sc16is7xx_handle_tx() call executed by sc16is7xx_tx_proc() can send
up to FIFO length (64) characters. If more characters are written to the
output buffer, then the THRI interrupt is needed.

Solve the issue by enabling THRI interrupt in sc16is7xx_tx_proc().

Signed-off-by: Tomasz Moń <tomasz.mon@camlingroup.com>
Link: https://lore.kernel.org/r/20220301060332.2561851-2-tomasz.mon@camlingroup.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af071d9e07e5 ("serial: sc16is7xx: implement gpio get_direction() callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 758537381d774..3a28331dec407 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -307,7 +307,8 @@ struct sc16is7xx_devtype {
 
 struct sc16is7xx_one_config {
 	unsigned int			flags;
-	u8				ier_clear;
+	u8				ier_mask;
+	u8				ier_val;
 };
 
 struct sc16is7xx_one {
@@ -341,6 +342,9 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
+static void sc16is7xx_stop_tx(struct uart_port *port);
+
 #define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
@@ -650,6 +654,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int txlen, to_send, i;
+	unsigned long flags;
 
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -658,8 +663,12 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		spin_lock_irqsave(&port->lock, flags);
+		sc16is7xx_stop_tx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
+	}
 
 	/* Get length of data pending in circular buffer */
 	to_send = uart_circ_chars_pending(xmit);
@@ -686,8 +695,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		sc16is7xx_fifo_write(port, to_send);
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sc16is7xx_stop_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -762,6 +776,7 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
@@ -770,6 +785,10 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	mutex_lock(&s->efr_lock);
 	sc16is7xx_handle_tx(port);
 	mutex_unlock(&s->efr_lock);
+
+	spin_lock_irqsave(&port->lock, flags);
+	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -819,7 +838,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 	}
 	if (config.flags & SC16IS7XX_RECONF_IER)
 		sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
-				      config.ier_clear, 0);
+				      config.ier_mask, config.ier_val);
 
 	if (config.flags & SC16IS7XX_RECONF_RS485)
 		sc16is7xx_reconf_rs485(&one->port);
@@ -830,8 +849,24 @@ static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val &= ~bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
 	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_clear |= bit;
+	one->config.ier_mask |= bit;
+	one->config.ier_val |= bit;
 	kthread_queue_work(&s->kworker, &one->reg_work);
 }
 
@@ -1059,8 +1094,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			      SC16IS7XX_EFCR_TXDISABLE_BIT,
 			      0);
 
-	/* Enable RX, TX interrupts */
-	val = SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
+	/* Enable RX interrupt */
+	val = SC16IS7XX_IER_RDI_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
 
 	return 0;
-- 
2.53.0

