Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F9429CCA;
	Fri, 17 Jul 2026 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305292; cv=fail; b=STCjuDxVACZ5rCRI6Q6xJsKozhQncPD5ktJgGrlHeY5e25wbsF9NXw4YljXn45UJpIZG0zXgAKoEXb4COTLDAxDXn5IjXURhfCVvnfw7Ew2DcvI7a1UXhwLjIcbVixZnRsI04Hka3qpjTKCOpVFDxCFjphdfS1aAZkKx/IEN0b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305292; c=relaxed/simple;
	bh=ZeiXP2klQS/hPOl6dx2GwlEE82P0lHTpvK/88tlNh4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deOuoGM+heUOCXDq1Cz124hFkxozp6qmYG+7IJkakkkL3oDSd6iBxpvbxmtDrL50iFwaetzgMFjqZR4/5o5JzVq+Yxyq6lRp6Y5VEq3QB5QCaAIYlKYgTzhQ9m1K5fKuhEz8uDikQbj6tuWpP7oy06c564QPP6XqVsrv6xHs6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STxkl/PO; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STxkl/PO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+p6WXBb8k6D99plXjnp7tfXLY5VjzHCIa9TjLMPvwJtQBU/jhaknCZ1sx7+177H1639Sxmq1RpXDyCj/lfIMZ3P5Rbw2a+CiWGWoCpkO+g+dQFGrwkBq9Olfldh+VASqwe9J1PY2NkdVXuchPeAPxo5hxu4F9m1nyw1VXmBJBysQr/eDUOKDEVeRuM/+f5Ml6xNgwuJOP4KLWeRoOf9yFN+3kyv1qnQTsYi4YRUYgMj9y7oUws1FrmvxEoN9NN7UC5SRI02AMKir+TE/LM86YkoqXUE5k0JkLd2BRxeLJEREUimYt6duQHskMeW1HkEkSB1iK0+eLLelRGannDDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKpNyvGiusIqZgi9DcCmmFbs5w0a8YDmT58BKS3XVnM=;
 b=gxzDrSR8+ypHg5xRVggTFl6g1wDXUwbUgDv70v2p7Cru5pIHKOL5yo330us3b0/g5I9LkoD7briFZOqwKDi0B9ScAFiQqzEBgmuEkl9o43An12hYnQS6Cl2nGq55FI+uh63DYR28PKq8CIVIax0c3dIwX5fiZZ0sWaKRoefMPLqPMBLhzCwu40iK0hZxqKaqNLjcbtzWESju90o89XbFdNehyr5ZR522Pfv6hCmZVmI7VD0jGyd46Y6gPLqy5j4ij8g/ECaXYjHJdq2XZsu41W65u5ZiLdLopeSO060fWYv7E8o8CncnERny+JPirFcl3v7iAJC3p3yZ/by/d4qABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKpNyvGiusIqZgi9DcCmmFbs5w0a8YDmT58BKS3XVnM=;
 b=STxkl/PORTjZcboCqgmP+d1PHwiar5mqS6yKMYZDWSbeeSyqBUxkW3svdGF7zhBHWmAOoxijJMk8Tbyt1PK3uiMo87SIyLOEJJJK4F6psX9AEhQT8paxosD1lTv4hHWCkPYalRRbdggFKjFUNRjNEDUWsYoxiA8/K2DPqXshJUc=
Received: from DSSP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::12) by
 PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 16:21:19 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::4c) by DSSP220CA0012.outlook.office365.com
 (2603:10b6:8:3d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 16:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 16:21:19 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 11:21:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS"
	<platform-driver-x86@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Francis De Brabandere <francisdb@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/4] platform/x86/amd/pmc: Fix error handling in amd_stb_s2d_init()
