Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B564756C9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403039; cv=none; b=tDXQm8TiChZRILl+D/pH6f3eCW9IZYNuCi+YMahbj3A1Vai147j0eNkpedFBTDBmQ+WXYR8MT4atRLeGScv3nimExXUGLJif0PfdGin2/+lgOqBByDfmtGCBwlJgm8jLXT/HibFzldng+j65ETDB6F3wUiQVaXm830YuNPIljOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403039; c=relaxed/simple;
	bh=NHZMWsqhaQ33Uo0xDtcv+OHeiqkGvqLsEmmgfpGzEN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4SRefotNLB581Wr23dEFd0G5uC5BFk8C1RBP9IYXvcVrsaCaK8/L5rDcc11kK89njgE0kcIVbjWwyNT/O6zhrxCwhEg7+mntzpk+Yy+ddrua7XGhr5Iaj5O+3dKV5M433CCPnrFGiIsMqoLwLyrI1c7gy1y+hEyOKtnyav8hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQzwGP2n; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQzwGP2n"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so921100eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403036; x=1793007836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
        b=BQzwGP2nE8HTSgirKKpAkkAnaseifqzHpb1rf7SwAeJSpDY5kdrGcbuPZU40h3Pe80
         jpPNeodaQUQYQzoJRV378uVOcI2klYp0Z8OsB3ZecB2G/xt96QGeg9Q8tXfbUR7tQ0by
         yz/kWCNfUDB2xajVt+agCh+rA1T8o4pTWG+L4TMW4fZlbeALaSlNoe/2TeyhnTMhwwJF
         ex/n6bzvuMhgClkKNAos1bd9azlE0P+aOzTo/6yAJPuNY/3rlVX7K5tEGux7Myeu5Wp0
         nBTrMN/UZ873Z/R1Ixbnbd2XwCH8EpwdfhTXz0DU1vREUFu8koBEllT+Fkd2nk6J3YA/
         DA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403036; x=1793007836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
        b=xib2nNDKXeb48e2dZElCPO5mT7N0CUZ37BOim29H4YllTKr0c9o7+SjosckDLy5N9F
         KG3CAe/ISQa3cOgj3gQc9sE83DurmTZTD0WnNJ1CgJvmufBDWH7Iy0F3A4Of0rAdWlv6
         4b/+0UipiNVonyWjs37sXFF6Gq8piK7PjXaYRtDrB8DVu3/r5vXJrsCN3Tzau7JxQZNO
         i+ITphxR95F/UZROIlXh8+wkqi0NLVCXwEUBHAfYJutTYRM1JlHhV96CHMXM9xnpn14c
         W6+GDZuXA7t5l7ejWYaWABRDvVcRGjRM/slrjxPQzEgqA5/q3yE6YrkqZNmIaIbO5B1P
         6NVQ==
X-Forwarded-Encrypted: i=1; AKwUvByr0yovsdbp4bSViYKxveTRQUV5YszvKuap/ZcdG2XTBThdjTBlbREVvkbeQDLc2ig3h7a+rQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0TRpiVcUhV7Kzra9Z/YhPI3NESdb+kGhNghqeLGA7kkmw1qEy
	xB/gjUa8Mn5+M+uKikv9cDLbfawTQF2DLB4r/200K8Ro9N22zHAAL5QL
X-Gm-Gg: AYBFou0GOa4l6vFmQEZsCFoXRp40YGsjBuGYIkgK+1REl6H9/80rAIj6m06VveX4F7c
	SkYAJh8DpeeaXKShmnjyGrCpucJRs3WNr7neQ0oBwRKciYt7wcf06Lyc2y/sicMrLYWuj0axZxo
	hKviVhV1ExT3rdasPXO9SpCSI2zjLX6bAcZWosWgkt7iY+imCLkqCmH3Hlp0kGA8P6dJTVyevIw
	Ois5vgXnJnlFZIGKzccRsg6bV6mn9ummdPqXSWnzh0+o0tB6hGZk0SOt1Gb1gbC8CE775SulYWg
	72poDgpZriaaUNH10QRDFReLasiar2pFXJjvYZ0ymZtE/a4LMgs1cJ9yUk5pjlmRUOZat9U9rHJ
	nFCzgp7jdL/WM0bkHl41TiXBdQjoXgppO5YG9Lscclk6s/xXCUrjyQzewIxQRBF7j+CHp+ZjTpn
	QdFyTIX2mP/fva9FlPeDhRCjm2OxWbM8bXgL0B0DLwE1Ike3DWGE3yEg7KVCrOJj1r4/LoiGMoK
	WTkvs+ToQvWI/KHHeMGCraKkCGJDAPGSeQ=
X-Received: by 2002:a05:7300:a214:b0:35e:ebb1:8e5a with SMTP id 5a478bee46e88-361a1b5251cmr9702651eec.26.1792403035840;
        Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
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
Subject: [PATCH v5 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Mon, 19 Oct 2026 17:43:30 +0800
Message-ID: <20261019094331.1128871-3-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
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

To ensure a correct rollback when the rebuild or the following
vc_resize() fails, save the rotated font state, clear it before
rebuilding, and restore it in the error path of
fbcon_do_set_font().

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v5:

- Save, clear and restore the entire par->rotated state instead of only
  the buffer. Restoring only the buffer left the cache key describing
  the rejected font, so a later switch could take the early-out and
  index the smaller buffer with the larger font's geometry. Clearing
  the whole state also makes the rebuild unconditional, so it does not
  depend on the next patch's buffer check (found by the Sashiko
  review).

Changes in v4:

- Restore the saved rotated buffer on failure instead of re-running
  rotate_font(), so that a second allocation failure cannot leave the
  console in a third state.
- Keep the old buffer out of the rebuild by allocating a fresh one.
- Abort the font change when the rebuild fails.
- Guard the rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.
---
 drivers/video/fbdev/core/fbcon.c | 46 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h | 22 ++++++++-------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..9a5d50d69d00 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2414,6 +2414,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct fbcon_rotated saved_rotated = { };
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2432,6 +2436,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the cached state so
+	 * the rebuild allocates a fresh buffer; the old state is kept until
+	 * the font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated = par->rotated;
+			memset(&par->rotated, 0, sizeof(par->rotated));
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
 
@@ -2448,12 +2473,26 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated.buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * state.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated = saved_rotated;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2466,6 +2505,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index bfbd70f8b1cd..a618adf3c871 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -72,6 +72,18 @@ struct fbcon_bitops {
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 };
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+struct fbcon_rotated {
+	font_data_t *fontdata;       /* source font */
+	u8 *buf;                     /* rotated glyphs */
+	size_t bufsize;
+	int buf_rotate;              /* rotation of buf */
+	unsigned int buf_width;      /* geometry of source font */
+	unsigned int buf_height;
+	unsigned int buf_charcount;
+};
+#endif
+
 struct fbcon_par {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct delayed_work cursor_work; /* Cursor timer */
@@ -88,15 +100,7 @@ struct fbcon_par {
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-	struct {
-		font_data_t *fontdata;       /* source font */
-		u8 *buf;                     /* rotated glyphs */
-		size_t bufsize;
-		int buf_rotate;              /* rotation of buf */
-		unsigned int buf_width;      /* geometry of source font */
-		unsigned int buf_height;
-		unsigned int buf_charcount;
-	} rotated;
+	struct fbcon_rotated rotated;
 #endif
 	u8    *cursor_src;
 	u32    cursor_size;
-- 
2.56.0

