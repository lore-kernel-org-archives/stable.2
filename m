Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272993;
	b=g5Og8+1NWp1cy+WrLJzSGs4087K7vOwEcWD5spUuVu+Gj6RWGeLZSubp1mmxhRHQSzp3
	 nbhcyPYRWGJqyfU/Wob3RoUc1lcbNI8GsyiEU6nFI0Gt6P7BmLz8MLs1T/689tjRXl6dG
	 O8ntaEfZlAYBrKgdq01ck7MKp2afqftRijtd4Oy3b8vo62Un+GfYfeAtIveIcVANbB+HL
	 Kp/udxNJHPHNs5CDcMKWhkq9M+7xmYOU4Ea5WJPFLo9aBwSHR6Tp0KyEkcy3elGhaFMaC
	 xhBMNzZLXDFpJIDwpqARe6pRVNyMW27edGEhGBVc9hfJxujYaguqtdi4X3UeEUqrE/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6Z/pcMJfjiiTGW+A7Pc/uOpCy+3HbyqLoOgLbO/bU00=;
	b=kqeDFEme9iVNSARGzyJu4GNnO7rYzn8oabxZrUiLek54vPOKBjXWFKLGVj93tYXJ13vn
	 KsDezSz29KQFJ5PRrrzZspGK+Yyihy1jffkF4yYU0gnaw+tb+bJx6lDxJJRZb/pffNleP
	 GUyULzDiiaicqtnNbcr0Pc+kQX3JUpD8jvCdHH5U68Mbwx4enftccvO2p66YLqcYcdJR/
	 9ALL+8eRKseqzl4I3M0xvVL0QPAxNCMJSnfvXmPkpQnXokQR1gSX4RLM65r+wcjBBWLIa
	 xGY91tQoRbQbN1e7ZUn4NETOrGD4ZeP9Qem2mQQiu+OGs++p/CV/hLdbrJJL+nwezmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dCw/5oPP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D4606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCw/5oPP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3C81F0089F;
	Tue, 10 Nov 2026 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272992;
	bh=6Z/pcMJfjiiTGW+A7Pc/uOpCy+3HbyqLoOgLbO/bU00=;
	h=From:To:Cc:Subject:Date;
	b=dCw/5oPPQTKiZOb6qmLtDXZO34EBIW2/VSJTYs6znU/x422F938cDiyP/6TY3sie5
	 gGL9xjJuA7Dd8bU2mUKfKoiYSMF35ZWyByDnA3kOcIURvGXTRwo00LEtAf7caDs3cU
	 4ocBK3rCzbXmxDKUqFInYthamVA89sGAiOq7VZ3/q+ana7ZpymRn6UCNbu2H0/mPyl
	 y/6Xrs15FX79ZcDFom+RdYsxfj3nahwFCF+wCPwRvAzLVLUCGN8ihVYndnaVBcJ1Q5
	 E3z7cBC5p/Tq53EvTzg69rSTv9ldIB+6SyFTEghy8ByUwpnYg5XsuRl/itRjztogea
	 c9sO4jKMkqm+w==
From: Sasha Levin <sashal@kernel.org>
To: leo.liu@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:50 -0500
Message-ID: <20261109200950-failed-6.12-a56c2536c399@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a56c2536c399d57a9bb1c02fd411e0c25859af3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200950-failed-6.12-a56c2536c399@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a56c2536c399d57a9bb1c02fd411e0c25859af3b Mon Sep 17 00:00:00 2001
From: Leo Liu <leo.liu@amd.com>
Date: Tue, 20 Oct 2026 14:07:20 -0400
Subject: [PATCH] drm/amdgpu: cancel idle work in hw_init failure paths for
 vcn/uvd/vce/jpeg

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
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 10 +++++++++-
 29 files changed, 174 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1f..7ce3396b1431c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
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
index 2968256d4cd74..46293664fd28e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 
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
index 564e40899df22..361d0f4b4bc7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
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
index b29ca3a49939b..4e8eed2b62db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 
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
index 0343a64595f2c..1925d3092d027 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
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
index 4da3f9c995c11..a1496412810c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
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
index dcdb089b43083..1a4594d5d9527 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index f2debf6b6bd07..efdc537ec81ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 						    VCN_JPEG_DB_CTRL__EN_MASK);
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index dd0abce73687c..eb3dc9558e0d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 						    VCN_JPEG_DB_CTRL__EN_MASK);
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 8ddd12740a040..0cbb2b8a7e78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
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
index ff7128a11cad0..97c265daa2bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index cf304b489d872..90b57a08d6dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 564d8fb58905c..aa75b2691d570 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index dcb8487e22b17..3016227cf0ed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 done:
-	if (!r) {
+	if (r) {
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	} else {
 		if (uvd_v6_0_enc_support(adev))
 			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 46222fc30be65..48eac56f758e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index b1428f5bbc81e..0ba9bab7c9210 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	dev_info(adev->dev, "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index dd870ecac2a42..20a4cb6d17fbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index d5adccd3e6895..7637305df7e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe474..4e1fbc7b50f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 76793a5caa701..b3e63d6e79a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error_vcn;
 
 	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error_vcn;
 	}
 
 	ring = adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		goto error_both;
+	return 0;
 
+error_both:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+error_vcn:
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913ac..12ac204843963 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 10ef5616b2f5e..2b2abe6895084 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -481,18 +481,26 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
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
+	for (i = 0; i <= j; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0f4f4d66e2e4b..6543f21daa1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -417,18 +417,26 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
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
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da8..8b5646297c2eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -349,11 +349,19 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c3192..0c58ca25d7b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -395,11 +395,19 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return r;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07fd..a6eaa57ec2eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -303,10 +303,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046a..055729a42094f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -267,10 +267,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d4..55a4b2f9463fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -342,11 +342,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08ce..ea6cdbcb6352d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -257,11 +257,19 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 
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




