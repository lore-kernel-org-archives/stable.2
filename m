Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528999;
	b=boCeFYxOUh1WCXpX6AuMAmmJPzORtV3+NP2DykKX/jfj2t/oFD6GHm4gWYSO++4ZGqJ1
	 nNMEEXlbBY8IAipZx1lSFUtHIturUcMxtLbMqyoRUEcVv+PYzHiVymCaoubQTcg8J5l2m
	 DLLDmgQD97i4d+0c8smK0/mY7hmKHSObSwth9eRdIrkpZTTTYcHBjuW+W13GettYwGKAB
	 hK/lddJ217a8kxE0D887mYW2N08CWDuG3qmdpH3wiDU7kEvLJRMZVnE+0dua57mpXSVyK
	 8+i+BrC9RkimYgcV8azzjAKJnoEk0efFnjV30I/mkuT71VDdwiLFhmNKK7CwXBxPuCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528999;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cWU+Ua6rZSLlzoNFkOQ/4j8IAFswY5s2+ptQ88azqGo=;
	b=dPQE5NNlrbswgL9O88FjeKbn0TYAI0u4AnQXYLPeaZcAptUndxq7mOY3leXZ2HHfQpMY
	 GbXuXgCAr8TwjjZxcGX5g6r877uPVvE8ln3LRJUpTTp9wiXGj1SH044M9IJc+Gq6UVGRh
	 PF9oiasRm+/uob6UkeWL7JNHrGzFckSnrDpMqeHIcH5hX2BgvdPc3nHI0Ky/WyzPBo8at
	 QpDraVG9wtuLwVAJ0yYvYODZYZJ0tMliko+DIHLkZjuuyL7y4vsUwfj759Hja7stv6ZkE
	 aW1tjwjyBLnIvAc1KzliWXJ9JExVxhMTQVUkpDta72hDwz1Chandbtu694FDMkRfyxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=p6+WRS8w;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF19606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF19606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=p6+WRS8w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=cWU+Ua6rZSLlzoNFkOQ/4j8IAFswY5s2+ptQ88azqGo=; t=1795528998; x=2110888998; 
	b=p6+WRS8wsGkc9/B9OcIQr8qsysBI1U2Vs7HIfg+fvYVgg+Tx5Q6JW0EZz6ocr5sLcp5jO8GfFWN
	4+iZ7UDekLUXiYdl4bi9oMxQIcy3+Ls8vx8/32ITarbNqLDhmen5tf7qyy6fdaTWphBxWgioyVpQD
	0P/e/Cxw3fP/aKCh+W2CCOLZnjaF+Rm6vB+1C5GIhIwoZoRtxtssc437g5KBaFWzRSr/o3ebdxfBI
	lUdzVjGKjqn/9ttFHnWFCHlMZeI06yrx728aGqUhFXR43LKGvq/Vc54iDKIreE2lA43CwUM1/AT6W
	BW2nAIvtyO6/HxM+JlaY/rjjXgVHLoSF2kNw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xVr75-00000003NuD-0NAu;
	Tue, 24 Nov 2026 15:03:15 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Daniel Drake <dan@reactivated.net>,
	dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.18.y] drm/gem-dma: Support dedicated DMA device for allocation and mapping
Date: Tue, 24 Nov 2026 10:51:30 -0300
Message-ID: <20261124140251.4131801-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit a9da24732aaa80d631bffc8a1390836d4b896690 ]

Support for a dedicated DMA device for prime imports was added in commit
143ec8d3f939 ("drm/prime: Support dedicated DMA device for dma-buf imports").
This allowed the DRM driver to provide a dedicated DMA device when its
own underlying device was not capable of DMA, for example when it is a
USB device (the original target) or a virtual device. The latter case is
common on embedded SoCs, on which the display pipeline is composed of
various fixed function blocks, and the DRM device is simply a made-up
device, an address space managing the routing between the blocks, or
whichever block the implementor thought made sense at the time. The
point is that the chosen device is often not the actual device doing
the DMA. Various drivers have used workarounds or reimplemented the
GEM DMA helpers to get the DMA addresses and IOMMUs to work correctly.

Add support for the dedicated DMA device to the GEM DMA helpers.

