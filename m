Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A5433BA8
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628838; cv=fail; b=nF0znuLaZOEcKZgDE5T/dA8Qr/WpB9Kf22lWg7rrOOm5ed9Xu5n0YSsAgaJuW+75diNDsmiPr2oXqIIcyx1P9thFMbJe/d/QwQCIKwregjA9As8r71cybgApNHq+U65U94RDjZ5K1aojE0oIAvWwrCB8hstr5ZvjVgBsd/RI3Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628838; c=relaxed/simple;
	bh=HakN56UFxjb3uGfdxl1Co4+mU5o9AV+wftmU62JhP0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QssQusoZeOilhHpjK3VL/Dk+niW2OUdOQ0oKM0ZvO2SCX3hv8xAm9vj7jdqtV3bd07beSHU+p5o04HvLrPhrEFx0xJD0zzKwgaSsmOQWk/HLVV2C8T01rcxZxgSW3jmSVlpl3cWNok6XZPonLMSJCbiw034D1gNuRWYCf74OIjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=txcLDGGC; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="txcLDGGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3b6pcnlWKEDjZDNitiPS/fO5rnR/WlZZoCktar+9s9/v2ahjy0iSr+7B0Q8eKsJai1ccZepbE7ZtzRjyX2U2+jzPIwRjeU72G5JPr+PpGSMcCZPROuIYOYlijIfOHx/Lw1CmCeL0Tn3dIBNI1I3QW09gSNffa01Z9lgjRyKshcuoO4XNRQAoTFaksr3lYaK4T6THeep9YiTgw4kb5qXLU1hZJl9CYWprLxJUpku26yJeJ5rJWCJD3Q1yIGWTIBJMsDhdBADAy1zmRXGQIHn+EpS/JugPyPQhYlhpBE40W4BOaQ71pKLLg/gHOts770vl2ToHOWRPhEF+IfACHjo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEJd90KP47DBhMEugN+o8DF35ohh3Yb2WFOUoy5U1fY=;
 b=Y6R81XW+nrRQtiZHwYfRtCKSuNAnhXdjtqwsTr4xAaTq0CCztSJBZZUnrKB9aKw0bp3OBCETrVKfVNEZTDap/p5JQ6Ql+VhOB1p9cV+8R/cJVzJIJj/pVEeBd1q/loXS6tLUABXKB/TcSBx5m5YQQUTyYRkx3clL+IU8tCC6MZ1zkju86RntsMqrDmKJXy+AYlEegqWfGK4Etm2ay9PqvKrjOO6kjQVrhXK7/gU+C50qLSccCHxjOICrsT8c1rAAWLCmQBZddOg53M+1YodArXtmiZhO7FKrAmHr0LuQx6acFlFrhtTOMU6CcTeh9zJNCtHpRg6xhSkBU5fYA+1SNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEJd90KP47DBhMEugN+o8DF35ohh3Yb2WFOUoy5U1fY=;
 b=txcLDGGCvVWcvpVv0Y7xagaklVO9d6DHsJUCarkoxTG0BVP0/4s5ZIXa7tSUvi15RCX8BpFuuQEy/t9psHuTbyJEs7AhwxtOH8V+h2PF4Vmyo0Y3gSCK2/YV/HBcBrmmOShWKVMC6AYcPXOaSaE+P0RNq9wLhT9Un+Tq27Ts3Qk=
