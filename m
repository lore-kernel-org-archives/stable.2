Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046527;
	b=Jbaf5Y6+EAPA9RAVpcOOcFs6/ORwCViACr9fB5sQjrZPfKdo9rm9oR4vQAw1n6dRsxqL
	 jYU06V85GuKqhA16/cL2e0sR8QFMP/q6fACiCTcQ0Uk1k+8F7JbadPVqErGtn7mNHzMI1
	 LW6qCfbAwz1/LPueU5oi/ZegMs/221HtxBoPMj0ucTf3oak4+GqAQAZpz9gxy0pXYHw+g
	 wJqYIEnkVyNOngerXktrwzbR9GrZy4rNC1fWGE9u8aW0yL25DcID6Ndr2yn7jKrawXSPc
	 SjBZbeTxNCmUqrTBkYxZk9eMhnuczHpSWBteWdbWaVL4LOx7BEfVQPz+rHoakxmRTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=58KqZK+y6cYDGp9rvrmdUVZ9UXl/nFl8w05jMBh/8Lc=;
	b=3y0YtMCIJGFIvv72jiXb04IBd9JityxVrWvudwh7DPyLhq+Q0jcO1R6ZIoUF1yqgrFtg
	 8BzAPi4koKrN6PtMlc3OFVEx7HLF+u5E8zW8yd2bRyFP+xATMIcHf4SKgkhQn0wZWA1hk
	 WQx/8LTsz/3WmYa6JGRY1xdc+sSabsSJet/uqRC3k6OnD2/Tnk3HnnxNsJdU7qlW+I026
	 ahJaJSlacUmJOt4wo2GODii9IgCpTnZ/QP5tR8o6kq5inB1prfnXdThePXKZ8Bek8+7kY
	 RrLdXp088g/Vm2CrMUfYLaiQseGGqNziNfMugtxQB5AmPIlU+0Um4hmEF66caGdLtIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab8+MWBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28D606A338
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab8+MWBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006431F0089F;
	Sat,  7 Nov 2026 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046526;
	bh=58KqZK+y6cYDGp9rvrmdUVZ9UXl/nFl8w05jMBh/8Lc=;
	h=From:To:Cc:Subject:Date;
	b=Ab8+MWBHOc2SyMgP0uT3VwvOAmEAf0Rez+sImKuz2OgHPeZGw8qjmu0VhkyTsYcWE
	 PCItBOH9MyvBDu9/r2Wx4TChQuQOYUWS08GS6xU//moPk3WnWLdDtAeLruUsstkFOy
	 GTJEvryooK5JlRnGxLSjqDOV7xqqWMlhpCelVZmUYRZ5McMN8Fl/TP7pd5c03tYauV
	 qxEZymHizzH82gtXPj/VffBfjtKBp2wey6RbnA16Zr7EMyt6NnnEupdJujJLi6hdoC
	 a5FIO/bQBV1pnH4dT7gUdtTMT0HCfT8JTiLiTxNQqgUgAC9KO85LGxDqopMkPySbIP
	 Tg0V51783ZQHg==
From: Sasha Levin <sashal@kernel.org>
To: kevin.wang@amd.com,
	kenneth.feng@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: preserve committed OD features for SMU 14.0.2" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:24 -0500
Message-ID: <20261107051524-failed-6.18-9b0890e72d19@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9b0890e72d19b0c430fe62bad290c7c79baa78e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051524-failed-6.18-9b0890e72d19@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9b0890e72d19b0c430fe62bad290c7c79baa78e4 Mon Sep 17 00:00:00 2001
From: Kevin Wang <kevin.wang@amd.com>
Date: Thu, 15 Oct 2026 14:02:31 +0800
Subject: [PATCH] drm/amd/pm: preserve committed OD features for SMU 14.0.2

PMFW treats FeatureCtrlMask as the complete set of active OD features.
Uploads containing only newly edited bits can drop earlier settings.

Fix the OD state handling to:

- preserve committed features across later commits
- keep fan-curve and legacy-fan bits mutually exclusive
- keep staged OD settings out of power-cap writes
- update cached state only after successful uploads
- clear restored features only after they return to defaults
- restore PPT for the current AC/DC source after resume

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3625
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8d4ce79aff1cd1ff4feea4967c30e04eb6be8c2d)
Cc: stable@vger.kernel.org
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 230 +++++++++++++-----
 1 file changed, 171 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 566b7f2b00f0e..6a12d6f8c9dd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -91,6 +91,10 @@ static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
 #define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
+#define SMU_14_0_2_OD_FAN_FEATURE_MASK \
+	(BIT(PP_OD_FEATURE_FAN_CURVE_BIT) | \
+	 BIT(PP_OD_FEATURE_FAN_LEGACY_BIT))
+
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -963,6 +967,84 @@ static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
 	return feature_enabled;
 }
 
