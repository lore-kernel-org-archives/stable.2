Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AF25392A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707642; cv=none; b=oDvmoiuNwFsVVEAf+BFEClhMNizAk2f6XYrMCtjbtGT2cgNhlEbwJ+WZy/fXUpq/8hYv6RAFPhxPLz99Fn6CH+lZ+zFn7xeYTnBvmiic+/Mt1NYJ2/+3dBKqsR/GY2GghVUpaD9cDOTc4iZlGdBaHr2ClUMe+HGR2QvY8d0nUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707642; c=relaxed/simple;
	bh=FXcONuxdN7ewauWyRtj+tu4nP2OjVWhygMMyf83FZXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prcqT5QCpkR3qnUwRj2rcLSBJGoFyMsaJXQoFnhaGjgs3TJpEsD/x4pqlzL6B//wIqbpNDE5qzDqQn2NYCAT6e7vfZ1C522Dl/6gd1ho/PtYvD5YE58X1D3EUTaiPyQ/rinlyjjuEudPzoDPMe+CdIir25pLXqt0lKFsmrNJH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxTYrREg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxTYrREg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4551F000FF;
	Tue, 29 Sep 2026 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707641;
	bh=V0m6SgkzbUG2xIT0Rj9CCL/0He13SihsG1jxrm0+xqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxTYrREgMmeuZa3w26ODE3NdTZ+L0muzAO6PZGC0U0AzMH4khKBC4CJVheE2vH7rp
	 0rOU6rdU8vXTLbrrONirKqJLzvuR3S6nKQbZdUbcb8n92aVvbWMwNA1S/hXzAjL2MH
	 BTbNDgjamiC4scr/2BRWENCDT9oA4I0uFeOu6Nsny0/pyvodMLI8WTb2sW9AhuiUFD
	 JBj4gVPDCAKO/23cHOvjRtSicytKzynDgjvIiBot4k3oxGW6zcnwBHl78gSCVmDaOu
	 jFjinIpoH86QqQmgJ8OkCYkTLuOGXK/v31idW6vY5C0GCoCdrM+wvrfQ8YKtkvzr24
	 yZx/44aLoM/Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Dave Airlie <airlied@redhat.com>,
	Huang Rui <ray.huang@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] drm/nouveau: switch over to the new pin interface
Date: Tue, 29 Sep 2026 14:47:18 -0400
Message-ID: <20260929184719.523576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092908-masses-gestate-783f@gregkh>
References: <2026092908-masses-gestate-783f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 6797cea18d3982fce6a7d63e51b4cea0e3c8eb06 ]

