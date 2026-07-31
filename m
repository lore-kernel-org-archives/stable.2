Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176740B10A;
	Fri, 31 Jul 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517026; cv=none; b=NiApzmJmDK5uAZ2PK0r2MqYV4xL5qqNRkFwZT9tdwQHNENNyAmU/mCMaK9krogTtt1f7ak5GLLbYEsOpC1ITlw+kuBEpY/axqSyyOOcvNNvHpOaEFonBlVc4ZLl9ou7D8c/FItRt6UPtUXxjxuk9xtVvsrE8wt3jVwn4xiySqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517026; c=relaxed/simple;
	bh=BG9oOIacRYK45+kIGX2Q5F6SUe2OjIVsTc9TQPgfCz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5LsvchQPtnICGoGGhGEBcJ7/a4vERHyXcXeTul478Trz0XHnaEu15Ckb+bstYtKDmVLyyZiTfT3jewuDOKBOOwnrwnTBkvO8bBzWXDyUdUqF7vO/rUXIaB9qlsMGyu7aI8glkmRPYq0GiN5aOWQJGvOW13cv+nt/+86XH4v63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojjr2Zb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojjr2Zb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D291F00AC4;
	Fri, 31 Jul 2026 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517025;
	bh=JSTF/EhiF+zzML7dVZ1u233Db9xYX6dDelyLsh+FPKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojjr2Zb8944aUVNtUkEB8cWTCyAvPlq4E3o1I1T+aR9xvR+FFoDREB4njyk+jIBtj
	 qaLDfz3AytRYElepxv4Ozkur9JkyXwt6foKd0u/LfGFHQz/NAC7jgW+WKABY2ri5HR
	 nY1OJ2M9d4r5xGlly1p0/WNp76AxZZGWNm51ZeQP7aGApdiuNO2haQFzYkJIF6rU1M
	 PVHY/Y+Ui/FM6SyKApIZmzCnLxzHGCNal2N+C4wHZQaV88Xbq49JMoqQDj3BYfVt+z
	 bSehDEK3iSwGEH9GaJjPhaUyinDMp1f3mARtU4zHSq4PvkV9CntV17I6kcUGJZcJT3
	 potAUUvW21WSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/tegra: fbdev: Remove offset into framebuffer memory
Date: Fri, 31 Jul 2026 12:57:03 -0400
Message-ID: <20260731165703.883481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072953-ramble-ravage-32ab@gregkh>
References: <2026072953-ramble-ravage-32ab@gregkh>
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
index 2040dbfed7e2..ab88a53d07c5 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -211,7 +211,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -257,9 +256,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -271,9 +267,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
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

