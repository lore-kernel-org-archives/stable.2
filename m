Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF925C80E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615146; cv=fail; b=UrQ5yCNI42ReRo9imTyNamQy6zOXyvha+KuPhSdI+3JTjPkztj2rxW3leFfVMMQBNHF8FTs5PkqMd/HpUgig/WrdD/FY6X4EVU7kSsASo6cr/Xb53MRHEWj0T2iqNHNGksKB8E4Lhkg7gH0tkMZsVXl1OZRdlVU4iLgUUR+W/hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615146; c=relaxed/simple;
	bh=XjqnEUzOJm7Ex4JI9e89yDILFY/zFTldztZqpCWx+k0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSF7qfpQAkrypNXRE+f/4emzok8wQSyL/4/66bcjlbgUx8Lyhbje+ADjZyKdRdBmKZ02kz8NeLHul2Dn+8o3J3LtElG36ztK14f1/hcWuK5xv4j217+OqnwKhKIuT4Brb4BYX5cnqf2fUdCO1nEaVHMhYf1/4g1v/0KukubnMWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8J5k4Md; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8J5k4Md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIb55R6aDmCYHwl4wknZBS+T+xQt4cPjfMWdDVQuLG50K4+TeMHdK8rBTx6Fnz2v0lrLetHH9XKuLDEwQv4lw4ReKxHbJW5pGJ+MVJR5+/PMCJuHeBKSB9wfzgy4EK1M/ttgFNlms+IGyEP0YnAaVeyafjnAb/Ki+U4vlKY0B/Iyxttos0Ro9fEkG+J/YM4O+y/QbmOVWbd/Htr/G4v5YjS7iII0vr2OmTEfCyArY80F0cY5fNZMmzfFZCmoapg1rUx7emu0wuwTE31L3auKsII9PjvL+SKIZLEepRPgpJxsjr4vl4DrFwmgAYyirRntnFZUTWK9EwLqDnytH83Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvE5yldw77zspbGh2Z4VLkYxwscUgjAvegG75mQkpts=;
 b=n3WFsEYp9UO7ixwcvJ3wsS/hNNreEJqTYotLXuCRB1U9e8CH9d3EUCDyd9ZKPsqUdOO1Yt+8bify2ugJCemZfc4bCnnhWulKrpavWLQNdoBGl1DFW8az09wSpDlxmeb49i4rb7DpSiKwPr/qiO12qwTuaRFzCHXDcLKOnvLq9nDXNYSVC4WNL2UYOGCclImnLLOEl2Xz3nmz+msK2+ZmNyyNlKhbPMOkU6LoK+ILI+oIE71kzsA9PlBGT5Yyvc4eZyHkvqrKoBzd9RQvFgqr0Vq7YzkiVV+2HyIKSzECnLXCRJ1IC6TRtlsYsDpcmVn3zT+pt47AQo5Y8SS3eF5AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvE5yldw77zspbGh2Z4VLkYxwscUgjAvegG75mQkpts=;
 b=B8J5k4MdmcdJXa9IkQczw8XQ2wqx3tCXjU14swE5jLGl14SQrZyQ54W2Z8otcZ0oSOUcnmCbh8auGk8kiZh+sJoLhQNwQVkdlk+Ww2TsqObodeHxRXxRmdNwN4GrR5lD/tFKZCfVd3DSDVQ1aKSDDNxmrBCB7YQFKIsHKsiZD4A=
