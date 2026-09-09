Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E96582BB9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965910; cv=none; b=sf3rJOuLubEI5UHXDtI3SLcrkTcAf6DIeBAVBQwkt+i41TATI3DMB4/2m27/g6W4hjwUt9FFKHTdGojeffH/+wyuoIwkAV4tuNX0neFjsZyGraen+NU2ek2Qlc3vQObzJ12j6PAHSe+1uP9/Jyxdm9fy8tnS5olTPzTFqpEWvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965910; c=relaxed/simple;
	bh=K5fT6BG7wGPnC/IEmo/8lZ517eDS54Ge2uKxH0GbEjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO7zwz/1KBRNmM4X/+XhCyowXPwgWr2bIA4P4YB8g5nCmgjPx916BCdtFcCUY5pWqij1n4h4zjuWLnV4XW9Tl/beF1AbeW4aPdBasZrw6wotQUgZ8cc5ToFz5HUVv7Nho2WBBMpDYoJs3PiqDrLIsDYZkX97FgTJ71RDV7Yualo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec6Vm1mR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec6Vm1mR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528BB1F00ACF;
	Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965908;
	bh=gg8/LKl6Ig9JuKhKKb7Jixw07oXQ2dn58zBSdIg4ya0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ec6Vm1mRKJz6/DV6Cz+tS3di94nRjv82+Hjx7t9PdDkVvfqwUpQ2j646gT9/w9woE
	 RRCtucU0WRK7/Bl5sXhjfDGIcS9/6Wz9DC0aJp40/Pp6hS3ExoiHF3LqW6qVpC7HCL
	 vJF0FJ3QiSDtq89Lf0kMbxsGjgbL90fLjKeLotYSGq7yJM4qBewDm5dCdatp/RwlKr
	 UeoaaFBxWVGCyr4o+crjg5Gi/w2lxdgnr2W//5xczFzZtgxJUQ33QdDenfDr/jufbQ
	 h9j77T/I7ZwQLeIIyK/U0BWmds7W9bTneOGjiQnkyIxvQOdaGKQLFiBK6ie3zG5skL
	 efyt46YpYcBFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] platform/x86: ISST: Use PP level enable mask
Date: Wed,  9 Sep 2026 10:58:21 -0400
Message-ID: <20260909145822.2742457-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145822.2742457-1-sashal@kernel.org>
References: <2026090339-boxcar-confused-152e@gregkh>
 <20260909145822.2742457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 9b9026943b19d06ebf520b1f4786621947cf43c8 ]

Add check for enabled levels only when reading MMIO. Some levels can be
disabled by BIOS. If the level is not enabled, return an error.

