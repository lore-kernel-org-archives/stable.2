Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D13470EBE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931342; cv=none; b=SVkituZs6hp735+d0H6U0p5qK1hxD+YdsWldyfw1m545WOPCJsYRF9lgD4sPvcrK/PsXkSsi+zAuweozXTUiz0lLEX6JYhMuhjIJFpc4TAhvm7Mw/K9+jLBDuatEfCPmESlMAO0uWYEO/ecTnX3lxnGGr2KW570dtyruK0epxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931342; c=relaxed/simple;
	bh=dB1S/sZKj+i+dwGMdMxbVLem8TQLykj9JJRxhrl8s0U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X+NbNk/gc5OqBYwAifGoaA1hXTE08k4e10L93e+72hzzHdbtgqBnRNL8IiMgLXp7K9KG4YTC0zFZ9RURtqO6Wdw2TZQt6uSGlG1J3NJbC6O0VLW+18yXH5kZg8yMp3rYA6okM11+QvbXpMA1xNRTarnXGo/8xQVT0AnpigICpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s43yzGbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s43yzGbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C11F333F4;
	Wed,  5 Aug 2026 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931309;
	bh=0lURTJUzkJcEosD/rpk5TTJSFQtzpcjoqbXSfhiHqzE=;
	h=Subject:To:Cc:From:Date;
	b=s43yzGbZxX3dQsqVQI2Ca2UDntZlBIxl86PwUFib8UWyVLtDmBs5yYBzdMaWK9YSv
	 /PxSwuIjmOXWfotPueW7jIgc6mHd9WcJdv5iaIGPcFiSmKZ8Ux4YKQjNYa1fqSEiMV
	 2drwwOkc0ExcuNMdjNwzG3H9EenQcaA6xX9JTDc0=
Subject: FAILED: patch "[PATCH] drm/amd/pm: use milliwatts for GPU power sensors" failed to apply to 6.6-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,kenneth.feng@amd.com,l.nieradzik@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:00:11 +0200
Message-ID: <2026080511-repent-suds-4dd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1849a64165ccc23d3e5fc22b8be19227c21c1871
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080511-repent-suds-4dd0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1849a64165ccc23d3e5fc22b8be19227c21c1871 Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Mon, 27 Jul 2026 12:23:17 +0800
Subject: [PATCH] drm/amd/pm: use milliwatts for GPU power sensors

GPU average and input power backends report a mix of whole watts,
milliwatts, Q24.8 watts and decimal-packed fractions. Q24.8 is inherited
from the legacy PowerPlay sensor format. Milliwatts are a more natural unit
for the hwmon and pm_info consumers in amdgpu_pm.c. A common decoder cannot
distinguish these formats, and converting native milliwatts through Q24.8
also loses precision.

Use milliwatts as the internal unit across all PPT and PowerPlay backends.
Decode Q24.8 only at the legacy smu7 input boundary and encode it only for
the raw amdgpu_sensors debugfs interface. This gives hwmon, pm_info and the
sensor ioctl one unambiguous unit while preserving the format used by UMR.

Fixes: 5b79d0482f3c ("drm/amd/pp: Remove struct pp_gpu_power")
Fixes: 01992b121fb6 ("drm/amd/pm: fix amdgpu_pm_info power display units")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reported-by: Lars Nieradzik <l.nieradzik@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 757ba0790bafec47a507e9662bf380f2e027d420)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 662ec01961f4..df2588642817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -43,6 +43,11 @@
 
 #if defined(CONFIG_DEBUG_FS)
 
+/* Encode milliwatts in the raw Q24.8 sensor report format used by UMR. */
+#define AMDGPU_DEBUGFS_PWR_MW_TO_Q24_8(power_mw) \
+	DIV_ROUND_CLOSEST_ULL((u64)(power_mw) * BIT(8), \
+			      MILLIWATT_PER_WATT)
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1104,6 +1109,10 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 		return r;
 	}
 
+	if (idx == AMDGPU_PP_SENSOR_GPU_AVG_POWER ||
+	    idx == AMDGPU_PP_SENSOR_GPU_INPUT_POWER)
+		values[0] = AMDGPU_DEBUGFS_PWR_MW_TO_Q24_8(values[0]);
+
 	if (size > valuesize) {
 		amdgpu_virt_disable_access_debugfs(adev);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 71272f40feef..8bb9c198ddec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1210,7 +1210,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					return -EINVAL;
 				}
 			}
-			ui32 >>= 8;
+			ui32 /= MILLIWATT_PER_WATT;
 			break;
 		case AMDGPU_INFO_SENSOR_GPU_INPUT_POWER:
 			/* get input GPU power */
