Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346345C710;
	Fri, 14 Aug 2026 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710870; cv=fail; b=VJLuTz9vzjLOHqrihB9vfZzjC7Oxz7B0QsvZBuQNx7hGaN4mJ562FKgxBUAFlpCi9QrXEmoJZPX0jOgdg2EqGanb2zWBY2shYOLqggmlQPSm/ZfsPhgEBraqM/LjKtuKnStvhGcqfzcCya1/dA5J/68qDSjhoIrIYu96Zwvq1Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710870; c=relaxed/simple;
	bh=g2JfmtWNoDxFd9smq2dnIhWQJm8sfATWP9h0ObMH3oI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bq4BLmPwoFaNLqg7UmlAi0RcdfZDBgAjqrUqPHHY7DOyXPaKXnk+9G5fjzDiKSjwxinDdMX/dgl0sXMrq7xLa8aUXRcmvzGALEdgkrihYz+uBXxgLgu84wFZv2TkgAzSIgHHD1x9rGCjJCtUhXbYH+O/Rf1tZGLlKoRVPLsdiEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YR+jdIFo; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YR+jdIFo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQ24Kqm1u5+CpIfnZfAVhSSW6Ma0LQ0imRA8zrBQ0dTkS8YsTkbaPpS795Nif/kKo5PpI7vsZJHMkrVnKK8f1GbeVTYZSa9a/wNmWcfMMai5Q4h7J4swm6g+VGWaKtmIk8Tc8xiC2gS6/lFF6nmmPlr7SDSMA2+jY/g+hTfuYufKs0v0GoapEFyN0lcJXKQDxIq95aOZsWbFqqcVuZ4ohMI7GWiXAX6FZ8Nhpz1XXY2jp2/F2Dwh0r0IlAIRc1ARmAdN/M4iKEnIQlgYLexYI8cY3deZarAKHTGFRPf6FVqo3vZNA7ocRCVyMgpaEHOyQgFk5UedREpp6oEXD38CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohtbb44jPKe7unlr42LTJUV9O86EoFz8W5DqUGRZZow=;
 b=Ur4xJpCyEiYsKUYAocbXsyM8pEf+Vo1n1NWmwE/3uWIR8tMqd3Zcg2jl7nwDkKlC8AX/e8eyH3HvSK7HutVsjPEUho8lyq5OR0JLCdyszlgMPm//4iHqkUe4sZ1jTcLKojgnCttLAYLokteeTrgWx1Y6taLmJyC3y0FzXwaZ6coVsLRSZ6Wq5uch7shCpcG1TXapesqzI33autBKVJ4cRFumudJZUnUU2zfMXu8tWTVAi4OMFnH2ABwHHWNHRX2YNzfPY4xWdIn4GtBotMKPjBI6iPOD2STUvPGQMbJ/lkl7EjzS3f+caM4o1n5KbSgHioC9QyKHOWAQnRUFMDO+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohtbb44jPKe7unlr42LTJUV9O86EoFz8W5DqUGRZZow=;
 b=YR+jdIFo4q4xN0TemY1TKuHjQLyDcrXzqIEAUg50HnW+rH96FvUeEveGQh0+I9RDEPra+i389JCAG47QhSfrISQnW/Baih08OsrxTEgKytLNDMgXp3sS0tfs2LJZ/0r7ZtrdCZzkKdlle+xD9ndhlmsIb8WYCdBKptGnj9EbGIY=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 12:34:24 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::18) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 12:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 12:34:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:34:20 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Fri, 14 Aug 2026 18:04:02 +0530
