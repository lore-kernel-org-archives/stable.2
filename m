Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516869;
	b=ZxdQLQNVuCLMnBkkOKS+53//iKQSJ9RxK7ZO0lQFSov1jX8Q9hHkO6AwXOnX6cnb137H
	 ApGJKq3TkRx/auwoEsQ6C+75acKlctA4utZ1WFF7b6VQi2RdgR3/ZLwcba+bj5GC+q9Li
	 Z5NS+mc7hxGenHjXcaRTQRXnAittxdquemtdnYMfgGXXyx61/W8wK1DnXhAZ7IkSvqnl7
	 EFdVGmzpA9g3QFD0vdo5QVn5kCsYsU11+QLCCt+c9SfuzMcuFo1NiNnq/b/xhgZGxi4IP
	 /JL3qJmYe3p7xiu5QkS7j6ekfY0dxwkxhLou6IIP+0g43CwBhApN+p7K/Pw5IgPuu9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jDZ3RsbR0lzjh80RdYaGoiyqcwZFdKq6Ev4bKa5IKmQ=;
	b=zBZd2nVti5ZSebNxMXeWde51xBPFy6AisZN4qfQLgJF/CsQBZEJJKZr1LW0TrH1j1yGu
	 /TQhOsPAJInA5zR2o2nygKkSufoEZcW7j2Aq9y1E1tPeUois1TPgdHuNaC0n5kUjBbksG
	 sRgonBJcYWUkjt1L9xl2zYzZ/aPlAtUhDN74aVL3ZYvCsTv5b20/3bjrLGRCBXVZGiIus
	 qg5HBVvdynMWn3yKBKg2wYQIZ341c9BOVh7abgb9nrsjkKymndJGo0W/MV9L6NHxrkBGI
	 VG2W2yd6eW3Q+UinFWBbCDdN8hUGKiS/7uBD4urU1RovZJaUzFpxg46D7vsErqly4Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvN+C6q+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD951606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvN+C6q+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8A11F000C4;
	Thu, 12 Nov 2026 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516869;
	bh=jDZ3RsbR0lzjh80RdYaGoiyqcwZFdKq6Ev4bKa5IKmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RvN+C6q+ZjoLw3p2/lt4iN0DDCOKXfnyBdXAoM7mMOFI1mJACOSEflt+3qCpdDs2b
	 e3tOW3trS38L4RnQxjjCw4NFdUnM8uaFTeugK4OE8Ilhz75ukbr3i5OfWaTeKMBZcc
	 DpF10LenWkkIK5yf9GYlxYQAiVc2xBvMfIg+M7RZP6E+j4E53VJQpvTAfOgKrS/d+i
	 Ja2twDDWTCK1zXa7kgacR8DFk6kILAEGg2JhB2LqP59FVPF0Ic5xOANC+p42oYD6Cm
	 29zWBJMpelUfVTDzMayzyVwHgpfhnZxooNIeG+OwpBtwOqWe3wFaYUWouU+wbIJyGs
	 TzbKA2qhWmLXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg
Date: Thu, 12 Nov 2026 15:54:27 -0500
Message-ID: <20261112205300.3543698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200950-failed-6.12-a56c2536c399@kernel.org>
References: <20261109200950-failed-6.12-a56c2536c399@kernel.org>
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
[ sashal: Adapted per-instance VCN idle-work cancellation to the shared VCN worker also used by JPEG 1.0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
 24 files changed, 119 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 5c95cf6167d94..3135ec3ac25a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -132,11 +132,15 @@ static int jpeg_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index e4cfa6b7141f6..22ad2213a85e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -193,10 +193,14 @@ static int jpeg_v2_5_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 27a27de6c6c3d..635279f7a9090 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -146,11 +146,15 @@ static int jpeg_v3_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 90f64a46bff7c..e641b1a917349 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -178,10 +178,14 @@ static int jpeg_v4_0_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c4f812939a85f..76d9201d7249c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -347,12 +347,16 @@ static int jpeg_v4_0_3_hw_init(void *handle)
 							VCN_JPEG_DB_CTRL__EN_MASK);
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 78a9fb26bce2e..3ec310fbdb903 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -201,10 +201,14 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 		ring = adev->jpeg.inst[i].ring_dec;
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index d0f800e7938dd..cc3344b069746 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,9 +145,13 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index dc5cc48a31350..ca13fa271288a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index a1227867dc887..c2d1d38c1b3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index fd4acb1300f93..2101f96f6b28d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(void *handle)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		DRM_INFO("UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 71a16073c43b2..47e7987be0ba6 100644
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
index bc0fca75417ce..a03b32f40bdab 100644
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
index 8a6c24b98f1fa..843227ec96e03 100644
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
index 4c7f6c2e1adee..5d4758ce474fe 100644
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
index 14ead62ec57db..df3220ab98bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -528,12 +528,16 @@ static int vce_v4_0_hw_init(void *handle)
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
index 563721c551634..be1e799795848 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -250,18 +250,23 @@ static int vcn_v1_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error_vcn;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error_vcn;
 	}
 
 	ring = adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		goto error_vcn;
+	return 0;
 
+error_vcn:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 29f5f6b1eb0a4..72975d44c1240 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -287,7 +287,7 @@ static int vcn_v2_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -297,10 +297,14 @@ static int vcn_v2_0_hw_init(void *handle)
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 20ef8835b12b1..e5cd2c9371358 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -365,18 +365,22 @@ static int vcn_v2_5_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 				ring = &adev->vcn.inst[j].ring_enc[i];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return r;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c175c58c6073d..518cde0476232 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -397,18 +397,22 @@ static int vcn_v3_0_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e9d43924bcd73..276d6e7d14bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -332,11 +332,15 @@ static int vcn_v4_0_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7edb6da93fd2e..f4061a2ed83cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -313,11 +313,15 @@ static int vcn_v4_0_3_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return r;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f0354a7dfb461..da0daf9bcaa2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -283,10 +283,14 @@ static int vcn_v4_0_5_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8994e4bdf4b6..3c7fd45917788 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -250,10 +250,14 @@ static int vcn_v5_0_0_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 0034e71283964..d0a6496b731be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -257,11 +257,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
-- 
2.53.0

