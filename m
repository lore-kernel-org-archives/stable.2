Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527064;
	b=fl/NV3OYbILjLFCRK0lHJAxTsMVmWuSjBv+fD1vGLU/rMQrzixrWarhkc88wNYDxOEiZ
	 jo19mjmmJdCFmg5bmW2Z7B9fUshw3yU3LPFfCFvgXQkFB7lSEKixB1tXUsOPqT6DFifs9
	 DaRV2mNwPgh7NUVD3Y7QOAFa/AS0X1dGj6DJ1xD7MyVYqgtXlluclzHncIAKkkrBIfEUa
	 hpnG8JGD+iHYWaI4nT3e0IMLiOEqIM63WgU92Z6GZ0jhRIv70Y0jqXCRidH9W/2xQg9fn
	 xR/9Fp8PRDa6C6PJiL37MabfZVBXdhtxqZ6J9B+pzsxiK2atjLuGO1qh5HN9V1cnvfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527064;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Tr+nvH1iRjNmrI8twQlPIMvhOSPOoWGVKGBgmEcMbE=;
	b=LGPulWJhaxa10Swf93tZaVr33GV8+4A0EGcQhfQ5IxrlX2YlsZL7otSJFaW8cbB7bl3g
	 iP3+4MtkjuAl3VSUYZt+XQDP8f7qsky7mqSCy/L8Zoza3oGM5/uKbdZUnTNJmtsJ8dTTx
	 m9BE0XOmNNhNMO1aRFfzLPNZ2JOAwLg6LJdMJ7AI7env7Koh2frPeIhPB+ICsROboNGfW
	 9XxZLD5T69ug19quUMJqPkCiqv3c/sIXmxB9Iy3jaNgUCqQnfBrG/WFzxhZtepHspznpZ
	 zw+md28q23pSKvBOFSAzHlgOfvyI5dMO6pHVVtRyBMJWW2+AZ94a67cVkHzICPhufPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFLxaNNf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7F606A333
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFLxaNNf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762311F000C5;
	Thu, 12 Nov 2026 23:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527064;
	bh=7Tr+nvH1iRjNmrI8twQlPIMvhOSPOoWGVKGBgmEcMbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFLxaNNfSUlM1tlj1zLZeXOsu042HaS8a4/T+BVBo/sELlebq+20GESAQYletLJVS
	 VCDHhBmh3qOSc/6Dtbf3Rg81IK+7WaIh8xq3XtJq3dij1sewbUGw8B2qJz80gSY5H5
	 mDY+Pd7Tidgq3/g/G4oOqzRM4+5DOfKLV39ZaYUU4IL7d9FZVrdZczOTOpW6KHxyAc
	 yqbqcU/VItCNpArtnUeBNWzMJhX6SMNurrdfglrQsomX6etc83j0OPFLwz1j+HmTaO
	 vMjOM+xtL7KIdyk+KivtQFiNdc5ZidYFEiHF4ly5Psp8ujjwU48E7l0pPPGOUHglgW
	 WzdXGP/hQgRCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg
Date: Thu, 12 Nov 2026 18:44:22 -0500
Message-ID: <20261112234400.4141170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202426-failed-5.15-a56c2536c399@kernel.org>
References: <20261109202426-failed-5.15-a56c2536c399@kernel.org>
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

From: Leo Liu <leo.liu@amd.com>

[ Upstream commit a56c2536c399d57a9bb1c02fd411e0c25859af3b ]

When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
idle work queued during the partial hw_init() is therefore left pending
after sw_fini() frees the adev state the handler touches.

Cancel the idle work in each hw_init() error path, immediately before
returning the error, so that hw_fini() remains the sole cancel site on
the normal teardown path with no duplication.

Link: https://github.com/ROCm/amdgpu/issues/234
Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
Assisted-by: Claude:Claude-Sonnet-4.6
Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7ff2327fde029e97d0050fcb94e3f4063c318547)
Cc: stable@vger.kernel.org
[ sashal: Replaced per-instance VCN idle-work cancellations with a single cancellation of the shared worker, which also covers integrated JPEG. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c  | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c  | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  | 4 +++-
 15 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 8e20ae3f0f117..25f034d5bafb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -155,7 +155,9 @@ static int jpeg_v2_0_hw_init(void *handle)
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
 	r = amdgpu_ring_test_helper(ring);
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	else
 		DRM_INFO("JPEG decode initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index c682d1fab7f0d..db7a24c509779 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -169,12 +169,16 @@ static int jpeg_v2_5_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	DRM_INFO("JPEG decode initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 8c49a67bf0408..62b517699180e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -144,8 +144,10 @@ static int jpeg_v3_0_hw_init(void *handle)
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
 	r = amdgpu_ring_test_helper(ring);
-	if (r)
+	if (r) {
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
 		return r;
+	}
 
 	DRM_INFO("JPEG decode initialized successfully.\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 3a27bed57b4ff..482007346fe14 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -712,7 +712,9 @@ static int uvd_v3_1_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 01d8e7d2caf97..abcdf37f0cb15 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -195,7 +195,9 @@ static int uvd_v4_2_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 563493d1f8306..ddc44841f3722 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -192,7 +192,9 @@ static int uvd_v5_0_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 72f8762907681..0d8cd2e1ddb34 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -522,7 +522,9 @@ static int uvd_v6_0_hw_init(void *handle)
 	}
 
 done:
-	if (!r) {
+	if (r) {
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	} else {
 		if (uvd_v6_0_enc_support(adev))
 			DRM_INFO("UVD and UVD ENC initialized successfully.\n");
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 1fd9ca21a091b..79cf2746aea16 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -589,7 +589,9 @@ static int uvd_v7_0_hw_init(void *handle)
 		}
 	}
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD and UVD ENC initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index ddbcfcc70df5c..d9e690e5ff4a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -467,12 +467,16 @@ static int vce_v2_0_hw_init(void *handle)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	DRM_INFO("VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v2_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6095ddf1d7b79..fcf7ebad605c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -477,12 +477,16 @@ static int vce_v3_0_hw_init(void *handle)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	DRM_INFO("VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v3_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 70b8c88d30513..2050b890bb4a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -530,12 +530,16 @@ static int vce_v4_0_hw_init(void *handle)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	DRM_INFO("VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v4_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 462008d506904..923a71350962c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -213,7 +213,9 @@ static int vcn_v1_0_hw_init(void *handle)
 		goto done;
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 02ae3e7a8a552..5eaf3e13d0efc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -248,7 +248,9 @@ static int vcn_v2_0_hw_init(void *handle)
 	}
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index a0956d8623770..063d732869de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -307,7 +307,9 @@ static int vcn_v2_5_hw_init(void *handle)
 	}
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 7085c1f45cf74..f1ad7fdd035fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -372,7 +372,9 @@ static int vcn_v3_0_hw_init(void *handle)
 	}
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
-- 
2.53.0

