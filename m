Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F23D5C0C;
	Fri, 17 Jul 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305286; cv=fail; b=MtGj826KdKa6qGElyKRpmf04iziNDEcyfEi+UrgWy7H2FZHK+1/A3AngH4qxjVdpu6v5+axqvclENtGv9W0NQCbjs9rQ60tgWfecnINgjKYWPdUjM/FPZ+lSWk9trHVNsP9tjJEizMtw2aSntlqlDO6pAr4ctHu8yx6D5TGmCQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305286; c=relaxed/simple;
	bh=qytaomriOBsZpBgsYyxuyWON8X5jRhbDM7ek7ZYWDXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVzj6v/ha8Sh1El5/jyTMJynv64n2btvR5bJ2wsGwH+OxNjIJhhIgcSHnllON9Dooc7JjoGZVo6BZHoQ63TQIG5367SsaJ2xGStkD83Mw7co78aYAMzZ8+MfBW98MGswk/CFKSy14DonNkebyWyTXXUgtmMSzvB3GUt2kMWtHg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XF8nZWO7; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XF8nZWO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt+297e0eUgOi1vP3hMCw1YSkedUo7UhRlj0q4N8SiShLbZU0njcEjSGu+IPwZNwlxWyuoGmkE1Xo0/Wofzc362bbRLNM+/s8iuteeuV4mPQSLy+1s5sbmfZfGi7OtLYohlBMMmN/dRUUHp5Em5Ko7wDp/8unOz/3EUjwzjQSNKS8AuoQS2SNLuMpSdd3YGN7HIDMqnFc13obQ1fgTH68sb7NwoOg5RFFjznA22A80z63IUPEm02n45Pv0DoZ6kuHy4UoCS+5yhkybXEhN81BAjk0IRAmzLooiZ1jUj6j1U8ZmR6WuPutGTXWeo2OeqfTTOGb/+avDSO/ObKNxmgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iBjMAckTC91FcJfnb6p+FOAA7x87kf+MEvr8T3nZCY=;
 b=MGOnSHo/u5nNz698ZkPCriA4PLz6UhuL8KYReXBJNqSRRJfEG5dP0BCpCPeTUxvtOjoYrDQ/6I/MyBTpp+T2uynaPSWlFt54tTTYBiiZLW54QZpfeF5NpQ8RbTnbFryoxEeJzOZqPzaGmCj10QhX8tM1mW0yyxDtOCCIi5W1eKv7nNyh7xCdhbLqsat0RrLodUduHgvHIOmTW9p4FJFOf8zIQtRZw8+bIBmAoIU5sWO/P8di6xRidZpCHxapBzyUBXFuWVbmsJHPOF8UexjLiZVW60/a441/i/CY9orlsZ6MG0sFPnKKHat1P331/nCXJW6d4mABRr2ukeLuNEveWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iBjMAckTC91FcJfnb6p+FOAA7x87kf+MEvr8T3nZCY=;
 b=XF8nZWO7S1OtHIDT0KBLiBKlJEM8wLWUXb9ZykGNhUPbipN5aEL8TzrZ4E/MCVthq5HKKyTWQFBoVBjM62cyZV5OSTaMy3Gz++7hVX6HNMcRPikJDlsUXtTk8zKNuE++ouI5qRAByDrtVQyKvJDAcDLOJCoW/Xz6QhVloavS/p8=
Received: from DSSP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::7) by
 DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 16:21:19 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::80) by DSSP220CA0014.outlook.office365.com
 (2603:10b6:8:3d3::7) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 16:21:18 +0000
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
Subject: [PATCH 1/4] platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when STB init fails
Date: Fri, 17 Jul 2026 11:20:20 -0500
Message-ID: <20260717162023.956346-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: e3016bcb-b099-4d7a-9f95-08dee41f6ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	69445x6DA/k4A/PlVE14ZAZq2ffrbOgsV85NtrQ/R2CWF+XKpACDq9nVRvOa9c3PV/MUNSkhwqICXcK2ugBGHTZvZXgp6PzcyzQ+clYnOjysMh5ZtBWi2G5fmMw57asb1u/8chkFmbX1ZF45ofrZFswHjJojAr/JlnWS9akOLr0ERRYgSm9zHghCl6ncEHvStIh3WR5sAasYI+pZwwTHo+5r1QiJusnICBRpWc8iztvS388Rn7KlvWC3PbGKPPpc7QjPBrU+HCb6XqNP4sDy4y38ebRZ+a9Gjd+443OYn/fbaEvQjvpqavm7r+lOqlJLk2QjpgQwThcr6ViwXGMykW2ozfldP6Ecf5PQYYGELyJvWeUDcpSaCuHTtXna5GRyHfS3VhNt+6VzIGsq1Rnfbo0GaYlDzk6ywUQlS8zcRsP4DcDznE69UYLjRhohZSMOKVdUqR7T0+TxjoHDZyUhOqoO1NMZOa3upp9zXBRQnYztsHExxrcp2l66qDTevOn3wZ5BRgbzUMrQO4tO9hXBTEyA7R9awX1bx9U8gHZPgsvn7cR8FkzRV9mWzJDJ1g/TdArNHGb58pQKT6Sl27fXoISsyEgsAtk8qMRut0Hd61EXb6LapuWtKFZ9Aqq8EjopQe0jTHH2EM2TCd7n4VvxmR6usuAAy/ukL+OrvaF6Jb4C6IYmKgBIbpfnN72XvWiaFSnlKnVXsrvqv7PpljZL2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p1z7NRPNgsBbKzpbN5XleeUv5I5l+vSLthmmRyhSJDkjfjMJV50VtYZTkFD/JDBB8y0qFTvl8+26AqY2AZ64r/7dWwqmZKsvWt0ksCetuY7UdYzqmUI1b6Z9uoAmfwaXw36PGmGj5n+ho7zJFR1LwpU+T/MzLvhcq2APplGLKy42Wk1DxnueVLRSlRdWbiEvNc7ki42vhByvIY3ZDqe4UMN/RGyccrFZkXioRHERmLYMYd5ezOFW4wMI3dU7kGrg0aw8MMEeNMbShOJ1E9sd61bvudsspIH4p5oH/DYMekgFCL39kL1u+6JRHoTKn1rO+yeQGPMtBdd4pSZ0iPRCGp1QEZay2RI//1OColt7ZFlROJDr0wUmLqDk5GGaMy4PsyBo6Y6LXsj2U+oSP7lhaESaJ61suJkYgCeOsmGkRN6zqqCLCeM4a8uNEARxjrGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:21:18.9174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3016bcb-b099-4d7a-9f95-08dee41f6ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550

amd_pmc_probe() registers the LPS0 s2idle handler with
acpi_register_lps0_dev() and creates the driver's debugfs directory
before calling amd_stb_s2d_init(), which is the last step in probe that
can fail.

When amd_stb_s2d_init() fails (for example the S2D telemetry region
cannot be ioremapped on a long-running system, or the SMU rejects the
S2D setup) the error path only calls pci_dev_put() and returns.  This
leaves amd_pmc_s2idle_dev_ops on the global lps0_s2idle_devops_head list
and leaks the debugfs directory, while the devm-managed resources
backing the handler are torn down.

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
amd_stb_s2d_init() error path.  acpi_unregister_lps0_dev() is safe to
call unconditionally here: it is guarded on the same conditions as
acpi_register_lps0_dev(), which is exactly what amd_pmc_remove() already
relies on.

Assisted-by: Claude:opus
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

