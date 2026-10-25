Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917915;
	b=TqM9XOrW0isK+7xLgCNIC8bSBTK+CYw/93R4ag32oyXFwVTlSY8EhHCa04aDGsWuJpTE
	 zZ9yIm3jrcu5+vk2p8Z/Eu3j0WxhotOe2MImpG03tqBJ59NGerSEnwzSSzlAHxRc6dX5F
	 oqWGOmfaGui2CzwkNr2DaVBcDGUSOT1TnNoXtctEoCYMl/w/+YILcK+qWXL9XGaBefKMB
	 5fi1+c8kvDFHtqFSpArnos/sAFFLjAQK5e+jFgtJQP6YknNks4dKTxHX3mcVEZyWXnlxl
	 UPlQ4hYLnsG12WGEu2+4JM42l/daS4uvtC/0I9T2lioAVi6ZARWnEY69/xl3g/+fM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1d5mUWdvk774lKl2QnImU1luPbD//SI7ZRpbSPmcqww=;
	b=U4owG6dTxK83HUBUKFTGntW+5ygps9yw7DuPeweJ43rtde6mipxdd59xq2iB1jmBGC7V
	 fNu+b52xAsjJ8KxXA/DmmxYJVPL5wvENYtkQFT+EQzTL8seT/iBUuXCCWdEHXrxjqHcQA
	 la1iklGYgL/fT82/UPJLpN7Zx5K572mYuZcNQIHW4IJofIFxOJ4dBTVr+DWH1qC2c8cCt
	 euF1rcfWErFyvglcUVChhtuo3DXAPDAghg+5sNAu+UsieDDMrxx+hN8xZpZs3NX7++WFt
	 PG0Op3LZEBJhl4Bw17R6n089irMV3V5sx7Z4Wp+aYJd6oI8ogE4SOENJFXphriYXtMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwBNUJPA;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DC606A321
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 975DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwBNUJPA
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so1642265e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792917913; x=1793522713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1d5mUWdvk774lKl2QnImU1luPbD//SI7ZRpbSPmcqww=;
        b=BwBNUJPAn8EirOOv0LA2XGMGZoYIK0tC4puvCdA+BS6/VTgfMNClPjk6LuwgqPbinh
         xrmHONcG3ywNDuWrxBHUkOnoehYpXF4pTEbeebOPjEfrkiJPpy31OgjWFGAxiBHS6dhn
         hl1iVWyd5iHADrNbZeFo++tyWxl9e+ogaQVYiiKswmGGLmZUgQb1HNoxSi9RIrMIC/XT
         Z9tV9yjBtiP2M8frEoVsjoBrz6YN6uUq9jwemF1XGs1zqVFj4kfWyC2E7AY24UYlYadX
         rk7Xh/T9KmLXqYrKBGQujXBbzqUNLz4OfdS1//vAcxqbFkFEu9EZhgjla0GCxEXPXU1D
         9AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792917913; x=1793522713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1d5mUWdvk774lKl2QnImU1luPbD//SI7ZRpbSPmcqww=;
        b=OTgNF1Qs8EbZKr4+UaFZHpltENMcKVVekl6+WqSJ3t2MkM0I1gmP6NbBzVV3YqMB98
         n4fzPfhk1ZMy7ZqyuDtc9EO8rhBI17uI3kM78HXbNIbprBvjsK3/6BJo+X6PsTV7YhYW
         u5KZu0ulfPr/TvBeHM6MuMc+NMKAPd90PUzX254f3B5XJ0g7tcq1KJ+rfDLq3AS8KX9M
         8VQ3Y+RJboXKxmDtRMgSyQSqSCI2NVBeYJ4DYkSKVyM4q5kkvOh2wEX6sY34DCUyYk2n
         +jKMk8ftETVdqE8TQRkiRSemuHh+/J0Oh0sH/0Bh4QF9+QuZhZqXvXwkFHXJ2vDBjl/3
         wz1g==
X-Forwarded-Encrypted: i=1; AKwUvBxDOeYkJov0Ad8tS0EZ3SmF5i2Dy56EgVPMWwNYkEx5ZJyywZr60lwTtEtOqqq3YNmf9j/dgKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMWAneaM00ctL9Gxf+07LjX/gsZMVanUp9iDPy2OHHkCjuICQ2
	64on6IOMV/oTRR1SxR0wZf0sTkVjHEGXNtnAw/4Yd9n2/YfoiS1qSvCM
