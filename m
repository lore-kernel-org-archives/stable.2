Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5B3E4C7D;
	Tue, 30 Jun 2026 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800185; cv=fail; b=exH1iBgjI2hBhe8UuPjQ/e2p8lWqRWXCrmLfV9nTYl5FiwtikP0v65N+YJjOrbajZe5vm+cztBeTGmkY1V/HzhxGm5ByHiTd6o8wfyWaGGO2jHdsmEMiG1rYVyoP4QXvifIzZ4ndbs3w0oahSFZEcdISzKAvpyXcV/QoTNNHoKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800185; c=relaxed/simple;
	bh=uAh+K9OzAfaVW+Vs0CJ9W3gMLAvjtPZPRze5fbt0SxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJwGprCFEIBNxertNZ4p9Lar10YbFBCVvdRXBAAZSMTSdwSxAA64g3a6szsb4kqX76muF9zBne5b68fVvJhPzFDvM5G6+85jsv7yuZfK0OL+QAR8SpsNXxFFO8KZYXrBwJlk06LZlgRlnIvwvFMCe7JzO3zxlKy5t114cVcz/v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dlgljKYE; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dlgljKYE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbsW5db5Z6NZIgOsWpxApEGe0VO6YmI4RsVDDOOCSKfCb9a3FGwCHu3EvNin3n60U5+8Mk4bQTol7nkepK8FJkvRDQUyO3NvFWjawkET7ua4GTuwCQK6DCp26e9ypvPtoIvCa/y+gnyH+T4GvH0ucZ2NcrqEZcm/ReZNyEzQNUD5PYMSWA+eRN8sgNn6hlI4tttylTfHvG3OICYyXrBofFR8lqaUMK1a6dkOpZ7t5QzT8Qs36XyBA4cp++k9FUEeHPsuNb38QAxSOmuxlmx0Vm8qxBhc2Tqbeu3tuiMWyv7zMygkt29gb5qEDl9EeeEedehGC4sqJ37W/+V5Nvh6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfYZbo4qVvls6tfxGKmEfWS68q9+A6W60QAnida8ujI=;
 b=eIOy7rnhj7XQGir8G4WEQd92qG93UeXI58v504c1492/OKNiWEq06xsxx6NoZPPM6XtEZ7hla9zbV8jd3PUfiWtmlNwc5mmRo/dRquNZkoWEJhcJWdSw8AqZHn5+sD/8nPd77jF/yLk1woBPTshkrpZ9eBac7qq2y7StKsUSb+Da4H6z2Wlcd6hyaVz3xHJj9vlMcfMZVyB3BORkbbKG8k62vEDWSNbUgy38venzWZJw4xiAY7E/xj+CoJKMBezPM+lu4OJ4/sMOsaBizWe6q0+ZWC58dOHX8pqSO41OaFa97f5qYCAMEpZBsIWAB1aqYL1zH2Sg5T5bTejzfVj4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfYZbo4qVvls6tfxGKmEfWS68q9+A6W60QAnida8ujI=;
 b=dlgljKYEx9i1ESmKqXO3oMqTdhNyBOS4bpzdvkNgvVWqs20ImvZgvYUW9wnAHZCB44ZR4G/NtpHnZh+56RTsQstluOHTgvAre/22wio8fLE7TxxiIXk2aRdCHDKSFN4Awblqx3/ze7+OE4tMQBHtWgokV/iQ96u5fYCSGIBTxqOLI+1XipXhM6DKFe6X721IpHVy8bpls7lKYPAA0ZPI5LFU5zezq2dZ3UhbiN8u7pyAC77+jB2hCJXTyBiFYkTU/uku9anbAVgSRnPeIX7bh0COuFUfflUt5p4qZTUCpC5hlvQGSr2qWeaoEizbYlPeZOXRh7AzlwwEeLY/TtzvSg==
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:18 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::d) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 06:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:16:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:16:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:16:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 7/7] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Mon, 29 Jun 2026 23:15:40 -0700
Message-ID: <702d43bee205cf4970a249762d5aea6e4101987e.1782799827.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782799827.git.nicolinc@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0d9dce-c418-409a-0bc9-08ded66f18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	uhS9H1ccaEkuKgJq+RuITAv+Or60HnKQxiz24cFnMwnd8ak1eqH33KJc482rLA94sHX8gOPV03dw4MlEEeITKp4F40XbxwEXgB2PXGsmt0EyCyrk3picy9WkFrg1rLdL+NmTt4+JjSwcPlNdOsXwp15AgaZEcAvUydI2so7/P7nB/KfXfRaXWnK6byIUU0CkHe3kiDuYBsH9FhmAsBBP5MXo19B7vyOYKckngdbj7Lsd20FQ4dls55LoZcwE9plEXPjaS8IkYExfn1HEIpqcCMHH3pZ3FEqL4dJh6u1smdI/U1IsC8t+nrwfqAlVk1vvrY/lDvJenH3Tc2ovPMO4vnH761aOaDpo3qemvPnESZlrDS0cVEkHfpZqb+/Q3k3Ha/H+zIWMgl7aWSdqrNxoR6dzx1QynJ7QPLoz5KocAZGgMyuJ/4R0iRO+D47MGYCTgIfGuLze1x0/qm13VoFO8D1xWytvAJvQ08Jmf1+G18BTlCAscaO/IPxO/kKJyNkGLaY1l3SKgkJWxtbs/ewLjGiVQZ1FcbxdprsPbdZz7h37XsjI1eH37XGCaJ1DhbA5FwVn4TWZBTBQzISsCcKTmT0B3+4HSQ/45ssjjEN0D7ZwH4+jKXfmzwAZDZvyx7yT8ofv6VsXh5qp7grrvuOhqmDbZjFfU3lD7XhGn0loDRc8KdlMrUxa/MFSNfwTPR4tfdjDGskUNnste7lYKqcLyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4kmetoDjT6vcnutjk/gV8Zn1zMqmvaDXzR3yNzjBzvAoCbltBPe31ai+svz48MPO5O5x2yBa+ve76PcZiDzi40jGjKIrxnV2C1aLLV1Nm7OBF1Y/1ow8fj92bMmVdyuN2OudwYdXcaDkjU/1TlkrVDdPZyWShTJWt8aWHtDHCuRZJnt+sJmjvXik7ne3tlIGo8Bbqk7PEyVp6eNz+M664q3BllLrF4DQ5AeKTWvfpPc0MAxsqRuIfe6YjKPidNKLjy1MYRDsHWOXDytZ+V17YCwHuqmJNaxyr3jusLJ6UxmHf9f94C3m0AAotD8RVgGBgGKkLAU02tgGiazkaBgiOb3EqxoQN2UShNnLrpL1zYQ7z9MzH2h84p3wb47Ov7VAcerHaDgglikqVJeXlc8XZK14lA+2KLWAn9fvy2QS6tbYUuVAmyIokZRD1stN37Ra
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:17.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0d9dce-c418-409a-0bc9-08ded66f18da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 822ab73161969..bca9395b6a1ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5280,6 +5280,33 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 			  hw_features, fw_features);
 }
 
+static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "kdump: SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -5494,6 +5521,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_hw_probe_kdump(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

