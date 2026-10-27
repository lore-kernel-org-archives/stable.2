Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086622;
	b=Wa67Gp6SiZex5WnCGxtP3Gs0QpAxLshDm/SEceyBtCRj6VAmlZZt5dBkAduobECgQeUR
	 83RGTKOJpdRvKsoYvBHkvpB02F2IOeMuLxWXykc6n3nq85Qj8ucfUi+bR5cimeNQQf4oV
	 Hr2Xrhn7qiX5UyTanl1ksVqW/Sw87IowYAroetqn2y6l3xX2bGLpvSauvH3YSscQoqRM7
	 fFmilaVkTzs4fQshIII+JwEBziJNMpw6yuU3U4slAMJnXOMylpYMmRM8Yk0XxGLw3xZXT
	 DMU6vQVZSI5IVPah5Q5a9PhmoqlX+PKSDw9jGZbzrIa2DaaW0TXt2vCX436NbgUH2XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086622;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HiJ17iUsddOzUuExsk2un3MHIRsSQ7IJc5lEWFn2yko=;
	b=ImQYK2hs8Mb8Y8mZx4TAaqfb2nN7p6xKUOvJ4DN2zrqWPFe/wyWTHEzsftRNMKUoNXJj
	 tB/59Nh5xaLXOTxtiA3qGG0Pv3hUp5Us0TSaD1bZutL48UQRpBv4OAxb+a8so5t079mzo
	 KwVDCcZSDqGQfFOMAUVoiwmntJJa2uZ4jA+zRvRLg7PrXd0jIZaNbdsv19Ta54OPABMzJ
	 KLl7MIeaqqtErBqokqS3nCdzCBVT0r27YMtGEuxXHEBYupjWClziT/Tqz49TN2DDemBnJ
	 O7exq7s3bsaWJ6M3nZbdYkM32Lp6bEUIJSbHUbKLl7kZkcw4gLXR+weSgFGfHxpATmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="IeMnx/h8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.21
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F09606AD82;
	Tue, 27 Oct 2026 07:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F09606AD82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IeMnx/h8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAK8W/RIDJ8ZVfJJ6NCU7skJYaPkwGpmDQbOrOTnq38KfUNBhofhPxr+iLzoR3SL0Z5Fp7r7mVWdhye24rdtbXGvHdN/1C1ZZF+Zxx+Y2fS9QzWWmw31Gmf9xe1obDjYUTjCheScs6xxnXs3cRNYQyFmBykoMuvHzNubrAwJBHNfxINVqk//uVjAL/NyiDVpNid6w1nha04UOmcKLyskjGX7yCqdmMZDET9mSg1WYQo9QWoCC0TdXJD+gxcySkrbmJRfySJco0LxJjy+ez71xg7JusaA1EkK7oIUv/7ycpNNiIG8PYAQSMZrCpAQt2oE21JMnwLUmlIRWpEzV6GFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiJ17iUsddOzUuExsk2un3MHIRsSQ7IJc5lEWFn2yko=;
 b=DgU9Q5y0NZ/jOfxdnAp1QLwQlwkP9BGweMEhFC7LvyJgynbBRNAIM8DrRHTITqdI0yuGM3za9W2YE90bCprm8e2z74Yten1zXJ7b25OdB0bOlZ+mTQh8HiSmZUUUBkAXcIbIXTvEt+mPJm+Vlqo+S4u4J/hWVQLZWYK0FfozmY2V8ta+nEQNzeak0sIgIDIJVoP5syUUMp4S81A877OWHFJo7uDlUY2fQ66TEhwl30es/hZ5kcF8TGbVv2kC5m40xycyho28v8FzPAxDP30T89Roiyoi0lsYrHAHesxVP78gzzZx59ilRIWueLvW/hKBHIP9H2O64Tn248QWWYogjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiJ17iUsddOzUuExsk2un3MHIRsSQ7IJc5lEWFn2yko=;
 b=IeMnx/h8axM7KqJHDIXV4BYs2BwV4Ed3Vly5t0gcZr9QoDoFEmgutyVMy2HfbnoEaDXCdst65oNqePRo5OHVmrYUjLK6/ZhHn7LcWGfbFXNRwot3o8NANozwVVDjWAC5+ZghBrOCQfx8UX34tSw2TzR2LrwRXJIC+ezvyt6QKAg=
Received: from PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:54 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::9d) by PH0P220CA0027.outlook.office365.com
 (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:36:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:36:53 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 02:36:50 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v5] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Tue, 27 Oct 2026 13:06:27 +0530
