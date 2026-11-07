Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048742;
	b=2BF7xT4zmsDvQwAxYF7OuVYQXVIbjmS0jfTazQzOiRZ1xC9ZErDfUCrU5Cl9MJm8gsEZ
	 Fih96dQ/zTxGtuBKnUyxoDkO+hvaXiDNmiP/K5L8+PAtcplOD59/lXiSKgDBEXP+57Chz
	 mtljix/NEADteksZiBIVNixqbH7PCDfLf+gHxqqY12laOGt3Ml2rP415RQpZUf29YEKXG
	 mGCVPxwkYxpYVaI3AFOQri0pmyl1rFi8mQwYsWlZLvn2nk+r55G8H/CkqBWYUQIEfuKPX
	 HcflYYul7Itt5WnWVSrgYZGh//K7zcuSJ1HN+kcNMd9g+WDVfmAMDijj/kxTlBRjr8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0iJu9bTou07ITNflO2SAz1mmhPgAQu2sqz23PXkFmM0=;
	b=ZxtoerogbnsqIL86RUG4IuPzyG7gJSd7R55gnbQ6tBe9C9t092+AnqC/UnapiCYVP3qo
	 G43LHHf7BkGT0YrZ3uqllMz9q68tf8paXdbd5EhaGKAcPaPk4wedDwaSsxVXWPQDM+wpA
	 MdW1oh0kVbRxP3ho1S2lxJoE1l9v6R8GjECFo+BHNVWzSxbYbodfBvJgsGsfcqatsl12M
	 MkEoFlwp4vzkW26DeVvM263QUAjc+Gpz/yvxCIoCgvcw5/68e6yGOJt0i8OSF1Jyx2CId
	 BelHbyWEPS91NuScmBDpRRiTeDqLjoHUCsnXKoOT3dZMnNKixLSDSRJDkY5/3Z7vc9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSqTHhrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF274606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSqTHhrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536241F0089F;
	Sat,  7 Nov 2026 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048741;
	bh=0iJu9bTou07ITNflO2SAz1mmhPgAQu2sqz23PXkFmM0=;
	h=From:To:Cc:Subject:Date;
	b=BSqTHhrBpgA9l4iWfkR5D6GPDK0fR+paeuAcZdVYql1wA2lt3MOOsdSvbEoHDKaEr
	 1w0HOMhFVPRmOjyPVQezbnoUJywE6WUNBh5y40+sR9OmXeu/dsIzN+4kNVlcmwofIK
	 bo5KohA9j0linEDjtGL82/NEHS183/arr+nLd1bNS80t99olIN0VmUXbN45guq/XTS
	 FVAiFtqRK95GcXMiIrheTpoFmTMzvg8TSBAgdf2EdY+gCLfW4Gcrql7mrsoexW9ZWl
	 yWvdg8WBjuZ0RB0SZlutXNiblW3fBgMzJ/2U9zSPoVRDHlllUREon5pn9C4DZ6rkRT
	 01azTkqnWOmmw==
From: Sasha Levin <sashal@kernel.org>
To: kevin.wang@amd.com,
	kenneth.feng@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: reapply umd profile state after recovery" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:20 -0500
Message-ID: <20261107055219-failed-6.1-ad6eb088a508@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ad6eb088a508d927641c8a76d1ca7911dfb7c80b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055219-failed-6.1-ad6eb088a508@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ad6eb088a508d927641c8a76d1ca7911dfb7c80b Mon Sep 17 00:00:00 2001
From: Kevin Wang <kevin.wang@amd.com>
Date: Thu, 15 Oct 2026 15:38:26 +0800
Subject: [PATCH] drm/amd/pm: reapply umd profile state after recovery

Resume and full GPU reset retain the selected UMD profile level in
driver state.
The GFX and PMFW state behind it is reinitialized.

Add a generic DPM reapply path after CG and PG restoration.
It restores the UMD GFX state and asks the PM backend to replay the
retained level.

v2:
- Reapply only GFX CG to preserve the profile-owned GFX PG reference.
- Fall back to AUTO when reapply fails without failing device recovery.
- Propagate PowerPlay DPM errors before accepting AUTO fallback.
- Limit workload-profile error reporting to the swSMU reapply path.

