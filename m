Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536851599F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220681; cv=none; b=bInRDOAeAqOlIVEZDrInbbp/buLFoHKQGBZKvWUlrl9CT7eV4WwAYoK2sPslB4c0/7XVC3TWXStg5Qf+ZIVeLABNK3Sz6VqzSNAaGSjjFmaYS0tHy2Dne6+zbe7FTjuEPG7mCzzU38KZuXTHKrRMC7YN0E+oZDnSDGrJ8MnKnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220681; c=relaxed/simple;
	bh=/qBMNAkDORYrg8vjx5sgLlzyUVd4qYNg2iHoor9Judk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFHpsL8ZmTgK6RH4hbdnn4wFt+Txb7xJGO1ag/W1GvhEGwHskdg4xJr6au6PD/sWB0n/WMzHSHPmcoaaNT89NV/C59XG67EtOnCOmkWeQZIUy+mT0v+rsw2TOzKz3SWSw7lgkw0XSJjhMYIRjLBbx5ZNfNSChlhQ5l913FhRER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtoHdlJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtoHdlJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00F31F0089B;
	Mon,  5 Oct 2026 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220680;
	bh=Prvn2rm4kwZ1ZFounzw1pfHaDsZuX4HoE/4SmXNgEdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtoHdlJxjQJ74Ms5R0y9AFDkojVrpTZwNGn2toficNQ1v6mRjcHkZ6e+37k8MLyU+
	 80sD+I93V02EsvThdh+dezCNkRPIrVgvEqlBWwO+LgeknsnxyksVlP8sEQUdOPshCI
	 e8vYaln1eTct4aIC4AN5SRJkRG4UdLViR5hI0/xcEBU1CiHQEN6LLH8oxLy+7BmUX+
	 CNsbIzMrt9WsPLBISSAAnSnI2oAfFmjRKKbxu2jKKOClBZhLEdrhcKKwo/TBHLVie/
	 qxpRPawqj+NWAfNc0rkK97cfZu0RuQaJ1YpCBpEO251D5YbOefYTFqRSU3rCGE3jwE
	 EC3V4iPimLbjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] tty: tty_port: use guard()s
Date: Mon,  5 Oct 2026 13:17:53 -0400
Message-ID: <20261005171429.3065052-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005171429.3065052-1-sashal@kernel.org>
References: <2026100521-mammal-arose-32f1@gregkh>
 <20261005171429.3065052-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 88d65e22c8bf7a4b6d61098d67727d14f1c5930f ]

Having all the new guards, use them in the tty_port code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-6-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 56964f6a3123 ("tty: tty_port: restore TTY_IO_ERROR on activation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 168 ++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 94 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index e10ccce1653e3..64b2584ff7a18 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -63,12 +63,8 @@ static void tty_port_default_lookahead_buf(struct tty_port *port, const u8 *p,
 
 static void tty_port_default_wakeup(struct tty_port *port)
 {
-	struct tty_struct *tty = tty_port_tty_get(port);
-
-	if (tty) {
-		tty_wakeup(tty);
-		tty_kref_put(tty);
-	}
+	scoped_guard(tty_port_tty, port)
+		tty_wakeup(scoped_tty());
 }
 
 const struct tty_port_client_operations tty_port_default_client_ops = {
@@ -245,26 +241,27 @@ EXPORT_SYMBOL_GPL(tty_port_unregister_device);
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
 	/* We may sleep in get_zeroed_page() */
-	mutex_lock(&port->buf_mutex);
-	if (port->xmit_buf == NULL) {
-		port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
-		if (port->xmit_buf)
-			kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
-	}
-	mutex_unlock(&port->buf_mutex);
+	guard(mutex)(&port->buf_mutex);
+
+	if (port->xmit_buf)
+		return 0;
+
+	port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
 	if (port->xmit_buf == NULL)
 		return -ENOMEM;
+
+	kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
+
 	return 0;
 }
 EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
-	mutex_lock(&port->buf_mutex);
+	guard(mutex)(&port->buf_mutex);
 	free_page((unsigned long)port->xmit_buf);
 	port->xmit_buf = NULL;
 	INIT_KFIFO(port->xmit_fifo);
-	mutex_unlock(&port->buf_mutex);
 }
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
 
@@ -321,13 +318,8 @@ EXPORT_SYMBOL(tty_port_put);
  */
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
-	unsigned long flags;
-	struct tty_struct *tty;
-
-	spin_lock_irqsave(&port->lock, flags);
-	tty = tty_kref_get(port->tty);
-	spin_unlock_irqrestore(&port->lock, flags);
-	return tty;
+	guard(spinlock_irqsave)(&port->lock);
+	return tty_kref_get(port->tty);
 }
 EXPORT_SYMBOL(tty_port_tty_get);
 
