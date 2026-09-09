Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6F582BBE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965908; cv=none; b=s7SYz6WVKTgAwycfZwAm9fJrmEu4qNAgwbEA+45suR7mFK0zsAI3hMKdHBlWO9D7fTHyFUTuz0vQlJd+8OSuyENLxBOr+AXVykPksoriwTu3Gc4IiwDA4hvVwpT3c9+d53l+NcpERuFVKS5DQqqz3zR5EOBEootTd2CqPGsBtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965908; c=relaxed/simple;
	bh=lFOAOTJrWOjO7D+3+hbSqoZpbW9o9p3nMvMeTXuslIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qf5q9QDEacG2CCs04vcqoX+lCjhAZFoyFbR4IXrwgSTXm1SSWBJs8YcHBXQ3kcwT0LaNiwATzyYela501FvHT0ErgfOogTSxIKvAqvfo4SqLP0zKELxxOCQlGV0a5ufbguYuT3SB5aXFkKNLHrPWGBY8YhaS2d9r5ECRnVG6L5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv3zQX1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv3zQX1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B71F00AC4;
	Wed,  9 Sep 2026 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965907;
	bh=GjdVJ/yHKyI8Uaynr+feJZo/6Wr2Wik5j0DP9WhAngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cv3zQX1wvJsMJv0AMPRJqrSHtb+SPK8MQaaB/knsqydRHmnyvyUdTTuY7vWS5ACM3
	 q6gKVQIMlIVgTrXesAtg1HA3EBURs8yefWtubxZcpp6REUT6/L0k9h4oaC/M5pZrKY
	 0SJNbWxE53WT+0fpGzaknwabgjQDfXsZ4ClhVtZAwiEd5ptRIZRdg+0wT3RTGU238W
	 I32ySevluy0KpNr9yyBdeSvGHufroKl5Kwim9z98f/uUEz5VwMAhuCino1Oo+M3MZz
	 nnHbFxyyQxirbD+CVANQyiTvQMmvCItzVbliXe0Iag7ltHlhYdrlMPGuB22NIDE7Qq
	 Em2y6vmh/oiuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] platform/x86: ISST: Use local variable for auxdev->dev
Date: Wed,  9 Sep 2026 10:58:19 -0400
Message-ID: <20260909145822.2742457-4-sashal@kernel.org>
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

[ Upstream commit 8c5a689eef5b1c1eaddd17b0b1f2609d3f66c5b0 ]

Define a local variable for &auxdev->dev and use to shorten length of
lines. No functional change is done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240423204619.3946901-6-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: f9a647cb8d90 ("platform/x86: ISST: Return error during profile addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 0d0c88b9095b9..a73d425cf0410 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -313,12 +313,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 				 struct tpmi_per_power_domain_info *pd_info,
 				 int levels)
 {
+	struct device *dev = &auxdev->dev;
 	u64 perf_level_offsets;
 	int i;
 
-	pd_info->perf_levels = devm_kcalloc(&auxdev->dev, levels,
-					    sizeof(struct perf_level),
-					    GFP_KERNEL);
+	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
 	if (!pd_info->perf_levels)
 		return 0;
 
@@ -349,6 +348,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
+	struct device *dev = &auxdev->dev;
 	int i, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
@@ -359,13 +359,13 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 		return -ENODEV;
 
 	if (TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version) != ISST_MAJOR_VERSION) {
-		dev_err(&auxdev->dev, "SST: Unsupported major version:%lx\n",
+		dev_err(dev, "SST: Unsupported major version:%lx\n",
 			TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version));
 		return -ENODEV;
 	}
 
 	if (TPMI_MINOR_VERSION(pd_info->sst_header.interface_version) != ISST_MINOR_VERSION)
-		dev_info(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
+		dev_info(dev, "SST: Ignore: Unsupported minor version:%lx\n",
 			 TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
 
 	/* Read SST CP Header */
@@ -1276,28 +1276,29 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
+	struct device *dev = &auxdev->dev;
 	struct tpmi_sst_struct *tpmi_sst;
 	int i, ret, pkg = 0, inst = 0;
 	int num_resources;
 
 	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
 	if (ret)
-		dev_info(&auxdev->dev, "Can't read feature status: ignoring read/write blocked status\n");
+		dev_info(dev, "Can't read feature status: ignoring read/write blocked status\n");
 
 	if (read_blocked) {
-		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
+		dev_info(dev, "Firmware has blocked reads, exiting\n");
 		return -ENODEV;
 	}
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info) {
-		dev_err(&auxdev->dev, "No platform info\n");
+		dev_err(dev, "No platform info\n");
 		return -EINVAL;
 	}
 
 	pkg = plat_info->package_id;
 	if (pkg >= topology_max_packages()) {
-		dev_err(&auxdev->dev, "Invalid package id :%x\n", pkg);
+		dev_err(dev, "Invalid package id :%x\n", pkg);
 		return -EINVAL;
 	}
 
@@ -1309,11 +1310,11 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	if (!num_resources)
 		return -EINVAL;
 
-	tpmi_sst = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_sst), GFP_KERNEL);
+	tpmi_sst = devm_kzalloc(dev, sizeof(*tpmi_sst), GFP_KERNEL);
 	if (!tpmi_sst)
 		return -ENOMEM;
 
-	tpmi_sst->power_domain_info = devm_kcalloc(&auxdev->dev, num_resources,
+	tpmi_sst->power_domain_info = devm_kcalloc(dev, num_resources,
 						   sizeof(*tpmi_sst->power_domain_info),
 						   GFP_KERNEL);
 	if (!tpmi_sst->power_domain_info)
@@ -1334,13 +1335,13 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		tpmi_sst->power_domain_info[i].power_domain_id = i;
 		tpmi_sst->power_domain_info[i].auxdev = auxdev;
 		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
-		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
+		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
 
 		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
 		if (ret) {
-			devm_iounmap(&auxdev->dev, tpmi_sst->power_domain_info[i].sst_base);
+			devm_iounmap(dev, tpmi_sst->power_domain_info[i].sst_base);
 			tpmi_sst->power_domain_info[i].sst_base =  NULL;
 			continue;
 		}
-- 
2.53.0

