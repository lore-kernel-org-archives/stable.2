Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B15377AB0;
	Mon, 28 Sep 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619075; cv=fail; b=mpk3HKoAicORArcWOjQ6aNT8CEjAL3iOeR+qRFY+/mOFdsZO5SrUIn//qYWtWtxytlpVg4Usas4WJQUWEWlX2eWLN+50QfiyeQNm04a/GU0Azo89hmgsM/evn04wU5cFtaYW0HLgwBpfANNospQ2sE/B44RFGUb2EVgkiknz5G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619075; c=relaxed/simple;
	bh=zfRDFiO9CJyuS6Si0gHzh5M0zSGy3ic0ywd1DjgzRpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2M7NSZURaBjBy1tzEkmGADS6+OOwJm3HyixyqQS7FVQNhc2nupqz8JNBlY1yCQymxOAT9atkJx6yWSRgV1WXDb/Sln1UBPx+6cDR4d5hoj12RQDNl4G5vaHcWFvkKLhMdn649TEjHH8YmtjHEkCrkSOGlBYTvNUWQJh5jUoWn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZqKlLBKN; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZqKlLBKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMbz981l5Vs88kMuwJLxp0tizdWfmfNRVSuQb0TqrcD+VlOJEnoPcPm7Yh9ws3H5Ak96fQMmQB0WRbJV14exIPPwrsGXXxP17R6I+z/wzaqcvWcER0GWzLvB3nEksGiIJpNVZymm1ZwVNTbd7gPIw1AqrnrAm4isX0I0Fqdntd6livkxjSlE0+6vxQ/HGXv9KrZpMWGcxYst1IiPiykTKdlwFu66B4/SyoktI95GbtvxlMFp5270gWPuU0MWQZPprCN7tEGTwDdg2cGV1Yp/+sPgdgNixCk7A/GTKbvP0sCGNwuP3rrGWWgVMFhzVnwWYmw1LHL84i+pPZQFZ2U/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OF7nwFtLKQDrtpEjpl1NWv2q6VzQue/Xc4CldGe244=;
 b=nx3ch8Fc4eSIstAN4RX5pr/bcdpaH3BM6Qsqmos49SCig3/SYBT9gl7AFuYq0lg35YKqJDZP6mgUSfSLUGXnCglrb4JvzQXDbuysrlxelGl40EOypwt89vRaRjnVUyhuxXqYvwyJirkJkfUGBBESKvITJxm82FIrXrZke2XmnmmsBJ5PREAYS/v6CAYGHLcKeHH6Dd6OM1cCLh3yPYzpyseVRJzbET0ZGD2dpETTi0yxvujlI0t+sUQ07afhCw5PMNvBr1MkJNoO2ksv/xTFtIK10BbYi8nVxHGC995ED2uSbvR0A12YnMVlDTKZ5VbkFS+FebDAPV/QG0zMQDN4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OF7nwFtLKQDrtpEjpl1NWv2q6VzQue/Xc4CldGe244=;
 b=ZqKlLBKNcMmVAG5cQuaYzrZBJr2rb+Ge+c9ON4ZB1hORlcybuVH0Rg9tp3u8HjijBYG3sH8TXy/BoubV/4MvTeOsWyFOcsqsp9wHt0oY0R4RVaFu5vtsBcqaLVzZI8s1+7yXIBUq0MhyyRjBRexRb+ojUEnniW8HiLMiloUh8so=
Received: from BN9PR03CA0865.namprd03.prod.outlook.com (2603:10b6:408:13d::30)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:09:56 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::4) by BN9PR03CA0865.outlook.office365.com
 (2603:10b6:408:13d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 18:09:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 18:09:56 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:09:53 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <bp@alien8.de>, <yazen.ghannam@amd.com>, <tony.luck@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] EDAC/amd64: Mask UMC chip select to the four implemented selects
