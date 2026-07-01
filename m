Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F434678C;
	Wed,  1 Jul 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917151; cv=fail; b=LgDgoNih+XlCD7FW1+6yT032XGAypo7LHgTzCUb9owtwC4hbxqJkPHyauiqlhWxYAoRfksS5A1YMyhbWSP/Y+/KGGGqu1BzC0dwErOVfcM3axXRcK++AWKvw5T3AYddZuuTrTbLzJhrEBDabMN5G4RBVhmTzTKyCoGYV7N4IwL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917151; c=relaxed/simple;
	bh=C6KwSR5H/WIAmIcpv/RdHDvN91dl9E+nRPBNDgtnvWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W4qlaN04ONawLe/F3seq4pZeNJsDAo2yKtCcJvZiL8SIfCTvrCmohEB2iMslOXCazop1gHpJYTJoTLuraCCthJ2p3LKQuueEvVEbytLmPoXQwpBCL+i3jXUCGXcfWuRzB4Tw/kFTQo6RbmhJsB2b3rHdXjOhIVbOxN4RgO+Bbdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lEaNDHI+; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lEaNDHI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPfQ8xENHjP8tMk8QhsuuOG1Ao3M315bvpJgU1EIxcMkpDXak0wqFCfbH9T1Dh1slhpv9gJDP65Z0KKwQmkZ+mawy4OpvQg3CLQvqR14Zbo3wkkHfN0Dhp/dpqCDRPHjLX+xFJvWBV623UMPckTibh8PtbT14V9OrW7reEisyAKLHcSjY9n+1aiKILinNQ0qu306H5ILBPk5YPLsXDK44QUf4Cnwfa4yIbvQvrk7mzmPS4vX7GH7rTfDiVL2LHvIruGCetCB5hW5xUMZr2XGRIYTBJFdIB7g1QOgPbzIZfe3e03vCMDJc1nnzNGbFnoK+FRIG4ZZJ4oHA4UcnvK3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmuy4r/LO/+UyyrA/vTbPgi+EZCCx4dyKpZlrrSIYK8=;
 b=hfaYNa3eY9/Me6EBnym+KzgUY2gFKVlxuiqz5k8Vzwo4H5rgXKMUg51jBCpjSZBQGu84bYq5fP14Li75KlnYtnKbDvgKJI62CmhKed5kg0L3g14GtMxcxA66/LD55v1k2u+F5fzAQJy8dJLeZxR/7p6P11xZnSKYlons07n9ebmv1cxTV3lZOH5G9h5uA09rOsY9LbeDkcmnbQ+8JBnlgCPLwUjR3MyxydyB2//tLoqIOdREps1VwqJQXmkwOVX7aXbK6+iKyZINcEvqDX2vS3zwg/TPCSQi9dDAUqEo0G+HhxfgYmno67w6RvKVUPm9zjizhbVpEEOycih1P44SUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmuy4r/LO/+UyyrA/vTbPgi+EZCCx4dyKpZlrrSIYK8=;
 b=lEaNDHI+k72Pl9znsfqmy3TOF05wYROiyXVuUM4tZnySb3vVUAUvQUeV5SgfxAjducjyFQxyneJqK4A9HVUUy5I/tCu47fdsW2pzUlpNanUYiZYonTrI0G+1RGQFC9pNMR3DGrM7gDzLypTeHIj9cZTsFxZIwuoBNihy3F4mOM8=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 14:45:44 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::3e) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 14:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 14:45:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 09:45:43 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 09:45:43 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <bp@alien8.de>, <x86@kernel.org>, <thomas.lendacky@amd.com>,
	<hpa@zytor.com>, <david@kernel.org>, <yangge1116@126.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.gupta@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
Date: Wed, 1 Jul 2026 09:45:43 -0500
Message-ID: <20260701144543.39582-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: e6863833-e859-4f80-7ada-08ded77f6e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	x+TjOdFqVG8tg5hRoAOQR2BpeLWfQaEvHD4V43PNFZ4e1F5hGl3aHKxzpJBGWRe7sQZlaj65dvoItYgo6Aua1dTDiySL3J23yjNZslLkjSxROG39x5uZwbsgeaiVFYjRv7AoQyTlPnb7RK7MWRwTSHMBaKjqkzClkvoVSE6Prs2tj3NF1BFzmZxBkWr2fm2vjI915bxhZbxZsp81UBTbpKgU5ZxgDJwrVXmbj6W/1Fj1eWHhKnuOXQfwzSMohyQN/B2sL2a2AyQqD7SoV8g+Ary/dXHMgbsinLwR4Brzxvj9OeOA4ETkMi2AisiZgF2nJE5NMJ527ekpGF7d1ksEdLWzXhIcjOq2k0YtvI0XQn/6XJIz3rFrEEQR79BGFGPJPJ02DaauSMYFxm75rQOra529ZRX2wCrHPFKBFFOW/Yn+May53bohQfw2cmYJkGP6YRzWDmLDvjWjudppZctvZdl1GUwAF2RR5K68+A2KIjAcT2lO4mdIKjobsu4XlKrBAaD0nCaqU12GJgQcyw3VEHNU+jbCjDwxlYjkuZBoxGh4c5gcW8ZTjdaYVYHrDbyBtaJSRdVkMb9w25oV3JJhoc8D2+YAwvwu9AS6Oq44PWQitWzHBeU23oia1qAiioKKHa9X3TLNWfHA3Z3uEi0xQ/8+WB6qOIdUkkiDWM8hJV58zyu8TeQIxf3It3fvrwaUgZEiHZlRcAxI2sfRgyO/yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	unIlfKaedUozbHK+qKHZD9qjJHvv4dSVqjc4ei43WzPyu8jl0FchDNryHwHGKgThEWHukhyBpBg0DSCRwnbBnv/7EwIUusj3GLQykKqKQXlAg5lyMB/5xFhqHB4oG+q8yv9gRCC9K9bEHmrHRbdmyorhZBzILDEm+hCWUn/ODo/PG8iz3u5VxJ2WeH5rxYSQUNPNvbN4o8sS+Pr3FRVXHd2YP10kMdVBDIpalkyBdLg/omQcTnVP29DRiJtVbXrSHjwdBcZ/GansT98tsiUQrDXcz10uEjNy/xw93D+ckDJgnw3Qb7SU08np0U2axQDKT0/TIs4RlFFFQjU5vuzqWBESQd5DtQ7t785wU1VJGRX5cJj3Wgjx6i2/dTPDT5RS0w/41V0Du/BcSOY5vWgvFZk5ck1OVttPAw/9a3dWqJduV1Sb6VHQoBhaIvMLwb4w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:45:44.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6863833-e859-4f80-7ada-08ded77f6e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
FOLL_WRITE | FOLL_LONGTERM since:

commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").

Drop FOLL_LONGTERM when registering encrypted memory regions and restore
the previous behavior.

Fixes: 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
Cc: stable@vger.kernel.org

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..c4b53700f69e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2764,7 +2764,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 		return -ENOMEM;
 
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
-				       FOLL_WRITE | FOLL_LONGTERM);
+				       FOLL_WRITE);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
 		goto e_free;
-- 
2.34.1