Received: from BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:05:41 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::44) by BLAPR03CA0061.outlook.office365.com
 (2603:10b6:208:329::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 13:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 13:05:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:05:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 08:05:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <christian.koenig@amd.com>,
	<gregkh@linuxfoundation.org>
CC: Honglei Huang <honghuan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Date: Tue, 16 Jun 2026 09:05:31 -0400
Message-ID: <20260616130531.738887-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e2c0d7-2e68-4a49-f6e0-08decba7f7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Uymkv3dF//K64v+UFBB9htcpEQzrBrJJJKGUl02l12Zqo5y6tMtgrYM6A99Y6vpuTZtMPKv3cbyEtKkNHjuAn3zaYXrVdNeytF12KLdME5p7MKBbVnuPVZyqrUJnfncRWN63WHaq1Dmda7ZOrCjge6QsJtkkopkLSqVGBChIn7vRl5jsR2zsfnJziJuHU4Ha22tKkoqQjaiWzLGkDrGY/NtqqWDtj9NQhCRClSY2LT2C9AV9XT2XhfAtNGdjMIGXZaOxJ1t1XAJuqOmfk/mLhTNzt0QnFc4tiAOMv05mZ+FuooKcWUGaz/XLy+5lraEX8J/PMJkoE2XNef8Wkv13jLAKGiQngIUNyIzPhxTBfLMsoOJiXAWpwhuuTaYjJIav3GZkM1oedUHD/MKYH4qyyc16Jisdy2h39znEIzezdmD0Ju34x6WOpDhixoSy6D2gzrWih9/tvXkSqTP1uVxszpuqwZv30hQUWxKSlI9N5lQqjdP3JJu8VtJlrAlgRW/+EZ5bYgzaJtXTUygf/kaVQBA3ZONAI6oh4WTxLl+XD8Hn+hLWq3nuKLUL8iw0so/SVQoAwF8lhTaSIDL3P7IGNdA5A+RaEEx1IwGuU2LNk1/Rv26bHJSZzj5hqtyoGOjufayt2HFOihELRIis71X7EAu7HuLhTpgpbq/+CMSYQR5ByxOxlE0L+cMfrPUKD4XoY+BnyMb9Hoglo/FgWlmBN+/l0585NCetfT4cVEsWivI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Afp3Jz3MI/0QYe5IU+R/+eD1gMBJwE/i5rHCrroEStUBNFsiq8zSlHC9ZanXdVetNePpShT0YLTClwYsFcfZ7seRLuOVlGXLptwDtusAff3UquzA85AzCHH58gnqk8N4ui4iZwvGY5ImKe3hBUk0nvuHEyf6GCPxM5gf7uGpVsL5TG6noXuddberFdNKCvTFTE+IN9xSwqIZy8+2rXvN8VJFuQV+aWtlC012fE8nBEH9V3nVlfjY3tHde3vUBbqsHsfXGTEfhyzTBE2A5pEcG6qiAz+ZWP/AoNgpJTKBafVXmYwXrE8FmYGtlHTI8GfeNCLOGNnNKQ8OWyZaYXAs71Mb18YFT02F5hPQtU9RPozrB7k1qAjOSwNwCbdSjAYCHCyLPmLnlmOyWLYWP/xO/ynjTKOxhNOIfjPlmi4xgCMMzjo34UVf18zu+tcbgl0U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:05:41.2521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e2c0d7-2e68-4a49-f6e0-08decba7f7fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

From: Honglei Huang <honghuan@amd.com>

Since commit c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
moved mmu_interval_read_begin() out of the per-chunk loop, the
captured notifier_seq is no longer refreshed across retries. As a
result, the existing -EBUSY retry path can never make progress:

  hmm_range_fault() returns -EBUSY only when
  mmu_interval_check_retry(notifier, notifier_seq) reports that the
  sequence is stale. Once the sequence has advanced, the stored seq
  will never match again, so every subsequent call within the same
  invocation returns -EBUSY immediately.

The "goto retry" therefore degenerates into a busy spin that simply
burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
finally bailing out with -EAGAIN. This is pure latency with no chance
of recovery, and it actively hurts the KFD userptr stack: the caller
ends up blocked for a second while holding mmap_lock, only to return
-EAGAIN to the restore worker (or to userspace) which would have
re-driven the operation immediately anyway.

Drop the retry/timeout entirely and let -EBUSY propagate straight to
out_free_pfns, where it is already translated to -EAGAIN. Recovery is
handled at a higher level: the KFD restore_userptr_worker reschedules
itself, and the userptr ioctl path returns -EAGAIN to userspace.

No functional regression: the previous behaviour on -EBUSY was already
to fail with -EAGAIN after a 1s stall; we just skip the stall.

Fixes: c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5393
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 342981fff32802a819d6fc7cf3c9fedf9f3d9d60)
Cc: stable@vger.kernel.org
---

This patch is from drm-next and fixes a regression in a patch that
went to stable.

 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index e452444b33b0..99bc9ad67d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -174,7 +174,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	const u64 max_bytes = SZ_2G;
 
 	struct hmm_range *hmm_range = &range->hmm_range;
-	unsigned long timeout;
 	unsigned long *pfns;
 	unsigned long end;
 	int r;
@@ -201,15 +200,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-
-retry:
 		r = hmm_range_fault(hmm_range);
-		if (unlikely(r)) {
-			if (r == -EBUSY && !time_after(jiffies, timeout))
-				goto retry;
+		if (unlikely(r))
 			goto out_free_pfns;
-		}
 
 		if (hmm_range->end == end)
 			break;
-- 
2.54.0