@@ -1219,7 +1219,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 						   (void *)&ui32, &ui32_size)) {
 				return -EINVAL;
 			}
-			ui32 >>= 8;
+			ui32 /= MILLIWATT_PER_WATT;
 			break;
 		case AMDGPU_INFO_SENSOR_VDDNB:
 			/* get VDDNB in millivolts */
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 6371f292f2d8..606d48115301 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -24,6 +24,8 @@
 #ifndef __KGD_PP_INTERFACE_H__
 #define __KGD_PP_INTERFACE_H__
 
+#include <linux/units.h>
+
 extern const struct amdgpu_ip_block_version pp_smu_ip_block;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
@@ -150,8 +152,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MEM_TEMP,
 	AMDGPU_PP_SENSOR_VCE_POWER,
 	AMDGPU_PP_SENSOR_UVD_POWER,
-	AMDGPU_PP_SENSOR_GPU_AVG_POWER,
-	AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+	AMDGPU_PP_SENSOR_GPU_AVG_POWER, /* milliwatts */
+	AMDGPU_PP_SENSOR_GPU_INPUT_POWER, /* milliwatts */
 	AMDGPU_PP_SENSOR_SS_APU_SHARE,
 	AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
 	AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 763947fbf16f..85b089a3dc41 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -41,8 +41,6 @@
 
 #define DEVICE_ATTR_IS(_name)		(attr_id == device_attr_id__##_name)
 
-#define power_2_mwatt(power)	(((power) >> 8) * 1000 + ((power) & 0xff))
-
 struct od_attribute {
 	struct kobj_attribute	attribute;
 	struct list_head	entry;
@@ -3351,7 +3349,7 @@ static int amdgpu_hwmon_get_power(struct device *dev,
 		return r;
 
 	/* convert to microwatts */
-	return power_2_mwatt(query) * 1000;
+	return query * 1000;
 }
 
 static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
@@ -4919,7 +4917,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
-		mwatt = power_2_mwatt(query);
+		mwatt = query;
 		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
 		if (adev->flags & AMD_IS_APU)
 			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
@@ -4928,7 +4926,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	}
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
-		mwatt = power_2_mwatt(query);
+		mwatt = query;
 		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
 		if (adev->flags & AMD_IS_APU)
 			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index bc82ba2e4c9b..f8a5648095d1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4062,7 +4062,7 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 	    (adev->asic_type != CHIP_FIJI) &&
 	    (adev->asic_type != CHIP_TONGA)) {
 		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurrPkgPwr, 0, &tmp);
-		*query = tmp;
+		*query = PP_PWR_Q24_8_TO_MW(tmp);
 
 		if (tmp != 0)
 			return 0;
@@ -4081,7 +4081,7 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 		if (tmp != 0)
 			break;
 	}
-	*query = tmp;
+	*query = PP_PWR_Q24_8_TO_MW(tmp);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 4b92b52aba2b..c283309efe87 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3934,8 +3934,8 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
 	if (ret)
 		return ret;
 
-	/* SMC returning actual watts, keep consistent with legacy asics, low 8 bit as 8 fractional bits */
-	*query = value << 8;
+	/* SMC returns whole Watts, while power sensors use milliwatts. */
+	*query = value * MILLIWATT_PER_WATT;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 69a9074058ce..b466b08e4a67 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1419,7 +1419,7 @@ static int vega12_get_gpu_power(struct pp_hwmgr *hwmgr, uint32_t *query)
 	if (ret)
 		return ret;
 
-	*query = metrics_table.CurrSocketPower << 8;
+	*query = metrics_table.CurrSocketPower * MILLIWATT_PER_WATT;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 7b8f4c1b80eb..e9c194056e32 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2154,12 +2154,13 @@ static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr, int idx,
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		if (hwmgr->smu_version == 0x282e00)
-			*query = metrics_table.AverageSocketPower << 8;
+			*query = metrics_table.AverageSocketPower *
+				 MILLIWATT_PER_WATT;
 		else
 			ret = -EOPNOTSUPP;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-		*query = metrics_table.CurrSocketPower << 8;
+		*query = metrics_table.CurrSocketPower * MILLIWATT_PER_WATT;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index ca71efaa1656..368200f7cf16 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -35,6 +35,11 @@ struct pp_hwmgr;
 struct phm_fan_speed_info;
 struct pp_atomctrl_voltage_table;
 
