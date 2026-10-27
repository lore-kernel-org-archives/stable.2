Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093623;
	b=x3YfLws6zOgCC9Q+JOr3Ag+iIdusHeUiYPqEdjIbKTukn6Y0p3x33OjisG8ubRY8YRpQ
	 YqbvigprLa6DxGbNGLUGBU3ZCuDtBGv9oXe9Zxsyl3E4oIL5W1R0vpFpPcyV/CiG24Fq5
	 1bLYhgmt2GjsmjzOCnYjDuNdFNJf0xYNk/lYBPxMp8vcCKOG8UQMcz+KS7RH5TjxROMN1
	 AY39OGdnviPnTd3iADlnL0nuzqcEn55Xvsl8rRXDCI5J2s5iL/Owukfs9Fj6pvVFY4ZGd
	 QG3EAcbl8vaqpmB9LgVSoFFZHdUozKTyy/iVCUpGs+5HEITn6sfW3nDmemOIBpLBgIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
	b=bcwdFXsR5JX9Y1BBAwj2RSho2Am6JpmdtQZb7OMg03BuDM5AdEQHMSdw6TEFuKxpqC6B
	 cpyAhXgWm0jlSgyuf0CjxvdstyuUhxW8YWVvsJrJXQ7pI2eSHgOHFBEqH0CSlJ3ddG6ep
	 x6SLnKZ8bfA4zxeCYVjvvCL7epVzq40FaE/SDZDHv3YXsVb2ew4Ezdm6nAk1DJ+6H9Ra3
	 29ha6alKEX6Wm9JvFegv1ULXUDTr0CBHuH970B7R6aAjFH7O3vyE+jv4DaJsqz1atWduu
	 B1lX/vCfc+kUMEMB+TejMoIOkgn2TOC+lNcxDwv0UZker/uWk5Uk0gzAOkjdhqkJj4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgaFe0gY;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1A606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgaFe0gY
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so3699250eec.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793093622; x=1793698422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
        b=pgaFe0gYSgrRysJ+7VBJxBGET+E93uXuTcDneCjw9DjHOV5LTo+XL0Yo28sKC+aQp3
         MUUyJTpGaWf7HLwWTD0SIcRxnNFYcQIIQfdtVn8iSSDopBdDd+seQOxJTE+EIfzTTtt9
         ehPxEEU47Jitbe8fAxcHEsN374Q0ySdymD1LHHmBtU9S9a8hc7bxqt0UsdfJpdqRqT6v
         c1bn2Mv6Nac7vzoNQGP20Zpi18zC94U9MoIWWRZu+qHmtJnM77GiNt4amyAAkS9edbUE
         uXiDD3+DJueossRq5ueCi+zWBvCjJ8YcqQI8F1wsnL7MhiZU4y7mwutLE9OWCsfceu9J
         tx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093622; x=1793698422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
        b=a8tE5LarfyLmejAEC0foW3vFw4SIuxZg1qpPfxOUrxmRSFWoHIzirMw49V1TcwxH6K
         Rkz2PRqaf0Unpf4gpacJEO80ONlz3isHCdEE/s+/gu+XRVR0nUsgvVVt8nTWeFjfKybT
         vTQqChho9+yR5aNXIV0UJ2/pypaPH1T+w9x/CDeHDQszIRZKUNQeLuLjoRPIDHF4PifV
         wUBvS/XEU1UdqQCjNtxqtlNat+InHbXIOU7rZF6Y2qzEET8U4RHKOVEY8KKIMfJlw2JA
         NRsKjyTFN9u4rn1Y5yW/GsZvfG8mSAvXZKQk41aiL1/ehaHiV94OY8Y0TUFUDQE1gVeU
         AMzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMZW+qQOshL05wEe01K44MzL6rHj6Xm1cYYdH9B94PW2gMD1n3+Mpqhrmi5hVAVJiiMnK1pkU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDluR+sZ/geQXu8ZNMzkJYbPcQad6Aq7isxlsK+S8EqAVo98mt
	Yjh/GW+VZugvtNflpcVe8ZHZNAC5796zEsTJ3b9/ZLkHz8ekYDLA0u95
X-Gm-Gg: AYBFou0cHyb0ur33mrkxS5FYQD41l+85ahocHk5MOFnlQIKeVSt+O8l7sWVqHZjMfPn
	7LP49GcHktK8jKjz3YER2oHZu6eQ4yij7pDRw81fZdyRKy9gDefh+jT3PR0xy7MN7bhPFeUFv0Z
	gMmUZ6+VevZFZmmXM++I4IOhlA/i6lfhdKqCA/N4tTv/SGlD3EKVg4BIVuzRY5Um94obZmOvNGf
	RhBlMOORtNvLuTDhQzQBWDit/drrFtgp5K6ETgigUfQG5KJzuB7o4P/86IxcGGHCdh77DjRRE24
	AKzShLuRi0seYvHmW17ttd+8RJl0V7kEbiMR4LqXAhThCoGqO3JI0qDxVh2lh+y5z8vx568CLKq
	bpAp4Ul1vB/JKSaxdSZeLcka0yKt5gg4c+Ekx6Wmghiv4AzUpB+dt51yyrLG280qpUjzT7ESkGQ
	U4Qva1ZnW8rkUUGrrqKRF67KWCNKc7MRLr5LAkz9KCBYXSDnHRMfgkwTf8udEbacWO4ji5CbZQU
	A5BF8SiJppIQEv3Dv5i7px16qxe5fOF7CYHFqwfosph224HJECCHTm5Y7a0IOdtyCPCJcNgrpGF
	lkMmGV7N5Jtgxib8
X-Received: by 2002:a05:693c:838b:10b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-369fbc18dc1mr9426970eec.8.1793093621340;
        Tue, 27 Oct 2026 02:33:41 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm39259524eec.21.2026.10.27.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:33:40 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: 1210364094@qq.com
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 17:33:35 +0800
Message-ID: <20261027093335.688287-1-yyaqia@gmail.com>
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

