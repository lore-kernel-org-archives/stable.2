Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27C424D48
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963067; cv=none; b=FwGHvYmxiK908mcCj9V6ujkn0Rp+EMKZFab8XYNpst/2pXzZQo0pnMG8XE2Cjsfbxpc3ho5NDAFW12HP0Jqb6O0ht/Ilv9P24c+XFgxL4ykiW2PGcfI1+C7BAobQ78tIJXUrG8jyIBKniUfmDPBMHNo5NV3iQ3vhunNwHPFCjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963067; c=relaxed/simple;
	bh=tjKwQAQ8z/CgCZ2Z5C0xCkgFR/a9sGPBE6NbXPb9svQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKWEZSDiNI7nGjJ/AmiH1J3bjrs2Gl/3AbscbOzsMqGJ20Q2jGQnrG2vZSVzNWswJhCaSZYjGyBcWwdvNnWMfrWlUPCF59MCwJtTwDWFF+dTfi3OUjKF8JDQJszM7BaFB829yCySSThocon/BNhhnp37m6g168HJGOd6NnF0NVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb55nLGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb55nLGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674F51F00A3A;
	Wed,  9 Sep 2026 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963066;
	bh=2ygQGyHuLwXIlx6nO2yUOD/a9TlSEFc1RlGla3MA+LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gb55nLGyl6huBdbrApseCQpZjm/b4hAu91reNH8H2l0V2V4TLKPceX3Cnt7L1LOqm
	 4jODynSyolxlbzrIksZjbT5Gt2e4NuKirTg4+LBb4yEgt74gGR4mzIaQgeVxxUT8UB
	 R2pFh788UYfxDsq7Ng6STH+fU9UJc8Uu/1HoFoAtIuNMUy1MECmZaLSjfKxu8oIk7u
	 mhcflV6xe1x2kgemwhD7d7euQCytgNrsrjBgQJMIF74bqudNh1IvAV2pJnrZJFwZvW
	 NVPz6n8S1xlQgQkKQ3ahtB378RvRAHudws2IsWdJe8M4c3ij/Kcz6ZEMCo4BOdExro
	 K1hH7FDeT07zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] platform/x86: ISST: Process read/write blocked feature status
Date: Wed,  9 Sep 2026 10:10:57 -0400
Message-ID: <20260909141102.2383363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 8bed9ff7dbcce4d1a436f7839be48c6fd5fac0ce ]

When a feature is read blocked, don't continue to read SST information
and register with SST core.

When the feature is write blocked, continue to offer read interface for
SST parameters, but don't allow any operation to change state. A state
change results from SST level change, feature change or class of service
change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20231204221740.3645130-5-srinivas.pandruvada@linux.intel.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..1f29642546613 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -233,6 +233,7 @@ struct perf_level {
  * @saved_clos_configs:	Save SST-CP CLOS configuration to store restore for suspend/resume
  * @saved_clos_assocs:	Save SST-CP CLOS association to store restore for suspend/resume
  * @saved_pp_control:	Save SST-PP control information to store restore for suspend/resume
+ * @write_blocked:	Write operation is blocked, so can't change SST state
  *
  * This structure is used store complete SST information for a power_domain. This information
  * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
@@ -258,6 +259,7 @@ struct tpmi_per_power_domain_info {
 	u64 saved_clos_configs[4];
 	u64 saved_clos_assocs[4];
 	u64 saved_pp_control;
+	bool write_blocked;
 };
 
 /**
@@ -510,6 +512,9 @@ static long isst_if_clos_param(void __user *argp)
 		return -EINVAL;
 
 	if (clos_param.get_set) {
+		if (power_domain_info->write_blocked)
+			return -EPERM;
+
 		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
 			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
 			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
@@ -597,6 +602,9 @@ static long isst_if_clos_assoc(void __user *argp)
 
 		power_domain_info = &sst_inst->power_domain_info[punit_id];
 
+		if (assoc_cmds.get_set && power_domain_info->write_blocked)
+			return -EPERM;
+
 		offset = SST_CLOS_ASSOC_0_OFFSET +
 				(punit_cpu_no / SST_CLOS_ASSOC_CPUS_PER_REG) * SST_REG_SIZE;
 		shift = punit_cpu_no % SST_CLOS_ASSOC_CPUS_PER_REG;
@@ -747,6 +755,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (power_domain_info->write_blocked)
+		return -EPERM;
+
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
 		return -EINVAL;
 
@@ -804,6 +815,9 @@ static int isst_if_set_perf_feature(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (power_domain_info->write_blocked)
+		return -EPERM;
+
 	_write_pp_info("perf_feature", perf_feature.feature, SST_PP_CONTROL_OFFSET,
 		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
 		       SST_MUL_FACTOR_NONE)
@@ -1252,11 +1266,21 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
+	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct tpmi_sst_struct *tpmi_sst;
 	int i, ret, pkg = 0, inst = 0;
 	int num_resources;
 
+	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
+	if (ret)
+		dev_info(&auxdev->dev, "Can't read feature status: ignoring read/write blocked status\n");
+
+	if (read_blocked) {
+		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
+		return -ENODEV;
+	}
+
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info) {
 		dev_err(&auxdev->dev, "No platform info\n");
@@ -1301,6 +1325,7 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		tpmi_sst->power_domain_info[i].package_id = pkg;
 		tpmi_sst->power_domain_info[i].power_domain_id = i;
 		tpmi_sst->power_domain_info[i].auxdev = auxdev;
+		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
 		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
-- 
2.53.0

