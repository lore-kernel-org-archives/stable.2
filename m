Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED5489FC5;
	Thu, 10 Sep 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044758; cv=none; b=H/2cR6mTiv3DNHQyWhyuCs9I63TqSKqbz1BPgGqRSU+RxgnSo5hNfqGUXryOAmkttvp8eha48klv78D3sKUHgzc6zSDsZZR1qcv4iA+8Vigsy3S8BHYeHwEAg38w3fa4799KoXSc8ArsWhcfM5ZsUA5dWHGEXLASRUvIcAF9/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044758; c=relaxed/simple;
	bh=IrW6p3ZLdUFJ3Jcbs7wzREuMl/3huvxHpZzV84Qc2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2Vb5iex69EDgzDfbG1D/GKPSw24tNAqbOBNI45bg2Sd1nhBjgsV0nxITxiXaLiTY36P9QgpashSB7Zf8qMA4a/bx/v27hyqPoT/lx4gt8vCxO3Cyq3F0omcQU7WbEluUrhConHLSw9n3G2Q0CYlp966nGxYvrQxzBQJ6BHzCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Y4Oczp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Y4Oczp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3781F00893;
	Thu, 10 Sep 2026 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044756;
	bh=vSWTZlCSntg6/s4HIFneb0KG9/AZ/9u3vKr/KcS0Qic=;
	h=From:To:Cc:Subject:Date;
	b=D7Y4OczpfjPk8g947QcK6DTOcbQnIfKsa4WNCBsggomfwsx2/8JZMUUqETouktXvE
	 /k5hZNjjFfYXh7IFI0uPLMeeKFn5c8q38T6NLZ7UJF0An5ZePwGA1rEalNuoA+3AFP
	 jrRgMq0jflG1lKVzOm00UqU2MmOv4b9qfKVH7hMXeobbTqpmFnDpC8iEihtjpC4S/+
	 m6clcxuB0otldzhXH//aFlb0T88IGS3yP4SuTJQDXDXVEA5PKcj80BfiK+h/kWgRGy
	 lOlOV2eAsXEZK37bWiClz9f/ORzoNkvVEIUJ8tz2PxdN3eqWdYFzdd/IhaCMsv2CAR
	 NuJluM9piFTGg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eGX-00000002gkX-2gRo;
	Thu, 10 Sep 2026 14:52:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	syzbot+5fabc1ae99ff40690d84@syzkaller.appspotmail.com
Subject: [PATCH] tty: port: fix tty_port_tty_vhangup() race
Date: Thu, 10 Sep 2026 14:51:14 +0200
Message-ID: <20260910125114.640880-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers rely on tty_port_tty_vhangup() to synchronously hang up their
ports before tearing down resources as part of deregistration (e.g. on
physical disconnect).

If tty_port_tty_vhangup() races with another hangup it may however
return before the port has been shut down. This is in turn can lead to
use-after-free and NULL-pointer dereferences in racing ioctls (including
a synchronous hangup) and in processing of racing asynchronous hangups
(carrier loss).

Add the missing serialisation to tty_port_tty_vhangup() and
tty_port_hangup() so that the former does not return until the port has
been shut down also when there is a racing hangup.

Note that serial core does not use tty_port_hangup(), but it already
holds the port mutex when clearing port->tty and shutting down the port
in uart_hangup().

Fixes: 7ca0ff9ab321 ("tty: Add a full port_close function")
Cc: stable@vger.kernel.org	# 2.6.32: 2b5eac0f8c6e: tty: introduce and use tty_port_tty_vhangup() helper
Cc: stable@vger.kernel.org	# 2.6.32
Reported-by: syzbot+5fabc1ae99ff40690d84@syzkaller.appspotmail.com
Link: https://lore.kernel.org/6a944641.4d659fcc.734b4.003c.GAE@google.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_port.c   | 87 ++++++++++++++++++++++++++--------------
 include/linux/tty_port.h | 22 +---------
 2 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ae33987207b6..b22ff9eb7778 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -340,19 +340,9 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
