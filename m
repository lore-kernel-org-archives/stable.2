Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D147DD59;
	Mon, 14 Sep 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395486; cv=fail; b=H72J3f3qPQDr9xHhL6WhlhkEYmWP1clJV8hThvOH2HhcP01dXnJqxgJV/Iw02RDsgnmRFuprQpWzCxIW4k+nMhKzhLxyuhrSWQRw3jXA+vE63o2lbHj5HjWbFLamG4Qd/VkVhNE07/QFWNu0beHLCQJxYbfkLBC7twRH45I/Z94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395486; c=relaxed/simple;
	bh=jxY3WU0D7v2mVnvtbEWlIE6mT+EhFPymHZ1Y+8ri6aM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xr9TtDs4e1F7KL+OMTg2FYo90difF4sD9Yf3HqGV+QEhdv5dzOlE4wc9S+Z91NZb8yFWfIZQAzJZHSwiwqCnjiQjIzqah7c2SGVeahuTGxNah9dyWrDwSrzBfrGBYhzZUQpWKGtGzWm4OfMJBJwQYFqZPO7D7umD+FN9Fx08KNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=29D8eHkm; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="29D8eHkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4CCpoq3c0gI6EEuMt2qzpOvhNh/F3RPLq4j3xmPFmYFCxGBBAxFFwTvG678F6VAey1eEtRyNczd4PY5KG0lqbNhc/BnSIvRUhf+z3kOKNdLMgIRwMFoMdJtvb9rgkwt2Oi+OiOm25KJwEKPSWsLvwx6g9od1T81LAlqfjFJRI8kkOZc0NnA6fORlDcfCp/2QKy29tZPCIhPmnVQvuveT++d5ohCNQBwbP7zdT5cAx7aEgd2e0BI5AUwA2UTAbZ0F12b3SPJ0dJ0uzVjD8HOJGJHK+sqnnAYKAHn/iQLGvBReEiIlZSF1+OLdQ1UYZUhMYAOHo36aYVG9wiSj8SF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh1Vj3VI1RSAzumCnAXNuASA0z12Z8GaWWSyOIns5VQ=;
 b=pSJpKkfVYfnON3MoRyYZH6BeArG+Ck6dXTXEXtkfQQuixQe57i17E1xeOyM5oaPiRUIqUkgCl0rjM6PCF1VyDLy7+VWjwoP4uUa1IEWTwVfgFbAbYoWgNKAGfJTKJmowhdUgz0nsuaJYcdI66lUgDSPKvx/2Q7qvIW9XTRktcEAO7W5XVWMgmEeZ/O9T329tVzvCVQmqkKcvGa5RWcFDmPiZBPCWFCCKh3T4ttSvTQDSGLDQliQGgsW68+Tz7+nyPumlW8e+Tg7RzhU/jYNksQIlMMquRwwSqOV/wLZBFv4EldQMHAT/K5+QA9BNHYmBK+WLhs+r/AGCbhFpU/rZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh1Vj3VI1RSAzumCnAXNuASA0z12Z8GaWWSyOIns5VQ=;
 b=29D8eHkmQRVPwpc1j13FsHH7e111uQMXdctfKwQiKB1Ld6PY3JMVTV2V65Gt6FPBWFarB9Uv5dXKc9ET4Snlf/1t0muoY7eRy9CJaZUoqBN23TXK13Hl/QwVxw//yr12DRVCQ3rcEZbOH7TWT7Y3LSZGmBpwUC+AZlzBsY9SGns=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 14:17:57 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::7) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 14:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 14:17:57 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 09:17:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <mario.limonciello@amd.com>
