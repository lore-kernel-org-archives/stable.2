Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072075;
	b=XJvgZzYimeZnoL8TRpdrLJo7skAc+HJ+YzcfjneJlc+B2XheOxUwSwN2diPPvNX098zo
	 BxoJvz3HHMUbPxSFR4raGEJaWYtfyzjli6M/d8wXtJiVnTfv5c9xeQ14p52NwLFI6Rxzj
	 5Ou5dbRh3zI9cyNEzxXbEVksNTbCc4AUG3vXmMbNpvmUUv8UW2XQDIhBWSsUYAkzTWm6U
	 P7qnBKB8N+tMT/x0xfxzwYoxTgR+16fKZcD99fNrJvisraSs2+LVRFPXc/j3QtyNlnhGW
	 CzVfizPwF3jSFGaMHmB/YnvcEUrcGFOAcbf38uzeJcOqwF20k593OA/xzg6RV+NmHjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
	b=CtGtcWyONweHZuUA92UFSlrhIVbjqZ/luingU3r7UBarsYKLqWQbP90nFu1rkt3ERJVe
	 w8YZnSJFmMu+W5a6zcn4jHkSJB3GG1T1hFVi444upLXB6JfGBdfA4Qg6QADtmnYQdPwdE
	 q3rHzEYXnGVCCUUEdWTPNyJngyf1C6q+5DWTUsBgdGrXnw1SxF3bRdsC/2nMJh8D41/g8
	 B61weQCNvnk0sBu92oTznxE0gkLQfXldhmurLd5S1Bb94Gjgukz5bqRyzK5YcJqz95/mT
	 Aa/mEdVeBtuZd5fQq4bHbb6E0r9kE70ixC3JzgGQPd+3Oxs823x0ogARxCSD/dTw3Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psEq8aAO;
	arc=none smtp.remote-ip=74.125.229.139
Received: from mail-dl2-f11.google.com (mail-dl2-f11.google.com [74.125.229.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBB606A32A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEBB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psEq8aAO
Received: by mail-dl2-f11.google.com with SMTP id a92af1059eb24-149f2b3f25dso1068366c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072074; x=1793676874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
        b=psEq8aAOyXfGJ0hGmlqCLt55ggfY7SQsTu1QJ97BBrttIeuh7p1PR5bfeHqTeZTPMZ
         aserXw0meG33UyK7L2eAoWV/Okiw/W6S+qckn+RAG0vN6v7636xT/TjzcjOvBNDTFaJ3
         jb05W7VBzaqKzMeCMiGfRBfFAI1QZILSiQgc4xKZQHedeqnNH77qbnGuQPRuIGLkMC4G
         LX4/STPhgraMIGbaPrLoVOEEz3p16K93wtfqeY1Vb1TFQytDbmA7hlOX5IjFU+Dsos3/
         VWecE1TRrA4JyZfftdljCO0UGGdd1Sj5CQFiYEWazJfUyO3XW0NUhNC2ue++kXSn4civ
         nuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072074; x=1793676874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
        b=QV+6rS1tcXzfqmNA77VPiXh1IIAjgHSrPp7EePAaFq9HVJ7SUIk7cnlwwYLAIg+Hm2
         VDwHHmDJUZcZDjzlOXH8qoLw7xEch8xgIvPjZjh887I2xjCJl6uUiBx83E9Yl87UIF08
         d5f2RJCfGT8ovSXp6Sm4CF5RjkK9yJMMnBsohiuBK8VuGSdJ3b7sVzvyUiBfMdlYlJ+J
         s/Z5fFAkPLM7T3ug7OQGcYia8uEgDuQp28eV17ons2q75HGNGgVBACSwa/4FL5KHsxHU
         PpgHN4+zh3BzYPwId91x2qD3VGHW8oQnPG2T/IgqIo1Fp6Vf+ugDPeAELPfsVSu7eH0j
         78UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIOVUclintFSWOIYUdX5BayZ1zrRY7Ot/lz2vorQz/fxYxLo8p49VbRPKmrxy6QKTkbNHJwGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYISrUoVpKP/gu8paIOIE+l/UCDuOFR5jc0aAxDhFnhEinULAsYP
	KczaHOy4U1ScJEESzCO7jbQPm42UcDQjJmyrGHslCANJiLfaHFf2BIGg
X-Gm-Gg: AYBFou2X06npGqhfq5C2/S9Q+eEvlYgiPd9tKoDlSaujNc692YhPZrgUqxjmcqtNkJ3
	TX1RZ1TZAlu4VcrT7Suun2lHf/qrEcvrhEyg0E/Uv33nBCMGQEuJ33aym6aV0TDvqbYnW2Btifx
	dV+tBPXXlcLgS8wt5VgSTuW7T+4PGHENSibFINwPYXaKm5cJYttR2qltN6YUFj0WIeR44vMjzWn
	W/ogZgnMW2HXgECVrhTfkzqotimDEZLwihqiA3od3FwgTU9eLVTsuqgbxBPljB9/DbUythsxYdW
	pI/2DOfTrMfaLzwuCqu8jm8Gi6YKaPhyLRqf47rmGgQTJSvNL9W1/lT4LF+TG9Djmiruj5dN3mq
	4NJHIb1WoJJV4ab1kjXoSVe54v0xuG9Evx+AM+JE6gk4VegSqgJnI2btQ9UbwW+v7o+/6k9VaTm
	tgckZuBkJ840Ik3PXZV59lFXdKY3aRZcjJUDG+dGWeNlcrUZKyc6kHrZa8sLmLZswPwmic4gF+6
	p/nyOH3gY/G2dWPVCvbXdUUzZrvnBhtloN16gqrs/eWPJNX5uwfbP1gV1Vu9EGxVTp7iEYNFdyM
	hI09JjVpa0b+ZVVcDkReIphHYgkG9kTVGi+KmQ==
X-Received: by 2002:a05:701b:428a:20b0:192:fd91:c567 with SMTP id a92af1059eb24-19935906f80mr13498312c88.11.1793072073779;
        Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm54876624eec.23.2026.10.26.20.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 11:34:22 +0800
Message-ID: <20261027033422.585328-1-yyaqia@gmail.com>
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

