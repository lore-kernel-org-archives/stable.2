Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79D489894;
	Fri, 14 Aug 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729798; cv=fail; b=QIjEXm7mxMFwO3a/+2BSscxGJzmmXhxEUQdPeAiQRRwOEh1G94xJPRIn1n7PsdQEOZwwFiutuKh12VNBfejImMHrgkgNEi5xtGmJVZg4ZVdRofrXtP3ozwZeiqjHWojkOT1d/YXmZXK25rT4SKNG6WiGDKhbaCjmINpI95gss+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729798; c=relaxed/simple;
	bh=7hiWpmxLEpRzryTa+y1Yc4FXCABftTKIC79kFKB345k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwytAEh+RAOG5+7S94393fDYTmJvO75TyLG6OInx2Mh9SZXA2yRpQyDWH9kChAQwQzEWRUnEpy8m8esfBbhkbYZ3/x1TScfQmM/iiXcBYjJvxAdBEAxxfaIDyt4d/8wNFKR1JEeFecLF6vGtWpzHOErYMa0t3ld04eIFURt2yAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ji1oK8pd; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ji1oK8pd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYgSnYh/sZzc6u2V2zzBGRcVZHIMlrwMTeBBHBmNjBeDHyhWCPELI/XxFpGthPivFKt5Px/zArY8hzi9y2G3IGHyWjL4ymY6dMN1gCqML5r2U+iUfh2XGiMh/DN0bpXFipXO+m+6AEQq6EGVeVP/9Jrj/M2KJUiQGj+2VlN13dqQnw/VzlNd5aN8BAf5dtVaDTECTLH8ghQYfDBaQRDtB4gCfxlbDSphUgJOAz5TgJ9tboWnazjHVz/9MK2nBVO5RWyjWY0kl9UwIYv2CX7TiPb5BO1BWlM5i+EgivMmGaXOjia7CCps8w0VQ5//wQWODCbHnk4OGCe7ZF9Nyl65mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcwL7q30kVUDpUK8MmIP9skD/RaOel6rO6UeebnHPsQ=;
 b=VhBSJ7iAKIalSAk5Wg6sJM50+k6IEw/PXdvjQyujzqjqMqvT6BNkDd0nTEQIPBDOwyXARv63AtbvLqt5V+7DNZmajVW0/Ao5VXcC6q+KPfhMKlm8wgDTdK0SgQYyeBpxmUpSFrI3GcEdPrv/z9pk0ypuHugDRr/NIZru3osvly6DTK7jl5w/HrBQ2/mwWVohFUy0Qf3MNiwp6m17yxyyArDZ1ltL7ckyL5lC5fYwXwwt1O8n2lRYUv+9FJ4CH8EBYmruo3AHgBrDAYco5Dcn79aypMDTRKRjEOIV4C6zj1YlEY6GRXa0Tww8YBXaPvTj6nIBZafvIqoowpMvuyvYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcwL7q30kVUDpUK8MmIP9skD/RaOel6rO6UeebnHPsQ=;
 b=Ji1oK8pdBU0MP3J8Av8/IYiuyoZu/MeSAu9dMX2qg/c6OZ2lh+I6V0r24S5Yak04pzOy7t33Y6nNF5ghjcmjotPII659HOh0mBrwVSznlsvaahLmn1R+jpqJob3meAtHqq1FWZN9XE4EhoYGEOgtL7CeQ8mMOqHT7kbEZYTaAlk=
