Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3F395AF4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321320; cv=none; b=l6J7y1C9R+ZqiZ7hCSXzI945iwZePDOxDw7spFczuKZoPOUIGhMHnlLMLIniM2BCjHa60vRyKSsWKCR5qzTR89X5w6LW33QQjPxauzm5Ux0sJWH35Me3fBjcsCWSpfvEdMEK9gg0NaIpSiaA8XQzW+qiEC9tm6XgUkJYccYwmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321320; c=relaxed/simple;
	bh=rV+sOCLruTY2AmaAIO87qLp1tLUpNQ7aATINwaxBuZc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mZVxs6PpVln7eyIASzV3oonDLArZd0gGeT1BW2kJHEwM46U8NJGwBK2dk6QVq51nE8gqhFfhSclP3iQMSZmf9/WF1HARJkWbEM1h1iKtXBnLRQim1f4a6E5GVbBrdD4Z6vkQ4c6JgTxojhDsD9/DLOM9CQBNVu57A1A8hAQfWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17FdqOat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17FdqOat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2101F000E9;
	Wed, 29 Jul 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321319;
	bh=ow2wjDYtfRyBgUIq+MPZa/GqIyDgHvfJ6OjCl0JWzUQ=;
	h=Subject:To:Cc:From:Date;
	b=17FdqOatF1WVLRIMDj+beTEeZUfFXGNByk0kcCP/4Hwuzg5KiSQXh8f9NrmdrQbOS
	 BBbauDJGeB5tvQNLppFS5luhEB4aMqYvtZvGZL3i4w7Tc4EOl5eJE5Mna2Cu5yhtpV
	 RH/hya33EIRNvD6VHDwUhqAjRgVBKCxObB7xSn+4=
Subject: FAILED: patch "[PATCH] drm/tegra: fbdev: Remove offset into framebuffer memory" failed to apply to 5.15-stable tree
To: tzimmermann@suse.de,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:34:52 +0200
Message-ID: <2026072952-flight-outer-804b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a18b6e30ecd69096beda4a0c96d2570900c3879a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072952-flight-outer-804b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a18b6e30ecd69096beda4a0c96d2570900c3879a Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 21 Apr 2026 09:29:06 +0200
Subject: [PATCH] drm/tegra: fbdev: Remove offset into framebuffer memory

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20260421073646.144712-3-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 19e39fa54bfa..793849199783 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -76,7 +76,6 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -115,9 +114,6 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -129,9 +125,9 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	info->flags |= FBINFO_VIRTFB;
-	info->screen_buffer = bo->vaddr + offset;
+	info->screen_buffer = bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;

