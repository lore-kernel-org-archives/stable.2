Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F53AAF54
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529635; cv=none; b=qYkFDbEydEnthcjRR+7hdMdJMkLhI3zUknzmSiMr/65lkWR4UPgnWh29MLioh2cphBS8/UlQStWl+WhJwR4d0pVdB2kKkf9e4nfpS87dBApznpUINDkhcl+xDMU+24jT6eccUIv8qMXtHv7XvrXcKQNJLRF8BPcAPZmsez6yDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529635; c=relaxed/simple;
	bh=qbPaYJBirbvT7ihHw211bCHk6KPsVXJrTqNHUfJUxcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXXzzU4pXeJsmf4qWo5dLswq3InX9hQI1sevYPRg5wcXGs6vMEAM3mt2SJ1oSVaiylHhai67JI6mDifkffedPQu4uuQhSbrk4pkSi4BQLTbkFXyHy6yaXCshfBk8pk81m72Jk1uLtUzr1sljBdtYTTHlil0s0LXXbeOy5qOragA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kvIesZli; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kvIesZli"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso387832a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789529633; x=1790134433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nb71HvzDE3B3FVkEVJ/TFE9xXljAPx+xdoqH1xLqTX8=;
        b=kvIesZliLjWNXzHIbikndyYWX6AZIuvM9NpRYKinjzwsZC1mYu3mREPcgUBO/ObfAa
         oQMpf0EvItVU3xxVhnwYmy+sJgq3lHONVft3CiuSptIMv8w/UeWjqxxqHY7EFNeN6q1b
         evBmEbb2uHhMvpclthnhlIz8Zg9Ae2/B5l5Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529633; x=1790134433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nb71HvzDE3B3FVkEVJ/TFE9xXljAPx+xdoqH1xLqTX8=;
        b=wFpzws1MZpZrdrmDiiZaeS+4WZrD7tFJoX+Cf6FhTYMs5BrIVae4RztH5fGD+gcVSU
         FxgrMUbOPcfpdV+7zwyNUe9i8IOnkGBIW3Rmp9W+VSNrjWkzW0A2pnDelHY0pJVlYGLh
         4biDllk/rkMm23oupT/hC7fnsZ/p4wnmrJgW4+HptDSlr2utoNxDycAthmJIR8TltAZ3
         STnP55n/FD4p2y5zMnDFA2kjcmyBFeyHcnyN/t8HZgtND+cA7fq1xpErB0vUvqNqz1Sc
         XAzFk3KQqXmSUOX6/wwOygctfk6Iio7tOzHIVW6wjYvUKPK817BNpHgabP+9hqlFe/7K
         KAvw==
X-Forwarded-Encrypted: i=1; AKwUvBzNO1cf95k0UyHUmPVRffBspl4RhQP86k40mUN43wmnGPhF/7g591AJuM8atmLYzTFcfOBQoxw=@vger.kernel.org
X-Gm-Message-State: AFuF++m8QJNrFNagoHjoV80e3+UYprulM52jX3vlEdGYralrnvqWiPhA
	dEU74haXH4j5YpXb9lb9pZHpCMoCVv/xJ+BV3S+aclyHYar+TWpzOTi5OpEg1DQNVQ==
X-Gm-Gg: AYBFou0gYZrCxAu4L+/j7YC0jKtVY1IIaPlGUConpW0s9QsgxIAmr3Zp3elHeIGaOPU
	Sa2gnl9EP3Ghe0at7KleevtMoF0TmlISqGrGFQwoXC7vDsONTpaAm5mHIaogHi7hAxmVI80io4o
	/OPAUwTA8mqjknJqRCYIPAHF1eqefxnef3J9sjC0QPMdKIge1mLyyFQWjazdBdnG3/6O1P5yASN
	hYT3tDtGiamNK7gLwRx1q4z06ixVnKHuNfX0hwtlfLkxKy4+YHvEXTylfdxR/POiPjTtA9b/VzW
	4YfmibF36o/oseMjnF+0Pb0WdspRD30RbuaGovu/EAyAvMEMUPaZLdfu1x2GgIFKk050DB2orle
	0bVRRiVweyOYrF9A1869Brcja7s44XjzO/j84SAsLGZ3FQQoAk5ldRko9ATbXsKH3uG2HPrn/WE
	W8B40QAeRi3u5/9WkcxhlkLWphEssy2JeW9Hwh5EAcCFIBg4qJAniiveTuRWc/dV++lpYBE6nv4
	WYl22qoG73ZFcs5qlHUqxIrzyO5+R8QCLFUNkL+EQ3UMt920fcz7pykQA==
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id 98e67ed59e1d1-39e1e4c54fcmr2477670a91.20.1789529633211;
        Tue, 15 Sep 2026 20:33:53 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:33:52 -0700 (PDT)
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
Subject: [PATCH RFT v2 4/5] drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
Date: Wed, 16 Sep 2026 11:33:25 +0800
Message-ID: <20260916033327.3054126-5-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

