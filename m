Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523497;
	b=0JcFtSu1O5W3In7q8xBlKShKmPaUyjZAhax3Nu4GoVl+LIRYcgnDQHoGNGpPcMXfT7TD
	 BFLBO+2xasmW+pti7fjb/HUxKNHxSqnDuaf7Xt4JjexUbv19jAAd9790CWiZcin2T+594
	 kziIPGH54y4bUEZKpS+ZHmxPLJTfdQY0uuqBP5LRArc0jl4aasiTmJP8Xd2jHu/hWwfts
	 pxKPmPbA6+gsWA62sNTsXFnWaMHvUjSHHlXVQ62msLm8ucLjsZfMBx7/mi/Urepa9tBNE
	 /6ToaBOOi1ERbz0+FRoIAOXPlqweQIjtqqSZ5XseLslrkpAVyhXtBYnB4L4Te/gU2TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z8lQchgAvfIy5qvQKF/R4SHl7gFJVO6/srKv9v+eDmA=;
	b=oFOLG05zgHgZ4MNUNsoKZ+UFDss2KB3tAH9CxcXCLEv06h86+aRZ3TOmXRIG53LJ1BfB
	 678XJXNDXbvdzsb0avqae2bs6ITPvROt2dk2oJ3yOKn/DzSNf8VHj55H//HlgbkGiGZJA
	 Ox8K1hwft8EnD/YYxQwLMi3UBgeE7CHLpc6IvGg94OOMc3g56j1yx+IfU5nZUkNd5TPaS
	 Z6OcmwD18IU4+lHT727D5kC6dfm0NewzRgG2Vp7U2rv/dydV/yp7EOSi6Q06rFcOXnRZZ
	 tErp3U5nsK56b7pv/OQQJ+ein21f9LeZJXk6pESg4NliVrCesxmRoxppNnuL4cqPsAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9Mcfhk+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F7606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9Mcfhk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B73A1F000C4;
	Thu, 12 Nov 2026 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523497;
	bh=z8lQchgAvfIy5qvQKF/R4SHl7gFJVO6/srKv9v+eDmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9Mcfhk+TlRMsFOd8is4Bd3QkFewbEzgMLiKXCy7Lbl+wM5WHZYgZG3RjU4g18cRj
	 gWeESpwfnzTvRcNlopB3AE/i9QFdkvh/ToxnKtTZqQlwKJ7qynJIgqqvl9l9SUzvBL
	 nXF0UeGIh1Xwo/waXYK+zsFvP9rd7DG38KYE6wvcosh6HIe35+rIKQzoqE/6wr0K9O
	 SOzKOcz+5UAtnev0PTBw5hhSQaAoA39WttqzNo00BfRAQV7YOBqfcAuUs8x9vybiNb
	 MVmCjmw8O/HwCsXnO1IU3ntSLVrKRmhbuZxbaGd+jFpgjejZ9b6z7Fhu+KdwIVtYp4
	 yWD0W3a05v7fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg
Date: Thu, 12 Nov 2026 17:44:55 -0500
Message-ID: <20261112224341.3916201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201920-failed-6.1-a56c2536c399@kernel.org>
References: <20261109201920-failed-6.1-a56c2536c399@kernel.org>
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
[ sashal: Replaced per-instance VCN cancellation loops with a single cancellation of the shared VCN idle worker. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c  |  4 +++-
 17 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index af8f244e9c940..f54a3dc761fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -135,7 +135,9 @@ static int jpeg_v2_0_hw_init(void *handle)
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
 	r = amdgpu_ring_test_helper(ring);
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	else
 		DRM_INFO("JPEG decode initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a094dd138c0d5..6e617209c082b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -184,12 +184,16 @@ static int jpeg_v2_5_hw_init(void *handle)
 
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
index 54cbf62a8deac..d003d8277c584 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -151,11 +151,11 @@ static int jpeg_v3_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
-
-	DRM_INFO("JPEG decode initialized successfully.\n");
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	else
+		DRM_INFO("JPEG decode initialized successfully.\n");
 
-	return 0;
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index ae9e390c8bf6b..5ebe2d42cb396 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,11 +143,15 @@ static int jpeg_v4_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index adb9f5cb95c23..13e50191d10ee 100644
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
index d7e31e48a2b8d..ae24b92e00d5b 100644
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
index 5fe872f4bea7e..cc1c1949fe2f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -513,7 +513,9 @@ static int uvd_v6_0_hw_init(void *handle)
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
index 91ef914b4cdc7..3f370883de568 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -581,7 +581,9 @@ static int uvd_v7_0_hw_init(void *handle)
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
index 479eb9382c77e..03e8543604dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -469,12 +469,16 @@ static int vce_v2_0_hw_init(void *handle)
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
index 27b2c4c7c63ee..26a5744ac407d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -479,12 +479,16 @@ static int vce_v3_0_hw_init(void *handle)
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
index 66cd3d11aa4b8..28de74c9bd4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -532,12 +532,16 @@ static int vce_v4_0_hw_init(void *handle)
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
index f0fbcda76f5e3..094cdb16d566a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -199,25 +199,28 @@ static int vcn_v1_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		goto done;
+		goto error_vcn;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			goto done;
+			goto error_vcn;
 	}
 
 	ring = &adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		goto done;
+		goto error_both;
 
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+	DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
+		(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+	return 0;
 
+error_both:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+error_vcn:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c271f3f0c70a1..52d454126b9e6 100644
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
index f2a07794a2868..067df13a36b29 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -309,7 +309,9 @@ static int vcn_v2_5_hw_init(void *handle)
 	}
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b73c642b7dc61..15e7ddce879dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -355,7 +355,9 @@ static int vcn_v3_0_hw_init(void *handle)
 	}
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->vcn.idle_work);
+	else
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 608ee2a4d6275..83d997f8d500a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -261,7 +261,9 @@ static int vcn_v4_0_hw_init(void *handle)
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

