Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C22336895
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469054; cv=none; b=LImtgNTuJzLCQlNQpRwzeSGt+4NIXVF0abD3l8fHRNXDAWWP6o8GNIP5CQVqT+kDX7UAfk+ISTeDSSs1M5kunkc0g1Xz4JGye8syPmA7KuPZ3FL2FU8419ikNHcDoHJDs5YVOZW8isLJBf16KsjasG+EHi3f+1jFpjvpg0NMu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469054; c=relaxed/simple;
	bh=1Ae6EomzE/QmBGYiV5mk1M9vk5nsB1nfD2lGvptvMfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLRP/KsYV/vVGC9AFaNtb+elyqqyZIXMSt5Ua/h5weGYZ2fU1xRD6l3DEj9d9HyNKgjLwOvTrFKGf9pWGh7GQw35J/BLwVfH0BDkErMXah9CaCZdkroVe4OWt2Cdkvzbhr38odZZMx83WHsf+4bX1NqLTesSQcoVOKz+rh8KLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM6NgBE5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM6NgBE5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso1518603a12.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469053; x=1792073853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xn4NE3yaQrjXfCQOoGywwWxzBDjnXzrFJ0pgj+Z4FLs=;
        b=hM6NgBE55NHJMV0Qq46s/4cHIK+o9C3DF267vtDzULyMtUkKddU5fEv8RloeOxaR1a
         E1z5f8D6ROd9MN7tVx4R/4kgyR/Cg5QEE99zcx6nGcz5PDt5W7ZIPWOQG+djCGeDRjsn
         bUDyd64oUW7duGxaQpGQTiKvYrTFZgPCzH1j9Jx7vJAnbzRHfjliOkOzl/JA91msi3mO
         VETXHeogx2psJeAr9k/vIKmiyKsgG9OWrs4EomEYX5M4TNmxp9dG11yCkG3t0cxD3o00
         w11GmE0qXon6K8p372cztb5VS4LW4AzUtcecZKUqaUC0zvYrlu/DbFy5D5nVCUzv0iiN
         gYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469053; x=1792073853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xn4NE3yaQrjXfCQOoGywwWxzBDjnXzrFJ0pgj+Z4FLs=;
        b=vzsi86gKjGrWOdUQ15RXORMQRkoi+J2pNOZPscHFlF81zy1Txf7qYfLIOFwAdYwQ0W
         XdTX+bHQYtOJQoUfWsSUR388sXivOXwCASief+UMb2ti8QdfUryxrW8pkcM00tE/e1hr
         6oeZSLBfiTUaBKoWvDMwuYAB2QBLj+Q6n891tfiDvTiTyGLOTzCbp0dvWcYbzJJLnHsm
         KSARkSwN1aJowukv6E+Bm1z11tJWTJL0gVoKvoCf9HATdcvtddriJBQpUTMptCgM/K83
         REzIzAgIqnYrjeGimdVA1jWUIBCd4FDI3CQJz+a9YEIHed1XTDQoAbhMiURXHUD42qYG
         IFHA==
X-Gm-Message-State: AFq9FYKsIFeCJKNAomA8+cEPn2lPJ34BCmKvz/0neRE7Y4+Pd43dtx3e
	oikGCWQygchs6yQYTDD/OBPZ1ikUJvV5EMqxnenbZS2zq3sGp3cK/KB4Ya1GjlXy
X-Gm-Gg: AYBFou1+KTTt7ganSzhc59kkBo6fN0FOg2Oy25vF93LD/J+GKM87AYcZtfDf1bTtG4d
	Rn2rsyXAvwSaHjimg2HM6MmKLd3NbUUPzDX3wDqCHQaxQxBMJiUGawuTJILKhOGuyGJeXxbjic6
	Tx5Fmmnc1lwLE4FX5COSIiu/SbhBy1PU1uAM9a31aX3g2Gb3aCKOa7YbnbhBr5l/WDgkrHVvHpE
	x5rq3QwDH1hMtdKS8tIZTUbVcwx1sfbNI6cI7XZGM4KAmVzzc4raqZ7mrPBZlaixt+xZpGhkH72
	i3oPNkj85xSyK47SCot0EYW4nt3cc5jkzJ3MKmU7EBdt8Zmdgub6im9Hj9rURsa84EoE0I0SFL6
	OkjWACQmvG8Ngw2l8dLjNb93e7+GHq2fjecI6hl1uxdYSQV3XnuUtylFNzuzihSKu8A0+9DpWCl
	KaKlolSeq72HzRTF4Cua1WPCDj4ORdtRTzwf2GH13G47oJ3JxR1jYuV4nz3Y9AjLK4abU+E5Y+X
	AqRoAYCCrofgPhp23121CTj86SaWCjLkoEnHu9/7fXJx0jgKxpbWsRGfO3SzOBEsiam2i7KwJzK
	ZYt5wEn3bnOw9bwWt9zFfodhFbeha1csxR9eobvwKFSxkUjQ/+Nn07RKltVNHhIZa6XNNQj6/0x
	cSn7AzU69IZKPaoklY/B1KgYp7m8HYtXz