Date: Mon, 28 Sep 2026 23:39:34 +0530
Message-ID: <20260928180935.472319-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928180935.472319-1-Vishal.Badole@amd.com>
References: <20260928180935.472319-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aafc1d6-7eba-4684-d218-08df1d8bb3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mB9NWn9paUpZ5LvdY3dtQ0FJMcuhC5+kdvW9I57epDhLV9D6OaUNya9iYNUWc/HsxyvIn51XUTvoaf6K+tlvsOcgOvB2int4DgzBvCwJqSK6v2iUc9KRL81CHzwJOY9YNfn2EZCTYSUVgFNhbboU6XEuTfVtsbt3b5tz/Q+upqzEeortxLrWqVpUDKE/ZZ/GTK6QcxvuXa8WVnF/AG5i1kI5kl/Hd4PUoyQUt5WhycudlpQLWGEiyNmoIBD2BGYX/3/EHRwVFKB0zPmqWOyDG67emGiQalHtbh9yU6z8/FEI0NAo3VMnES0HmLr46xzGXiS2vMs4pFyVXOt6uyBVNN1FMlpSQDXxtka8jDzVu1FFv37/crFOblUoow4wqAvJqIwp9HqEG/2ZqAwctGXtOCGIGjUClKWY07JpvhLjhpcMGQ5n7BS3HfIwyC3FD+u5+UrldN6iMeUgBLvED0UK7ML6//UXwm1c2gr5aht3fIMFun/Xoo/RKJgd1+kU/2pqOZr/tsYFK7YlFEkK0/xjn8Zhaqw80JGq9ifcUHyVJIceBwOzZ2ISOBNYzyTOThNe4/V3jGv+4MC/TZNNsQFn2NYfIrQDsy+5K+o9Q8dKtWKnFM6YPNh7eG4F5/k8eVZu3GJz7WL+UsbPyNn62hH3+V3LcTj+WU/xwOujXggfytmZqKWMRQUJja8PUGrQ6cU2hASlQKWWSY2MJNiLvHlpfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H4ncQKTno9SgZ4QIwSDnagitCsKaWQtBS7+4jeXbG40aUwAvcoSdbAiGcXS3FAFM4RTqNykpgZd1lufuPfV/vIchEK+3P+QWUGb7zFXyw78RLkYJH4DjUvWXVC1Gt93IrLQQMO2jGLj0sBxzTRUlNWOFamcDinfH6bzUWtg3o3e0byKkeryOTi+W6rXO8pIIuJx/jiTgzArYOlIMtxWsQdkgtBKNBYwQkLSZtV2dT1cbYijB6aJaaVS74HNx9lEZ7QZoECLlF9Fln+9d2XnGjgoAQauYFGvZOa0oV9X6XU7HYbulZFm+dzDCiES9OcKQHKFGD/Nyt04v5VQ6OFj3rHqyY9PkUj619nnqEOUcOpOfQ/7mOnnTU3wJ8QyXXzE+y7xzHgvi/XYUS1xq/KlOJx1GSX7xh3YxURH6cyo+QW2kb3iH/3XlERrxcBzKRpPd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:09:56.1712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aafc1d6-7eba-4684-d218-08df1d8bb3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

umc_get_err_info() masks the Chip Select from MCA_SYND with 0x7, a
leftover from Zen 1 where the architecture reserved space for up to
eight chip selects. Only four have ever been implemented, and newer
products document this as MCA_SYND_UMC[1:0] = Chip Select.

Since only four csrows are allocated, a syndrome with bit 2 set decodes
to an out-of-range csrow and trips:

  EDAC MC0: INTERNAL ERROR: csrow value is out of range (5 >= 4)

Mask with 0x3 to match the four implemented chip selects.

Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
Cc: <stable@vger.kernel.org>
Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 475235c402e8..ec4cc306b726 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2802,7 +2802,7 @@ static inline void decode_bus_error(int node_id, struct mce *m)
 static void umc_get_err_info(struct mce *m, struct err_info *err)
 {
 	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
-	err->csrow = m->synd & 0x7;
+	err->csrow = m->synd & 0x3;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
-- 
2.34.1

