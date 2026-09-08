Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7A175A79
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829549; cv=none; b=oME+fmiwy8rKZVqXDuqoOBtD+qtSntWjo32xKQjQ6rMWRF1Z3ZMRfw5eD8EeCvF5j/xQvG6C5Ux3IYRCs0LUkRhFRsaxKmW3i9jMhmFh6Pewszxc2EbSf+R+/Bt3ld4qnYR2uQweY1swcziYFsplA/Rt1Xpuh8MQ6KK+iVb2igU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829549; c=relaxed/simple;
	bh=9S0miCU7FhMzRZGx1453B9FCaOB+CAVxMI3+NrJnzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQbpQUsvnwKpRv+drFJH8oBYenVIWBq1N2x//jydobPo7CEZt4+maaWkoXAPgjp5TS2oJbEBWUK0Z91CTnL5zxdvpLDkOYbSw5U5rioHRJwXo9zg/t6IpyZIQ8tXgZRmFpYmVPERvgNtBl6CusLgzOwEK3GSUqlNtWClHq6SrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAc5Va37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAc5Va37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C001F00A3A;
	Tue,  8 Sep 2026 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829547;
	bh=5cljCWM+6ZNyrG4bZJae8SRQwZZF1atLINk+id9ndfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAc5Va37buvvtWKSlLqFwih/bZp6ExeewWw9daSwBhYQgm5L4LWVWKtowxI40ALuE
	 q21mRJ07Yl8uHYNPC2jouGNUsALpi/5Ucc09O8jdu0wsttVU11lrMAY/dMSGV1yeyA
	 wn6As9/U79Hni3wb9A++KxuipD1LV0/nK0bm/TiHDwh6VWVA5OUMTQEcKF9VV/e68D
	 fguI/XWTF2Xg7I/9PfubYQV8wbrwuRTyzkBqRN0dhgrGGl+nVC6rFSc9ue4kgcGh8K
	 v2BSARsf+TAewWyDqgKNnEU6FHcJV9dwyD2AcIHXs+biDACdD08AbcPmqzEXXseJuR
	 qDsYfR/1AABdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] fbdev: Don't re-validate info->state in fb_ops implementations
Date: Mon,  7 Sep 2026 21:05:41 -0400
Message-ID: <20260908010545.1675830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-babble-bobbing-7765@gregkh>
References: <2026090350-babble-bobbing-7765@gregkh>
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
index a642becdc0d73..23e6cc5172d7f 100644
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
index 49296ea9926c3..c694ab918978f 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1013,9 +1013,6 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
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
index dcfbcb7523ad1..17307c00d46f0 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -523,9 +523,6 @@ static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
 	int err = 0;
 	unsigned long total_size;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->fix.smem_len;
 
 	if (p > total_size)
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 3baf33635e65f..b1bccb5f83e09 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1031,9 +1031,6 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -1097,9 +1094,6 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
 	total_size = info->screen_size;
 
 	if (total_size == 0)
-- 
2.53.0

