Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506071;
	b=TQ4yTEGT6aE3Q4WLvWDztBQLJb+qdLBne3EXUY797PqNtSQ8Gu31os9/T3FtbkEJmbDv
	 76VvK4or1JSLE1nrtIaUBiriLnDdBbHt3arN41fiYhBe4SdZavklsB+9/c7tn6W9ey+1N
	 RHpX2H7ykQj+lJ6RkrUHG9RxkOpkdI+FhfjnPvzdHmQiq2t4npX4UFIPVPqPb8fFA2KXk
	 7Yi8q+4ylgYTkOQTjeWX0aUJoC6wEkqQLTyhzOi+a3hCoucoN6UeoE1KFyaxGmrp5yJx3
	 dIic3kCjI1ku2sm8hYbcV0dyXne0HbeNYH5rW9eIZFUvyzXXOmp5XfSZiLZNjuFecOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZnUOXR4q7AEOdZeeEt7YaH+i+q8V7R+T5wpH12+fNyk=;
	b=qeCNVMLNWC9bQJTbJXxQUn+ut6o2zmkjlOqcbLMznAd8YKFYhtlZK6H7i26Rm7sBQbRW
	 BgDybc/B2DBag+VN9n/7TXcjEhr9P6idfQbN6ItUzNucGToXJuGg6J1KuDVo5oQtWSIM7
	 zFhRKQ9d+GQf3Z/S03GV2DBEEunyjwfU3ZMzW2CDuHvH5POx1Cl+rtBj6FSo8sQFgVBXd
	 a8OVoTcBAo6txaVTJBl1YWl4GUMg11HtA5ak+HwjSB2OsayxNvfK+uWGAc3u3nr95a1rk
	 nwl+MJMwhQgBqepwfoVmNSPyFwWZnNVqFpp2vS5jfq/9eYongoPdpu0IZrFkKqv8r0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oCkXYgUB;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B302F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oCkXYgUB
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f05b465cd1so19754175ad.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795506070; x=1796110870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnUOXR4q7AEOdZeeEt7YaH+i+q8V7R+T5wpH12+fNyk=;
        b=oCkXYgUBc8CpQKqQ1dBEFkqdxwKK2JcvfOKmYKCynfR4vOhoT5TSnMqbjt5VHPBl2W
         1yKxt/LzTIf8xlpuHEWwifepSNlMx8XymWPjGjVS8dXLzRlGlj2IIoTSARf8jPpx3wSx
         bgay1409kvvx1UL+c6KothhJjK5eVgEUy5QF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506070; x=1796110870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnUOXR4q7AEOdZeeEt7YaH+i+q8V7R+T5wpH12+fNyk=;
        b=p0WIthj7E7fd6bd6XbdezgRQH6lf+2jezJFjai/NFOXROn2bZHMemf3C8OuhwKbrVS
         KDbFYM6MW6fI6hLlcks1j20SYuUimuV7h2y+5e32jWEe08cVTPH21/abaHXYMu1X2aEJ
         YKcZvb/GdLOAPdYF8mGa7uXZvQ2JNbnIBf2UXNz2ArA7deUfrkGHEajfMLIi5Q2LVHyq
         8Vky2eFodVXpS6m6eqWfqDmzEoHvNRq2cs4krBuZ4Auu7o7a1tEhDr7h7KQorqmWuRDm
         krcjb7BsHSIc2aTyk1n+lKlQYnkRg44LOnGLf3aEeHsv22gBEiPLfV11O40UVDVb9Rvx
         e6JQ==
X-Forwarded-Encrypted: i=1; AL+hErHzFFL1ScjXvAbEiHrX2O+PEoLSAmW6tuXw8ygbtEWOv/60n9BAViedhy7CRvc+8TaGh/ROOd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gKc+ypisg+CKuRzxEwcXfPfu5LS06HyXWr7x5dBjgYZxbjB7l
	PiLyPuQsyZcAL1IK+Mtmh8YCzvW6fxkYd/k5ikjrCb8QQKNgh0mDKoOtUVyYNkRW9A==
