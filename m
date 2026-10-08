Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424B32B130
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469010; cv=none; b=GGLjmsHhBCx+TATuY3fogSJppSXg3qeDq3pYwuRYCuM0mzw/QYIjvcUvFeFZqdgQGMgGKkqFPPvJTwBv4RrabKlU0cSjzj9A/8Cw+mn0XfWq3ygQcCUKFkocPX7Os8ggy/uT4rIMSZQeFy9HzZyg8oHjDnyH3YuoqzmJvCIPuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469010; c=relaxed/simple;
	bh=DywhEtY5HaU4TFl5H59v/l6/P4WOBKD7msZKuT9/zv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWr8emx5h9kk4eAlkdyIdHUZiwmTSWAFPqPqKrl5l2Gfv1TBN20HtBp1eUK49NDSRi2auBKA8MTHzcHr2tDS9Wa9EUnrlKrQJl1/wG6wdwO4VGYwW7Q7T095iZF9CuBuwx1VrBiwjhpGDjgn5hL4bkJCWHIzlROhcbgG6bzi8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbFlO1Pr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbFlO1Pr"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8874539bccbso2691819b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469008; x=1792073808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRAyMnDBOkTdXcCY5hzfFTJQTqpw4b/rMKpxpyy5Aso=;
        b=pbFlO1PrsCrT4e2ypulFixHBhA/x95ww21xFxTGwP9VZncaGBKZ+HAjmTdUoe1pxur
         KqMfEvcMwp4Q9pf0eMFsUNmKPwUls+/4qpMFK3Q2uepZIU1HclbTazOM9vXBhBEr8uqm
         8qA7fyAx6HgogZJ+44McwDpKPTq2ieRJIe5J0XI06y10NW1TH9PPGu9fwazx0G8LYsxE
         3xVH2TjNPxBKp78wPHUJBOcw6ympFaQE0+OwxKTmNZQ9J13trlXOcHDG3qhq1eZTry23
         xWCDhIKhBnNTtqtPiIEg6gYKKMVBkYRYmQP1cY+yd5sTJfEckBB38nOXedqe4jkVAX5x
         sdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469008; x=1792073808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRAyMnDBOkTdXcCY5hzfFTJQTqpw4b/rMKpxpyy5Aso=;
        b=V8wyUJeEf08nBZsxIOKmY5ihn45ekApGDbWNPfQI3vZbYLI4zIumJkltIzYzgDLFz0
         xGng0WEYOnmXmZolLUl0N1wJeJpI0KIZ11DEyHFLMsNu8dL2iI8QcgjICe7oCqi1bXP+
         H60ZbvdMkA6N+hDlQ104jfmsp4A9v3OejEyr65hNyfBDMCNHRODQNKM7EYhN79w4dF/7
         hWfQmnnf68eU8ZBULsmOF1zxLpXle5blB6tFbcCtQFBao7XbzKRbhv5ShG+2Y/e80QqG
         uGCrb7YUukjzWN3BB1b9f/GmTHs+NRz9IVGprq4w/ANqynA6POtv0ZXXifU4ek45VJOp
         U9yA==
X-Gm-Message-State: AFuF++nRfRha8mwHeOuG679OjInWlHupOBIAIUwxF5J0YpEyryQ07bZ3
	Uzx+uMT3BjVIuIZHgHDYOW1zbRUfXRaaZXoN5GSKRsfvxaUNGDtdT/n4zDCDACQL
X-Gm-Gg: AYBFou3jL/OtE2AJdkNnlimeoYjZ9hI+QfysfSoWm7D31WuqyLuj9TGpqg/9GwKwPfq
	Z7rTk2rGa97F1YkjLItUpJD4pVodZ+kg26wIgv8HxPRidvEplbs9kXNvuMLNtShcCxQvy+1UMoH
	JLrc8TVNWQqMlKAqBE4R2OK5ekHWLyHkzmrF6IGTzOWipI978/INeQNS1ReSLKK+bTWEyWEEzEg
	exF1aAwMfxtSS/PTl291HVkYgYm/LNS+Lmu0odTPX+rVJ/EqV48pIoEXTfQcfyraOkNra0YygkH
	l+QCbjA/GF75mjdnxQA185m6auCSbNz5dWp8JOnk3jJMDE1HkH2F54SL2Cn5Y8VVWqc9RpU+0vI
	+AfDxB9T1d/WeDGlZmtvpeoBIUhz5HqvoG6kGMFiO/EyHOF9R/0RT9H2nJap2qONzw7yndMh8oT
	95a0ilQx/ZhzbYRLSrY/jc03soOSi/UY3GPt0Nfx9F7Mkz6z9ezkLtLS1vCwJFmKJNiay85xE1X
	isJcv8MLBv+4whHCFIXe4eMBhIzLEkgesen9i9A2foQkAEP+W9vs4zZ20sxnpZeYSB7VxhtWO8r
	JD89opVpYudcTTIjIYwgLUtveMzoGgKPnAY1ndRAp8JofURsdPU1Gk+lTdrMyyXJ0bC/+42lxBA
	Zqnzjxfm6pdFIVMSKRpTpx9ikl5fqPYiD
X-Received: by 2002:a05:6a00:1784:b0:890:bc70:fcc0 with SMTP id d2e1a72fcca58-891b286d2admr4769685b3a.48.1791469007562;
        Thu, 08 Oct 2026 07:16:47 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb89dfe5sm1697131b3a.46.2026.10.08.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:16:43 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 6.1.y] tty: port: fix tty_port_tty_vhangup() race
Date: Thu,  8 Oct 2026 22:16:27 +0800
Message-ID: <20261008141627.1183294-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100551-skinless-gullible-4ab3@gregkh>
References: <2026100551-skinless-gullible-4ab3@gregkh>
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
index 494500c453cc..b3a92ca77ffe 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -350,21 +350,12 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
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
 		tty_port_set_initialized(port, 0);
@@ -378,7 +369,22 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
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
 
@@ -396,6 +402,7 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
+	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
@@ -404,26 +411,47 @@ void tty_port_hangup(struct tty_port *port)
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
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
index 1ec146b8d0f4..660edf9e741a 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -234,7 +234,8 @@ int tty_port_carrier_raised(struct tty_port *port);
 void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async);
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_vhangup(struct tty_port *port);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
@@ -253,23 +254,4 @@ static inline int tty_port_users(struct tty_port *port)
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

