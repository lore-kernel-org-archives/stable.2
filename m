Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869F46EF61;
	Tue, 21 Jul 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657905; cv=fail; b=H6BoSuaCMoQF1+iUIRIUL7I38GRTgR2Lsqz3KdUV7L0Z5A70oGhRiOp7g1WazuzZ96L5soOpWsECxFVOCEqdf13XCPmIl21Kg8R5Jd6oliW8vo4lGp/accrgu+99gCWAv2u20lzBkDbfAi3l12JGroNf1xDH4j2PtVKDKjDDeo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657905; c=relaxed/simple;
	bh=yGyZXBPgSYqdf4QO5vV9d8Dh6DxPduvmuJ3PhiLwoz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3p6Iu37BMQCuRQqLBcCH7kOkNgTxdz1+SmahQMj2VAU0iisAPrl1uS++ZvezmUZ7jcERZUJjItAoXXSDyhIWfy0dlVmcm71f7goDyK3p+ZB/hRzavWMCaxiDSgFVtXx5msY7F+NWPphBPuQEy5tJ0yex+szW+suI7Yn6IgAy24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v1sUVgDM; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v1sUVgDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYGzZOw8M5/SX5L7O2mz8ofVuDtfSxWv6y0avxD1M5PgxfL6Bsb5XFQFO0q92JSM7gkiVEKkLgPvmQUZDoV+Kyc6FAnwrB0p/It646fmxmzcz2mw3H3wdQWfamesWsITm1ylPBzag5M6eP4fCrXusyQSEH3E8PHIiRTh6Qx0Htp59LV7ytRG1poEP7MV/cgQMjaDsnrLyeiKwJqJY3UFbjl0ADN176xHMKX8nhO+WrpiP3F3v64tKXrGC63yz8AWUeCjd7XvVYPesBYrm0+XPuNz6V0XQKuGyueR6ezxoNchfdlQ5c/SHEeRCaGhcN30WuIBRuvpdVdBJ07JpDadrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjf2VUlWJ4eNSrJy79PbE67BQdPF0GVE1c/BjBr6XMU=;
 b=rHIn4+UuGX60bVuYNXJ2rf5UEPwXv3ZxINrVhfusLHCIC7MyCbf1+2jDO6ezUcMOJf0oIF3ZLmJRrrDzPZegqIlIGZfJ7KumO+BiXHiDXxV4+D2WQCuhzAAyxPiHVgfVaR6pfc5fvOyoUoHJVkBsJSTjKZkGF0Xbv67Vhq5R2YIkMnvB8f9GCbkpuUvmSgrptA1yH03LWGDXV2d75ezbRmtJ36Z90FdguUdR0vcwBhb2LPuLW0lnd1UtzCJfwyZDHzAGtZ/++Hk59W3LC74sjgFb55tfxpAg6gWj6odkH+PzCkv5mW0Cvt8B0rtf4mIfHxJqz3VfTY7hEzC+UIOZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjf2VUlWJ4eNSrJy79PbE67BQdPF0GVE1c/BjBr6XMU=;
 b=v1sUVgDMAORbsgFzFTOcJRTrkR0oY4uPc6HcZuniiqGUuIXMMOvrnjrJ0bkb/YYol6jHgzr8kS0nW8DMjVzlc7FUJYEUOgjWhVDRmsedcZ6AnfI1ApRJ69H+5GhAF1gxWmftnM/6rfMXbc73YPvgPC4elw1LCXxcQcoMpOuHiVQ=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:18:18 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::47) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 18:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:18:16 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 21 Jul 2026 13:18:07 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS"
	<platform-driver-x86@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Francis De Brabandere <francisdb@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 5/6] platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when STB init fails