Date: Fri, 17 Jul 2026 11:20:21 -0500
Message-ID: <20260717162023.956346-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717162023.956346-1-mario.limonciello@amd.com>
References: <20260717162023.956346-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0588c573-2bd4-4901-2a4b-08dee41f6f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|56012099006|11063799006|3023799007|13003099007|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+V0v8aEkDwh9XKR0H4vLF9+UNzpNC9Rt86QSCIHN2ufWdSJoPzOWjsLJCVqWZ4XDgO24mxUEph5iyjUmkFdxI1Ksb0i6bnzdaaF3x2UOO7sVMovimLYncLAcadoD75J6yFnr/v0KJsag2TV11j7biy506Eb3U0yGaeoCba7ahC9jI/I3VwsKc8yBYqn6XcThhwR3Zuz3Hoqy9aemMcYlaiFbS/kgFZ0mIZqUJ4b7nvNu5PLndZT/Mssv/xpcsFDmr7SeFvjuGDId0FWgnn6rlXRO9BdEzr9UyH8edZF5mMSfFSR1UcHzEgUbvvvE5/OaFQfuLI13zCqdnyU8pff9HuhiDN0LX0VQh4/t51D1Or0AmYX59cxLvoSQrhe+mMDolOI+Qpd9TD0rS4RDEsRz2FKdT2VUQg884gj2whn7fRW6zMS6QS8htYNMcqpzrJy/Nclvb3wqaX4HN3Xo1UqfytiNQKB3cPrp9b+ziqPBRKCnlLTEm2OdToVyYlK6Q2NMK6z7ndA3lYFX87YP07lnzB97t2l2zmzqBKISFUDJIY5oiLxHhhNXR7XMP5hlHalXYCw9IuqKkpxr4792Rvwl6LF7a1kbTrjYlGhvktgea7BwUw+Jt0z8TPcRuLPLdhekMZWNrHxxcfZQ4tEYmwEZLw+Ctlz9IWKse9RGVR/yxXhjp6oaznAsmtYQ25GwTR/hVhbSt1molZJQ5e8LiIj6GA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(3023799007)(13003099007)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OBVPdBmar1zWLXHUQq1gcVY+aIdyz0SboMhm3QswfdzThuyymE99NUWViwvvoK2mOX2hOGTv1HQ9i4ugTcs+Xt3NY27Aj1meFZwy4I7m+FrZy5u6cgIYZ3/uLzTMIDZR7OjLVt3McY25GKl+GJl+Yvm4oh22nVn2qHJdr0+dGCPcA6oA2DoIET5xawnUK8YwoGRLTan41pZIak2LgHis4ktAZQM4xZrdYi1gyuQ/ZxXN9xaccsTSu20W+E4JwiaH5SHo42lz2LLp4bsCiWkbnOpgoAL8hc1DuiN+AHs5ICCzXytgeVpvbU0fmUpn7C6M57roFye/0OHgyqn5Qt0XoPKn/yBDzQoqb1xtbR//K8bRA0VI9do1Gb0YXoWRTCZUYeaEkdbs2gTapE37OznZAyUD19y3Ac0J0Xrhmex7yvh+rJ4hkIwWNCJD1HHYSNEg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:21:19.3142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0588c573-2bd4-4901-2a4b-08dee41f6f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019

amd_stb_s2d_init() has two problems on its error paths:

 - The return value of the S2D_TELEMETRY_SIZE SMU command is discarded.
   When the SMU refuses the command (e.g. "SMU cmd failed. err: 0xff")
   the failure is only noticed indirectly through the telemetry size
   check and reported as -EIO, masking the real error.

 - dev->msg_port is switched to MSG_PORT_S2D before issuing the S2D SMU
   commands but is only restored to MSG_PORT_PMC on the success path.
   The early "return -EIO" leaves the port stuck on MSG_PORT_S2D, so all
   subsequent SMU communication - including the s2idle prepare/restore
   handlers - is directed at the wrong mailbox.

Consolidate the exit path through a single label so the message port is
always restored, and propagate the SMU command error directly instead of
inferring it from the size.

Assisted-by: Claude:opus
Reported-by: Francis De Brabandere <francisdb@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
Tested-by: Francis De Brabandere <francisdb@gmail.com>
Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 753d630f3283d..6a048cb2605ec 100644
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
@@ -306,13 +306,17 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = MSG_PORT_S2D;
 
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
-	if (size != S2D_TELEMETRY_BYTES_MAX)
-		return -EIO;
+	ret = amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
+	if (size != S2D_TELEMETRY_BYTES_MAX) {
+		ret = -EIO;
+		goto out;
+	}
 
-	/* Get DRAM size */
-	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
-	if (ret || !dev->dram_size)
+	/* Get DRAM size; fall back to the default if the query fails */
+	if (amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true) ||
+	    !dev->dram_size)
 		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
 
 	/* Get STB DRAM address */
@@ -321,12 +325,12 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 
 	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
 
-	/* Clear msg_port for other SMU operation */
-	dev->msg_port = MSG_PORT_PMC;
-
 	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
 	if (!dev->stb_virt_addr)
-		return -ENOMEM;
+		ret = -ENOMEM;
 
-	return 0;
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
 }
-- 
2.43.0

