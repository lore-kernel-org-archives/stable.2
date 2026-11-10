Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319253;
	b=U1ncgFaGTBduLHpqrDyYFnStVGoO2DRMunu4z+qGvC+W7JK+VsJHeF7U3NhdXuAzmEbG
	 LkaiUsOq6VRExtrro66Uuulpb08qkNQh/BEM0lIRtb0z9Cf3pVxGe/iEgG14bscM9L13G
	 1k4ktaAlVufjYWv6rSjnpsVGGuAUsdoYaKhg44u+/Um6MObV/6v41VzNWXcTNtwS+vyaP
	 CJimV3v0G49K/yYXGwlPRDtiRiMNg580+VzA/R6BfT3GaQRSZ/db8ZShsZIpj1DOKCaPx
	 sQ1zLE2k0RRaCwvyj7tcPmycRH0m82hS1aWREvDaGAUvENO6tOFoSe/icgJ7/EzWl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
	b=hG0r6s3WYO1KHasY2s2w+GeG60J3HwvBiDMM0ISREKZsHqgYVaGDxeHzWJ3N2PCpyE06
	 oU311guPHIrd9O2CgMLwh+8NAz3yVjbWJsTN16d4Ww1nyPKL8z4c535dBxwM6IHlrJyD3
	 6paY1XOnEF9hFD9kpKub8x8ldJEUg7YV3cblPcmASo//H/OK32B6CR4D33iUYLK7ss76g
	 ftEPSGf2b/f8PGHys/uiLNATCufQkPBdrCXlbemqZBsm/YSMqOxl0T0JrX+36Kww3mozE
	 /JqMYPsOEzLqAJUtbHlIKz8fBWfFQ7Tp9GiGNDIgDeDpgi4Kr5leknKqh0SKBt1y9lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RnMLGhBj;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C40606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C40606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RnMLGhBj
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so706994c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794319252; x=1794924052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
        b=RnMLGhBjuhZFM6YZcEhT7gshDGngPZEtr95ajejwaPDX8AwjmBLL0BQxg/VUCMPZ4t
         HYuaJBJjm8cAyVTajAP0vgUS3Z0Nbxi9GExlPgpVA2NAYaW8ol5pmoe8sCZojc+9mqaj
         yzVpyX+G6qXsTMNkEtZBFw8Mqjra0Tnv/pASFPka2STtRsz4gdh4s8izbdIw+zRHHppB
         L+tCKdToXQbjMhMDTGmSxGbnyoAABYPvUKfZy4CqYtvU5h224YG0IF2QOBGJMm84uuDz
         tOAzQ6DiKEQoBfrUg9aEjh9nklrYM1cWk03gpEmehHCjbhPyaTVqyEM7puyCxjTk2/7e
         T7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319252; x=1794924052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
        b=P0MspApgmcTtgWBTCEEtvHfoLrCB9t+5q7Ws8+U0Ucw3wH35ndWFZ3PXFD4gT64fig
         fH20a9mBeBacNNw9nq85Eni7KxQDA692LOs0cFiDeTrGaf4eN1xNOlY7ZImv2jAYnO5W
         dhiESCfjEVPZnTnoFmKkoi2/pQco/JD3DEfRflKKpB2yAkzGQ51TIChCsB/VJIpT0Ltj
         6+TCnDJUOoSEIM5AJFPf4Oa+pbzK6g25MC68fmVjiiq4W+ac/SP3DcyB3z8e2WiYVIWK
         8hy43Bcd3InpNygcfBOqumHmTz4zdsySHrq+sircY2QJ0wY46MCIenx9jgXNbpLkq51c
         CJpQ==
X-Forwarded-Encrypted: i=1; AL+hErHyp2h9uUqROOVtAvF50skcuRtuVrVG+ypd974w+TGs9F/9WvHuJ7Y452X5dPIW4olCGpvXJJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z97OHKpY8wbM6J1y8/b/XA53gidKBarx7leUUVmgY9hDuRd8XAF
	eJDoL2q/g2D+c8swqFw6MXajEow5QLy0TgMIemNNhtwpsy4+gEVAjhYc
