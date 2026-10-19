Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F44A3F26
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400548; cv=none; b=Uv1BPfhsqunOR7eGQSr2VjkCqiqSTSvOFtMTTozCts4IaaS0Kff+d+kuO7/VWEPNkHfA2HnsSh+z64mVlTlBVmngWwvC7ZMoucM920c5hDBNvaGYgjhBbrssqa6LVUnsw2ZCM3L9yVgcITVSEij81s66kj/ZOnoXi4hDKZB6NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400548; c=relaxed/simple;
	bh=hNwXCb0QCjeV6UqX+rBd6PPJAB3Kr8dXWIoXog/ZgyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMdv2hP6zTTdi2Rzuri09Mc94BvnoSVv/6o7IeD6l9rBnbqFRHM6cXBzdU5h1g1AKgkPTSORNEzzIKRqtlXaH0bkB8Fsi6cUDfBzkawbhetGNH62bNUNk6XXUgaBWwJeLsgoUpvfNowUgmcQa+y2qbGr84zO9cW8/i81DVzDG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkHDTD7a; arc=none smtp.client-ip=74.125.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkHDTD7a"
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so280665c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400546; x=1793005346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w2RQ5WGjn2LIf6pS+EL+gZuJjI5Zbzl0HNqA1FRv6fM=;
        b=CkHDTD7aV2ERCYXvf70hYwvxAOfEz7sBlqCLeavSztpilwx2fOLwpQt0rRM/7kRDNW
         z74mCnpTecR5o7auPds7TRz/NUQmnCuGk0kar5sl3aE3U0Gf0oz/5q8yFrJwi1kYoyCl
         LfFB2EoFXHKK2o9s4B9eKRiAMtU5aP2yIQ7zN19YD1t6BVthb2lpKMfXWz4HpYSnvzWE
         zJEfAQo+XuHmenAmpFbCVB8oxEq5brcLCdE4o2EHtRijXtCwMxhXmMIRYCJ62jL7YQso
         07x/ctg1t18eDZwyDFEl3x7W8B0yKmp9FrQLyd6jJHqIigN/GS7cHZ2e/0igLzzMkDD0
         Libg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400546; x=1793005346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w2RQ5WGjn2LIf6pS+EL+gZuJjI5Zbzl0HNqA1FRv6fM=;
        b=hBRinA9Z2eeN1cVMcKLcfwH3kvr7iheqHLjgsuVDjTeTar3MXHiFW+kFMrKmKGCStx
         z2h+4PzS+uVL6FjF8KLV3fWhkFV5dHo04hF5fgCdiLVo0M+sywBdIWNCb2ESTjBwSDh3
         N+2uCtI/2iR6W7FWUwUDQ+br5qDCG5pYmBzw8zF911/CCz29FcHNAtzpCtNH8d5s2Vio
         ox4QGs5lZxjbgLXCzBijAUfRJj5FQrTVQXu8Pzqt3/AUzxIZmRc5213V3ClIODLUPTlD
         vhd5EudF4jNqMGKpPhvvfaozmb8lHa+hpP6CSaIBepN2BXHztor2nWLMQpYtpQIf6rUt
         pNzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwj4urkdsQQWJ9xafrIJNTfNe1/H+NPOePrOHbg5Q7Vxa8u+Y4Dg2enRDc43PiiWMIIWDYKMks=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnnnn8vVBxRvBAB//Ed3V8/hvcIoCuni+KNy+JifafUZrE8vhE
	lVs4je9qvPfSvWPDsoq84hHkpsHOV0nzOoOvcPF24feQgZMvX1HVE8OZGCjpJYY+j64ZDg==
