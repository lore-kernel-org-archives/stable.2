Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE047A882
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556389; cv=fail; b=As28mSUBe9W+wAB7ycmHvDqvYl6zJyR3EmhXqfSfi7DP9qh3pRHRW2+bSaMhlyg9W1/u5PMDP1xIET4V6h75/vjFwoAHbrodht2UfoRhBzsE8fvg2a+vl84cKC67+GwCH1osFjXYgzUh1JYSho6xQjzP9MyZc/1SArSSQjtpyFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556389; c=relaxed/simple;
	bh=MN66zVhM9eXmCM25pnuklb1+GtfBRrywiBrj9+MiUSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoWerS8gw2wwm3wvB+LCPHjCAxbS/LiLwXNtXy6pG072Y70uPjMWReppSm1jlbdFjkBU9LYo3hq/1jVsIT/J+MT+Mb77iz+RtxHqJ9fHrLCBDPJMD3dLgbgVj9z5nk661Hlt767REpP7pmx9cQiTOjHYYLiTEUNmf+V6wH7VplE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0XFSS0u; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0XFSS0u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDpGKXIWlRjdRNfrqILUtSZr9JaezP3x89sDwAaIQSBsqe9uPN67/x5e7Dv4hv2iy1FtNFBVqgStVc3l9LTyMXxlIkUZRgEvR8SrDxVTrdMIkck7OMOrlqLmTjiXk/XLjjv2E9yvkonyLykgwTDvVTPxfbkYolZSp9OJXjkAtPOUMgAJJuZ3IrYvtWKmsba4uJo+eywtYIkkAnhhyXbExrxsE1fPaxIQfuzXUiFm/zC5mYl+vNN6lCkkiWkrE4I49djwCHdChTtU9TNtkg+c68hFRE6V7exbqsoMhmMPY2OaGLmo0YfbZYM/lPr46Tx3nPSwfad61GimtndQLEVuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6rrKn2XCblIO89InuG082BFqvUZ5ZKAg3zPXH/QcMg=;
 b=gGetMYrI7r16SxAmwQZT+T6RbW7J6cncnpeZ5OBA4/k3tDy2BCqPmVpMMb76QZoABctt7jK7a6L27ObZ6IpgYXfJ65XAZ6Gc+sLI8826ilVQca7WYT97pg8JuGvFLz9fMt8CCgVPCkIJCVsv3DH+YOrrKCp+9dxb98+CxVTkX70ryng1GcAhNu4aeNUe0UHP6Ws96ze2lV9K8rCYnjGn0OpLIStUcyCS1PwIReorkKiS8LAXwjZ9W4xyO0+pXVU9MXFcXNiiA6Mo7mr2xvT132biwOjKpEd8jk/YXUKzKloN+RrqNt7ya+G7N1irr4ftTXbfGALthpd1IJFOSvnVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6rrKn2XCblIO89InuG082BFqvUZ5ZKAg3zPXH/QcMg=;
 b=y0XFSS0umJbV1ZInHMotd0YAiGBBFb4P8xxw+P9jyR9FQO/fIGNCCXmejYlXP5IE4pGhZUrFQQ8NKOxmAqHJjZhj3R65Iqv3XStbE19+3/PYPnNAbih76Qog5WvjieWDG6myIVxJqAYOVhJ4rQ9vWpnLKouEmyHTUu+mmty1K1Q=
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 17:39:42 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::66) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 17:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 17:39:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 12:39:40 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 12:39:38 -0500
From: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
To: <git@amd.com>
CC: <srinivas.goud@amd.com>, <sai.krishna.potthuri@amd.com>, "Dileep Kumar
 Nagavarapu" <DileepKumar.Nagavarapu@amd.com>, <stable@vger.kernel.org>,
	"Conall O'Griofa" <conall.ogriofa@amd.com>
Subject: [PATCH v5 01/15] iio: adc: xilinx-xadc: Correct Write edge in CFG
Date: Wed, 12 Aug 2026 23:09:04 +0530
Message-ID: <20260812173918.1156342-2-DileepKumar.Nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812173918.1156342-1-DileepKumar.Nagavarapu@amd.com>
References: <20260812173918.1156342-1-DileepKumar.Nagavarapu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: ec95f215-f412-434a-75ae-08def898b0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xEhyE/SnFhYeMLna7SaAPppNKy0HWE/Tl6jnrBuFA1yfEIr137/g7qdgNpkisdGkVWrPgkNBJqvPwSbWvLrGfvKmYSbr2Jpw9IuZLdnknZLwnqQUNRTAE5INCZbnGiUyV+OTzgFlVFNRUlSEYNtOPlLdwbv86erzMlMQrv8qinaZ+DmXtlv/v5tPhKzYPsdlEXZUzKAGITNtxq1jhOLLa/CETa8n3WzwCWpg2qgbG0+MY7COlPTQ3bzPrwzJPgEcGP2vf6SdZUqzKZOh1vmYPMPmZhAgrT3mOzyjLEddU7Os/A3O61+DHntVWlluUDeiCAs0fCPVnUe271Hoit2JBPr4XjOASFXPv/jkBU15vlzFth7NHnLQyt/0f8OLffFfAdPTnhvr8Vn+ReRZz6RkzqaLUKxNeJTzXBIqDXdIxCuZpuzBgLAPIPMGYXC7LiLJO8awQ9AhsnfHJLuaZ+2lDJw74vayd/s7BqGDVlB1JQo4raCmakWgqFuCZv0JicJjvDEo6ohwrlO1XURBVfL4DGrXk47XOD5lu9m/BfZyzfS9PiRMAdjyXqPzRRYFJFtPAbH9piolETabhdZgXfSWtRkSB4088vdYWPkqW4GacNugiRdOGsvKvQVgoIqhjN5k7fUP+96TZnXw13QgHPsf5UVahDaziKzT7zPTpxk/eOmkQGY40ToNkvVUVOn5qyFl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yr+HuHTbKGD5XOjBtTGQpCb9Wxge510E78SD4Kw/CDrx0zaZXDsEkXNracyIFEwQXPUFbEHgMmIHqYL5u+k5bVHPv6u6azQnlFsHTzAG/n+mPnR+yYM54haHkjG+hWlUEy9nMnbYcNnP8xX/kaPycoKfwXE2WAqL2tMnR5uW1h8p+14WLNRu0I6YeAx96WtWEFvgL3wnnE2qBgBNP+3cIaLwIeJSitfxRGVUlj4E+f/UoG1CAduYCJWbuxbfMAIe56aTUHhixLZCS6JvaoM8v1tMdU6xMisSE73WAs5qzCYbEu5FHHKskc2pcKnisUpaA0ivzeHCXLHF+EpUNoKOk5oFP2kxwQPcorCuTUEv6UmfOz41lbtcG88AuJm9ATJYJqpIgY4e7b6d3liRw8zST8aFipJYRr4xNA8/6kuQzKWsRMQ1mlsRMVK/ibjujV45
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 17:39:41.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec95f215-f412-434a-75ae-08def898b0f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

UG585 states about the PS-XADC interface configuration steps,
REDGE is 1 and WEDGE is 0, this is consistent with the XADCIF_CFG
register default value.

Configure WEDGE to 0 as specified by the TRM.Abnormal
XADC temperature readings observed on Zynq-7000 are no
longer reproducible with the documented setting applied.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index cab66bb8cc1c..bfabe78b66e3 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -390,8 +390,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
-			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+			XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
-- 
2.34.1

