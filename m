Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F4424D79;
	Wed, 26 Aug 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764610; cv=fail; b=KarqG1aY61M08PafVo5MBztt430itO8Ze2a+lAs2GQdAp4zF5Q13flgGMnMNKHyamesw/6nho6UjMh47BwRDEmh1uNCfyFEPg0YWaENCWBPQNQt+e1/kg7rjibEddCl4FMESUYKQrnA7uxldbu347rN+sYdgOaMYz+QA3kVgR8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764610; c=relaxed/simple;
	bh=dy8oy/srC1BwJSevGQZCDcws6awJdOxDrj5ZMTQVeok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkZAV5UvlGyQSHXJ0Dp2U8FXw2/6S3ek+8fyaye5jLH2+ackUw2vNs6YYFG0IphAqlGyX3cLKIlLVdhQkG8hTBJ4l6wnH+P09N77weVxFzGajcGBiY2wg3DfRLEs7EDdWfJAqs6OfFV+8npTopmRgiAww+YcuIYXCfXLOK+/XDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Owdd8dYp; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Owdd8dYp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e06lU+pOWqPn3uZ9cq2OsdFzKcZe0/UpNgZIl1MlsO4G1EPYUuNxuJCyojsHPIj0k9gCYsJyb79T8oJZ17/nY27u35TFtiOPj6/xAyDjAQkiTwKb/bEWS0CU2l3c7kCODfRMr+nuH0KxRmnCOGN9Fe7FnX3WFhlKnDRINXRvmAcgvlGJFJnGItyQHudsDHl+p/bkNgMWy0rSp9hAEVWL91d6kpRUHPuvIrutpDcaS2L+sWVhUuYwMwg7zKCNuUwxuSCiVJE2fo/MuJtQre3xKJZcQvgpQbm4GJ9C4aph/nGGWF3iMVyZTCYLNpK1G0XRIoU/KzSJ+SZcsoLtmKcwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emdJDRMuxf37Q3GwTCDWz+fc2YVnnjeMAU5Jm+uwtP0=;
 b=Y+MEoxJ+4zdkH4Rk7nyqA129oYJNzfnu9rrvps3uu/CwWxkZAPuHHLP5TTK3yqg5y2k1PncrkgihvC6UKR8jdzNNjZV5lddc1YrzaBVepq5okrHucfxSMdIj3y7MLJ3dPRaNx4RerKIDhjiaMyBFCDoPj6WSfkpAwWhrAisAmfvikYafmlMB7H8n6Uxq2mXqW2v39gy0EbWq7WjKbaTvfraqHbUPo4Jo9TROIO429dUHlJLcukUguG+D9IpmjH6DOZsui5KQKJ3SSc7GoJhrW5iQAG4tFZYWUIOOdKSuG8K7mAlscno6+Fkp1vVkHSzsllygOnAXxtaWzBsMV5k7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emdJDRMuxf37Q3GwTCDWz+fc2YVnnjeMAU5Jm+uwtP0=;
 b=Owdd8dYpTfVAg4hcKz1VjV2Y1NmIRU2NM/atl6ZPT/Pq1K98Gaje+bm0AcdhojOmqV/n92+TLi3Aie51f8TV17Z9Z1e7Ma3Py43+awCwswmZ8bTMBMqmEXgvMIYPuHblJ0M/BO4eFLb3I2U0WziwJU8JCfJpgg7X7H9wGN8HCeI=
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 17:16:00 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::42) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 17:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 17:15:59 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 12:15:56 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Wed, 26 Aug 2026 22:45:37 +0530
Message-ID: <20260826171537.4167367-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 114499cb-a7e5-407f-5c18-08df0395b324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|3023799007|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	CpvuaZMD5xQ44FkpJ1xv+bFQ0vcKjQW7u0Ah6IKfqlDlmCkXWfq//ZUazoEMSc67SYVV8A5MSkX3reFigYYrXxpyGcPG9hfCfWoz1FmzZRNG/KrsQ0y72dr5MuGfruzm4rvaJ/nlWU1aG3QAxNOYwa5R25qJKSoFLb5eyDoydJAcn532IxEsbw2tOmiSJBhTbaHRXhiABfLWQj7ix1/fdPpgZLikGN0L757WigZmneqTRambsEdcyLW1CEgW2B/Zfnv5tJAOHgVtl+QJLwWiFJyRcq3nNzi0x+k88MNcjmOryvGQgUBILJVXLqIEfKsZkEEbZkFs0bPd1XqMcXDyqKiHBBjukD7VMpCh+x739VexoDHMUO2cQKstWY4RkhhJlqfaUyD8RReqDqGJNHvVCDvc2RdGgUkxkf2VQ/cRx5JIIm2z3k9vQ4svJH8dksPVK6kZWjpxVvfYntkwVa1SGiWiEkr2Z+9MjidH5Tc3fqktemQn7cztrhDEsgYt9JysxScvLSE3yEPMqm6Elje7atnc5b7vf/UR3gQYDn6Ia1/5gVpfkdXy83Oi9aRYZ+Hwk4JQ1N+Rt8ci/pd0yombGsdlUL0iBxVtMInpSGj7+jpxynbwI5CFy80839fXh8NMGrs665s6+WsjNO6P2vu5B8FZNR2xhEUPC1HGS0wcNsBQtj8+4H6fBzXIEY8JV33vQ+sYWw/YM0zbPDLJdRvrRg==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	60Xvl9V15oUzW+YSFwKJ1/BySME/OvFstuMQQ3Grcz9r1/F8jL3iOuOVnBjwTXCg3DTe/huNrQIsJQx2MnViVCSAI935f6b1i+/m0Zrg4l37UmI9FuZ+l1gV/12fxUF7Z3CZe+cVN7zdD6ZPgkQ3KH8hIFDTEpnWSmIex4ToEfgJCjTEqHoIsyz+SY1ne87gd8GNmsRChv/5POrSNdG+CsS3bG4yjMhBJz2SMO69ua+HW6KuI2xU6gtH4jrwmnb81Kk3aLFiedbCw4Kmp0VnzAU1TYueG7djfeS6mLChIYzR05Pfr9+dBnz90aUWZbSCQ5OcPezgMjj8ZFZqC7mOrN7OwVVGIpXATZoBy7HVBSoFYjiXaYAWr0Kv90Zrg6W4tINAiO30PchLkPzQDRrluxwOi5hDON6UGKhTDNrB38b74yMm4i1bd4b6UhI1gVKU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:15:59.9112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114499cb-a7e5-407f-5c18-08df0395b324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

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

