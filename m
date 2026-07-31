Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D42448CF9;
	Fri, 31 Jul 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515954; cv=none; b=Sw6N45P2y6chDIzG3SB0thZDD9rrfc5reu1YBuwhJDEKtwlwwbuaSaGhGWssPcdhut3bPCO4xo51sjxj4nHqTPHMJOk6FPqPBGXXDz4sWrt/VZB5IQCqdmyl/7WhzEYu+A15bBzD3UdzwmflptTKpN2zg3n7pKN9dbVHEyUVrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515954; c=relaxed/simple;
	bh=r9GHmiVtwWcs7DPrjdQhWPhhlTDRxEu/vuj19wAJEe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmfiWn1+KzKXatXwo8qYsXrFhhBnhyPvEhyMHnW0s/u0ebtIwkw6FyYT1K+1XTVkCvz4QjD4Rj4mI1sLFN1wZE2uNAV85OdqkvloYZK+eBIvUkxMcrIAM/aeOR4ftb5y5nGdhf46YdrwjcVHaXq2ugyF4w0P7UAg/YZ3e53T4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs99QDGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs99QDGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C181F00AC4;
	Fri, 31 Jul 2026 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515952;
	bh=wfrSPvqP76I9CYztqD7DQbSqJBShjoJiC2ouvz5kFsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cs99QDGBXtlWsMtHdzkKVn43QeRqpUosuT3UCouksk/8Qt6aiTvd2yNsqxBfpw8X6
	 WozQ3p9Mee8rzvwd78eXL+SU3pibpY/kQVPXKiYja3ypFVX7QbOaBDcWBEHTFByosC
	 0UMe8XLgJntX7CEqd2iyFZvePUODPjtJnEEfaHJhUp5FAF8MDimPvfgmc/DQcEpad2
	 SPwtaO8orm3VKkkpFnm/6a1gsSG7Rl7PXeFKcdMDZNoe4YmqQoUDOhmqvEAzgrVk3L
	 EPgFAjW4zZuX5LzbOLGKFaXh44l2kv1O62q6pP+25dvsHFdPIHyVViiY/ldHVHuKk6
	 xWVt6a3KkrClA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/tegra: fbdev: Remove offset into framebuffer memory
Date: Fri, 31 Jul 2026 12:39:10 -0400
Message-ID: <20260731163910.838898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072952-flight-outer-804b@gregkh>
References: <2026072952-flight-outer-804b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit a18b6e30ecd69096beda4a0c96d2570900c3879a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 6e35c7951dfb..daafaea41196 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -221,7 +221,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -267,9 +266,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -281,9 +277,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	drm->mode_config.fb_base = (resource_size_t)bo->iova;
-	info->screen_base = (void __iomem *)bo->vaddr + offset;
+	info->screen_base = (void __iomem *)bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;
-- 
2.53.0

