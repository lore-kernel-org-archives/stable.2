Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072850;
	b=pZOHUJ7UKJKYbvIdcNWjts7VBI4sOkFa9I8yBuTiVuKFoYJW8k4d47wbaskFG4o/0j0z
	 oweYskgi+JYJC/o10aI6pXmQRqh6eHvt6xQqI0lI44752c1iOUQkU2FZwiUhG4xFVwdIy
	 NKacZYJnl3pLXcHzZTXULP1SfTYLbCKJtgspTqd9wOOaMQi9xcZlzhVtgQMPEsQuHHfhy
	 x4h5EkXJzunRuAZC9JZ196VhftY9ERkEjIkPGaGJdV14aZgugwCTuFXE+JH/LIWJMQk+u
	 Hkm37tSoe668rfcRWPX21avt3FwXfewbcmc459T6YSAWIvI326nJ6XPbVlfC6iWQGPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
	b=uk/abbYPyiStAvwquUFAGXAZA4uBQOGEOVOI+1xYa99WP2cO0+EkKCV9alL4AwJI+nHD
	 K/jjaebxxLTToAcVrMynuNpb/E0wF6gXoqneuqT7LJ/bUnVVVG8V0KYvbdbnZCC2Jt1OG
	 rLYiqHR5Iw/LcYVk1Cc+i9Tx6qX204LAsndNBtnl6x91wGE3zOc2XBHx90wNOrO2PBCjz
	 4QQsyaTnC7SScVjXdvJFvb1uETkzfYSATG7z0mb2yeFgr7C46PTq57S9F/tRmYNcG1Foa
	 aVlN+C/XCMS/wfRXATTqzfKtMbV04sVKkISUtoBKKExjjmV0q9hcOo8vL0oOMVi9hCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e983Zow8;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4A606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e983Zow8
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so778570eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072848; x=1793677648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
        b=e983Zow8bqjcKnPpbeo0bbx7KS7wIeUh39gAOhDmf2Re+Zkktq3fgnJC41tfL3GREe
         5c6sMBCH2D4WNBCK52FND3Xet7GOvnwn13zfbYx7WoOVAzxFGimRlBBT7Y07ZzNEEktP
         7WXk+Yi/UJL42KfR3Di5c6WFqo5Tvb/ND7+pWcYoSSHGN6Xhi6Bl7CypCbWewPd3QNUT
         k5mohsSecJcBa+nCksrsh0AVnrGG/oWPJl9JesGIU1/9WNuYcQbYO1xjz+ZNXnwBd8tf
         JdeFa+FyY3QE6XfKiASyPEKdUp1zMj78IG9LZPrLQSMz0xSnnywEzz5NhGHDOWOQTzl3
         OHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072848; x=1793677648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
        b=05VoHNkrDySGDzGBu4TmwAYvYq5QD1h/i07bcK16kLV/hHPiIaodXMWp/nTNRPIZ4+
         v8suYeYHMjaBANer3M/l9b/WBq555kgvUVNl3zx4Z8yhJtf0m1WSFOGlTxXGH1zDbXLS
         t0h+sK8OVQ+Buh0Lp1zPwUOJ1vhudXcdXFmpHHuF1TV+hYZ+E/tLE/BN9TjHTi8sTGz4
         4EsgQ2dj2tj4RAxK2vSP1MISe8GVxv5WBfyL0lCi1SBI6U00V3GH9sHmh+fk4KkuGiyZ
         GtGsUvM6m5dfC7ctgOXxLW9WmmChY5wr3qq1ijARyc2JkAHhqlnsryuxrBNkfGwIJwAt
         6FjA==
X-Forwarded-Encrypted: i=1; AKwUvBw5d5K9kf4nE4tVP66B/wxuQ+n0LPA/ho9jw9bapJ/K5OY9tOSwbIevzZocRB7yfIYQQ4RIHuY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8fquYP0LNfuoBeMzLKfXCtygKd8QIFkHrr/GVbyb32XB9J4RG
	A368YfNcDPH8+X1OpOfCwxlW2puhFKry9zuseg58MhJCcuFZ0VThOl+R
