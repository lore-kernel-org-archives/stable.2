Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677223;
	b=irNyKCt+mGem+ZdLjtrVpF+vEJBe1qT+mSr3c21FsNiX1YXXw9lPpdGIUCBdYXOsVW+y
	 5q/98t7jg2VCV1oh7wmBvEzNWw23L+lFoE8DXL50c6REUzq2wF+YFLYN4xpcA0OGWtARO
	 3VW3skHsDpIft5k9YZl0RzmkL3xtOcn6E6KjcUwXYllaTWobJJwB2LH7QADKp1wbvsqtU
	 U1rYnVlZUJhYhksDR3m9IqGG1Mw+PxEAdlAH6iQGuJbLTMEI6IqSuay+avfDvAkNDV2QC
	 xvs0vQvIs6KDxW/r9SD0iarKHGsse5Fi5jRQuOxB/YiTGsMQlhnHB2qRoHYhDeGoCwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cQV4QP0qYKuYxZ6jnr2bO2k6G5yVFMpzRyKHmSwnLAg=;
	b=XsxJQ9qYsxsWUEhvvXn44iPOjyuoxn+VKjY+nS1StsG2NbT9md804gUYn2u5KgVaQJTZ
	 l1GUqUtlY7be1ly8Se5XU21GU+uODhVi2guBpSH905kz29qA43HHveQhancZmiYAvgCWr
	 jXi0fT2voqdOtNioLE5ATLZY4ju8fHWqZoo+UNVPrpgp6xhViF2KNGZGX+hyxQ25qjyra
	 d4F44IipVYeEmiuR3izVDeFnHzAVuDjmwbRa4bTsPVukvUhtr0LpZNoYK9SQqMhKlGD7T
	 yynHGzlvVgHB1O2W5TingvFno2kV1ISq+/oZeV85FxvsVipCAq0IHpVACsrZ0kVOeGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kLhjqtux;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFF606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FFF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kLhjqtux
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso3591402a91.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795677222; x=1796282022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQV4QP0qYKuYxZ6jnr2bO2k6G5yVFMpzRyKHmSwnLAg=;
        b=kLhjqtux6XoFLiVz7cXR0eao5WOFLPaFrl1O00H6GtHUmF0WhrPghAuGlkfsFuf+fG
         V+cNsBABihBT7+EHD6CC+Wdw5tGaTOM6H1+N7RltSrjM21U520FEdxwQxLS4P1HFmc4N
         PsZEymLv9qpZs5qqghTiniJK7T4XvOTFbWYSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795677222; x=1796282022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQV4QP0qYKuYxZ6jnr2bO2k6G5yVFMpzRyKHmSwnLAg=;
        b=frr46smMZ1ZrVYuJK1ZOKrH2FdzvUz/kbrUuXki2NhRlMn0z15bAcaif34iBLzGNue
         9hncIgDlYBYoMXAcfAqaCQiL2UY9bUq04oHmGLhxyJTLc2mRcUQ7PIIUTq0TMW9jf7AI
         SgVVXP74Ndo4QNYI3QYkSZgePC63dmC/zwlLvxLuasWjZcXDBqDF7AR2hWwkAPzt4jya
         qpg5fBQ7HP39l8RXfKh5NY4nfWQV5tJIP/gLgFo9APt+nCzmppzz9Dpg4oip7LKMPWgI
         OMOWq28tlrm4vmX/P4Ak7/bktwtAZQ1YaGRtyv9hhaxv+qv4xkYQjUi5+q/X37HfJS0t
         Y/JQ==
X-Forwarded-Encrypted: i=1; AL+hErEzuKVkQ1DIbpyKuUJHT2ivb5Cb/NfujEzNcuNSJriqbBy5O1/IcTJvEiChlfPjISUSC7erMkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pHoQhC34t7bPMYlt75QW2m8YXb/KzJKKXJa4sAcpD6SjckJF8
	BWba/LGnpAgcIXnWw+/5I8J1JcGprBNvE3fNAJ8exufcUYec1iV6xSY2Y7e0tkt+GA==
X-Gm-Gg: AZFdTZcW+YQ2uV3v5rzSe/eIvb+yRtYXusxNnCUdhJYu2+OVITF4VfiUsPxLgyfpEOg
	lsASKCF2wKDbiV2IcjDXS1WQ3D4KrWvNlPa9a62MoVmc9RB5RuS96ko+MMQFv7X2jmeRKwRpYWO
	kou0B/rpJiOOoJ/so4xIwzFS3ceEdRPH03ZHNOg69Dpf1p4DELNlvohiZZDuwKa/kHHFyUwgEXY
	SI/PIGwgwX2vpx9z9U3wNPb1zUX5RR6ShEaYTX6qdgHdqjoJ69mdQowjsyIatbxKG/gPeQaC1Lx
	aF9aI37gv0I49bqkl7kSUiWAuxrwgvYcFGD25z2epH7YgNmqA4Ypoohr7GPAnS4z7U5Zr6rUpyy
	ZDGEf0KFaaqBczFvjPou/qkWGVR+biF/AYjg8t5y1anjA0QDgu/9bD3tP0S4eG9m35KJrN64lOz
	d+90fa5h6d7PUdLZJMm698Y5kRmnchEE61TuWL/1qHJJxg+XFu3qloQFDj7pdqHasS47y6erRhI
	fuOPi9grtRlTLGP1PJVCvg4+OgFzprVII3P7hx1ZUBENJ5m57UTGCMCUWv4q+y8lsRjA83qPsuT
	GawuQSc+2tkaL0K8lKpajn7Wo5nwXGu8fdof6nukrfKYtzr1FPNDcCmFz3o3ayGQ2t0LlovjISE
	Xco/SfQ==
X-Received: by 2002:a17:90b:4b0e:b0:3b1:8380:a9a0 with SMTP id 98e67ed59e1d1-3b41c95c18dmr20709401a91.46.1795677221915;
        Wed, 25 Nov 2026 23:13:41 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b41ad0b52dsm33777492a91.5.2026.11.25.23.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 23:13:41 -0800 (PST)
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
	stable@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH RFT v4 3/5] drm/sun4i: layers: Fix VI buffer address for clipped offsets
Date: Thu, 26 Nov 2026 15:12:51 +0800
Message-ID: <20261126071314.253890-4-wenst@chromium.org>
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
Cc: stable@vger.kernel.org # v7.1+, needs drm_fb_dma_get_gem_clipped_addr()
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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
2.56.1.839.g22a8290db9-goog

