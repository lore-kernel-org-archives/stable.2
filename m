Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F4288B9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231034; cv=none; b=lwiVaIWucSIfm/vbMUG+La+X3IhunN3LYxLfd2TJhXDP43ni7f8z4D8zPvt8YR0deHjL6dfR66CveyGVGEY+jJNVcfjZf9yhCJ/J3i0QHmp1YuzMhavP/P/ylOv6Depyq6zIy5SUY0o9CAL1Zteu3Hnk206SaTYn1lB8xh6/AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231034; c=relaxed/simple;
	bh=/tWy9C8RDSW2O8DpeWlS8EW91K5bgwmReuOQKfeI7Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjCZTMJ4w14gKKiTfppIwhQpN9bO5KmWgBtqDpFFfelPzkj4XaEarV5QegEOaXwswvjxH4Czn1sTvoEKX2nw5AKCk/1prHuUXOI6WhnoAJ5+YrRm+eb5JTjW5MzBdYG+hTN/+efXW2O555vbECfpbyM496KdNZCzYr0jwn96ceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVFaXDlE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVFaXDlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBF51F00898;
	Sat, 12 Sep 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789231032;
	bh=YpzFiLEql0AH7UXLxBSc7qxGlJ48soVkQvLpXnJG92Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVFaXDlE+YiEhtwvwtd/xJP/DY3x0bZ2pon/a33hUpkDco1ZApygEob03KvvFnCwa
	 dX0g25TUyzYDr/VWrSrwUu/f5HTcF3pCzjPjA0aogdK5UrHC8D6sKoNIx5XFXoma6A
	 yz/1bmV6oIixqCYRxCMfBHlC/zzYQe0QUYELuokWi5RanLYJROoa0B7UpIsf2yfGpe
	 FsZTR+S9IxzxE0HsRzU0Y6bPY1jatOsZXmusG0LSobeSvZz4TbKzNtuLmAnUtFXPWM
	 5s/eu3ycMvYlG2r3MOUMlO2TwC8GoozljpZObUA5DyhtwqUa18XoLTtG4suRNBnmu/
	 y/8WVHRX7Gnmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Skeggs <bskeggs@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] drm/nouveau: remove chan->drm
Date: Sat, 12 Sep 2026 12:37:08 -0400
Message-ID: <20260912163709.3673876-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912163709.3673876-1-sashal@kernel.org>
References: <2026090931-importer-stinging-410c@gregkh>
 <20260912163709.3673876-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Skeggs <bskeggs@nvidia.com>

[ Upstream commit 3543e84e20fbd60e02264f757c77c7dbdfd1ee4a ]

