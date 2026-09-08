Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876150EBE3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858485; cv=none; b=ElIPK/QlQvjTA8kenBhXKGvprETQyIc6wH2O6JTmcZW2gl+t6t6f7ZgNJlTi8Jg0uJ6JFOWzadbU/13GV79C1VQRfJzO6Sw2aSFqovSgwpp4qEuuz8XLQS5FBXfJskJ6stXawSL6uuLYeWc7R6z9kudv70ZStzF870RfUgcCGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858485; c=relaxed/simple;
	bh=w0FP0wBCIa+/EHsZH1IzuHconhrkS9VP6UooovR5/Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9eka15ixEFIFBN92mwHXkvhU8NoxGlqQ3z1my/NewkrPJMRzZ9sUiyS5eTXD6YWfPym70n5RMMz0paKjgFFUJLNWWYV97VffgBmhvubTMvYpMBxaBIELsjpsiqyKWUeJgKEmDgekDIfSKg4x07+fjSJDZ6Me5vUi8Fn+MJHgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fSTLCwo9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fSTLCwo9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so352399a91.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788858483; x=1789463283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nbiAaHsEOkyMIOSUPLzzSXJU25j/HCglaTjq/uSdS0=;
        b=fSTLCwo9UlzWgwAlMqzzgV5X0WBJS+cYSP1bhB0f4FASEQmrPBaNzjqhfnsjfCPhXs
         Dq4QuTbyisJVdciUDAqPHAq+HA48WrgF3s99pQDcGzAgo+5cDwdEfwS3/izeG/I5zTx3
         suMQ/jBrFH81/gHPGoiekUeYVFNZNtQB/kB14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858483; x=1789463283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2nbiAaHsEOkyMIOSUPLzzSXJU25j/HCglaTjq/uSdS0=;
        b=hwiOyv69hRKV8osAor6s2gd6izGmb5mNXsKygMUnvCl074JLpsIMRADQJZyh2mIrNz
         h2RP5CI8niMyUT+5qAeSa9FFcLJ7+SxXr9UcXD9eiZZBuvO9gua+xIrn0PcXcq+xlBoN
         g2w5S+0qSQ6JetmiAh2Oda2kim69pCNQmzm+ZgrjWJEA1IxIvaqkdtTl0icNfU7dO6dR
         +1oaTsYRE/NaCABr+udnP6G1OA/4cmHrhKY5Pz3emirCkUssB5HjwrzP3O/rhj5T5yt6
         3mkt6Q8cMnleRJNK8nr4bwGwx1ylO9rZFhMoq9xNotNUbJEMbTvj/2CQ22VWA108apL2
         BZsw==
X-Forwarded-Encrypted: i=1; AKwUvBw5aPXiJWyFnxdZ47IKQbdXZFBHKIMpxjVFSe6yCcZJOWvfTdJzQL+eg1CjdcUJd42fhSk1B/0=@vger.kernel.org
X-Gm-Message-State: AFuF++kHvWJTA0BpHTsA5Wrjk32ur7S6U83CvGSNinU7BoJscuulKyS0
	pHZsN1OPdO548Gyg+F7r7lvBiZxMMn+mFyhxhf+gidKpiIKSkid2ZFCiD1mlySbALg==
X-Gm-Gg: AYBFou3E3BkZoKgFfszy/hEfHzWmKw76SBYmpqNTaB3pFsIlJzClf6TvZIKi/f6Hl1n
	QHU+sqWMrJ7LFyDDxwICm1y0iM6t9QuiTOcrk1E7v11XQtrOlIrPMGRHe0QY3TCMcPv/1zFnBxB
	e7K59Ie9Tc8MWfTwNnue5XgydklaaE42iOPBsvjK5y7VRJjHs8N6UwyXTLX3RTriCm1w/0rIxA0
	chhGrsxfLcqKz2E9604PEZq58u56Gc+Cyfyq/1T4C9T1tQl7ubgQCgC0TLHzIAT2fiX89aOVtXs
	D0gB3dUh9ckyxPjWRrE7aL8h4VBSpWYqxXQR141xky533QDglkDQgBQqVfKFFAoItXjdlAaUNJX
	L39jAeoy6LBzj3jDavAmpN7rZL2wwuawFHnX/0lEGLiDKDfMLpkc0f6eCgY8v15ym189iL9JiHO
	4WSkitT2KLnOCdUK5FU7gqfQun3NQiAIA1rmRMTGBD0lspbPdf/UNr9YKmalRMFuQcIVU7DzFIw
	Most6EiwzKV7G4Qok7iPd4nZ86CQ2RhBG5L0IeOLUt8zso=
X-Received: by 2002:a17:90a:d010:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39b8be7a13dmr4691886a91.10.1788858483369;
        Tue, 08 Sep 2026 02:08:03 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:08:02 -0700 (PDT)
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
Subject: [PATCH 2/4] drm/sun4i: layers: Fix VI buffer address for clipped offsets
Date: Tue,  8 Sep 2026 17:07:41 +0800
Message-ID: <20260908090745.1089143-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908090745.1089143-1-wenst@chromium.org>
References: <20260908090745.1089143-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
index bad102134726..530efae7e13c 100644
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
index 2e9cda45c04e..7a1d5f1db037 100644
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
2.55.0.979.g7e5102b832-goog