This covers:
- PCI runtime resume
- Full GPU reset recovery
- System resume, including S3 and s2idle

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fd0699fc9f4266fc07d6ce6dbb484fac04601106)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 85 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 33 +++++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 87 +++++++++++++++++--
 7 files changed, 201 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 866e83de950d2..f147c0c459da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2781,6 +2781,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
+	r = amdgpu_dpm_reapply_umd_profile(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to restore UMD profile state: %d\n", r);
+		return r;
+	}
+
 	amdgpu_device_fill_reset_magic(adev);
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ab6f9131ac11f..3e5634de077f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2974,19 +2974,6 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static void amdgpu_restore_umd_profile_pstate_after_runpm(struct amdgpu_device *adev)
-{
-	enum amd_dpm_forced_level level;
-	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-		AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
-
-	level = amdgpu_dpm_get_performance_level(adev);
-	if (level & profile_mode_mask)
-		amdgpu_asic_update_umd_stable_pstate(adev, true);
-}
-
 static int amdgpu_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -3032,7 +3019,6 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 
-	amdgpu_restore_umd_profile_pstate_after_runpm(adev);
 	adev->in_runpm = false;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ca818965afe1f..7db44fa24042e 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -449,6 +449,8 @@ struct amd_pm_funcs {
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
 	int (*emit_clock_levels)(void *handle, enum pp_clock_type type, char *buf, int *offset);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
+	int (*reapply_performance_level)(void *handle,
+					 enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
 	int (*get_mclk_od)(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0394085a03281..75d8bb4868e89 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1082,6 +1082,91 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
 					       AMD_PG_STATE_GATE);
 }
 
+/**
+ * amdgpu_dpm_reapply_umd_profile - Restore the active UMD profile
+ * @adev: amdgpu device
+ *
+ * Resume and reset retain the selected DPM level in software, but the
+ * underlying GFX and PMFW state is lost. Reapply a retained UMD profile
+ * after the common resume path has restored its default CG and PG state.
+ */
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level level;
+	int ret, fallback_ret;
+
+	if (!pp_funcs || !pp_funcs->reapply_performance_level ||
+	    !pp_funcs->force_performance_level)
+		return 0;
+
+	/* Serialize the retained level with the GFX and PMFW reprogramming. */
+	mutex_lock(&adev->pm.mutex);
+	if (adev->pm.dpm.thermal_active) {
+		dev_warn(adev->dev,
+			 "Cannot restore UMD profile while thermal control is active\n");
+		ret = 0;
+		goto unlock;
+	}
+
+	if (pp_funcs->get_performance_level)
+		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
+	else
+		level = adev->pm.dpm.forced_level;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		break;
+	default:
+		ret = 0;
+		goto unlock;
+	}
+
+	/* The active profile already owns the GFX PG reference. */
+	ret = amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					      AMD_CG_STATE_UNGATE);
+	if (ret)
+		goto fallback_auto;
+
+	ret = amdgpu_asic_update_umd_stable_pstate(adev, true);
+	if (ret)
+		goto fallback_auto;
+
+	ret = pp_funcs->reapply_performance_level(adev->powerplay.pp_handle,
+						     level);
+	if (ret)
+		goto fallback_auto;
+
+unlock:
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+
+fallback_auto:
+	dev_warn(adev->dev, "Failed to restore UMD profile state: %d\n", ret);
+
+	/* Restore normal CG before releasing the profile's PG reference. */
+	amdgpu_asic_update_umd_stable_pstate(adev, false);
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_GATE);
+	mutex_unlock(&adev->pm.mutex);
+
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+	fallback_ret = amdgpu_dpm_force_performance_level(adev,
+						   AMD_DPM_FORCED_LEVEL_AUTO);
+	if (fallback_ret)
+		dev_warn(adev->dev, "Failed to fall back to AUTO performance level: %d\n",
+			 fallback_ret);
+	else
+		adev->pm.stable_pstate_ctx = NULL;
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+	return 0;
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 72b13ece22ef4..ba8624d28f28b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -484,6 +484,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level);
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev);
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 				 struct pp_states_info *states);
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 239c64b8edca8..7b0ff5a0993e1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -358,24 +358,46 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 	}
 }
 
