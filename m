Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDD2D0C7E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830306; cv=none; b=F0HQyZ0iSINH98zW+o5C8WFwmRUiXNhlvqyl9gpHYsqNhd1FPisUcm+3CqsUtklIAcHBSM1L1r5rv5MzyQFQE2gFfSN1/f3/cXbTUUAWMPP7G5rrAE7rSDeGgu93frpk1YeMusHxnZs2FiRKXq3Qjkh8TCg4FufKN0pDT5lVKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830306; c=relaxed/simple;
	bh=20JsNqo+/HmaRF1Ch/oVYuCe2UmQFRTwAMZJ+UU48Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZvYg55r8fArFl7gDBhPQxjTqwc/i+lKPH8NeFOuvR9Or3DLblNqf9PkI30JHzbsCtIXW+3i7VVRIqh1r/GE4BEi0pJgfPXrM7eXawS0laTAqxjPY1jkbuU/J/AEl24vyyU9AQSpvde8C5GfuLoGw/ndK9f+H3auf0fpRvlJbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd2fwtTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd2fwtTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0B41F00A3D;
	Tue,  8 Sep 2026 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830299;
	bh=79Ei4E06ygwOO87qgbAj018i0vMCu3PFYIJ6wOke5Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kd2fwtTYuenY1V+3aWLPsEzbxT8UraPrezd6Rd4Uh2gJOnaNTJnLbKvmXbvtSk5e/
	 qs1jhErPiVtcEARzNARjgMnjZtSj8fsJDrP4NlQS5sTUOXIgTgxAp91BS/QN9sPjpZ
	 V5VN/QHE4lz0mbRhPG12LH5kEmyFr5Tva+xZOjwEFvTN593hIv7nxk2zVvatusc08l
	 eLIGlW5M9llpYdUk49Co6tTpXZWULaEAYxGlatiGqZfbuskWqOg0J8TwX/7nLBLHMk
	 x2PW0V0W0rG73XqWPsnCBV5wFyM4rv7BMa02lLp/c9NwFOkuGiDkaAuobj/ZV/mK4F
	 Na5qqnmoBemkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] fbdev: Validate info->screen_{base, buffer} in fb_ops implementations
Date: Mon,  7 Sep 2026 21:18:12 -0400
Message-ID: <20260908011815.1729727-3-sashal@kernel.org>
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

[ Upstream commit 3f8974f68f408f4983443b745a3cf95b06112469 ]

Push the test for info->screen_base from fb_read() and fb_write() into
the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
the driver operates on info->screen_buffer, test this field instead.

While bothi fields, screen_base and screen_buffer, are stored in the
same location, they refer to different address spaces. For correctness,
we want to test each field in exactly the code that uses it.

v2:
	* also test screen_base in pvr2fb (Geert)
	* also test screen_buffer in ivtvfb, arcfb, broadsheetfb,
	  hecubafb, metronomefb and ssd1307fb (Geert)
	* give a rational for the change (Geert)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230428122452.4856-18-tzimmermann@suse.de
Stable-dep-of: 9ad709afdfa3 ("fbdev: ssd1307fb: defer I2C transfers from damage callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtvfb.c        |  3 +++
 drivers/video/fbdev/arcfb.c            |  3 +++
 drivers/video/fbdev/broadsheetfb.c     |  3 +++
 drivers/video/fbdev/cobalt_lcdfb.c     |  6 ++++++
 drivers/video/fbdev/core/fb_sys_fops.c |  6 ++++++
 drivers/video/fbdev/core/fbmem.c       | 10 ++++++++--
 drivers/video/fbdev/hecubafb.c         |  3 +++
 drivers/video/fbdev/metronomefb.c      |  3 +++
 drivers/video/fbdev/pvr2fb.c           |  3 +++
 drivers/video/fbdev/sm712fb.c          |  4 ++--
 drivers/video/fbdev/ssd1307fb.c        |  3 +++
 11 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 96be1612d1f85..302a8a6bdeb0f 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -378,6 +378,9 @@ static ssize_t ivtvfb_write(struct fb_info *info, const char __user *buf,
 	unsigned long dma_size;
 	u16 lead = 0, tail = 0;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 024d0ee4f04f9..69a6cda61cebe 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -451,6 +451,9 @@ static ssize_t arcfb_write(struct fb_info *info, const char __user *buf,
 	struct arcfb_par *par;
 	unsigned int xres;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	p = *ppos;
 	par = info->par;
 	xres = info->var.xres;
diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 31fc7f76af772..277d24bc5d3da 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1014,6 +1014,9 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 5f8b6324d2e8c..26dbd1c78195c 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -129,6 +129,9 @@ static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
 	unsigned long pos;
 	int len, retval = 0;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	pos = *ppos;
 	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
@@ -175,6 +178,9 @@ static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
 	unsigned long pos;
 	int len, retval = 0;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	pos = *ppos;
 	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index facf47a69483c..432fa3fa7fa13 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -21,6 +21,9 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -58,6 +61,9 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 78303cf740701..30edc0bee60cb 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -770,7 +770,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || ! info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -779,6 +779,9 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(info, buf, count, ppos);
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -835,7 +838,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -844,6 +847,9 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(info, buf, count, ppos);
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index f6be62ed42c5a..98e224a9641c7 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -163,6 +163,9 @@ static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 23a3388880e79..417371de6b23e 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -524,6 +524,9 @@ static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 3622254349120..0a27a980524c2 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -646,6 +646,9 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 	struct page **pages;
 	int ret, i;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	nr_pages = (count + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_KERNEL);
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 41107d216b625..efaec92ed71fb 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1027,7 +1027,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
@@ -1090,7 +1090,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1604529a565d9..82f41770ca205 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -301,6 +301,9 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	void *dst;
 	int ret;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
-- 
2.53.0

