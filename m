Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424579;
	b=ve+2MzPaNQUKAvsr+uNzIBI1eaUx/eX6hLk1SDyfZDVIpt9L2/M+EQazBqN4Cd1dOjZl
	 HOBuoTBse3L82gKj/4QBcppBL8bnuYFtNq8K6LKZufwcXnTPt/eVp5CA6V1HsPFk/z0gA
	 A1HuMhu2s85zK/JzcY+A8Zgai6tTBscGHRKKaMWwfEHdWDl0XXpBGb+QSXlipxljWJLOG
	 SXyBcaSDv0KclfDir6ameNa0/+PFRMZ95EyZtXrTlJ+jCjirPFnJzmj4VkKHZtIa2Qx8h
	 +bZyf0xXxwzpYiRagtVXfOCvtOwzhvz1vXZJOEgcypCVG/QC9H6pxd4RmkdfqwBw06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i2O5pYSAR+99dFr01TS/jsnlEsmaV7synN3xLbqvvDg=;
	b=SVfhzDG+lB/s4lU6y2CqC9a0j1uZBSXB4Zl0tw45+9kq7jbpkIGV36PPpU2SSW0oXOK7
	 iYM7rvNDKepv633/jT1aOoqWD1C4rlht2PdwaITf1G3Uj/WcPDLRzCofefGuEQDcoFl5V
	 7f/3Eguum/I7aC4uLtcCaxFdMsBiXNTmZwMGYopvpTn9sdf1lBnt99OxYW32ZTXsNHVkn
	 6F1aBR7JOqOq+YcYBEcsUeIrAVgAkMp0QbLlIkTaUd8Vgr11SDB0YtSAoCdrmrtBkCpsW
	 pwpOZ0n08Fcav6coWjW4Gw3JJbsbULIoai+p1MHuCE+stpafidqDuGL5kFJ7ymU7ChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cjz3YCE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cjz3YCE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FAE1F00A06;
	Wed, 11 Nov 2026 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424579;
	bh=i2O5pYSAR+99dFr01TS/jsnlEsmaV7synN3xLbqvvDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cjz3YCE5PAESFAuOuAh7g/HpUYSmByHhZIQVCskcsnx+6BdG8IuUIz+Fv5LNiw7Bq
	 m5JW7r6cp6KX7l7taVELQYEY6fysKqB9PqgxSn6CG7Xd3rIFi7Nml1y1ND9ImfcvID
	 TfEe87g2vjCoy0hjhM4n4u6sfQM+Bs2dWO3FRYsEJkX7vyWlB7OIer9FDhALzQt+K2
	 xxdkQyDTeIYZGfyz9+rH9h59Z/bFJxVxcqe6Ly9LUUqcvYe9hQdjJygRkkzhtPyjHR
	 oRrEYChN7/e+S/SgjtX+ldi8FAQrEWcu8EvGVAxfdWrX/H+C/MbS+QX00LICHkJzlZ
	 PHPANWenlVUzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbcon: Rebuild rotated font buffer on font change
Date: Wed, 11 Nov 2026 14:16:17 -0500
Message-ID: <20261111191546.3930787-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062707-failed-5.10-e4b6b865d45d@kernel.org>
References: <20261107062707-failed-5.10-e4b6b865d45d@kernel.org>
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
[ sashal: adapted rotated-cache handling to the individual fields stored in fbcon_ops ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 41720de26eee4..779e648aeaffc 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2434,6 +2434,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
@@ -2453,6 +2459,33 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
+		if (ops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_fontdata = ops->fontdata;
+			saved_fontbuffer = ops->fontbuffer;
+			saved_fd_size = ops->fd_size;
+			saved_cur_rotate = ops->cur_rotate;
+			ops->fontdata = NULL;
+			ops->fontbuffer = NULL;
+			ops->fd_size = 0;
+			ops->cur_rotate = 0;
+			rotated_saved = true;
+#endif
+			ret = ops->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2469,11 +2502,28 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
+		kfree(ops->fontbuffer);
+		ops->fontdata = saved_fontdata;
+		ops->fontbuffer = saved_fontbuffer;
+		ops->fd_size = saved_fd_size;
+		ops->cur_rotate = saved_cur_rotate;
+	}
+#endif
 	p->fontdata = old_data;
 	vc->vc_font.data = old_data;
 
@@ -2493,6 +2543,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

