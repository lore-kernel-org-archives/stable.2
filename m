Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289546D0B7;
	Tue, 21 Jul 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657897; cv=fail; b=Heg2Pxpf3creOoF6BmC4RNP5fbvq69Hhf2dDLj3j4Bl+ZbhanbmtcjwaWwfrEda4ZniLMuSupO/2//52Qz+RbjaeNMETgNhALPykHI5skXk3KfBuk/oGwwl78yyu+v0hcFOSuCUlyCNGpTt+hMLViajWT5/RbFhYOBCfFZDdZWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657897; c=relaxed/simple;
	bh=82dYBD1zNO8zLPEdTyDFhzcZQDl1xhSBr2H1B4F1X6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/WpJiKnEVU7Ip2oYZmLSL9e01CIp0K5vIcIMS0cWgw19t13q7qJrfWv7tteHsWMk0lGJJsADI9F35jzDwbU8jrKit0NFLO8oWDR7MFgFogDph5xz6afBcPkFMdbQyQjL0/2To5C80Woft7FfMS9vvI4LQam2+SpGk7jqab66eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rj53NtAh; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rj53NtAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTsnwr1HIz/6hv3K0uLP9s9WSS4tEHGeXWw14S2NtHmnLe4aW9vkLA+/om3tmaIC9kEeYDWis0h1mHExgh0/gQlMt8MF+vVblExEU5+WLdAdcM2/ZrsQf1CNwsz8NAi7x/tVXH3cytSF8XT3IIbA+csoY39yFrKlms8cdziMoJGn7Ffg9EdiGKA60L9jO8tOPY34Rr6h2dZQyCRsueG8vkCrgHwvrTgrS2JAibnOioe+NH9ff3OClBz7g32Pg53WijsEOrDUofMobXf8o2cZeLm/1HTHITuds6l2wvt2cnmx8+rFaxLzDr9OvoD9Ncujrs3XbHNi/yazZ5IstMmzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZbjVO5RMtuUyv9KNJi+VCBRwnYIGGDHEWlDV5rIlBk=;
 b=dC2mH/5mzkCPrFk4NvT532ylWF042MJqEDAUwvzr9I9xidPvh/souTWmuJCPwnXmosVr4sKdkSA+oktepwCetDd8qGnAaGXfsIjugaN4QGXhgm3hRRcpQZ0i8okca0owiQ3mCaV/b32lOUW1jU7Qpo7xp1X1Ze6wWerD3LAlZ+O03VrPIiRyYpCCzMwclKPH9MLLf0/5zbKbxMNNfFtEU840Y1BZlPwUHME9WNyQW2BkCRydfbVVAQmkX1bmrWmKcv5BtGCrQ/yH9vin7BPu81bTusq0ReqYe3NQxURMw83OjAI2Kv9I7KMGxyVVbxX0p2LfSUeKL5jeANUnoLthpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZbjVO5RMtuUyv9KNJi+VCBRwnYIGGDHEWlDV5rIlBk=;
 b=Rj53NtAhFxCqOqEEHfL02GqHnRTE8dt//PqCkcuTMqHqY/0LAUfOhZk+20cHZizp6dHA6XmKWYZQPVFVvrzX+x8Oo4gGzuw58itZUiBRiKaMUPFLr7smROFtPyGVkjjlzg3WZOVGgqVgLD7DPqex7Jwp4pcQ4ueYepFuT3Ufsfo=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:18:11 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::30) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 18:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:18:10 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 21 Jul 2026 13:18:05 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS"
	<platform-driver-x86@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/6] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
