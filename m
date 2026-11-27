Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780635;
	b=oj/V54IH++4YsA8WBEMV9zlqe8Kgv95mtWvG2wDV8r74bvCOd2Ct0j/hramBb1GHeTSA
	 PSlU0Ahf4BTOGEReTrXN8L78tWBSyQwNmDa419TLJC9/eneUib8T8Bphw3rsjLgv2Hd+L
	 8VPdliQiAz/G3XkAKacHR4E6L5yHEZa+oQL24et9TxQA5JX5Xnb14tfCyFdDqcOMUP4ol
	 5j2XzsFiEm+ikhxFSccuzV/UKlVBkBHKmZN2JzMUI/bC1Q+gLPRhl3t5+7oanK+xv2amd
	 4WbPvQZM/qrE582ZSewgIc7MYqV9hYDVCty4d8pn+GIMjO0kNiUa9AU7cee+9SFxsTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780635;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zNl0gzAuMM3PWdN2ADU4YVC68uMmFQ8b87V24Ksny+8=;
	b=rar4+kh6tN0ofkTNL+8kz8mAGMpXcf0RyXaeupfN1NlpJGojqilUCOaFgWhGSsm1mvzf
	 u8A20NJcPNLDxqoZ8VbJy8S+I13T2n+PYvh2cpQy3bYaZkibmx6BHbuLXCD90cke1IaWh
	 efdh7Y9c+HbNR0afB0/IFY2triug/1lIYWQgXF2RGaec2eBaPktVRk0edYBX1SSms+jwa
	 GtC6CyCU0teR5bIYMHnDje5+6QQFWzm61lStkHo0KJrVsbKEG8/ZVN5ivXF4Cz8KWf2T5
	 L1Bq2guZRof0YGUZu5A4O76o0DTXRp+bJx82uLk0ER6+alLXsEyuqhgQ0JDu8Ai6YCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vDPoVoc9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3A606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vDPoVoc9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqNzDU2Lg4O81wbSeochmcH2r14IWc0OJehleq0VVOtFWnOfAeHwaQHd15mEZtwWWzJmHgBV09niAYCi+44fMmTiHTRPHlu7jtmRF5gXLkLq2B78gEdDsMJpY1k+xhRdohuvknGF2Bo3FYSn966HfHlMOCWb3e+N9g3ZZhC5f5tynx/TkqGdEhzBNGnPdva5QpXKCQURXg6TZ2BXQRr0ADe+ZMCI8mIvpXrEhVrvVijoUIDz4DG7VMmgBniTiqkbn7odll7qNHIdG8+BoR7yplqPMH52bHAcrwGF3HtzrBtxm1zrj1n/NtjKvyBjjibdqz9k9RdenoT0VGGZ/qPTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNl0gzAuMM3PWdN2ADU4YVC68uMmFQ8b87V24Ksny+8=;
 b=yhBAaug74k/D39Bt059URc/873BdU738y+CV8P3UEUBCKdc/AJPrkUnK2LZpOOtb/AI7m5dqz6XK0X4SScjtfK0AFeZqFUT5jnA0eol71/qx8Iim0oDSz2xyrUYWjUxhoZbr8kCs8LJve1sqQcwGmo0mHTrixtmbL/NhPACc/yz1gXat0YEPSFJcVFldGPQzuLsnYT/i1B+/3Wo3w9uMlBzq2ojLB9kmaxtM9TVfCN2wAw3S+/yfwv/lNrPAP9Gc3NsFrxM8bsdqYjuWA7IvzwgFx8zghG+DyyHxbJ04qmxF92BsTJKe54xt3J6O3FCLsEAujAvJtE2jtkCeuEKJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNl0gzAuMM3PWdN2ADU4YVC68uMmFQ8b87V24Ksny+8=;
 b=vDPoVoc9eLZ7KSY/9/vbVnZdIcAUEbkkKirZvH6dV1qVuEb+xRaemVQovvvAsvIj0f83u0cR0ENI1UhoV2mR/iipOWbnCtqVhe63i0QGdizO1ZPnFz/0nkVt/51+kyVHfqQpym1yIxQB6ycg66S2uwpbj5UONM+epcwIjqGdito=