+static u32
+smu_v14_0_2_filter_od_feature_mask(struct smu_context *smu, u32 feature_mask)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	u32 supported_mask =
+		pptable->SkuTable.OverDriveLimitsBasicMax.FeatureCtrlMask;
+
+	return feature_mask & supported_mask;
+}
+
+static u32
+smu_v14_0_2_get_od_feature_mask(struct smu_context *smu, u32 pending_mask)
+{
+	u32 supported_mask = smu_v14_0_2_filter_od_feature_mask(smu, ~0U);
+	u32 fan_mask = supported_mask & SMU_14_0_2_OD_FAN_FEATURE_MASK;
+	u32 mask = smu->smu_table.user_od_feature_mask;
+
+	if (pending_mask & fan_mask)
+		mask &= ~fan_mask;
+	mask |= pending_mask;
+
+	return smu_v14_0_2_filter_od_feature_mask(smu, mask);
+}
+
+static bool smu_v14_0_2_fan_is_default(const OverDriveTable_t *od,
+				       const OverDriveTable_t *boot)
+{
+	return !memcmp(od->FanLinearPwmPoints, boot->FanLinearPwmPoints,
+			sizeof(od->FanLinearPwmPoints)) &&
+		!memcmp(od->FanLinearTempPoints, boot->FanLinearTempPoints,
+			sizeof(od->FanLinearTempPoints)) &&
+		od->AcousticTargetRpmThreshold == boot->AcousticTargetRpmThreshold &&
+		od->AcousticLimitRpmThreshold == boot->AcousticLimitRpmThreshold &&
+		od->FanTargetTemperature == boot->FanTargetTemperature &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v14_0_2_legacy_fan_is_default(const OverDriveTable_t *od,
+					      const OverDriveTable_t *boot)
+{
+	return od->FanMinimumPwm == boot->FanMinimumPwm &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v14_0_2_zero_fan_is_default(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot)
+{
+	return od->FanZeroRpmEnable == boot->FanZeroRpmEnable &&
+		od->FanZeroRpmStopTemp == boot->FanZeroRpmStopTemp;
+}
+
+static u32 smu_v14_0_2_normalize_feature_mask(const OverDriveTable_t *od,
+					      const OverDriveTable_t *boot,
+					      u32 feature_mask)
+{
+	if (od->GfxclkFoffset == boot->GfxclkFoffset)
+		feature_mask &= ~BIT(PP_OD_FEATURE_GFXCLK_BIT);
+	if (od->UclkFmin == boot->UclkFmin &&
+	    od->UclkFmax == boot->UclkFmax)
+		feature_mask &= ~BIT(PP_OD_FEATURE_UCLK_BIT);
+	if (!memcmp(od->VoltageOffsetPerZoneBoundary,
+		    boot->VoltageOffsetPerZoneBoundary,
+		    sizeof(od->VoltageOffsetPerZoneBoundary)))
+		feature_mask &= ~BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
+	if ((feature_mask & BIT(PP_OD_FEATURE_FAN_CURVE_BIT)) &&
+	    smu_v14_0_2_fan_is_default(od, boot))
+		feature_mask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+	if ((feature_mask & BIT(PP_OD_FEATURE_FAN_LEGACY_BIT)) &&
+	    smu_v14_0_2_legacy_fan_is_default(od, boot))
+		feature_mask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+	if (smu_v14_0_2_zero_fan_is_default(od, boot))
+		feature_mask &= ~BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	if (!od->Ppt)
+		feature_mask &= ~BIT(PP_OD_FEATURE_PPT_BIT);
+
+	return feature_mask;
+}
+
 static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min,
@@ -2317,6 +2399,38 @@ static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
 	return ret;
 }
 
+static int
+smu_v14_0_2_upload_ppt_overdrive_table(struct smu_context *smu, s16 ppt)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask = table_context->user_od_feature_mask;
+	int ret;
+
+	/* Do not commit OD settings staged after the last c operation. */
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.Ppt = ppt;
+	if (ppt)
+		next_mask |= BIT(PP_OD_FEATURE_PPT_BIT);
+	else
+		next_mask &= ~BIT(PP_OD_FEATURE_PPT_BIT);
+	upload_table.OverDriveTable.FeatureCtrlMask =
+		smu_v14_0_2_filter_od_feature_mask(smu, next_mask);
+
+	ret = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
+	if (ret)
+		return ret;
+
+	table_context->user_od_feature_mask =
+		upload_table.OverDriveTable.FeatureCtrlMask;
+	od_table->OverDriveTable.Ppt = ppt;
+	user_od_table->OverDriveTable.Ppt = ppt;
+
+	return 0;
+}
+
 static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2375,6 +2489,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 	memcpy(od_table,
 	       boot_od_table,
 	       sizeof(OverDriveTableExternal_t));
