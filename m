Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683865;
	b=OoL6z/dD6R49ysK6c9DWE28Wblsa09Rayf8Zhtcy9/sLqtVZxO9zWqkK1tbkootuKOtU
	 oO5AvkmyUulWmQruINbbNxMpz3n1pHXU7lfRtUdZLm0kllmQSm3vbI1AHjADAt2uzuyy9
	 gs7ykiEikCDxFsdWBd+oOMCbZ3fMIyRPiOcaghBb5rYam09CgtjYsNtBIqpYw8IUka0VH
	 6YdkrbOaa7bQAKPKkQaqP+Yqj/jSZmkNBCdSv8ciJ0CrEKRBmwF5j10p2KePGUxUnEaCJ
	 EockIqDBXzhVG0Bj4+rkCqYnzpk4H/ITGoeqQj2i16gyalwupVN5fCz4PD5NYr9RqSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683865;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=x08eFSJWECdpEB1+Nn1Ri1/1VsyIJ9XcTh8PmWDvozU=;
	b=rgRfDthHTXdPsXB43K5YzWjnHT+nF/utC1fxdpjockq1gASfkwiwpaZ2/vKvXRYzqDIX
	 lR50ymQa29JOLlSaq61S5J7wdSXLH2MBnAzWtNPzOow/aVQNBe4+mcCtjnDQoPd8rbfNJ
	 m7pV3PA3C5wm2x2PcPsxjtxuGl7x+dHWF+9s8kSapnXIPwrXb4JGlOA0waGONjpvoFQLo
	 vTyKvD34g8g/WTpJWbIxAlD5fOyn2981MhqwaFKaZj0gR9+gxIbuqMvTynME93ighr3/2
	 V1KSdk95sZIiGmSDGf50cGumIRimYOyrrNwBtdh79xEINRuycf1wiGNoh8b0NQMxR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FCr1n6LK;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941D606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3941D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FCr1n6LK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=x08eFSJWECdpEB1+Nn1Ri1/1VsyIJ9XcTh8PmWDvozU=; t=1794683865; x=2110043865; 
	b=FCr1n6LKrbI8oW3DrBFZ4LhPRslQschdejCoxAWWg3CtCBZUY71iyYWz+BjyqEbqi+q9KX6XHuu
	ykNAZOd2flns+FSXyrZX0hLblt77EDkb0y9CYGxXkFeMiJJXiqXCsqUTQvskxNZwSg5hiIGZPKr6H
	DOX9xsyaNekgoAFWGOELNbwyWGk4VMnGp/i/ZS2NnVeg/LTyGSlbq8uWgyoj5Ow4MfLKnkBXftAv7
	Mc9e2if63cMdGMzLnXCmVRae2fMkP7ByM6YPPBCXApcnrh9fzZBBPwpl3HxLmeHF7vXZTtPLBgBsu
	G4FVfDWzZN09PoIVO7EOpJxlIv/NcqxU1TqA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xSJFu-00AgZ4-SQ; Sat, 14 Nov 2026 20:17:43 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 14 Nov 2026 16:16:52 -0300
Subject: [PATCH v2 3/3] drm/vc4: Look up the async page flip fence before
 committing the flip
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
Message-Id: <20261114-vc4-async-flip-fixes-v2-3-d33cbe99ed5d@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=iY87qOAF9o9B2cQ2c/WuwCK7gklnYq3GKs6xfJt0rec=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq+LPGFGQK+Ts+Q9W/z9l7YlnBkebPiiauWJvJ/
 NiY0fTuNYGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavizxgAKCRA/8w6Kdoj6
 qg/HCADavdu8w7AprOBdACwdQeIFfuLHReLgHNMoHGfGkF+UsJGJhaCBFfndDVZID19clXMY010
 c6T7IytB0RPZxxVSGem/ahNCfbLDWfpcSKxyFwk3lB8C78oUj5XhMQnP8Ld+4KrNzAuSCKF1Zub
 AvkMRbsp15uj0sIbyuWeVBZ5Cgey8lFmJvsZ7Fgtw3NaAX4LNdiSvq4mHV0xAU/YLnvF+FftsSb
 lrCB1hVlxubDg8+s40zLegCX90x87gy+sSKrdi+h6qE+kCtdtZV4a0nEF/pVy+P6yvlLhMTkiEI
 wfDR42RsGE+Wip/m2jdxoDnyNVaIUs6Zoa5dHP9m1jbj3iSy
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

vc4_async_page_flip_common() ignores dma_resv_get_singleton() failures.
By then the plane state already points at the new framebuffer, so the
flip is never completed. So, its state leaks, the vblank reference is
never dropped and the event is never sent.

Look up the fence before changing any state, so the error can be properly
returned to userspace.

Cc: stable@vger.kernel.org
Fixes: d19e00ee06a9 ("drm/vc4: crtc: Fix out of order frames during asynchronous page flips")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 177ee27ab6d1..4b6d4a5f7bc9 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -948,33 +948,22 @@ static void vc4_async_page_flip_fence_cb(struct dma_fence *fence,
 	queue_work(vc4_crtc->async_flip_wq, &flip_state->work);
 }
 
-static int vc4_async_set_fence_cb(struct drm_device *dev,
-				  struct vc4_async_flip_state *flip_state)
+static void vc4_async_set_fence_cb(struct vc4_async_flip_state *flip_state)
 {
-	struct drm_framebuffer *fb = flip_state->fb;
-	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(flip_state->crtc);
-	int ret;
 
 	INIT_WORK(&flip_state->work, vc4_async_page_flip_work);
 
-	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
-				     &flip_state->fence);
-	if (ret)
-		return ret;
-
 	if (flip_state->fence &&
 	    !dma_fence_add_callback(flip_state->fence, &flip_state->cb,
 				    vc4_async_page_flip_fence_cb))
-		return 0;
+		return;
 
 	/* No fence or the fence has already signaled. Complete the flip
 	 * immediately, after earlier queued flips.
 	 */
 	flush_workqueue(vc4_crtc->async_flip_wq);
 	vc4_async_page_flip_work(&flip_state->work);
-
-	return 0;
 }
 
 static int
@@ -983,14 +972,22 @@ vc4_async_page_flip_common(struct drm_crtc *crtc,
 			   struct drm_pending_vblank_event *event,
 			   uint32_t flags)
 {
-	struct drm_device *dev = crtc->dev;
+	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
 	struct drm_plane *plane = crtc->primary;
 	struct vc4_async_flip_state *flip_state;
+	int ret;
 
 	flip_state = kzalloc_obj(*flip_state);
 	if (!flip_state)
 		return -ENOMEM;
 
+	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
+				     &flip_state->fence);
+	if (ret) {
+		kfree(flip_state);
+		return ret;
+	}
+
 	drm_framebuffer_get(fb);
 	flip_state->fb = fb;
 	flip_state->crtc = crtc;
@@ -1016,7 +1013,7 @@ vc4_async_page_flip_common(struct drm_crtc *crtc,
 	 */
 	drm_atomic_set_fb_for_plane(plane->state, fb);
 
-	vc4_async_set_fence_cb(dev, flip_state);
+	vc4_async_set_fence_cb(flip_state);
 
 	/* Driver takes ownership of state on successful async commit. */
 	return 0;

-- 
2.56.0

