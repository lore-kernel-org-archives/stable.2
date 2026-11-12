Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488234;
	b=3gZM/7VsF8CtxtHqpJcD9GR1A8aoe6M3sS3u6V4QQ+NHjVTFRYhNFW1CPRQlqmLa3R0u
	 clQbwejzDqbOwUn/H3AEkiZdERq7yd/7GHrmz/0ey66OuRNtWCnPlhCkOiAk1z5VURJBL
	 /UXasQT/Lz9UgNH/OC8IwEFjsbTTdGEzzN3ALKu7gNQ1k/ia9Yfexnd/fZPt++BBDw7p7
	 XgLASpPX9ITBqgigdrQzn18TA5JcUsySV0/xMp6FERgGU6zmEElpBV7lD5QmrTxLiHBNG
	 /zzdLOIqWHzoiudyBkVQl4K6T9nM7kShdKaJMa1Ruo13Qbo9RA+2jqpx7+HsQ0splUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488234;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sIakiFIiLJEWLg6VzeGcLqQHWah4lcn09LJBE+2/zc0=;
	b=xcPy7ipN8Xph2aDfTTCW1o7qG7xqstyrX3O+OoddHPvniLmVrQOkxS2OHdKRsMPMqMTT
	 CumRWszKKXxWgU3cUFkP3HS7YglUCW0yxK0ky+sz2bG0G2XFm84UniRpa+fscEc14ly8Q
	 4TWJMiRoGyTIPcxCNaEtUyzLikAec6nDqQv6Ulj3xTrZCkZUB86Wf/SRqfmrIE4UswfU3
	 W3NkYV9K5iBstzJVA0Z0IbAKcyiZfxCatN4JgzgMMM417izeWBEzfa7KX7+tj/Kzx8jzM
	 oPXtGjSDJ8dDNqcL4YZRmQrBrHufW0QleD6Pxmh4004k2rZs0BGI0BDTyqNSsHoIDKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VaHoxUwy;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399C606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4399C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VaHoxUwy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=sIakiFIiLJEWLg6VzeGcLqQHWah4lcn09LJBE+2/zc0=; t=1794488233; x=2109848233; 
	b=VaHoxUwy0L8k2qRsfFAgTNxwWL5tZerRLrfDIDvd1V5IKhaLt/HuN2Zr4uwEFG4OM5bSE9Prr0z
	n/FVmJ2m6n8E7oPpIeP8CTJlIFRJeUjySuG2u/u4ecST50gyky2LxDjGM6SISuvFfr3+Ob971XX98
	aIqP1bPBtqUmH6xXn9drI/m9MfRWPReZAgd0GJLGvCHrk8Y4nLAVge0iNA1NrHFTeQMWijXGRLwly
	oEolpmt0lHqqMmTKrwxm0OMcHADQKG/4Fm5z5qBAHaQBuIS9oBYytKDHADeMChSxBurXCgvW3V9Sz
	Ivr6XCzSBBcLwTn5+JQUbZ/H1lBtGPkJndPA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRUMZ-009Xxy-1I; Thu, 12 Nov 2026 13:57:11 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Nov 2026 09:56:56 -0300
