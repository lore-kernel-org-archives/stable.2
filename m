Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFE1A0B15;
	Sun, 20 Sep 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928254; cv=fail; b=hdxSGeO/RGvkuBafyC4iYYPiXlD6WoFc8J4LVsYlfE9eg8V4mw3RRISMstQVJihnZ/L3daCT9aD5fguEgl8BFghpfNUKE4Z7yaM3HJSa1zEkON70TYBrnqOLoNV3qwt21eNsmHvgWOxVt2WQX++T/2H7iybgCHi5DC2++WAyXXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928254; c=relaxed/simple;
	bh=tWfP2theVb+FGi6Df/pDgswTIV8hFpXpyLeYFndKyFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bkfq75H9aroeLnUNG+x8rqptvhcglimtg/EgJ0UqX/upTRYJj4eOdF7vJgz1+OszeN4MEstoU/2x0EJ5kEBX7DpReLKmvE7atUov57WzHgnEvtTjObsyo9yt5vPwmFPFh6nrg2xTwrEXtdWAIswjiPDzMMCoqwOG8oZmb1+Pw/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0CF+RRVj; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0CF+RRVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7SAwY5/dI/wnqupVIM7ZytCsb+TfB4nbZbXMugqyi4K3hjpYRng33R5yGp2t4fJIz6K4pIVdexBXY+/UR3ipSWY2DB2ZFb4V8ESQ1mW1jYxV/9MopU7fCJuZzYWo3na0Id6ZO3KbMwbHLDU6HcXSrc02XTegRBFsUesNlNzcFldokWksf42HmwMwexLNJj3V8WGzEP97rNpfhs/rLZ+MYzDAeJulC6w7vow70RnepYhQLIWeqiSUY5bD26HQkl5Vv0C0ZzxHYqiL3GzM4u/1ZjSvwQCJATbp3hHiztFnaypC4pEgb2pHa8nWtMKsxq42ek1arcYrtqEM9hk1Fp9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=oZWbRS5ZZVDYtoF9CSSnLvRbUf0LfCTyUHHDgSzhSYF4BpRKerZ1D7VnmmHxDglmQF2ZTCpzntJF3wnv2Dh4z5u4RTcQb1ajARivNeMrHHwSBEzyEy+NGJVJkFbahnqXcyT960uu1DEgJALWRiZKRBOsSNmcmBKLWU4HgC+KmM7cpYw7gu2YQqyTSdkdyRYBgtzENHTT6msO7jc5a9sqpayEWbmqlY0bk8fuFgNSRAY5fPL7DhywG48OihAHp7Jg3BCnnFinNEaxM2ZVUKX0K9rr2o2btb5FQcSCQaLKMiFRTDd740LaI51xBr6Xua/Fy/HzS8APFHHqjpewolNMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=0CF+RRVj1iNo19rE0GqmqS6ZU9w0H0xZTvTY2R1RDgL817NdF5Cq+W8Cf5tITi3MccodQieM/fEIrXFYRsbODxPfkvlW6ODU8jWKbjyXzOVo1hB0qNMx9x8M+8eBad6zVx/YQ77TjDNKGWnDeS3OrH1PvuHysi5OlPz3uqpapqg=
Received: from LV3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::16)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 18:17:28 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::2d) by LV3P220CA0004.outlook.office365.com
 (2603:10b6:408:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 20 Sep 2026 18:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sun, 20 Sep 2026 18:17:28 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 13:17:25 -0500
From: Melody Wang <huibo.wang@amd.com>
To: <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <ardb@kernel.org>, Melody Wang
	<huibo.wang@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/8] x86/sev: Make SVSM calls preemption-safe
