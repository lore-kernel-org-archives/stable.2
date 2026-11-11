Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423581;
	b=qrXXdG/nJK0sldsSnD/hfAbrS3LwQ2kZ4ktJTwPFknjvu5uoewqty0giuTvR3d3/6Sf2
	 EHAh+1HgYV59ubP1ASfBV0OfvoXWTvV5hr+u9g2iZRIEBiA34XwBvdEcCd94bLSTwW2LT
	 6N1xrQQmSevAL1PLHgKOXbKfjKaLkZEeHf3qNuTxsnbQKNrZAe9JjAFvWSqAFasAUxH6q
	 LJrHI3aogx93R509OcmxEL13XJBc+VVahmecmxwD5/v9O+PY3jbLndvJy9JOY2eDfiCEo
	 IHAGxdN5xwjFVppf58FdRVFPs/kQO03VHzO6vsK8qQaT7qDaiPzhcK0xqV75GWwYInA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/e+8ZeUs2qOMVCtzlkrtF87tt4CmOFK4MtQqrm+g19E=;
	b=i6Lg9Jk9j3o6VDhicRF4Y6uHVaEkRboBUoIPy5FwTuAkrE5VwT2stEBnNTkEWUtdDZ2D
	 7qqJN/Ij99yoQd/SJhcLe2QJnD9nenxpy1yWDp+WzbkJQ9+XQ8ZZLNgm9ZvilbEDTIBzE
	 S3J4uX7eeenXwLDxvS9jrCptK3Ezvu/X43VZsTWtIWxFU3CB4y7AiSL6XGD/IJr4wps5Y
	 fssK2BAnN2UJlQcLZFGAwBclmh1qd5nRcWPwKKcR0zLf9wTJKU4xtIGARwQ5VyfFIIVwf
	 uviOGJjS+ZeAtLE7Q7+ed4qjp4Gc80t+jao3PHGhQF1UCKsmMcOwWA/RZ8Uwq0gksww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daQGlObq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2B606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daQGlObq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343161F00ACC;
	Wed, 11 Nov 2026 18:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423580;
	bh=/e+8ZeUs2qOMVCtzlkrtF87tt4CmOFK4MtQqrm+g19E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daQGlObqc/UAlVoYE4+FYs4QhsbOR8LFr/3N21f6MF5VCQlWEj3D0tqQXQJa62+vd
	 FlRR23tIkZyP8sNhaiUZBOcZiPrKnviTUeAURzEUv8ECZ1uATgjcXA8vfPOpt6OfXr
	 WXrq1UqckeqcDnupqGM/CcfxeBND2taUWrgKx2j2LNRmau9JFRKosbwsuspoTEdSYb
	 Ha3BywVBUVaTajW52Jnwuuevf0i/tIdrX3QxAiSjVNhsQIETrzu0pghXwFeD7Fjh3x
	 AaiGVDEfBDQM4ZinkAnGM2PtnIJ3VtVb7iNTny1UiRhDEWuQXlVCLouNiGPUzjSq1m
	 5cxrKmoRo3J/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fbcon: Rebuild rotated font buffer on font change
Date: Wed, 11 Nov 2026 13:59:39 -0500
Message-ID: <20261111185908.3923312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055247-failed-6.1-e4b6b865d45d@kernel.org>
References: <20261107055247-failed-6.1-e4b6b865d45d@kernel.org>
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

[ Upstream commit e4b6b865d45d8dafb6c6f28c8a993a5b4431d25a ]

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
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: adapted rotated-font handling to use separate fbcon_par cache fields and the direct rotate_font callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d6a728e0690d2..2b891dd6330f9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2415,6 +2415,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	u8 *saved_fontdata = NULL, *saved_fontbuffer = NULL;
+	u32 saved_fd_size = 0;
+	int saved_cur_rotate = 0;
+	bool rotated_saved = false;
+#endif
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2434,6 +2440,33 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update the rotated font buffer
+	 * to match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the cached state so
+	 * the rebuild allocates a fresh buffer; the old state is kept until
+	 * the font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_fontdata = par->fontdata;
+			saved_fontbuffer = par->fontbuffer;
+			saved_fd_size = par->fd_size;
+			saved_cur_rotate = par->cur_rotate;
+			par->fontdata = NULL;
+			par->fontbuffer = NULL;
+			par->fd_size = 0;
+			par->cur_rotate = 0;
+			rotated_saved = true;
+#endif
+			ret = par->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2450,11 +2483,28 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_fontbuffer);
+#endif
 	if (old_userfont && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * state.
+	 */
+	if (rotated_saved) {
+		kfree(par->fontbuffer);
+		par->fontdata = saved_fontdata;
+		par->fontbuffer = saved_fontbuffer;
+		par->fd_size = saved_fd_size;
+		par->cur_rotate = saved_cur_rotate;
+	}
+#endif
 	p->fontdata = old_data;
 	vc->vc_font.data = old_data;
 
@@ -2474,6 +2524,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Re-select the blitting type, which re-uploads the font map on
+	 * tile-blitting hardware.
+	 */
+	if (con_is_visible(vc))
+		set_blitting_type(vc, info);
+
 	return ret;
 }
 
-- 
2.53.0