X-Gm-Gg: AYBFou0BMGmv0KOjnZLUYFLpVt1aB+o6ZlJ18CoS6C2uCq+aoycmNbE1Hu4cE6Xf+SG
	kmdPnqsiKRyJ8JPBoFNxADrCh1HKNezx2GA+4EkKZ3peZfWBU33z+jD7YnxWNZJMWpKMCWsaejC
	XJ8UD1jz7xlYAWc7Pyx2nDj6On4wmOZTnEWjpjMp+yA5lpEX/ZJ8f7/Bf3tGvGwCn2kdZyDREwC
	gr54jQ6PdOBF45WNL7MEctY/a//vOFobeQtVDzfeGxpvWwTvx+HlGNIv6M/BTOkMaFUjOF+05jz
	lG3Mjqj5tLEU6arriLQp7lkNjyAGyYVzXpifJYVjuonO4C5SzRDOAyQgdE5RDOGlIbcPRxuVQ5C
	gd+3yuaslfyCLSSLrDOgZdRR8HJZsUnhWPIpq27Gexl1+2yqlNXzbAip4TZwMVeHRvyaZyubaOn
	ol/q++kNmCqzlPHHYiUJSLHm0lFcKPhRYbgcNf54/gtGFjQLs5rqes+9KiPTxEKmvKvlCAssexR
	D/PBM00PcPCZCVMrYDSaDZGiGpE4H3WXwC+jvDFuimFb/7noUtC0URjDTOjZnH4cjOlsvADE3I0
	7Asr3MiwKfjPvKjt
X-Received: by 2002:a05:7301:7d01:b0:366:c497:610c with SMTP id 5a478bee46e88-369e8610133mr11168504eec.33.1793072847986;
        Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a026e04a0sm11349777eec.1.2026.10.26.20.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 11:47:16 +0800
Message-ID: <20261027034716.588174-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_cursor() can be reached from the console printing path, which runs
in atomic context. When the VT software cursor is enabled
(vc_cursor_type & CUR_SW), it calls fbcon_del_cursor_work(), which uses
cancel_delayed_work_sync() and therefore may sleep.

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, the following is reported:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4722
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0
  ...
  __cancel_work_sync
  fbcon_del_cursor_work
  fbcon_cursor
  hide_cursor
  vt_console_print
  console_unlock
  ...

Make the default helper safe: fbcon_del_cursor_work() only stops
blinking, using cancel_delayed_work(), which is allowed in any context.
Every "stop blinking" call site keeps using it, including fbcon_cursor().
Only fbcon_release(), which is about to free @par and must ensure that no
callback is still using it, calls the separate
fbcon_del_cursor_work_sync(). New call sites therefore get the safe
variant by default.

cancel_delayed_work() does not wait for a running callback, and
fb_flashcursor() re-arms itself, so also move the requeue into the
console_lock section. fbcon_del_cursor_work() callers hold
console_lock, which serializes them with the requeue and keeps the
non-synchronizing cancel effective.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Sorry for the last email, I forgot to write changelog. This email has no
code modification, it just adds the changelog.

Changes in v2:
- Reworked per review (sashiko-AI): do not guess the context with
  in_interrupt()/irqs_disabled().  fbcon_del_cursor_work() is now
  non-synchronizing by default and therefore safe from any context;
  fbcon_del_cursor_work_sync() is added for fbcon_release(), the only
  path that frees @par and needs to drain the work.
- Move the requeue in fb_flashcursor() under console_lock so a running
  callback cannot re-arm the work after the non-synchronizing cancel.

 drivers/video/fbdev/core/fbcon.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..917ce9d641a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -422,10 +422,14 @@ static void fb_flashcursor(struct work_struct *work)
 	par->bitops->cursor(vc, info, enable,
 			    get_fg_color(vc, info, c),
 			    get_bg_color(vc, info, c));
-	console_unlock();
 
+	/*
+	 * Re-arm under console_lock so that a concurrent
+	 * fbcon_del_cursor_work() cannot race with this requeue.
+	 */
 	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
 			   par->cur_blink_jiffies);
+	console_unlock();
 }
 
 static void fbcon_add_cursor_work(struct fb_info *info)
@@ -437,10 +441,30 @@ static void fbcon_add_cursor_work(struct fb_info *info)
 				   par->cur_blink_jiffies);
 }
 
+/*
+ * Stop the cursor blink.
+ *
+ * Does not wait for a callback that is already running, so it is safe to
+ * call from any context.
+ *
+ * console_lock serializes this with the requeue in fb_flashcursor();
+ * otherwise a running callback could re-arm the work.
+ */
 static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
+	cancel_delayed_work(&par->cursor_work);
+}
+
+/*
+ * Stop the cursor blink and wait for a running callback to finish before
+ * @par is freed.  May sleep, only for teardown paths.
+ */
+static void fbcon_del_cursor_work_sync(struct fb_info *info)
+{
+	struct fbcon_par *par = info->fbcon_par;
+
 	cancel_delayed_work_sync(&par->cursor_work);
 }
 
@@ -765,7 +789,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
-- 
2.56.0

