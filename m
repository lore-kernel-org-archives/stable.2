Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048966;
	b=ZZIt993Wg4moJEoD/WQAXQMjjzjyAeTLYPkLm/ZIlGIZ3zKVqdm4pQYIv//17lwO7+WC
	 quCYSLs+D4yEkVsFom1j0KG5ypi8x34wmLCZY3/TbtwYoJ1FEEWKSVojyIw6XWO2KYLqS
	 cm8GKOv/HglvAmf7W3XdpEGEQ1ZvVXQv0h4n+Q8NhUHa+E3KT+4QdLrzB7sgX04911pLD
	 v8oRdmNiKL229I9pd+XbcX+/55im0yaLgi3pSSM5UYGPqHGvn2pZr6odO5D+/JJGlfEWx
	 1Ofr5Sy3bpBidLiVt9Vo/gSC6UuATNRcshaEHvsbpTZyoKBIjFOlOzNLorbXeXzIVKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rjWF33CvjbkiO3fdi5szjuCkaQFyzipKzpO6KSjK42Q=;
	b=fHxe2ldHTOoK8fZ499mCUdcGWEOwocq8preJ94/c8Nv58864ySQT5BWU27jJLIIv9CzF
	 ZzMMt5AlMteyN9sB0cywl7gZza/lCVw4J8fzVWZAKMVzbNsnMyuwfIL7aCyEtejWuE+Jo
	 yG3+u/+8KFuOCWtY1CU47gc/h+eeVzS8VR0B/5JFOw68rqXS6i73Y1kIBrYpaC8Yz0BBZ
	 Q0jNtPbR0d7zWwncG0lDuqdaM9boW0QrU/IEwAKTZgpxp4UH73iSpqKVC8XAAvlbo0BYW
	 RTPvR8jgeD+VH8mdtHJL+ZWabeW1eR95W+TduRvYAOWmebfo8iB/vZ+4uhA/zbYtSCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+uRXtfn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+uRXtfn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D281F0089F;
	Sat,  7 Nov 2026 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048966;
	bh=rjWF33CvjbkiO3fdi5szjuCkaQFyzipKzpO6KSjK42Q=;
	h=From:To:Cc:Subject:Date;
	b=K+uRXtfnHR1XJQqEaY1uDm/2Am0aNuFR2HqOwG0qjGndzr5nRuK6aoVgD2AOfQwNk
	 aaEjwMv6OmJ8RsZIG5CoycW6Fu9hvd3uu8vc2pUD1a47O705b4wvnwunPn+59tRmT9
	 U94cB5D8IdHp/dzwkZdWDWQYuez57EiZ0uxY9G1tSsI7izOcSQuejS46i91u38JODX
	 hwiS8o/D1VJQfgB9kLRYmubvVuWX4ig3cvzNIxhsq9YeH86rzpozFt42Ou/YLGyXqA
	 8kKqnxx5x0sUfalsn8Wxl+DKBxsUZfkpbepFM7NyW8VUS/6WnZgrRjsuJhu371pK25
	 nYRSqMHezZtyw==
From: Sasha Levin <sashal@kernel.org>
To: kenneth.feng@amd.com,
	kevin.wang@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: add zero fan stop temperature support on smu 14.0.2" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:04 -0500
Message-ID: <20261107055604-failed-6.1-af52c8fd45fb@kernel.org>
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
git cherry-pick -x af52c8fd45fbd5e3b7a329858733ac674abe539c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055604-failed-6.1-af52c8fd45fb@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From af52c8fd45fbd5e3b7a329858733ac674abe539c Mon Sep 17 00:00:00 2001
From: Kenneth Feng <kenneth.feng@amd.com>
Date: Thu, 8 Oct 2026 20:28:09 +0800
Subject: [PATCH] drm/amd/pm: add zero fan stop temperature support on smu
 14.0.2

add zero fan stop temperature support on smu 14.0.2

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5905
Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Kevin Wang <kevin.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f990c94a2633d0ead477eb1b174e254a6d292e66)
Cc: stable@vger.kernel.org
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 549716349117d..566b7f2b00f0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -89,6 +89,7 @@ static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
+#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1020,6 +1021,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
 		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
+		od_min_setting = pptable->SkuTable.MsgLimits.FanStopTempMin;
+		od_max_setting = pptable->SkuTable.MsgLimits.FanStopTempMax;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1244,6 +1249,24 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2311,7 +2334,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
 					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2393,6 +2418,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 		user_od_table->OverDriveTable.FanZeroRpmEnable =
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
+		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
+			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2444,6 +2471,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		od_table->OverDriveTable.FanZeroRpmStopTemp =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
@@ -2749,6 +2781,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmStopTemp = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
-- 
2.53.0