-static int pp_dpm_force_performance_level(void *handle,
-					enum amd_dpm_forced_level level)
+static int pp_dpm_apply_performance_level(struct pp_hwmgr *hwmgr,
+					  enum amd_dpm_forced_level level,
+					  bool reapply)
 {
-	struct pp_hwmgr *hwmgr = handle;
+	int ret;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	if (level == hwmgr->dpm_level)
+	if (!reapply && level == hwmgr->dpm_level)
 		return 0;
 
 	pp_dpm_en_umd_pstate(hwmgr, &level);
 	hwmgr->request_dpm_level = level;
-	hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+	ret = hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+	if (ret)
+		return ret;
+
+	ret = phm_force_dpm_levels(hwmgr, level);
+	if (ret)
+		return ret;
+
+	hwmgr->dpm_level = level;
 
 	return 0;
 }
 
+static int pp_dpm_force_performance_level(void *handle,
+					enum amd_dpm_forced_level level)
+{
+	return pp_dpm_apply_performance_level(handle, level, false);
+}
+
+static int
+pp_dpm_reapply_performance_level(void *handle,
+					 enum amd_dpm_forced_level level)
+{
+	return pp_dpm_apply_performance_level(handle, level, true);
+}
+
 static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 								void *handle)
 {
@@ -1536,6 +1558,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
 	.force_performance_level = pp_dpm_force_performance_level,
+	.reapply_performance_level = pp_dpm_reapply_performance_level,
 	.get_performance_level = pp_dpm_get_performance_level,
 	.get_current_power_state = pp_dpm_get_current_power_state,
 	.dispatch_tasks = pp_dpm_dispatch_tasks,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3bb36668eb399..c9fe323fa6244 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2366,6 +2366,13 @@ static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static void smu_enter_umd_pstate(struct smu_context *smu)
+{
+	smu_gpo_control(smu, false);
+	smu_gfx_ulv_control(smu, false);
+	smu_deep_sleep_control(smu, false);
+}
+
 static int smu_enable_umd_pstate(void *handle,
 		      enum amd_dpm_forced_level *level)
 {
@@ -2384,9 +2391,7 @@ static int smu_enable_umd_pstate(void *handle,
 		/* enter umd pstate, save current level, disable gfx cg*/
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
-			smu_gpo_control(smu, false);
-			smu_gfx_ulv_control(smu, false);
-			smu_deep_sleep_control(smu, false);
+			smu_enter_umd_pstate(smu);
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
 		}
 	} else {
@@ -2445,7 +2450,8 @@ static void smu_power_profile_mode_put(struct smu_context *smu,
 
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings)
+					  bool skip_display_settings,
+					  bool force_performance_level)
 {
 	int ret = 0;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -2472,7 +2478,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		}
 	}
 
-	if (smu_dpm_ctx->dpm_level != level) {
+	if (force_performance_level || smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			if (ret == -EOPNOTSUPP)
@@ -2495,6 +2501,39 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	return ret;
 }
 
+static int
+smu_reapply_power_state_dynamic(struct smu_context *smu,
+				enum amd_dpm_forced_level level)
+{
+	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
+	int ret;
+
+	ret = smu_apply_clocks_adjust_rules(smu);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to apply clocks adjust rules!");
+		return ret;
+	}
+
+	ret = smu_asic_set_performance_level(smu, level);
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			dev_info(smu->adev->dev, "set performance level %d not supported",
+				 level);
+		else
+			dev_err(smu->adev->dev, "Failed to set performance level %d",
+				level);
+		return ret;
+	}
+
+	smu_dpm_ctx->dpm_level = level;
+
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL ||
+	    smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		return 0;
+
+	return smu_bump_power_profile_mode(smu, NULL, 0);
+}
+
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id)
@@ -2509,13 +2548,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
 		break;
 	default:
 		break;
@@ -2644,6 +2683,37 @@ static int smu_force_performance_level(void *handle,
 	return ret;
 }
 
+static int
+smu_reapply_performance_level(void *handle,
+			      enum amd_dpm_forced_level level)
+{
+	struct smu_context *smu = handle;
+	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
+		return -EINVAL;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (smu_dpm_ctx->dpm_level != level)
+		return -EINVAL;
+
+	smu_enter_umd_pstate(smu);
+
+	return smu_reapply_power_state_dynamic(smu, level);
+}
+
 static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
@@ -4030,6 +4100,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.force_clock_level       = smu_force_ppclk_levels,
 	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
+	.reapply_performance_level = smu_reapply_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_apu_thermal_limit       = smu_get_apu_thermal_limit,
 	.set_apu_thermal_limit       = smu_set_apu_thermal_limit,
-- 
2.53.0




