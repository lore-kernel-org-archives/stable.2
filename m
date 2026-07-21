Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D23326D51
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628720; cv=fail; b=N8c3Bryd47tEehxh7eXeRZobHfTLHsSef5oYLmnlg98Hy94D7U3qWHIT86SZ0urzoARdXE5GXJuzzMrBN3PAXg8TGSYdFbbdjNHzI+emikU9A56dyUkjGr4x8x/DvsgeotRHxMapTK7hRfvxWVWCwZpdNlrCJb2XC5DkqgqsbZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628720; c=relaxed/simple;
	bh=HakN56UFxjb3uGfdxl1Co4+mU5o9AV+wftmU62JhP0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1RcjPAh9X3eS1BbJ8FYs4whlvSQvokanOTMfEHbfa0mDgDHtoPYdPfARE52z8j0rTplYwvhdTCaMvAWWszB4UT3qxnn6VUSzRbgles9qr3XKr3g8unps85fs1LC3vbWIv9/C9XiKofVvFz9rKcd244ZJ6J1j1FOucj3dEpCFC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NymItuAF; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NymItuAF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6ueywtGrKmL+ZuRXeSuuKwwo4oPC7BHlNGvEy19fpv4LSPtjo0/+Nbo5fg3QZohe3g+M+9c3XCkdDyJyTE+uyO7am8jCQVqveXHsleorNpRHNftL87R6DuA4StQzZW6A0/59wFDB1G0WDzVSebLbZTQuBYGZUUpDvrzquTK2tPtgE8D6U9V7p6FhbsXnqiHy43FoyWG77ilidx38HK11sQLdTqoP6E2ml7IMhy+OMKmD69TlLSk7jT9FMc6o3PgMAxZe1xoPFThdM37jRAKQ00K+d4g6L3aY5jLAiD2K/zKYtWB1sbhy5SwfxQK4N/nG5l+fAq8KH/SMOuS+xMSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEJd90KP47DBhMEugN+o8DF35ohh3Yb2WFOUoy5U1fY=;
 b=XS27VFvh138r85YbXXuF+Gjok46at1qWxGcuOV8XTd8/OtA6zJcYbEtIV7D+uSovcLzmtkYWe7XO8b4+LkYWePfzKSVjgJkTXrTK0RrASJHjXepI/K5JMShwNZ0Ww6dtNiR6GpGu1t7+JHGUy0/poI3qdlyhBT2BlJOpTrbPvHEnd7BwMBqLO2FaVZjHCYzswLfmHRzCoHv5mUWTZOwpPYUtNJcFcNTXPRlwDHiveTkDo1FvTslX06XM39lIFherZ5JViOwu3L1DGUMCSrTZO3mEooEUqu9M4/3W6zWRccpBdm8pgp7THS8/q9/igvDqyn72OrhaqQKJxdBv+Guc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEJd90KP47DBhMEugN+o8DF35ohh3Yb2WFOUoy5U1fY=;
 b=NymItuAFFI4cgBNXhxb/Lg2ArHeNkiFWiouDlsQvFcZU42g4EWyEj0BsXeAIZFwcVg1N2gbWegsfEDTex8mzDrf216EHcMxPkHZQtj5ONa+pF85kzuXJClSfRUxQQQJ+4CGi0ZQun6d+U/ExhKnaaKrmPas3O6GPxNzcgZ3mCps=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:11:55 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::39) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 10:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 10:11:55 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 05:11:53 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <stable@vger.kernel.org>
CC: Sashiko <sashiko-bot@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Subject: [PATCH 6.6.y] perf/x86/amd/brs: Fix kernel address leakage
Date: Tue, 21 Jul 2026 15:41:45 +0530
Message-ID: <20260721101145.2864360-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072053-bullseye-luminance-4677@gregkh>
References: <2026072053-bullseye-luminance-4677@gregkh>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8780cf-4f35-4742-dfc6-08dee7107de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|13003099007|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	to8OheVPm6Zv9Io/DvGx+6QIJSg6EukU5lkRxNY/mUHUDhVoTgYhLYrvsUg1WGeO76OuTDCsP0F/4XXcAUnvU9GRkcGd7TE5bo2h2qUCabcUWu9rfi7e87qcgczbWpdNehNTPslrdHMPWhVpTxTOSQdbNIhjPUZ5a3lQuTtE5UBjJfQYPdeMH3HS4JjO8JQcWqwgarVwWwgtLPHZO3EHs1SCT9PAeDv+fcJlLmY9aPHzYKClaQN4CFNLil1tfO8+ZF84X0VRsN2Xcwyhlq/pNbFqKI756D8zZK1kRazYXNjdgcj58GYR49hFbdSFGmUDVrrx7hU2iYHyIKr9CCd4BaCyz+0Y0HtuoGd90xHxEOqcOuB0mWhLDgULOWX4ph1iYNd5bShZ9fSZT6MVWpAwf6OZZdRS+zcRx8RU3XPhPb90cR0IOyr4lObScAqPArIl2ZQm4iA9h25qSS78fFnJU05av2LzOeyhL4ppVNY2YDGBr5ys4gifZ2ZbK6BGuJx6+06NC4c5UZpUUi0HCvykDlWa/8XYXsFjjrGFARL2b4RjGbmhnhZxYY45sni9qSl/WYaK0i5HZZJg0Pop+aN2E/wGTSQXVDihjbZeGryR91urX686AtIT+mnv4tNME3WPe7uyK0x4wBGu4nYRjXTpUa8TN1e8Sd90ZQU+DA3JwsI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w8zMA3PJNFIDfVx8cG6mP4YxAeiF/cwzPwCThUASRbH2ugRja8vEDo7bGzT9W5lILAW92l+a5RMbKJ0KFTjENiBCbZBUxSWQy+2vm8y0tp2fsWxWztESB6KKrxVfRI9GEexBSaklVXizBWQ8yuQsPrVVdyvO4aIRRwxS9gmAIXCgYI34EcAbcz3okYV3Gml75r90LXFuMoStJtsHoCUwiGBUOJAlFOD2zuWrbJz6xtoLp9mYJJIewopB1PXstDIsQdAoqPZ+9iLTh5uxMI5GnTidP5wigEFx1V7/zb1ScjsKAcsz6y3Rf6HVDxX850N7XeGefXXmtPMf2tRPwwCUDJQ6IOff4STZLu3yg0zcWdLu6ihepHRiGK3eyq4Kdx6aZ03CfHkXUcWkX4gGn1aHiO29WH8gPSwwCiU9KubTuGwqMZXGelTgCH3IKZQTj9Vg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:11:55.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8780cf-4f35-4742-dfc6-08dee7107de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702

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

