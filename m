Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813B30B502;
	Fri, 31 Jul 2026 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465666; cv=none; b=XbUeXRf3D6S4dAQOi6k8vBMXbHOm5GeLNl/txJiJhAzy516tNtrr9zD9d4bXiue3vmeYukD2/sMGXtaAU+IwtbCwNwygQ2MCcthsXAY+LeU8NijQTC8fADJW81a3NwelH0BSNrfLIKVSh2cDFNz/0oiZr87gCE1fvnng1Z+jdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465666; c=relaxed/simple;
	bh=4q5DOiZATlLzvrPR60tHia90+pQ1RdRgj/4XMXp3k8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MByYgsvSqFN+t4oCSNz7HoFXJVazIm83fohIISg1ghhrgmlhKjY2/w3xKHQyXU/uSdjFMiBgoDXfTN1QX77IS0ozOXSK2Qmu9j2KPCwpOanNb7cryZDZo9n9khAmEZuBRPE18TxOmWzsvkq5QIy+79Gr+ZQxXW3ypcYrxfPGiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO5fgI7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO5fgI7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DE31F00A3D;
	Fri, 31 Jul 2026 02:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465664;
	bh=wpGbo/T2vqfHpg6x90ZTuSPiFWtovciDxmqa911luyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CO5fgI7MK8ErDZadE1tEjj/9J4h4tFauFIJGyRUDkla6ZmZWjTFqj6LKqA/M488qr
	 1Q2XDKzzTs9UcLGh1BpANMo3uzo3fhjWPs8AlE/ibCcGY/ALilyAo0LRIB7MOxEQqb
	 RVlODnk5PHpksjEP4h+QzLTa19ZRR6OVutiF59wiwgo+R1Q2j+XjbJ3SA4n7VG8d2h
	 PQgM7Da4X8BKex3fBTlPBcfz76BrHBdmD6yP4MyPr4255CwgzjX2wmgxXYm3swNKZz
	 TPTOR0bzMydiWf+8Zj7KoJoT3g5L54xEozIe3Is0RyKHqyvJF7EqAp2dx6kvRmOYum
	 7LKsv97HJHXcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/tegra: fbdev: Remove offset into framebuffer memory
Date: Thu, 30 Jul 2026 22:41:01 -0400
Message-ID: <20260731024101.3339564-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731024101.3339564-1-sashal@kernel.org>
References: <2026072951-strategy-rage-af59@gregkh>
 <20260731024101.3339564-1-sashal@kernel.org>
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
index ba0971ec34b5..d4ef5d5e4264 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -78,7 +78,6 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -118,9 +117,6 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -132,9 +128,9 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
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