No existing driver currently uses the GEM DMA helpers and calls
drm_dev_set_dma_dev() to set a dedicated DMA device, so no existing
users should be affected.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20260311094929.3393338-3-wenst@chromium.org
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
Since 6.18.65, vc4 on Raspberry Pi 5 fails to allocate buffers:

  vc4-drm gpu: [drm] *ERROR* fbdev: Failed to setup emulation (ret=-12)

6.18.65 includes 008dd935c79d ("drm/vc4: Set DRM DMA device directly from
HVS and V3D"), which makes HVS the DRM DMA device and stops configuring
the vc4 GPU device. It depends on this patch, which was not backported.
Without it, drm_gem_dma_helper still allocates from drm->dev, which keeps
the default 32-bit mask, while the Pi 5 HVS IOMMU aperture is above 4 GB.
With that, every allocation fails.

This bug was reported on https://github.com/raspberrypi/linux/issues/7794.

7.3.y already has this commit, so it's not an issue there.

Best regards,
- Maíra

 drivers/gpu/drm/drm_gem_dma_helper.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 4f0320df858f..55246a59e8bb 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -144,12 +144,13 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
 		return dma_obj;
 
 	if (dma_obj->map_noncoherent) {
-		dma_obj->vaddr = dma_alloc_noncoherent(drm->dev, size,
+		dma_obj->vaddr = dma_alloc_noncoherent(drm_dev_dma_dev(drm),
+						       size,
 						       &dma_obj->dma_addr,
 						       DMA_TO_DEVICE,
 						       GFP_KERNEL | __GFP_NOWARN);
 	} else {
-		dma_obj->vaddr = dma_alloc_wc(drm->dev, size,
+		dma_obj->vaddr = dma_alloc_wc(drm_dev_dma_dev(drm), size,
 					      &dma_obj->dma_addr,
 					      GFP_KERNEL | __GFP_NOWARN);
 	}
@@ -234,12 +235,14 @@ void drm_gem_dma_free(struct drm_gem_dma_object *dma_obj)
 		drm_prime_gem_destroy(gem_obj, dma_obj->sgt);
 	} else if (dma_obj->vaddr) {
 		if (dma_obj->map_noncoherent)
-			dma_free_noncoherent(gem_obj->dev->dev, dma_obj->base.size,
+			dma_free_noncoherent(drm_dev_dma_dev(gem_obj->dev),
+					     dma_obj->base.size,
 					     dma_obj->vaddr, dma_obj->dma_addr,
 					     DMA_TO_DEVICE);
 		else
-			dma_free_wc(gem_obj->dev->dev, dma_obj->base.size,
-				    dma_obj->vaddr, dma_obj->dma_addr);
+			dma_free_wc(drm_dev_dma_dev(gem_obj->dev),
+				    dma_obj->base.size, dma_obj->vaddr,
+				    dma_obj->dma_addr);
 	}
 
 	drm_gem_object_release(gem_obj);
@@ -428,7 +431,7 @@ struct sg_table *drm_gem_dma_get_sg_table(struct drm_gem_dma_object *dma_obj)
 	if (!sgt)
 		return ERR_PTR(-ENOMEM);
 
-	ret = dma_get_sgtable(obj->dev->dev, sgt, dma_obj->vaddr,
+	ret = dma_get_sgtable(drm_dev_dma_dev(obj->dev), sgt, dma_obj->vaddr,
 			      dma_obj->dma_addr, obj->size);
 	if (ret < 0)
 		goto out;
@@ -535,12 +538,12 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 	if (dma_obj->map_noncoherent) {
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
-		ret = dma_mmap_pages(dma_obj->base.dev->dev,
+		ret = dma_mmap_pages(drm_dev_dma_dev(dma_obj->base.dev),
 				     vma, vma->vm_end - vma->vm_start,
 				     virt_to_page(dma_obj->vaddr));
 	} else {
-		ret = dma_mmap_wc(dma_obj->base.dev->dev, vma, dma_obj->vaddr,
-				  dma_obj->dma_addr,
+		ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
+				  dma_obj->vaddr, dma_obj->dma_addr,
 				  vma->vm_end - vma->vm_start);
 	}
 	if (ret)
-- 
2.56.1

