Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12644E055
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549473; cv=none; b=RULSjMNAJUZeHm08qlgMeWCadhUsJE74fokYwjl5p4DriFwWR3aKgo39WRXFIXlgNnsgUauRTuKZTYGXZJI+4msnv8aC0bwaAj5Nm3/s4L9mNZaBe4HyUQNuhG48mEfFw7y5Lxfqg/ertOXZV59mt4m7Csfhn6yKrDl6e43f/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549473; c=relaxed/simple;
	bh=1K1JP9G1/3f7ufxAMtI7OBfhwoNAwBsrvUnRXPID2HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPhOjTyzVQATwySB01/aUQMvDQM+aXCgkvFbKvlKuOZcKlwY4ml/ISa2nnxBC2uSBLkwANej8bC2IRexNp0aHmEa24GsJdnfhvcAu6USL/bcLSDWaCXI+W+XwGFDRYnV54amBYSx03JKvo4Iv8WhdF+CoEwFJkamghkfsElhxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHT1GJFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHT1GJFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AF71F00A3F;
	Wed, 12 Aug 2026 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549471;
	bh=Z48JrirgzFuWxfXWrAXBWwXWWMqgrkL3xvlRigEQKm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHT1GJFA6PVuxi/PTl5Z5s4ks5r2wJ7SUGt/bGItE2agCZB+38exl0xYwZ6wLzkqh
	 aNx6/czw7geN/A18fXDvdCBOHzDMTQFPkY5s8WtMtu49O6hIOuN6AymrZLNAKg7Cfi
	 0rxMM2OfmpgesQx985FYZiS5LOQrZNnoZ1EoMtHecCkpas9ubmne3ap7LwqCNqxZhX
	 FQmcjOEl6grzDRkuTYx//Q0lLcZ4y0LEtRasmAjH7PiMlhPNga1xPSeWGMT/wfYtji
	 jURRoEuvg9ZtghlzGvzDnl69G3g1wg2pvQOQd9/k/nPAyHiq4gJeRPQEcqGyjmHbPX
	 xF5l6DY7Toxcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/amd/pm: Use same metric table for APU
Date: Wed, 12 Aug 2026 11:44:26 -0400
Message-ID: <20260812154428.2235665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080524-joystick-anagram-33dc@gregkh>
References: <2026080524-joystick-anagram-33dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 56cbb36696407a27cfbfdbc2dee0b1e206178cec ]

Use same metric table for APU and Non APU systems
for smu_v_13_0_6 to get metric data based on newer pmfw
versions

v2: Use inline func to check for unified metrics support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 048f4541b71f ("drm/amd/pm: fix torn gpu metrics reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 102 ++++++++++--------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9ac694c4f1f7a..b79a2b66d30d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -102,6 +102,12 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
+static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
+{
+	return (smu->adev->flags & AMD_IS_APU) &&
+		smu->smc_fw_version <= 0x4556900;
+}
+
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -253,7 +259,7 @@ struct PPTable_t {
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
-#define GET_METRIC_FIELD(field) ((adev->flags & AMD_IS_APU) ?\
+#define GET_METRIC_FIELD(field, flag) ((flag) ?\
 		(metrics_a->field) : (metrics_x->field))
 
 struct smu_v13_0_6_dpm_map {
@@ -584,7 +590,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	struct amdgpu_device *adev = smu->adev;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -596,7 +602,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 				return ret;
 
 			/* Ensure that metrics have been updated */
-			if (GET_METRIC_FIELD(AccumulationCounter))
+			if (GET_METRIC_FIELD(AccumulationCounter, flag))
 				break;
 
 			usleep_range(1000, 1100);
@@ -613,29 +619,29 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			table_version;
 
 		pptable->MaxSocketPowerLimit =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit, flag));
 		pptable->MaxGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, flag));
 		pptable->MinGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, flag));
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, flag)[i]);
 			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, flag)[i]);
 			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
-				GET_METRIC_FIELD(SocclkFrequencyTable)[i]);
+				GET_METRIC_FIELD(SocclkFrequencyTable, flag)[i]);
 			pptable->VclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, flag)[i]);
 			pptable->DclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, flag)[i]);
 			pptable->LclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, flag)[i]);
 		}
 
 		/* use AID0 serial number by default */
-		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID)[0];
+		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID, flag)[0];
 
 		pptable->Init = true;
 	}
@@ -958,6 +964,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -972,50 +979,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_GFXCLK:
 		if (smu->smc_fw_version >= 0x552F00) {
 			xcc_id = GET_INST(GC, 0);
-			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
+			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 		} else {
 			*value = 0;
 		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_UCLK:
 	case METRICS_AVERAGE_UCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
 		break;
 	case METRICS_CURR_VCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_DCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_FCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency, flag));
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower)) << 8;
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag)) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
@@ -2303,6 +2310,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_5 *gpu_metrics =
 		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
@@ -2321,50 +2329,50 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
 
 	gpu_metrics->temperature_hotspot =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
 	/* Individual HBM stack temperature is not reported */
 	gpu_metrics->temperature_mem =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag));
 	/* Reports max temperature of all voltage rails */
 	gpu_metrics->temperature_vrsoc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag));
 
 	gpu_metrics->average_gfx_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
 	gpu_metrics->average_umc_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 
 	gpu_metrics->curr_socket_power =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc);
+	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc, flag);
 
 	for (i = 0; i < MAX_GFX_CLKS; i++) {
 		xcc_id = GET_INST(GC, i);
 		if (xcc_id >= 0)
 			gpu_metrics->current_gfxclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 
 		if (i < MAX_CLKS) {
 			gpu_metrics->current_socclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[i]);
 			inst = GET_INST(VCN, i);
 			if (inst >= 0) {
 				gpu_metrics->current_vclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[inst]);
 				gpu_metrics->current_dclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[inst]);
 			}
 		}
 	}
 
-	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
+	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
 
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
 	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
-	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
+	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
@@ -2405,22 +2413,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	gpu_metrics->gfx_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc, flag));
 	gpu_metrics->mem_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, flag));
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
 		gpu_metrics->xgmi_read_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, flag)[i]);
 		gpu_metrics->xgmi_write_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
 	}
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		inst = GET_INST(JPEG, i);
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy)
+				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
 				[(inst * adev->jpeg.num_jpeg_rings) + j]);
 		}
 	}
@@ -2428,13 +2436,13 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		inst = GET_INST(VCN, i);
 		gpu_metrics->vcn_activity[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy)[inst]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, flag));
 
-	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp);
+	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, flag);
 
 	*table = (void *)gpu_metrics;
 	kfree(metrics_x);
-- 
2.53.0

