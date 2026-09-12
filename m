Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42635677C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227596; cv=none; b=Zu7xEShWK93V76WDla5xNen2Xl8uK7mZWTarF2jLOr5olzHY1qavUQ7ZOF5lgbP1UKe7VetEhTwLlG25juMfhzdHqF22X8Ow+8xcd6NfRUvaahVglKnDSQ3cXZgTN9lkRsqCzVx9dwXWhmtVtsEhu2yy3e0ExeHccF5iiSSfWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227596; c=relaxed/simple;
	bh=DUEqwzrnSo8++4BKub772LbXgzhAWIF5ehq5fzZk+Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsW6YogSCNme2EayNJrmi6ZFDIpUlWOBuWC2VzYI4bw59u0TFlPongZ3Vty/KlbvzQ/bSzm7sjE5/e+W85Gf6m5umzAmUSPQpP2xYd44K9a5d78hS+VZxgoLlXNWlK71BUHWVh/2rhxft44bRjZ23Ik1NXsCo0jfyK5Mn12NRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IErg4V07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IErg4V07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222991F00898;
	Sat, 12 Sep 2026 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227594;
	bh=d0DpRHvBUOfAGYcMUyHuErwg92hnWle0N5ILA2/RUU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IErg4V07pNkMu3SfXzBVa2TR8anPkWF4Zwql8oLAxD7G21TbNBHJ/d8xubZ+lOx8P
	 vpj3kUPWovO8E6lOReI5A8JF1CRrImN6PF/hVQADAgsHj25JsM64ME3XkN2KCAwyuA
	 whVYR9aJlYRFsCzD0obtQfOnbGFxeFMaGGhCBrnY18IS2Ea3viSnXKi8S8RW8HCddu
	 4Lq4xzrMU1OJj3qqNjPdYZQ1wnwjzKHccsVN9Ol1mb5Y6PMKKN3KtLpr6XfBS0QUZI
	 xwxroPzhP1UFbaCMpcR6KPxf5lxbA4LJip6o22uFstdAr1DrUg1opZXJs13TDqH+QB
	 3Ry4eofHkjv5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] firmware: sysfb: Move bpp-depth calculation into screen_info helper
Date: Sat, 12 Sep 2026 11:39:51 -0400
Message-ID: <20260912153952.3238327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-cross-finalize-0ac3@gregkh>
References: <2026090919-cross-finalize-0ac3@gregkh>
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
index 74363ed7501f6..7f2307cde243a 100644
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

