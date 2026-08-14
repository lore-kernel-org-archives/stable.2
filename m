Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D848C3E3;
	Fri, 14 Aug 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729822; cv=fail; b=Fd6r1+NXHrP27cMS6yfkaurK3vtGx0HKC5xSV9gjqm1VKdJ5x06eiiga/k4dtLv2Ojzmarq5fpLQJimxGJ067JHKey5MX3WnbuLobEKhie7YKKC8aXas7S1dmQyfcVK+FYjBPR1Bt8bNCAHLSI50PhFN6L6cJoqFZ1/bV2KeciM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729822; c=relaxed/simple;
	bh=3rPpHAonzGi3PGse3r5UJvDbVVssha8ZXm65aQdqzV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6I7L6TSPyouaTPGOko8dMqRkOqDTkSztrrwA4TapXprDXWE0TRtgc452ED//jcPvltaZiTne5zZsLFOE6E05QD9yyD+xisTxfNnPV+TB/OtPtfuy1Q/yqh9ds8WznPztwm2bDuOpvSrQENBOB0TIHzxMWrRIm0XyDp9oVnddXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlTRiTo8; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlTRiTo8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8xXZ0xcoAenoWYmDS6N4xZSli1oDO8KITuxkvuxW/XdZs1MpXwwJBXkhQtbvmp7qyHIc9LENzTZNr96SDgSm02WGL0bdJDFRjGyYmmGB8Bmzdjp/Pm0/I6W2Z37XUufx8SExh3tYHM/m2kGqYttjBV0P2rjgfGBBOaQB2zTgt45i89u02Q1Kz59PK8I3jDzUtkj1BgWwwam8N4J3RO3+fI5LaTZkjdj+n5punTUwndyH2wONqF8pj0aY1eO2Tgif9VoDqSdkL9gKIhDzNm1yJCeFnKyVP+HWakREblPNkCGnzlNqVFiqTFavkZIGI2vyWsTVNUWZe8pKZuolzUGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xWuEXp9UOgGNqYbeKlWSEHqTSJ0bwAd4tPbFWCZV28=;
 b=RCoe8LCEadO3GsXQ7USpuBOxoerk9+tH/RJL34wQCYPWM05na7hAZE3JROzwcA6AMrZz2eGtb3cl1VQYf7VeKe5wt+IqHpqsWzjU8BSwkkGRn2LFLVJ9t4xG76ExpxpkUh9DeCKhJcea9xjLtPBssyIOvED2e3+ykd4hT2vrrTeau2wyav7QkcwL6xhB7fvtwX99FHfN+zZh85FvA9Tf7slSJgc8+zAI94ZmSfdUOhQJ1zLZErvI991/T/yp/dsJ/vCm9twfoiVMwNFoP6Xl5HFVn/K7/8EB+PxDwSRIx0XsIZ75+bnaPL2WmLskr2pHzDZYxg1jAT311RJOXJBS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xWuEXp9UOgGNqYbeKlWSEHqTSJ0bwAd4tPbFWCZV28=;
 b=NlTRiTo8LLfnA6l7HFSrnL+eLnPMpphivFUtaUUqcJKRd71RR8X53AnjurRLCwVk8mrUNCTyX4ovTT+HXVyPFX6XjffYPH+LR54U1u2HfOSDxvvQMYAe/5QdChDfvny19HqASt5wbo1xDpxKJ9WhY8dq9JsNU12Kicvqlldu1x4=
Received: from DSSP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::12) by
 LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:50:10 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::8f) by DSSP220CA0012.outlook.office365.com
 (2603:10b6:8:3d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 17:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:50:10 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:50:02 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Petr Tesarik
	<ptesarik@suse.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen
	<zide.chen@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 3/3] perf/x86/amd: Implement x86_pmu::print_debug