X-Gm-Gg: AZFdTZe1qNYCNQZJx7/+FH5VzvbFLvQbMp+Z31fhYhBBNyffxDNLuArAbgvPx/b41Cs
	R1Tr8OWBkEFncP+/+rSQWDq/+o07odI65w8iGBsYb8+uoxt8Jl1Y3g/XpjMLBEYw4VYwhoRKwlY
	eFFJ5oThoWe/Jh59+0tz+N6ZKlfR3SpUBZ9BYaCbQYpjzcSHfPQCaC1TXSvIxylehgH38tWMh6W
	XDVUibsZl4EpXKOAxjK250dY1DeClXCbff8OY12xuIMhBtI2GplR8PfUD5v6jppwySMVlpsDsdT
	6ydr/1YV29Qbf4lmOvL3619K257KJCjCZ8n5cUO0z9cRW5Qf1Iwfoe5cYsKYFW+gwsydyO+vTre
	EspkOPPEBGyjgWRgt7vw/KluUnb+POL5lB2k2mKYvv0AGKGzq99OU9YigfBywC1ZSiTPUAIJnUY
	S9wjd7z2o24u7SkYpg/tUtyztw2p6y3wq6TyOl7WlZNbFx69UYFRIARJF2Z6/dt/pWcF7V7AJZ3
	jDv072slWaTtlnFCMBF5azMZcpDaJdoOEl4L0KSzCDnY2yhe1ZF/HOIcLPSikR/JP1fp6+9AwY/
	e+7H2b9EKpuo7RpRydmJyXIxRyg3gDcbSu614A7jc1+5ujmquQSbbqhudQYl
X-Received: by 2002:a17:903:298c:b0:2e9:5714:6075 with SMTP id d9443c01a7336-2f03f117c82mr126158455ad.17.1795506070067;
        Mon, 23 Nov 2026 23:41:10 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2f04f6049dfsm55300615ad.19.2026.11.23.23.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 23:41:09 -0800 (PST)
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
Subject: [PATCH RFT v3 3/5] drm/sun4i: layers: Fix VI buffer address for clipped offsets
Date: Tue, 24 Nov 2026 15:39:31 +0800
Message-ID: <20261124074041.115251-4-wenst@chromium.org>
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

Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
get display memory") dropped the code to calculate the framebuffer's DMA
address in favor of drm_fb_dma_get_gem_addr().

This turned out to be wrong in a couple ways. The hardware is programmed
with clipped dimensions, so it needs the buffer address to start at the
clipped boundary. Moving to the helper negated the clipping. Also, when
clipping on the left, the buffer address needs to start at the first
pixel in the sub-sampling group even for the luma plane. The hardware
handles the interpolation internally.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary. Calculate the intra-group
offset and adjust the luma plane buffer address so that it points to the
start of the sub-sampling group.

Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory")
Cc: <stable@vger.kernel.org> # v7.1+, needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is an alternative to Jernej's original revert:
https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com/
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index f9c7f28f9fa2..67cce1b0e70f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -130,7 +130,7 @@ static void sun8i_ui_layer_update_buffer(struct sun8i_layer *layer,
 	ch_base = sun8i_channel_base(layer);
 
 	/* Get the start of the displayed memory */
-	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 4d3fc03f9877..b6796416d550 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -205,7 +205,21 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 
 	for (i = 0; i < format->num_planes; i++) {
 		/* Get the start of the displayed memory */
-		dma_addr = drm_fb_dma_get_gem_addr(fb, state, i);
+		dma_addr = drm_fb_dma_get_gem_clipped_addr(fb, state, i);
+
+		/*
+		 * The mixer can handle odd offsets into sub-sampled YUV
+		 * planes, but needs the address of the first pixel in each
+		 * sub-sampled block. Adjust the luma buffer address backwards.
+		 */
+		if (i == 0) {
+			u32 x_diff, y_diff;
+
+			x_diff = (state->src.x1 >> 16) & (format->hsub - 1);
+			y_diff = (state->src.y1 >> 16) & (format->vsub - 1);
+			dma_addr -= y_diff * fb->pitches[i];
+			dma_addr -= x_diff * format->cpp[i];
+		}
 
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
-- 
2.56.1.809.ga0b61035b5-goog

