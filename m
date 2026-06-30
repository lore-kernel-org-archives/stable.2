Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DC3E2AD2;
	Tue, 30 Jun 2026 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800179; cv=fail; b=hBlnx/2gVDz+GS53xjHr/Pvnux3qSSMbPxG3DNT+PA1Xuk0uBjmGBpgVlfJbBDfL2q2hvgvwxBqfq/PMse06ooo7JFORq+kRbQWpwl95V9GcopqTFzGL8XH3JZDjy8c8bEd3YqPZoOfGKLyLVqSAD3cd1HYZ6s3lnvC3PPxTHWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800179; c=relaxed/simple;
	bh=UwDVZRMbx794Hjp/dj0FbljKe+RWqwru71oeAVhOXb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxHteeBSffeOafefhK7QFl6FSjlzo+2IpLjUTFLD8nCe+j6X+m07+GPxZPBux2QPKASqYq0VR6KfWAnPwGVHE/GY1SAqwB/HgCHKx7NE9TM4Pcwap5BehyVKT9MorxuwuTH5VkOqnyLMDkuqVdJigD0rhM7cOgsUn5pTty3VLmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNqVKE9U; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNqVKE9U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgfUXzp2K5fNXLIQf/x2fr1ZlFWXtjI20tpVuayTJA20vFvgns8BnLkj/olUe7r8MGyXE/e/RTVZXEedUn58Lv8/WjMmiZ7aYUOa6VV+YdMDoPoWACkOuqEKqiXyaQgCcDz4mrS8aLlw5QuLiE10GwKvhubMsYl8Yyyo+35jadgrNpl4qQ4dCZp+Oy9zSmLWd6NoRRAnHNt8HjwNpbB2E43639QMVqwDFqSWFrnVPEqA/yrSorJ4Wgh/RZKIijUjKfaM+KroT+MQIlqhdMTCoL+UUCUriqYcsvfeqp084s2LAleO24kOBcFESW8IaaGZ7v6VIConCCng6I+5siN08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4s83RVRuYz9hI6DmirPgcDa87lEc3Vr960tnB4NRcQ=;
 b=r6tLA/AvlfsXb13wc9sRiCQTUqtJ0FLNYG/V4k/gBcK3CdqglLrn0gLoPVJkJ0wwQxm59hrh2SZ74YcZz81M4j+hgfF+DCSGmpNQxCDxgQIx7nAJD59M0p+lfTV3LWDOlkTh7BkJ708tXVBxgu7mmhyxfjF8udObgJqdA0okzQXfeYuXX7CBD7dt751zoFl8EFrUaOMTw9OseWfp6VBri71ETg4RX1X9F5QSdkoTLGnwovJnpU9BnX/oqKa+mubWZD6+FgVGwOTJCpfShjWc2MsU2IYs2ls5SrX02VMSFbyajpqK8yK/A8nGvHGdY5e07EopfphfcWms8gpLahs9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4s83RVRuYz9hI6DmirPgcDa87lEc3Vr960tnB4NRcQ=;
 b=TNqVKE9UMiIe3a3qhUK8lrfzWZUxC4K3tzvfMpEEm9ceJ/KbhoaeFqI+LJphRusRKW/SfE1NRVsrLD+VcfySZtKygJcGsmQXDINAR/ppZB8XtZZzs6EAxhSaia/WqagiodtM1n3KyFv0LCuNJLmyGc8xU8J3k9fs1Rq/zOl8Q1BCFhNGjVkYoJhoxeV8BO/mKMLCRwCHpmpzd+UiTy0nLbNy847aeofAqsQ8bKlgoP5Qwya4Yk22K06MGNF39z62fZvozS1Mkjmj2hdzCOBVVxGWm1XMg1QsI2d1ne52+yp4Di8fefw/5cRcCmXKM5M7j37tR24F2Tj1nXWIeT8dSQ==
Received: from CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:12 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::8d) by CH0PR04CA0110.outlook.office365.com
 (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 06:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 3/7] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
