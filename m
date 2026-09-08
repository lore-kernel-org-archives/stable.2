Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF7258EF3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829550; cv=none; b=m85SlTzpcsVNjOnJ+rxEQmxlItUY51dmemnL4dUlplzlvpP3iGucSLcBGWUgUbJEuBZvhQOobp3Y/zNb13Honx2KhV1N1qtLntMACqLkkRdXt2lhupYHmB3SA2JQuO0veCNOVzmaUVgf7b5MbmBIwYTmTjrLCTtWsSOcF3Q3BmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829550; c=relaxed/simple;
	bh=cWY+uaejsE+BB7W4oA1tJwWTeEO+kezkcjzAJS1vkwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrX/DhoXMF2C2kaa54EuUioFzrdOBFo35fQrHOa/Q3yayh4fgiCxV+k6jhMDUkMXTfBNkhY+kumXEt1V4U+UnGqjVnCzo1x33gcsVyrxs7vy2mIGsKzMn4+uuJpu1xXcbkLsyd6VP7G0pYhCKL2Exkb1ciw90371hQOG6rWxs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iax//Q2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iax//Q2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9601F00A3E;
	Tue,  8 Sep 2026 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829548;
	bh=vPBTkhUnnsvAUjIyKGJ5buJxqrmwqNVK8GFgx8LwgCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iax//Q2ijbfXU1c73NpTy6KMq/ItC5r26xKpGMBECjXvRi8MAUm4fupdX9SFQ+Kio
	 uUo7KB7nYNWdYeNSlx0XqoNA0w2IiveTdhHVohQ3zfjezUdsx9oJKKd1tgoaNSIXVl
	 sLvCarBON8aLO/41hij/2AmO0+zHBS7KJJKD9S2R1Iem6+Nb+v8Yd/XeuUMMQ4c0Ud
	 ah3qyeXnl5g9os6HqNoIn7VrlKh6Ztm4Q5Gxa22KuMbVE+ymwJvqip2aqEImU5j1qV
	 Vs63otuRsdhgq8zUBjZdoSrbkPwshmJEwkxdbXG3toBIqYfXbMg1BhDTLohD6kwSY4
	 /1LJGYriEgw+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] fbdev: Validate info->screen_{base, buffer} in fb_ops implementations
Date: Mon,  7 Sep 2026 21:05:42 -0400
Message-ID: <20260908010545.1675830-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908010545.1675830-1-sashal@kernel.org>
References: <2026090350-babble-bobbing-7765@gregkh>
 <20260908010545.1675830-1-sashal@kernel.org>
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
index 23e6cc5172d7f..19f5abd06907e 100644
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
index c694ab918978f..4c6c42e2d32f7 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1013,6 +1013,9 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
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
index bd0be854b1161..a43812a2dfec7 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -768,7 +768,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || ! info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -777,6 +777,9 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(info, buf, count, ppos);
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -833,7 +836,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -842,6 +845,9 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
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
index 17307c00d46f0..eba185b58f0ce 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -523,6 +523,9 @@ static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 0bb464310e640..955c35352c220 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -647,6 +647,9 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 	struct page **pages;
 	int ret, i;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	nr_pages = (count + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_KERNEL);
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index b1bccb5f83e09..88f898580a68d 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1028,7 +1028,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
@@ -1091,7 +1091,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index b9fefa844574e..7620c6913520a 100644
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