Message-ID: <20261027073627.2589115-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc59cb5-f680-4657-43cb-08df33fd123d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|18002099003|261026121527099003|13003099007|3023799007|5023799004|56012099006|11063799006|261021121427099003|10067099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	p1CGnSrK1Q2M1epttYQJs+ceXTlP4mYp3keMiMKixmexRkawPrjNl4YkMPKdSdGFlfzhJ2dmx2f7UkJ87q3OUNS6/mSkznxz1zoNooh3XYF4+ePvKZggxQ9QEYtSTRNY7ylDN/RDl0DWiC+zh5u7Yry2Te9FWOPhGbv7YehPhpJXH1EL3M9LjQtsL0YLKOi2O0XYQrPl5rnb/Elv4VG9pCk+pQTBVRlbqjzvEkgWdxSzKYlEXQqfjmdEy3byosQgfYepxrNu9Q5KcnoBqxbfAPMWIShvvBL7gN+tbO/e2ar5T0sHG7vFdsto0hIXdHIMASnbEdBQKAdEeg6bQoH6ULeq1x5DXw9JBrfF5mbtrF0X/wjY+9n6ZwiLW/DXC2eUfaey6Q0uHolfeE2XlIHzL9eUGVnxK/xjTtH1fiefUr+fN1lBYUTEZytQXN5ICykztUK8njxudv4B8RyBBh16y8RmdA3sZHRsyMwp6wlhdIHQo3fEdBRQnO7IHwNrxcdP3uN0f9NIiXgRxX3dvE8tgWYj387K2ehgsVFXktmIvvCRKdJf61uuJw78IbCBpO6IXEZQtJ1CZeT9oSQe8P+ILYoKT7sctqqqkMW3y3zvnmUIfO/g7q1HLUJXAI8ftpaLVWtMMj4cHEzthdWvsTmm+fA31yHJ+0SRGH+Kis5sjPA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(18002099003)(261026121527099003)(13003099007)(3023799007)(5023799004)(56012099006)(11063799006)(261021121427099003)(10067099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pTbj6PZSQySvREIjvr9Ek/vtl08I61nAk1DvxhVv65P9FJy2QJN4sd63E2fXJ1UlFmThcrDJngFh6NtDjOpTPo1Uv8zb6AIy7+/k8HrQeqqtUPPtu7S85ZEWCxAWwj0b5Lq8s54L5mBO0tEsop+rObDRZlPlQjzxyyNpK6sFiSi7yNLnrRx51Bp+5RuIgM12B6Ig4YV58xRtccUL8pm5QeQDktNp8aGh1u/ALCv2M4bBNaL4FlPv0WzgJC/O1ONZOxN6yIZtx/mKoo8RYzO3serv18x0F0Is9GRgNyacfYeAFypcJ3LZb3HgxyN9Ws0t1KfN3d4efZcdMBIpafpAoc9pTJgxVdxvqLTBlB7QTnxJD1xELkF9JDWvlFyWdSRUd3I+SdwoSP4H2mEPvop5cPIXyrpt4Mpc9wOIQ2BWPXQmTW+J+Jl+2JTNNUpBGUTA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:53.4860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc59cb5-f680-4657-43cb-08df33fd123d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

group_cpus_evenly() builds the managed-IRQ affinity spread used by
multi-queue devices such as NVMe. That spread is meant to be a property
of the static CPU topology: it walks cpu_present_mask and then
cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
including CPUs that are offline at the time. A driver depends on that
partition staying stable across re-computation - the CPUs a queue is
given at probe must still describe the same queue after the device is
later reset and its affinity recomputed.

On an AMD system that stability breaks across an s2idle cycle. With CPUs
3-11 offlined and only CPUs 0-2 left online, the machine is suspended to
s2idle and resumed. The NVMe controller uses the simple-suspend quirk, so
resume fully re-initialises it and recomputes the affinity spread. The
system then hangs for roughly two minutes and stays sluggish afterwards,
the controller only making progress through its command-timeout poll:

  nvme nvme0: I/O tag 898 (3382) QID 9 timeout, completion polled
  nvme nvme0: I/O tag 398 (618e) QID 11 timeout, completion polled

QID 9 and QID 11 are the queues whose CPUs were offline when the spread
was recomputed. "completion polled" means the commands did finish in
hardware, but their interrupts were never delivered to a CPU that was
watching the queue, so nothing reaped them until the timeout fired.

It happens because commit 89802ca36c96 ("lib/group_cpus: make group CPU
cluster aware") derives the cluster groups from topology_cluster_cpumask(),
which lists only the cluster siblings that are online when it is called.
The resulting partition therefore depends on the transient online mask
rather than on the topology alone. Recomputed on resume while the non-boot
CPUs are still offline, it no longer matches the boot-time partition, and a
queue is left with an affinity that does not cover the CPU it is meant to
serve once that CPU comes back online. The dependence is on the online
mask, not on any AMD-specific behaviour, so the same stall is reproducible
on Intel platforms as well.

Fix this by snapshotting cluster and SMT masks together under
cpus_read_trylock() when all present CPUs are online. Latch the first
capture attempt, permanently using CPU-order grouping if it fails, and
propagate later allocation errors instead of switching algorithms. This
keeps successful spreads stable across CPU offline/online cycles for an
unchanged group count, present/possible CPU sets and NUMA topology.

Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
Changes in v5:
- Snapshot SMT masks alongside cluster masks using the existing cleanup.
- Latch capture at entry; use CPU order without live masks on failure.
- Propagate cluster allocation errors instead of changing the spread.
- Link to v4: https://lore.kernel.org/all/20260826171537.4167367-1-Vishal.Badole@amd.com/

Changes in v4:
- Drop the index-based unwind; reuse the mask-based cleanup path.
- Link to v3: https://lore.kernel.org/all/20260821184923.2462575-1-Vishal.Badole@amd.com/

Changes in v3:
- Take the snapshot under cpus_read_trylock() to avoid a torn view.
- Link to v2: https://lore.kernel.org/all/20260814123402.3170161-1-Vishal.Badole@amd.com/

Changes in v2:
- Gate the snapshot on cpu_present_mask instead of cpu_possible_mask.
- Reword the changelog and the code comments. No other change.
- Link to v1: https://lore.kernel.org/all/20260807073612.3711269-1-Vishal.Badole@amd.com/

 lib/group_cpus.c | 120 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 14 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bba..c77bb906f2d73 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -6,11 +6,14 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
 #ifdef CONFIG_SMP
 
+static cpumask_var_t *sibling_snapshot;
+
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
@@ -29,7 +32,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
-		siblmsk = topology_sibling_cpumask(cpu);
+		siblmsk = sibling_snapshot ? sibling_snapshot[cpu] : cpumask_of(cpu);
 		for (sibl = -1; cpus_per_grp > 0; ) {
 			sibl = cpumask_next(sibl, siblmsk);
 			if (sibl >= nr_cpu_ids)
@@ -286,6 +289,84 @@ static void assign_cpus_to_groups(unsigned int ncpus,
 	}
 }
 
+/*
+ * Cluster and SMT sibling masks change when CPUs go offline. Snapshot both
+ * on the first spread if every present CPU is online. Latch the attempt even
+ * on failure, so later spreads cannot enable a different grouping algorithm.
+ *
+ * Without a snapshot, use CPU order without cluster or SMT preference.
+ * Successful spreads remain stable for the same group count, present/possible
+ * CPU sets and NUMA topology. The snapshot is not refreshed for CPU hot-add.
+ */
+static cpumask_var_t *cluster_snapshot;
+static bool cluster_snapshot_initialized;
+static DEFINE_MUTEX(cluster_snapshot_lock);
+
+static void capture_cluster_snapshot(void)
+{
+	cpumask_var_t *snapshot, *siblings;
+	unsigned int cpu;
+
+	/* Pairs with the smp_store_release() below. */
+	if (smp_load_acquire(&cluster_snapshot_initialized))
+		return;
+
+	mutex_lock(&cluster_snapshot_lock);
+	if (cluster_snapshot_initialized)
+		goto out;
+
+	/* Only capture when all present CPUs are online. */
+	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask)))
+		goto done;
+
+	snapshot = kcalloc(nr_cpu_ids, sizeof(*snapshot), GFP_KERNEL);
+	if (!snapshot)
+		goto done;
+	siblings = kcalloc(nr_cpu_ids, sizeof(*siblings), GFP_KERNEL);
+	if (!siblings)
+		goto free_snapshot;
+
+	for_each_possible_cpu(cpu)
+		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL) ||
+		    !zalloc_cpumask_var(&siblings[cpu], GFP_KERNEL))
+			goto free_snapshot;
+
+	/* Trylock: a caller may hold a lock the hotplug writer needs. */
+	if (!cpus_read_trylock())
+		goto free_snapshot;
+
+	/* Recheck under the lock, which also pins both topology masks. */
+	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
+		cpus_read_unlock();
+		goto free_snapshot;
+	}
+
+	for_each_possible_cpu(cpu) {
+		cpumask_copy(snapshot[cpu], topology_cluster_cpumask(cpu));
+		cpumask_copy(siblings[cpu], topology_sibling_cpumask(cpu));
+	}
+	cpus_read_unlock();
+
+	cluster_snapshot = snapshot;
+	sibling_snapshot = siblings;
+	goto done;
+
+free_snapshot:
+	/* Unallocated entries are NULL, which free_cpumask_var() ignores. */
+	for_each_possible_cpu(cpu) {
+		free_cpumask_var(snapshot[cpu]);
+		if (siblings)
+			free_cpumask_var(siblings[cpu]);
+	}
+	kfree(snapshot);
+	kfree(siblings);
+done:
+	/* Publish the capture outcome, including failure, before grouping. */
+	smp_store_release(&cluster_snapshot_initialized, true);
+out:
+	mutex_unlock(&cluster_snapshot_lock);
+}
+
 static int alloc_cluster_groups(unsigned int ncpus,
 				unsigned int ngroups,
 				struct cpumask *node_cpumask,
@@ -299,6 +380,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	const struct cpumask **clusters;
 	struct node_groups *cluster_groups;
 
+	if (!cluster_snapshot)
+		goto no_cluster;
+
 	cpumask_copy(msk, node_cpumask);
 
 	/* Probe how many clusters in this node. */
@@ -307,7 +391,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		if (cpu >= nr_cpu_ids)
 			break;
 
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		if (!cpumask_weight(cluster_mask))
 			goto no_cluster;
 		/* Clean out CPUs on the same cluster. */
@@ -322,7 +406,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	/* Allocate memory based on cluster number. */
 	clusters = kzalloc_objs(*clusters, ncluster);
 	if (!clusters)
-		goto no_cluster;
+		return -ENOMEM;
 	cluster_groups = kzalloc_objs(struct node_groups, ncluster);
 	if (!cluster_groups)
 		goto fail_cluster_groups;
@@ -331,7 +415,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	cpumask_copy(msk, node_cpumask);
 	for (n = 0; n < ncluster; n++) {
 		cpu = cpumask_first(msk);
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		nc = cpumask_weight_and(cluster_mask, node_cpumask);
 		clusters[n] = cluster_mask;
 		cluster_groups[n].id = n;
@@ -347,6 +431,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 
  fail_cluster_groups:
 	kfree(clusters);
+	return -ENOMEM;
  no_cluster:
 	return 0;
 }
@@ -354,9 +439,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
 /*
  * Try group CPUs evenly for cluster locality within a NUMA node.
  *
- * Return: true if success, false otherwise.
+ * Return: 1 if successful, 0 if inapplicable, or -ENOMEM on allocation failure.
  */
-static bool __try_group_cluster_cpus(unsigned int ncpus,
+static int __try_group_cluster_cpus(unsigned int ncpus,
 				     unsigned int ngroups,
 				     struct cpumask *node_cpumask,
 				     struct cpumask *masks,
@@ -365,18 +450,18 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 {
 	struct node_groups *cluster_groups;
 	const struct cpumask **clusters;
-	unsigned int ncluster;
-	bool ret = false;
+	int ncluster, ret;
 	cpumask_var_t nmsk;
 	unsigned int i, nc;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		goto fail_nmsk_alloc;
+		return -ENOMEM;
 
 	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
 					&clusters, &cluster_groups);
 
-	if (ncluster == 0)
+	ret = ncluster;
+	if (ncluster <= 0)
 		goto fail_no_clusters;
 
 	for (i = 0; i < ncluster; i++) {
@@ -392,12 +477,11 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
 	}
 
-	ret = true;
+	ret = 1;
 	kfree(cluster_groups);
 	kfree(clusters);
  fail_no_clusters:
 	free_cpumask_var(nmsk);
- fail_nmsk_alloc:
 	return ret;
 }
 
@@ -442,6 +526,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	for (i = 0; i < nr_node_ids; i++) {
 		unsigned int ncpus;
 		struct node_groups *nv = &node_groups[i];
+		int ret;
 
 		if (nv->ngroups == UINT_MAX)
 			continue;
@@ -454,8 +539,13 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
-		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
-					     masks, &curgrp, last_grp)) {
+		ret = __try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
+					       masks, &curgrp, last_grp);
+		if (ret < 0) {
+			kfree(node_groups);
+			return ret;
+		}
+		if (ret) {
 			done += nv->ngroups;
 			continue;
 		}
@@ -496,6 +586,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	if (numgrps == 0)
 		return NULL;
 
+	capture_cluster_snapshot();
+
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-- 
2.34.1