Stop using TTM_PL_FLAG_NO_EVICT.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Link: https://patchwork.freedesktop.org/patch/391606/?series=81973&rev=1
Stable-dep-of: 6a6870d3077f ("drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c   | 48 +++++++-------------------
 drivers/gpu/drm/nouveau/nouveau_bo.h   |  3 --
 drivers/gpu/drm/nouveau/nouveau_chan.c |  2 +-
 3 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index d9106f14fde50..bc3ffd2c942fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -139,7 +139,7 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	struct drm_device *dev = drm->dev;
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 
-	WARN_ON(nvbo->pin_refcnt > 0);
+	WARN_ON(nvbo->bo.pin_count > 0);
 	nouveau_bo_del_io_reserve_lru(bo);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
 
@@ -421,9 +421,8 @@ nouveau_bo_placement_set(struct nouveau_bo *nvbo, uint32_t domain,
 {
 	struct nouveau_drm *drm = nouveau_bdev(nvbo->bo.bdev);
 	struct ttm_placement *pl = &nvbo->placement;
-	uint32_t flags = (nvbo->force_coherent ? TTM_PL_FLAG_UNCACHED :
-						 TTM_PL_MASK_CACHING) |
-			 (nvbo->pin_refcnt ? TTM_PL_FLAG_NO_EVICT : 0);
+	uint32_t flags = nvbo->force_coherent ? TTM_PL_FLAG_UNCACHED :
+						TTM_PL_MASK_CACHING;
 
 	pl->placement = nvbo->placements;
 	set_placement_list(drm, nvbo->placements, &pl->num_placement,
@@ -457,7 +456,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 		}
 	}
 
-	if (nvbo->pin_refcnt) {
+	if (nvbo->bo.pin_count) {
 		bool error = evict;
 
 		switch (bo->mem.mem_type) {
@@ -476,7 +475,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 				 bo->mem.mem_type, domain);
 			ret = -EBUSY;
 		}
-		nvbo->pin_refcnt++;
+		ttm_bo_pin(&nvbo->bo);
 		goto out;
 	}
 
@@ -487,18 +486,12 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 			goto out;
 	}
 
-	nvbo->pin_refcnt++;
 	nouveau_bo_placement_set(nvbo, domain, 0);
-
-	/* drop pin_refcnt temporarily, so we don't trip the assertion
-	 * in nouveau_bo_move() that makes sure we're not trying to
-	 * move a pinned buffer
-	 */
-	nvbo->pin_refcnt--;
 	ret = nouveau_bo_validate(nvbo, false, false);
 	if (ret)
 		goto out;
-	nvbo->pin_refcnt++;
+
+	ttm_bo_pin(&nvbo->bo);
 
 	switch (bo->mem.mem_type) {
 	case TTM_PL_VRAM:
@@ -523,30 +516,14 @@ nouveau_bo_unpin(struct nouveau_bo *nvbo)
 {
 	struct nouveau_drm *drm = nouveau_bdev(nvbo->bo.bdev);
 	struct ttm_buffer_object *bo = &nvbo->bo;
-	int ret, ref;
+	int ret;
 
 	ret = ttm_bo_reserve(bo, false, false, NULL);
 	if (ret)
 		return ret;
 
-	ref = --nvbo->pin_refcnt;
-	WARN_ON_ONCE(ref < 0);
-	if (ref)
-		goto out;
-
-	switch (bo->mem.mem_type) {
-	case TTM_PL_VRAM:
-		nouveau_bo_placement_set(nvbo, NOUVEAU_GEM_DOMAIN_VRAM, 0);
-		break;
-	case TTM_PL_TT:
-		nouveau_bo_placement_set(nvbo, NOUVEAU_GEM_DOMAIN_GART, 0);
-		break;
-	default:
-		break;
-	}
-
-	ret = nouveau_bo_validate(nvbo, false, false);
-	if (ret == 0) {
+	ttm_bo_unpin(&nvbo->bo);
+	if (!nvbo->bo.pin_count) {
 		switch (bo->mem.mem_type) {
 		case TTM_PL_VRAM:
 			drm->gem.vram_available += bo->mem.size;
@@ -559,9 +536,8 @@ nouveau_bo_unpin(struct nouveau_bo *nvbo)
 		}
 	}
 
-out:
 	ttm_bo_unreserve(bo);
-	return ret;
+	return 0;
 }
 
 int
@@ -1078,7 +1054,7 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (ret)
 		return ret;
 
-	if (nvbo->pin_refcnt)
+	if (nvbo->bo.pin_count)
 		NV_WARN(drm, "Moving pinned object %p!\n", nvbo);
 
 	if (drm->client.device.info.family < NV_DEVICE_INFO_V0_TESLA) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
index 2a23c82074362..ff68ded8d590d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
@@ -40,9 +40,6 @@ struct nouveau_bo {
 
 	struct nouveau_drm_tile *tile;
 
-	/* protect by the ttm reservation lock */
-	int pin_refcnt;
-
 	struct ttm_bo_kmap_obj dma_buf_vmap;
 };
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 9b6f2c1414d72..e48f1f7eb3705 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -107,7 +107,7 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->push.ctxdma);
 		nouveau_vma_del(&chan->push.vma);
 		nouveau_bo_unmap(chan->push.buffer);
-		if (chan->push.buffer && chan->push.buffer->pin_refcnt)
+		if (chan->push.buffer && chan->push.buffer->bo.pin_count)
 			nouveau_bo_unpin(chan->push.buffer);
 		nouveau_bo_ref(NULL, &chan->push.buffer);
 		kfree(chan);
-- 
2.53.0

