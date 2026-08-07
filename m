Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BE36896D;
	Fri,  7 Aug 2026 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088200; cv=fail; b=NpyKdWUGlgvvEWZkDMnWW2QjQyfuUCR0vTBj3G4zYb5xoVWn6caPhudqM5i+UaHZqOJMh4DS46NBHegwglpCk2065c76m6wPnLDtdXHi4pewpFCOUHNEhKM/h6a2fQ8xnxx3tAsNNwomeSY8MU008zmUdGyxxzJkiN6cWV2mLDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088200; c=relaxed/simple;
	bh=xBWilqP5WFyUvdR6tSF5SEb74ovPgvSRoMPWH4gR8/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OqvheWdWJsVMm3rj5fnoT50qI3uCU+3anhTCA0AkdjCtd9VHZSUPAwN4OynKcXWSvxSOVN4QASsWgadUUhbqrBZIkra4PqCK7EYWtF0BnTyjLiO30BWEwI7djX7RG0NykDOFzQ1AN2jPc6qOBpD9ZSOfUAsuagJV/eiDtXcJhmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UM7Fo5WJ; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UM7Fo5WJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy0WFC3Ucy3ogBJ8Q7esKPTyDBRXNt9xntTCwuicXr1Qw0kBDlrJAaJw14mvgKS+j/1k7EvZi6cCQYLWI58DnK849bLp6ciGs/GWC8h7gYxXqymfAE7ZZ3UL/DtwXs7t1yg1AA2+T7el53niUib6cLD9WWarSeoPf8grTQ8XWhswW0GC7Pc/myQI1pJH+hYJ3rF+e7yD6fESyQdlN94kb63WrON9KAgdH2iqhgB3hH/J013GxtGQeScnbNyDAp9KfOKnpFHYESO+pPNAZg/swWPg1O5HT5B4jMP5HJ0Sig7u79+MyVbdM/50lVHhERnz4eUIXGClOab/XnNEMUEAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uBBPi6TiB7DjUjak6BRnRFpdYxUDjfu5qiDpusTgLg=;
 b=C0kyGoumhf9tFM5fPq17JVJWVhy670BsDmld724hwpyED2HqtIF3R4A8xK2CvbxOpaOTT/fWOBpq1R95PVkT1igmJ/aWckz0aI6hjybD82RpwnX5pa3YEnFWtB4sUyHR+8Cg8JBptEyMDdtUScoT8Rfh+A7DmyCPKaCv5iM1lxXfvCqeo+MF04Qpmh0xRyWQ+pAX0SWQMGze2o8m1k4TRDlquxQcnX0l/Q74sut75F1DPwWfChRo/+EcTN4LyPNL2rBLUXaAWNpfbjpsBH1br4VDY9WEOZnRU5IOLwk6s2UUgjtv9zTzUO5O+2TASslGq20C6qpb8IuOV/57p7I9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uBBPi6TiB7DjUjak6BRnRFpdYxUDjfu5qiDpusTgLg=;
 b=UM7Fo5WJ/2kQ5W2N5rc2m1RbQzMEzUlVZIW4qacgCZssZBHf0zRQP6CHkGFZq+h1bJF72wg01D1vsz3L7TYEd+Ygh9xuIAZsoNyPlVac+QzXxLCA+h9hz3fKeJNjqKPTK5uCBiAvfiXIdNaHnQNqE/DgHpm92Hsvn+lCcKjWFaU=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 07:36:33 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::43) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 07:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 07:36:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 02:36:33 -0500
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 00:36:28 -0700
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Fri, 7 Aug 2026 13:06:12 +0530
Message-ID: <20260807073612.3711269-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edc1ad1-52c5-420d-558b-08def4569acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|3023799007|11063799006|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	mZzh8qislUHpdmmGvlkRhWv2hc/PHe8FQIVqBfk3u58Hv2hkd5GdhPfClkRGA5qttTG3Xgs4YY8nMcsIaimaOgvdn7VCGN6exP15+X3e4OLBTSvoIoKhxMSl4fq13PzJuRq2c+4SjjJMGFQ7VkLpKVM4G9VGh0Aj21Y43sTqtFGuIDP72y9Vkmn+cKJq2p3ZxhzioIXEbYRcZx9lnaTczSjB9XyKfNe9aVgING8ilGzCQjhJOVo/5fKl1SkHBwFgEhHQ8jkfTrnbzPD9eM5eZub2a6rZqfoFXgi9pB8w7R7eqlUiSoXm2/40yyGtbXPsw2wUiOz/gnU8bDeDCrS/vdJsAwDwKFziwdtYGrsEAaS0z2Z1rOUXowwZFjVNSzHQ1yUDpQmVadDOvks2/MrUDetL9Z2PxPVZTeurHUv50Yq2vWvd5uGZEHZsDaeabuO0kUfEF35TfCCfGFdbDdiP7JpYOgI0My66quLp9lke0gI7RjCi1cpDsQwZx/N8alopZjHKv7BqBz5zwNjAW0wa8jySVXxbmvEqlCB8xltY3il/kFtpK4d1C5Bmn4jUF1Pmh7+ile4D5G1b0seegFkFpK/NFZp1jv7wTi0y/K4f7gDnB1V4QRVG9hSB/9yHmoxTMq2fodq04WUFtuEFDCOUJ7BKpNLpZvzhk3lBcoAiz+b0EC4Ved3YFWCnVguVaK9sctAguLf+pJTOo60wmndBhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y0icenl0mNBIGV+pBR6JifTsdL54GlHOkl3aWFe4jNZeptcNVPK+wmALKZLIgQBxAUX8Y3v+V2SvfEEtL1MOBvYl6E/9Uo1q7rAUOxNWWagc51birBHbO+TYwLG1+a6wdFrSvcoXsyV1XX3ZAQqq4q+NapIoO0pkd9QY+y7y8Dc0qN6nLJBzaA9X5Vur3kbhqm41un7+KTVheyR5hyKYtYQ26UcdPBGhx9w43bEoZl2CJJDnMmVrNt6DVqofjRC3B4GDyZCkok1ki44enZZo9YaFQXbFlTfRlwUDMrknuc3vZeidTvwBI70Jku0BMgjDBxhpmNLw9UBTJ5bQO2WBA29BFtxE1fY9aTd8Z/oUvGk8003oQYN6beZ/hwueVts+CO5ft2g2bSMxSyTtaFqg88adXbSmVKydFALzEfhXx3+5uLQAi6BY/6ZgpZNQqhnU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 07:36:33.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc1ad1-52c5-420d-558b-08def4569acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887

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
once while every CPU is online and reuse that view for every later spread.
A fully-online view is the complete cluster membership, so the partition
derived from it is identical no matter which CPUs are online when the
controller is reset, which is exactly the invariance the callers already
assume.

Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 lib/group_cpus.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..3ec9b2c4c908 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
@@ -286,6 +287,74 @@ static void assign_cpus_to_groups(unsigned int ncpus,
 	}
 }
 
