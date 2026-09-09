Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5288582BBA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965908; cv=none; b=l1oXBenKKPLhMV4Jnt5FFzScbRcU24clmm76+JQpCoKAd35dSeV+TJlzY3LOXrjZqwQG58vmfQZZvSsespDh6Ahqb8CY5lAjEyP4+J4Ytz93vU2ZBbKNERcOYn9mqlU45KxfoOl2Dtc4GR27a/6eLwvjIXY3oZskoJ1/SRd8Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965908; c=relaxed/simple;
	bh=TO4AavplhxHjoKiCXxJF9MKJcIN2paYvhigULK5c8r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjas8IPHGff7UM4xkc6S25OG263gcyClCZBsqDwUB2Q3/PH10qdzr4ksElW8+N/YNpfe169AuQyNrDTKNn/82Dh00XHIX2/ZtuQEt6m2bhxx0X0jtzXYrys16eibQRC7wTAhafKljL6VjcYVTfQNa6XMTqMEOlG7TdUpV17ZcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7llVf4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7llVf4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9B31F00A3F;
	Wed,  9 Sep 2026 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965906;
	bh=zjFS7+VPsqdMErLOFm05bvTQ3PY4QV9XskyzeYXji9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7llVf4mmZdorxZlWqDOSrDoL0flAl4GdRRC+B/a9jP8UfU7JXtJeYlfpPEQ2g08I
	 7hl3SUBXXLjypCUXpu0kG2W1gxN45BsblHZnQjtKdyQGCLmmUssHIW/IS/ZBIjGchy
	 ExXPpcj8OJa+Qw/B3++IAamwXct9bjphPLKFbCYLwpc/Si2aCQXcJCexkm3DG8ye7S
	 82a5ryPWncmhWPPv+WoMyzUSfMKNJS9EyAZS+K5S9ZSmEwgOHCJw0yG3nv8ssJ7Blu
	 sf3fCh3jkv9NZqLNqB2cDVkjniSP2KDNu+ggQeXO+x+mkBDYi+UulQHbUzCXB09max
	 ZQzaKDYdyj5/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] platform/x86: ISST: Process read/write blocked feature status
Date: Wed,  9 Sep 2026 10:58:18 -0400
Message-ID: <20260909145822.2742457-3-sashal@kernel.org>
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
Stable-dep-of: f9a647cb8d90 ("platform/x86: ISST: Return error during profile addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 292a7cfa55759..0d0c88b9095b9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -234,6 +234,7 @@ struct perf_level {
  * @saved_clos_configs:	Save SST-CP CLOS configuration to store restore for suspend/resume
  * @saved_clos_assocs:	Save SST-CP CLOS association to store restore for suspend/resume
  * @saved_pp_control:	Save SST-PP control information to store restore for suspend/resume
+ * @write_blocked:	Write operation is blocked, so can't change SST state
  *
  * This structure is used store complete SST information for a power_domain. This information
  * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
@@ -259,6 +260,7 @@ struct tpmi_per_power_domain_info {
 	u64 saved_clos_configs[4];
 	u64 saved_clos_assocs[4];
 	u64 saved_pp_control;
+	bool write_blocked;
 };
 
 /**
@@ -518,6 +520,9 @@ static long isst_if_clos_param(void __user *argp)
 		return -EINVAL;
 
 	if (clos_param.get_set) {
+		if (power_domain_info->write_blocked)
+			return -EPERM;
+
 		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
 			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
 			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
@@ -605,6 +610,9 @@ static long isst_if_clos_assoc(void __user *argp)
 
 		power_domain_info = &sst_inst->power_domain_info[punit_id];
 
+		if (assoc_cmds.get_set && power_domain_info->write_blocked)
+			return -EPERM;
+
 		offset = SST_CLOS_ASSOC_0_OFFSET +
 				(punit_cpu_no / SST_CLOS_ASSOC_CPUS_PER_REG) * SST_REG_SIZE;
 		shift = punit_cpu_no % SST_CLOS_ASSOC_CPUS_PER_REG;
@@ -755,6 +763,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (power_domain_info->write_blocked)
+		return -EPERM;
+
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
 		return -EINVAL;
 
@@ -812,6 +823,9 @@ static int isst_if_set_perf_feature(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (power_domain_info->write_blocked)
+		return -EPERM;
+
 	_write_pp_info("perf_feature", perf_feature.feature, SST_PP_CONTROL_OFFSET,
 		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
 		       SST_MUL_FACTOR_NONE)
@@ -1260,11 +1274,21 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
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
@@ -1309,6 +1333,7 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		tpmi_sst->power_domain_info[i].package_id = pkg;
 		tpmi_sst->power_domain_info[i].power_domain_id = i;
 		tpmi_sst->power_domain_info[i].auxdev = auxdev;
+		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
 		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
-- 
2.53.0

