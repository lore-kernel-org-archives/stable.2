Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AC2D0620
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830303; cv=none; b=jFsftJZjqt5+2brGwgfxtk+OHzkJ4MyIkxEoc0958VPTffh940FVZGu+L9HAE64Y/kOk+wGRjYng4XH89aWMi8FbiKstb0d+wbzAF0JMSvnwl4Rwq4t2XloiFYrx6ixodQjZ71t92/mCazQdtUTKa0ejDrUdehE+ew8vM6JbAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830303; c=relaxed/simple;
	bh=M43bou+976WUycqhmDwZMnmHEQbae3gQAxfcgJYVeD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWHhFsTlz5U22yrLxDJMz9nvOS3GZoKXmDKp+EywlN+8BqGaN01K3mQeDtA2OZj6jTAMYWirdrdHCCM0+DJHB2MpUL4BSlNI6CalXtGWWVPLhZgPDYWoKavQ7VkPw/8wL5y5LhKWgdPCHb3ZTz3/xthXsXfEr5eBE+5/h3J7ciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBDEjxpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBDEjxpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8801F00A3E;
	Tue,  8 Sep 2026 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830298;
	bh=IzImFG3dByL9secrTBrwqbsHsXTB9w6W1+2mA0HjAw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBDEjxpQ0E6yMIoBXWlkdbARijIVXkegvz2j6Kf+k5GlJHpCdoWo6JCERPiPBS3wU
	 6dzDpn6jV9QUE65Yp/0H+9tEQjQ0xfCBFM15y89KPrUqYQWNrznd8dgg7swRTy2VMy
	 T3gzdTTOpj9PeH3hfiEN6fybbXhtIT2QJg4ICJq5WNIiobj84bsaq1Dj28b1XKCd0S
	 b8E2Dsy7smh3EW32UHBe5uRy2Mgkbt6Z/nEg6gw4lnnULV0kmXuStQsxDnxyh7nXdM
	 qgs7/R2vYErqFqJId/hR0JU1wlmY7KEWW4lZ5JpBK2ybAUEk9NCkdLA8b0BoRCupbF
	 p7yyTIA0XizXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] fbdev: Don't re-validate info->state in fb_ops implementations
Date: Mon,  7 Sep 2026 21:18:11 -0400
Message-ID: <20260908011815.1729727-2-sashal@kernel.org>
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

[ Upstream commit 453bd91302f16ddb8a2f5eb3df9fda3206dbacef ]

The file-op entry points fb_read() and fb_write() verify that
info->state has been set to FBINFO_STATE_RUNNING. Remove the same
test from the implementations of struct fb_ops.{fb_read,fb_write}.

v2:
	* also remove test from ivtvfb, braodsheetfb, hecubafb and
	  metronomefb (Geert)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230428122452.4856-17-tzimmermann@suse.de
Stable-dep-of: 9ad709afdfa3 ("fbdev: ssd1307fb: defer I2C transfers from damage callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtvfb.c        | 3 ---
 drivers/video/fbdev/broadsheetfb.c     | 3 ---
 drivers/video/fbdev/core/fb_sys_fops.c | 6 ------
 drivers/video/fbdev/hecubafb.c         | 3 ---
 drivers/video/fbdev/metronomefb.c      | 3 ---
 drivers/video/fbdev/sm712fb.c          | 6 ------
 6 files changed, 24 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 1f8b8caa69bdd..96be1612d1f85 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -378,9 +378,6 @@ static ssize_t ivtvfb_write(struct fb_info *info, const char __user *buf,
 	unsigned long dma_size;
 	u16 lead = 0, tail = 0;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index fd66e18fd58a5..31fc7f76af772 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1014,9 +1014,6 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index ff275d7f3eaf1..facf47a69483c 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -21,9 +21,6 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -61,9 +58,6 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 962a155a5b3d0..f6be62ed42c5a 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -163,9 +163,6 @@ static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index ed73769f2ecdb..23a3388880e79 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -524,9 +524,6 @@ static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 092a1caa1208e..41107d216b625 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1030,9 +1030,6 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -1096,9 +1093,6 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
-- 
2.53.0