+/*
+ * topology_cluster_cpumask() only lists the cluster siblings that are online,
+ * so group_cpus_evenly() would compute a different managed-IRQ partition when
+ * recomputed with CPUs offline (e.g. an NVMe reset across s2idle), steering a
+ * queue's IRQ away from the CPU it serves.
+ *
+ * Snapshot the cluster masks once, on the first spread seen with every CPU
+ * online, and reuse it so the grouping stays stable. If no snapshot exists
+ * (partial boot via maxcpus=/nosmp, or allocation failure) the cluster path
+ * is skipped and the plain present/possible spread is used. Only the cluster
+ * path is stabilised; grp_spread_init_one()'s sibling mask is unchanged. The
+ * snapshot lives for the system lifetime and is not refreshed for CPUs
+ * hot-added after boot.
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
+	/*
+	 * Only a fully-online view is the complete cluster membership; if any
+	 * CPU is offline, retry on a later call. The read races hotplug, but a
+	 * wrong guess only defers the capture.
+	 */
+	if (!data_race(cpumask_equal(cpu_possible_mask, cpu_online_mask)))
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
+	if (!data_race(cpumask_equal(cpu_possible_mask, cpu_online_mask))) {
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
@@ -299,6 +368,17 @@ static int alloc_cluster_groups(unsigned int ncpus,
 	const struct cpumask **clusters;
 	struct node_groups *cluster_groups;
 
+	/*
+	 * Capture on the first fully-online spread (normally the first device
+	 * probe); later spreads reuse it. Sample the ready flag once so both
+	 * loops below use one consistent source.
+	 */
+	capture_cluster_snapshot();
+
+	/* Pairs with the smp_store_release() in capture_cluster_snapshot(). */
+	if (!smp_load_acquire(&cluster_snapshot_ready))
+		goto no_cluster;
+
 	cpumask_copy(msk, node_cpumask);
 
 	/* Probe how many clusters in this node. */
@@ -307,7 +387,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		if (cpu >= nr_cpu_ids)
 			break;
 
-		cluster_mask = topology_cluster_cpumask(cpu);
+		cluster_mask = cluster_snapshot[cpu];
 		if (!cpumask_weight(cluster_mask))
 			goto no_cluster;
 		/* Clean out CPUs on the same cluster. */
@@ -331,7 +411,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
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

