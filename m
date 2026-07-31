Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8C44E66F;
	Fri, 31 Jul 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515126; cv=none; b=DXll+2wSq4/+McTm3pJAxX3O5G3z3wO1Bm75o3KAJLbpuwANHbqmJbU0Hox5QFgrq2/07nomJfuTlYvzefGlDkCHuCoL14fVxKdkMt96EBkXde4tjizKg6fKDEvo8C+6mKbrb7oId5t6A5k+20mYR8ku9LHkg1AXVMr66xUUhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515126; c=relaxed/simple;
	bh=g6xtt/5sLStLwyFKitjzivjsR2X+J8xLLp1+0dqxJzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhAT1C+IL81hcDqzWF2QUa7pm4j/9IugMBXfB01fIh7uFGwBgJh/tIVuDRgvxfhpIDNtXXgtKc/Z9qjh2s7awTGv8AXkga+lxAHL8XvWSU7CF76kxY36/DSp3NBMbCTBuCdem9kbXr6dA2yGEj8cG11zeARc3C6jM9EeTKrfYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8WZ2Mdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8WZ2Mdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C231F00AC4;
	Fri, 31 Jul 2026 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515124;
	bh=qRhySz1J3Xbd5u37NW2FVEjEd3J3Cx5EVCKmCyPeBzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8WZ2MdlDsoxXCCMArFYBJqUKgtIg7/qT4vBPRWRv8o8610ApBOJP+o7i6aUGXBs9
	 apI8fgymoGof+lF59FtAyzdQY8hMaq+OUq/YwxgiS206mMpLiDQdSNBaxbVp/8anVn
	 6yAIWnA+ZkLhBs1DbyqpxBKj7W2VgWSrU0ASz1WJPqvn2HWj3pVo+4Bb7FeKtRFux1
	 sCP3cTg+Hzs6jo2zN/Cc1Byr2eK+2O4i0DbYs0UFJW0VbJYFHD3DimxWyLkKD6DE9b
	 326qkCs6CBWdRj/bqCN2qahqS+7ysswDkKAuBhmQDsi3+cz3ILsC1of70ydU8BVK1Z
	 Ct1Ryv54Q5W7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/tegra: fbdev: Remove offset into framebuffer memory
Date: Fri, 31 Jul 2026 12:25:21 -0400
Message-ID: <20260731162521.789037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072952-subtext-celtic-af7b@gregkh>
References: <2026072952-subtext-celtic-af7b@gregkh>
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
index a688ecf08451..b054311f6869 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -222,7 +222,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -268,9 +267,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -282,9 +278,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
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

