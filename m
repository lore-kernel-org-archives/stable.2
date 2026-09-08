Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35722D0C64
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830305; cv=none; b=AAvx9CIGNJ2rCxg2hroO8FTsYT1OFgJtTA/P8qAH2H95qulEfPJEJ72cel8ZujQQ9lvYidXxncgTNKkdw0HgxQrI/9sOsUb8JwEOBc7N4+CbAu0iLtNZRgR9E51Xxg1zQy2yYbver9wUwXmo+PIDCe/d6r0qE3XOTq6SECbWVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830305; c=relaxed/simple;
	bh=J7VUZfghbQ0pPyYe/HkyYf9qzWlVPOAbBBYgZtVKI+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLpC3Rpt5CNGRAKhfxnmSRnKRxjJaQyXM2ogTr5bm1vLRFs8ZlqT2UEX3CamdrCIyW8Joq9ZOXCDl/L9kPEL1Vng4W+mgzQElxBRujkaqRQ6pU4WHtGBBRM5zzXgNRJrolkWfEIDU/nfNLmQTrdkWhg2/dx29g0FN7iN2zeyx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRPDeDbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRPDeDbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051A71F00A3A;
	Tue,  8 Sep 2026 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830297;
	bh=4mCNjS2CBfQL80uj7T8rZ1kk93qb7WS4Adjq5QC8PMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRPDeDbKYQGeTvsROw73q69JANaGjgLNlMt8/c+Lnu9sZMEPLRQ3Pk5vtwxAudMmD
	 d9i0X9z1uM1uf6BJpmJwMNQHiJiMNu8Y15/RP/ZMnPvnrsuioa/k2TH+BLp5JMrQcN
	 61OtEQ0JIwQ+uME5iUw1zfPcKdoxy53lowfZs2rLxRkOavdQshb7WzVVlHaIi+j2+W
	 9qRmx8Ad2wE3aYwg+8SN/a83U9zdYvbX/rPeMyMjNwtwlSchgs/CWN34Mjc9yTmTi6
	 JEfRHWYcDwtZxk4CrlUWOQ5g2vozMUKuyzJeMauVsbaPsl6H4PLBo6sCvRXDrNSc16
	 C7oDXIDAQqgGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] fbdev: Put mmap for deferred I/O into drivers
Date: Mon,  7 Sep 2026 21:18:10 -0400
Message-ID: <20260908011815.1729727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-mantra-reunion-82ab@gregkh>
References: <2026090351-mantra-reunion-82ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 5905585103276b7c14bb9a7de4b575216cb6dac4 ]

The fbdev mmap function fb_mmap() unconditionally overrides the
driver's implementation if deferred I/O has been activated. This
makes it hard to implement mmap with anything but a vmalloc()'ed
software buffer. That is specifically a problem for DRM, where
video memory is maintained by a memory manager.

Leave the mmap handling to drivers and expect them to call the
helper for deferred I/O by thmeselves.

v4:
	* unlock mm_lock in fb_mmap() error path (Dan)
v3:
	* fix warning if fb_mmap is missing (kernel test robot)