+	od_table->OverDriveTable.FeatureCtrlMask = 0;
 
 	/*
 	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
@@ -2384,6 +2499,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 		memcpy(user_od_table,
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 		smu->user_dpm_profile.user_od = false;
 		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
@@ -2420,6 +2536,14 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
 			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
+		user_od_table->OverDriveTable.FanMode =
+			user_od_table_bak.OverDriveTable.FanMode;
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
+	if (smu->adev->in_suspend) {
+		user_od_table->OverDriveTable.Ppt = 0;
+		smu->smu_table.user_od_feature_mask &=
+			~BIT(PP_OD_FEATURE_PPT_BIT);
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2432,14 +2556,22 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask =
-		table_context->user_od_feature_mask;
-	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
-	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
-	if (res == 0)
+	next_mask = smu_v14_0_2_filter_od_feature_mask(smu,
+						       table_context->user_od_feature_mask);
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+	res = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
+	if (res == 0) {
+		table_context->user_od_feature_mask = next_mask;
+		smu->user_dpm_profile.user_od =
+			!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+		od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
 
 	return res;
 }
@@ -2463,43 +2595,30 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		od_table->OverDriveTable.FanZeroRpmStopTemp =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		od_table->OverDriveTable.AcousticTargetRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticTargetRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		od_table->OverDriveTable.FanTargetTemperature =
 					boot_overdrive_table->OverDriveTable.FanTargetTemperature;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2517,9 +2636,17 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)table_context->user_overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)table_context->boot_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	OverDriveTable_t *od = &od_table->OverDriveTable;
+	OverDriveTable_t *boot = &boot_od_table->OverDriveTable;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
+	u32 next_mask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -2691,6 +2818,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.AcousticLimitRpmThreshold = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
@@ -2713,6 +2841,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.AcousticTargetRpmThreshold = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
@@ -2735,6 +2864,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FanTargetTemperature = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
@@ -2812,44 +2942,38 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
-			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
-		/*
-		 * PMFW interprets FeatureCtrlMask as the complete set of OD
-		 * features that are currently overridden, not as a delta
-		 * describing this single operation. Any feature whose bit is
-		 * clear gets reset to its default on import. od_table's mask
-		 * has accumulated every feature the user touched since the
-		 * last full restore, so record it and keep restating it on
-		 * subsequent uploads.
-		 */
-		table_context->user_od_feature_mask =
-			od_table->OverDriveTable.FeatureCtrlMask;
-
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
-		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
-			   table_context->user_overdrive_table + offset_of_voltageoffset,
-			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
-			smu_v14_0_2_dump_od_table(smu, od_table);
+		next_mask = smu_v14_0_2_get_od_feature_mask(smu,
+							    od->FeatureCtrlMask);
+		next_mask = smu_v14_0_2_normalize_feature_mask(od, boot,
+							       next_mask);
 
-			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   (u8 *)user_od_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset) ||
+		    next_mask != table_context->user_od_feature_mask) {
+			memcpy(&upload_table, od_table, sizeof(upload_table));
+			upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+			smu_v14_0_2_dump_od_table(smu, &upload_table);
+
+			ret = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
 			if (ret) {
 				dev_err(adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
-			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			table_context->user_od_feature_mask = next_mask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			memcpy((u8 *)user_od_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
+			user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 
-			if (!memcmp(table_context->user_overdrive_table,
-				    table_context->boot_overdrive_table,
-				    sizeof(OverDriveTableExternal_t)))
-				smu->user_dpm_profile.user_od = false;
-			else
-				smu->user_dpm_profile.user_od = true;
+			smu->user_dpm_profile.user_od =
+				!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		}
 		break;
 
@@ -2867,10 +2991,8 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power
 		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-	struct smu_table_context *table_context = &smu->smu_table;
-	OverDriveTableExternal_t *od_table =
-		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	OverDriveTableExternal_t current_od_table;
+	s16 ppt;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
@@ -2882,13 +3004,7 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		if (current_od_table.OverDriveTable.Ppt) {
-			od_table->OverDriveTable.Ppt = 0;
-			table_context->user_od_feature_mask &=
-				~(1U << PP_OD_FEATURE_PPT_BIT);
-			od_table->OverDriveTable.FeatureCtrlMask =
-				table_context->user_od_feature_mask;
-
-			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+			ret = smu_v14_0_2_upload_ppt_overdrive_table(smu, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
@@ -2900,12 +3016,8 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
-		od_table->OverDriveTable.FeatureCtrlMask =
-			table_context->user_od_feature_mask;
-
-		ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+		ppt = (limit * 100) / msg_limit - 100;
+		ret = smu_v14_0_2_upload_ppt_overdrive_table(smu, ppt);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 		  return ret;
-- 
2.53.0