Date: Fri, 14 Aug 2026 23:18:08 +0530
Message-ID: <bbd6778b5494ac5e256479d4724823086a03c701.1786728929.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786728929.git.sandipan.das@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a70de3-d3e2-418d-c96f-08defa2c7c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|10067099003|56012099006|6133799003|11063799006|5023799004|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	KdBPLgg8irVeLFGRGv8Dm1pBkBmU+VXC60fBcUjCm+YwHWvnMTgLlRrDyLSl5XqZoxwYZfDjsFdXaj4EnBBK62raIs5i5oEXIyxHZJmsyDiyl0aKddnZURsFo6nwUGaZH5KTPM9EAlSB2Ix433mxaQyaif0gRpMGRAPb88mg/GcNHzQyuYM/QqoyHJ1CSm+cl2bJpm4zIFV6ZBCRqjJrR1c/X5Y0pMqlloC0Ky6CHvyegskxZeiC4ZcA0+ut4fOazv7wNXNJN184hjp1b96PnnwDVQ2uETY7N1XFAUDj/PF7ouf8upLeUJYeuxRlg1CAI44Ic5jWi1k9c07+BINgOXAIfsgbIVvy95CwEGi9M2g4er7AZ7KXPFgTSFBBBE8nZhsBkY/PIPxwwnRmmV95pgZJg0QPEW01MFRmKce8lgrjrfDzvkSSw/2Kz+bT7cxAVRT7YJhqUUPtvWB5OiS5b8pgvcpJA6nDHNgvAaKvh6GLTJGtpI2WKIgE/wLayAobqGli3Yxfpi6QGlhpKKS0aZHkadGpEx1e8DwbmIJ+3/qGICy9TeOn8jCZUgIh3exG4tCKmPUi/HUpMocZp+GkG5gJwS9+D9SuXt/L0iy4JpR32iy798qB9l7Oj7JCAgDwuP/B8NFMgpY/MfJvM5aE85p9cBCXxaurt2K7adIgr8+LWOjq9uuTRh0oxNUiAy1H8yrmcaf7n81ONcQ8SMjZYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T0AQT3Au7X3ZfZcyAhDE8pkWRV9xpjQ759bRmqJmI/fXg1fVTJLwoYA4xm8Flt/aIUfYENLNs11NU2pCfReWOfmwpvNktKRosAfNqSif+G0T5uAtPrkl1JrJny1vQmXroUsvNKPr3p7fvH0aAxpWQAP/TBmSqh8mTGFSFbQZXDcy8Dc4+QuROrUmkw6LzFJ97oXbWo40EM5sDKDflRxpmPh/rZ/ASnqh9VUVlnQw7Uac+/fog7KvFkSIgHFJHNUbeFCOUOEqgC5lqQwmGYN24PDpyrdpe4BH03C2kAdjwomPlQ+udrb7XgWSWoDSkN11XNEGsEoSv0IWUEVZfHoR4jO9RDBSD14qJ0MI7EtXTaXAPjMNtFeciqKk/VKD/fZsa2T7Xs8h6OaW+I7vSfHFu8qfMC4E1jJGQnkN7v4+m2owgUsKetq9kJKr233KJxEP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:50:10.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a70de3-d3e2-418d-c96f-08defa2c7c66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

Implement x86_pmu::print_debug for PerfMonV2 capable processors to dump
MSR_AMD64_PERF_CNTR_GLOBAL_{CTL,STATUS}, plus MSR_AMD_DBG_EXTN_CFG if
LBR Extension Version 2 is available. Chain into x86_pmu_print_debug()
afterwards to dump the event selectors and counters.

MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_{CLR,SET} are left out since they are
write-only.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Petr Tesarik <ptesarik@suse.com>
Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
Tested-by: Petr Tesarik <ptesarik@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a787409f5a62..ecd648af81f7 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -841,6 +841,25 @@ static void amd_pmu_v2_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
+static void amd_pmu_v2_print_debug(int cpu)
+{
+	u64 ctrl, status, debugextn;
+
+	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctrl);
+	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_V2)) {
+		rdmsrq(MSR_AMD_DBG_EXTN_CFG, debugextn);
+		pr_info("CPU#%d: debugextn:  %016llx\n", cpu, debugextn);
+	}
+
+	x86_pmu_print_debug(cpu);
+}
+
 DEFINE_STATIC_CALL_NULL(amd_pmu_branch_add, *x86_pmu.add);
 
 static void amd_pmu_add_event(struct perf_event *event)
@@ -1452,6 +1471,7 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
 		x86_pmu.enable = amd_pmu_v2_enable_event;
 		x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
+		x86_pmu.print_debug = amd_pmu_v2_print_debug;
 		static_call_update(amd_pmu_test_overflow, amd_pmu_test_overflow_status);
 	}
 
-- 
2.53.0