Date: Tue, 21 Jul 2026 13:17:55 -0500
Message-ID: <20260721181756.143084-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721181756.143084-1-mario.limonciello@amd.com>
References: <20260721181756.143084-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9726576d-996c-43d2-37e7-08dee7546f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	321BzCNBwb5uXXnfrq8v4DmJylQETmqwTuKUZbYCJ6EYBXu044afQYWfakCiyQgEViuKwYClkZOLC2VOJ74WnrCVYlGxWBmQQ2jo4M4gq/GvewWexWe0J35kPPTHun4Q4VTXVn4GbysLawcRou9lsloDo5tVVsax124moefY+EcoPta6rF/Kzn/d8uR9ftiZxxoFm/WoPc3yUZaTOt31su47gGyuHkT0FdyDuRzr/BwEVcuRPsAQ2qP/aKD+aLtVbaRoBHN7sH3DiK3aKnREE5bsRhvXojMcdLZGOK1FLXXELCbmOAqXk+esE0z7SAOy0sKDsSDFa00o95gRfs6HiwcEDSfrvOE8KxelKVvYP8vmeiIacLJAKeUfRRnjThXz43VzGeb+18bruH75AfB+1Nqlaz8Tu6UQcRQCBkKaZPUKFcoBLEENXVYT35To6o9K2VHmsd3sAT2+THOd54hoj8R3K3ug1PhvbUbwffOqKxxOapuukHDvEc/azd7J3bJakYApfrh8ZtgvmAvKiGLlaF9AAqChxMw+8s15/ACDej2GzMqk/+MvBlY9z4Nf/+RVq+Y7H5h66IqJj6o0J7R6e7/ilT5WmBSXS+xBFWofkY/jgc0PO3p99l5UeJzF88yig8/nkKiK0EFvvUG5DzXOWCdqVFw9IL5l+gqKvgY55vrsvwhLKMlS9WElmAvg81yBKNgYLJbkeaec5lvPh26j5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BSVR7y16Gcva78mPMyQ53zbDsYmIIrJr0QDYlMfWTnqOk6ODz7biCyaK15zRKXC+8WLWQR8rilBkirno6YJEXtr8wnH187QuNn8W+CoZiOdZywWAYvWr6Ho3P153TIrS5aXRxrslRzhNUzMd7G58qQxILGxoyLKrzSU4ApXZG8Iw0F2AjjPSaFCh5db40mzsJwCTjUVHkIHdQ3LBzYYPQ65BqK4VLqQr5pRMtlEi/s1Rmi3UbAOjpvwohzf2Ny3uHWIpPwJJlmk8j1KAycJQcYR/SReRJJANc1hkll/ySoDA1MbR92nnIm8ogXosEcfYlkYJnJjJ+2fqGESfrc459fVp1JPq29QgMcKPyyjgMAfwIELsciLZ0S9h/8aBLu58daxkxTjh55xpO/rwVaI0JvEak1lMQ+n6sepJnOdhpkKMcJHiTIts25+WCjX7o16w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:18:16.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9726576d-996c-43d2-37e7-08dee7546f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

amd_pmc_probe() registers the LPS0 s2idle handler with
acpi_register_lps0_dev() and creates the driver's debugfs directory before
calling amd_stb_s2d_init(), which is the last step in probe that can fail.

When amd_stb_s2d_init() fails (for example the S2D telemetry region cannot
be ioremapped on a long-running system, or the SMU rejects the S2D setup)
the error path only calls pci_dev_put() and returns.  This leaves
amd_pmc_s2idle_dev_ops on the global lps0_s2idle_devops_head list and leaks
the debugfs directory, while the devm-managed resources backing the handler
are torn down.

Reloading the module then walks the corrupted list in
acpi_register_lps0_dev() and hits:

  list_add corruption. next->prev should be prev, but was NULL.
  kernel BUG at lib/list_debug.c:29!
   acpi_register_lps0_dev+0x44/0x80
   amd_pmc_probe+0x224/0x380 [amd_pmc]
   platform_probe+0x67/0x90

Even without a reload, the stale registration means the next s2idle
transition calls into torn-down driver state.

Unwind the debugfs directory and the LPS0 registration on the
amd_stb_s2d_init() error path.  acpi_unregister_lps0_dev() is safe to call
unconditionally here: it is guarded on the same conditions as
acpi_register_lps0_dev(), which is exactly what amd_pmc_remove() already
relies on.

Reported-by: Francis De Brabandere <francisdb@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
Tested-by: Francis De Brabandere <francisdb@gmail.com>
Fixes: 83ad6974dd3b ("platform/x86/amd/pmc: Move STB block into amd_pmc_s2d_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index d50ea62fa2f3a..630a664bdd2f4 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -919,13 +919,17 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	amd_pmc_dbgfs_register(dev);
 	err = amd_stb_s2d_init(dev);
 	if (err)
-		goto err_pci_dev_put;
+		goto err_dbgfs_unregister;
 
 	if (IS_ENABLED(CONFIG_AMD_MP2_STB))
 		amd_mp2_stb_init(dev);
 	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
 
+err_dbgfs_unregister:
+	amd_pmc_dbgfs_unregister(dev);
+	if (IS_ENABLED(CONFIG_SUSPEND))
+		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
 err_pci_dev_put:
 	pci_dev_put(rdev);
 	return err;
-- 
2.43.0

