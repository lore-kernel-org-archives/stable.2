Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603398;
	b=RY2ZzaCVrJN0qfYBP9b+CvVnUElC1f2VZolnGFLN94uGfFHsidFYF82fr6vsu/Rh2BHM
	 q6+SWZhmuNZUZ/DhDNBFXiYxBMAOXVhj/bFuxrqu1NYSCBhZzHBRBsjCCJ2uC/KfOQyEk
	 jgX8pC/9g+wcsin5Q0joLV3YVgh6/DAJJ8w+VuAIR8AiTGAuVlhMN5u3b8Us82k9k4Mjh
	 pOZhASjuTSo7y+DkJCbt99G+zuPxZQVYeVhHQh2xWHNcvC/y1cymbm2S6Pod0CsGrd4i7
	 +Ad2P0n9iz8RpXAFzhLw8tBxqwlI4hiEpFo9wVBqqoB+cKjld/c5WAUs6Apw6Hma5lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603398;
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
	bh=dxTCD2EtG39It1GxIrbgqsT26094PsqPX9wwAE4FoME=;
	b=hEpDza81MU2Yk4C6t/m95NfmhMnWyRd6VY0V5nkVKGQDszf9kxafmBmk9WVJKdyTiWzo
	 6Zrted2Ni5bWQNB0MjCTQeWbsJp7gzGERxhmc+y6rNw3xg5zveS5udAOHBbD69xQJXQse
	 i3H9i98om4exhoo77WlpicqTG2dkrMwdUdO8nKnzADrUxIS1e+S/jKMF/ozfUcKRZEw9s
	 yjJTmWL4uVffGKunLNz5Fi4B6/oBXv1ILR01XoXGqwXDcHRjScO6yftep/UktgFrdt6V9
	 mwpxk+OLNYNZFAFc1i5JzYrHvGh78dXBcOgAlkUkDTwWxZpb7evQXsn6t7T4F95PNxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xBgEl5d6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.50
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A15606A324;
	Mon,  2 Nov 2026 07:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A15606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xBgEl5d6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8YQ0XB51za/wTiXR/Dft+yZNEbsoVbEXCl9RUoSkNAITKwSjOV7A7ZBFy9hYa/xhCwoEN7H8noW7O7VPepXRVBITokdEUxfjhrAoKNLC2PendaS+EW/Vwtb4kZ9JI1Ynl4tcGoaGAfDHG08v/eTSTnBCR+0/q57jiaTI/WYJS0iIg4U6izg/KI7T6hPLdCim5ikLEaqQblbE3rgoTlxZCsVf1aXYq/M2UMiNJPmoXk8D6MjbW1YzC4PBmrXYMRAc6H0PcFbBJQ/5ozOplD2kdGNuG1kSOs3SEy3jdX6ETBrLmxxgktvrNr3F7AQtrKyjGMgby6ayRybAh4upBWElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxTCD2EtG39It1GxIrbgqsT26094PsqPX9wwAE4FoME=;
 b=UyXuJpp7QwN4X1qusaLZgytpEJDqxHW+fA8KAjHSXgqxDZstRc4uH16EpOE2kA4E5YKrjD9txqQS0x0zw7ojNomIr7iUz3cwjQu/1UGRoVdUDWoC2xthRgPBCJ6LYaj6My05TnKIbKQInv0Av/TjsNVE+cyiqPI65R9HW5tq8TlAvttJK0MACjmrw4Of8COGSbMF003Na/Yglpnv/bSJs4OVWGxOpWkWzs+pXTu0bbJbC5zuOBD7tuhw63BDGnMk2q5nt+IhYjFsPZ4WSAaTTulAFj92pLfEcF618fSgPwmUuky87VFDg62y4pekyeTuDSUCKKDzEl0UKib6DILLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxTCD2EtG39It1GxIrbgqsT26094PsqPX9wwAE4FoME=;
 b=xBgEl5d6f0vFGBN1KFxEpqqAQVUoy+1adYKW3+bTFkZS7KOmgUB2HCjqKzKMv/qd3u1EUlzkjSPWB9V9juL7nzdN3bzWb4uYL4dNKvtFR3Fai5g2X+zwIbfItUOrDj5tlI6/cib+TrHHKv2dYEg2+rdR3gSlhaQ7H0Rs825MfLA=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:09:52 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::18) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 2
 Nov 2026 07:09:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:09:52 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 01:09:48 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v6] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Mon, 2 Nov 2026 12:39:30 +0530
