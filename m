Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677229;
	b=bIjqoOIa0Hqrgs8VHLz0ydEHMoSbUsknkGq1S2HmW9hX+KxuvyXVfScU+8CSDu5lyvJv
	 qwAYphDajrcjefsOAJCWPS0Sit4J0j/3wB63Yl7bDpqyB90q4IlRnHTDaWwX6qLySJnzU
	 XMyut5paCN4X32csEcHGobklePsEDGmFg8sCqDyFXJS/N9tPF90yYIKC4DKCNvTefhgHx
	 AApf0txM5XtbX7X8fslRV3dsAblAGeQIdspN307vCQgBT5rA9USailV5Qv/oJfylwkGNy
	 LTUDmuPZv6GeNrndD1XCmO3jUfASDB/1AaOZb4j6MgCcwYUOSCIpNN3oFzL3/+cqFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s+aLuJucBwaSWJgFUDaZ/eOjRwoee806v+5/S5Iceo0=;
	b=jRsvQBxAfWnWvqK3ev6zR56kUZCRyzIC30SdYhia1ARAjrUYTGNmWiQw6u9aXEd92fY9
	 a1vmEfW2kFyK9ofBN3pncpPUMi1WO/co6zIJ4d7f0cKJq1af/Rl1WOBblJByEz8QMun5K
	 H+0uw6gaCUMe3g6a+A0xiXAkXA/vuXln2Gf1kkXvtvy/7+Z38vFxF5N5ORF4NxuAvmihC
	 XUbPPu7TqJOQcQ4BPb/tYHNo87Xc+NrLOxncsgzmPX4zBH7aCxqStgd3BLXlEHS7A9A5R
	 Czg0w/xqMpoi3/4fnC3ipzSye0anFyIxak1GnXhg5s1+dkvTYPtl+Y7Djcu7bva2nOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Kvo/lyOV";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F4606A32E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9F4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Kvo/lyOV
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so4902548b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795677228; x=1796282028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+aLuJucBwaSWJgFUDaZ/eOjRwoee806v+5/S5Iceo0=;
        b=Kvo/lyOV2MwVQoedJXQyYsL3HvDt5LvUj7RzpWxSWv4x6pKYXRyjbZYTtXIzqRuzDa
         ++vJx3jA9pMmfGQxcfOSO5PdliQmErXY4GFplELU0x//8LevnlIJom44DUtqdRBYZq0l
         L14uPqJ2iAuVl82ASxIPoSqSHRbpftsk1wnR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795677228; x=1796282028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+aLuJucBwaSWJgFUDaZ/eOjRwoee806v+5/S5Iceo0=;
        b=UH8OrHt2ic1tPdxHDq8aOWyk1iiuVci5MF+rLadn9iJCriJuXmdBBvwSm4ctWn2KgM
         PHZFuUngaWfwM8mEp9BjQMGSLY/AYLlupll5pVocie7actvb6+8WKZlrd3S28pDiBB4X
         P7GQxAFJh6PKnqs8SewrDk1gJ9PBpXydQgi63cmXSKz3z2ODkK+o1kTa+KvmyB221D5X
         6LwlnqxDuNjvc1YILCm0ETiC+bBg+D25n5ZTUYefYIUyg4L76Nq+Ne493O4oZXoCMm1r
         THUHLZOWHnBkYXokKg5UrpBjFbdAtJ24jFib9wJIs20c2YiYhfuy6guMhM7USakyewtv
         GTgg==
X-Forwarded-Encrypted: i=1; AL+hErGC8fcD3ov2gNA7iZmpZfqQRh7ViVbEVGfmII3ug333EYtT4Z2kzDkbGeTYRwAthbE2XNYNYhA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WDMh19no1Kjo56dWdG1O6dZGeyNa1jrisjCv+3OQCtj40CCml
	TBYUcF/xBdYnzaCvdMFMJzIqFAluqoJl9fK3qRpGWXw/V+v6oJPALFnZlO/OkHFAAvcTSa8jbuF
	NJiJTWw==
X-Gm-Gg: AZFdTZfLpqlwSHoiE230aZRaDcADCVpKrv7FBD8NLPd3JRbvAQ09nLlAlHYtPjz8VPH
	AMSguQQTCG7vpYFKHj1HRks+RmuWbQFG1WvHFSu7K7I9KqIl/M3iERnUq37JYcuBCwqIeY8ph5J
	sqh/HLfPVWja1YcbX6JKqsbd1DYtxi/linCexCyO48kzFlEt/mzvul2T4HXRPhJzj+a0g7Z+/ZI
	dxUQZdztMKmcMxKGPdOy25Q54MPunomlhxECwJsyWvuofWAVU/0bdt6iZ2W/zEds231Ze8aa8F9
	cz0+MX9NrEPRFTrfc6fBsaPHQRrPMU2SYExdKArY3ManXcpJSqmpk0x8mP1X63f+Dwp/0y1jkgk
	pkf3OJ/Rc2fkc2x1tCI0TDp0c/iWSRuzoBh8XbwnpHLGTDXMS+C7dgm+8i9N0M69lwYrxG2zAs5
	Vp/YncK/J8uSPbF7magPtRexA2TAZLDz2nUvGvry9pFSKm4BYzr+tGrTwkFkCdS025ZUDj2jWVA
	a8wnUevlsSi3l4Sa+SHGOh7o9hWVUvcnaNE265mr+05O9u6vdd3L1JqzifgNnMA5bbr/0ZyRv83
	rjCdfJ13XSE0lgLQFyLbgTrKABEgE9tQrFWOQ2Sc8YLNMoOUchW3nAm/M9ToAJWbJN6DUzviYbg
	/5A1/dA==
X-Received: by 2002:a05:6a21:3f94:b0:40a:56b8:2551 with SMTP id adf61e73a8af0-40a56b82debmr793737637.17.1795677227780;
        Wed, 25 Nov 2026 23:13:47 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8cdfd2d2fc4sm4664437b3a.49.2026.11.25.23.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 23:13:47 -0800 (PST)
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
Subject: [PATCH RFT v4 4/5] drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
Date: Thu, 26 Nov 2026 15:12:52 +0800
Message-ID: <20261126071314.253890-5-wenst@chromium.org>
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
index 62dd0576fadc..35eb5039f5ac 100644
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
2.56.1.839.g22a8290db9-goog