X-Gm-Gg: AYBFou34gRk2DzWZm7RaFUQgOjsnurGctOSrLnxrP8Au1J0qhLRBz/Wt174CW5AHvV6
	VGjxfITTUXnMnRiuAaSov+eTJi/9j2jfI3lC9xmmXxRLNKENZIvCGRYlKgHYLJmhUL6G8W5/aL6
	x8n/UGUnd0T0g/St0Se+7M+J6n4kxRKJ+yNES/A0W0M5mAOa/hVQZrH2lCOdkJxRO50s9CwjPfa
	XGBB8nS/c8djX2tQLeE5UTXAFJMYabOskC8N7dCD9NQ60nFrXgNXt6n/Fr+HLQJ2G/nIMiW7YeQ
	0s9S+myGzD7wW7iOayzstUnYWZ51kFWaggyuiD7wbAGl/o/23mpSSyTs0FUgr7rQZsJU7SCYqHo
	IbVzuE7m6t7F+i2WLqBOW+maeVqiIwqsL/6VO/TE6xEIW5+SYRI4PmSMxBm1JCqo+Guh9UUtfRd
	6Jn02cBNHhTJW4dlEHkaiAXn8YDffXY8vwiFGC2VvC/gG6G+O3FLdU8pVqmR9K83hWD8kIoGuJ0
	bvOT8hmiDwFPm5g3TL9LD+ckjm92ijAAJQ=
X-Received: by 2002:a05:7022:5f04:b0:149:1feb:6dae with SMTP id a92af1059eb24-18513b9ac38mr8670710c88.39.1792400545600;
        Mon, 19 Oct 2026 02:02:25 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:02:24 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Mon, 19 Oct 2026 17:02:05 +0800
Message-ID: <20261019090206.1094958-3-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the font is changed through KDFONTOP, the new geometry is
installed and vc_resize() redraws before the buffer is rebuilt. The
rotated putcs/cursor ops then index the old buffer with the new cell
size; KASAN reports a slab-out-of-bounds read in soft_cursor().

Rebuild the buffer for the visible console before the redraw, as the
other callers do: select the console's blitting state with
set_blitting_type() (which also uploads the new font's map on
tile-blitting hardware), then rebuild. Background consoles keep
their rebuild at fbcon_switch() time, as the buffer is shared per
framebuffer and must not be updated for a console that is not being
displayed.

Keep the old buffer out of the rebuild so that it can be restored if
vc_resize() fails: clear par->rotated.buf before calling
rotate_font(), which then allocates a fresh buffer. On failure,
err_out puts the old buffer back and re-selects the blitting state
so tile-blitting hardware gets the restored font's map; the font
change fails as a whole, and the error path never runs rotate_font()
again. The retry added by the next patch still covers
fbcon_switch() and fbcon_modechanged(), which cannot roll back.

Unlike the other callers, this one does not fall back to unrotated
rendering on failure: their "par->rotate = FB_ROTATE_UR;
set_blitting_type(vc, info);" pattern is ineffective, because
set_blitting_type() re-derives par->rotate from par->p->con_rotate.
Repairing that fallback is left to separate work.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v4:

- Restore the saved rotated buffer on failure instead of re-running
  rotate_font(), so that a second allocation failure cannot leave the
  console in a third state.
- Keep the old buffer out of the rebuild by allocating a fresh one.
- Abort the font change when the rebuild fails.
- Guard the rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.
---
 drivers/video/fbdev/core/fbcon.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..7605e4237ca5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2414,6 +2414,11 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	u8 *saved_rotated_buf = NULL;
+	size_t saved_rotated_bufsize = 0;
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2432,6 +2437,29 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the buffer so the
+	 * rebuild allocates a fresh one; the old buffer is kept until the
+	 * font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated_buf = par->rotated.buf;
+			saved_rotated_bufsize = par->rotated.bufsize;
+			par->rotated.buf = NULL;
+			par->rotated.bufsize = 0;
+			rotated_saved = true;
+#endif
+			ret = par->bitops->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2448,12 +2476,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated_buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * one.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated.buf = saved_rotated_buf;
+		par->rotated.bufsize = saved_rotated_bufsize;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2466,6 +2509,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Re-select the blitting type, which re-uploads the font map on
+	 * tile-blitting hardware.
+	 */
+	if (con_is_visible(vc))
+		set_blitting_type(vc, info);
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0

