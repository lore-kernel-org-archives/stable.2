Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332742;
	b=EkJOmFtVg6Atjx2ecaixHDEMzVch9w7A1H57Qw9rW3G8SJjQ+sRBF1NQxYkeqVQHxUCX
	 dRZiyv5GFDN3RqB867AzrpYih709Njb9FiQR+Q09KjZWlxaN4dDVkaMN1SnES9SEmzd20
	 CVz3iAqr1C6KPHQgdkWBscohrr4HM9DrBTOnXUqn8bZ1MREDQkLoqMtbswM4q+J08hjrQ
	 dnWZeE4M1IWEN18jV2vLPZQKb97oqro+GZqxHChadxVbg+RcFzwQ5JRDOuyrh2I6EaDxv
	 NQHLLDrcm8d0wHAWIpdqr1Aw9FPZh/2LDPRS4Sc9+DQRN3QptBIOT1toapukdO7U+hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332742;
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
	bh=uuqpbv0Oo/L5nrb8eszKvytHKVTY1a/44BgZjrMYPN4=;
	b=Ssb51zdBJ7+I6lPommN7VxX3HWj12yl0MFD+iOTZpSbLAvIX7r+MOBg+fdtOz/D7691x
	 XqdGZW5pgfZZCk9w86PphRl8qIFSuFYdTU3qGPWLt/8v/bLE50HuCV6/NbSfS4E2tWhRq
	 vb3ZAumZpXNYx/y0Yghsn61VdkVj8LaOkL3ecqCT2Be0m4T6olJ07leb+Eo3vw1W+FKj2
	 7Ej2incfewDbzcRRKpUY17c5rNggChghekD1+BVAK/07fFAR9PI7mGwajKWkaPH5u/N78
	 9vu4EPfDA58ar99fVki3cvNf5qzUuej0rthy7PbU6pfi5h9YIqRUnvkmmD02e0PJgFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CEWQeeO8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B2606A320;
	Tue, 10 Nov 2026 17:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 958B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CEWQeeO8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlQIMUn0WOLB0rv9WPk0YJZV49NU6IS4UzjocdSrYyBAnIEYGZDbck+1ZHhbEZbrTHFQ3xmokoooSy8ThY/4Dk+16EO7H+sTuus0trCAUJxtI4ROO+yDMJ40tl3RABdETTeS9SSW8PeuMcuStaMSYYL47spEH8cHAxSmIiKk+ob1oSlis+jH7+M5W8AYA+Ug3f3J/SrLMwXZ8vERPV05Wh4XRp6x1KhAFzSJq6svpxBQO+cfnYFGwdT9gSpZHvKGJD4frN35L2OuQFDWb1BA5ItnmNiAQ7OffCSkq52CTImRpwqZqtc0NgR8RETYVK4GG6sMUYkZt+xoa0w0KVm9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuqpbv0Oo/L5nrb8eszKvytHKVTY1a/44BgZjrMYPN4=;
 b=CUf47HPGwo/RXl4vUWcRhs8PbLPfnOOcYZv3PsT0bWUb9XDpvUmch7geDV+OuMtZCeShYQIIzrCBqOSyfJDZxQiLzRNma7vGIwa9chkDY0L+w3SvKREMiLQcoYr0nT0mmgLV14UebCH1fZm8CrbU1By6yRKTt1s58KOQBTX46xEYI63yz89pSB+xUiY+RN5wg+z5+T+0LEL1B3Lt1FLL1tThnWTBr+bgQb5Szj1O3ivEw9L/Do5mcBF1DYK6RiZzeZWi5OE3pQzs5AEmQSqEEHtDXo9bggUdFH2YVCUTT9sK5prGTmYqB1DfvtcuEmwVWqTketgwvSDjXGz1TxvA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuqpbv0Oo/L5nrb8eszKvytHKVTY1a/44BgZjrMYPN4=;
 b=CEWQeeO8rxJzDENQwy47GAwDkDcFOHbCmbFU9IYkEspcnRtveDbyJUcip9go2Y670+jTp/WCi1SWEbPvH43BMP8Ya9cgvBiA0JLO2AN/aAxo3xL0m6c5InC2/McDC4CQAGbrgldWZE6a4svjI+zbmKGceMlMuOsV1ERoI6MS5bU=
Received: from BLAPR03CA0097.namprd03.prod.outlook.com (2603:10b6:208:32a::12)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 17:45:35 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::55) by BLAPR03CA0097.outlook.office365.com
 (2603:10b6:208:32a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 17:45:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 17:45:35 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 11:45:31 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <dan.liang@intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v7] lib/group_cpus: Snapshot cluster masks to keep grouping hotplug invariant
