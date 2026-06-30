Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4023E3163;
	Tue, 30 Jun 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800180; cv=fail; b=RXz9ndhYi/HwlrHNDWgpbn+u2mO1duO63LZMVEwDOUxNcjj1ZDB7lRZs6j6mEmWYFodq5tC1erH59npRtKz+bz8DRDR1IuITjJQIr1qQsY/QKVsnQ4dlaOho5OeZ+65leN5aTsAcI/+2mu84z4FjEgVDZaekfwaRVpGR3oKHStM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800180; c=relaxed/simple;
	bh=dQ72IIOM26ua/npY+KsKn/4pt590EjdWDs4N9tMkxpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgt8ZC1B9rFSpfKcDDb1DY/MUSAW4TxT2zTZsJjEO8PQOWlSimROrdsIii6bFHeLSdGtw88HRWb5HFpvzw1j+OcMGRm4YhruvIrbvXCBpq1LyV7RBVJwDsdFfzvUSCkaxxLyWMK11nt0wyZhklsIsNF28bHHPNgiLhig98m6uPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mc7Scltc; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mc7Scltc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5BVlzfCKYxWVh8kKjH0dwWPiaU+rLrRsJzcUQGL0xrGGoDe8At4r5UZ7kMmvixIm+Zw4YbcPBJcErdilKldq5wK4yhEwlOmq2Ik5FLKPVIKrYVtYq2+mKvY80UfL8EmUdXHms8WUIjKZO71GYjgf5SFKBzSo+97RBF+hUPKSChOzBzOXIjEiuP/X0aH199Zh4eQ2s49Y48D0143UAg/cP8+N/4o/C/OSJugqRtZW2gnF2WRu/XpyvwW2JqpQZ3DN8nhxXOvdb8JTzw5xqDbanfcKHTyo7fEEMsoQP5qgi5JHECQgmUhNwrxZGhb9vJ8e2FrQHCNab/eYYg3pwTJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2jPS9pmc4PfMe1WAXYbaumuUN7eORXdQ73wO8q/3x4=;
 b=dq/PbyOh1oO9HyOXVLMCKfVU6q46SjOkD0d2c2+iRBcDFbgxT6cgHOnFHs0toB58IgWUVix6/eWMuTR7w/sHzxMBDQ449Rshl7SdpOeQQBVYieRRTouV4LkQrTUc92YhaXbceXbA3HDJxye0fqcJ3W58zSX5bf4Vq62R3M4FaLZVXIp5v8+1lR3rkueEBW+7u/WKudG40/bBgydQBOCFUdAvrztI++oja7l1jIlOu5GK05/lDNGgtK4AkoH0Np//u5UI3f+E0o0dPK94HlaOtTA4MUgTlIgUfe9EOtyz6Q7AwfMBMsCT9RGCSEnxl4DweuANAq9M6CXYRy9l4E+NgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2jPS9pmc4PfMe1WAXYbaumuUN7eORXdQ73wO8q/3x4=;
 b=mc7ScltcqJfpdoWYHDemyezPkRfQx2yQ2+i3qOD3hFJ7zZFi1xxg/ygfH38lFJOTaLc0/srMaHPecEYOuJsK+LprP/hROtLKGus5aMU9TPtdPiyCfPI4+fE1JnHYh7X7fqOmgDrja6Rrf0KBhymjGuDxftGd0quhkRFO2grg9N5nVwaeiRfqgtYc6EWOlb3b7kqQQWXMmDcDKSs5Q45g0X0odTqQuqr2oCW5KYXo9hj4EXMMZ4roYYt/5bredBAcJJsitl38NJi54mowZw2M1UMJAJAW1mpKCrwbbtWadscuBsMtvoDIVljif8MVYDbnjpohRdAjVscyj2MVnYH5aQ==
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 06:16:14 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::92) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 06:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Mon, 29 Jun 2026 23:15:37 -0700
Message-ID: <0b035c53cb401acde8244b805d4b6a0312b83708.1782799827.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 6979830a-c1e8-4c5a-511e-08ded66f16da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700016|376014|23010399003|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JSwKZE9V5EVZydMArkB2sFZZsDdM74tmVoz4/nlLBxzg1PORo9uAFsX7RP6QDs637itvDLmac/1kJQc6Wx9Upkc5hMB7yUAmsF6IjbcpABv95v2Zr/EIniqpCKPJjKtfi6X2keibN1Z0mRFQqUWse/xsr7ctcyo0ZpE8MUdNupWndPynh/2QqJ+VpBRdtJSSk3mYzGYYeLde0lesKGhcFzrGqXQLp5gyH6gGvhE+yCmlLEbaA59p2q90aM5tFc2+1RSybFMUtyYcX2Q8sFay5Ueha+C7QJEvDtpNMk2ey/eA+V8CtYtZh3h4jBXXvcLcLFkw1qWMnNvb81KUgaZdHPi3Te8TMtABARwPJcHmh19HLENx7WtDeF5Fin0Rulh7UWImq4aAcc0WNWrDeweFmCatCs8i0/nvvTmPrduq0aYzhi1FUPPLNgglc5FdrTR8dxQ4jbJ7HjR/v74IQB6S6IgpfMJC9CgBA9q42clWbMYq3ZZ5pUap7sLqzdT9zFlCbuT7RUt+vn/IjcNGsLGNs8o3nfmUFTEZYDgyGQDM2vQVot814UADpXrXwtyjf30OZL3NqdsUX2lPBZU50zCrvZ3ZyAZiggnPM3KvG/1d612vIuc9Z0F2HpyrUPhxpvhha0seKHmF4hANr0aEHLWvW61RAG8Tut5vMCwLv7+WebfH7QDhlQuBrnOZ1QJ5n+iEtrruVuhhLfQ4FfmFLqax9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4pIdFHNQ2y91dCp38zoVD3uV/tU4zjtSMra/rjwkFRxOLpx+8zvx7KSUD+9rikZr2NnsrmVEwSPKkXmhZ3NcGpqOX18GfaPyD8GldtdrML2FA5T165y0kJj/eTqu8g7WPPQ3BEqQWFcdaU0P7mnXbO+fCisuBlhS6wWd0maNhC/2QFIRnt05r0BvbxdAyKBjbYmW4ai47JkDbcTRSN+HYn8f+JiVcvW8v9KHZBTj8YqbL63bzO9ybK7I904phgNWx8fnS6bXh3aqGq69u1HBemrxMbWbSqLlMyxGUzuhzoOMNa4je85G48+DwKK6dW1wVL9/inhL5k2PRXGp/cTlpSia0OyfkdVs8d/OFVMl4F2kz2KbSlfVUJVPe6MIgGmyT2GKUShyz6EnpY7ELf+ytIN83MjRMi5oFWY1TyGNhDLtllM17IOX6ng2goP/ThGl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:14.4887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6979830a-c1e8-4c5a-511e-08ded66f16da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Also add some inline comments explaining that.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2c33de5128a09..abcbc9874f252 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5083,21 +5083,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	arm_smmu_cmdq_issue_cmd_with_sync(
 		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
 
-	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	/*
+	 * Event queue
+	 *
+	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
+	 * tables might be corrupted, triggering event spamming.
+	 */
+	if (!is_kdump_kernel()) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
-	/* PRI queue */
-	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+	/*
+	 * PRI queue
+	 *
+	 * Do not enable in a kdump case, as we cannot serve page requests.
+	 */
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
@@ -5130,9 +5144,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
2.43.0

