Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427A27E1DC
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469026; cv=none; b=cNw7qfY13cNRzp1GbWqC0UIxPSAIUYCOUfQ9fsx+lWzgXixJSE7KAVsckxXe0/mMBGPE5RRmN3BPqGCrdIixM9H1LMNETobZmzOBu3FWAEUj3oztff+XAXz5rx5wsVrQ4OtSC4OSSSIK+Ze72sDQsb2m7PlsTtyLiSpmihuFB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469026; c=relaxed/simple;
	bh=WUt2oZIkQTSP7ayz0vLMSQfqstktHKpA2ZqO+0LakjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ+IgNrr0eAcQ7R+DzHiXnr+JJbLqT4qwx3hyUbCgy0HJdHHVaDs0SH6dkvuCfiYdTvhVRWLJ8j05JuZeI+Egf9mQChCvQNCBmX7T2PYld74B6lrE3scZwI6zNXJIZVO53s+GUZSDBwJ58LHCZM3Vq7wAIRGCiQrrtW79d7cAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxv9Tt8i; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxv9Tt8i"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso2302888a12.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469024; x=1792073824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBFPMkpAcKiQnWC9BPuwHEoionUnMJC4DycGHVY7oCw=;
        b=bxv9Tt8iBWDb2BGK/EU3ML/BcKOhl/6FarH+rInwVvS/6PuHcPVYW7YcKkOaFvNw1H
         3JxVgzc93ltVPZeZfPFLciTnJkdWIASlaTp/6HCmDRQtYi74oSvfiCAY7hX3Sdeofha6
         D6IplCWSrKFNMfgjvRO05P/KbDpNY+pU+eSv8rs4/DEKGQ2EnxCtLRuIa1Z90PjBcSXU
         dId6Ag721ZmghhlF/xGKkWQfeuoK4FEIPd2ypShZCzUJ2OQz4dQvMLOgs6Kn7lQBMmyM
         dI9GKQ0J1xC8O3I6YBlxxLueEwv4kdVqAdxRJoWNqy863P02ZI/1Qs/jd1ReEcvc51sK
         EG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469024; x=1792073824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBFPMkpAcKiQnWC9BPuwHEoionUnMJC4DycGHVY7oCw=;
        b=g+WZfaBunMXqGn3beHBAL+zsyB9jIHBPDC2zm1Gy7gR2ND6Pucr+Gr5rD4VXiO/9jD
         2bLc9n0VRk1B1RDrOVT83lZaFP1HXFzjQgyrryK4D6ZzZ0Xa52U7cMFHWQY1lzICwYnz
         63ZhzKc5ztKrzPMqUSHvZHFMvxNTAJTNuzkZhH6l/1Q7tCOuv+M+9UXAQcbpHCX+bCbB
         RLnuYYFZiuKZCixydlytKX/b0oK9hJA9q6XLWIWc18T4lnu8tite3cmnR8k6kUcQvmkI
         R1rlE0414MsmPJa12U+nxfpGYRP0Ku0ECNJ/dME0wPMq5GGIww+udcGZlP963X9EpSQ0
         ohAQ==
X-Gm-Message-State: AFq9FYLQ+UIXwAiPZqYbYC3TwtiDVQgP70ixRgs9Intv28Cw9SKsKzvP
	7KVc4OtfCIgBoIL5TuOutrc/5FJuFsvQQFaUMesAyIK+G4GIQ4YXowDSzqNhquwb
X-Gm-Gg: AYBFou3XCvDYdqwzAnv0123+MzvY3nEg0X2fRSGQNKNKEHfu7CvdvAvDsabizM79ljR
	hO0miO5L4hjnvKJVSIBP+p1nZL+pOlmG8h0HK2IpS9qk6wvKupvZJhrfTQHZ0ZCTldV1501rfmb
	zNqc26tI2vqHniZCvQfsHx2Vb0zUnoIhRH97ahXpTocSCxkyjT0ip9v3aYbqCGhENqHlthuIlOb
	uGIc6uoz+0ANV9y4aI0K0MifLAfM2h51nBoDp+z9tkEqWNB550+RopcA0KwBPbe7IKCUswOTCIv
	qcnmmXLkET2xcBGcxI3S7SNW3fnm1YAexlWGO4nEUsQGiL/pVsxJo3nLoaJR5ci1SuKAPWuiQ1f
	NzItUuYj7iILMbve522/koPwbNbhkwf1WEDlj4VRCLQb0oWYpFfpUFOrDX8Vyx0a6AjEEA26sVw
	FWzCN/A7Ri7TtwVe6k/r9p+DeuA/RM1yzvqKyLm9Uj7k3CrogaZQyedJgELkeLNK46GXrTEbNf5
	OL2mlbg+IFMynGmonsPQO35rdstoh3qxO5cuKPBMR3X0+5gaQFJyHSH+sqHPfYC8CmsVi2mqpOX
	0CGUbccsAJhhjaOGGPAWDr6TBlVNX4A6fbglInEpprkHrvLu1eFKso5lPcoHPU3uTRZ6BBBZ4vO
	GngkObpdRWwCCh1q4Zb5yKeU8q1VX5Nih
X-Received: by 2002:a17:90b:4b0b:b0:3a4:9a7a:360 with SMTP id 98e67ed59e1d1-3a8a1ac8bbamr4941670a91.29.1791469023689;
        Thu, 08 Oct 2026 07:17:03 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3760777a91.2.2026.10.08.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:17:03 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 5.15.y 2/2] tty: port: fix tty_port_tty_vhangup() race
Date: Thu,  8 Oct 2026 22:16:49 +0800
Message-ID: <20261008141649.1183309-2-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100552-dumpster-splashed-bbd3@gregkh>
References: <2026100552-dumpster-splashed-bbd3@gregkh>
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
 drivers/tty/tty_port.c   | 54 ++++++++++++++++++++++++++++------------
 include/linux/tty_port.h | 13 ++--------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 58d2962bc411..d0fe98f786f3 100644
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
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 03d889398c5e..7b0a1c360ff4 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -186,7 +186,8 @@ int tty_port_carrier_raised(struct tty_port *port);
 void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
-void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async);
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_vhangup(struct tty_port *port);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
@@ -205,14 +206,4 @@ static inline int tty_port_users(struct tty_port *port)
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
 #endif
-- 
2.43.0

