Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E22877DA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830309; cv=none; b=uWcpt8xE3dy5ZqEMeGBKbs3MiEi2RkVnrgqTjagJQ+HWxNilqx5Kn7ecHWYKr92YDvx5JUB6yOgiyC+wjDqPtOUl6CYG3uqUtER6ldGDT3ErF8JZ53FF9I05A8VjPuHnwV19g6tJSAwacXLG5YiL9CX0JjKDM1DBtsV8pSDHHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830309; c=relaxed/simple;
	bh=uRfPZopfBxXN2uQ8wol4quujI+kpCUbsHgddOgfpTeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS3BUpvVEsTBQhPtnIdoFS5xs4n0nFpLKrdIcLVr+aBWnvsRqdoLKtImpX0g4i9vFkSbJIbAjKMGHcVGu/FX9PGUHQPzR44nmVLE4mj/zrEfEmc3ACQnhec3zORb741jwB+xc7SvuEFfZ2XgTuSEilMzGF8fdThGWY79lJCNrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEo0sYZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEo0sYZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18061F00A3F;
	Tue,  8 Sep 2026 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830300;
	bh=C6belNA4eFuLWfNLznn0jjv8XgGmDFhYrMohoSp9Yns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jEo0sYZzd+P1u6gfeR+zv7WED3mAyfeLHSCadwG1lp8JFc/yo6fomFpv9SWX2wAkV
	 7JQOyPokHaZqt/G7E1rLWLh2Sd715Kczqk/LAcKWV+dqRF3jb1ZSidGXAI7VlasUsI
	 x5H4e2XEtnjmXql07Ubw4PYJgiy6IDm4OkKRePWgVk4eV9GrSnDDQYD8XrCpRp7ZAt
	 YJSCJlbtwAsyA0lqZeT87uhpxImo/sNwXUNF31I7EKXgMxHuYNfTqav5BDzWaOyR8y
	 xAb3650ChHLVgnikp6nPHmfKh9YbGfdRCjUSR0nQufEbQk9aJPKlhgeheivalPBCgy
	 YibELuRKqnGyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] fbdev: Add initializer macros for struct fb_ops
Date: Mon,  7 Sep 2026 21:18:13 -0400
Message-ID: <20260908011815.1729727-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908011815.1729727-1-sashal@kernel.org>
References: <2026090351-mantra-reunion-82ab@gregkh>
 <20260908011815.1729727-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit f1061fa641b8b15c7815d58c20a6c29f2f1f5337 ]

For framebuffers in I/O and system memory, add macros that set
struct fb_ops to the respective callback functions.

For deferred I/O, add macros that generate callback functions with
damage handling. Add initializer macros that set struct fb_ops to
the generated callbacks.

These macros can remove a lot boilerplate code from fbdev drivers.
The drivers are supposed to use the macro that is required for its
framebuffer. Each macro is split into smaller helpers, so that
drivers with non-standard callbacks can pick and customize callbacks
as needed. There are individual helper macros for read/write, mmap
and drawing.

v5:
	* fix whitespace errors (Jingfeng)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230530151228.22979-3-tzimmermann@suse.de
