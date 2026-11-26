Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677218;
	b=oyL4P6q9P4f7Op7Csg6NgZLA1t9ZYDrk1Krza8wtPEv9mf71fm4DMNLed4qksKdXo64v
	 8h7jzY2Xq7OxKk2aeHZR/1Bk0TI1AGWMV2Al4TR7cPeWO3Eq8/fbBIoGJFrOVvIiTByX/
	 Ud+vDxv2XoDzoZKBwHK/C6cn2PnanIvPhDcBtuodVZ6inChyR3KYLwISBhRH4ggyLPPgK
	 mfUayVIRwuDlbJXFaE3a/d2TUK6ySLHuFsYKegoBferRENNAaSwAP/YjtTUglm4MkVONx
	 gvh3ngJxFdJTgleMq80kRDWPxcTev+GJJ8VcLPRuuwG86bdb3J5w1cogiDmRuiETlAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qPWijXdqnnf31Uvd9pQegZ3VFu+gZGvbQbzLAzg1T+4=;
	b=09OOX7ZRpl6oJScrxNeiOHRFk0jxFmmalJCgHJlwkjse11c5DaMxZNLnJS7zbKUUjPZY
	 gZBrfxVekf/9W4vQEZYLddmtSuf12K6JwGsyeAnepMOQ2otGoGCU4mweBzoFqC3ZJXRTA
	 ezQOLTxFacSURggAlnpeI5JriCrEDNlGJtegUR8yVZZB4bXxRJQwzUJpynXcbI475ex5K
	 wJq23M5CcqXygk8P/6/ZPZ7RnUjAvXd9q1xK8g6fjLzCnlUoyO4xWvrPocllk3QVk0Nyn
	 LjzZH+mGsH0EODsv8zRY2Qe7ymTazPCAeTs+D1HmSswcv9Aa3rFGHL2JJe6YXwTWasQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K+nSo8aW;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F4606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270F4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K+nSo8aW
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f04f61282dso30871635ad.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795677216; x=1796282016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPWijXdqnnf31Uvd9pQegZ3VFu+gZGvbQbzLAzg1T+4=;
        b=K+nSo8aWWYUhWLctSI6XrsJCc5J3YCSeDOz0ByX0mzEoXkxlwSANd3UOLv0r5hDQCW
         qY0Ao63L8oWN49zH1gEke5DT16oXWkmPKi1frdRr+ZJxHAshwZ9QGEtFAI6VAdOi47w4
         FRQO9/LSphipaywD2FiXsIGdjgG1stipwepQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795677216; x=1796282016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPWijXdqnnf31Uvd9pQegZ3VFu+gZGvbQbzLAzg1T+4=;
        b=RwhO9590eeLgOr5Q0jmSpRKFn6PKsKRNWcnPKzUmENrF6lJyyehF3+ckDWMpFIXJzk
         L2FA/hXxLf8Ksfz2m9c/JaQA2VhehyjDCu1ZQy/TxbOc1ziVZ+4/eRrFNL0OPZZWR/DH
         Hc4NrhkH4PuwKH8L0KuKMfWcfRnv70va4NqPpAlsnehQCUB1DJLNMOjGwG2dtbcBoy18
         +DLMHXyUidweuzClwIdebFJ9eimfONH9wlWIfk3jBu6W7CUtRbEmrs6zmD/P9VZ1HnmV
         r2/QNvFZ7LK1hSS4oO0M70Jd8/4ch/dwck/04mi+L4AQ9RI73Ea47TTGcrd84UXWE45w
         ZppQ==
X-Forwarded-Encrypted: i=1; AL+hErHZXraBONgABgUOSrd4oi2IbrGksSsNZRi/AOZ3Xqm3YTQOYScuTcyWbrki7haX7r/csVECV6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ocntukldVXUNY7kunZWlE71WVcsxN/cF1jxfhg/3e3jEd0yTS
	V5VwDK7dDxpiNdRkPJR3YAicDwh84bvuPtprdMBH8/xRnlluJWY0Qq5LqdPTyt5SEw==
