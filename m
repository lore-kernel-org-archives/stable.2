Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E66355F42;
	Fri, 31 Jul 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496257; cv=none; b=bd+fM2YTkUgNc9dREgoxj4Qh020DJDq5GdTRQGkkAT2W9w1r9Pz13TqKARnhkZkxQZEdETXWdPUoqwDm1relZ4/SN74w/EaN1arAbc8qHcctAXsZbgPCf+QNNM1bd1U1w1SoE7KKyRbQSZfYgh+E06a/BKy+u1E0eZApL+0u9nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496257; c=relaxed/simple;
	bh=cGe7uAzZ2izPy4VkXsy9WhDtx96gxPjrNMWHdHZQK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE3ThhdfXeOC1tayqGUsB49GMomjB/eg2ppxaYUlakc1tpcGIkoobDcwG6wDVqQrTOoJzsunWxfi/u66dgf+z8Bz/dOFMZ8P6RZCBi7WfYgByZEzaowAj73jlYSUWp+TRUTd+bQsscASf/pq6/gqyHLNAa/l1oHGjfxgi+R3ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6L9YNwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6L9YNwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472491F00A3A;
	Fri, 31 Jul 2026 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496255;
	bh=ytqivL4jFHX4nTrfGKiLg4ZD46ph+c7BxWubgoutGSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6L9YNwf7IOE8Y7SKl9wy9kaMf4ZUQ/idSSKCL0Umzqx/JlQG5XJ7htEIpx8SoJEg
	 Bt1oCeplePQFH4WZgcdvIeY+aneSr+zcseRLt5PUaqwjyh/yRuVFqXYkKDCeRK0A98
	 G+SzUQXDISUECxdL8diV56hVIFXnTgX8YFiXpnUk2jpIQH8A5H0X18Cd9Ht2f+jh1w
	 oo0GGJswWKi465nW847qOrGH/DxelRnU4BEQeKo6f+UTFTtvAmtXoLAtdYIQX6Le6N
	 j8hdPSugqQ94n++zcl2WjcfY7Y0WOGtbUyfjywj9jPK/rtZl/ew314pt817qRNigfK
	 Ee0sNJJBGI1lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/tegra: fbdev: Remove offset into framebuffer memory
Date: Fri, 31 Jul 2026 07:10:52 -0400
Message-ID: <20260731111052.3596094-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731111052.3596094-1-sashal@kernel.org>
References: <2026072951-goofiness-shank-618d@gregkh>
 <20260731111052.3596094-1-sashal@kernel.org>
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
 drivers/gpu/drm/tegra/fbdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 43a504ad4f38..b7de5819029d 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -75,7 +75,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -112,9 +111,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -126,9 +122,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	info->flags |= FBINFO_VIRTFB;
-	info->screen_buffer = bo->vaddr + offset;
+	info->screen_buffer = bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;
-- 
2.53.0

