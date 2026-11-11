Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423078;
	b=sb8B8iMHbp1M97zT0us7jHqg4HejmDOiBB3lUzFh9G68u+bWvO/YdK/dcDYunUsKP0Ew
	 Rutn4qH7hltGFEfGsA5w0F2bME0GHP3zfJF2xlHjR+q0Dor3E4rV45DMCUdGNoqcpUq0D
	 sK7m5NJLEqnEEdHVvQwutysQ3A5nasNxu8GlHYc+aE+J2b7H6dWREmNlln7EGIq4JDDW4
	 y5cYvtIaCB2oVuifVXw1oWBntkoVgD8/FpjBBccddERmUvqihOIpdA9F2K4yxqduCeRPK
	 l/I9eJlm+T56IyN5s/C+uDzPKz5wmVFtPM67Tr034ABh1EOoeLqx6TGMQAs38lPTiPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2keT7Ms1yh7H2A5fH24C4ZP9s+1ZE+h6vnQv259i8ZU=;
	b=JP55/WyCzL//CQfrTR7b9w7DxPAn3/DGQZOV7FIfhnBpwZjUMkKEddbr205hJ/QYZ7l4
	 2AYybupP52ayAoCakpW2M8op0kTgylroXGS5fCbNj7O0/K0SVgLfP/o60ppKTwlwD8l5c
	 Y0UNDPHHu8tnzr7jW/Jk1PE66tCbYIS/mf46h56Q43AdnF87GWxp++PfhhfPnv8l5DnT5
	 FG1dGmPad9qmDeJ735iCSvJY94RdUUTcG2Xhyf+JcsD6nOqUyFOPu4NGOApzRG2pSvd9E
	 FmAAmqXKXeW7yLYSlc7IllPbHs62AIwy0pzBciRtEo7ioEAluB73noLNhjFmLK5GQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0Z7KoPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F768606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0Z7KoPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D24D1F00A05;
	Wed, 11 Nov 2026 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423078;
	bh=2keT7Ms1yh7H2A5fH24C4ZP9s+1ZE+h6vnQv259i8ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0Z7KoPZkMeWoQ8d8KSYOR7FDeTuQKNAXnwyb9/hf7g28SaUv8inWiXLnUqvu749d
	 1+pvGKGOoFYVMmYvFmA6LZmxzXIiALsu9vuOQs2kpJ09oEy1djHzZjyzVoQUcfoD+R
	 fC/2NEs3EtOG4uyJ4bVRXMnHzcrO1Xd1+tDrRkRSCpyMv7RQ5LD/2Mn/W9zPu6pMT8
	 gFYJg/aWxhtdKFkpA+Aq/PrjJpxdvjec6q0xPHT4OGolOHFYArQ7jXada2BnbR2iW7
	 gzUe1A9b8J8eJEpvGja8HrlcVdKEnhCkhb6vjAMVXMy1Mxik3dpCBVgnit6dM+4Eya
	 eub6ZtN/7OG2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fbcon: Rebuild rotated font buffer on font change
Date: Wed, 11 Nov 2026 13:51:16 -0500
Message-ID: <20261111185046.3895966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051321-failed-6.18-e4b6b865d45d@kernel.org>
References: <20261107051321-failed-6.18-e4b6b865d45d@kernel.org>
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
[ sashal: adapted rotated font cache handling to the older fbcon_par layout and font reference-counting API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 903823c9ce567..51860796f4364 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2430,6 +2430,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
@@ -2449,6 +2455,33 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2465,11 +2498,28 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2489,6 +2539,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

