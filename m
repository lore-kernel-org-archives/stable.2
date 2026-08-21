Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34433DE438;
	Fri, 21 Aug 2026 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338208; cv=fail; b=leFuqYMeu1qoATK6LQKAEkKFz2BJOKtZ4t6Fm2DNrTW4zvCaCvFk8v81q/D/f6YsVXKP6QqMOoE2mT/BrT6Yr1/pWJh7tqLTm198nxmEYYLKrvZ5t9PECSUGaJ71KAkmC/Fl2tyXIwYxJZjYl7zqDxuwn9rcdP5nLht1SKHwNm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338208; c=relaxed/simple;
	bh=t+jTiCfaHtcW9EWYnGyvnFqVj+gS8bGkmUPtxR1Vr8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBkjWQHvfhGFL3y/je1tUj3t01CczBlm/x0BkbTMIv5+PBC1SMhsruJy222VygLpCAc1fVReojVmA+UOC7MLCcMEJptI+w7iUK9ejkLsEmPbwNl036JgRwYVnd8K26vptgtgpXB9votoH8FIi9HaSjcv/EHIDiXTj31q6jhym0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bx662vOt; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bx662vOt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRUApVcmOc3rC1cod/gRsXb+bW9OCiB65/zx4jOGO05TZRmMdHGe2oYaQBNexoV/zLYfOeykm/hR3XKzPlwY7j+KGkyoYJkHI0C3kIXzke35UwaFH9o4cyjZUchRkTTHOwKkBC21IinYhrBtDVAO2kBwfTg5CEAns3G8p/fM7dCVjlT4tagp52mKEBDHLWwVRbILJ7qQNT+/bWN2aB/2ZRfvb+N6Wqj1WeA/oxSbK8Fj0nJaIQ6Dr1bxDf9G4EU67rBRVmz161NGS/yRytZ+Yg17cpqPxtKkRPQF7lKK8g4qhokZ9KteGgetQFZUQmzsVXh0J/4FKc7pP8jDw5IPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMR1UunReqvAkwRHZ8n4Qed02Bobc1lklx9KtbkRgG0=;
 b=KmwlHwTV2BuWcJiuCojXZzpbJbSCmkrXj9M6GHRkPgXyW87rDBVME48n9IBIWF3wpnfXQEkDUANVvCFa1GKxgyuVGnRSlTASBSyyNuyyokEW8fCdXGvpUbKFCQ8fsOKYVkHlmcLkrRyQvyf++1Q/jwe9EJiFXJxfSHz2YBOWpWEDE7faggkTr1MXcG9amoD1Lo8HGAONR2AfUnlQ+FC+RhQQMgLQXTPwuZMN/04++Uaifr9jSyIOra/YYYiCOjG2UglqPV+1CFF/X1/Lqupi5gpWqiHOm2/2VhsR35f4xhJupV3noInzShPWv4KgsnOtKr7jK1f/fz5T4DH8BM92ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMR1UunReqvAkwRHZ8n4Qed02Bobc1lklx9KtbkRgG0=;
 b=Bx662vOt1PED40GA4G7OGuESqLGtDSbx+4/EOrwH78w+ftBnJFZhPVc77il59z3SXRU3OztvrF+OeDa8B8HSRYTkJlOXCCVogea8qYMk4JAzOrQpdKCAPaAGaeOaNVd2G5duv8n28uU46w2mSal4R+zFiGj2zpEFlvGi22O47Tg=
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 18:49:55 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::25) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 18:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 18:49:55 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 13:49:52 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Sat, 22 Aug 2026 00:19:23 +0530
Message-ID: <20260821184923.2462575-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da59b1e-47a2-4f41-a0d4-08deffb4fdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|13003099007|3023799007|56012099006|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	W8Gz4pXF4VqXCIrwU3CZIe6O8o95EuS934crUvKgf+5XoQPVpgI4fKDQsS414Ntw6z7+uDDgOnheREVfMzyTFNJQN20uU3NHSjVbyvANP1WFjUebPKCI9p0oi4dQ7VVJEkSCXlXKACPndN/s5ToRVeTGZEWRp3KUlphpa4kxJwLtR3CUDt+xkW+JMXqKdAd0UHOiIr/fHtE32bQ+FGULWHfHZK8W37NRLLfiLKNJivtlE4KD1G7ajdcEUdnT8hBPSih9TVW3Y2N4yK6kGKmNxFzpilP8W5DIU5qVJhRtF40E00WURu08kEnsBWt9tCwIvB5RcTAHJlRoaZsIKUyMfJA2zxYtpWKZaes9r4wgL4tnAv2IoTzm8l1yFHPKUBokTMM79KygLff/cuOMy0NZbAquqdWQavrYNf28MDSkYrk1R8OIEwXMT9Hb+3Nu38W1wTRu4IFLwHRPfMvQC4TSEaFtAnhWhguGgU1bIJUxQTmarPbqNq0kjVq8IuPWuMqPgRiJ67VJwpVQKRDUOnqq8lECxTfn8v46nbQE2Z5IlX8nH4agrPkXPAsVMpgMATvDSNqx2H2jhkD07sQttXBHhj/RtGoV+AiXQV0VIF5LYII+z+AO/JJEZdN3gg3Bg5w3Lx/HcbmP6cDJ+SHd6SKZ9+LiCzHiU1sJraSbItEiTBz+yC9gvg6Oe1ptK5aZKk1ilHrWTAnPDtn1xzSgFKYEWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(13003099007)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fgXq290eHuhSCPvgqIIir32kCbXbnvCLa5tfZ7HGgwp4rAk1apdLAX23U96eFU+P6lUyrA7dkhSu8wKOn5NF2uMXEhh+XY4TWthHP1j2RWplavDkNICJDA0J67MkFDBUecCgOs21n7OjRUllThwLjlAxBWzEL0H0zVD3EbiynHvN+OXpH+gjHCAti6vjL1SFi67fRisKkzNSWjAFpKXdMdAknMkz4NT2kfQI3cRfVOPCUTlhraH6ZpL5yNToRcF0JtdVd00TcuLA26bmI4Huu6exGnAjMAXn42jRYe/xbhl6DA6XMBJG2HL4gVt4ra1mmMKPelpKqjtGj54YBYYS+zIf5Tj8+wfPIRowGXu139UTGMRk5L8VMew3XhCDycOjCdhU+FiRs70JPu8bF/6Q7vGnnupdmlcWlXOSPTwMGg4lShOTT9WPurtjAJcTx/4L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 18:49:55.0575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da59b1e-47a2-4f41-a0d4-08deffb4fdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

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
Changes in v3:
- Take the snapshot under cpus_read_trylock() to avoid a torn view.
- Link to v2: https://lore.kernel.org/all/20260814123402.3170161-1-Vishal.Badole@amd.com/

Changes in v2:
- Gate the snapshot on cpu_present_mask instead of cpu_possible_mask.
- Reword the changelog and the code comments. No other change.
- Link to v1: https://lore.kernel.org/all/20260807073612.3711269-1-Vishal.Badole@amd.com/
---
 lib/group_cpus.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..1406d32dae8b 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
@@ -286,6 +287,81 @@ static void assign_cpus_to_groups(unsigned int ncpus,
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
+	for_each_possible_cpu(cpu) {
+		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL)) {
+			while (cpu--)
+				free_cpumask_var(snapshot[cpu]);
+			kfree(snapshot);
+			goto out;
+		}
+	}
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
@@ -299,6 +375,17 @@ static int alloc_cluster_groups(unsigned int ncpus,
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
@@ -307,7 +394,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		if (cpu >= nr_cpu_ids)
 			break;
 
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		if (!cpumask_weight(cluster_mask))
 			goto no_cluster;
 		/* Clean out CPUs on the same cluster. */
@@ -331,7 +418,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
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

