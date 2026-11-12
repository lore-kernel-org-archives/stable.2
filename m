Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455786;
	b=NRqJGOnVF3hsQBkmci/nbv5qiYDsUUqobxrgv0Az/VgxbDWGkzmtFhkXCCKGZFf0aqcy
	 kt3ueFPo/7MU9LFts2gdzmpQlGyW1coKcrf6cJ9HDFfpVhEgP8tVdFHoiHsPqyX5lI7Rk
	 HwAK7Qi05bnieeBYN12fa+weLFyvJfd5KTOC0aBCvv0BTpLBfB71OlzJHh7up0RcfcdZv
	 4B/1I45fZGbNpreWZ3UYjKp1EXvaiAEuENBKWhC2jTHeyjTE1Jh+cCO1bz1yK/VoDWZ5r
	 ezlS0GHst6E+Lf76c+ZKUdSvn3SoClHqH+IYvHgCjSzuIh9Upd26I2oYG6na76AEjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EAhXseB6H0YcI2lUHSQWeRc1GnlOIDH/HLV7tFJX42k=;
	b=qadYePuZoU/QYhFA+rBd9bOvKxhGMEeyU8kdA3sMEi3gYIjbpZjVUBJtJYnJ+AOXL+Ix
	 U0gaq643w0kMg6YDsVHW54lBKZm78DK/q+vrjh9kimjKcz/YaxLZ1WJst0feiZolljnd2
	 NwZjD9gruubkRXzmuLYAvZUWaTikXLpZ9N9Ol/zeS+YxiAu2JuGzHCM9wg/O7ypH+Ofbf
	 P4RXK/Cb2g+YVYVm0WdJNOUoqs1CSIgPPBIKd3cWeda4Jau5hDBRGu62RUvB2Rd6Qr+mK
	 6qHCMKdNUo+E+x4EwHvk/UFIaTuY4+pXXWhEQLd3W8l+qtMxBVxCqnZ9drS+8iuGZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEF6wWxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33126606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEF6wWxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C831F00A05;
	Thu, 12 Nov 2026 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455785;
	bh=EAhXseB6H0YcI2lUHSQWeRc1GnlOIDH/HLV7tFJX42k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEF6wWxblxzVRmyFplXnQMX53TIG9lbpRQiEFE88U9ckEErpp8VIQwExXdRPZhPto
	 2XkM/LdPS/vdHPg+f/ak+UqBjOJV279MaYiGefDWz101rVJ0h5sJcWNOGYSQeRM+3W
	 MZQkBUa8EBrda5XeaG8fEmTZWwmYH8mVGYr/r5UVK1gOEEnYql5XMb+2frAJcPVD1Z
	 FgUWGpfbkAKV9uYqWR6c3L68kwlRJ3q351LEDwroDzGd2rqyZicuEJs1SM8y4IYl27
	 evMmYvgpi+v7+JDwk4Fb5/i5f+mLVzRZAcpsku0Yc4s3aKx8od7dceFdUw2P24Geru
	 Ho6BeuaA5XdOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
Date: Wed, 11 Nov 2026 22:56:23 -0500
Message-ID: <20261112035607.1542041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201906-failed-6.1-733389cb31e2@kernel.org>
References: <20261109201906-failed-6.1-733389cb31e2@kernel.org>
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
[ sashal: Adapted upstream recovery helper reordering to the existing inline recovery code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 ++++++++++++----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8bd9ecb88c94a..3cd3fb1a5eb4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5621,7 +5621,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (need_emergency_restart)
-		goto skip_sched_resume;
+		goto post_resume;
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -5693,7 +5693,30 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
 			amdgpu_device_recheck_guilty_jobs(
 				tmp_adev, device_list_handle, reset_context);
+	}
+
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
+	}
+
+	if (need_emergency_restart)
+		goto recover_end;
 
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
@@ -5730,24 +5753,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
-	}
-
 recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
-- 
2.53.0

