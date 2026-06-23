Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057E395AE9;
	Tue, 23 Jun 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249554; cv=fail; b=tkuiEqdvSfpQvKY5tatXzQEGy6AofjHrgYQ6GgZ/NXHe5MI2ORC74kIVBj6u7kMhn9qSaEdX7Is3Z4sBv4lwYv+jmoGHkM6iyGRxSe5iCPmR72FkVF7D/wYgxuMlcbzQJpoeXOPylo6IJp1v34n2rw4xR+XkKwV+pK0Y1ITQNtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249554; c=relaxed/simple;
	bh=22mu/dy31qodfyTotsHQe8aFzqdECRMp1oSsW0hLC34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sflc6gws92kesZZmw5owvjqX2t3ir2KW7nnI9hUGgjjgmbkSgPmNwBGIgSCyS+HBaRawXdESdOyqPeSzsHnjc4hBkTDYyr1Q7HSPwgt1AJ5GHWjT4wqx2/2xKSmAj++hoD1hH2rjMGCPZVMp+tfwT5wytIaIwcYNOISMq1Rlm7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VksBbn4M; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VksBbn4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvPX0hFvkE+P+In+GSjGrlpm6JfBESvX+Fs2N0H8UfHsIPPhTlDltJN2KW3QSx9SQJFDkG56cYh+J0bQa8/WoiKQxnmjToGQCIuLmHOoISPUtDXKt21Yk33WaOgRxDJ+5afnTnqLVKQo4VIFKFnW5xQ4l5sQzfQSyRQAJK7r6L0+jMTOJmUTc0Re0xv9DifxFkAgfZsBOinaCZuRZMEWDtHD9BFBlXttiDBRLGrjyz9bqjUWV3kvrlj7fBqmU7CuoAR2wZPL68z/fMM4MGx72f0uO5izGNjc9gYTf/TvfpUPGYYecEbFAqNsJftGENJRqbq3qSBM6sbLV1P0fj5lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+GPFJksbe5osfJ1naelBNgLRcpoUxuDQeUwut6/eyk=;
 b=ZfO4Afo2X0PDxPM4FkrYHhOFcJwCtpc75qWIaH8OImQFhiEDwOSpZG8bpkwpEzAWEhUhymXdzThM1ZehvPBipLcQXsPZ9rcSWGEKPZkdBBTzasciloc1kTWr5641dPgGkvjFUugyKifnHTheH5rmJAwv6DkC3qoiHkKuiFl02r1xJsDSnX2e3ru66+ngHDMBROZ2Av50eYpZy8mTPKcAzAiSNOPUNHWbUbyDBVJI2HiQjBsus5wfYT0ssUOz9bXpPeMLUiPa2YWTKPvMLiwYyLQpgphxaGfEaF3hlk9xcxcYuzHXYYo7g/iFNnfiAmqiJ34GJoPUFZ4CQkwV33pgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+GPFJksbe5osfJ1naelBNgLRcpoUxuDQeUwut6/eyk=;
 b=VksBbn4MmRUQa00FXW4csgI4Nl+THZUxmN/hDUqHwqy3MJfKeJ0Yi0xRImknYqFYrpBA0duOlUX+2obOo01UFyqwzteYgl+dozrEipQDybe+iSiDDZkm6MENP0YZNUUARRjNSLPCTzwi9SVgN7wTRDc8mMu1gn91iSa0z/nmP/w=
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 21:19:07 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::81) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 21:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 21:19:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 16:19:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 16:19:06 -0500
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 23 Jun 2026 16:19:05 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: Penny Zheng <penny.zheng@amd.com>, Jason Andryuk <jason.andryuk@amd.com>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Date: Tue, 23 Jun 2026 17:19:03 -0400
Message-ID: <20260623211904.3674-1-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 792fc022-b6f7-47f8-eadb-08ded16d0f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QsPq64KPEgxPyCtroy1u+Dbsvk2iPteuaG4yjgrqvByrdf6a5fnjIoPvX6s1vXALT5j4nxDcywVb/fJ9o5yWawivjg5DTdqmU1kSzRnzXWR7McjQkAlj9ynqJc5dw3tMp7SBnPGexmtVk1ZTCjJjq5+E52aMaACocqWNKpVXIf7KP4gQX73Zb46lUsWn/w4Mi40yVXhwXh9uXcjzzgPgCaOqZxXTy2Yjb00zolQCQqbeQTC+KaHz/sXx1R1tciPpHol6ZI80XHQWhHSm5sYd06uD31medBrRD6TYyJnmm9A8GkFQRGNQpZmrt9xBEJLij4uF7X28aBQ57rEBOsc/MSSqATREn4G5RqU66o6Y9Bvsw1Z/WH/SUIa3BJ/bKYXfIqKQE2HOrHpCuUPYbyAjAFGNQioDSSUr2VfV9PMBC790OHRZ4fjFpKd3drVZu6lwaqcFgPNeUAhnIfQ8k3lKyatz+ZE8Sr7/jVzNBzmylO7vCtY8JaoO7iGrTFXIOmIbGLOMEoiJfOq7d1Cbb6beOigKOmcBbB0Bpm48WpFDgmyhUvqrSfyn9ZIH6Ly/d4Zz0NUtAUg8/SiI0trwGRVcwcM820CBF4n+cQYOfDMf8eaXseK1gE5Qqiev0eNNnEDd/COvouzxsp5QV7ll0dJRqmn0NY+TNYV+MVlFZxDweZndOcKwaiLy1pHpySShwXkRP/wK3nk4GTWrIFUp3uZo0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vZcb7HKwSeTBZP/QljiO0E41I5oX2PD+Bk5ZUkE2woaM1CXKkOvr4gVB7MGkax7E33gOzhF95ioqNPCxG2jgLXTmqGZkBU7asiL/m0WWvDZXFG6PDv9/cgv2NZiJ2j2HZQaKwW5ryLQicAheHTSnXQ7MN6vfvL2y7F9uWSCRybSMWOVBXHjGdU/7HPqlY+qWbvP29uvGADGNoh1sC3c2CbQURfmmMSz9pg9KfmExph9CG0CjvtOKV9+y4cHapD0rSDHVKMmCD5tAi12dBz5Os5YlYQwcIb3N2CkTLtFjCzWg6i+ZaNAku87w6IM/tIqTtuHnqpXLAbBlqQGW6ZJC8tbgz37FZ1Raqr6quLCnIPQFvR/3xBehEpTf1eB0Alor5RKSQReWHEk15H/MXZFxpXHOf2U3q4mS6IfaNQja2LNNCeDobL3MaiE2sbIJB9PT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 21:19:07.1037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792fc022-b6f7-47f8-eadb-08ded16d0f4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

