Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457146;
	b=ZiOB0HjISExFNYsT4QHyqOqRZKjQTnx06WqTsFtS3KLM8m9AEPFUhEkDE+yXVCZfHgWE
	 MFj03HnXlKecEkZngktMWLRnXbizmeGFNEExQA0NXDVoVkVfKckgy1kBO+8l3nK+6jZmd
	 IoxYknK4Dwxd83XcBvY8IShvgFYYZDOjf0jbL4n2ZD7kLNul6/+DmkusRjkzocEX7LuFH
	 QrtZqaxWe9zzcNl2kQBp6MYi9MBaQKBORtytQscakOUFZtOwhzquav6m2g0TMUExvWsHT
	 GahkOgPW506pnYC8dQvpnVfGFZsLZz0e0PydMZ4dhC6kJGozpaGTJtMh6fB6LZ6oHzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z1dyCp0qOBCzCfQkd2hXV2ddeNfrXOY7W2VXk2YDwvI=;
	b=f3ksPW3tvYFecZw3YRSV+O0PXHifDE1AqBzI8fdI0Pr0ntcrKpF4WOYfja47j+BqVRMt
	 y6SuCnFYJ2FCZ22lZYuMBtw0K61hTBZAboHcuPGxWNqB2zUnf0RmTZ/GsyMqiJJU2eDsx
	 dslIPZxH/tZorH22N0QNya4MqJj7VXy3qgwWpSVyCXLsSF+e1ygMF8S3aCBCXdoHA0uYH
	 B/5V6WKg0awGWbETG2/TrVRQq/Wc+r+/USgwl9mYahcUVdQ9Eu0J3Xl2bMr+eIOXQiviW
	 KfWa/hzmRPn3zSd5fMUyiEUlwC0P3aboqhyaeaEgUsP42S7BPD442mqoYMJvGWlBpaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID87B4qF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112B606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID87B4qF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367F41F00A0A;
	Thu, 12 Nov 2026 04:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457145;
	bh=z1dyCp0qOBCzCfQkd2hXV2ddeNfrXOY7W2VXk2YDwvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ID87B4qFd3jA0HMg5g3pj8+E1zzZri35o6Cku1eyytc2sZki/57e73NFuRgX6EnmL
	 auGrw3ozXiaf7aIwhjJcgAgp0/r3BFh3d+tkR+MYcbp3SmxxGD8zj7Rc4ScAnFU+2i
	 uB7lJ9xSj8dNzMUEhnCfT3VkOvalmSzDo9UcsGkaXyxO7/4spJ08PmicjY+gWPohFW
	 ioYO3sdSfV+jcqBxAAJiv/F9gQShxeH31GBozB43dw8LdZRkMpFmKuTg9iVIPnjaZ3
	 eNskEkLzW8YA0jUZ6k1L45MrEWAx1Q5MDS0nCxEFigPleh2GWjtQ7VDSZg9LaXQ2Lx
	 /46fwMZ19Ws8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
Date: Wed, 11 Nov 2026 23:19:04 -0500
Message-ID: <20261112041848.1555523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202409-failed-5.15-733389cb31e2@kernel.org>
References: <20261109202409-failed-5.15-733389cb31e2@kernel.org>
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
[ sashal: Adapted resume-helper reordering to inline code in amdgpu_device_gpu_recover() because the separate helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++--------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f9fa4a7caa69..9c98084ac1234 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5296,7 +5296,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (need_emergency_restart)
-		goto skip_sched_resume;
+		goto post_resume;
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -5337,7 +5337,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_hw_reset:
 
-	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 
 		/*
@@ -5351,6 +5350,29 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
 			amdgpu_device_recheck_guilty_jobs(
 				tmp_adev, device_list_handle, &reset_context);
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
+	}
+
+	if (need_emergency_restart)
+		goto skip_sched_resume;
+
+	/* Post ASIC reset for all devs .*/
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
@@ -5384,18 +5406,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
-	                amdgpu_amdkfd_post_reset(tmp_adev);
-
-		/* kfd_post_reset will do nothing if kfd device is not initialized,
-		 * need to bring up kfd here if it's not be initialized before
-		 */
-		if (!adev->kfd.init_complete)
-			amdgpu_amdkfd_device_init(adev);
-
-		if (audio_suspended)
-			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
-- 
2.53.0