Received: from CH0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:610:e4::9)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 10:13:50 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::78) by CH0PR03CA0184.outlook.office365.com
 (2603:10b6:610:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 10:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 10:13:50 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 05:13:48 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <stable@vger.kernel.org>
CC: Sashiko <sashiko-bot@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Subject: [PATCH 6.12.y] perf/x86/amd/brs: Fix kernel address leakage
Date: Tue, 21 Jul 2026 15:43:40 +0530
Message-ID: <20260721101340.2866795-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072053-paralysis-glancing-61b5@gregkh>
References: <2026072053-paralysis-glancing-61b5@gregkh>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 05744db6-5a7b-4c6d-6e5b-08dee710c2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	IeCGeH0QhtUEvoWDkUavYbxmwQb5HcOfqR/jXbQEy3qky3OOLphZOLs3KIgifnvE8clgEAFqwjlfR2Skb6fj2reH/uZkXqi/hfd8APavg2L4awCeIUQhCauzY1IMFjK2sBefz1O9JO3toHR7V72WcfUBY8MUBW5J45cVeNJ+0NdUFRef/Z48sZ31mrh7Pq5Y7CkA7D3AX+COtijWX44G3P5v4qhJE787smpdsbxRKEP8exyhxUTGNxdN3cX2n46D8Q2HTJdXozkKHS7Lwz5HcMsj4XkOaaJoWGgD60oroDbVbgswdlX4AxHZ4kLjjW8UeNK8HAfFmo7bhxuZbpJzK16sOx/jli0vzpAtjJObBKzy4XSsMsNuh+tHG4N1sMCL5K66hzLEigvdRPVCvVajqOA4YnzL/vxeKTfYgT0sENLubtYdLithpCmXQT2xg3hqpFh7H2ZJJKYhj8vU65FHuCngdVVUgRrGq/EY8NEsU/O2dWDUWw4hiAjZCJsv/DDiMaSNMsa4NoHmFrBuAeKT9NJ7bBQJjQpt7lrW2NCa0LEL3dxV2LEArnTr4gOeeZln71Mg1leAVKJ139+o2cACsG7UP0QMuy63JSYBrjRjKFQ+OZOJ5rjVJOGonYF9yraHwPV7VTo+okU1QeYHmrp6oLuGrBC9eoMaiq/2+DyQSKk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VGHke5dAycBQJWxpGCgfrpx43hFobziKNWJT76ySZoOCXbGEZwL9oS7etsFjEoFKRkYvVGbPb2toFt3GaDNFg5AuMjY5+UG8pzr4kvu3cr1M/+vj9jX5WGRyNLL6Vbe6pvrWAPFipRtPXJA3SNx4n2CTWoTNnqfMBVcWN6WKW8ddXqI/+EfET2OMNrGeMu4pHZ0kbu0raksCtXOb3+xPlzkJGZXTDHaq3CRydPnXkBBvmNoDppquNXN0cOX0J5mEzE2stgGKAjiUMx0DGhvTHXGm7a9OFyrnCTfdwUp0qd6ZgM2ZZUkMszXRXQFaGs0opfU/ANFcDuhuEJdGjLZEaLmTreDiv59cjNYDnKWzJ6Bqml8hDr7iKPTdx/ohSxRr5RH1km9a6OjY4Pw5GuzCrytmRmKn0S8GSB2bpUQN3YuJnQO4/vr79agIje57g47o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:13:50.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05744db6-5a7b-4c6d-6e5b-08dee710c2c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

commit 47915e855fb38b42133e31ba917d99565f862154 upstream.

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_BRS (Zen 3 only), perf can still report entries
such as SYSRET/interrupt returns for which the branch-from addresses
are in the kernel.

E.g.

  $ perf record -j any,u -c 4000 -e branch-brs -o - -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff810001c4/0x72e2e32955eb/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94a9821/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94ffa1b/-/-/-/0//-
  ...

BRS provides no hardware branch filtering, so privilege level
filtering is performed entirely in software. However, amd_brs_match_plm()
only validates the branch-to address against the requested privilege
levels. For branches from the kernel to user space, the branch-from
address is left unchecked and is leaked. Extend the software filter to
also validate the branch-from address, so that any branch record whose
branch-from address is in the kernel is dropped when
PERF_SAMPLE_BRANCH_USER is requested.

Fixes: 8910075d61a3 ("perf/x86/amd: Enable branch sampling priv level filtering")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://patch.msgid.link/f05931c4f89a146c364bd5dc6b8170b1ac611c65.1783701239.git.sandipan.das@amd.com
Closes: https://lore.kernel.org/all/20260710110235.F3FD81F000E9@smtp.kernel.org/
[sandipan: backport to linux-6.6.y]
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/brs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index ed308719236c..01fcd43522bc 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -259,13 +259,13 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
-static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+static bool amd_brs_match_plm(struct perf_event *event, u64 from, u64 to)
 {
 	int type = event->attr.branch_sample_type;
 	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
 	int plm_u = PERF_SAMPLE_BRANCH_USER;
 
-	if (!(type & plm_k) && kernel_ip(to))
+	if (!(type & plm_k) && (kernel_ip(to) || kernel_ip(from)))
 		return 0;
 
 	if (!(type & plm_u) && !kernel_ip(to))
@@ -338,11 +338,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
-		if (!amd_brs_match_plm(event, to))
-			continue;
-
 		rdmsrl(brs_from(brs_idx), from);
 
+		if (!amd_brs_match_plm(event, from, to))
+			continue;
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
-- 
2.53.0