Date: Tue, 21 Jul 2026 13:17:51 -0500
Message-ID: <20260721181756.143084-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721181756.143084-1-mario.limonciello@amd.com>
References: <20260721181756.143084-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: d572dc8e-d60e-483b-5530-08dee7546c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	qMr5KeVDXB7H08rnJm4U5deGxbOSBN3CtkR+suvO1ewdB86zxUXpyZlRcwp5INFf/ywET6rrcxY0NAj4aG31hbg1oyr8gRGbsde9UjZBxq2Z8R7AE4qraWE1q74CjX5n2KRobg2Go3GW92Dtb8BXpIb16wsNOEygLbxXWxhCp5Ae1xlM+oumK4Sp3jCb1mFOSzw/8jctyBOZokHh7VngoO/LgiMqPvBB8E6MtmsDOFuMfM9rzaikao5f2yOx8KBP4KNo4E0//PwfuM7F3ylC7f4DjoEaXhG5OZVtQ8iOa0W3SxFxb12Q/GMBrMCfgCEKOlJt8ibhf5ZsQWr243RS0HapjPThjzZiwmre14y0fQQohPBJMm/goSNGlWiIMkCs4axvkJ5fZqnH7kcZRrn0n0w6qsgZxCuz/GKNnS/Ct9V07tPkuUGbz97Ux02t7BhTZoH7YOX7aFMOoUErKR7kFNCqwvVfZg6bFFDpDjjP7Hf4B6M5pPt4gKtDxn461Gnf6YWPIQsqgTlC+1ZOkSwHQzORFgrgPqIvXjAnkj74G2TcVoHiw2qS/uq9hgLjqhaqsCFljBGZo1tLLIEqL7Qfjr87ZB4CQBYxELRhFoYfyrGjyA5KYbGmoAsUUwoGQ9SNnvOTyyFoXYls3JwqLKCfSw5bBrsDZ+j4XkLkvPKu5RHOf8VPoD1LddF1FA51a8/rsmyNzmg20DnTCfl4rkVrGA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n9n48b8fGYHv8HN/CMS3G8oaSFvizjzCs40w2GvCZpi9CLwoZZgMFOzdceRe3lO4eYaD32vu6C/Tl0bO9i7dakOFGFuqwfH2UL5JrMmTrg5uJa0qqVM8BW1eshAAUgJSTZh9pF8zb6nSDsESiF/aAdMB1JKiguRJid16HZP1hwrxMv6aOo75ys01eTqHIbLu9fcS1+Sl3qNIA8HM/gv06DOtA7dfWtMmyIZGZhkL/nrC9aI0/ZsUx9Rb9GE4bu/UYNJyg2IRcdpLMqILFvcj5T7lcJXvouc/ElgCeaC6Q/LowAURRVAQ07XNDf2Md/EDn3CM52jyfqpBClfIi3nSP42lnUtkbmYV2FoKmkM0j5AdGL7Q1sSOxT868cEzg7EkkRokjU+4Ey2TfEbro0EFbIDNl/RUHOQJZxD/yo9VG6htWl5Ul6GCcHY7KVy1+Z2J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:18:10.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d572dc8e-d60e-483b-5530-08dee7546c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

dev->msg_port is switched to MSG_PORT_S2D before issuing the S2D SMU
commands but is only restored to MSG_PORT_PMC on the success path.  The
early "return -EIO" and "return -ENOMEM" leave the port stuck on
MSG_PORT_S2D, so all subsequent SMU communication - including the s2idle
prepare/restore handlers - is directed at the wrong mailbox.

Consolidate the exit path through a single label so the message port is
always restored.

Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Closes: https://lore.kernel.org/platform-driver-x86/54655f38-edf4-e756-e24c-5f4cb041d63c@linux.intel.com/
Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 753d630f3283d..83645c0a8d785 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -289,7 +289,7 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	u32 phys_addr_low, phys_addr_hi;
 	u64 stb_phys_addr;
 	u32 size = 0;
-	int ret;
+	int ret = 0;
 
 	if (!enable_stb)
 		return 0;
@@ -307,8 +307,10 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	dev->msg_port = MSG_PORT_S2D;
 
 	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
-	if (size != S2D_TELEMETRY_BYTES_MAX)
-		return -EIO;
+	if (size != S2D_TELEMETRY_BYTES_MAX) {
+		ret = -EIO;
+		goto out;
+	}
 
 	/* Get DRAM size */
 	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
@@ -321,12 +323,16 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 
 	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
 
-	/* Clear msg_port for other SMU operation */
-	dev->msg_port = MSG_PORT_PMC;
-
 	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
-	if (!dev->stb_virt_addr)
-		return -ENOMEM;
+	if (!dev->stb_virt_addr) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	return 0;
+	ret = 0;
+
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
 }
-- 
2.43.0

