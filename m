Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453924;
	b=3KOfklmReRObeb1ig+i98nNCxoMkocwLAbqFbOIFwpC0adS114LKb+A6XTUDj4nBA6dc
	 NTN2bHhqch445owAtKD78qlIOmyMz41FNVeBQtfNdOOBS5hwVvD4kjQYj8/ATkO6eYpuz
	 XkDxiSSBRLN+Y/3f60dq36AWLQrNceFGNFE1EbAXVCUgZklHLJaB5Sz2IWsjaDcmwJDV2
	 R1U179+LJBpMFCMln0JvpzF/Sx7nZnxT9zUQWEyGpvABKdSL5f6gD11VQOxyvQYTIyi64
	 CYgTpAENypk8hdfXrGoZlXHR+wLMX9sHt7AvOe7fzaau9wOwr2/N6Ql1fX2lJjC45Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vn70rYA7eBDOsarQU6IYPBpAxVkrSFTCHahZu+HMB+g=;
	b=BOfESdGfx1Z4Adv0q8yu1lSf2V7NBiukt9EfYkXopybGXWDd8HECQ4n6HRryQel2++/V
	 Yw1F/EvgCUkkGcrf8pabHBtaF6iryWmQs2QuVinoOu7MM5+/x4BFH5UjUdBSPXEyHT/Tt
	 1Tvmj9uYmtuF9ETA0Abz0RAo97DEl16JjLchRPK+pV0YGGEwQ9USzd7GV8RRspbICtPUG
	 XrzVR9kRAKAiE7nppF4WZ8u8Ri5QullhXdPq9QxYZfxcUO0p0bHuvTG9gqkUfOjL/P8UE
	 gVaZRLLwccUH/ddXpcfY7r/oh7qf+sA6/c60+UxdhbvEEEjGsT3w5sfupe0S3u5leeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRVGsT4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E98606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRVGsT4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21DA1F00A05;
	Thu, 12 Nov 2026 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453924;
	bh=vn70rYA7eBDOsarQU6IYPBpAxVkrSFTCHahZu+HMB+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRVGsT4VxzXkabU9ag5tk3Y9IvTc0SreXN09MXk9zd4pGmi19Mg5Uz+7nHHb4fW2H
	 wDowJF84hHI2zYLpm9iGvzUOpTcnQ2B0VqJV04zUMYWZlxMN9p1he1mq/iNGm+oSWi
	 7mneDUtRyW8/JPEhOktf2isUx2PcyRq7kfgpqaL6HF1SqIraWiiHjOFmb+wxHDDdMg
	 DcNSGj+XnzW0rMGzl46cASRu2LlpB/e5C3bPctx9pAvr/T6duE6M7nH/W0Mw3Xq4u3
	 eQJNJ0KWVDKnAj8SwY9v6Ksscs2zYUbGlopaCzZeqe5ZeZPnjS2phm0GFuQisRLrsN
	 Jh/N9XEausdtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
Date: Wed, 11 Nov 2026 22:25:22 -0500
Message-ID: <20261112032500.1401957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200944-failed-6.12-733389cb31e2@kernel.org>
References: <20261109200944-failed-6.12-733389cb31e2@kernel.org>
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
[ sashal: adapted resume helper reordering to existing inline code in amdgpu_device_gpu_recover() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 +++++++++++-----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a8f8bb342884f..bfc77c4273330 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6018,7 +6018,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (need_emergency_restart)
-		goto skip_sched_resume;
+		goto post_resume;
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -6029,7 +6029,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
@@ -6075,7 +6075,28 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
-skip_hw_reset:
+post_resume:
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		/* unlock kfd: SRIOV would do it separately */
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+			amdgpu_amdkfd_post_reset(tmp_adev);
+
+		/* kfd_post_reset will do nothing if kfd device is not initialized,
+		 * need to bring up kfd here if it's not be initialized before
+		 */
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+
+		if (audio_suspended)
+			amdgpu_device_resume_display_audio(tmp_adev);
+
+		amdgpu_device_unset_mp1_state(tmp_adev);
+
+		amdgpu_ras_set_error_query_ready(tmp_adev, true);
+	}
+
+	if (need_emergency_restart)
+		goto reset_unlock;
 
 	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
@@ -6114,26 +6135,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
-skip_sched_resume:
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
-			amdgpu_amdkfd_post_reset(tmp_adev);
-
-		/* kfd_post_reset will do nothing if kfd device is not initialized,
-		 * need to bring up kfd here if it's not be initialized before
-		 */
-		if (!adev->kfd.init_complete)
-			amdgpu_amdkfd_device_init(adev);
-
-		if (audio_suspended)
-			amdgpu_device_resume_display_audio(tmp_adev);
-
-		amdgpu_device_unset_mp1_state(tmp_adev);
-
-		amdgpu_ras_set_error_query_ready(tmp_adev, true);
-	}
-
+reset_unlock:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
-- 
2.53.0