X-Received: by 2002:a17:90b:4cd0:b0:3a6:fa01:4bad with SMTP id 98e67ed59e1d1-3a8a04d5228mr5283779a91.6.1791469052693;
        Thu, 08 Oct 2026 07:17:32 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a50d32sm4415458a91.2.2026.10.08.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:17:32 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 5.10.y 2/2] tty: port: fix tty_port_tty_vhangup() race
Date: Thu,  8 Oct 2026 22:17:23 +0800
Message-ID: <20261008141723.1183340-2-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100552-unscathed-jailer-aa56@gregkh>
References: <2026100552-unscathed-jailer-aa56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit b48820de8c1a596c5b99775524dfce73c6576c5d ]

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
[ Ting-Han: use mutex_lock()/spin_lock_irqsave() instead of guard(),
  scoped_guard() and the tty_port_tty class, matching the existing code
  in this version of tty_port.c; tty_port_shutdown() has no kernel-doc
  here, so there is none to move ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/tty/tty_port.c | 54 +++++++++++++++++++++++++++++-------------
 include/linux/tty.h    | 14 ++---------
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 599b749729ad..0231b90608f2 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -312,11 +312,12 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
-static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+static void tty_port_shutdown_locked(struct tty_port *port, struct tty_struct *tty)
 {
-	mutex_lock(&port->mutex);
+	lockdep_assert_held(&port->mutex);
+
 	if (port->console)
-		goto out;
+		return;
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, 0);
@@ -330,7 +331,12 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
-out:
+}
+
+static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+{
+	mutex_lock(&port->mutex);
+	tty_port_shutdown_locked(port, tty);
 	mutex_unlock(&port->mutex);
 }
 
@@ -348,6 +354,7 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
+	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
@@ -356,7 +363,8 @@ void tty_port_hangup(struct tty_port *port)
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
-	tty_port_shutdown(port, tty);
+	tty_port_shutdown_locked(port, tty);
+	mutex_unlock(&port->mutex);
 	tty_kref_put(tty);
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->delta_msr_wait);
@@ -364,24 +372,38 @@ void tty_port_hangup(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_hangup);
 
 /**
- * tty_port_tty_hangup - helper to hang up a tty
- *
+ * tty_port_tty_hangup - helper to hang up a tty asynchronously
  * @port: tty port
- * @check_clocal: hang only ttys with CLOCAL unset?
+ * @check_clocal: hang only ttys with %CLOCAL unset?
  */
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty))) {
-		if (async)
-			tty_hangup(tty);
-		else
-			tty_vhangup(tty);
-	}
+	if (tty && (!check_clocal || !C_CLOCAL(tty)))
+		tty_hangup(tty);
 	tty_kref_put(tty);
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
diff --git a/include/linux/tty.h b/include/linux/tty.h
index f6e789c66943..e85296b229a8 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -622,8 +622,8 @@ extern int tty_port_carrier_raised(struct tty_port *port);
 extern void tty_port_raise_dtr_rts(struct tty_port *port);
 extern void tty_port_lower_dtr_rts(struct tty_port *port);
 extern void tty_port_hangup(struct tty_port *port);
-extern void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal,
-				  bool async);
+extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+extern void tty_port_tty_vhangup(struct tty_port *port);
 extern void tty_port_tty_wakeup(struct tty_port *port);
 extern int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
@@ -641,16 +641,6 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
-static inline void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
-{
-	__tty_port_tty_hangup(port, check_clocal, true);
-}
-
-static inline void tty_port_tty_vhangup(struct tty_port *port)
-{
-	__tty_port_tty_hangup(port, false, false);
-}
-
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
-- 
2.43.0