X-Gm-Gg: AYBFou33T8U8X73gTKc1kP3VOdevRwH7nTo93YkderYFWWkMnGQRQIlMyOZ1a6Dffzg
	Izb0QnskhxaaGdrSwuCXko5n62pVCvfmO2hgCt8K0WHzMweUPAyLBsF37rBwYa4S7/q5aTlwjHM
	cKNHfh2vQ0/PHK1LWxbYEVnzC0RLssRcVuPFVwKwSQ699vGFz9N+WnRjD8ClDuZA5Kf7Rm1KkdH
	U6Jugd1b8FJe8IJuUF+SxWUVWLzU1T+JhMSBVQ3byfdCvTihANadubjteMZ3W1GhcWkw0RsCKbl
	Wen1NtWJZd3aqmMmDg1Q+DNC2IzlR2KA9HPWRMbt81FfDUCYrucGqezgmxjqE/3tEBN8biJjN5S
	Q4W3iyri8oFNiWvbfYkK1aSoZwiHCFWn8sJS4ZLw3W6eIOgMYZscOewYEtFzIMNx0f7WRjinpFJ
	6ijRN4mF4Ggb8bXZaphwTJTqtzr9pwusp9Sa6jsd28YzzSjqRbrWUQ70CkildDRFKPd7O3HRGtD
	WaXpb0dsYHc2IbGCb+EYG3S8tTbqMJDZhaJby8B/bLvsnn617GvJeYMG7IBpmtXxV0GU8v8Qwop
	E1pHasAA3hEWSsQkN1HkPuSwyN5dM80HU3/8C1rCxdj+JpOix7JVHNkEQ5xf2+SlRLDfW89RiLc
	FgXeyEBxQ/ejAtA6KQOAgaHK0bKV43aLUPtcWgPS/iv9uA82s2jmAtc6dq7ljqYudSHeJy90te1
	HyWjo5Ooa78FGoGk8SfeLlBpseMT7KxZhnnsqAErQbMIAcGro2AFDG8yNIq3CljYYpn8CJuGISG
	+WR/B7J68Qq0uabzciY8rAkXmRbUYuKr8ksV0C34/JhzCPFpPsEFHfwHAvTVNlYDrJ4tQEsWHSS
	mBCXENsyCOU=
X-Received: by 2002:a05:600c:4e87:b0:4a2:994:5750 with SMTP id 5b1f17b1804b1-4a35acbbbdamr59352085e9.32.1792917912666;
        Sun, 25 Oct 2026 01:45:12 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de. [91.65.217.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm111484945e9.2.2026.10.25.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 01:45:12 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Jack.Xiao@amd.com,
	Erhan Bilgili <erhan.bilgili@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix DC scanout position handling
Date: Sun, 25 Oct 2026 09:45:06 +0100
Message-ID: <20261025084506.62881-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
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

dm_crtc_get_scanoutpos() packs decoded DC positions and blanking
boundaries into u32 words, shifting the second value by 16 bits.

VRR extends vertical blanking without changing the line clock. For
example, a 4K240 mode with vtotal=2250 spans about 9000 lines per
refresh at 60 Hz, exceeding the 13 bit range within a 48-240 Hz VRR
range.

The 13 bit mask truncates positions above 8191, causing early VRR
timestamps and missed vblank count adjustments.

Fixes: e806208dc1da ("drm/amd/display: Fix slow FPS.")
Cc: stable@vger.kernel.org
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0a8dd7241750..f78c82ba7f70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1767,6 +1767,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	bool in_vbl = true;
 
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	/* DC packs decoded values into 16 bit fields. */
+	const u32 scanout_mask = adev->dc_enabled ? 0xffff : 0x1fff;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
 
@@ -1784,15 +1786,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 
 	/* Decode into vertical and horizontal scanout position. */
-	*vpos = position & 0x1fff;
-	*hpos = (position >> 16) & 0x1fff;
+	*vpos = position & scanout_mask;
+	*hpos = (position >> 16) & scanout_mask;
 
 	/* Valid vblank area boundaries from gpu retrieved? */
 	if (vbl > 0) {
 		/* Yes: Decode. */
 		ret |= DRM_SCANOUTPOS_ACCURATE;
-		vbl_start = vbl & 0x1fff;
-		vbl_end = (vbl >> 16) & 0x1fff;
+		vbl_start = vbl & scanout_mask;
+		vbl_end = (vbl >> 16) & scanout_mask;
 	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
-- 
2.56.0