v2:
	* print a helpful error message if the defio setup is
	  incorrect (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220429100834.18898-2-tzimmermann@suse.de
Stable-dep-of: 9ad709afdfa3 ("fbdev: ssd1307fb: defer I2C transfers from damage callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c        |  4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |  1 +
 drivers/hid/hid-picolcd_fb.c           |  1 +
 drivers/staging/fbtft/fbtft-core.c     |  1 +
 drivers/video/fbdev/broadsheetfb.c     |  1 +
 drivers/video/fbdev/core/fb_defio.c    |  1 +
 drivers/video/fbdev/core/fbmem.c       | 22 ++++++++++++----------
 drivers/video/fbdev/hecubafb.c         |  1 +
 drivers/video/fbdev/hyperv_fb.c        |  1 +
 drivers/video/fbdev/metronomefb.c      |  1 +
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  6 ++++++
 drivers/video/fbdev/smscufx.c          |  3 +++
 drivers/video/fbdev/ssd1307fb.c        |  1 +
 drivers/video/fbdev/udlfb.c            |  3 +++
 drivers/video/fbdev/xen-fbfront.c      |  1 +
 15 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index bc265aa0f692b..7dc10cb90d4e5 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2090,7 +2090,9 @@ static int drm_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 
-	if (fb_helper->dev->driver->gem_prime_mmap)
+	if (drm_fbdev_use_shadow_fb(fb_helper))
+		return fb_deferred_io_mmap(info, vma);
+	else if (fb_helper->dev->driver->gem_prime_mmap)
 		return fb_helper->dev->driver->gem_prime_mmap(fb_helper->buffer->gem, vma);
 	else
 		return -ENODEV;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 79b08e927f769..8c1e9205937d1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -626,6 +626,7 @@ static const struct fb_ops vmw_fb_ops = {
 	.fb_imageblit = vmw_fb_imageblit,
 	.fb_pan_display = vmw_fb_pan_display,
 	.fb_blank = vmw_fb_blank,
+	.fb_mmap = fb_deferred_io_mmap,
 };
 
 int vmw_fb_init(struct vmw_private *vmw_priv)
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 8a0d1365cd723..de61c08fabea9 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -428,6 +428,7 @@ static const struct fb_ops picolcdfb_ops = {
 	.fb_imageblit = picolcd_fb_imageblit,
 	.fb_check_var = picolcd_fb_check_var,
 	.fb_set_par   = picolcd_set_par,
+	.fb_mmap      = fb_deferred_io_mmap,
 };
 
 
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 67604a4d9a39f..0e5b3f627fff2 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -653,6 +653,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbops->fb_imageblit =      fbtft_fb_imageblit;
 	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
 	fbops->fb_blank     =      fbtft_fb_blank;
+	fbops->fb_mmap      =      fb_deferred_io_mmap;
 
 	fbdefio->delay =            HZ / fps;
 	fbdefio->sort_pagereflist = true;
diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 786fe6116405b..fd66e18fd58a5 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1054,6 +1054,7 @@ static const struct fb_ops broadsheetfb_ops = {
 	.fb_fillrect	= broadsheetfb_fillrect,
 	.fb_copyarea	= broadsheetfb_copyarea,
 	.fb_imageblit	= broadsheetfb_imageblit,
+	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static struct fb_deferred_io broadsheetfb_defio = {
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index e348f4c15d81a..20f3f9c5242b1 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -321,6 +321,7 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fb_deferred_io_mmap);
 
 /* workqueue callback */
 static void fb_deferred_io_work(struct work_struct *work)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 130fa827eee32..78303cf740701 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1352,7 +1352,6 @@ static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	struct fb_info *info = file_fb_info(file);
-	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);
 	unsigned long mmio_pgoff;
 	unsigned long start;
 	u32 len;
@@ -1361,14 +1360,7 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 		return -ENODEV;
 	mutex_lock(&info->mm_lock);
 
-	fb_mmap_fn = info->fbops->fb_mmap;
-
-#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
-	if (info->fbdefio)
-		fb_mmap_fn = fb_deferred_io_mmap;
-#endif
-
-	if (fb_mmap_fn) {
+	if (info->fbops->fb_mmap) {
 		int res;
 
 		/*
@@ -1376,9 +1368,19 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 		 * SME protection is removed ahead of the call
 		 */
 		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
-		res = fb_mmap_fn(info, vma);
+		res = info->fbops->fb_mmap(info, vma);
 		mutex_unlock(&info->mm_lock);
 		return res;
+#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
+	} else if (info->fbdefio) {
+		/*
+		 * FB deferred I/O wants you to handle mmap in your drivers. At a
+		 * minimum, point struct fb_ops.fb_mmap to fb_deferred_io_mmap().
+		 */
+		dev_warn_once(info->dev, "fbdev mmap not set up for deferred I/O.\n");
+		mutex_unlock(&info->mm_lock);
+		return -ENODEV;
+#endif
 	}
 
 	/*
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 3c3cd45c1908f..962a155a5b3d0 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -203,6 +203,7 @@ static const struct fb_ops hecubafb_ops = {
 	.fb_fillrect	= hecubafb_fillrect,
 	.fb_copyarea	= hecubafb_copyarea,
 	.fb_imageblit	= hecubafb_imageblit,
+	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static struct fb_deferred_io hecubafb_defio = {
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 5fd1b33d11238..ccc2e41275dd0 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -915,6 +915,7 @@ static const struct fb_ops hvfb_ops = {
 	.fb_copyarea = hvfb_cfb_copyarea,
 	.fb_imageblit = hvfb_cfb_imageblit,
 	.fb_blank = hvfb_blank,
+	.fb_mmap = fb_deferred_io_mmap,
 };
 
 
diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index f79f8cc41f33b..ed73769f2ecdb 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -563,6 +563,7 @@ static const struct fb_ops metronomefb_ops = {
 	.fb_fillrect	= metronomefb_fillrect,
 	.fb_copyarea	= metronomefb_copyarea,
 	.fb_imageblit	= metronomefb_imageblit,
+	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static struct fb_deferred_io metronomefb_defio = {
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 74a013c398b14..91a5803b2ebde 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1483,6 +1483,9 @@ sh_mobile_lcdc_overlay_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct sh_mobile_lcdc_overlay *ovl = info->par;
 
+	if (info->fbdefio)
+		return fb_deferred_io_mmap(info, vma);
+
 	return dma_mmap_coherent(ovl->channel->lcdc->dev, vma, ovl->fb_mem,
 				 ovl->dma_handle, ovl->fb_size);
 }
@@ -1957,6 +1960,9 @@ sh_mobile_lcdc_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
+	if (info->fbdefio)
+		return fb_deferred_io_mmap(info, vma);
+
 	return dma_mmap_coherent(ch->lcdc->dev, vma, ch->fb_mem,
 				 ch->dma_handle, ch->fb_size);
 }
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 071448eba2465..61c1556bf7c5f 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -780,6 +780,9 @@ static int ufx_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
 
+	if (info->fbdefio)
+		return fb_deferred_io_mmap(info, vma);
+
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
 	if (size > info->fix.smem_len)
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 212494b0a4ba8..1604529a565d9 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -368,6 +368,7 @@ static const struct fb_ops ssd1307fb_ops = {
 	.fb_fillrect	= ssd1307fb_fillrect,
 	.fb_copyarea	= ssd1307fb_copyarea,
 	.fb_imageblit	= ssd1307fb_imageblit,
+	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 3c17049de9540..a16cf3bd6a9a4 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -348,6 +348,9 @@ static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned long page, pos;
 	struct dlfb_data *dlfb = info->par;
 
+	if (info->fbdefio)
+		return fb_deferred_io_mmap(info, vma);
+
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
 	if (size > info->fix.smem_len)
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 37e3f226f78ce..91f0a9ceede1a 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -338,6 +338,7 @@ static const struct fb_ops xenfb_fb_ops = {
 	.fb_imageblit	= xenfb_imageblit,
 	.fb_check_var	= xenfb_check_var,
 	.fb_set_par     = xenfb_set_par,
+	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static irqreturn_t xenfb_event_handler(int rq, void *dev_id)
-- 
2.53.0

