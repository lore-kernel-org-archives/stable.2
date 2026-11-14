Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683856;
	b=Nw97XrOK/TJuHpub7+a9b8ixAEPh9Cq5mjk39Uwq1g+arcnfnIJYUt2pQJjksqC8pH2w
	 L/b3li43rlXDhKnemT26A+bx/Td1JfIT7cu2pnmsoHIC7DOnhb7wA4s0eaJsXKxm9LBL7
	 ncg+5njFPrivOoR53A9oZwa6RkeZurkHmyMXszEuX97wT/7VvMOIEfx/DJYZSiqx2iLUE
	 00rjSKq2XsFozHs5/TO25J1/SMdAyFhxUCKpoqaXrxfxjG5qsgqZ911yVrFMSNoTrG0NZ
	 J50EVmK4qjvkrITCi2+77JcC4xQTC0GBZNzjRMe+bHRai7o23WjWsQLw1I1AKp6k9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683856;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RGbuyVsXW5NOl4DwAGrCKEQ770n5q+bOEZPB4llRPRg=;
	b=N76rDoaZbIAsN8O1t3fqJog+5hp7hQj5VyoHociVX/TZIXO1siClza7hxd45D+BN/rt7
	 bsLO6qD2eMY/kqO9zpT8gpgteIwsuW+tcSMUmPqfjHhVRYRhgI9dPvivhJLDNxZWOLB2H
	 ikMJHd9KJQ8FE+vUbnE/oBJxsu+Yhydv7hxywEmTrLTq2j6tdmaSC51gxKip+1ebR62aH
	 CS7VVNf9BXiKJVvnNfF2d/vL5c0uK2LGD6J3C6bNsX61EB8SMLE/XejUccGCh0Ums5J23
	 hv4dahZOQR6OKAZhy8t2ZMOSEvVESOULhJ6trQcmJub7mGDodu7ZUk8MA+RnWRY90qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="lz/9bkE7";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F026606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F026606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lz/9bkE7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=RGbuyVsXW5NOl4DwAGrCKEQ770n5q+bOEZPB4llRPRg=; t=1794683856; x=2110043856; 
	b=lz/9bkE7e/WELYgDJKanX3re8nUH9dUHvJvoK2i43ewcqFeVPa+TC9fvMA2DJcGjbRjpQdeLxNo
	djYH7+HwHbXEHl3P0AoYPo7TJf/9gJ/d8MWfL8BA9Hlc1zrdZjRN1DFZKXCjwdFfSzbLICvtM44jd
	XcD+AODm/KPRQoqZEX/ACGq/L0AK0SkvxwmHrcUB6Nq0GMJgBHfI03Ajd98PUPL31lHbB01a+Z1hy
	pQw2nbyDOGwX72qnnbR4BNG7bV03cc97mnrWJM26lvxW+fq9RJrJznqcfRb5Nwnxxebkc68dqqkQ9
	Hr8r2wE2BTa7I/0TPVFfJhFshpCz1UfeJP9A==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xSJFm-00AgZ4-55; Sat, 14 Nov 2026 20:17:34 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 14 Nov 2026 16:16:50 -0300
Subject: [PATCH v2 1/3] drm/vc4: Drop BO usecnt before releasing the old FB
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-vc4-async-flip-fixes-v2-1-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5136; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=o+1sqDRO3c2/x1XmhWNv/vIP+CY0CIM2uUrdTIg+dI8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq+LPGBcOAxxO0NLp1omWaITyF37j/sVvkMAk0r
 snk/TxMpEaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavizxgAKCRA/8w6Kdoj6
 qtx1B/9iN7xNHgHcuyw5oWERMj6HFvU0k2pNLEm9qqx5P6C1fWPPp2GRDQ2Dvn5DCxmNYWHMHYL
 FMIHt+qTsxapK1YfeodrxQQIL5vQA56+OkcZsyT2Wwu4YEJtvBUEnS0v6xZKjAR05/cLKJEpEmS
 fEld1L6NNzj/rA5CKut8OgUPKNMkNFlGhvVvU5JqwN6ksF+2OnTdFBUR+leZX0/l0QLwyua1jN3
 a2NMSzAS0yi3DRO9dk578uq6Z07Ob9qSehNKTvUAFGqNrjLMXHznS9DieaVPJL25B6hndyUz+A2
 fxqQkcpjsNvnL3bhscp73ZvAVZtyyw3OvQCfpJIW6nR5GJ0c
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

The async page flip completion drops the old FB reference before
decrementing its BO usecnt. If that was the last reference, the BO is
already freed or recycled into the BO cache when vc4_bo_dec_usecnt()
runs, leading to a use-after-free or a refcount underflow. For example,
while running glmark2-es2-drm in the Raspberry Pi 3, the following
warning appears:

