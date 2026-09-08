Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17402BE05A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830309; cv=none; b=mB2rGbNJp7WoYd39IETk48RNFmvlMV/MlWFfytBT8O9s49ENOpZesMqKVSH81yOCBSZ6Zi1mxw2kaXnsV5k65VZIJ9ndJPUBukmOtAt0ucQk/gPLIxo+u5TARJyfA8AxRde98/H3WekTFyZmL7JfvMgoFaoX6B1rSWLAvn9Vxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830309; c=relaxed/simple;
	bh=iIIqYmV9GWOoGjkXF4SUVCN7Xngma1385uLs5nhjY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZXu7OQ3tblmi/55K4rkI/To74Cy8vFjgB+9Er8ZVN+djHHt8FOtl7XzAqIOJr6UXoDDegxQ34omnD98aFtnQJlHAUralqWxOEpM555vfrxlB3+aiG3XZ0tpjLnwdJZue/QjiB3ZXQZSucnWDqvomLG4TDIQqioqPIw6r1jU+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKy271M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKy271M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0741F00AC4;
	Tue,  8 Sep 2026 01:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830300;
	bh=HsoEK3mZK95lEfaHjkpTqvVKwi+1g8zx5uAaXFkulXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKy271M8x7G6wccuKbuWWnHyGESorBEolQ5SiBpEXSD0WrsPtuwuRqq5HGFJnMHDZ
	 0/rC/3wlopKur6rf6fVZH9zYgtEoFqeU/DFSuPh5uaifchdwSmHaUm1yMf8d7n24YV
	 MZ2GRQl9XsTdUOBK0pZMgQsxNtM+V+Df+CQKBgtZXpooHu3sKr0hrbuI+ZyrYr3HPy
	 EHQ3GkHmnIeo5DdyAdZzakJ90JHOwibAjUBsHdaSXXHKz2EDZVZfGSebTeYZcosdMU
	 IMg4LIM7TB3TBJ1wU8vFoMl2dCyky+f9VC3sU+334Co0bG3qpQqTIPlNiIzyWoQWfB
	 KSSG7KVMGtREw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] fbdev/ssd1307fb: Generate deferred I/O ops
Date: Mon,  7 Sep 2026 21:18:14 -0400
Message-ID: <20260908011815.1729727-5-sashal@kernel.org>
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

[ Upstream commit 417218ae730b4802419b36d3449eb7435fcec7c1 ]

Use the existing generator macros to create deferred-I/O helpers
for ssd1307fb and set them in the fb_ops structure. Functions
for damage handling on memory ranges and areas are provided by
the driver.

Ssd1307fb's implementation of fb_write writes to system memory,
so the generated code can use the respective helper internally.
This also fixes a long-standing bug where fb_write returned an
errno code instead of the number of written bytes. See the commit
message of commit 921b7383f348 ("fbdev: Return number of bytes
read or written") for more details.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230706151432.20674-9-tzimmermann@suse.de
Stable-dep-of: 9ad709afdfa3 ("fbdev: ssd1307fb: defer I2C transfers from damage callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/ssd1307fb.c | 69 ++++++---------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 82f41770ca205..8941f65e34d1e 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -292,43 +292,6 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	return ssd1307fb_update_rect(par, 0, 0, par->width, par->height);
 }
 
-static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
-		size_t count, loff_t *ppos)
-{
-	struct ssd1307fb_par *par = info->par;
-	unsigned long total_size;
-	unsigned long p = *ppos;
-	void *dst;
-	int ret;
-
-	if (!info->screen_buffer)
-		return -ENODEV;
-
-	total_size = info->fix.smem_len;
-
-	if (p > total_size)
-		return -EINVAL;
-
-	if (count + p > total_size)
-		count = total_size - p;
-
-	if (!count)
-		return -EINVAL;
-
-	dst = info->screen_buffer + p;
-
-	if (copy_from_user(dst, buf, count))
-		return -EFAULT;
-
-	ret = ssd1307fb_update_display(par);
-	if (ret < 0)
-		return ret;
-
-	*ppos += count;
-
-	return count;
-}
-
 static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 {
 	struct ssd1307fb_par *par = info->par;
@@ -339,39 +302,29 @@ static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
 }
 
-static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void ssd1307fb_defio_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct ssd1307fb_par *par = info->par;
-	sys_fillrect(info, rect);
-	ssd1307fb_update_rect(par, rect->dx, rect->dy, rect->width,
-			      rect->height);
-}
 
-static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
-{
-	struct ssd1307fb_par *par = info->par;
-	sys_copyarea(info, area);
-	ssd1307fb_update_rect(par, area->dx, area->dy, area->width,
-			      area->height);
+	ssd1307fb_update_display(par);
 }
 
-static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void ssd1307fb_defio_damage_area(struct fb_info *info, u32 x, u32 y,
+					u32 width, u32 height)
 {
 	struct ssd1307fb_par *par = info->par;
-	sys_imageblit(info, image);
-	ssd1307fb_update_rect(par, image->dx, image->dy, image->width,
-			      image->height);
+
+	ssd1307fb_update_rect(par, x, y, width, height);
 }
 
+FB_GEN_DEFAULT_DEFERRED_SYS_OPS(ssd1307fb,
+				ssd1307fb_defio_damage_range,
+				ssd1307fb_defio_damage_area)
+
 static const struct fb_ops ssd1307fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_read	= fb_sys_read,
-	.fb_write	= ssd1307fb_write,
+	FB_DEFAULT_DEFERRED_OPS(ssd1307fb),
 	.fb_blank	= ssd1307fb_blank,
-	.fb_fillrect	= ssd1307fb_fillrect,
-	.fb_copyarea	= ssd1307fb_copyarea,
-	.fb_imageblit	= ssd1307fb_imageblit,
-	.fb_mmap	= fb_deferred_io_mmap,
 };
 
 static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
-- 
2.53.0