+/* Decode legacy unsigned Q24.8 watts to internal milliwatts. */
+#define PP_PWR_Q24_8_TO_MW(power) \
+	DIV_ROUND_CLOSEST_ULL((u64)(power) * MILLIWATT_PER_WATT, \
+			      BIT(8))
+
 #define VOLTAGE_SCALE 4
 #define VOLTAGE_VID_OFFSET_SCALE1   625
 #define VOLTAGE_VID_OFFSET_SCALE2   100
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 54d3dba7d354..cfad8cd74773 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -658,7 +658,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->VcnActivityPercentage;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index e6e009df9840..bb9620666dae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -158,12 +158,10 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->Current.MemclkFrequency;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->Current.CurrentSocketPower << 8) /
-				1000;
+		*value = metrics->Current.CurrentSocketPower;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->Average.CurrentSocketPower << 8) /
-				1000;
+		*value = metrics->Average.CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->Current.GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cd0457e13f54..6dfc3b585c6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -602,7 +602,7 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
@@ -691,7 +691,7 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
@@ -777,7 +777,7 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
@@ -866,7 +866,7 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f799e489b481..dccca6ddd5ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -855,9 +855,10 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 			metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = use_metrics_v3 ? metrics_v3->AverageSocketPower << 8 :
-			use_metrics_v2 ? metrics_v2->AverageSocketPower << 8 :
-			metrics->AverageSocketPower << 8;
+		*value = use_metrics_v3 ? metrics_v3->AverageSocketPower :
+			use_metrics_v2 ? metrics_v2->AverageSocketPower :
+			metrics->AverageSocketPower;
+		*value *= MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = (use_metrics_v3 ? metrics_v3->TemperatureEdge :
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index c54675b00a96..3e3c68448ba9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -318,8 +318,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) /
-		1000 ;
+		*value = metrics->CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
@@ -387,12 +386,10 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->Current.UvdActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->Average.CurrentSocketPower << 8) /
-		1000;
+		*value = metrics->Average.CurrentSocketPower;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->Current.CurrentSocketPower << 8) /
-		1000;
+		*value = metrics->Current.CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->Current.GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 75335da224c7..175c44190caa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1215,9 +1215,10 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		    ((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		      IP_VERSION(12, 0, 0)) &&
 		     (adev->pm.fw_version >= 0x373200)))
-			*value = metrics->CurrentSocketPower << 8;
+			*value = metrics->CurrentSocketPower *
+				 MILLIWATT_PER_WATT;
 		else
-			*value = (metrics->CurrentSocketPower << 8) / 1000;
+			*value = metrics->CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = (metrics->GfxTemperature / 100) *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9d8b1227388f..18c0b43b93b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -677,7 +677,8 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_SOCKETPOWER:
 		/* Valid power data is available only from primary die */
 		if (aldebaran_is_primary(smu))
-			*value = metrics->AverageSocketPower << 8;
+			*value = metrics->AverageSocketPower *
+				 MILLIWATT_PER_WATT;
 		else
 			ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index acbd7046d8a5..0be34fbdac26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -807,7 +807,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 			     metrics->Vcn1ActivityPercentage);
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->AvgTemperature[TEMP_EDGE] *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index fe929bd89058..8d476a60d62f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -434,7 +434,8 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		*value = SMUQ10_ROUND(metrics->SocketPower) *
+			 MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index ba91bf590eed..a9d558f5b739 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -338,10 +338,10 @@ static int smu_v13_0_4_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->AverageSocketPower << 8) / 1000;
+		*value = metrics->AverageSocketPower;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		*value = metrics->CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 27372a60e83d..f95b15af436d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -295,7 +295,7 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		*value = metrics->CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b12388134489..41608574bc61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1321,7 +1321,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, version));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version)) << 8;
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version)) *
+			 MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version)) *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 42c9ceeb4f7d..5d11ed8be4c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -817,7 +817,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->AvgTemperature[TEMP_EDGE] *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 7bf88ffd311b..edc3fedca9f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -372,7 +372,7 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		*value = metrics->CurrentSocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 3d73f2050bbe..568665265a13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -312,8 +312,7 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->SocketPower / 1000 << 8) +
-		(metrics->SocketPower % 1000 / 10);
+		*value = metrics->SocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index a6a88e7b2668..bd054cbfbae0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -695,7 +695,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
 			     metrics->Vcn1ActivityPercentage);
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = metrics->AverageSocketPower * MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->AvgTemperature[TEMP_EDGE] *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index faa7d661f3bf..0da1ffb3a567 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -378,8 +378,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->SocketPower / 1000 << 8) +
-		(metrics->SocketPower % 1000 / 10);
+		*value = metrics->SocketPower;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 2105a1d7bb34..118eda5429ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -411,7 +411,8 @@ static int smu_v15_0_8_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		*value = SMUQ10_ROUND(metrics->SocketPower) *
+			 MILLIWATT_PER_WATT;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *

