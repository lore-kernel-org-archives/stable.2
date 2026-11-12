Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488231;
	b=dTy1gZvEIx+fsqH+13R+GctF8JS9zoVitOt44vL08Di0ESKe9mfWFs7k/OuI27K4hf/W
	 kAolQ31Wg6DmXnRzW+2sLMVQw/cazlD+DdoeZXMZ+YjjC0sZhcdpB7EMEqPf71HkSPaHR
	 5dCeFBmZ7IWv32CtAcm9DTDtX7x9a6sldIYIbc78Ai3WezVI7WIurOnAufvEGfSNF17hz
	 m4FoEDqLljhpfSbv8kuawdDFKadqQ6/pPePToL2H45G/5py2dzIV5BCZsdg7s9MQmNwLc
	 pk8QhDroUFC6niylb8Ox5ne+6D6K3ULu+hzSFvkBHHuFRgArLCaPp/kffT4qPGNm0jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488231;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+DIJefjwUpKQdS8Hp+UBpmUWO8RYbixBIlSpsd8e9U4=;
	b=Kh5oqFi9QZS/NUklIq9m+6CZiRXIA5a28Ks6yEz/CA39RnB8VZVf7uHJ4kR6eKurhuMQ
	 Nw6AAU2CBDOyQnWMkHgZFGhg4gBO0+agZPhJ6GJENUWvlwqpNm9DMRNBuLyh8oeP4cHxa
	 IMw0lHwnWG3h7CiMUdv3cp70awJwAlEYuKak/Dis0n0w1RhtHq9muwY/Ysd7cxYKejbFl
	 VWR8cQyNuOoKrWpB44Ypsvk9h6iHYw71KmFBSiPq4gOQmHuvJGVTg9HYaMxnfVn4Dun2W
	 9BZSkoQe2kRgW1MAKwSYceOzEoY8qe/J+kMpZI91gWl9z9SqOI3UI5cPKziC+YHEAGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hXazfG66;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2B606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD2B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hXazfG66
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=+DIJefjwUpKQdS8Hp+UBpmUWO8RYbixBIlSpsd8e9U4=; t=1794488230; x=2109848230; 
	b=hXazfG66X+gAf0Z1Jdggm8YFzy1QkxAxcH1e13TKt/kW5AVfCduEe0tSMyKCZ5yx3fFo1hM6kMo
	PpInSRuOr0kVF8M2YDAQlXtEdMcgQH2kqDhPdjA2zelvXSULYkWDqHG23tbtkFllKtUlkUvw+3AQP
	g3wEHJXkTNKrdewYsV1T61dK7ph464NY0fI3uUYsrAW61CIohkosZ/2yXScgE/EO5rU0pamPy5x52
	z9vLzAunc0PVW2vNtS+URwoy9N4zZ8K5tjwAFWqcCnDn/YGnJRlk6yUBoIe1Dp7lU9p8e74BNdFBN
	0n+DFntAdI0LUzJ1dOpG+J45jdgSXKRM1SGQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRUMV-009Xxy-Oo; Thu, 12 Nov 2026 13:57:07 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Nov 2026 09:56:55 -0300
Subject: [PATCH 1/2] drm/vc4: Drop BO usecnt before releasing the old FB
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
Message-Id: <20261112-vc4-async-flip-fixes-v1-1-42449a703840@igalia.com>
References: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
In-Reply-To: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4409; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Mhhdx3abS3XijWwmqjGsd076MAeg/l7+teHRLZS3X6o=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9bedjX4DAe6whOU8Pua1KncGrTOyDh49nWhrq
 6KiiNf5JwCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavW3nQAKCRA/8w6Kdoj6
 qtP1B/4/c98UMJrZsjU5xNZWuuXYNxWWhHhkw5h8VnOyLN99o7rVzlXhx45ECUEX+YtPsQ9idSf
 Ql0ly5GUFD4dq1W7W/J5TxOWg1Wm6cEvoIio0SI0er8iSLN/eVY/oJpR2IROX3sF6O7P/RV9QLA
 WlWMuPsSjDHUjVrLJoAr8X4Vli8dnCxqsOoJfuYb6igXiCftIWs2bjnKm/l59KPveHovhx3ftjy
 HdumH5i7x2sa6JxEhfOD3tOdGv+OX6MvSyk0/z1riXIogKaAev8D1c0KBPfLbyuUeFloKCw3KxW
 MnFehN0CBjXVF3wyAU2q4kK3Sj6aRn9rHuz/VkkeddtVnkEj
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

The async page flip completion drops the old FB reference before
decrementing its BO usecnt. If that was the last reference, the BO is
already freed or recycled into the BO cache when vc4_bo_dec_usecnt()
runs, leading to a use-after-free or a refcount underflow.

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