@@ -341,12 +333,9 @@ EXPORT_SYMBOL(tty_port_tty_get);
  */
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
+	guard(spinlock_irqsave)(&port->lock);
 	tty_kref_put(port->tty);
 	port->tty = tty_kref_get(tty);
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
@@ -362,24 +351,24 @@ EXPORT_SYMBOL(tty_port_tty_set);
  */
 static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 {
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
+
 	if (port->console)
-		goto out;
+		return;
 
-	if (tty_port_initialized(port)) {
-		tty_port_set_initialized(port, false);
-		/*
-		 * Drop DTR/RTS if HUPCL is set. This causes any attached
-		 * modem to hang up the line.
-		 */
-		if (tty && C_HUPCL(tty))
-			tty_port_lower_dtr_rts(port);
+	if (!tty_port_initialized(port))
+		return;
 
-		if (port->ops->shutdown)
-			port->ops->shutdown(port);
-	}
-out:
-	mutex_unlock(&port->mutex);
+	tty_port_set_initialized(port, false);
+	/*
+	 * Drop DTR/RTS if HUPCL is set. This causes any attached
+	 * modem to hang up the line.
+	 */
+	if (tty && C_HUPCL(tty))
+		tty_port_lower_dtr_rts(port);
+
+	if (port->ops->shutdown)
+		port->ops->shutdown(port);
 }
 
 /**
@@ -394,15 +383,15 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 void tty_port_hangup(struct tty_port *port)
 {
 	struct tty_struct *tty;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
-	port->count = 0;
-	tty = port->tty;
-	if (tty)
-		set_bit(TTY_IO_ERROR, &tty->flags);
-	port->tty = NULL;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		port->count = 0;
+		tty = port->tty;
+		if (tty)
+			set_bit(TTY_IO_ERROR, &tty->flags);
+		port->tty = NULL;
+	}
+
 	tty_port_set_active(port, false);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
@@ -413,15 +402,16 @@ EXPORT_SYMBOL(tty_port_hangup);
 
 void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
 {
-	struct tty_struct *tty = tty_port_tty_get(port);
+	scoped_guard(tty_port_tty, port) {
+		struct tty_struct *tty = scoped_tty();
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty))) {
-		if (async)
-			tty_hangup(tty);
-		else
-			tty_vhangup(tty);
+		if (!check_clocal || !C_CLOCAL(tty)) {
+			if (async)
+				tty_hangup(tty);
+			else
+				tty_vhangup(tty);
+		}
 	}
-	tty_kref_put(tty);
 }
 EXPORT_SYMBOL_GPL(__tty_port_tty_hangup);
 
@@ -510,7 +500,6 @@ int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
 	int do_clocal = 0, retval;
-	unsigned long flags;
 	DEFINE_WAIT(wait);
 
 	/* if non-blocking mode is set we can pass directly to open unless
@@ -539,10 +528,10 @@ int tty_port_block_til_ready(struct tty_port *port,
 	retval = 0;
 
 	/* The port lock protects the port counts */
-	spin_lock_irqsave(&port->lock, flags);
-	port->count--;
-	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		port->count--;
+		port->blocked_open++;
+	}
 
 	while (1) {
 		/* Indicate we are open */
@@ -581,11 +570,11 @@ int tty_port_block_til_ready(struct tty_port *port,
 	/* Update counts. A parallel hangup will have set count to zero and
 	 * we must not mess that up further.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		if (!tty_hung_up_p(filp))
+			port->count++;
+		port->blocked_open--;
+	}
 	if (retval == 0)
 		tty_port_set_active(port, true);
 	return retval;
@@ -624,28 +613,24 @@ static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
-	unsigned long flags;
-
 	if (tty_hung_up_p(filp))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (tty->count == 1 && port->count != 1) {
-		tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
-			 port->count);
-		port->count = 1;
-	}
-	if (--port->count < 0) {
-		tty_warn(tty, "%s: bad port count (%d)\n", __func__,
-			 port->count);
-		port->count = 0;
-	}
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		if (tty->count == 1 && port->count != 1) {
+			tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
+				 port->count);
+			port->count = 1;
+		}
+		if (--port->count < 0) {
+			tty_warn(tty, "%s: bad port count (%d)\n", __func__,
+				 port->count);
+			port->count = 0;
+		}
 
-	if (port->count) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return 0;
+		if (port->count)
+			return 0;
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	tty->closing = 1;
 
@@ -764,9 +749,8 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
 {
-	spin_lock_irq(&port->lock);
-	++port->count;
-	spin_unlock_irq(&port->lock);
+	scoped_guard(spinlock_irq, &port->lock)
+		++port->count;
 	tty_port_tty_set(port, tty);
 
 	/*
@@ -775,21 +759,17 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 	 * port mutex.
 	 */
 
-	mutex_lock(&port->mutex);
-
-	if (!tty_port_initialized(port)) {
+	scoped_guard(mutex, &port->mutex) {
+		if (tty_port_initialized(port))
+			break;
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
-
-			if (retval) {
-				mutex_unlock(&port->mutex);
+			if (retval)
 				return retval;
-			}
 		}
 		tty_port_set_initialized(port, true);
 	}
-	mutex_unlock(&port->mutex);
 	return tty_port_block_til_ready(port, tty, filp);
 }
 EXPORT_SYMBOL(tty_port_open);
-- 
2.53.0