Xen synthesizes the CPU topology, so the num_nodes and num_roots values
may be surprising for amd_smn_init().  Specifically:

    roots_per_node = num_roots / num_nodes;

may results in roots_per_node == 0 which leads to divide by zero in

    count % roots_per_node

As an example, I have a system with a Xen PVH dom0 that reports:
Found 1 AMD root devices
Found 2 AMD nodes

Ensure roots_per_node is at least 1 to avoid the divide by zero errors.
num_nodes are allocated for amd_roots, so roots_per_node = 1 will
populate all the entries.

Also add a pr_debug() for the number of nodes.

Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
This is an alternative to
https://lore.kernel.org/xen-devel/20260506055528.476493-2-penny.zheng@amd.com/
but it leaves smn available for dom0.
---
 arch/x86/kernel/amd_node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be01725a2a4..f335c5f1ae1d 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -282,11 +282,14 @@ static int __init amd_smn_init(void)
 		return -ENODEV;
 
 	num_nodes = amd_num_nodes();
+	pr_debug("Found %d AMD nodes\n", num_nodes);
 	amd_roots = kzalloc_objs(*amd_roots, num_nodes);
 	if (!amd_roots)
 		return -ENOMEM;
 
 	roots_per_node = num_roots / num_nodes;
+	if (roots_per_node == 0)
+		roots_per_node = 1;
 
 	count = 0;
 	node = 0;
-- 
2.34.1

