Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADE227BB9
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529627; cv=none; b=rSe9KHpiY9MO+RWVXMUMjR1WWGN2blKMmw1AHK686Qy0NVnvTOPwIRUFGqqnE92SnAMCmvYsFf3IwQ6iEiiEbP2gWsfdOjWombdM+ch1nheMZu2mQ3zYAJJiQsbEv3S1Y0SxO83Ayt5K32ZnzQ1yJWKdn/y9A868vjqImPSqgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529627; c=relaxed/simple;
	bh=4OYvQ72/SKMSJjpx0h+y2ofjW3s/V32EvXQ/gsEJdiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKhqu9uRc87JUA5VuinRSJMDblLzeK3hnrYx97wHFS0ZD3JxbOD5ZJfBxGw4uRNCysAhJEteEoyAw95cnMgqU+CHLESFk+MwgI4/Q7Kvmm5lOKuqJK8ZHtMJrq/HyQ+DcXdDjNu3l59GJ7Tmrx+65jyw31UEn19gaxM+dznIeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a7fq152z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7fq152z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso460299a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789529625; x=1790134425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuWaqYdx3lVj9cpjPj9FHjq5qpjsbWLYsj0P75i5UJE=;
        b=a7fq152zP8aYiI5n15olZFPi/PajX7CBlgeB4LV+MKi309Hu9PPvvXwbht15cYVkVZ
         p9AD+/ElEd4IAOUdt5o5x3J8mVbaUlhDctW7H+M+98uUIqij1mWaxX9LI5isXVsalWIP
         UsKgB3miFfULylQopZo6db5LoOZt8jF41TBFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529625; x=1790134425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tuWaqYdx3lVj9cpjPj9FHjq5qpjsbWLYsj0P75i5UJE=;
        b=wzn2bp2MD8bFOB0vuC7jYYVdGDvtrDhybH5xVXv75xzRDofjYIWR/ddpqCfMgPfr4v
         UJ3w3OzDgqH6UTWQlMAWEBHIykn4nXEMbX51KW9It7e8hrZ05gekODST3sHl048HYbXv
         bcp0qPcgnm4qK2GdLGwKBb/bTWozbVrPmwgE08GhdGd3nrvAd6dkt7w9KK2sove2UI6o
         tBsn4wuTzbTBu4MmTGZPrznUlPz+kZA9KZV+2ocx1zVyN99nMDf/gC2M12y6IMZSGc0/
         tl1IciS9TyM2qHKIQvxV89aCIL1aqNc7BUr6EDam9PyTrfGwZSJpHudhHzS8hXYuSm6x
         PbKA==
X-Forwarded-Encrypted: i=1; AKwUvByxYuzQ2dBvmxFyHqq72W1Y7DpZa8hhDGh4TUEeWt9ytLUnXrsZLXbfGEQ4ktdeRBpVMy2ngEk=@vger.kernel.org
X-Gm-Message-State: AFuF++nTBXvMngVC0ttopKscztpoXkZ6chS0I4K9jB+vcjXf/rQ52Rqb
	/IMcK2YPDd98kv5eelKnrg2LndTMAYeHFqJEZfPJqsUyyqqWZXlK7rUUVDBM5aEu8g==
X-Gm-Gg: AYBFou1sp5DBrM6AGEOFHCV6EL4iCbNfnNM0cfYzx36s5/vs9SXRj7QHdfLLT3jgOXN
	flU4W/8lCYpyxhyCpRFmWtKrqi40p+AYPBSyJDm8xqKy3BRY/HNCFVkiiFiuAKWYpz69dMUd1Jq
	Djk45N7GF3EnakBqZ6dwzWOPbSL7jCdHzjzeVaYbMJCTXre426j6DHm2DpzMy5FH5d2YIP9rKyg
	7ucRXjcIj4tD+CEANL1S/f4UOTxclfCUZqyy/No4HzMC6bH5TmzcjNbTYb3V2eEEugwlP3D15gr
	G4nXOd8H+DmQwc9Gv8tgZ1bTlmePdCV7SBCA7aSGzLCgCedxeE5oBCuMyiGnhmCbEeZreBAz6V1
	QHGgzgv9Yszd16OVgQU0gYXc/DyVTlKslFyERkOFzMP2uvw0q/R6/5EwHuh3oDzkrqpakP70SAc
	3epCj9XEC604lfntIE6rvAgEOj1KVvzInD3EL5q1y1QjkXwdQi+PxCF8M19nMAZNQfDuDjZfyKn
	lqNDTtx9XDmE2/L6tOoqIROuh34PT+ffV2fR7roIjoapQQ2mMkFpiAOZA==
X-Received: by 2002:a17:90b:2604:b0:39d:f114:8f7d with SMTP id 98e67ed59e1d1-39e1e27ad34mr2355684a91.3.1789529625104;
        Tue, 15 Sep 2026 20:33:45 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:33:44 -0700 (PDT)
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
Subject: [PATCH RFT v2 2/5] drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
Date: Wed, 16 Sep 2026 11:33:23 +0800
Message-ID: <20260916033327.3054126-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916033327.3054126-1-wenst@chromium.org>
References: <20260916033327.3054126-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

Cc: <stable@vger.kernel.org> # dependency for next patch
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Use new drm_framebuffer_get_block_offset() helper
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 37 +++++++++++++++++++++++++----
 include/drm/drm_fb_dma_helper.h     |  4 ++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index ab0f37d8a5ff..0aaf4926db4e 100644
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
@@ -86,6 +87,34 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
+/**
+ * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipped
+ * framebuffer, for pixel formats where values are grouped in blocks this
+ * will get you the beginning of the block
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ *
+ * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, clipped.
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
2.55.0.1032.g73a4cd73de-goog

