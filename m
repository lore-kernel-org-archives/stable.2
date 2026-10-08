Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3B443AB6
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467011; cv=none; b=ix5g0mVTAUKvbSLPGIzjuS28GSv6yZI3hF+jg+YQlxGoCYP2F+kGAvZxbSBE77ZheNs9QzVxRQsYaKygAwPSq2Pb/heXH7csPKP7AfRCnS2CCXI61S+NhNmx4slcnw/pV1iD2tVjUCoxCz3IKrQ+eEocvBSHarRZd9Cq0Qg3iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467011; c=relaxed/simple;
	bh=zPUuefb4cZ5vR1dsxbo3O+WBU8+V2y1S4YRCLyHJ3kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsvbJOWTUDWomQdZcEPTjVxcgFlUoYpL5vIwakog4jIhziJduH+PtVuxz2+BKnY5trgqGBeP/vSBsVPRQYDXmM2zN21UKxRE3Yq3dpG1Tcxw9LXLRMt4M2m3V7aqJDIIG2aICcP+hZiYv/IdrGJYQ9HAK7FMC8PJntrUWcZUWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlHS8NH7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlHS8NH7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a6cf104827so1892743a91.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791467010; x=1792071810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7n7ZO26RiSPM0cpSYWJROLBFliGqeGA/szkAs3a7qQ=;
        b=FlHS8NH7JT4Tjy/iYzQk3ZMSmA2G9AtEJkil/MwWXtoVuGFtXZuiEE+euiQewVeve7
         b58IZPiFc99r8sCKhULYviPYtb2eJyA8EH4Xew2bROqZ9e6HKdS0VS85SrRJmDGNp3ce
         u6O3GcxdZxVPUNRDo/SFQ9Z8QS3AkX769T5jgFDwWQkoh3c09Bduz+H1svqRRU4i4x2s
         swq+d5hXABEyYEwEIQmVEgASrRPBiOL/3u9zt57Z/lfnQdcaLynV6Uz/i1EfRwo3VYZA
         n/8/lE/xQEZagq5wLKpfH+CCLeQ6VwHnO83Ls7XbHgm4u+OTeCYPtCO7XkHZhqYKJFWA
         eTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467010; x=1792071810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7n7ZO26RiSPM0cpSYWJROLBFliGqeGA/szkAs3a7qQ=;
        b=JkQzwN300h0NmROM+3vi8Vr2+4cABhMoAvLVsXwIy/1MqXLuwgX+sepzLLgHXlt7/T
         66ZqtOIFqz8aEO7+L2AabUgN+xxVJgt5bqPXD4uqufsKSk/L4EVN50VoS0EvNWH1II91
         JvylpNh2ZdQXo4UqDOxY6ZIEF7wfPvSoFlHBR+dEltoIG97yb7rJk7LP0HgHXrTQBgLl
         CXr3R1Oz4yZXGGt6dl7YWHk6/w+zCBL/pT9SxGBX4XEtiQYLYXZGSLh0vmuR1Szxg0MI
         EpVvmqAcbi2qAdhqfq8t0VF68HCAEoTL6ArqS3WO9g62J1tOHBI8Jgn3CMaycGUwPP+U
         wcxQ==
X-Gm-Message-State: AFq9FYJ2APtxJDE2MSa5pYlTbWJ0+51IuLxQ7bGoPQqblEE45Q++aGkR
	DSeiZ3ALVdeWaROZRGwIyX1zS2giPDsd8Vf3IQ4L8+0uPlI3yCoPebmJ1Bjd2BV0
X-Gm-Gg: AYBFou0WE4728lq8O9nkXouOdjSfzEIygfs3UDv112q+Uu7LauXIGQWUNAQpnAlYu7S
	5KCbTvVS3zWWWcLDStwv0TzCFNhFp5cQ+WLOVTcFz8gANJGSJLXY19XYks5/Feu115uH1O4zDNi
	ibG+PVOOFSpXnwwTVB/lOHCI7rfL9Uzfy65rYWucchfXyfy8QFshj+3KpIy82ZLo0JyvNRrhlPs
	eomy1wlB1M64sRfpRtolQ6JZEzpqPY0i5CmK/31cMN1IByaNBZmZn3e6MLRSPvpqLGhhtm1l7Aj
	tKVEgAE3zCJGzOSF8uipVZiG8NKoXbc/5yhqlkbHznNIFRLa7JDa8VzJpJduEU6+hkfi3gsW/tD
	4pFiox1+4VeBTYdjb1Suc6rvMQeoexYPfeQRC0BeSRRydW54/0kIwmjC3W0Mengdd0Ec4WEZFtO
	8jpci/XX7U8g2n0thvyifi1+di3efBmmKgvOyycLMbsR76I+Re9NJDVjjgoVXAYarDnWT9jVWQj
	QT9euA0Zf2S+SskFRVEZgH4zKTegtw3kaEsxBW2tjXoSwHcoaLuPji2AT1ZPR8NSNTjsuDNALEy
	qz4nDJhWkNl1HDYZBFni1W6svBc/zvU6C05jJkyZ2GqibZgVZUxJl4i+zWjBbeDXf9bDy6WbcBt
	mbKfdx7mEh23fiSGwlndUv9raYUyXTKNGgVZTouqMWteY
X-Received: by 2002:a17:90b:4a8f:b0:3a0:cde8:1dd6 with SMTP id 98e67ed59e1d1-3a89f66d566mr3845405a91.6.1791467009417;
        Thu, 08 Oct 2026 06:43:29 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a5e0eeb6sm4557925a91.2.2026.10.08.06.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:43:28 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 6.6.y] tty: port: fix tty_port_tty_vhangup() race
Date: Thu,  8 Oct 2026 21:43:19 +0800
Message-ID: <20261008134319.1183247-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100550-nest-aviator-8a3f@gregkh>
References: <2026100550-nest-aviator-8a3f@gregkh>
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
  in this version of tty_port.c ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/tty/tty_port.c   | 74 +++++++++++++++++++++++++++-------------
 include/linux/tty_port.h | 22 ++----------
 2 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 21430e64b412..2ffe11ac184f 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -348,21 +348,12 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
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
-	mutex_lock(&port->mutex);
+	lockdep_assert_held(&port->mutex);
+
 	if (port->console)
-		goto out;
+		return;
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, false);
@@ -376,7 +367,22 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
-out:
+}
+
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
+	mutex_lock(&port->mutex);
+	tty_port_shutdown_locked(port, tty);
 	mutex_unlock(&port->mutex);
 }
 
@@ -394,6 +400,7 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
+	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
@@ -402,26 +409,47 @@ void tty_port_hangup(struct tty_port *port)
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, false);
-	tty_port_shutdown(port, tty);
+	tty_port_shutdown_locked(port, tty);
+	mutex_unlock(&port->mutex);
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
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 0b97e562894b..6db28a4ec453 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -235,7 +235,8 @@ bool tty_port_carrier_raised(struct tty_port *port);
 void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async);
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_vhangup(struct tty_port *port);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
@@ -254,23 +255,4 @@ static inline int tty_port_users(struct tty_port *port)
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
 #endif
-- 
2.43.0

