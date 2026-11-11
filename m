Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364570;
	b=IbOIzlXmj0KUAC82U/F4Pwe75lZe5LsShzSJXPpAvNaxABRCffRiLIq8u1ExO8kaenbU
	 hoQx8wBq74eWvFbTTnVHpE6PuZSiUTXATF97PflHAKFL/DQBM2qFa7Ihl6TZ44y2+UAPK
	 A3Wv7yccnMYD/JJaqoAzYa/Jk1th/+70/yfwDGPPgkNUBMZzn/WDFhV2UFc8FJfMUlgJi
	 EWyH8ISFwKigx41atWyfls1gm+zqFG/DnhE17NoUSbFJF/8hr94qt/a7Gm7wP9VvhuRtn
	 Li5ow3i0UgtgwZe4LRwBN7sA/enyAvJgVkmVPTDYUxACOeTrjbGqH9BHjKB6hYv66+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m58h36jzFfhLTkdlv0JDZoaR01pLQXzvZ69dBh+AM8g=;
	b=Q2zwGFnK7oEE6KD/xdTasc1bz0/qzxXtZmEyxgZXx+vijIbs+9WTXT1IU4pJYFVLiDQA
	 Kj1s6nNBUovqivpOHQh2p/3gqiFt2t43oS2eTJp1L+yEthVtmhkDCQICnNkh+tQDEVqan
	 fJQIJMXStq5fxFt0wnoyWcZcxe978ibIlMBoWXRpIWoBNsnHWV7wLJWt62R+JMyK5eR7N
	 AfizquDYGsIS2Zjmg8jmhAIR5itQFHgQUrNsMBOIJx5IS+RCgIJhiBS/Yc8TS+BNBMHYe
	 1ECORXBA3dIFGpV3ctysNIq5d2p0Hk30KNu8TMNisUY+rroyxHslhl5xkwlnqEtxq2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c53j5UWE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A42606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c53j5UWE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF01F0089F;
	Wed, 11 Nov 2026 02:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364570;
	bh=m58h36jzFfhLTkdlv0JDZoaR01pLQXzvZ69dBh+AM8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c53j5UWEVbq3AoyDRHU/etFg/u3jq2Op1DkTxdq2JWBvn3vARnFkkC0WAdbRtueRr
	 jfgQMzuXtC4GuqO5ggHYFrVYyX7fV52wY5gchXZ5C1j1fwXoVzg4xevL4dt0FpTvd6
	 jq+CbkCkar+qZGEn5iw7mQPjYt/v7ViGus9PcZYwOqKfd0l8IplPjNLlZuY4kXryvw
	 pfULz3b8vh3f3E1+lRS3nzJr9YBlZXvjgWBRf96bP6rt+dNRkmqpbBCx3qQYKgPL9f
	 fUQojNqz2eVy31jQQv8MyMBe1EBFhC9pTc6L7q8eWn3hmjRnAcHoioogfZrojaqXlT
	 uQtSVIMNxedgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amd/pm: Revert state if force level fails
Date: Tue, 10 Nov 2026 21:36:07 -0500
Message-ID: <20261111023600.717843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052445-failed-6.12-ad6eb088a508@kernel.org>
References: <20261107052445-failed-6.12-ad6eb088a508@kernel.org>
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

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 58893392989786eefd89aba48823dc3e27d37fd6 ]

Before forcing level, CG/PG is disabled or enabled depending on the new
level. However if the force level operation fails, CG/PG state remains
modified. Revert the state change on failure. Also, move invalid
operation checks to the beginning before any logic that could change SOC
state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ad6eb088a508 ("drm/amd/pm: reapply umd profile state after recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 58 +++++++++++++++++------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0f37d5ccf246f..f57d09b025153 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -974,6 +974,24 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	return level;
 }
 
+static void amdgpu_dpm_enter_umd_state(struct amdgpu_device *adev)
+{
+	/* enter UMD Pstate */
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_PG_STATE_UNGATE);
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_UNGATE);
+}
+
+static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
+{
+	/* exit UMD Pstate */
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_PG_STATE_GATE);
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
@@ -994,6 +1012,10 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	if (current_level == level)
 		return 0;
 
+	if (!(current_level & profile_mode_mask) &&
+	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
+		return -EINVAL;
+
 	if (adev->asic_type == CHIP_RAVEN) {
 		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
 			if (current_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
@@ -1005,35 +1027,25 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		}
 	}
 
-	if (!(current_level & profile_mode_mask) &&
-	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
-		return -EINVAL;
-
-	if (!(current_level & profile_mode_mask) &&
-	      (level & profile_mode_mask)) {
-		/* enter UMD Pstate */
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_UNGATE);
-	} else if ((current_level & profile_mode_mask) &&
-		    !(level & profile_mode_mask)) {
-		/* exit UMD Pstate */
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_GATE);
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
-	}
+	if (!(current_level & profile_mode_mask) && (level & profile_mode_mask))
+		amdgpu_dpm_enter_umd_state(adev);
+	else if ((current_level & profile_mode_mask) &&
+		 !(level & profile_mode_mask))
+		amdgpu_dpm_exit_umd_state(adev);
 
 	mutex_lock(&adev->pm.mutex);
 
 	if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
 					      level)) {
 		mutex_unlock(&adev->pm.mutex);
+		/* If new level failed, retain the umd state as before */
+		if (!(current_level & profile_mode_mask) &&
+		    (level & profile_mode_mask))
+			amdgpu_dpm_exit_umd_state(adev);
+		else if ((current_level & profile_mode_mask) &&
+			 !(level & profile_mode_mask))
+			amdgpu_dpm_enter_umd_state(adev);
+
 		return -EINVAL;
 	}
 
-- 
2.53.0

