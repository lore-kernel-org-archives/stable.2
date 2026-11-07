Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050829;
	b=x1QrVgTJ7zaytC1X0W/rFoogwN6ZRPdfeOXZCmLwd4ahzS/2kntC8e7TKopRCOQbx5V3
	 URXxLz43wTUKOTp55xUsQpJZayMGZjzWOD6iCGbqDZ6sEsjqAAWMfuXDk/Fu8/nEoA2++
	 GFS0jRYQlw5LNt/4hRlv+G+5BhvrEA1UAn6WHBrSo5zlVxsnMHHULTzybffahfs67ESJs
	 jFdfSGyHY70a8VIGJzg1gqHWb8zuP/VQnsoTT/BuavAfp+QDhEUYtPTejPU8tSrbDfLOC
	 TV0aGV+ABcVJkn29dWLA/EMLvy8G6p1Lk+5q/dCAfwg9NcjSkZLwjh/7rg/Z9gsE61g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NNP/+NwK0zdOAVLP0YkpeRt23gFfGKjveSVTHovyZjg=;
	b=AvxiX9CKklerGhIcYUjaC5BSA0nLqB/xDP8rFCilvP4lLHFdQ1LfoWj4fVuKMZjt5JTr
	 qqe3i/h2QQqPeePmKVNnpUDUc16H2HzXjgRysukqbdGaa+2+YO46Fra8vybUezQnTOI1u
	 SAr5JphkahKrOidjZBRFErdOE4gw/+ONEYRMI2FUQlfc7prhHmxb5ARi0aChyRmCU8chH
	 8SIM8DPBgqNAQNyjPqKy7DnquNXGzeo9O8SD9RKs4csbaZLpuzKiBXTD3rn8o6Khb53yi
	 9k/6OmSTBx1w+6zqkI+5t45vOoQRChOihvy3XpkdO9VBcHGLceRIQHiiLBGua7vDiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPRuRlJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47879606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPRuRlJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33E61F0089F;
	Sat,  7 Nov 2026 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050829;
	bh=NNP/+NwK0zdOAVLP0YkpeRt23gFfGKjveSVTHovyZjg=;
	h=From:To:Cc:Subject:Date;
	b=CPRuRlJzCwPaRW6tguNrBkV/AKVYWCQ+84fykNBlg7bhVTjIy7/cplzhaGsK7MLkH
	 snXG2td9FI21Cryq4Ms793u8MfLNJSXtl//q8tD11EO0MQjQgqGJEqIVpZwK/1fOLB
	 NMm0PCfoyj3N6RXDppxfyr+LSlEjox9ruLsJ82K3bWIoJsb9N+4Z/rVJa3jUD+T8Wm
	 kH9ci9DYZt3F40r01PxB/FHTw+JRkSy632J+0oabqN5Z37AnTDUh7JffUvQpD3eYHC
	 Ork7oxYPRUBFiDU1aVYhMReLDG1dC//CI1Xmrw3f7h2rH7mDoNJbYK6OT2D+qCum3H
	 sa8XI9fzbq5Rw==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Rebuild rotated font buffer on font change" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:07 -0500
Message-ID: <20261107062707-failed-5.10-e4b6b865d45d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e4b6b865d45d8dafb6c6f28c8a993a5b4431d25a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062707-failed-5.10-e4b6b865d45d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4b6b865d45d8dafb6c6f28c8a993a5b4431d25a Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:30 +0800
Subject: [PATCH] fbcon: Rebuild rotated font buffer on font change

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
---
 drivers/video/fbdev/core/fbcon.c | 46 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h | 22 ++++++++-------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ba689d42792d7..af587ff02e437 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2391,6 +2391,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct fbcon_rotated saved_rotated = { };
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2409,6 +2413,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2425,12 +2450,26 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
@@ -2443,6 +2482,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
index 91b59b2990d29..d93a89877d043 100644
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
2.53.0




