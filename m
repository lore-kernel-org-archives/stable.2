Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4131618C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227223; cv=none; b=V2v8RjHw/OsIfiYZPICsk4XmsNqfPY1e1anlttys9kb1noOQxR+0l39rX7uSr2dVryXEVFBfKVwC/zVnnvMc83SjVE0pU4gCETKKzTm/uv7FAI0GuaIHGIflCd/R/36TkLhNHDg8l5uyeZbq/7W9Qv4krG6MAyww6UscWwmEdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227223; c=relaxed/simple;
	bh=rTcbFudA3OI6MgpfN9NknM6QhFN5e15/msbwasPCrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/rh0VEPGn1zoVYGycLcby6PF0pRC6vcVMHw9V0W7hSnXAFHQfpFRRXGTmiOidqlQeMiF3p9ZBrOl1097QB7RuUVPBguiVm2oZhhLwBSsRdz0VREK2vVsBeyVDjt2Doehx8p1MhgVDXHrzf6wJUVF2byd792LPrH8W2zLMTJWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7T5FVg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7T5FVg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C131F00893;
	Sat, 12 Sep 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227221;
	bh=j3paA7DDwvxFyxbfe2tQrhwqrLi/kbIQbJiiI2ZebiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7T5FVg4D/jYz274/pYgb1g7NaMdcMNt8kbJBe/yBNl/4oEZO3pFqr9A9rbn1lI53
	 jk+1RZqiy8Guz/Q8htbpK7GsofC2MQHoVMnQmQv2OPnJ5cSIW3dILPVpmrBNSuUdd0
	 vu8Q8yOicfjyb8W11o/oC6iktosy9GJdrGg3TzpyByNl1BsotMAVho+gZNshu1jyUP
	 RRzP2W6TVZAe7ygwgikaqxCKL4DelIbcIrOLND867pRUxz8yfMz19hT/UrXhrVTwSD
	 eK1uKMNWNTumzjMIZUowcPpQ+Bb6ldkTd8NxotLJJJZQWd9/9Fv4CXMQKLYyeAVNzN
	 ZtitUMtJwtu7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] firmware: sysfb: Move bpp-depth calculation into screen_info helper
Date: Sat, 12 Sep 2026 11:33:38 -0400
Message-ID: <20260912153339.3234260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-operation-hull-a6ea@gregkh>
References: <2026090919-operation-hull-a6ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 1ce4c3aeef333be1e6290ec6d1f7891c2bfc7a1f ]

Move the calculation of the bits per pixels for screen_info into a
helper function. This will make it available to other callers besides
the firmware code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/20250401094056.32904-14-tzimmermann@suse.de
Stable-dep-of: 03f1a3545b72 ("drm/sysfb: simpledrm: Improve framebuffer-size validation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/sysfb_simplefb.c   | 31 +------------------------
 drivers/video/screen_info_generic.c | 36 +++++++++++++++++++++++++++++
 include/linux/screen_info.h         |  2 ++
 3 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 75a186bf8f8ec..592d8a6446192 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -35,36 +35,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	if (type != VIDEO_TYPE_VLFB && type != VIDEO_TYPE_EFI)
 		return false;
 
-	/*
-	 * The meaning of depth and bpp for direct-color formats is
-	 * inconsistent:
-	 *
-	 *  - DRM format info specifies depth as the number of color
-	 *    bits; including alpha, but not including filler bits.
-	 *  - Linux' EFI platform code computes lfb_depth from the
-	 *    individual color channels, including the reserved bits.
-	 *  - VBE 1.1 defines lfb_depth for XRGB1555 as 16, but later
-	 *    versions use 15.
-	 *  - On the kernel command line, 'bpp' of 32 is usually
-	 *    XRGB8888 including the filler bits, but 15 is XRGB1555
-	 *    not including the filler bit.
-	 *
-	 * It's not easily possible to fix this in struct screen_info,
-	 * as this could break UAPI. The best solution is to compute
-	 * bits_per_pixel from the color bits, reserved bits and
-	 * reported lfb_depth, whichever is highest.  In the loop below,
-	 * ignore simplefb formats with alpha bits, as EFI and VESA
-	 * don't specify alpha channels.
-	 */
-	if (si->lfb_depth > 8) {
-		bits_per_pixel = max(max3(si->red_size + si->red_pos,
-					  si->green_size + si->green_pos,
-					  si->blue_size + si->blue_pos),
-				     si->rsvd_size + si->rsvd_pos);
-		bits_per_pixel = max_t(u32, bits_per_pixel, si->lfb_depth);
-	} else {
-		bits_per_pixel = si->lfb_depth;
-	}
+	bits_per_pixel = __screen_info_lfb_bits_per_pixel(si);
 
 	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
 		const struct simplefb_format *f = &formats[i];
diff --git a/drivers/video/screen_info_generic.c b/drivers/video/screen_info_generic.c
index 64117c6367abb..900e9386ecebd 100644
--- a/drivers/video/screen_info_generic.c
+++ b/drivers/video/screen_info_generic.c
@@ -144,3 +144,39 @@ ssize_t screen_info_resources(const struct screen_info *si, struct resource *r,
 	return pos - r;
 }
 EXPORT_SYMBOL(screen_info_resources);
+
+/*
+ * The meaning of depth and bpp for direct-color formats is
+ * inconsistent:
+ *
+ *  - DRM format info specifies depth as the number of color
+ *    bits; including alpha, but not including filler bits.
+ *  - Linux' EFI platform code computes lfb_depth from the
+ *    individual color channels, including the reserved bits.
+ *  - VBE 1.1 defines lfb_depth for XRGB1555 as 16, but later
+ *    versions use 15.
+ *  - On the kernel command line, 'bpp' of 32 is usually
+ *    XRGB8888 including the filler bits, but 15 is XRGB1555
+ *    not including the filler bit.
+ *
+ * It is not easily possible to fix this in struct screen_info,
+ * as this could break UAPI. The best solution is to compute
+ * bits_per_pixel from the color bits, reserved bits and
+ * reported lfb_depth, whichever is highest.
+ */
+
+u32 __screen_info_lfb_bits_per_pixel(const struct screen_info *si)
+{
+	u32 bits_per_pixel = si->lfb_depth;
+
+	if (bits_per_pixel > 8) {
+		bits_per_pixel = max(max3(si->red_size + si->red_pos,
+					  si->green_size + si->green_pos,
+					  si->blue_size + si->blue_pos),
+				     si->rsvd_size + si->rsvd_pos);
+		bits_per_pixel = max_t(u32, bits_per_pixel, si->lfb_depth);
+	}
+
+	return bits_per_pixel;
+}
+EXPORT_SYMBOL(__screen_info_lfb_bits_per_pixel);
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 6a4a3cec4638b..ab3cffbb58b7f 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -128,6 +128,8 @@ static inline unsigned int screen_info_video_type(const struct screen_info *si)
 
 ssize_t screen_info_resources(const struct screen_info *si, struct resource *r, size_t num);
 
+u32 __screen_info_lfb_bits_per_pixel(const struct screen_info *si);
+
 #if defined(CONFIG_PCI)
 void screen_info_apply_fixups(void);
 struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
-- 
2.53.0

