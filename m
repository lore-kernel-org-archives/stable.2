Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7437883D
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641028; cv=none; b=CP4VrZjWVBsUJRo+Asz8N3huzCMWZJGNLA1c1ImmZk4M0DmnDvlK272RRwK9gGE/YcdzL8HDyRpDsxCwJMx77NvsmDmT8UjpfbwqdbgqoA+ct8htqwX4PtK6v7p2dc3WYrD3W1v9TVdTPV02XQ7wxZlfSlaqcnlM/9x11QXWBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641028; c=relaxed/simple;
	bh=c6x5Wt4N3KT7x4DICycGnjJPEQZsB+EZnuJ9tlaS4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Upoq0ZgxeS7/bZzdgVWr3Lcqe9gNZNTIDVcWqJpv5fx/4VODVDURIaDy1ApouefPk0/D6170mWEob8KmxQikD+QCjdyJV9qE9NcZVKggv2HRn2TK/04d2mDCceUBur6HdHfanI09JJZJ8fqJuTsuLUGQNoa8IxnKpyidTQ5Bl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHd2jPP6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHd2jPP6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso1046595e9.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786641025; x=1787245825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
        b=sHd2jPP6rH1mekjcXlgQoSrDZY3iMakv+ZRC3zdxbMXQH/maBPRKQdP1Dg7JwgGDlv
         kN8UqEeNldTSu8IaqGWpIeIpxqzzl2hBHtr464MdO2XMPqYiIdHeuCdoeScB98JTWq6H
         851I00DfZFJ1QUegu7GfWqOUAoAFsxzOZ+CmNCEFu7Ybk6cCU8AmAFkE8dwQexwp0DId
         aNn8Uul0bnE9xqqGo0BNp2+ppSPZl1xZMoIP1kTBSEcds0vnue/mX3M43o1QS8wdhtZk
         dkxICLMcpGrQJHRva98DO2ynUnD/vRvYhrrrggPocXlV1GJdwE+2FiKO2DbxbX5NLlPe
         FPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786641025; x=1787245825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZ5ZVury4cSm6TIivP+oeyuQjJii9GLDK9hKbjIQnF8=;
        b=fnvEy5dRU60sSPxdwRA5kKXQHnyDebMUWZ6qEAw4BrxufV+mp7keZvAR5MIPbMEnGE
         MhUohLahgSYGhY+/FiS4NgQGqJVTQ4IXqMYMZQxyxly25wxJ500PDOqwFnLb5w6P3FYL
         UGX2ZCpP1aYq99g0p+1afJGn1mUO5lXET6dRzXD0kWTFCt33/ygYzuMOswI+YtO7SV0Y
         Wj9lJK6BNxON2soCPagCWYPrwy3Q7epX4fS366JQIBqecGqjLSyLSTFNTu3l4reiIwJD
         mQ0GXYOFTHkd2VcAPiVNY6kUpYRDCXa8z58npOvkdIWsgF2/HnbmreRDP9LEeefwYKzu
         nnNA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1GyTgGmU/CvTHtMsDoJExp2MErB0O44pVGW9ZAfxaTZxKrY5Bk7dCtdbpXPbGUWr88ApWTVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuP9HNlXdfRDqt9w7553yCBeBcmgpGVG/AwAd7XzkVsKWCjVHE
	slypgickNqz0npAtG/RlxpQxdPMo583Tiin4VsS8+0xAE3YgEySv/PvU
X-Gm-Gg: AR+sD12Z2SP7wWOixX7O+t+kZcyge+dtdtDGVg5CLto3p0PWkjoHipMBdGEvavO26O6
	pUC6Fy6+oAX9Iits+3DSrgTZd59fwXokCz4dw0pYabBS91G1vuAuCKsHGG3ka7Gc6FNzGhBnhvd
	y4aKlfhtT2dv0X8BUT4+CuPgg+WIJ8sU+GXR2DIex5bPeFJvLsNit0C2x7CNdfVW77V1dTXKrEb
	g1iEo0EdV/IhpEfKBmHSIkqTb5wzeYPRgBaf1y45O5SVQT5nh213vPVfKoRLcGChNjr7orZg+ds
	vwNZFxRfZwK+fAdCdIiuK1NFbgOCHnzFDfxzUivexHPAaLiEFFJmik4Dp5QBJ5YB4cT6MjJl+RH
	pvX0u6LT6GsQd16ee8TNysuq2Uk1hnPXQXBy4FD36j8syQlt4asoqOkUn9vSU6nkMT+XBsGWwcb
	fL92RpMEeV7RlUwQaoZScgJs/LUI/pIpAZ4fnGDkJRy7PyYF130ce9Ir6BFn+0kGZPu1IuasE=
X-Received: by 2002:a05:600c:8519:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-499821f20efmr106473135e9.10.1786641024765;
        Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
Received: from cachyos-x8664 ([77.83.245.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f6b1sm76662355e9.4.2026.08.13.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:10:24 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	roman.li@amd.com,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH] drm/amd/display: Scale custom brightness curve from full range
Date: Thu, 13 Aug 2026 22:09:59 +0500
Message-ID: <20260813170959.22073-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40d82a3ee..533c69f0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      unsigned int min, unsigned int max,
 				      uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
-- 
2.55.0