-/**
- * tty_port_shutdown - internal helper to shutdown the device
- * @port: tty port to be shut down
- * @tty: the associated tty
- *
- * It is used by tty_port_hangup() and tty_port_close(). Its task is to
- * shutdown the device if it was initialized (note consoles remain
- * functioning). It lowers DTR/RTS (if @tty has HUPCL set) and invokes
- * @port->ops->shutdown().
- */
-static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+static void tty_port_shutdown_locked(struct tty_port *port, struct tty_struct *tty)
 {
-	guard(mutex)(&port->mutex);
+	lockdep_assert_held(&port->mutex);
 
 	if (port->console)
 		return;
@@ -372,6 +362,23 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		port->ops->shutdown(port);
 }
 
+/**
+ * tty_port_shutdown - internal helper to shutdown the device
+ * @port: tty port to be shut down
+ * @tty: the associated tty
+ *
+ * It is used by tty_port_hangup() and tty_port_close(). Its task is to
+ * shutdown the device if it was initialized (note consoles remain
+ * functioning). It lowers DTR/RTS (if @tty has HUPCL set) and invokes
+ * @port->ops->shutdown().
+ */
+static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+{
+	guard(mutex)(&port->mutex);
+
+	tty_port_shutdown_locked(port, tty);
+}
+
 /**
  * tty_port_hangup		-	hangup helper
  * @port: tty port
@@ -385,36 +392,58 @@ void tty_port_hangup(struct tty_port *port)
 {
 	struct tty_struct *tty;
 
-	scoped_guard(spinlock_irqsave, &port->lock) {
-		port->count = 0;
-		tty = port->tty;
-		if (tty)
-			set_bit(TTY_IO_ERROR, &tty->flags);
-		port->tty = NULL;
-	}
+	scoped_guard(mutex, &port->mutex) {
+		scoped_guard(spinlock_irqsave, &port->lock) {
+			port->count = 0;
+			tty = port->tty;
+			if (tty)
+				set_bit(TTY_IO_ERROR, &tty->flags);
+			port->tty = NULL;
+		}
 
-	tty_port_set_active(port, false);
-	tty_port_shutdown(port, tty);
+		tty_port_set_active(port, false);
+		tty_port_shutdown_locked(port, tty);
+	}
 	tty_kref_put(tty);
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->delta_msr_wait);
 }
 EXPORT_SYMBOL(tty_port_hangup);
 
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
+/**
+ * tty_port_tty_hangup - helper to hang up a tty asynchronously
+ * @port: tty port
+ * @check_clocal: hang only ttys with %CLOCAL unset?
+ */
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
 	scoped_guard(tty_port_tty, port) {
 		struct tty_struct *tty = scoped_tty();
 
-		if (!check_clocal || !C_CLOCAL(tty)) {
-			if (async)
-				tty_hangup(tty);
-			else
-				tty_vhangup(tty);
-		}
+		if (!check_clocal || !C_CLOCAL(tty))
+			tty_hangup(tty);
+	}
+}
+EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
+
+/**
+ * tty_port_tty_vhangup - helper to hang up a tty synchronously
+ * @port: tty port
+ */
+void tty_port_tty_vhangup(struct tty_port *port)
+{
+	struct tty_struct *tty;
+
+	mutex_lock(&port->mutex);
+	tty = tty_port_tty_get(port);
+	mutex_unlock(&port->mutex);
+
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
 	}
 }
-EXPORT_SYMBOL_GPL(__tty_port_tty_hangup);
+EXPORT_SYMBOL_GPL(tty_port_tty_vhangup);
 
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 23cad403bb8f..8d22c59c6f15 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -245,7 +245,8 @@ bool tty_port_carrier_raised(struct tty_port *port);
 void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async);
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_vhangup(struct tty_port *port);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
@@ -264,25 +265,6 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
-/**
- * tty_port_tty_hangup - helper to hang up a tty asynchronously
- * @port: tty port
- * @check_clocal: hang only ttys with %CLOCAL unset?
- */
-static inline void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
-{
-	__tty_port_tty_hangup(port, check_clocal, true);
-}
-
-/**
- * tty_port_tty_vhangup - helper to hang up a tty synchronously
- * @port: tty port
- */
-static inline void tty_port_tty_vhangup(struct tty_port *port)
-{
-	__tty_port_tty_hangup(port, false, false);
-}
-
 #ifdef CONFIG_TTY
 void tty_kref_put(struct tty_struct *tty);
 __DEFINE_CLASS_IS_CONDITIONAL(tty_port_tty, true);
-- 
2.55.0

