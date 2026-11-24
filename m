Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506065;
	b=Y9qGzrMw78C46eHA454JV+nKWoxqrVXh+dRKRU6okweb+7PLV62jv6dNWeEM9g/+tuQw
	 rSls5Zv2ydkIbB8EDguUn0TuWcH06omRnyOg5IIwQSMMsMbt1jNuE3kgHJprRXr0rXWPG
	 BnKJkvtnZigYgSC6E47XXEL5hr/NGJTt9+0uApkhmJVXc/8mFmUZ0GKAmHnYV2sT1v0cT
	 bWBY1iaAPWKqhWG+WXTVi2i/xu+FD1uEkIIF+iDOulvZfd8Vk+V7Ue9qjpV4SyLEJHe3o
	 9Eic2aB8X0B+Qtd3sNHW1b8lkD3e8YiCxYqXFsuQXwQwYuLyierHij2lbIOYmY3NTeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WVGnOxIIOZpu68Nyn3y7Nw6nHdmb3NEH0yzfOULERRk=;
	b=KEMAsERFn95FN/fIJ/zhhzACGl4WIURsiOYOGJbDoWXGUXrA6MTZObcWPajfO+ngzcOr
	 dr/SBnhEMDEzRIO4dWh1Xek9NhBG/SlYJj22h7dHuSK6O0LSh6V6cNfqCy8hlqBoZL0fh
	 1J5xTLqamo0/Y7Ld3E2mD7SztjPxIoal6goXm4DNkGvIWb6pKT2N2wz5vXUDtVGsEQ1+K
	 JR/5uMSO0U78ryvBVhz/d8uxbhVC6UN63biHZzLd3smPHPE8DEompQiLB+1bM+7jGC1mS
	 rE6pPSWRDrYxdz3YQLutpRP1IeeD5r85zytV/Clg2FPPKIEJFLhS/1Gn29tFhUn4CNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=La9PCRuD;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B208606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B208606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=La9PCRuD
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so2036670a12.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795506065; x=1796110865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVGnOxIIOZpu68Nyn3y7Nw6nHdmb3NEH0yzfOULERRk=;
        b=La9PCRuDAzv8+KQ7XMikyOp2hPy6GwDwYKNnENUqqR9+qHHJHvf7WHwhzRm1KhbdZQ
         6fEM5kdFSCyegN8RRg/pAZfI+fcFhbPROfQAL/+s7sdkf59lPQd6ksE62a13ZaqhYyQq
         2bEw9ZEVUyutvvQBH1IY6YkLwIzXnaHvhKdW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506065; x=1796110865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVGnOxIIOZpu68Nyn3y7Nw6nHdmb3NEH0yzfOULERRk=;
        b=onMQM/aBBYymSqlDThH452cd7TivYrqJu1iozoe9sgxH9KiBwcSEkF3tY1t+t2wjM9
         upUV8kPNXrXuUbX7IejvHhjcyFI0041KG0hVMkGl3W1KjLo8aQ9E9tCi6wF8pkVlE07P
         uz4Ct0X/R8G2N9tuj7tzwU6BVCYc9vLQnmlkpNvbQWX12u+o6yiFwjyonciagU9jeQKd
         05hbPWBGlsR0GH7ASpCEILyDNYB6RmrPiZgxyvSPJjiUqB4mWYiyG5b2wzncQLTBokN3
         urVp7+j9fCqB8acrLUd4FA3TXLIh9R52zMw/eoGdqZcicdFuLu34x/wMRLyvLpHC3ZfH
         dCZg==
X-Forwarded-Encrypted: i=1; AL+hErHjqEYuKKNA/qZ5r4hyXChl63a05NIb6c1KZUMlcLNU5v6nYUwnsyqj4kD5C7LLA7GdC78q2s8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lfg+DSVwna6vbCAomP+pDvGrPTUdXdWaQDCPrIgIt9IaMXLwM
	V9305ahKhwl/n3Mfd/VflLARrnpYWg1tbTXRhbAtK0usi365xIUE5i34WNkDQeZX8g==
X-Gm-Gg: AZFdTZdSkx6O/LlqisO+q7X6cO/RNoyJRInDKbNDi42lE4bfJTw2sYJb/fVlkSC3+aE
	6hvBtI5ELAaRpMLUxsqiOxkWrrs8Lfdxi8FqSHlvUUNtk3M/2qvXmoaOELI6lSzvO1AFZiZrNjP
	gTeEVx7aNn69acTBboOKhpPtR+ZQiqUh4e9I6UaqiQr/C7+3cUbMbu8qbvZLLF2hpVIyegRmivU
	z16uDm9dNSSmUAAQIwPUZN9Uz5WNXbqyfaM4yNm/etBDJr4A/ETrTTGEbHpLf5AVlIXe81dwnRF
	4OPMkr08dNi5038iffo6tEbtz/PIEQhlkca3+BYcT7uyt+Pi9SzjJtqBUGWrGg/u7JyTN6Q1onE
	CvJll+9I8lTkB4c1lOgSqOx+XW9JoLIJoA0vxSBvWISc2UdJJEPeTH6VqyrbyPCkrvej2Cqo9c+
	U4HnopR8DChXB9qORlbwwjuS50fnUwKU/Jev7k3c2ZmBKCYqYmw0wxPFPmdkqCpoI3D64z1+/uP
	isUI5rr0RmhaTo7Rp17zSsIk7+OEll6/FgtEEweoz/Dck6aV2BqR++rBtifvG4S/BTaeix09m3A
	3sd6NN9ZV7sllkcEr+H5i+ANpQgtTKekGSIDZoPZP9j5+I1faoSrD+RAHAVA
X-Received: by 2002:a17:90b:2c86:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b41c8d9179mr13079197a91.12.1795506064871;
        Mon, 23 Nov 2026 23:41:04 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405d639fdsm24820073a91.10.2026.11.23.23.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 23:41:04 -0800 (PST)
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
Subject: [PATCH RFT v3 2/5] drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
Date: Tue, 24 Nov 2026 15:39:30 +0800
Message-ID: <20261124074041.115251-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
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
2.56.1.809.ga0b61035b5-goog

