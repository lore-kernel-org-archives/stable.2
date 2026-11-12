Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453470;
	b=LyEmf6Zmn+blR7uCTSWH3ZSRjfX4kLGRtIqFPW93kLLo5n7+GKp+CLatMryLF94lWtok
	 j+omNGhBaRxbgcbGp+YQV8szSdb+m73Q+SvGluTUZ5airQkh1Qdj18WEbQzY99KpVruhF
	 +dAM2q9vqsnXVSogKL0HJR0KPl8RU/sp+mV/nUXClzihZSH/aRxNAfzrWC+vEpZHUaGvn
	 tJhg0f9Y5+qhzRca3hG0hw2zHlg5a1IqlY4c0wSSIr9xNkbmmannSWokb4xp23uGPyJX9
	 Vd86P0nsFY5AqW0RH6N6djAcAOQ+g5vySDVUmY0VTh7BWSjBd/jafh3WjxFnV4cmLhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=On2c35btmNhmiH0etPL6d6aMVFYONbECDtu+DNw/Lvc=;
	b=CLS5PXpfkRqHXmXfSIEtuFcJRhDeR05CohnMjGYVGWeR1xdmtSjY/RomSKUTlBkRJ4kI
	 krVBZvnzkqdz4evO6Lb3qK5z906H5FJkpQrXr6NYJEXz1WAX5axCMkywyavdTOpiG4Kbl
	 ZFtqfZmfOYBez6a/vQNTyrr6qvbTdlCqYKfdmd/RJCNsUM+1AAS4bHKL3D+RMkDfPu/RU
	 2oj73ZLoDQtYUzUeETkmG8wpkLuE5eN0T22EiicuKaNxSURcVSJFVUTRPW7CiqkPEGFLv
	 7sVItfwYDJSHKLs2oS/t9ZVvEfjxJcZnwJxpbyOQRC8Mvu9D/GGmRY5zPxEts8r6/Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkgRUAFf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFC606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkgRUAFf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E7C1F00A06;
	Thu, 12 Nov 2026 03:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453469;
	bh=On2c35btmNhmiH0etPL6d6aMVFYONbECDtu+DNw/Lvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkgRUAFfPHyluaymmxs84LgvWdc31X7cbCikooexE6Wzum3CgExpfr6ZXGsy09Xij
	 y6yKWG/3DlxNpRzQ3CXiMZNJlbwdCiJ+uOQQun8hBKOFusXkcwAA/1oRwyZ8whl1x9
	 jVocjgfDaS+hCY398oyljzB5WhF6xGbrL47iXyBo9tA9tuwaTJasZK6OaG2tQPnmMd
	 sy76iBIEwDxU0Slqaodb2cXbJBdh1/YpZNhNfxKddgIguVkA74MEhTBNpH1TwUvQZl
	 vi8ztax2tY4OvAT4ZmAopstY/hb9eY2s5IldCLb/uvweIHj+WBFYoNmUH5uxzmbSY/
	 1hDEoulQSXCOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
Date: Wed, 11 Nov 2026 22:17:47 -0500
Message-ID: <20261112031732.1416232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201417-failed-6.6-733389cb31e2@kernel.org>
References: <20261109201417-failed-6.6-733389cb31e2@kernel.org>
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
[ sashal: Adapted helper reordering to inline code in amdgpu_device_gpu_recover() because the upstream recovery helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +++++++++++-----------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2cdbee6700ecd..41fac9d273622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5511,7 +5511,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (need_emergency_restart)
-		goto skip_sched_resume;
+		goto post_resume;
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -5522,7 +5522,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
@@ -5567,7 +5567,28 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto recover_end;
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
+		goto recover_end;
 
 	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
@@ -5603,26 +5624,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
 recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
-- 
2.53.0

