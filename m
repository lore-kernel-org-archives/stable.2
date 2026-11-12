Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459043;
	b=EfzGtUsUf11nsQmYd2s2md+YXbx5AbHWtH7LT3zzzmmsYJiXzv9qrZnrhM+NgDV+ehaT
	 7mjLRC5t1LfV2sdgrnQS2VcSLJjdmcfWXCJ4g8C/kInbyFrHItVEt1Q1ZJk54OlOiOqGh
	 pSPW34OaGId0Pn+sMN9ZT0nazHSXURPZs+mpB9uAo/Byc82TV5n7MZKVi6rnblNR3tiRn
	 +wU5BLTvtbURNufH4g/wu+izdwLZgvKxVGAas0wk8qG/DXa2asSprl7IOfdPDfj/nYKar
	 2auaoCQBuCSicULj+oNEPoSU8TFmjk3gzj9x2GthUKXAuppIhLydZf3kMfNlxmAyNdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=piau1wGGLVV1PSBjDc1R+tsES5wgEl/GoelQkVUF76Y=;
	b=xIwzS+WpRR6GAqDcDs+iuaLj9oMDgVdfzXDGEzWBSrTBJ4SzbAmFY3KzpFodA5yVIN+H
	 /9L3XjR+qoDIKfrqaxp3DGFngTJaCm+i45Br0/wQ490ztQZX250kIwGHU6sH1d29qXA9M
	 G9/9pL5jelf0xdYaIzasL5yPkavdyXinX4QBmV+raQrnEsvhGInf6XFtlJitt+KKrCHzQ
	 TzL6/1BsUQJv0KQZBu6LYidqfwY9tvBvAnsRmmzCBImsonFCg0IBbvHevgIZbpHbO38JP
	 mMnOnR5iQ9JsDGwwmNtyMf1FRKl7Y+3cV8E4WzUe+RYytfmyyPs/k1oFJdeX1dPev3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WEFd/rgn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB0606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEFd/rgn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785DE1F00A05;
	Thu, 12 Nov 2026 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459043;
	bh=piau1wGGLVV1PSBjDc1R+tsES5wgEl/GoelQkVUF76Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEFd/rgn/tWSd+CGf6QOMezar3AwNAmdnJ8iTKUfzKuShtTMPiXCtcTF4eQEWo4wo
	 2L97GCx6MBkSMzx4vxFcjEuX1sy1wiFvWD11HNDj/jrkO9NOM+Q271RZILBpG1CZo5
	 ci3UTIXFWIo2J4RNYw3S4jiALIi20TbuBP2cwuceTAQXv5nZsC+RPFy9s5d2RRtHN0
	 YE2henmh26/zp/b2Q43dltK/yhBNd+A32cRI4ejkirdAaY8vHElMhxkpIEEru7KVnF
	 iicb+G6fvY+wPy0s6E2ZM8mMXh5Vrk8oGYuYcPwel9V8nHzsUC7d0ub+9pGOxP2dHw
	 r7DTp92RR2TFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
Date: Wed, 11 Nov 2026 23:50:41 -0500
Message-ID: <20261112045024.1831966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202836-failed-5.10-733389cb31e2@kernel.org>
References: <20261109202836-failed-5.10-733389cb31e2@kernel.org>
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

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 733389cb31e2c55e355410759fdc68afe74a4582 ]

Run GPU post-reset callbacks, including KFD and display-audio resume,
before restarting DRM scheduler workqueues. IP hardware initialization
already happens inside ASIC recovery; this change orders the remaining
callbacks before new scheduler submissions. Preserve the emergency-stop
and guity job completition path's callbacks without starting schedulers,

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1f6433e2b264e75c56ae95f187788806201bdbc3)
Cc: stable@vger.kernel.org
[ sashal: adapted recovery helper reordering to inline callback code in amdgpu_device_gpu_recover() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 873346c377787..ea0fd088c97f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4646,7 +4646,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (need_emergency_restart)
-		goto skip_sched_resume;
+		goto post_resume;
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -4658,7 +4658,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	    dma_fence_is_signaled(job->base.s_fence->parent)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
@@ -4686,7 +4686,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto retry;
 	}
 
-skip_hw_reset:
+post_resume:
+	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+		/* unlock kfd: SRIOV would do it separately */
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+			amdgpu_amdkfd_post_reset(tmp_adev);
+		if (audio_suspended)
+			amdgpu_device_resume_display_audio(tmp_adev);
+	}
+
+	if (need_emergency_restart)
+		goto skip_sched_resume;
 
 	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
@@ -4721,11 +4731,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		/*unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
-	                amdgpu_amdkfd_post_reset(tmp_adev);
-		if (audio_suspended)
-			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
-- 
2.53.0

