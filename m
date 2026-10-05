Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722C37F322
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190254; cv=none; b=Db5TB2huUnuA8Exhsq3kNpB11qL2LTJF3gx5oFX2d6vfo0BCHvyZ3DZ1/6HBMN25UtEJZ3riuqqdh4VfdEKdrUwFfbN2TOvpRDYKDMJDM+KWdaJCUBgy47+M1qp2TfvirZpbfzRmVXu7yFjJMJWHHR9tZMIFxlnLtC/KNXgUW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190254; c=relaxed/simple;
	bh=b8/YhC7hoq5Aso6C3RM8aqMXNHLtIHgYK/rglcsWEhc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O6qmFPFAqbGC1nqV6g6KoVCRJMjHoByqXYkM/UEl6BKlR7Bz05xwDQVkSJfTx9MhJiOALvbHAajGFmsdTKbSbWXtbltUOmUGSbZKe+RgdxXA3js38jvq8p40qLqh0AQFu7M/5H7VRY3DNfPjgy4B0/N6UuH4WM56eHdN1oDAR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/E8BIql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/E8BIql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497FC1F000FF;
	Mon,  5 Oct 2026 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190252;
	bh=T3hsdVGPyXWgDP4jK2E5IK2dhlzKwxKbfesbJMnmC9M=;
	h=Subject:To:Cc:From:Date;
	b=l/E8BIqlJjM7EkZ3GAQE3W6eKqCEC2Wdm3WoHavvBDQBWxLwNGOko/vAICg9pk87v
	 FA6X6d8UBzYJ4JIUOqYxiMsiHoVf5EopkELWQC94+skMGca4a0L/f4R9vlr30XIPzk
	 hZ3OWxXBJZDu/OXzLrHLxzGsK6M0aE9RHvYA1ARw=
Subject: FAILED: patch "[PATCH] tty: port: fix tty_port_tty_vhangup() race" failed to apply to 6.12-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:50:50 +0200
Message-ID: <2026100549-shortcake-ecosphere-463d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b48820de8c1a596c5b99775524dfce73c6576c5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100549-shortcake-ecosphere-463d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b48820de8c1a596c5b99775524dfce73c6576c5d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 10 Sep 2026 14:51:14 +0200
Subject: [PATCH] tty: port: fix tty_port_tty_vhangup() race

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
Cc: stable@kernel.org	# 2.6.32: 2b5eac0f8c6e: tty: introduce and use tty_port_tty_vhangup() helper
Cc: stable@kernel.org	# 2.6.32
Reported-by: syzbot+5fabc1ae99ff40690d84@syzkaller.appspotmail.com
Link: https://lore.kernel.org/6a944641.4d659fcc.734b4.003c.GAE@google.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910125114.640880-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
 	}
 }
-EXPORT_SYMBOL_GPL(__tty_port_tty_hangup);
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
+	}
+}
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