Date: Mon, 29 Jun 2026 23:15:36 -0700
Message-ID: <486f6aef39700999692ed83fcae48d7e61d8c86e.1782799827.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: c76e1369-eaff-4a2c-4fe1-08ded66f1569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1KiQQ4I/BG+VoLnn2dMsnBCVi1KVNX1AI/3q8cAShW6cG9YZQ2svbTLogbFfj3R8pVcmOtvH7ZqoBjEnor58fbowxGsHWtx+zZphql090TJv3CVN1lRyD47W2LGTvMfHq0ur0bmaKLkowYYiSjsWN3PI70VSIkQkO59n/tEHS7IL/9hFa6EjZ7OrTQ7crpls5TfqP7DYolJmKhP6/NuwK1jZbTJ+xzXvOwAFJDRMgXKnIqTktjI/CkTAgvgz0t5tzpnoUxwnWvGUu/2AJYcF0tFVjA66+43XIiQltdKGxZomsbQNusKq/zTayTnfuVd14Itx/5B1Kr6gcnluaagXIxLyTHPiokI0xIMv0Z4udLyzYopLMnThtq7+k7SOARqD8giKVO6Azwk0+JqSGn+jGbk7M4oGNxZB+nlykLfjZnWai8ZoALzW62zMLbN9MoHjiSoJS1oYBZ0QXN6VNFdLVgaAsI0ymRkEjoxwg5KQ616nSqFQYrQBTCIobZvqMtRpWlvSAiXF1Z1JBHY5yb5xJPbFhJHExSibtrZ1BXRZT97u9Wp+muzLQ6639b+Mec5tOQZG1FxU8LzLklxa0bCf8n1MVK4txM9KcUBKx/Eez/yfbgPezZ+1C4EJ+ee+5NUiYlTtMNyZN49M1X5eYkagaGtOWq+EJKqIYuS+bT/WQ35nUXcJ5Bi1NXjuEZAMM4f84+tEEQ9RLqFzt1hmO4dHHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S4+3wyhGXChCiXlvLFzB+NUGRiJMldnvBxvAznIRfOe2XoLZTlHNdVddV8rwPR8ZE4NUv1Has61lGkLbbwW9r8Qhg7j2x9ZBPi148Vq9r78PxFHiog0QJR69BmekHYGPz4bfwton13hY4a45QkijBxkGOyogsnqMXKgj0dufi0bKg+8z6StfxWbZiUs+00D7Rp3tGmP5xG7BLfPf7kJYDAhOLFwDHaIgQTtKt3uLsDZ9+FKxBRp+SPC5ZSyt/ugWb8mm7Gi1+gQ8Czr1EQd7QjU6yq5zaopXHKLQ+PnpwIm+HlScvKybLSKH146OvMCzVm+chgYuph6CRvJoXo3a7WJoJgrOCctUW4YvD2367AVQ3vjD8ZPyIdDOs86eN7kst2TSy98LMZ9X8CFgJDpYnNckK+E47EId3qZJj1KOzEam4RX/PIszvG6U96NnA/2s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:12.0480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76e1369-eaff-4a2c-4fe1-08ded66f1569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs().

Skip their IRQ handler registration in unique-IRQ and combined-IRQ cases.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++++++++-------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4702945b7324..2c33de5128a09 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2344,7 +2344,11 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
-	arm_smmu_gerror_handler(irq, dev);
+	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
+
+	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
+	if (is_kdump_kernel())
+		return ret;
 	return IRQ_WAKE_THREAD;
 }
 
@@ -4887,6 +4891,21 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	arm_smmu_setup_msis(smmu);
 
 	/* Request interrupt lines */
+	irq = smmu->gerr_irq;
+	if (irq) {
+		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
+				       0, "arm-smmu-v3-gerror", smmu);
+		if (ret < 0)
+			dev_warn(smmu->dev, "failed to enable gerror irq\n");
+	} else {
+		dev_warn(smmu->dev,
+			 "no gerr irq - errors will not be reported!\n");
+	}
+
+	/* No EVTQ/PRIQ interrupts in kdump -- queues are disabled */
+	if (is_kdump_kernel())
+		return;
+
 	irq = smmu->evtq.q.irq;
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
@@ -4899,16 +4918,6 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
 	}
 
-	irq = smmu->gerr_irq;
-	if (irq) {
-		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
-		if (ret < 0)
-			dev_warn(smmu->dev, "failed to enable gerror irq\n");
-	} else {
-		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
-	}
-
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
 		irq = smmu->priq.q.irq;
 		if (irq) {
@@ -4929,7 +4938,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -4944,19 +4953,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		/*
 		 * Cavium ThunderX2 implementation doesn't support unique irq
 		 * lines. Use a single irq line for all the SMMUv3 interrupts.
+		 *
+		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
 		 */
-		ret = devm_request_threaded_irq(smmu->dev, irq,
-					arm_smmu_combined_irq_handler,
-					arm_smmu_combined_irq_thread,
-					IRQF_ONESHOT,
-					"arm-smmu-v3-combined-irq", smmu);
+		if (is_kdump_kernel())
+			ret = devm_request_irq(smmu->dev, irq,
+					       arm_smmu_combined_irq_handler, 0,
+					       "arm-smmu-v3-combined-irq",
+					       smmu);
+		else
+			ret = devm_request_threaded_irq(
+				smmu->dev, irq, arm_smmu_combined_irq_handler,
+				arm_smmu_combined_irq_thread, IRQF_ONESHOT,
+				"arm-smmu-v3-combined-irq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+	/* No EVTQ/PRIQ IRQ generation in kdump -- queues are disabled */
+	if (!is_kdump_kernel()) {
+		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
+		if (smmu->features & ARM_SMMU_FEAT_PRI)
+			irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+	}
 
 	/* Enable interrupt generation on the SMMU */
 	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
-- 
2.43.0