X-Gm-Gg: AZFdTZcEL8LiDNllbgkAul6DJ5Tv7Simz3nCuxG1HoeecVMqV2Htmy5tNGCx5LwXoHx
	hQd3wP0k3RTGFhy1mB67LSLmKgsLuYJbUJhE2yWNMditdCqFK9FPisEfc60yv7Qw26JojPDIdNm
	FqWzQr23i/U7gya2qC6E8NXznTx6tvoLnYG+ToyC8UlBT8fOztF65Nzffe/tPcSuIyzOB767OK2
	6LrUD5iLUsqQ1VkE7n9cgpb5EX/nA7cjeloGHH7BGsrYAO0q8gsCAtgNy6YK6+tLHdN70pQORzh
	aJhQ5db/SXcRqalIXrIiFpPqrKBC9f5+FZOdYUYR5Kfd09fD+6ZMf8PskW4/kgmuUC0p973jQjK
	Y91gWrLFqBK8qJhGyni2QqomDFSu++Y3iUED5sIhhh07xZvwkall9XRH/bfkDj5UDoMYxZXHJnF
	/l8SmzsR3kFrFotbYau5d9gMKdiO4U+1f0iu86uGRC/YNFe3DAua8mY2RyzoKcVoNTabI32ZB+N
	gsL+OZpbA0YlVTdPQmREwJGkH7u+h7BCDsOOPjMSXXX+qu9V1jxgki61HW4BN9ssd4+qlsLON+g
	pVwscRIWiZWC9L+HnJlMCrSNFvZrlW8sj2TpInraUxv+yVKNfohG+6LvnnO3
X-Received: by 2002:a17:902:e847:b0:2ed:c9bf:9570 with SMTP id d9443c01a7336-2f03f1a4599mr214081945ad.26.1795677216392;
        Wed, 25 Nov 2026 23:13:36 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2f03f120769sm99461835ad.57.2026.11.25.23.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 23:13:36 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RFT v4 2/5] drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
Date: Thu, 26 Nov 2026 15:12:50 +0800
Message-ID: <20261126071314.253890-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126071314.253890-1-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
framebuffer. However some display drivers want the "clipped" framebuffer
instead, as they are also using the clipped coordinates to program the
hardware.

Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
the source coordinates replaced, while others have been incorrectly
converted to using drm_fb_dma_get_gem_addr(), which would end up
causing incorrect parts of the framebuffer to be displayed if it were
somehow clipped.

Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
drm_fb_dma_get_gem_addr() for these drivers to use.

Cc: stable@vger.kernel.org # dependency for next patch
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Expanded kerneldoc to explain clipping
- Added comment to highlight different source coordinates used

Changes since v1:
- Use new drm_framebuffer_get_block_offset() helper
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 50 ++++++++++++++++++++++++++---
 include/drm/drm_fb_dma_helper.h     |  4 +++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index ab0f37d8a5ff..789e6ac42c17 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -60,15 +60,16 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(struct drm_framebuffer *fb,
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
 
 /**
- * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, for pixel
- * formats where values are grouped in blocks this will get you the beginning of
- * the block
+ * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped framebuffer,
+ * for pixel formats where values are grouped in blocks this will get you the
+ * beginning of the block
  * @fb: The framebuffer
  * @state: Which state of drm plane
  * @plane: Which plane
- * Return the DMA GEM address for given framebuffer.
  *
  * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, unclipped.
  */
 dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   struct drm_plane_state *state,
@@ -86,6 +87,47 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
+/**
+ * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for the start
+ * of the visible (CRTC-clipped) part of the framebuffer
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ *
+ * A plane may be positioned partially off-screen, in which case it gets
+ * clipped to the visible CRTC area by drm_atomic_helper_check_plane_state()
+ * (populating the clipped coordinates in &drm_plane_state.src and
+ * &drm_plane_state.dst). For example, if a plane extends past the left or
+ * top edge of the screen, only its right and/or bottom portion is visible.
+ * Drivers whose hardware cannot clip by itself (i.e. accept negative
+ * destination coordinates) should use this helper instead of
+ * drm_fb_dma_get_gem_addr() so scanout starts from the visible portion of
+ * the framebuffer.
+ *
+ * For pixel formats where values are grouped in blocks, this returns the
+ * beginning of the block.
+ *
+ * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for the visible part of the framebuffer.
+ */
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane)
+{
+	struct drm_gem_dma_object *obj;
+
+	obj = drm_fb_dma_get_gem_obj(fb, plane);
+	if (!obj)
+		return 0;
+
+	/* Use clipped source coordinates state->src.[xy]1 instead of state->src_[xy] */
+	return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
+								state->src.x1 >> 16,
+								state->src.y1 >> 16);
+}
+EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_clipped_addr);
+
 /**
  * drm_fb_dma_sync_non_coherent - Sync GEM object to non-coherent backing
  *	memory
diff --git a/include/drm/drm_fb_dma_helper.h b/include/drm/drm_fb_dma_helper.h
index c950732c6d36..b2a0bd7ef9d0 100644
--- a/include/drm/drm_fb_dma_helper.h
+++ b/include/drm/drm_fb_dma_helper.h
@@ -17,6 +17,10 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   struct drm_plane_state *state,
 				   unsigned int plane);
 
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane);
+
 void drm_fb_dma_sync_non_coherent(struct drm_device *drm,
 				  struct drm_plane_state *old_state,
 				  struct drm_plane_state *state);
-- 
2.56.1.839.g22a8290db9-goog

