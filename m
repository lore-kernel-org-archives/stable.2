Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077350;
	b=mHI3WZf56rMqT+cFtgBKYo/ZuKyV8kRcYaDqji2UPoOEj//Olkr5gHxyjdsMKaH8Tu0S
	 FMJ/ltw3918chb11cnwoogrUGHVThYXg+pxw5xH+Uwd+smVwAlhv8M0ZgHzcMAkkC0Ut2
	 CdV4AUSrIi4brNhM4Fs/iFL7yQbDtcVXTVFrdqM40K7OHExLA1NSWQMCbD/MzXRcikRhK
	 hmf1xSfrqpctESulyRbu3c7v7ecbpuTZhPZWVvpoFRL9vpVAl4OaqUXKVI5t77t1bbIbG
	 DDZ+Mo5LP+FYwFGkPi2TUq2xVpqhGCc2pCL7dwVIDNaudOqIN14XML3wJMxbPY1rlKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
	b=ecxQ4YMQRPV4bUr7F7BEX5CIc2G8n8fVIb5FiElnYIS03/TiZJ+DFOoosw2EtnUYf/vN
	 JckQhSkVFzoRF1WOfMNvTGtmN1l0X3WtbUDFjjnijDvp3qvn2k0U/jaswndYTmtBkwgZR
	 RC6Q8QNbjg2aeueij1TW8JqmVCWPpR4hhM5P7UvqmnNC+a5QgjN7ijNnY8KyIMbWchANc
	 Ytpe9XYvXHPKlf9NjAPognHjJyLcrx1e1Purx/Py+oEcL9Zkn7IWpvUvpOTG03Aw2prTd
	 wK8WaWy6QnmioN/iAAIvwZVsR8P2GkYXCBsraGaN2urJz7ZaCDOhjcTSbh05dB5m9KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5XSdy4z;
	arc=none smtp.remote-ip=74.125.82.67
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2E606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E2E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5XSdy4z
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-181516de561so413165c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793077349; x=1793682149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
        b=c5XSdy4ztScAIiHgbPzGCVSJIwwkHGig0lgK23rWrPwg2l/EKPeyBzJ4Gk4qh1LNAI
         MqpDU3M93ZSDM+ZfHyQTNPLIYH7LKE6PTt6HVbeNcuEYx91FkUq3yXneMCsmRLiYZyhk
         COvqB26ApyfjUcwF4LFaatMeEEo8DskjXHgjAbZ1c4pF2HSwBqpsYIherHx/ZA5Qpyto
         59XFgop9BtU2vW5DsMfa4F4kmX/QOuT6surKOluEPqHhb6F7/B/AaksXrGCW/u/Lfzmg
         pONuPLkyFV2rhOkOmDTHeBv1j29LBBawuHyOHuKvN8USegNEiNFStaFRuMu8BYEzFllU
         cipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077349; x=1793682149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
        b=kUBcFOCIlqkZk3s0A2KTLhID8cwrCXOBAlP3urkI7jGSfISuorhxVHbRSOHKEhIef3
         gj3536ROFnWrpuzin/zskRfMhRhR4y/7Xv5ZNJY9pit+LCSwpt5+Rw8PNMhq1i/FKVpC
         x3bKyN+GtSh1TRqkkxSoGVrbSr2Z6RUFNA64768XtntW7G98W5QK0CXTOC6sDFcIqXvN
         P1sz0UmK2neESsloxfnELTHzrPTM3VxJIUaFUv51LB7tyPMwv+Jbjig/sPbcLbcT7RRm
         uriqw9QiLx21JrUabqaoM3JwitJ99VxKypk+xPg3aJRVbGYpxoNRbc+6+aIRsrJzte4X
         Aa3g==
X-Forwarded-Encrypted: i=1; AKwUvBxQN/tikIu/+08KKuS/Nc2srve2AFFpRVzCioTSaWfsBb8Q2mpUxZqfW5f7qIn+OtbAEUCANxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1GX68Rk/u5LzkG+6Xb/oOoxHnI7UIRaCIxcEMnnzW5cQlelXK
	N+fCakIvQ3MUUGC4svFEv4OnvHru1gKUgODKdZ0Pp2R9uRtrYRpPQp1e
X-Gm-Gg: AYBFou2PtJMu6Sb+m5zWGM821BjxYZOex38byHWR27CAzBjYPFzlZCs0IvFbipl0xYr
	F90kyJRsqgbYDSLI8JkFf47sUrPRZMQ7HngqvSW+wRDTsoA5u/k5KJzN06+6Awx52u2GEHO9mAy
	utmrHT41JlClxJxfaSFyhvjc2CyEdJM6MRHPUCCxiq5QOZpIKh3iu77WVrf3pNKLfdGgTcFnwgV
	GTU+RZqdBtJEX52Pqq6V97eYy/yPIBvFBak9Q2vsYiNQyhW260mSzmnBb9LyKrnrplh+v5rkw+j
	z/2XhiFzuvmL20xWIeNeKYW+0cVhmQvW62zEa+eTEZWEbllsVP8wirfC/c4G/bwz+vP8S/sHC77
	f7ZEZODd89GfwbjbHTg4Ly1Sb6gm/gXRgUZl/CeXonHRoXyTxzDkak7xFHD6DAMbuRZ5m9wLNXK
	PRZgPmGsKWVYiTSoQht/Y+AyJWxh14Lv9YR8b+bZJR2MFNhZ4SpWliVX8wPs46ce/NOtuuotgJk
	Qk878lcc4WKtg8Gc35K2moHY19FRgbagLfVTtbX20UMN8MPpEhQOLR+lnfnKaCth12UMQnADZlq
	Uo5ZKlHI9zu0wk2U
X-Received: by 2002:a05:701b:4505:10b0:15b:1959:15e0 with SMTP id a92af1059eb24-1a3c76669abmr2075046c88.4.1793077348863;
        Mon, 26 Oct 2026 22:02:28 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm35374587c88.6.2026.10.26.22.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:02:28 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 13:02:15 +0800
Message-ID: <20261027050215.612762-1-yyaqia@gmail.com>
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

Changes in v3:
- Add cursor_blink_on to struct fbcon_par so a callback that has already
  been dequeued by process_one_work() cannot re-arm the work after
  fbcon_del_cursor_work() has stopped blinking.
- Keep the requeue inside console_lock so the flag check and the requeue
  are atomic with the stop.

Changes in v2:
- Reworked per review (sashiko-AI): do not guess the context with
  in_interrupt()/irqs_disabled().  fbcon_del_cursor_work() is now
  non-synchronizing by default and therefore safe from any context;
  fbcon_del_cursor_work_sync() is added for fbcon_release(), the only
  path that frees @par and needs to drain the work.
- Move the requeue in fb_flashcursor() under console_lock so a running
  callback cannot re-arm the work after the non-synchronizing cancel.

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

