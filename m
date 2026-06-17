Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDA2D94AB
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695780; cv=none; b=jV06yhRLfs9tz0jks680sxxx1p+CUyI9Rut2t23ixH3Afirs+ouw158+zZd9JNKvkhsHREVKNfA9XJq1YU+gr3MvPFjOw2c7/GASDS9qlViTHWErfv003WxvnutzhBxP7RQpx2fr3iEMKYn9aMHUY8jWQjRDdH1tI9nIpwb9/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695780; c=relaxed/simple;
	bh=3p7XZ/qL3/9FoxLGYi5zEFz1IHsnMRpVGxgtlmMPr3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIIH0svRwxhocawf4jXWzkdSqBqyanopwzk2XtqWJR9GGHVKwZjE2ftWT4IkUu1WNTZRvb7YirBEKuJhs4/O2oR+7beOxUjbrhTdsQj7nGT/mAWEXXGnGBaCOsRZRXyMAig+2Yu/jB4urSfa1hNSH0M/e4RFjrpxKKjZy19vD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B112D6BEAF;
	Wed, 17 Jun 2026 11:29:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73B87779A8;
	Wed, 17 Jun 2026 11:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iP8HGyGFMmqbZAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 11:29:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/sysfb: Return errno code from drm_sysfb_get_visible_size()
Date: Wed, 17 Jun 2026 13:27:30 +0200
Message-ID: <20260617112932.511657-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617112932.511657-1-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B112D6BEAF
X-Rspamd-Action: no action

Change the return type of drm_sysfb_get_visible_size() to s64 so
that it returns a possible errno code from _get_validated_size0().
Fix callers to handle the errno code.

The currently returned unsigned type converts an errno code to a
very large size value, which drivers interpret as visible size of
the system framebuffer. Later efforts to reserve the framebuffer
resource fail.

The bug has been present since efidrm and vesadrm got merged. It
was then part of each driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      | 2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
 drivers/gpu/drm/sysfb/efidrm.c                | 7 ++++---
 drivers/gpu/drm/sysfb/vesadrm.c               | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 2a2b553366fb..547f2327af5e 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -50,7 +50,7 @@ struct resource *drm_sysfb_get_memory_si(struct drm_device *dev,
 int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si,
 			    const struct drm_format_info *format,
 			    unsigned int width, unsigned int height, u64 size);
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size);
 #endif
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 361b7233600c..40b4f7883b9b 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -64,7 +64,7 @@ int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si
 }
 EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
 	u64 vsize = height * stride;
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1a1e36700976..3f9cd5d03efb 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -152,7 +152,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize, mem_flags;
+	s64 vsize;
+	u64 mem_flags;
 	struct resource resbuf;
 	struct resource *res;
 	struct efidrm_device *efi;
@@ -206,8 +207,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index dbc317778d54..6a67b2d2e451 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -402,7 +402,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize;
+	s64 vsize;
 	struct resource resbuf;
 	struct resource *res;
 	struct vesadrm_device *vesa;
@@ -457,8 +457,8 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
-- 
2.54.0

