Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFE1DDFE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843764; cv=none; b=jP1wb75zCGieHGZNrL1anZ28B7NBHYtplxqHpxa3KYzOykdnu0Xu1rZNZegVEsXEAVZJhgW7eLqkLbthB3j/2FiDR8Fulp+bj6kbV7109LSGJ+kDI+qkYJKHNbX1CNa/P8NxIpwuGSdkwfhVhi0CJ8zrJ7nsxdSTfEou2I7uUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843764; c=relaxed/simple;
	bh=9Gz680K5QSslTUHGxRWjVgzzejSc0xlqkZhFGg8h0K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pY8bBvUWCSPwlb/ZY5X1Cxb9Xk2qGhvQW+B3b5XJ1TgXLbwMiUdal8jdwsClcF8SRBLuYr4Q4jdgqX5Lin90P1G+2dpqxBjMgFdiCE9iovIFfSWLtE0I6f/EPNfqilAbh1ncVZst3xdrMgLk5GDpPF+/RYvca9vebd8wyR6CVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nUig8c/B; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUig8c/B"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3570151a91.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788843761; x=1789448561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5Plj4uGj3BvxxxoyuAGWT0KJk9RqOTiZJAPsoPxBFY=;
        b=nUig8c/B2GPd6/HtcgXxxbrSKUCV0Tvx0EGmWoP/AFc095diJFjNQy6KdD6WeVrMNz
         3/50KXyFO7jGFyM5xk4EoQuI2zmvcGtMkX+T/XB67/+hxeU/7IqffdsoH7fHIqxu2oO1
         rOA3GynEYU2oUv7Xxyy3lvw5Lr83eGDjUy8mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843761; x=1789448561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5Plj4uGj3BvxxxoyuAGWT0KJk9RqOTiZJAPsoPxBFY=;
        b=GtA9l6iyD0dRFhFFoaXpWYZiE/L5G3IwlXXfBPWYcypeDPtDaDGORy+BEeB4CxS2Wm
         33H92b8pfAvLJHtLuAIA7rHI1EdB8A2N0juMc8nneoT3RBu4asO5a8SdhPlfOp+lbSJg
         bGjQeT4p7Se425JIPryQ+YVhjE+cQP3TsSpsB9Wazv5GJbnA/K5Th5N1pCQIKsbEuxN/
         QJOWLZ0JYuELgIJ+vnny36DyDUZON2MKJg9Cvs4iIYVJhyGyo9us6i3vqf5uopA8aVDy
         uGZC6VmKQO5bntxC9p7cRBKp08qe/IUyxwpjnIisd1MZNPpn6vrhD8ZqgndSxqs/DHaI
         njeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmiOi9P5mhdAIZBicO6xfvrrO86WciGMVFOMFog4iKVQtO979DSGheInSSdujsxXCiNPKsE+4=@vger.kernel.org
X-Gm-Message-State: AFuF++kdzHrQ6OXGKqP/43vSIDlTDaTmbR+Fj/msP1cue+MACnvOS2RQ
	jf69f1atnF7sxt7M3VQfAMF4TEnWwGyb5lbDRE3YRXVg1x9AG+hqVukvmTBx4rf1Dg==
X-Gm-Gg: AYBFou07XXdddsKevvlf3pdyvsgLmPNUrgxhaDUwsVs+emfgRbtRoc6OsR8a/n5ZoT7
	ubrXos6Je9w6WmRy6SHeasrbm7f2mRqUhRrxoMa3kMUMh/GBiaVwfBxmUslIHDkRLsazUVoHTv4
	Eb2YzgO14PDOJ2kGVQal1/Fkt4l0F7/ndMJ00BdKelKohQtr9Kw/E2SrMdl5i5BpUkAoEATrU8V
	64Cjbnl+DH698q5Zhj6F4A9lKBI4+S6GzK2eUty8fdGHACOBavm5naXTWPhbfwRGmvSneT+WODl
	YElxg6xBDwTAc5OoXq3pJC4Ro8/DrpaLDy4l101s7f91sDYypgvi3Hx9/TW7Z6WoW/x5p3WW8k6
	1UYXQw5TfV5bpzWFaNl6Qmz3OFzDFbl95o+EiGeK+ussofW+BB326/D67mh72BElWSogzz/nM2J
	j4X9Ily3kDTAA8SkIIkd+2b+facPfByRkKj1s9GkJh+6v8zFz6bdhloj0PRf8o6cfY59hfEHeEZ
	bij4BgPXc4d7AMVr25kDxREu8JAR6agigac+RTF/MKWj9Q6tqIBH2ir+w==
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39b26100e5dmr38830828a91.4.1788843761523;
        Mon, 07 Sep 2026 22:02:41 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b813fb4ddsm6342730a91.10.2026.09.07.22.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:02:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/sun4i: Align VI buffer addresses for subsampled formats
Date: Tue,  8 Sep 2026 13:02:28 +0800
Message-ID: <20260908050229.754977-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
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

This turned out to be wrong in a couple ways. The hardware can handle
pixel offsets within a sub-sampling block, but the buffer address must
start at the beginning of the subsampled block for all planes. The
hardware then does the interpolation internally. However the helper
gives the address exact pixel for luma, which messes up the result.

Instead of reverting the commit, calculate the intra-block offset and
adjust the buffer address so that it points to the start of the block.

Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory")
Cc: <stable@vger.kernel.org> # 7.1+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is an alternative to Jernej's original revert:
https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com/
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 2e9cda45c04e..185e9e5211c1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -207,6 +207,20 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 		/* Get the start of the displayed memory */
 		dma_addr = drm_fb_dma_get_gem_addr(fb, state, i);
 
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
+
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
 				 i + 1, fb->pitches[i]);
-- 
2.55.0.979.g7e5102b832-goog