Make the cluster grouping depend on the complete cluster topology rather
than on whichever CPUs happen to be online. Snapshot the cluster masks
once while every present CPU is online and reuse that view for every
later spread. Every spread then groups from the same masks, so the
partition computed when the controller is reset matches the one computed
at probe and each queue's IRQ still covers the CPUs it serves. If the
snapshot was never taken, the cluster path is skipped and the plain
present/possible spread is used.

Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
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
---
 lib/group_cpus.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..3c2229feb9c3 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
@@ -286,6 +287,77 @@ static void assign_cpus_to_groups(unsigned int ncpus,
 	}
 }
 
+/*
+ * topology_cluster_cpumask() only lists the cluster siblings that are online,
+ * so group_cpus_evenly() would compute a different managed-IRQ partition when
+ * recomputed with CPUs offline (e.g. an NVMe reset across s2idle), steering a
+ * queue's IRQ away from the CPU it serves.
+ *
+ * Snapshot the cluster masks once, on the first spread seen with every
+ * present CPU online, and reuse it so the grouping stays stable. If no
+ * snapshot exists (partial boot via maxcpus=/nosmp, or allocation failure)
+ * the cluster path is skipped and the plain present/possible spread is
+ * used. Only the cluster path is stabilised; grp_spread_init_one()'s
+ * sibling mask is unchanged. The snapshot lives for the system lifetime
+ * and is not refreshed for CPUs hot-added after boot.
+ */
+static cpumask_var_t *cluster_snapshot;
+static bool cluster_snapshot_ready;
+static DEFINE_MUTEX(cluster_snapshot_lock);
+
+static void capture_cluster_snapshot(void)
+{
+	cpumask_var_t *snapshot;
+	unsigned int cpu;
+
+	/* Pairs with the smp_store_release() below. */
+	if (smp_load_acquire(&cluster_snapshot_ready))
+		return;
+
+	/* Only capture when all present CPUs are online. */
+	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask)))
+		return;
+
+	mutex_lock(&cluster_snapshot_lock);
+	if (cluster_snapshot_ready)
+		goto out;
+
+	snapshot = kcalloc(nr_cpu_ids, sizeof(*snapshot), GFP_KERNEL);
+	if (!snapshot)
+		goto out;
+
+	for_each_possible_cpu(cpu)
+		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL))
+			goto free_snapshot;
+
+	/* Trylock: a caller may hold a lock the hotplug writer needs. */
+	if (!cpus_read_trylock())
+		goto free_snapshot;
+
+	/* Recheck under the lock, which also pins the cluster masks. */
+	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
+		cpus_read_unlock();
+		goto free_snapshot;
+	}
+
+	for_each_possible_cpu(cpu)
+		cpumask_copy(snapshot[cpu], topology_cluster_cpumask(cpu));
+	cpus_read_unlock();
+
+	cluster_snapshot = snapshot;
+	/* Publish the filled snapshot before the ready flag. */
+	smp_store_release(&cluster_snapshot_ready, true);
+	goto out;
+
+free_snapshot:
+	/* Unallocated entries are NULL, which free_cpumask_var() ignores. */
+	for_each_possible_cpu(cpu)
+		free_cpumask_var(snapshot[cpu]);
+	kfree(snapshot);
+out:
+	mutex_unlock(&cluster_snapshot_lock);
+}
+
 static int alloc_cluster_groups(unsigned int ncpus,
 				unsigned int ngroups,
 				struct cpumask *node_cpumask,
@@ -299,6 +371,17 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	const struct cpumask **clusters;
 	struct node_groups *cluster_groups;
 
+	/*
+	 * Capture on the first spread with every present CPU online (normally
+	 * the first device probe); later spreads reuse it. Sample the ready
+	 * flag once so both loops below use one consistent source.
+	 */
+	capture_cluster_snapshot();
+
+	/* Pairs with the smp_store_release() in capture_cluster_snapshot(). */
+	if (!smp_load_acquire(&cluster_snapshot_ready))
+		goto no_cluster;
+
 	cpumask_copy(msk, node_cpumask);
 
 	/* Probe how many clusters in this node. */
@@ -307,7 +390,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		if (cpu >= nr_cpu_ids)
 			break;
 
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		if (!cpumask_weight(cluster_mask))
 			goto no_cluster;
 		/* Clean out CPUs on the same cluster. */
@@ -331,7 +414,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	cpumask_copy(msk, node_cpumask);
 	for (n = 0; n < ncluster; n++) {
 		cpu = cpumask_first(msk);
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		nc = cpumask_weight_and(cluster_mask, node_cpumask);
 		clusters[n] = cluster_mask;
 		cluster_groups[n].id = n;
-- 
2.34.1

