Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423750;
	b=JRRtBRDT1sQxwhJK+H3sU//RwwkcDMiGFEB9w9u4AeDGTt7jh6C3mnE3nwfAebuFGXfs
	 cYXd4ux9Y2TtTULo/FZclY4WG9LZebraMdnz0xMUbGBO9X8Ok3GhEAAqW0mxBVrhlBXe0
	 bvP+nUToiTXkrNnQZQh0nmKN39xu5xcWKYxxqUzkGqoQsNHLNHuavAanQVy5L/Qt8kRcr
	 0JCM3SXrdVEckinKhdPhOl/sr7A0LvkDhylCKnkwijpBhOcjgIIqsFDj+SvmNpI4Oevmw
	 UsgbZD96FssscMJjB10jqF6HXLIkkxSK1gOXg8OJQ9DjyRVIW73rrmC4fhRFUaXqePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Dgcd3s9iY2YEwfM4c2i4CzVOyXcx9IKcTe430uyrjk=;
	b=2cagBCPNAaEsQwuc11N2OXxfgTd/rLORqzwACM2XNk+8amad4vKNjgYzBIxmjdJZBG4H
	 284RVehA/DshwB8rRgwLDotocIO0Is6Q+//DOuN3Hxuf8X5cFdaKBj4n1V8gDuAMeGMbn
	 CG0PaEFNM26NXQLEPelO5VccMpW94rmSacFcmnFo+N94xzBl27XLutChHCrWaPQbW5O76
	 XIrix60s4MoCkcafqyYOCAVD/h34Q4ehe9XmSavUrw4NbuKovcQUpBa6fJTWleH+H2AQ+
	 bbCnwlohkOjDEMkNHLzvl6eIiFMkH3PnM3LPV3hz1JqUrbpv3MmpG88ILWkdScP75ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOxHSgom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A265606A89D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOxHSgom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679CD1F00A06;
	Wed, 11 Nov 2026 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423750;
	bh=3Dgcd3s9iY2YEwfM4c2i4CzVOyXcx9IKcTe430uyrjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOxHSgomPkgLWNdcMqDzbxwif/Prh8253l8Ba7h0PGmJr6MHMNFMEcO+F7KeaNwof
	 Ouczr1QbHLEd3toajMpA/kLJbmVswBOrnCYfMLGasAMw1EvO52RpJElrEykxeQuL23
	 0YHpUBXKjxqg1lQ/NQ5mii5GVLR3tN9iBQH+L4WhQwWeVM8kU/UNSKu+4sAnNS+Qco
	 ZwRAoASdSWPxH96SFig4sy1i/MK6eXIDfE0i+RmRGqmrJjp1PYdMqslrC5LAWWsg/d
	 rFKmSq89OXbmSlEmYdGqbcQOunuPIkHZqz13rFgMWlHpjJ9NM+dz+yquqYPedlutUM
	 tyMxEZyBwnoZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fbcon: Rebuild rotated font buffer on font change
Date: Wed, 11 Nov 2026 14:02:28 -0500
Message-ID: <20261111190159.3927427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061003-failed-5.15-e4b6b865d45d@kernel.org>
References: <20261107061003-failed-5.15-e4b6b865d45d@kernel.org>
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
[ sashal: adapted rotated font handling to separate fbcon_par fields and the direct par->rotate_font callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index efefa73451a0b..a47b98c269cf3 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2389,6 +2389,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
@@ -2408,6 +2414,33 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2424,11 +2457,28 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2448,6 +2498,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

