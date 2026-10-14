Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264137A826
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957941; cv=none; b=KNMlOPEiqhoPJNgtO/qtx+xol90roCkp/KoQSFpOQF+D3tqElut6/I3RtiKrwT+96tbFcpAp4H3OXHzfjIPZ6DksIF5wB3q/r2wa/oz7DvISsed7/N8uyBoK66XJdhgJMg2JIUpOtRJ9TKELlCK6MWdi/4g6Zrh1b0fpEwHgWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957941; c=relaxed/simple;
	bh=FZjtCgPWScpO3udRUYo7ssr4rKWpgkU5u7FB3K0+eMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/DF8AIs3EZSs1Rxla6IwgvTWmwLvTCtybRV0cYohWHw+MdurKTfnsQaXCujbv46xTMNCY6PFVQgKW5ZgpACO/uhKQ8DNXrTyKvA5tNtbRyCnswca9uNirJZ6EZNAku3UTFSK1GzF1UC3dMPhQgLGOhtpjKrbatYLsb/UR82W1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZksIM1fi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZksIM1fi"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5bce4e278baso575643e87.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791957938; x=1792562738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
        b=ZksIM1fiG+I08mDUe9bhBsgWifHaO2suZZgotPdLUnfezrPNf4b124D5H031+hVR5l
         MViwpkEmCIX3k2IuULohpQR4/MFlWv7SC4qYkbI7u9QA7QV7TZA4xyWA3VjuyVq3zGrs
         9kOxbIEYhjgcu/uzm2ccxPx3InbxLpQqhwhs60b8i9h+/yot/C6T8s/XiAVMbOQb2O/R
         4JMZInSYGQNSMfwCGnJ9PRKdYVYAcOiaalLKKy0+x40VKOKkUNrjGvyWr3qTSHbMi6jb
         F91p8Bvkkqz7LMYqVFypMR66q+gWlk56ya4feuQb+SwbbqKCVlat08++rvFROTQhEOzS
         0U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791957938; x=1792562738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
        b=UL9bX/WAAMOKMtbdtw3VtMhwczA3Nm51K2FpRnHeLT2Gyc4UPRuYcVKGfU8KA/Whj2
         11SQ3PigYoW+RsL50K0bNE3i37Xyl9x9voziBElU5TreEYU8GZnPtpYUb+BhEHv/FUR+
         XeFudyUwQLhMx2JkUPJV1HdoO0JLKZ/f9uZJRLo8DmfSu3rKmqWHTzG8m7dSaMgtt/3d
         0odpdQCOZlBQxiMGI2aPMByhG/3gtN7U0ns6Yr4/2lb7UELYEUz/N7kEdrExTYP/mehV
         0MnMEgARue1NSIk8hKA9eB9L0eeg/iRkrMQI4fhgHlWEzHKykxv1vBWAhp3EDYD2rLK8
         LOAg==
X-Gm-Message-State: AFq9FYIRHgYsi0sfykNaQsxFpHiaiLeXtIM6tS1mMzW2ixqx1siaVE2m
	6V39d0PmeeodqciBRgsXWlMgeKiwDTZMUg3Gr+hxHc2VAUAj7a4LrTA9WddS8PSQS8s=
X-Gm-Gg: AYBFou146/FDaAoE6OC+mCGNfZuzx63MY0ZMIIZ/9d4zKCs9Eolrqf4LeG77kK8U2Az
	rBeuesLD+zr31gho+q3oKtcAuW6bsXD7fg/r0Ixg1yyXkJ5+FadMsYLxRV1MyIzjaw4A43RGoEk
	psNlQJxaRG+Y7nO+VeNoxGBMtgt4O8KTi7RkfGE3d1LWYE4qcOuwzvBtXG85XfPSJxnM3KoWw0M
	rfSY7hOlU6QObf2hVQ69iuLdyfnuRJK01wPSRLZF4Ha54+MBDHkvGZ4IY9+0bT8CsSF/ReL1NWJ
	SI1y6CseCRAc9ErgTFglv65a9S6rZDatGBDipVbjvpdahDnGoEazMid6mOUYxTT5tS8Z0h45H+z
	CPCipDHfJw9yhA3ppKchEIX/caf3JHpY7a2gU782TZDofF5z2FNuG05nEIcI6YIneGbjkAoN3mZ
	5S9z4NQXdzHNMO2StiJ/WmJMzfwMtuZ91Ahdl/spPDrutDrG24VlNi2Km4n/sA/rmOwpegYXnKV
	md5WV3rPhRg/J0W
X-Received: by 2002:a05:6512:3f08:b0:5bc:cbe1:571d with SMTP id 2adb3069b0e04-5bcdd559e1emr4705089e87.44.1791957937938;
        Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be34c726casm235360e87.46.2026.10.13.23.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alexandre Demers <alexandre.f.demers@gmail.com>,
	Boyuan Zhang <boyuan.zhang@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/amdgpu/vce: Prevent partial address patches
Date: Wed, 14 Oct 2026 09:05:19 +0300
Message-ID: <20261014060523.4685-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit de2a02cc28d6d5d37db07d00a9a684c754a5fd74 upstream.

In the case that only one of lo/hi is valid, the patching could result
in a bad address written to in FW.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Roman: In 5.10/5.15, amdgpu_vce_cs_reloc() does not take a struct
amdgpu_ib *ib argument. The conversion was carried out by commit
cdc7893fc93f ("drm/amdgpu: use job and ib structures directly in CS
parsers"). Instead, the IB is obtained via p->job->ibs[ib_idx] ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53375

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0a28daa14fb1..9b0efddd145b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -634,11 +634,15 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 			       int lo, int hi, unsigned size, uint32_t index)
 {
+	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 
-- 
2.53.0

