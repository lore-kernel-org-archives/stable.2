Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6703CF1E7
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379997; cv=none; b=GPyDcawwudRV4/BYoAqH4mNSg4nT12PdloVTVNPU3ZV3wAe0ukN1a0vnrdc4nPZTvP26NBlmyKmudac7R1dKcKiuJJVWs+h/9CZSxLw2MRMgyLajHN+ttw4+2PGcFqpqFtGD7a3+Xn5A2ylIxQYwzTbxdCzlgJV9gtQUoe3ZbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379997; c=relaxed/simple;
	bh=mKB4PEK+utWwRsA4INvr4RWhGUU8W4ZGbkGGmTIlL6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opotg9E7jxwiEJq0po6293Qa2dln+ALp9yvMZ+Z0R6Z4TkULK+REEBpWg/+zMaN+/xoEdLSsEsEorjjqAuXZ/xUE6ERlhhuejBx5gcBeocZQS/WaZniSzts0uiU/1CRimdsWXjFauWA/o9ynTJklSJxt/BT7YrvyRBWKSVUDBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFj39vcI; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFj39vcI"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77df9781eso23132461fa.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791379979; x=1791984779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
        b=OFj39vcI0skhEGDdCjRwir4DFHLkwnPCqRjAaStfgoSK8RVgW8EbxLeIoqrvQt5MgF
         EBsZjuCUN4tW6OfaLqoS+hGG/In5QOqRPH7wgj5Yss5XrSgN/WfBhzTik/tdMtezv5H4
         tQ7jv4f5k7B7+S21oXsDerAFqblZzogO7GfcHzOz6M1LYKJnm81qWcahhaB4650Gor0O
         tfwbmZIiZCefq+xlN2SCpgz42YeJR+6Ruuyw4F1upiwD4xMcyuIev7+tlijLVL86zvqR
         MZIlcjsFvVD1HBQAicmYfzit8s6Dc6j6dtX6PgKqbByIdPggYPWANJK0uHfwJzW/7eHh
         tBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379979; x=1791984779;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
        b=PKV7E0Gq2/ih7iNygqXScHeKRFLeX7m2Kcmm2w5jBufcoO8A7MBhRO9SZ1iA0q3qbs
         Rka0Atvq4qmWVSLpuTQPFaN4yx9GpUHy57Ost9Bs+WqeIsrM3g0v8vuLEqN3V893/mp5
         Q6llhfkaCWkJPy3a0lT04vJrastqmXKVpBneMp6c9p1vUDXqxUpxUzyM8qkS/K+/CAcV
         qWbds0kqER/FyojrewP/Y1J6R1aN8bclZ7oFSYvRXStSTLO6QeUOtxWbqmSGEigJ8X/T
         5HK+FbEnq+iXmJeP1MR1qEYBX+HlBmdWBe1GM3u5yaEn0DRb2X7Jsy5XJm9f7eA3uc7a
         vFdg==
X-Gm-Message-State: AFq9FYLV4YCaXrgdgAodktWHYZTDS6z0Z/g/Op0H0bAeWj1WdKRhurvQ
	sIWf5JfHyRy9ruGoGByZmcKfp05MkoVp4QHQ6inYMR37/VYmQLYjSYzNvOejJCIN
X-Gm-Gg: AYBFou3f5Uf3HFPFy1PCdCfJLN0vhVQpEcJ3nuBlR1HbCsGVeXUKJCSWNU1TODNUhut
	EiygNn02iTCzCKTXUUW+LrCdej7kAnhxb+WMdqz9StdzDzd2vcojak+o9Dn5nehau9je30cC9ha
	kG17g9di8U3n78PWWLyHe+JSVwDqNuCNl7aU8Pw+AjHikJHVXnZ7s/bIsI44EyeyHw0ONUyMyxD
	iRFnSttGFPAJRhAUXIdferIlsJjXDzIQ3opOB2mXG3Zg/K2lwkBZbrRodjIpDqU3Sut7kp1jOGY
	nIMd0dKWTEWprWFBy7zX1fBYtIjcNvgsc9j7PrKyQsu2zRUIdlFfo26DHZjD23uBqbP2nrtJnMg
	2LzyrSAWhgiFlWldtP5wsM/WUXqwmjqeLNAnYWemNv5XAo4LXm9UeNulBSHcV8hwRuLaRKmy9JJ
	g0aD43juzc0YSwuoH3mn3rUj+SN+K4KvOEPiIaQDioY5D2pVUal7KDyoeHHeNv6NtH6+ON02W6e
	/YaOzd4DE4YD+uh
X-Received: by 2002:a05:6512:68c:b0:5bb:7b2a:5b2d with SMTP id 2adb3069b0e04-5bcd0708cd9mr821802e87.35.1791379979145;
        Wed, 07 Oct 2026 06:32:59 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd30a474csm33636e87.80.2026.10.07.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:32:57 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Leo Liu <leo.liu@amd.com>,
	James Zhu <James.Zhu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Yinjie Yao <yinjie.yao@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
Date: Wed,  7 Oct 2026 16:32:43 +0300
Message-ID: <20261007133244.121787-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yinjie Yao <yinjie.yao@amd.com>

commit a2baf12eec41f246689e6a3f8619af1200031576 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: dfd57dbf44dd ("drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d7d774f100efb5089c86a1fb8c5bf47c63fc9ef)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63846

 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 323d68b2124f..f1957d4fa7a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,6 +560,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
-- 
2.53.0