X-Gm-Gg: AYBFou3SQEXCygqjdl9yluTrO10Q6A4DllLhV0fpBpaX+l7btPHhhD5hApKoDC37PxW
	QMWFBXoCVB4VCvGxn193Ay5wdEH6EqWqo6GSkbmQ7kOhMQ8iDAt/hWMLduYhYeFmM9KnCSMF911
	zXg7mdGXRcIJJZgxH8WpeSW9okR0kMsod6cYqHOTY5m8jvlvCZdC9zTf28gPdHkBz3X1hbO+gH5
	TPSDdjFCxtstQ64013fnTQNEt60DTXLzpyWEAHazwXDAq9ntcH6W1bZjK0W/lp2wukXrTvm5XF1
	I/AlnMtf7AxjORSCjidkqWYr03u8h3plagAVpgr/FqgW0esBYCS22kwWT5/DmpO+0FwsckF1oRR
	mrWoSdZia8EsCKwMiOUhYNRmC2hOaygjwBwh+dbynWr389j7PR8JFeUzfDTI9E+l2lSn1fmvseh
	tpu1jBey5wU1l2ytQ8ktkVuN66kHc6ndBqJoacFtBELbpIukKxOGjfrRtlCCc02xj6MHs5M7wRJ
	2vEvx+T8Iuwc7woVeYsWIPO/uWaG/OzzWTUjeHEvpBULFTRFzqXrbWUFqlBGUHJUkX6qz8kJR84
	xWZ2nkQEfMDvNP+cpD8TghIdlnUM6TjXK3oP3lFaBA==
X-Received: by 2002:a05:701b:455a:10b0:1a3:dfb6:e593 with SMTP id a92af1059eb24-1b3b6185203mr3440708c88.27.1794319251406;
        Tue, 10 Nov 2026 06:00:51 -0800 (PST)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b85d22sm7594328c88.19.2026.11.10.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:00:51 -0800 (PST)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: javierm@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Yiqi <yaoyiqi3@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH V3 RESEND] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 10 Nov 2026 21:59:59 +0800
Message-ID: <20261110135959.232798-1-yyaqia@gmail.com>
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

cancel_delayed_work() does not wait for a callback that is already
running. Since fb_flashcursor() re-arms itself, a callback that has
already been dequeued by process_one_work() can queue the work again
after fbcon_del_cursor_work() returns. Add a cursor_blink_on flag to
struct fbcon_par: fbcon_add_cursor_work() sets it, fbcon_del_cursor_work()
clears it, and fb_flashcursor() checks it after taking console_lock and
returns without drawing or re-arming once blinking has been stopped.
Keep the requeue inside the console_lock section so that the flag check
and the requeue are not split by a concurrent stop.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 41 +++++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbcon.h |  1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..0847dcf18416 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -410,7 +410,8 @@ static void fb_flashcursor(struct work_struct *work)
 	if (par->currcon != -1)
 		vc = vc_cons[par->currcon].d;
 
-	if (!vc || !con_is_visible(vc) ||
+	if (!par->cursor_blink_on ||
+	    !vc || !con_is_visible(vc) ||
 	    fbcon_info_from_console(vc->vc_num) != info ||
 	    vc->vc_deccm != 1) {
 		console_unlock();
@@ -422,25 +423,53 @@ static void fb_flashcursor(struct work_struct *work)
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
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (fbcon_cursor_blink)
-		queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
-				   par->cur_blink_jiffies);
+	if (!fbcon_cursor_blink)
+		return;
+
+	par->cursor_blink_on = true;
+	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
+			   par->cur_blink_jiffies);
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
 
+	par->cursor_blink_on = false;
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
 
@@ -765,7 +794,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index d93a89877d04..6a2f7f6e5a8c 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -97,6 +97,7 @@ struct fbcon_par {
 	int    blank_state;
 	int    graphics;
 	bool   initialized;
+	bool   cursor_blink_on;
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-- 
2.56.0