Subject: [PATCH 2/2] drm/vc4: Complete async page flips from an ordered
 workqueue
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
Message-Id: <20261112-vc4-async-flip-fixes-v1-2-42449a703840@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7146; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XZtWQkzVutqKUfcgzVwlfUJA5gqsO1ChRpFyNluRCNY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9bedB857nAyT6dI9BgOU2GneDfGp2fBIDs7Cb
 FBflX+83diJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavW3nQAKCRA/8w6Kdoj6
 qszMCAC8/BWrdrw53PMiOe6lMxnXYWcaI199zh3hea0MpZYDlUlADakAcCUoohkaYrLV4eYm7T4
 mxbddvull3P/d9zrScQJT78T7g0y4Q5tj7FUH9EyjhYfX2+ZLbHxcXlJ0LaGN458LNEMVBYNGh+
 ZiZSbe3341C02L99ZTdVNbJynxmD299hrIY+G59HKURmrs1fhY/TQx97jB3r3qnU4HEvU5pzL21
 KFm30eLLAamvaOPF92cie1PLF4aziHwt8bUmJqPeTtzK9S2YOdkAeWnf66YzbmvVoIAXFq/l+BJ
 h1bsvjCjeZ3kX+ejIwC6MASPcpOhJZ8nq7++Zc/9q/vfVU4P
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Async page flips complete from a dma_fence callback, which runs in the
fence signaling context: the VC4 render job IRQ handler on RPi 0-3 since
commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), and the V3D IRQ
handler on RPi 4-5 since commit d19e00ee06a9 ("drm/vc4: crtc: Fix out of
order frames during asynchronous page flips").

Completing the flip may sleep: on RPi 0-3, vc4_bo_dec_usecnt() takes
bo->madv_lock, and on all platforms, dropping the last framebuffer
reference takes fb_lock and can free the BO. When running the kernel
with CONFIG_DEBUG_ATOMIC_SLEEP=y on RPi 3, this triggers the following
warning:

[ 2511.636319] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
[ 2511.636667] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
[ 2511.636681] preempt_count: 1000002, expected: 0
[ 2511.636689] RCU nest depth: 0, expected: 0
[ 2511.636698] locks held by swapper/0/0: 1, on CPU#0:
[ 2511.636711]  #0: ffff000037183198 (&fence->inline_lock){-...}-{3:3}, at: dma_fence_signal+0x88/0xec
<snip>
[ 2511.636892] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
[ 2511.636899] Call trace:
<snip>
[ 2511.636991]  mutex_lock_nested+0x24/0x30
[ 2511.637002]  vc4_bo_dec_usecnt+0x40/0x124 [vc4]
[ 2511.637070]  vc4_async_page_flip_complete_with_cleanup+0xa0/0xc4 [vc4]
[ 2511.637102]  dma_fence_signal_timestamp_locked+0x118/0x290
[ 2511.637116]  dma_fence_signal+0x9c/0xec
[ 2511.637126]  vc4_irq_render_job_done+0x24/0x114 [vc4]
[ 2511.637158]  vc4_irq+0x16c/0x274 [vc4]

Make the fence callback only queue a work item on a per-CRTC ordered
workqueue and complete the flip from it. Flips with no fence or an already
signaled one still complete inline, but only after flushing that workqueue,
so they can't complete before earlier pending flips on the same CRTC.

Cc: stable@vger.kernel.org
Fixes: d19e00ee06a9 ("drm/vc4: crtc: Fix out of order frames during asynchronous page flips")
Fixes: e8941ac97f28 ("drm/vc4: Remove BOs seqnos")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 52 +++++++++++++++++++++++++++---------------
 drivers/gpu/drm/vc4/vc4_drv.h  |  6 +++++
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index c558b527c7e6..623b636a0365 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -884,15 +884,18 @@ struct vc4_async_flip_state {
 	struct drm_framebuffer *fb;
 	struct drm_framebuffer *old_fb;
 	struct drm_pending_vblank_event *event;
+	struct dma_fence *fence;
 	struct dma_fence_cb cb;
+	struct work_struct work;
 };
 
-/* Called when the V3D execution for the BO being flipped to is done, so that
- * we can actually update the plane's address to point to it.
+/* Executed when the V3D execution for the BO being flipped to is done, so
+ * that we can actually update the plane's address to point to it.
  */
-static void
-vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
+static void vc4_async_page_flip_work(struct work_struct *work)
 {
+	struct vc4_async_flip_state *flip_state =
+		container_of(work, struct vc4_async_flip_state, work);
 	struct drm_crtc *crtc = flip_state->crtc;
 	struct drm_device *dev = crtc->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -930,17 +933,19 @@ vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
 		drm_framebuffer_put(flip_state->old_fb);
 	}
 
+	dma_fence_put(flip_state->fence);
 	kfree(flip_state);
 }
 