Reset the enable and allowed level masks if there is a failure to add a
perf level.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-6-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Stable adaptation: omit the enabled-mask filtering of the per-level
BF/TF support loops. This tree predates 76f09e22027fc ("platform/x86:
ISST: Support SST-BF and SST-TF per level") and still reads support only
for level 0, which sst_main() forces enabled. Keep those existing reads
instead of importing the unrelated per-level reporting change.

Retain the allocation-failure mask clearing and the disabled-level checks
in the BF information, BF CPU-mask, and TF information ioctls. The mask
clearing supplies the context needed by f9a647cb8d90 ("platform/x86: ISST:
Return error during profile addition") to return -ENOMEM and propagate
the failure through sst_main(). No functions are added.

Build testing exposed an API mismatch inherited from the earlier
8bed9ff7dbcce backport: ISST requests bool read/write-blocked outputs,
but the stable TPMI core still returns int locked/disabled outputs.
Include the required status plumbing from 8df012a7f5131 and
72dd14d241e1c in this dependency. Return the raw feature-state word from
the existing internal helper and decode read-blocked bit 5 and
write-blocked bit 4 in tpmi_get_feature_status(), with matching bool
outputs in the header. Preserve the existing locked/disabled debugfs
output. This avoids importing unrelated debugfs and enumeration changes.

Stable-dep-of: f9a647cb8d90 ("platform/x86: ISST: Return error during profile addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 14 ++++++-
 drivers/platform/x86/intel/tpmi.c             | 38 ++++++++++---------
 include/linux/intel_tpmi.h                    |  4 +-
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 1220ce4e3b970..8382974f31027 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -318,8 +318,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	int i;
 
 	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
-	if (!pd_info->perf_levels)
+	if (!pd_info->perf_levels) {
+		pd_info->pp_header.allowed_level_mask = 0;
+		pd_info->pp_header.level_en_mask = 0;
 		return 0;
+	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
 	pd_info->avx_levels = SST_MAX_AVX_LEVELS;
@@ -1080,6 +1083,9 @@ static int isst_if_get_base_freq_info(void __user *argp)
 	if (base_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(base_freq.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("p1_high", base_freq.high_base_freq_mhz, base_freq.level,
 			    SST_BF_INFO_0_OFFSET, SST_BF_P1_HIGH_START, SST_BF_P1_HIGH_WIDTH,
 			    SST_MUL_FACTOR_FREQ)
@@ -1119,6 +1125,9 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (cpumask.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1195,6 +1204,9 @@ static int isst_if_get_turbo_freq_info(void __user *argp)
 	if (turbo_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(turbo_freq.level)))
+		return -EINVAL;
+
 	turbo_freq.max_buckets = TRL_MAX_BUCKETS;
 	turbo_freq.max_trl_levels = TRL_MAX_LEVELS;
 	turbo_freq.max_clip_freqs = SST_TF_MAX_LP_CLIP_RATIOS;
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 021e56f52ac12..e5738b304e5ba 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -228,6 +228,8 @@ EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 #define TPMI_CMD_LEN_MASK		GENMASK_ULL(18, 16)
 
 #define TPMI_STATE_DISABLED		BIT_ULL(0)
+#define TPMI_STATE_WRITE_BLOCKED		BIT_ULL(4)
+#define TPMI_STATE_READ_BLOCKED		BIT_ULL(5)
 #define TPMI_STATE_LOCKED		BIT_ULL(31)
 
 /* Mutex to complete get feature status without interruption */
@@ -243,7 +245,7 @@ static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
 }
 
 static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int feature_id,
-				    int *locked, int *disabled)
+				    u64 *feature_state)
 {
 	u64 control, data;
 	int ret;
@@ -294,16 +296,7 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 
 	/* Response is ready */
 	data = readq(tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
-	data = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
-
-	*disabled = 0;
-	*locked = 0;
-
-	if (!(data & TPMI_STATE_DISABLED))
-		*disabled = 1;
-
-	if (data & TPMI_STATE_LOCKED)
-		*locked = 1;
+	*feature_state = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
 
 	ret = 0;
 
@@ -317,13 +310,22 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 	return ret;
 }
 
-int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
-			    int *locked, int *disabled)
+int tpmi_get_feature_status(struct auxiliary_device *auxdev,
+			    int feature_id, bool *read_blocked, bool *write_blocked)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
+	u64 feature_state;
+	int ret;
 
-	return tpmi_read_feature_status(tpmi_info, feature_id, locked, disabled);
+	ret = tpmi_read_feature_status(tpmi_info, feature_id, &feature_state);
+	if (ret)
+		return ret;
+
+	*read_blocked = !!(feature_state & TPMI_STATE_READ_BLOCKED);
+	*write_blocked = !!(feature_state & TPMI_STATE_WRITE_BLOCKED);
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
 
@@ -332,19 +334,19 @@ static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 	struct intel_tpmi_info *tpmi_info = s->private;
 	struct intel_tpmi_pm_feature *pfs;
 	int locked, disabled, ret, i;
+	u64 feature_state;
 
 	seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info->pfs_start);
 	seq_puts(s, "tpmi_id\t\tentries\t\tsize\t\tcap_offset\tattribute\tvsec_offset\tlocked\tdisabled\n");
 	for (i = 0; i < tpmi_info->feature_count; ++i) {
 		pfs = &tpmi_info->tpmi_features[i];
-		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked,
-					       &disabled);
+		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
 		if (ret) {
 			locked = 'U';
 			disabled = 'U';
 		} else {
-			disabled = disabled ? 'Y' : 'N';
-			locked = locked ? 'Y' : 'N';
+			disabled = feature_state & TPMI_STATE_DISABLED ? 'N' : 'Y';
+			locked = feature_state & TPMI_STATE_LOCKED ? 'Y' : 'N';
 		}
 		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%016llx\t%c\t%c\n",
 			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index fdcebb8c30e98..541d17b8b90d5 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -46,6 +46,6 @@ struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *aux
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 
-int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, int *locked,
-			    int *disabled);
+int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, bool *read_blocked,
+			    bool *write_blocked);
 #endif
-- 
2.53.0