Message-ID: <20261102070930.1803698-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 681e3c4f-b60a-4e7a-1950-08df38b04a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261021121427099003|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	jE4IRAYhbGZYDaGPWHptjiRDR+iX2UxLG4Pa00x/XzIxOmskcpxs9feb6x7p4pwMA6vYn6ipGhuba2zd/CmezLxVY6BzIuImm6HKmZzzsY3tbY18biypa2J+9EwtwIX7v1i6Q9inoHoOPKWXIAuEtB5bZ3z0IbwjhMm9jtANN/+jWChfddwz79aEz+kDhOPoXjnTaHpqiHOtYeH0InaloySiS+i1xHX8OMY9tzUZ+Bo9h7kLw3F3RddM6Pf9PSP4xzJwJ6ViECDjPDTHyK4osLgMMMTYAXnr0wyygeUmOBxS4Y0GmAMfE+F2hheIoQ3bGwFafjeCzuzn77lgJxFBMx7RepozINUx6XEAqiM/ruFHFkW+bgu/rtLYCrHN0ta9etfeU/i2NWtHZ0GYLZY90W39KRxh8lgEcUKplE9Oc0XbffndGF9d8eLsmfhcw1M8RVeaHB9bvTiesWL4N3r2ZKU1TUuf0OSWv+L09mSHvmPDYVgx1FvWIgCfVnnPdbJo8ILK6rI9URkiGRkBUmezkufxkrx0krtd6foQNGLO3E6rlaODpFGOAalVBRFZxw5s7yKT4OkVv09RxZxUWG2P1y5PnWE65u5p+lBDYoHY6K1CCZ3el9lObk+8s4IwTX9v+hh8SQHlg+XdEB2TmdoNIKHxTWnReHNYwR7ZYcvXugk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261021121427099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xVQKvxxBlwN0pa4SZXCNQ/7rmJHmHvzMKoiyeAnyOd778+JU7549HQYZu03QVo6xkOKNcodSwvr6BiqE3ffYaYZN+7Zwn97w8VZdeoP64jr3FUfQ+B1vtWWYz5CRKXEcpidwsPTxtF+ni7PxB7ZzccmLc2LP5thKmAXw/csIAJIUjP3l3OSs1hNWDCIWnXsRU1YzuV397I/3p7HPPLFXMfV1fqaEA1ilMLamRLIwGm0F7H4fNFWArqWxU7tEaO17pg0qJrI1rpKc5jd7YWQQtbo/Qm4fPL4Jk+xYTWZFzYeszXUyE8F23AxInsiqgs9+7zZL6vQqjkOFSXq8jdaBDmyTxqLLgRYExAxDUI3z5tsQvK4t9jgjDEg0ZENntudbrxHLLRq02rAqbkT2Q4iR4gLMbWSO4Am/x+wTtLYgpWtsv4vtRboNtsPKFQe1+qoN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:09:52.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681e3c4f-b60a-4e7a-1950-08df38b04a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479

group_cpus_evenly() builds the managed-IRQ affinity spread used by
multi-queue devices such as NVMe. That spread is meant to be a property
of the static CPU topology: it walks cpu_present_mask and then
cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
including CPUs that are offline at the time. A driver depends on that
partition staying stable across re-computation - the CPUs a queue is
given at probe must still describe the same queue after the device is
later reset and its affinity recomputed.

On an AMD system that stability breaks across an s2idle cycle. CPUs 3-11
are offlined before suspend, leaving only CPUs 0-2 online. s2idle itself
does not offline secondary CPUs. The NVMe controller uses the
simple-suspend quirk, so resume fully re-initialises it and recomputes the
affinity spread while CPUs 3-11 remain offline. The system then hangs for
roughly two minutes and stays sluggish afterwards, the controller only
making progress through its command-timeout poll:

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
rather than on the topology alone. Recomputed on resume while CPUs 3-11
remain offline, it no longer matches the boot-time partition, and a
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
Changes in v6:
- Clarify CPUs 3-11 stay offline from before suspend through IRQ remapping.
- Describe the lock as excluding CPU hotplug, not pinning topology masks.
- Link to v5: https://lore.kernel.org/all/20261027073627.2589115-1-Vishal.Badole@amd.com/

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
index e6e18d7a49bba..66628bae79909 100644
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
+	/* Recheck with CPU hotplug excluded before copying the masks. */
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

