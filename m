Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB043E715A;
	Tue, 30 Jun 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800189; cv=fail; b=C2j+YxmvWinDIihq5FBYUWp2flWk0Ld722qhEA/1GTk6iopWIB83QioH49Rapxmy9Es/r8/yTSeakew5jmIc13rVy2wGX8cjBqQ4uZG1ENe/rd1AWNKVMJqhY+1VOTTp9BP84febR9o4ZeAPd82CZg0Be9MKqVP74wE/Dn8/AbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800189; c=relaxed/simple;
	bh=v2PJxtRzjAkEzo/sJJ7tqHpdqTXrHRvVbC76ncyXfwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxuHcIP7T6Yymgd6PiPiv+qR6nxr3IJUhn9whiv3ivOAuy/Frm866ouna/m0BF+sIRsJ2nwXFQHbiS2j1IBo0BRqp5rpKqz9ldPZVGhEOjFW7OYNwyi8iJUM0dw8yoT5WWLaJyrNeQsohOO0sXSFKMZ31zbQr49DvV1sA9zTteA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaSm2ZTs; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaSm2ZTs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t46XcQAKdM5HIzP+PC/Z2ivkcH9SLOLkMJPEknzwyWW7h4Y6VfjpFKjibY0U87WiEQHqOGVhCp3ikuEpljgUVkz3ebSC6k8R67+2UqnVVPNWXXEJeIhIZtO5MI7rLoAd8lATSXvVRs19T7BX/dmn1WCYW9saUtyMk0B7BqYnrqB8qngxw82B9LCbaHSO3VVeEdKxSC1/+ns2ARZBF3oiQYof2HlQz1AWxK/TZm4EH4HcLpzM0hDGbf5a2ufHBybm0KbfJbIqNZsqmkZi2nttXp4R2/TvJXleaHtZY3EdVykihEkD0YILuEAuuJXlZvccqU7kEib3X6pNEfGCSb9sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCdLUOrPahdSZOE3ORM+KOpLmv/f8Rp0zpPqW9+gpBA=;
 b=yVDcWYagITe/LM4Wq1zs0ev+EJicg4TVf01hvC79nn6epezq8NCTQDh2TfDe0V+w2S5GYrNjK9wPtGz2FjiYW7yBO8o0lq1V99f3/2VxVP2rNaIuzi2o7+9ymWNmROJpaPSym+rD2QJAKvM7v5IpzgWFg+R4i+0dnz3bzZ9qqf31rZ7QR4903nBTq6BALNkpLSRtdyqZrReFGGmj2M+h+l8DJaiUKrRdbMYed2M4sOiss5KKdkz4JBeHypuCBcE3zG0Zq0qSnFXjTlg1VfWHe6LrDGB+qnlY/r/KgAV5/QHbsXTej1rRpA7yuKsuNEsl3WjGd4ya3nxkm40vdrphVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCdLUOrPahdSZOE3ORM+KOpLmv/f8Rp0zpPqW9+gpBA=;
 b=UaSm2ZTsJ5NUZSxKBHNgWIW6W2lhovMAqwzcyp4IDm1UjplY0REZDWKjjyBhPKVsPZcaK9aspmqZVk1ldozVA2L4/vuv6GlI52CNjSKRq64MnmWZKiTtOO3Mi+NCx9WmLu0WNlZy7jM2eb8er06bxQxP9eoLVKOm2/C9VtaahOvvxAjqqV1Mb7GLiIxd4B5cqxfOYh1BN86/YamJkZIgKfR5Z9YvVZVlRaULzoa7DBfYaJduogRarrpgJDCdVDN5EaTk5GR4ZZjpd1IUhWjMsSl2uFmTBYV4PbA3VTvO1WnzD/ZBTfzNcBPeWKEWUFOgCfZ4gpkBPLar9YAfhhIBhg==
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:16 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::6a) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 06:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:16:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 5/7] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Mon, 29 Jun 2026 23:15:38 -0700
Message-ID: <6f08e5f6ee8de3fe3613d834e26120cdbdaae7fe.1782799827.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 14067e17-0d9b-4c6a-b48f-08ded66f178b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Hd6R5f7o1FKTQe9WNWpXuK4dCOU/uHivzSIKmP1lpRrz9D7NqT1jpkr7vq/Q3ymFD4LxZW6YHGYvJVtvplnmaqQoTsL3HJ4aXbLFYPCESfmm87NgvmXQd+x2X3z2Wvpuuft688QyWpxwiveY5C5T6QvZGrw/v419rtVGM9BjwVEpO6mKtXNoFsxIv6ST+8iCRLWYpWX+di5YwD5n9ezfSYZv0BmfxPULyzfSkX2NaspedzdU14ksS/bb/vZHOiItYJFkXrDphxlCBnj5AN/40C1GyLqUXcB3/Iq+OqMlTr29NmubtpdBD7njmZkjr3kOgHQkbbxbpEA38/o4eWdyu00SoL8k0m8rStqSTWUCFEsCTjrTEznE8nJWOWLQ3MTj8aMK0eo4BqvHcYDjJZAcw1rrMka1+xu5O8Vhq27yssMPm2Hgk0qS4DpC7gHxq/5940ktZYwFU7CKt+Shamql/jRob2pp/OenP2UkwzscTFcg2ux+3mhhb0kEivMFxQKXLbdsDvcgrgBevWp+O6KQ4Lj2mnZnTt5BgzfZ2yNrQQT5fiJYcOWJmID3lwTdFv+nMoqA9Mci9/yWMsGnG3X4JnxNJW21Y84/IaPCxEKk9gLk+X79kH8NqN2ZV8HifHo1TGY7b1GmgOCbRbPywPovE8R8QtK8zQzNkBej7bAVk0GoSIHUWxbk5UJ/+cO0NPilfHAWyCng8H4of98L2KiHAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gpfCU1hP72U0siUlpELdfM6H/EAZ+AKhSMB2oLv8Bwp8wtGLYp0FVUcmEfeXKkR46MrLZMxwLaTtLr3ha3Ib7O/ux3/syLaoL4TCoCphja4ddNaJ5eRTR/zmffNyd/+jdIAyXWci/oSSstz5S4063OdsXqNMloy6IlYCf/4uV+JjiN7ZLRxA3bFTBhNgP5KpSXtsJsWnVZOD2iCJiUjwUTaWoCuFdzeLKfCI9gVKU5Uhv8OAU1iHKRYggDbq4zTtoH1EztYP7EUOsYlIePdP5dzseK7MgRwgj1Ih+pzxPBOZo1NOyIULobdJwEehWe2ZMfgS5M6d15fm7FbJPgF5lSXwYt4F46IUT8lrEyrUHyL7Ht8a+xe5d5wjQat9UbjCriKdt6CwLXUz9QgtEwpGzXOvgGlYm3fC1rsjnjwigxTCg9/jH0D/a1dJN0g+ihVc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:15.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14067e17-0d9b-4c6a-b48f-08ded66f178b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
preserve that when enabling the command queue.

Clear latched gerror bits if necessary.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 +++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index abcbc9874f252..55ef2e7470a42 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5025,10 +5025,27 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * CR0_SMMUEN to avoid aborting in-flight DMA, and CR0_ATSCHK to carry
+	 * on the ATS-check policy.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & (CR0_SMMUEN | CR0_ATSCHK);
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -5058,12 +5075,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		/* Disable queues since arm_smmu_device_disable() was skipped */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -5128,7 +5169,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	if (smmu->features & ARM_SMMU_FEAT_ATS) {
+	/*
+	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
+	 * captured above rather than forcing it on.
+	 */
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
 		enables |= CR0_ATSCHK;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 					      ARM_SMMU_CR0ACK);
-- 
2.43.0