Date: Tue, 10 Nov 2026 23:15:13 +0530
Message-ID: <20261110174513.461743-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0a1d0a-6622-46cc-356d-08df3f526c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|3023799007|56012099006|261009223027099003|5023799004|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	p5sv5iH21+GNYN7lpxeE6wVEuItebuvu45b3rzFGByFB+0HM9VgrO7Xp2Qv3buFKNQqYSIxMvfWvNOo3eS3cRgf0M88Zc3wB+YilGfwUBUbu5KqUcguExFddEFJ/Zpu+VydlAj7FQa333ZDrhL0JzHt+pcc080a7DGFDPlCSJDS8rMBpQesseK7hGLMkOmyfV4cfeB8a/tQkVNUVQZjtla++hHLrI2Mn20731MgQTt1Q/56c6Q5kSfcxhCY7fqKQQxMRHeSvg1wNgATT2mbLiXV4xTS4Qx3JTux7SmGWUTbYcT2Y8FpNVc4pniIvS6plDsOMEt8YJxxCF49y60n0InCLiU82xZYq5QOWrFpyuWd7zv8wq/MqpYRefxoTpOZmCSJR2OWiUB8pNc61csoqQiQ2k3aoRQuePuMJ4/VDs13UEUhizzq6gwyagyV7SplLN/qXDRMgh9f+kxVS1oEVIGfEOW3382kS4658WBUZXDNNL+rDaV8YdwTWAMeZcJcQM7R0KI0y5H0T+fOK8d7CIiRwBoIXmcXE/dd5QJQ5zWXdekesLovssZMqrdcmhdprjc29euNutRoe6NmRBI5utVa9FhZ4lveTBMQVvznlqviZRQ5Xs25RQaGZJSdSX/yDFg18q8rddfHqlaR8Gbql68qbIyQmiewzYAkE+Y5TntA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(3023799007)(56012099006)(261009223027099003)(5023799004)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/gwxx0NMhdWsOp79N7FhDhIDiZvcWInT5GyeYC1ILI/Wu79SD6Tcg6mHHiErnis92GMegtpjmo5IdcXviBbt+QzRLtwj1fbry5QiHbZkmpOxRzGojClp0UE1xrXKPPko8Mh66Zd4vHGQYr8SxpIrEBn9KuE4D58qwHQMhIhYyMaq+A8XvwqlBevwFwerB/OSGzOe2mSDgxZ0Ne8ygxYP0xa5Vi3rJ1bKhNmJj50ESuNDDlpEFDKgL2SapmXgYzg1hGhwV3Xgptu8n9pIhLAR/D/0Q2wfi+xhF1NwGEnPMm9MAXnj5eK5deO5hhELzxzNYsHHK2noOzeukMwKkRpvMcIgykwGkh5PdMM/U1EyPCJ18Ud34HPRrNub65bTZ+nqviGoB0u0SCnTsE2dGduRSQaNfBg/eBdHGzxDJAAx9FEVJWbGLZRZhYvtzEoPz6sV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:45:35.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0a1d0a-6622-46cc-356d-08df3f526c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

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
Changes in v7:
- Return ncluster directly from __try_group_cluster_cpus().
- Remove the duplicate done update in __group_cpus_evenly().
- Link to v6: https://lore.kernel.org/all/20261102070930.1803698-1-Vishal.Badole@amd.com/

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

 lib/group_cpus.c | 125 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 19 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bba..7d878c94898d0 100644
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
+ * Return: cluster count on success, 0 if inapplicable, or -ENOMEM on failure.
  */
-static bool __try_group_cluster_cpus(unsigned int ncpus,
+static int __try_group_cluster_cpus(unsigned int ncpus,
 				     unsigned int ngroups,
 				     struct cpumask *node_cpumask,
 				     struct cpumask *masks,
@@ -365,18 +450,17 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 {
 	struct node_groups *cluster_groups;
 	const struct cpumask **clusters;
-	unsigned int ncluster;
-	bool ret = false;
+	int ncluster;
 	cpumask_var_t nmsk;
 	unsigned int i, nc;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		goto fail_nmsk_alloc;
+		return -ENOMEM;
 
 	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
 					&clusters, &cluster_groups);
 
-	if (ncluster == 0)
+	if (ncluster <= 0)
 		goto fail_no_clusters;
 
 	for (i = 0; i < ncluster; i++) {
@@ -392,13 +476,11 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
 	}
 
-	ret = true;
 	kfree(cluster_groups);
 	kfree(clusters);
  fail_no_clusters:
 	free_cpumask_var(nmsk);
- fail_nmsk_alloc:
-	return ret;
+	return ncluster;
 }
 
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
@@ -442,6 +524,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	for (i = 0; i < nr_node_ids; i++) {
 		unsigned int ncpus;
 		struct node_groups *nv = &node_groups[i];
+		int ret;
 
 		if (nv->ngroups == UINT_MAX)
 			continue;
@@ -454,14 +537,16 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
-		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
-					     masks, &curgrp, last_grp)) {
-			done += nv->ngroups;
-			continue;
+		ret = __try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
+					       masks, &curgrp, last_grp);
+		if (ret < 0) {
+			kfree(node_groups);
+			return ret;
 		}
 
-		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
-				      last_grp);
+		if (!ret)
+			assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
+					      last_grp);
 		done += nv->ngroups;
 	}
 	kfree(node_groups);
@@ -496,6 +581,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	if (numgrps == 0)
 		return NULL;
 
+	capture_cluster_snapshot();
+
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-- 
2.34.1