Stable-dep-of: 9ad709afdfa3 ("fbdev: ssd1307fb: defer I2C transfers from damage callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fb.h | 112 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 9b3c198b06826..8ff438fb4d19f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -606,9 +606,31 @@ extern int fb_blank(struct fb_info *info, int blank);
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
+/*
+ * Initializes struct fb_ops for framebuffers in I/O memory.
+ */
+
+#define __FB_DEFAULT_IO_OPS_RDWR \
+	.fb_read	= fb_io_read, \
+	.fb_write	= fb_io_write
+
+#define __FB_DEFAULT_IO_OPS_DRAW \
+	.fb_fillrect	= cfb_fillrect, \
+	.fb_copyarea	= cfb_copyarea, \
+	.fb_imageblit	= cfb_imageblit
+
+#define __FB_DEFAULT_IO_OPS_MMAP \
+	.fb_mmap	= NULL // default implementation
+
+#define FB_DEFAULT_IO_OPS \
+	__FB_DEFAULT_IO_OPS_RDWR, \
+	__FB_DEFAULT_IO_OPS_DRAW, \
+	__FB_DEFAULT_IO_OPS_MMAP
+
 /*
  * Drawing operations where framebuffer is in system RAM
  */
+
 extern void sys_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void sys_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void sys_imageblit(struct fb_info *info, const struct fb_image *image);
@@ -617,6 +639,27 @@ extern ssize_t fb_sys_read(struct fb_info *info, char __user *buf,
 extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 			    size_t count, loff_t *ppos);
 
+/*
+ * Initializes struct fb_ops for framebuffers in system memory.
+ */
+
+#define __FB_DEFAULT_SYS_OPS_RDWR \
+	.fb_read	= fb_sys_read, \
+	.fb_write	= fb_sys_write
+
+#define __FB_DEFAULT_SYS_OPS_DRAW \
+	.fb_fillrect	= sys_fillrect, \
+	.fb_copyarea	= sys_copyarea, \
+	.fb_imageblit	= sys_imageblit
+
+#define __FB_DEFAULT_SYS_OPS_MMAP \
+	.fb_mmap	= NULL // default implementation
+
+#define FB_DEFAULT_SYS_OPS \
+	__FB_DEFAULT_SYS_OPS_RDWR, \
+	__FB_DEFAULT_SYS_OPS_DRAW, \
+	__FB_DEFAULT_SYS_OPS_MMAP
+
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
@@ -683,6 +726,75 @@ extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_fsync(struct file *file, loff_t start,
 				loff_t end, int datasync);
 
+/*
+ * Generate callbacks for deferred I/O
+ */
+
+#define __FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, __mode) \
+	static ssize_t __prefix ## _defio_read(struct fb_info *info, char __user *buf, \
+					       size_t count, loff_t *ppos) \
+	{ \
+		return fb_ ## __mode ## _read(info, buf, count, ppos); \
+	} \
+	static ssize_t __prefix ## _defio_write(struct fb_info *info, const char __user *buf, \
+						size_t count, loff_t *ppos) \
+	{ \
+		unsigned long offset = *ppos; \
+		ssize_t ret = fb_ ## __mode ## _write(info, buf, count, ppos); \
+		if (ret > 0) \
+			__damage_range(info, offset, ret); \
+		return ret; \
+	}
+
+#define __FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, __mode) \
+	static void __prefix ## _defio_fillrect(struct fb_info *info, \
+						const struct fb_fillrect *rect) \
+	{ \
+		__mode ## _fillrect(info, rect); \
+		__damage_area(info, rect->dx, rect->dy, rect->width, rect->height); \
+	} \
+	static void __prefix ## _defio_copyarea(struct fb_info *info, \
+						const struct fb_copyarea *area) \
+	{ \
+		__mode ## _copyarea(info, area); \
+		__damage_area(info, area->dx, area->dy, area->width, area->height); \
+	} \
+	static void __prefix ## _defio_imageblit(struct fb_info *info, \
+						 const struct fb_image *image) \
+	{ \
+		__mode ## _imageblit(info, image); \
+		__damage_area(info, image->dx, image->dy, image->width, image->height); \
+	}
+
+#define FB_GEN_DEFAULT_DEFERRED_IO_OPS(__prefix, __damage_range, __damage_area) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, io) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, cfb)
+
+#define FB_GEN_DEFAULT_DEFERRED_SYS_OPS(__prefix, __damage_range, __damage_area) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, sys) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, sys)
+
+/*
+ * Initializes struct fb_ops for deferred I/O.
+ */
+
+#define __FB_DEFAULT_DEFERRED_OPS_RDWR(__prefix) \
+	.fb_read	= __prefix ## _defio_read, \
+	.fb_write	= __prefix ## _defio_write
+
+#define __FB_DEFAULT_DEFERRED_OPS_DRAW(__prefix) \
+	.fb_fillrect	= __prefix ## _defio_fillrect, \
+	.fb_copyarea	= __prefix ## _defio_copyarea, \
+	.fb_imageblit	= __prefix ## _defio_imageblit
+
+#define __FB_DEFAULT_DEFERRED_OPS_MMAP(__prefix) \
+	.fb_mmap	= fb_deferred_io_mmap
+
+#define FB_DEFAULT_DEFERRED_OPS(__prefix) \
+	__FB_DEFAULT_DEFERRED_OPS_RDWR(__prefix), \
+	__FB_DEFAULT_DEFERRED_OPS_DRAW(__prefix), \
+	__FB_DEFAULT_DEFERRED_OPS_MMAP(__prefix)
+
 static inline bool fb_be_math(struct fb_info *info)
 {
 #ifdef CONFIG_FB_FOREIGN_ENDIAN
-- 
2.53.0