Received: from DS1PR04CA0009.namprd04.prod.outlook.com (2603:10b6:8:44f::11)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:49:50 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::56) by DS1PR04CA0009.outlook.office365.com
 (2603:10b6:8:44f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:49:50 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:49:43 -0500
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
Subject: [PATCH v2 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
Date: Fri, 14 Aug 2026 23:18:07 +0530
Message-ID: <d83896ecfd6e98424c2053298fbb10a3d91592f9.1786728929.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e522ab-4ba1-42d7-e64b-08defa2c704d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|13003099007|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qxg607hA86g8XTWZXS81GtoCfK5MDJ/uSDOLgrxT3Bmm0b149gYd/E0O2VYopubjzTe5lNwFBqt+MgVn7b/ptRltaDhu9oJ8NK4tTY77JgYhapO2AllIzgwCPNPapkf67jjsefvMX2KZdsxEJ81DFitNDigOuIAaTqq3j7o5AvhGL/1b1lGBH9R1TPWa3+locNU6d3Br/EbN1zTg8VDVPAROzo4c3XuQYMhWmS7Y2+1gwFYd6D9TcXf46wfwzxFo5lnhm6Ott8ESJKhUoEeh1JtyyySKYnNJF7jRx9bgVJKPQLieUOhFHjZuA+q3+5e7XuWtd006jDYVuzY++v29HBkpJ2IxPuVfDP40ShRevWBn3IHl06WEfwscjCPS3I+4wboSa8/N1/axRbLwdCyDR4UYz4p8hx5bmfH308yedw/LuPmFhMvUo4OQkH38zBoZTSh4vlXwYu7i1LDqNorysc0j4bdCrli+yKJ/NkO2tlxdU5rhP1sBXxyMtQEr1Y2hJvMSHXKTaTa6zrQ15VM/RGiO2KWUeJIySDnCdBUhi1MTnFs5uUcDyA4ey8Ninn5IeGgqUw6LlabZso8sdrmgIPiYgZoUsnVrF4YWRVOXHkrIz+hxSGmbiFIVp+z1pGUIVqxiWfF6RSKvd5+Jn5GxCXe2ZCOrql2vzYN1lWvnJaBswmqYArF+ch+OEjFTKblp3+Sj0xAQohsn0P2mJk5Lvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(13003099007)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LNj46fmfjBRW/03GnuSWnfuVhN+G57qlwDsTgdsroyEQpgdRHeKHZI6/ARDTUeRAr/Fh/6ebhOx3zyzk21lMze4YwajIfrKy3jbXGxYPnpGdQ4sFRcVIZ/hWUn0A1wtPlxMwp3Sqp29RLlBI7TY73razyTzY6jdJaNjO0Kmc4UgwcqyYhCcPCQgYkG76MNNf3v74QLfgzqjp9ilEDdn1Rf9DbGeUJuNYcnQ6/j8VlIguZ1meAd5wXl3ceF46P3GMKy5wWgbzx6yuJTOkLcSaJP/QP82DwMGsDYO3unuAFwB6Y/uP5RavRRv7+rFnlid7YndK8Z+c4l3EmiScCxoXEv4By3YaUm8dyT58/sJ80yM8MwguTXzH4nISMZOzOVJAkIow8rfqiGlogG7X+3ObSYnrS5Eecz65qHaIZRQyA2BVHtIT4+kTnwRpz7HtnxlR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:49:50.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e522ab-4ba1-42d7-e64b-08defa2c704d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

MSR_CORE_PERF_GLOBAL_{CTRL,STATUS} and MSR_ARCH_PERFMON_FIXED_CTR_CTRL
are Intel Architectural PerfMon registers that are not available on AMD
processors.

Since commit 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2
support"), x86_pmu.version is also set to 2 on AMD processors that
support PerfMonV2, which makes perf_event_print_debug() attempt to read
these non-existent MSRs. The resulting #GP is caught by the exception
fixup, but as the reads are unchecked, SysRq-P logs an "unchecked MSR
access error" for each one and then prints zeroes as if they were valid
register contents.

Implement x86_pmu::print_debug for the Intel and Zhaoxin PMUs, which do
have these registers, and drop the reads from common code. Both are
wired up through PMU descriptors that are selected only when the PMU
version is at least 2, so the version check is no longer needed.

MSR_CORE_PERF_GLOBAL_OVF_CTRL is also dropped from the dump since it is
write-to-clear and does not read back the overflow state.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Petr Tesarik <ptesarik@suse.com>
Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/core.c         | 27 ++-------------------------
 arch/x86/events/intel/core.c   | 32 ++++++++++++++++++++++++++++++++
 arch/x86/events/zhaoxin/core.c | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 364a4c83f677..1b5af204cf64 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1575,38 +1575,15 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 void x86_pmu_print_debug(int cpu)
 {
-	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	unsigned long *cntr_mask, *fixed_cntr_mask;
-	struct event_constraint *pebs_constraints;
+	u64 pmc_ctrl, pmc_count, prev_left;
 	struct cpu_hw_events *cpuc;
-	u64 pebs, debugctl;
 	int idx;
 
 	cpuc = &per_cpu(cpu_hw_events, cpu);
 	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
 	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
-	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
-
-	if (x86_pmu.version >= 2) {
-		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
-
-		pr_info("\n");
-		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
-		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
-		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
-		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
-		if (pebs_constraints) {
-			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
-			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
-		}
-		if (x86_pmu.lbr_nr) {
-			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
-			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
-		}
-	}
+
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
 	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f6ee1819864e..10f2f8f49340 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3734,6 +3734,36 @@ static void intel_pmu_reset(void)
 	local_irq_restore(flags);
 }
 
+static void intel_pmu_print_debug(int cpu)
+{
+	struct event_constraint *pebs_constraints;
+	struct cpu_hw_events *cpuc;
+	u64 ctrl, status, fixed;
+	u64 pebs, debugctl;
+
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
+
+	rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+	pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+	if (pebs_constraints) {
+		rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
+		pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
+	}
+	if (x86_pmu.lbr_nr) {
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+		pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
+	}
+
+	x86_pmu_print_debug(cpu);
+}
+
 /*
  * We may be running with guest PEBS events created by KVM, and the
  * PEBS records are logged into the guest's DS and invisible to host.
@@ -6706,6 +6736,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	 * counting SMM by default.
 	 */
 	.attr_freeze_on_smi	= 1,
+
+	.print_debug		= intel_pmu_print_debug,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index e506f677db57..cc447e228efb 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -288,6 +288,22 @@ static inline void zxc_pmu_ack_status(u64 ack)
 	zhaoxin_pmu_disable_all();
 }
 
+static void zhaoxin_pmu_print_debug(int cpu)
+{
+	u64 ctrl, status, fixed;
+
+	rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+	pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+
+	x86_pmu_print_debug(cpu);
+}
+
 static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
 {
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
@@ -479,6 +495,8 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
 
 	.format_attrs		= zx_arch_formats_attr,
 	.events_sysfs_show	= zhaoxin_event_sysfs_show,
+
+	.print_debug		= zhaoxin_pmu_print_debug,
 };
 
 static const struct { int id; char *name; } zx_arch_events_map[] __initconst = {
-- 
2.53.0

