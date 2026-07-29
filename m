Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEB3DB63C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321314; cv=none; b=DAG29vJobzNRADgVOETLWxaKvOFe0srw39hMwQRe43DynTQyauEaEpGp514OvZYZvgg1SQir/3N39CqbIJSm8BxvgLMkQUPFs2LC+PVluy1dbhm5Gzl204WhZEyPqZYtBR/hhIFhLgjH5GBpdMYipg6PhiIpaqRagwIJuD6H0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321314; c=relaxed/simple;
	bh=BmzzJFEhwZunE3LGS5gHFFh2w5vlC04S3lJ2erJswS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q7P8L306Enjch4n4y4RIcil8zm7Oq7jU92W36y7JZOM+l+1t6t524xMmROFZvqhQxZrM7dGO+n18WkiNSOvt0zKkB9axQvBl84r31SJxxy6qBqS7ndl/v71VwAOmwATQy9wvisw8kY/B6v+2ztD9NRl4xhFpq+6IMxlSCWbLydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AZxR8bxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AZxR8bxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10221F000E9;
	Wed, 29 Jul 2026 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321313;
	bh=5/UCmr5SXCa1UH4WOMog55mm7ckNxzfQlSxQ3aE16Yg=;
	h=Subject:To:Cc:From:Date;
	b=AZxR8bxaIPYaidyXuJF+QaaNFmO8z7MFRArR8MMIjZ/d4LIvN53yak/zuPUAVRenE
	 oz/vlQJbfya91wMkp0hknbrmMMjg2rs3jWgktQ8z7pbRMGFQN8ZNrmtCehf+R6D26D
	 faVj8GY10v02/AjkKQhuFgGbMROPZyYsDy4F/g0M=
Subject: FAILED: patch "[PATCH] drm/tegra: fbdev: Remove offset into framebuffer memory" failed to apply to 6.6-stable tree
To: tzimmermann@suse.de,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:34:52 +0200
Message-ID: <2026072952-backward-riveting-1863@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a18b6e30ecd69096beda4a0c96d2570900c3879a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072952-backward-riveting-1863@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