Received: from CY8PR02CA0011.namprd02.prod.outlook.com (2603:10b6:930:4d::6)
 by LY0PR12MB748257.namprd12.prod.outlook.com (2603:10b6:404:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:57:10 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::8c) by CY8PR02CA0011.outlook.office365.com
 (2603:10b6:930:4d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:57:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:57:10 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:57:02 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>, <stable@vger.kernel.org>, Santosh Shukla
	<santosh.shukla@amd.com>
Subject: [PATCH v2 05/12] iommu/amd: Keep the GCR3 table while PASIDs are attached
Date: Fri, 27 Nov 2026 11:54:40 +0000
Message-ID: <20261127115447.209792-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|LY0PR12MB748257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1506bd40-c53c-491f-f0a1-08df4c7d9141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|5023799004|261009223027099003|18002099003|22082099003|260925021311599003|260925021911599003|260925022911599003|10067099003|56012099006|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	2CRfTWXYxQDOK/m0cdk9KWxTKC7HriPjCKDJatI8FPlXPmufQ/G3Lriyroc+9Hx4Ul2af5XcZVboRKfczF69XSBMbCTJXy+HYUox9fJm7bX6swkpjVIqdvlcPmz7VWCZYZ6BFyzcpoFRc05zkE8M06n7ipQdN6Vir0qZoyo1HejqA9ZmFqe77A7IGS539wv7Qz62GVl7jtev6rVoUc8Ccv5FNPLsy7oktkRKnBhDQSNiPzGBDKGaUV8h2CfbmFXOkT42vPr9pBz/Vf5XItlWKe2L3ztjwKyCYiY5v39YmW/YlaKO8TLddIqKlwYNZFtHd2RLsPhUBoMRPjZS8gu6cLbqYtgrbOaL6ACAHxIJe/RNIgXQrHY3UNuNlt60Fcm1a8cGL1Kinm6ZfXeS3ipJdBknH+u+xLmZZQ+RdDVx6meUbyeI+fAnzzcUFdAgTfu6xz81XNKDTQU1goHIO0lwmLvmA0K2IEhC4ZhGdYTddJE3dcedNOZYOnVXhUFOOGvKLJuE59bq8x5/Bj53xaSoD+c4KRxYuAZO8RRloTyiwvlqtg3aQUMD6J4EstHX/o5e7ryHWh172mVeVyNVWY8/zCR0LvWBC6KIPGc9YJSkIbRCzTwfF7iybLS4KZeqmXcAbyXhv4kNrpE0h211koMcqxD9+goRyvkmClALP2wH66jBlfI0pdfQ722f+HQS9hBFGCQK5jlz6hnIDdxjeI2wHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(5023799004)(261009223027099003)(18002099003)(22082099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iumgcrJ3qjPVh3fJH7LgYWusFrJHVfk8RuXgYOBuga1Mnjv2s9xKtR7cgGLzwTLAfbl86QJuUlFHY4thYOQ2RUPDowK/iDqi1naSQSSqQeY76x4YBE89ZM+WbsYrNRSz12oSona/0VQSvFUFzvfJ5H0nFUE/f9ci+nqiVRkI8NGyBQDm6QkqaGJNqSoWzcRmais29J5R7W3+ZOB/KqvDmmQ1QMuSXxPdP+fXacIjg9V0/LN6Gor+TZUWduAxi06HJtc0rEQlYI5iYi0qC31AKrljrZ5SdGJRrpi4x3f0vwlMAP/6a/EQDtyKiL8FYwLQyTCWzBR7XRXgv8dsRapuA/moefJ77FGtdp0NAB77Q3mfwuFsErU75c1xKwzXcyA1kE+1FWJ4qhjoUPU0SR3fU8OTX913uagKsMHVlO6iucvmiXsaReB8oFMrbuKhAnnT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:57:10.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1506bd40-c53c-491f-f0a1-08df4c7d9141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB748257

pci_dev_reset_iommu_prepare() attaches the blocked domain before clearing
the device's PASIDs. detach_device() frees the GCR3 table during that
transition, so a later amd_iommu_clear_gcr3() dereferences a NULL root.

Do not free the GCR3 table while it still has attached PASIDs. The RID
GCR3[0] entry is still cleared before detach, and setup_gcr3_table()
reuses the retained table on re-attach. Free it from
amd_iommu_release_device() instead, after the blocked-domain attach has
cleared the DTE.

Fixes: c9e8701132e6 ("iommu/amd: Setup GCR3 table in advance if domain is SVA capable")
Cc: stable@vger.kernel.org
Reported-by: Santosh Shukla <santosh.shukla@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0a1722110934..9c32dcb921f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1949,12 +1949,12 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	int domid;
 
+	if (gcr3_info->gcr3_tbl)
+		return 0;
+
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	if (gcr3_info->gcr3_tbl)
-		return -EBUSY;
-
 	/* Allocate per device domain ID */
 	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
@@ -2247,7 +2247,7 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
 	if (pdom_is_v2_pgtbl_mode(pdom))
 		update_gcr3(dev_data, 0, 0, false);
 
-	if (gcr3_info->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl == NULL || gcr3_info->pasid_cnt)
 		return;
 
 	free_gcr3_table(gcr3_info);
@@ -2523,6 +2523,21 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	return iommu_dev;
 }
 
+static void amd_iommu_release_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	/*
+	 * A device that requires direct mappings is released to the identity
+	 * domain, whose DTE can still point at the GCR3 table. Keep the table
+	 * in that case; a later probe reuses it.
+	 */
+	if (dev_data->domain)
+		return;
+
+	destroy_gcr3_table(dev_data, NULL);
+}
+
 static struct iommu_group *amd_iommu_device_group(struct device *dev)
 {
 	if (dev_is_pci(dev))
@@ -3227,6 +3242,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
+	.release_device = amd_iommu_release_device,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
-- 
2.31.1