The nouveau_cli that owns the channel is now stored in nouveau_chan, and
it has a pointer to the drm device already.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240726043828.58966-34-bskeggs@nvidia.com
Stable-dep-of: 511585987d27 ("drm/nouveau: unsubscribe the channel-kill event before the fence context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c  |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_bo0039.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_bo5039.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c   | 23 +++++++++--------------
 drivers/gpu/drm/nouveau/nouveau_chan.h   |  1 -
 drivers/gpu/drm/nouveau/nouveau_dma.c    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c  | 15 ++++++++-------
 drivers/gpu/drm/nouveau/nouveau_gem.c    |  7 ++++---
 drivers/gpu/drm/nouveau/nv17_fence.c     |  6 +++---
 drivers/gpu/drm/nouveau/nv50_fence.c     |  2 +-
 drivers/gpu/drm/nouveau/nv84_fence.c     |  8 ++++----
 11 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 8c7fff19c97bb..4c846276814c5 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1042,7 +1042,7 @@ nv04_finish_page_flip(struct nouveau_channel *chan,
 		      struct nv04_page_flip_state *ps)
 {
 	struct nouveau_fence_chan *fctx = chan->fence;
-	struct nouveau_drm *drm = chan->drm;
+	struct nouveau_drm *drm = chan->cli->drm;
 	struct drm_device *dev = drm->dev;
 	struct nv04_page_flip_state *s;
 	unsigned long flags;
@@ -1098,7 +1098,7 @@ nv04_page_flip_emit(struct nouveau_channel *chan,
 		    struct nouveau_fence **pfence)
 {
 	struct nouveau_fence_chan *fctx = chan->fence;
-	struct nouveau_drm *drm = chan->drm;
+	struct nouveau_drm *drm = chan->cli->drm;
 	struct drm_device *dev = drm->dev;
 	struct nvif_push *push = chan->chan.push;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo0039.c b/drivers/gpu/drm/nouveau/nouveau_bo0039.c
index e2ce44adaa5c4..2babc6c47241b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo0039.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo0039.c
@@ -104,6 +104,6 @@ nv04_bo_move_init(struct nouveau_channel *chan, u32 handle)
 		return ret;
 
 	PUSH_MTHD(push, NV039, SET_OBJECT, handle);
-	PUSH_MTHD(push, NV039, SET_CONTEXT_DMA_NOTIFIES, chan->drm->ntfy.handle);
+	PUSH_MTHD(push, NV039, SET_CONTEXT_DMA_NOTIFIES, chan->cli->drm->ntfy.handle);
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo5039.c b/drivers/gpu/drm/nouveau/nouveau_bo5039.c
index c6cf3629a9f93..0a6b1fce11084 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo5039.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo5039.c
@@ -144,7 +144,7 @@ nv50_bo_move_init(struct nouveau_channel *chan, u32 handle)
 		return ret;
 
 	PUSH_MTHD(push, NV5039, SET_OBJECT, handle);
-	PUSH_MTHD(push, NV5039, SET_CONTEXT_DMA_NOTIFY, chan->drm->ntfy.handle,
+	PUSH_MTHD(push, NV5039, SET_CONTEXT_DMA_NOTIFY, chan->cli->drm->ntfy.handle,
 				SET_CONTEXT_DMA_BUFFER_IN, chan->vram.handle,
 				SET_CONTEXT_DMA_BUFFER_OUT, chan->vram.handle);
 	return 0;
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index db2d01d013138..b706b6dd9a88b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,12 +90,10 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 {
 	struct nouveau_channel *chan = *pchan;
 	if (chan) {
-		struct nouveau_cli *cli = (void *)chan->user.client;
-
 		if (chan->fence)
-			nouveau_fence(chan->drm)->context_del(chan);
+			nouveau_fence(chan->cli->drm)->context_del(chan);
 
-		if (cli)
+		if (nvif_object_constructed(&chan->user))
 			nouveau_svmm_part(chan->vmm->svmm, chan->inst);
 
 		nvif_object_dtor(&chan->blit);
@@ -157,7 +155,6 @@ nouveau_channel_prep(struct nouveau_cli *cli,
 		return -ENOMEM;
 
 	chan->cli = cli;
-	chan->drm = drm;
 	chan->vmm = nouveau_cli_vmm(cli);
 	atomic_set(&chan->killed, 0);
 
@@ -229,12 +226,11 @@ nouveau_channel_prep(struct nouveau_cli *cli,
 			args.limit = device->info.ram_user - 1;
 		}
 	} else {
-		if (chan->drm->agp.bridge) {
+		if (drm->agp.bridge) {
 			args.target = NV_DMA_V0_TARGET_AGP;
 			args.access = NV_DMA_V0_ACCESS_RDWR;
-			args.start = chan->drm->agp.base;
-			args.limit = chan->drm->agp.base +
-				     chan->drm->agp.size - 1;
+			args.start = drm->agp.base;
+			args.limit = drm->agp.base + drm->agp.size - 1;
 		} else {
 			args.target = NV_DMA_V0_TARGET_VM;
 			args.access = NV_DMA_V0_ACCESS_RDWR;
@@ -421,12 +417,11 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 			args.start = 0;
 			args.limit = chan->vmm->vmm.limit - 1;
 		} else
-		if (chan->drm->agp.bridge) {
+		if (drm->agp.bridge) {
 			args.target = NV_DMA_V0_TARGET_AGP;
 			args.access = NV_DMA_V0_ACCESS_RDWR;
-			args.start = chan->drm->agp.base;
-			args.limit = chan->drm->agp.base +
-				     chan->drm->agp.size - 1;
+			args.start = drm->agp.base;
+			args.limit = drm->agp.base + drm->agp.size - 1;
 		} else {
 			args.target = NV_DMA_V0_TARGET_VM;
 			args.access = NV_DMA_V0_ACCESS_RDWR;
@@ -491,7 +486,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	}
 
 	/* initialise synchronisation */
-	return nouveau_fence(chan->drm)->context_new(chan);
+	return nouveau_fence(drm)->context_new(chan);
 }
 
 int
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index 18a9cbfef8ca3..3ce9832c9528b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -13,7 +13,6 @@ struct nouveau_channel {
 	} chan;
 
 	struct nouveau_cli *cli;
-	struct nouveau_drm *drm;
 	struct nouveau_vmm *vmm;
 
 	struct nvif_mem mem_userd;
diff --git a/drivers/gpu/drm/nouveau/nouveau_dma.c b/drivers/gpu/drm/nouveau/nouveau_dma.c
index b01c029f3a903..a1f329ef0641e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dma.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dma.c
@@ -72,7 +72,7 @@ void
 nv50_dma_push(struct nouveau_channel *chan, u64 offset, u32 length,
 	      bool no_prefetch)
 {
-	struct nvif_user *user = &chan->drm->client.device.user;
+	struct nvif_user *user = &chan->cli->drm->client.device.user;
 	struct nouveau_bo *pb = chan->push.buffer;
 	int ip = (chan->dma.ib_put * 2) + chan->dma.ib_base;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 1bfa312d6fb85..ee43a36f17bd7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -181,8 +181,9 @@ nouveau_fence_wait_uevent_handler(struct nvif_event *event, void *repv, u32 repc
 void
 nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_chan *fctx)
 {
-	struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
-	struct nouveau_cli *cli = (void *)chan->user.client;
+	struct nouveau_cli *cli = chan->cli;
+	struct nouveau_drm *drm = cli->drm;
+	struct nouveau_fence_priv *priv = (void*)drm->fence;
 	struct {
 		struct nvif_event_v0 base;
 		struct nvif_chan_event_v0 host;
@@ -193,11 +194,11 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
 	INIT_LIST_HEAD(&fctx->flip);
 	INIT_LIST_HEAD(&fctx->pending);
 	spin_lock_init(&fctx->lock);
-	fctx->context = chan->drm->runl[chan->runlist].context_base + chan->chid;
+	fctx->context = drm->runl[chan->runlist].context_base + chan->chid;
 
-	if (chan == chan->drm->cechan)
+	if (chan == drm->cechan)
 		strcpy(fctx->name, "copy engine channel");
-	else if (chan == chan->drm->channel)
+	else if (chan == drm->channel)
 		strcpy(fctx->name, "generic kernel channel");
 	else
 		strcpy(fctx->name, nvxx_client(&cli->base)->name);
@@ -221,7 +222,7 @@ nouveau_fence_emit(struct nouveau_fence *fence)
 {
 	struct nouveau_channel *chan = unrcu_pointer(fence->channel);
 	struct nouveau_fence_chan *fctx = chan->fence;
-	struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
+	struct nouveau_fence_priv *priv = (void*)chan->cli->drm->fence;
 	int ret;
 
 	fence->timeout  = jiffies + (15 * HZ);
@@ -382,7 +383,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan,
 			if (i == 0 && usage == DMA_RESV_USAGE_WRITE)
 				continue;
 
-			f = nouveau_local_fence(fence, chan->drm);
+			f = nouveau_local_fence(fence, chan->cli->drm);
 			if (f) {
 				struct nouveau_channel *prev;
 				bool must_wait = true;
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index e8ce33c89548d..353c4850a5616 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -558,10 +558,11 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 }
 
 static int
-validate_list(struct nouveau_channel *chan, struct nouveau_cli *cli,
+validate_list(struct nouveau_channel *chan,
 	      struct list_head *list, struct drm_nouveau_gem_pushbuf_bo *pbbo)
 {
-	struct nouveau_drm *drm = chan->drm;
+	struct nouveau_cli *cli = chan->cli;
+	struct nouveau_drm *drm = cli->drm;
 	struct nouveau_bo *nvbo;
 	int ret, relocs = 0;
 
@@ -633,7 +634,7 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
 		return ret;
 	}
 
-	ret = validate_list(chan, cli, &op->list, pbbo);
+	ret = validate_list(chan, &op->list, pbbo);
 	if (unlikely(ret < 0)) {
 		if (ret != -ERESTARTSYS)
 			NV_PRINTK(err, cli, "validating bo list\n");
diff --git a/drivers/gpu/drm/nouveau/nv17_fence.c b/drivers/gpu/drm/nouveau/nv17_fence.c
index 07c2e0878c244..7fa52ec61b30d 100644
--- a/drivers/gpu/drm/nouveau/nv17_fence.c
+++ b/drivers/gpu/drm/nouveau/nv17_fence.c
@@ -36,8 +36,8 @@ int
 nv17_fence_sync(struct nouveau_fence *fence,
 		struct nouveau_channel *prev, struct nouveau_channel *chan)
 {
-	struct nouveau_cli *cli = (void *)prev->user.client;
-	struct nv10_fence_priv *priv = chan->drm->fence;
+	struct nouveau_cli *cli = prev->cli;
+	struct nv10_fence_priv *priv = cli->drm->fence;
 	struct nv10_fence_chan *fctx = chan->fence;
 	struct nvif_push *ppush = prev->chan.push;
 	struct nvif_push *npush = chan->chan.push;
@@ -76,7 +76,7 @@ nv17_fence_sync(struct nouveau_fence *fence,
 static int
 nv17_fence_context_new(struct nouveau_channel *chan)
 {
-	struct nv10_fence_priv *priv = chan->drm->fence;
+	struct nv10_fence_priv *priv = chan->cli->drm->fence;
 	struct ttm_resource *reg = priv->bo->bo.resource;
 	struct nv10_fence_chan *fctx;
 	u32 start = reg->start * PAGE_SIZE;
diff --git a/drivers/gpu/drm/nouveau/nv50_fence.c b/drivers/gpu/drm/nouveau/nv50_fence.c
index ea1e1f480bfeb..8b76cb227f555 100644
--- a/drivers/gpu/drm/nouveau/nv50_fence.c
+++ b/drivers/gpu/drm/nouveau/nv50_fence.c
@@ -35,7 +35,7 @@
 static int
 nv50_fence_context_new(struct nouveau_channel *chan)
 {
-	struct nv10_fence_priv *priv = chan->drm->fence;
+	struct nv10_fence_priv *priv = chan->cli->drm->fence;
 	struct nv10_fence_chan *fctx;
 	struct ttm_resource *reg = priv->bo->bo.resource;
 	u32 start = reg->start * PAGE_SIZE;
diff --git a/drivers/gpu/drm/nouveau/nv84_fence.c b/drivers/gpu/drm/nouveau/nv84_fence.c
index 812b8c62eeba1..7f62089dc9400 100644
--- a/drivers/gpu/drm/nouveau/nv84_fence.c
+++ b/drivers/gpu/drm/nouveau/nv84_fence.c
@@ -79,7 +79,7 @@ nv84_fence_sync32(struct nouveau_channel *chan, u64 virtual, u32 sequence)
 static inline u32
 nv84_fence_chid(struct nouveau_channel *chan)
 {
-	return chan->drm->runl[chan->runlist].chan_id_base + chan->chid;
+	return chan->cli->drm->runl[chan->runlist].chan_id_base + chan->chid;
 }
 
 static int
@@ -105,14 +105,14 @@ nv84_fence_sync(struct nouveau_fence *fence,
 static u32
 nv84_fence_read(struct nouveau_channel *chan)
 {
-	struct nv84_fence_priv *priv = chan->drm->fence;
+	struct nv84_fence_priv *priv = chan->cli->drm->fence;
 	return nouveau_bo_rd32(priv->bo, nv84_fence_chid(chan) * 16/4);
 }
 
 static void
 nv84_fence_context_del(struct nouveau_channel *chan)
 {
-	struct nv84_fence_priv *priv = chan->drm->fence;
+	struct nv84_fence_priv *priv = chan->cli->drm->fence;
 	struct nv84_fence_chan *fctx = chan->fence;
 
 	nouveau_bo_wr32(priv->bo, nv84_fence_chid(chan) * 16 / 4, fctx->base.sequence);
@@ -127,7 +127,7 @@ nv84_fence_context_del(struct nouveau_channel *chan)
 int
 nv84_fence_context_new(struct nouveau_channel *chan)
 {
-	struct nv84_fence_priv *priv = chan->drm->fence;
+	struct nv84_fence_priv *priv = chan->cli->drm->fence;
 	struct nv84_fence_chan *fctx;
 	int ret;
 
-- 
2.53.0