CC: Daniel Gibson <daniel@gibson.sh>, <stable@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH] platform/x86/amd: Stop counting intermediate cycles with metrics table
Date: Mon, 14 Sep 2026 09:17:32 -0500
Message-ID: <20260914141734.2703545-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5077cfee-e51c-4067-3493-08df126af97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|6133799003|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2+qlwPbcZaQ4EmB7GOz1IbNn2Ti9qu3XAX8RB+wdl6hJ4bADu1qBhPh/EbCTuInjsQtd2FUQcuiUzAkcJznRmCWcGQ+2/e0jbiLwVYARwD5KXouG+fGLaYu5FpNBHLn3SW7e0B7/WKgJ4TJkBhOXEjWYqAqQTWM7UB5Vb36tIR0NWmLgM/5jaMAlOomeWU0kJbiVEp5nW2zrd9eDZOMcAtPB+9QOmx0Vd3ENDkOT7032N/z1kAPtz1elxaSl5b6cvvOKS4WdRmKrTzSnzYMIhoyaC7K4hz7MoGBlZlUVKdA73ME2aFVbHofNvwOlB5HWl3EXuZhQj+zS7LeSoBjsl+3su0s0Cf1oMfg+nvqXNCQj9+SnymNkO71my0fPc7lQhNznu948bSCLQ3pdS+n5ii/55aRYt/tPcYKrNWa3XZfR4TXBarDxIU7GikDJPkY+1nsE75P54HYsnh+8Ow2f25dDYEN5Vo9iDntHCGrN0lFLQ7AJrQVjO+etwVO28fyfJIbCTmj7E7vlw7eAFYXlb18lxS9hbj8vtP9viNC2NCtPuPhvcmbRmt7UXRm6xYYIJlnsVOVVpns+aXqpZ+ml3JR5XSb/Eqxakrjq63MTgn9qgxGDC53OdWSA/iG9NnEw/tTO9pL7u0fhEOF6jMrOvqtDzzAI9pGnZLhlAifwzFrU1a0LtzWiDZpCw5DHsuO3sQ7tTBnuU1FGZEC4KOX18g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hvz8V1aU+8SlZg2rj7qwVV47IheB9pBru1dECQzHG/Y8tfMSNKdhUgWldGdEppDcHfjADDHc6C76WqrpbsCyObZEV9mHC+YyHsncJGMza92GIhAVzgzf0RFiCSne0FphZLFtig8+c1BAp11T5xSmd88SST+G0iPCTWnawxIqyxKxZ3PhuMODBmUD+YEPypm63hcnMviXz9t9Lh0lYO4NYoaP5nFjcWpZX1JH0Eefv9MTN32IWyZtTN5Tacy3XJdt+4LYXDMmBdf1QNzssx2gmDPR0KUMgzE4lhaDjTkzJP6LLX7ZGq4V0zF8Gml2UiJpaFQWcw7+R8UqmeCI9TgDYCvGUhlPcUWtyDzJG0KcEHIBSDclmUWjvrdeFG46iJtVf/9fdMjiuuoi59/buRe+uNuS6zecGUmlDOGvhJ0toj70NaUt5j5P9JiHT4SKePvo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:17:57.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5077cfee-e51c-4067-3493-08df126af97d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

The metrics table doesn't increment for all cases that can cause an
intermediate wakeup if the cycle is very fast.  This can make the intent
from commit 9f5595d5f03fd ("platform/x86/amd: pmc: Require at least 2.5
seconds between HW sleep cycles") not work properly.

That commit originally was measured to work properly, but it was
accidental due to a logic error.  The logic error was fixed in
commit 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at
start of cycle") but this now masked the table doesn't always update.

Since that code was introduced, Daniel Gibson added a number of changes
to the logic which includes a state variable introduced in
commit 037f0b03c663a ("platform/x86/amd/pmc: Don't log during
intermediate wakeups").

Utilize that state variable to instead decide if a single sequence has
started.

Cc: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org # 7.1.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
Cc: stable@vger.kernel.org # 6.18.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
Fixes: 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at start of cycle")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6792aa2c61874..e384b56d67559 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -701,19 +701,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
-static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
-{
-	/*
-	 * Starting a new HW sleep cycle right after waking from one
-	 * can cause electrical problems triggering the over voltage protection.
-	 * That is avoided by delaying the next suspend a bit, see also
-	 * https://lore.kernel.org/all/20250414162446.3853194-1-superm1@kernel.org/
-	 */
-	struct smu_metrics table;
-
-	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
-}
-
 static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 {
 	/*
@@ -804,7 +791,7 @@ static void amd_pmc_s2idle_check(void)
 	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 
-	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
+	if (!pdev->is_first_check_after_suspend ||
 	    amd_pmc_want_suspend_delay(pdev))
 		msleep(2500);
 
-- 
2.43.0

