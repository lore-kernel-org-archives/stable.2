Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD44534B9
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628556; cv=fail; b=rLk9CTD8mldheLf4XH/LIDrAryxfH4ftyObD1p80tIZHOOKe+XBZPfFC5Yaiyd/z9q9dj9YqQKhzSPW7Sb3FZNLQwIZrnpA5bbTIRAg/r7iMmQ/mZ1a0AR0lG4EZQGa4gbehDT3oXZOoTFH4ruUzKdzlGHQv5MwQWS6rYlGHPsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628556; c=relaxed/simple;
	bh=86281VJekQ3rpb7/VQS5CJVxPAc1v1GpP2e9U8nzjgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kstHnbydmBIumt6sgtUT8yIk4KgngKTgh9Wq6SHuiy5Z7vqbmfaRpT97nnioH1y5zEYNn8coDqgrLLDEqTPqrL1wuuvpDup7KIyWNdwI+jM82SQ+Gl+QdBJP6s23vYBVv6tH3bpUmMLlyoZX+3fHLgDME/kGhRrwk6NMNNgXgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kZCpjBkA; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kZCpjBkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM5gz/9kSZ5sq8h1I6vhsnmZye/IKlELbJ/LfI5IadPPmyY2lLmqMQASfpEw4BtliRTg+Qw+gWXw2LhEbuauZmtG8Ede6Nq47wKJpG1d51tsrQteoBlV66E6LYo/r1g1pPcNNwIv1ekPMLN9vGRBa+naLeRNQlclQP0yAnd7R6Al7RD+hgN+j3aeNoXo1G5VUNUaX+NUsbM9k6kWPrzGt9LkMfFjL3OuTkZF+fqUKP13cxIuULRuXB8n9aMPu3C4nqWKhnKZyfahto5zZ9sYmBcgA2lz7daFr8ofeFOf7aqDHSZZhtmAhzseaWxneAaFT975o43SPZVgTS2EtBWQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmuuv3mj5ujKeMlSIk3zTBe2achtcILwkUE0e6UiDl8=;
 b=pJaoej1DKU7g4BbKX5Pu0g95cOsKXVCUBTAcfvEb5T9xbbc1WmMCK/yEZos2IDj1rPUczK3sQ7HAo3TbUBDnRt+Ifynu8bNdnxqzzqVrL2021qyRMGP2ZuBXE0j2DNd7bP4RYrHZqRvKr8bFHDJ9bdxRbB9KvT1pKf0lNU+YWYuPBn11xB12HNvi+b5NZipHDsyX0nVD//DXnxhnddkQOjyjJdzRG772zWZlpchKVvsM1ewXqg9DW8zm/tca5oew1MmlODsANAJ25jAi4PNF9CDov69BI6IxnfuJK6g6gf8rpi+/XY+W5urZg9h4jOINiGxTALzSuHqwCMsfBtN6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmuuv3mj5ujKeMlSIk3zTBe2achtcILwkUE0e6UiDl8=;
 b=kZCpjBkAzlJRxURwWJC/vmBGNI312xYQ6xCusg5Lhghh/eaVyLnsbMcdAn4MuPORkjPBShMJW8/TD9cLFuozbYNcpKZJXnxoD2wlsTjludVKb12uVfSSCTFYx5GL+sHqd5KOpjvB3djgeDCtJ/5JSaYr79OZKm3Ww0LjsgW/w/8=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 10:09:10 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::1e) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 10:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 10:09:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 05:09:09 -0500
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 03:09:07 -0700
From: Sandipan Das <sandipan.das@amd.com>
To: <stable@vger.kernel.org>
CC: Sashiko <sashiko-bot@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Subject: [PATCH 6.1.y] perf/x86/amd/brs: Fix kernel address leakage
Date: Tue, 21 Jul 2026 15:39:00 +0530
Message-ID: <20260721100900.2860022-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-trickle-dance-0971@gregkh>
References: <2026072054-trickle-dance-0971@gregkh>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7353b3ff-bc0f-4acd-bdb9-08dee7101b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AvCgJ0R3g9ii5KgfSEJmdnThGMnu8z4XDSUPHQDn01jXGzscc+5FEuBkJOsW8oyJdZr9zpyTU0lqL0rgstM9iJxIa1dHeNf2UzuEpTAPmJwwJeFY48XoDpzr4JMJpJHzziDqID2KLIKoICFoRFUadWSxNCjfY7ENhg/SPvRdFhhpeesIeIRouRIthyuegLKJNv+fgkZietHzVrlN/asbl/a1JOoXGpqfekixTVixGgpMLXRzi2NMVLdZtS/SNuDV+WaTv4X5UHtfMW7D/c0Rigg+bwWdUWCBjNUXXrL8KkPzEKdfDnN979V1A5j/NdIuo02858iLD8cU+sKwnGzeuUC5jumWFDtclyKOVtiFvZfXp6cZG7KZdxhJWT6KGM3ufL7kXZS1+Ckovyho/WdzUjxePWhf1xzdaehblylaHbEHst3pyvkhfqJ0P5vaB7hJpPyA3hF20XtWpDVLGfB7uOVsftJJ6gyBlf3NxV6mDZxxWocjTHlREEgcRxXCIY8NlG0iISz9KJZ9zChZScaf+6uMlozuSxJrjwih2vfR4zUWrJ9x839xzpKNjOKIXwLm32T0Rr+dTXBPAqLLKQF/PdYXpgBdmS95ZDLHCI1UuP8/xJtg6EA4UwoVWzob+381ZL6fFIkg26Rsao8RBb/51A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hyDsA2mjhzxWnTrnBn9CgHftxFRwwwrrritdrGi05BllwcclXJEgGOECLQVldVND4xErO4pl5zoqmpaa0HVXA/kfK0uypXI+hdoLiy3MrgP9eCTcy8REnNi98L9zYQC9No3EeACre2GQfovakW9d0G8ciYgxOSjRgmV91NdvpD4hQF7jB1tqtlKqzj3VHOgAjDHLt760K62N85+HCnvjnClc6JV1mFjGh4R7+c2nsXJK0aYWQe4KsynKPPSnFxiLhWR9wfz/wMSpx/LlCEEH0qduqABr5oie/acAk95zc44+cjoxvFd+8Gi9LUxE+QraJjrxlutyT0ikJat8VrNeyxQSAERV5frDzaxxpxIBLnJbKr/7eN1yd0wZyGiKF0gOHkGXZFFvIfjqc6b5s2bHOwnAbkfvPuFHGOOBXzYovAh5Njuqz1/++CImgcsMg5l7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:09:09.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7353b3ff-bc0f-4acd-bdb9-08dee7101b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

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
[sandipan: backport to linux-6.1.y]
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/brs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index f1bff153d945..fd46e73cb8e7 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -262,13 +262,13 @@ void amd_brs_disable_all(void)
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
@@ -341,11 +341,11 @@ void amd_brs_drain(void)
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