[  459.078834] ------------[ cut here ]------------
[  459.078855] refcount_t: underflow; use-after-free.
[  459.078952] WARNING: lib/refcount.c:96 at refcount_dec_not_one+0xa0/0xa8, CPU#0: swapper/0/0
<snip>
[  459.079316] Call trace:
[  459.079323]  refcount_dec_not_one+0xa0/0xa8 (P)
[  459.079335]  vc4_bo_dec_usecnt+0x30/0x118 [vc4]
[  459.079371]  vc4_async_page_flip_complete_with_cleanup+0xa0/0xc4 [vc4]
[  459.079395]  dma_fence_signal_timestamp_locked+0xb0/0x12c
[  459.079408]  dma_fence_signal+0x3c/0x6c
[  459.079416]  vc4_irq_render_job_done+0x24/0xbc [vc4]
[  459.079440]  vc4_irq+0x120/0x138 [vc4]

This could happen when userspace removes the old FB and closes its GEM
handle while the flip is still pending.

Decrement the BO usecnt before releasing the old FB reference. Do this
by unifying the two fence callbacks and only decrementing the BO usecnt
in VC4_GEN_4.

Cc: stable@vger.kernel.org
Fixes: 4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common page-flip callback")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 62 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index f42cd5353230..c558b527c7e6 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -895,6 +895,7 @@ vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
 {
 	struct drm_crtc *crtc = flip_state->crtc;
 	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct drm_plane *plane = crtc->primary;
 
 	vc4_plane_async_set_fb(plane, flip_state->fb);
@@ -909,39 +910,27 @@ vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
 	drm_crtc_vblank_put(crtc);
 	drm_framebuffer_put(flip_state->fb);
 
-	if (flip_state->old_fb)
-		drm_framebuffer_put(flip_state->old_fb);
-
-	kfree(flip_state);
-}
-
-static void vc4_async_page_flip_complete_with_cleanup(struct dma_fence *fence,
-						      struct dma_fence_cb *cb)
-{
-	struct vc4_async_flip_state *flip_state =
-		container_of(cb, struct vc4_async_flip_state, cb);
-	struct vc4_bo *bo = NULL;
-
 	if (flip_state->old_fb) {
-		struct drm_gem_dma_object *dma_bo =
-			drm_fb_dma_get_gem_obj(flip_state->old_fb, 0);
-		bo = to_vc4_bo(&dma_bo->base);
+		/*
+		 * Decrement the BO usecnt in order to keep the inc/dec
+		 * calls balanced when the planes are updated through
+		 * the async update path.
+		 *
+		 * FIXME: we should move to generic async-page-flip when
+		 * it's available, so that we can get rid of this
+		 * hand-made cleanup_fb() logic.
+		 */
+		if (vc4->gen == VC4_GEN_4) {
+			struct drm_gem_dma_object *dma_bo =
+				drm_fb_dma_get_gem_obj(flip_state->old_fb, 0);
+
+			vc4_bo_dec_usecnt(to_vc4_bo(&dma_bo->base));
+		}
+
+		drm_framebuffer_put(flip_state->old_fb);
 	}
 
-	vc4_async_page_flip_complete(flip_state);
-	dma_fence_put(fence);
-
-	/*
-	 * Decrement the BO usecnt in order to keep the inc/dec
-	 * calls balanced when the planes are updated through
-	 * the async update path.
-	 *
-	 * FIXME: we should move to generic async-page-flip when
-	 * it's available, so that we can get rid of this
-	 * hand-made cleanup_fb() logic.
-	 */
-	if (bo)
-		vc4_bo_dec_usecnt(bo);
+	kfree(flip_state);
 }
 
 static void vc4_async_page_flip_fence_complete(struct dma_fence *fence,
@@ -959,30 +948,23 @@ static int vc4_async_set_fence_cb(struct drm_device *dev,
 {
 	struct drm_framebuffer *fb = flip_state->fb;
 	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
-	dma_fence_func_t async_page_flip_complete_function;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct dma_fence *fence;
 	int ret;
 
-	if (vc4->gen == VC4_GEN_4)
-		async_page_flip_complete_function = vc4_async_page_flip_complete_with_cleanup;
-	else
-		async_page_flip_complete_function = vc4_async_page_flip_fence_complete;
-
 	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ, &fence);
 	if (ret)
 		return ret;
 
 	/* If there's no fence, complete the page flip immediately */
 	if (!fence) {
-		async_page_flip_complete_function(fence, &flip_state->cb);
+		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
 		return 0;
 	}
 
 	/* If the fence has already been completed, complete the page flip */
 	if (dma_fence_add_callback(fence, &flip_state->cb,
-				   async_page_flip_complete_function))
-		async_page_flip_complete_function(fence, &flip_state->cb);
+				   vc4_async_page_flip_fence_complete))
+		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
 
 	return 0;
 }

-- 
2.56.0

