Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BF34CFDD;
	Fri, 18 Sep 2026 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706737; cv=fail; b=uUMSi1CvErukQHJsELQh4zGemCjsCoL0fI68QyyypMDMcCsVScOMkqbYmpGg7fj8aELkPbMD9Q52wRRMerRXo+aodWAZqvKZRVNXQqWOnWS6rLT+vMG8tg/aBMAjmOjt9Ewuw5sgPceCoKW0dfMkwq5u/ZNfHS2ZhlhFB7Os2no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706737; c=relaxed/simple;
	bh=n9VMxM6jl9G+mAy6XqpKLpb+jw8gQH+C2SLhjVOtXpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jODHq5dUyq02DSe77ziO1rsCuyT8CghRx6/JIElbBH/VrqwsG8O81W8YKNaG4EweDJPF5dlB2SNNw81I7QnrYeJ3dcDthvNkr77qt4SidY6XLD47CnAM4rsV8+5p8mOu4K3an5Ev2/kWEgK5D+tkUiQ6MBwNqKeff840Eln0VJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJ1L9I8S; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJ1L9I8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDjEpd9qqQyAEjtyxqtzzsv8ePtKtFuOqmQnS4D7MIOsYGsDUgj5O52Hl+872CXcofLtGwLUvEiLmkLxuVtJcldwkTHzWFnodI6xM418VW+mmx5aXMJbd6skoYkPvieGoYSGCqQNVEl8mm46cHyYAkHYsRsjaJ9TvADdoA2hQJkwOFXMN191/n/seGDeDOuGF8dQ55LGe6gyO7MYrkdAQvKHs+rewLUzwX2oY20QBr0dPF6wAPX61IYWNpIvKtjrh4Epxk8jXDjnJ/6pYRRjmjeFRGm/PwcGnUCbKn5XQvqzX1cU5bU34h1jB3Suhnu0DUDrwg/9AUSUXnfA/ov3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLC9vamC+EYpJa6ViPLNNNDdMjrJNB+owur4k1s9SXY=;
 b=pkcJTNrd9NJB+/iINDvrHiLDo2Fh27eKBwC06ChbMSXW2F1eHcHjyLJ0rGXYoin2YaHRWOg4bSdcJ6esv9iBVHH8E15ttWroYXyRK6gepgGBGTxHE898bC9H/dw7pJN8WXuKk1hap4gKM8fzhMcwGGirdbxIM46AwmOBtH/7Ar21O8CbvaCB5R9U28xqkY/z1Y+tUSCSVStb7PHNZCzfxj7qPkvwMfjHVlXbbW0SPbUXQlRpuRN6DXTUv5FH/tmLvaSTl2YkQHyjMAx/HzEfRP160TXdkQjy56dfk8I4a282XT5wSmp4JIO6jZHjYYe6e8jFINo8YMZYWUAjCCotHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLC9vamC+EYpJa6ViPLNNNDdMjrJNB+owur4k1s9SXY=;
 b=DJ1L9I8S2XpC9d59SGMJHlkrjwQkWKk4Buv3aTL5yssC9r8aUaJEzZ28xF+n51+2XFCtduAHJozvNX4uh8PzV91xEngGzgfVURvSuyCfavTtijnULqUnLhvKcjZitpOPVklYGovsSBV/VQET9IwtH8hyOx7uAiNPaf4vv67Zruk=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 04:45:32 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:303:2a:cafe::81) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 04:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 04:45:31 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 23:45:28 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<arunkod@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] iommu/amd: Fix IRTE allocation when DMA translation is off
Date: Fri, 18 Sep 2026 04:45:15 +0000
Message-ID: <9a0c163409807c709511c335018c9e5b504abbb4.1789705496.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 6303a1f7-c5d7-4f6d-6928-08df153fabe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	18WAfZ5sABdU3aPZ78hysvFHyXLqhTPu2q0kB9muUR9D+U37vZn/g6WVKPquclrMzb1gYSmH2/q3eGfA/pl6p18Z1VPqCM3Jyeui7K994zCOSLk5XASid4sEjmNrlYojB0rpWQ08jLaX2Qny5q+/7pMNjwar3oh7VBAqnf7NuL9KjHABpoxGD9G0g4L7gBQxIP5BmYh8aqpGVsgEklVCdTZEhmFzSxvSMgEDSUfy8AK8+qXfKZvaW7VcZ2cDNqSB+ah9W322N5Y2kAO1pw3xKW6KljLpmgmMwY749Ioh1gAulv03lEpdc5hyGz6AF+6ZO0imE+p570neJV7lAK0Zxasu3mITzNwvrUvQ75Ur9OIqlhmzEmySGEN3dQJD4D//5NwvPN3qphZveI+O3zaNLVeIBNBz6CDf3izTePkh6+8qdh0jG10mefzBpWp5l6SElpEmwyG6bhU/9QbtL7bpZOTTjqNXm4hjy5rs1J1C7IQ1VXU/6idca+R+QdgryqlbOMuThZyDcoH358wCjROWcpZiWF5RdMgKPat/sGXQtdVoHlha0XihfttnfyH3r9a9AGhoT8XP8otXgTTks8hd7I6XbBrzEAlv9wxUwsEReGCqkmWeUHQKJqtyt7XrVndNKX44smu+Lq9szpr6vd2GLBbuyLQG3CyNOiHcRQhvEidQl6TF8OsQ8eDz7tZRzSf4n3Tw5HnKLetVmpx+9fCHHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ThhRgmBjpERyZ1FCOnv32kKJ7bHzR3dq/jxXghBJuWxAEWic/GRKSTMjo4lVLagklepoUEjEBFbhfelFta0zCU5aYIz+ru8mfe6hn8WQs3TSd7YNIrrkMWS5RAFOWNV6e23uB8ym4UcXgKP/uQ28iCdU6469GlXZI0vBeBvvbkfwFuhNzPGHfjdfbNVEEbmnaqAHKUCvILStv/MdvZC6G/ZknJcqVSJXNegnqvAycIVo2aGNSXSDBjRLrd1X9kSbccWF92y1e2lqTDzdZoKvj3x73m8GCym7BmZeO9uQr9n2zvDxEyrEGx8SdwtCjafNZ2mnyvarsBpyw6TPCbCBditQZHFJXG0mbmuO6M2v3EJwG7bZZ7Va5D8pdLs1/LiIVcHPo0OZGr0FGtEJazImz6Ovil2saHzfbJsUBM/CVTfWbRzrxeLEWr7NBCHm/P0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:45:31.9502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6303a1f7-c5d7-4f6d-6928-08df153fabe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

On an emulated IOMMU, DMA translation can be off while interrupt remapping
stays on. Probe path skips DMA setup as intended, but it also skips IRQ
table size setup. Interrupt remapping then fails with "Failed to allocate
IRTE".

Fall through after the PD_MODE_NONE check so the IRQ table size is still
set.

Fixes: 3222b6de5145 ("iommu/amd: Fix error path in amd_iommu_probe_device()")
Cc: stable@vger.kernel.org # 6.19+
Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..77ef2749206a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2531,7 +2531,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
 		iommu_dev = ERR_PTR(-ENODEV);
-		goto out_err;
 	}
 
 	iommu_completion_wait(iommu);
-- 
2.43.0