Date: Sun, 20 Sep 2026 18:16:53 +0000
Message-ID: <252b622d9df5835a929f7cf8e34acbf0fea6b334.1789927246.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789927246.git.huibo.wang@amd.com>
References: <cover.1789927246.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: a2550cdf-4d35-42c4-db0e-08df17436dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AUyGE09+C8ctASgQHNGgxZFd5GiK1zUg3AK3XVIjgSn9ism9dh3AQZEOCfMlZCZ0vX6p+sMrmLUVgmTkWdxGaF1pFGqW9+P678fTwVsAB8M7ANCMXzxSDdjpm0ASqKylzA76oueYOPf50lOgnwjkl6n4iV10F2mRinuD3ZIcFJvDbrHfZJQlW/3MeGt0Fm/pOxGe5gLBFoQl0g5xiiNm2Wpy5kYzqiQVij/Nn4oaPniuJMUu87Fob88i5u4IsiQrmE3dWCfkBj5WW4iq6piAndDDccq8xSrEl0nWpTIbyoy9W2UCqS+qnEJIY8ZlUNBrbL4BoiojQDiVEAJee4yv9Y3YXmK33P+WdY/aVTkBtIt0kLT1qasy1J0FpNgE/T/G/7FV5B3TmQGKmZ3jbTo3Zt439NDOAcRV1ngLvBOvQPc90iILxrPll5DwnBj6Kits5/ZO19095ud5ChruHAitntaru4XUrTQuWlOyLODsiykqQoOZfHQabDAVXREgu378ZMKtQiiBjD46K622nedwnIQ2OfwgKscpeYwxWcLwm9nIBqCDiYxQjab/cCpTC26h1VeQf3j3DGqVLGsAfPiznq8AV/VafU+JYaabVLkjmH3wnagY8/qUzJcyM6M6rMCOCJ+gHmjMm2XI89ITT/mcW+MMpc++fFFB6FN09IWiY2cMUfvD6k72/vkCIEU1qI8VKJDhDHyQRbcscqMdC1jhxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MnTof8PAmVGE5yp4a0EdYPyB6P1S0+f8GFzSYYBQJlYFQJmetXRD98PWNoRxBmQHDbcs+lGIItWUxxlivKXtFHL7CFqfwItlGOdJOkJLV54crTLRkctzASUoeQ5DIaffk3aKMoUxoCDLeb5aH+68B5u5+lCsG9oO6SSoghaw/VaU8z39yjxcEQtxTJY5zA4dWfgU8qUwF0g7AZniy6Yv5D1Do+VS1qKye6cm8seOi3NjxNSyQHMoqXZrypoGhzmfox2E1uZ2XoU3o6nhCA1h4EfCmdvfjguQZm2j7Kgoqcy//NstA28oI1f0u+rc3r4O+CyN1Om/O8uP5O9fhP8Iqj/9RpWRyxFclWd/HCIx9BhLEm71z5guGVOS/OyDJR/a7cQUjkXF64N2p5uvLmxPp6VCJsUTistDMRFbjCS971JZbWuPpgc4cAFgi4KDzRCp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 18:17:28.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2550cdf-4d35-42c4-db0e-08df17436dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
Message-ID: <20260920181653.HC94DqD8lJ1ABHfegtl60KIwNAK2Fy4Mw90twWn-qOg@z>

Two functions in the the SVSM vTPM guest implementation do not disable
preemption when fetching the SVSM Calling Area Address (CAA).

The SVSM CAA is a per-CPU structure. When a thread is preempted and
migrated to a different CPU after fetching the per-CPU CAA, the SVSM
call will execute on the new CPU with the original CPU's CAA. Which is
wrong.

Move the CAA fetching operation inside svsm_perform_call_protocol()
which disables interrupts around the SVSM call and thus runs
preemption-safe.

Fixes: 770de678bc28 ("x86/sev: Add SVSM vTPM probe/send_command functions")
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/sev/svsm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
index 916d62cd17dc..2d493d55ff2e 100644
--- a/arch/x86/coco/sev/svsm.c
+++ b/arch/x86/coco/sev/svsm.c
@@ -74,6 +74,14 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 
 	flags = native_local_irq_save();
 
+	/*
+	 * 'caa' is a per-CPU variable. To avoid using a stale or incorrect
+	 * 'caa' if the task is preempted or migrated to another CPU after it
+	 * is fetched, always fetch 'caa' and then issue the SVSM call with
+	 * interrupts disabled. This ensures the correct 'caa' is used.
+	 */
+	call->caa = svsm_get_caa();
+
 	ghcb = __sev_get_ghcb(&state);
 
 	do {
@@ -321,7 +329,6 @@ int snp_svsm_vtpm_send_command(u8 *buffer)
 {
 	struct svsm_call call = {};
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
 	call.rcx = __pa(buffer);
 
@@ -345,7 +352,6 @@ bool snp_svsm_vtpm_probe(void)
 	if (!snp_vmpl)
 		return false;
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
 
 	if (svsm_perform_call_protocol(&call))
-- 
2.43.0