-static void vc4_async_page_flip_fence_complete(struct dma_fence *fence,
-					       struct dma_fence_cb *cb)
+static void vc4_async_page_flip_fence_cb(struct dma_fence *fence,
+					 struct dma_fence_cb *cb)
 {
 	struct vc4_async_flip_state *flip_state =
 		container_of(cb, struct vc4_async_flip_state, cb);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(flip_state->crtc);
 
-	vc4_async_page_flip_complete(flip_state);
-	dma_fence_put(fence);
+	/* Completing the flip may sleep, so defer it to a worker. */
+	queue_work(vc4_crtc->async_flip_wq, &flip_state->work);
 }
 
 static int vc4_async_set_fence_cb(struct drm_device *dev,
@@ -948,23 +953,26 @@ static int vc4_async_set_fence_cb(struct drm_device *dev,
 {
 	struct drm_framebuffer *fb = flip_state->fb;
 	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
-	struct dma_fence *fence;
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(flip_state->crtc);
 	int ret;
 
-	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ, &fence);
+	INIT_WORK(&flip_state->work, vc4_async_page_flip_work);
+
+	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
+				     &flip_state->fence);
 	if (ret)
 		return ret;
 
-	/* If there's no fence, complete the page flip immediately */
-	if (!fence) {
-		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
+	if (flip_state->fence &&
+	    !dma_fence_add_callback(flip_state->fence, &flip_state->cb,
+				    vc4_async_page_flip_fence_cb))
 		return 0;
-	}
 
-	/* If the fence has already been completed, complete the page flip */
-	if (dma_fence_add_callback(fence, &flip_state->cb,
-				   vc4_async_page_flip_fence_complete))
-		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
+	/* No fence or the fence has already signaled. Complete the flip
+	 * immediately, after earlier queued flips.
+	 */
+	flush_workqueue(vc4_crtc->async_flip_wq);
+	vc4_async_page_flip_work(&flip_state->work);
 
 	return 0;
 }
@@ -990,7 +998,7 @@ vc4_async_page_flip_common(struct drm_crtc *crtc,
 
 	/* Save the current FB before it's replaced by the new one in
 	 * drm_atomic_set_fb_for_plane(). We'll need the old FB in
-	 * vc4_async_page_flip_complete() to decrement the BO usecnt and keep
+	 * vc4_async_page_flip_work() to decrement the BO usecnt and keep
 	 * it consistent.
 	 * FIXME: we should move to generic async-page-flip when it's
 	 * available, so that we can get rid of this hand-made cleanup_fb()
@@ -1387,7 +1395,13 @@ int __vc4_crtc_init(struct drm_device *drm,
 	vc4_crtc->data = data;
 	vc4_crtc->pdev = pdev;
 	vc4_crtc->feeds_txp = feeds_txp;
+	vc4_crtc->async_flip_wq = drmm_alloc_ordered_workqueue(drm, "%s-async-flip",
+							       0, data->name);
+	if (IS_ERR(vc4_crtc->async_flip_wq))
+		return PTR_ERR(vc4_crtc->async_flip_wq);
+
 	spin_lock_init(&vc4_crtc->irq_lock);
+
 	ret = drmm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 					 crtc_funcs, data->name);
 	if (ret)
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 09134809bf15..f68486be08a6 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -596,6 +596,12 @@ struct vc4_crtc {
 	 * access to that value.
 	 */
 	unsigned int current_hvs_channel;
+
+	/**
+	 * @async_flip_wq: Ordered workqueue completing the CRTC's async
+	 * page flips.
+	 */
+	struct workqueue_struct *async_flip_wq;
 };
 
 #define to_vc4_crtc(_crtc)					\

-- 
2.56.0