Message-ID: <20260814123402.3170161-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f52c13-5f9d-4c07-7695-08defa005f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|13003099007|10067099003|5023799004|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	12q+c39c52SKhNLap8gyVyjcI34wdKjFtJOL+vZRN5VunP4Uq7rtF56lXvcCdvEOZaTmJl8PX9Z9x81Xzy7epQXUcQvQikT0JeW/UEVPCdZ6aP01nonZCDDHYatwPgl5zdOInu44l0XYLZyT6LSV+cFcaPRFF3qdvBr3xxUgZ6n4eeFG0PV+ecyUSNkG9xrAxkAnjZCpOoDZZ7uoEmhlIQnwBpBVS9LbrINiulEOho+YnYBvS0X7LrTzlXc87EE2bo4ZoOwrF0AUXEKmknJC5ggXnB2rYDgc/9kO1/YjGfEnbw4DrhK4vp9QQTE2gpMQL3Em1vN/LMP01pkQrP711+ooHBK8PdBlF20UrCZdnjYFsgKdy+nsYw1/vClaJNNZblxAzqRJY2dS7ARrL579bugBNYoWjsal6kESvo6ConrECxareoY/BWVFpUqYbIBW0XnF7AoZfAIKieKUHaTRHVAU8MDDkMwXd/MBqvMhu5q9U3p2zAXeHIfCwJVO+C+UJqKHPqLS5gvAuh6FltRuoUuL4erMYY1S7cTPoj8ikghSiOW0oyye7EytQ0OUpzAi2QgcXCSkoEBfUqdFwpavse562DKWafYlUWNryML0M6vsOGzmOSfFjITm+/1VRNFz7II9mKRfFer+ipIk3k3VZSundmVre9NR0dDS14Af2HeumqO+NXudxM4i9I/Xuoa3psdwAT7PsvRJ8tQlReXe9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(13003099007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1/2H2a1LnJnHUAROc4arM2jPBofKsA8bXqJSK/95lAfUWqy+n0QqJCVPt6XcAEYIToZJcAGZyZwGAHF+Tw545GVyPNPl6yo9njMPJ//+rlPwYsADYvjcd6F7i8q7gHPkFSGrrw9rndkZ9PQ4aK+DWduwmL7bc7kKpM8rPYyH7e+Uu0DNCIRSvfS+UBjc+TZLSNX/PiKibdK7lH7sHBMx0CSlr1MN2uwAKoK3kAILlJyGFdWyTUcnboZVdjn1e7dqZ2Ls4eAmENWKFCtXhZ2MPF0McuRIzpf6YNWinXSar9+sLxTwS0i/Odsa98QxV8zKaCf/k+ozi7+TgG/dcgWDL4Yl0sLVf0RgVcw0D3r5qPGeJb82RnJr0FzncPNq3l6/Mv79w6wYfdp0fZr5qZC9CC5/pQW6bIrbhhL+jr2mVfJqYsgIHTjqjTKc5x8wK/lx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:34:23.7447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f52c13-5f9d-4c07-7695-08defa005f47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

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
Changes in v2:
- Gate the snapshot on cpu_present_mask instead of cpu_possible_mask.
- Reword the changelog and the code comments. No other change.
- Link to v1: https://lore.kernel.org/all/20260807073612.3711269-1-Vishal.Badole@amd.com/ 

 lib/group_cpus.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..06fb25c2e660 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
@@ -286,6 +287,70 @@ static void assign_cpus_to_groups(unsigned int ncpus,
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
+		cpumask_copy(snapshot[cpu], topology_cluster_cpumask(cpu));
+	}
+
+	/* Drop it if a CPU changed state mid-copy; never latch a torn view. */
+	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
+		for_each_possible_cpu(cpu)
+			free_cpumask_var(snapshot[cpu]);
+		kfree(snapshot);
+		goto out;
+	}
+
+	cluster_snapshot = snapshot;
+	/* Publish the filled snapshot before the ready flag. */
+	smp_store_release(&cluster_snapshot_ready, true);
+out:
+	mutex_unlock(&cluster_snapshot_lock);
+}
+
 static int alloc_cluster_groups(unsigned int ncpus,
 				unsigned int ngroups,
 				struct cpumask *node_cpumask,
@@ -299,6 +364,17 @@ static int alloc_cluster_groups(unsigned int ncpus,
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
@@ -307,7 +383,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		if (cpu >= nr_cpu_ids)
 			break;
 
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		if (!cpumask_weight(cluster_mask))
 			goto no_cluster;
 		/* Clean out CPUs on the same cluster. */
@@ -331,7 +407,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
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

