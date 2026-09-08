Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1953511214
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858490; cv=none; b=Qn7/41S4SXix7dV/yL/uccNdiSigYAxYqzzekkn6ST2XYAmeZrxumKYg53GqQhtUKfcT97DZPQ+T0/kF5bIK9gLl3gbn2+0OsnfLiTWPCUfLXoxGybuy57FoL8Z9fWusNxmQGoeezVJa2Dx1fk3ZhkjAkWHtcSQ60Mpekc/kJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858490; c=relaxed/simple;
	bh=xMbO6EhJUi/RdJ3ufWkeSaYG56Ls5TGr7006uLTOZQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1XqzOMCig/1dwFzaVHpoZ2QnPbdldSs/KrPafLEyeFD09IQnU9deUR8Fx4a0ph3ioLFV67ZmWFomDMSZWhbaU/pUZzru+m+i3BTqy+Odr9+coFhUF07+Xaj9kY410KHamrwI0XeQROaxpx2p6kIyIhZtruvkCqYLtO/8obi5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=niUkD29j; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niUkD29j"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3493380a91.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788858488; x=1789463288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZHoy8f3OpVjs16q22My2K8o0ZC/itaQqMauUbs1Www=;
        b=niUkD29j+ocgb+VJodWgsfyZ6FBfa51mJd7qwUCkp/haBaiZWWbvtyDmr1oj7xoziR
         flGubBpOylntQVUW5SI0LSXeDfpsPzWfDVGWBsYjfrUvknGbSVKNY4xKt6krm+N0N2Al
         hBMLh1PcY4pQuHg4iqm0n0aH5/m94N44YR7vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858488; x=1789463288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZHoy8f3OpVjs16q22My2K8o0ZC/itaQqMauUbs1Www=;
        b=YJoTRNqWfZOdnHfT6tYCDljZDnkEjT3+LiwftJGt6hj7TY/2HDXlO+cX4qjxuqadTy
         sB8fy8TR2NVizIUQULDHturvBbDfoTxpxB/q8hDwrptBBKm5eHx3x+/p7UjxK2uWS3vz
         47t0rstg2eznkRtwr2pGyD9QEMFJ6Pt8T+m+7BCWOEKcavDtgcnNbCx2ztVkdUhXdjBx
         +QLArLLUbA9+JTQ5rgOvgeX3KIL0C+zUjKJ7B2I9x2iAMSrMJxcmxYxm8HcX0qKNPIBW
         ECzqQD9MhtKSGdzBzdUADh2Tp7IpS9gCIBp1ntudwuzLtVWq2bAXF9PSxA088qzIlz60
         QG6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhYzPrCiVBOukIJA4J+0NlQFeRuZ1eNd2lnbIPC/35Wy7IyzWfyP5zOnhjYHjJiDIEAEMeWVA=@vger.kernel.org
X-Gm-Message-State: AFuF++mwM0ZlUupUx4F22rWOocjl8YquyrKfjoc6a32rSEYf5xJ+64bH
	qk2SHY3YI825HVdb7do3WI05pPXiqOlms4rksaA4amj6vcH3NAf9RSb3p6VQGFukng==
X-Gm-Gg: AYBFou3goydbNcE+b604lH9N39svPccBTMQG5w1cp20Pwq3cxQwyzse90d3iWQCzWe9
	BzTtgt5J+HmcEiuJDRDtoJv9U9mH4q0M/ZK6XwG+o68B/6uJ1WqUKRNKcm9eVhZ2kGbJ7yP3zFF
	lEGY2Wnh82+sudDEXmXfSCDdiq08IfRI7hgZQAfC85PmEwAbJnpKFJCbghZrJcMI0jSecGR/bLi
	koxktIpvTKkM15Ae3o4WFnFeUUtkb5rfXO5u7NCSfpVTmxd1viT9zDaW5gW39H66XO9L78NeNIk
	lxih3QQp0F8nmuuYywxj3hAXRqYG+Ep+MSz0JToXrXoejqY0Ec74VkM3YqL402aNY1aFqck0SDa
	ChICuaa3SSRYLuIzsIvZruxCsiL40Ef6MwBknokFVoN/6/6ToBx9JyZvCVYiK/McN64ScLG1Fc5
	8ONZeaWApIfwvr0RX9CaXxNVN9T1TC8qEjPYb1utdYyIU1H6aNQKeLbbvVSHGobXt4oiA/LnukO
	k7ZabKDOTR8v/5ZZIg6ADSF5IFLRWWKmDF0ucR1CqcgiUH/GcIopj3Olg==
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr43384810a91.21.1788858488251;
        Tue, 08 Sep 2026 02:08:08 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:08:06 -0700 (PDT)
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
Subject: [PATCH 3/4] drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
Date: Tue,  8 Sep 2026 17:07:42 +0800
Message-ID: <20260908090745.1089143-4-wenst@chromium.org>
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

The hardware is programmed with clipped source and destination dimensions,
but the framebuffer address is calculated using drm_fb_dma_get_gem_addr(),
which uses the full source dimensions. This will not match the source
offset if the top and/or left sides are clipped.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Cc: <stable@vger.kernel.org> # Needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index dea7404fe659..7bab75d5dedd 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 static int dc_plane_check_fb(struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* base address alignment */
 	if (baseaddr & 0x3) {
@@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
-	baseaddr = drm_fb_dma_get_gem_addr(fb, new_state, 0);
+	baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);
 
 	fu_ops = dc_fu_get_ops(dplane->fu);
 
-- 
2.55.0.979.g7e5102b832-goog

