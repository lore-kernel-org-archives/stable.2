Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CB3C7696;
	Sun, 20 Sep 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789927974; cv=fail; b=Weo9zXFkFwSHnpxkmH3ebkik7/h2lHjBsuq/Ycrgy4iA4Uf3zi3Nctt0LML/dm85I2V0T+8Qhl9wFEiI1ERRC5iu0aYqQPpirOBP2ihNAVW9SjDFD0fW5Px2wG8rUMWWGtr0h40MKmDR7greUpO8xP9FYzNGIYG6cJA6jrY4Uq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789927974; c=relaxed/simple;
	bh=tWfP2theVb+FGi6Df/pDgswTIV8hFpXpyLeYFndKyFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pg24HIFS9dYaKpNUWMkxgKrpFkU2wWwQfFMoKvFbHFxOEW+MmlZG00RREzeJ8kJXNMVoEnZdGzA8pDKkuPrhbhVrPPt5/4yW8vVBslEAXvMPzJhxEgE3ZFTKHpmI0n2flx2yPAb55sI7SmonrQmuyldC2zBqzFF0nZLX/Ym4Nbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrbE1oxy; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrbE1oxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzlN0p2+qUbm7+21qocjecaZd72xQCru04DyD1dcVaVklUJa4Zu3ymImgPP3UF3HdfiulC90uGZ3U3tQUtiRiRhmSRTpAWJjWbxstxcRnuHU0GaVim3gfsfNQ+F8BbvtVlz+8rnJ+WO7veeyruOyHDAnjllt5pJY1xUy8snTGCpF1NDTVYPj6fXRpT8UsngAAMmH3jvNpLiz0uaeGO0w09zTcQnPHnidmzVsA2eG/OWuhW8TWZRBZ5ODFvJkqJ71b7TWv4iV0cuxDXG7NDT1BQ44Jxx1eqzGwbGVspCXU9lJepcoqgQiF8ALkkir2aAYwhBdY8lYOnwbTgCddwV4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=aL4JcbhS1+i3b4zUMZYHglKOfKXTm134MXpoHLrAY4lJA+lcNOso7nOy4DVUPFENUFRMQfPgMN9B2utlrwIZGIthkuRvn510Dzs8Qlu3jg2nlZYbRGg9U4YSwYvByA09Ba93bj1hLM65lBCJYDUoLozYN1cDCplNHPSHV5DevcELYugtBZzk+MyrFXNGLE3n+b50BAOPiYCYjAMGhhxnop7rfBtt7CmewBXx22P6QhxSw8ZEMg/2dF/WZYhE8pHZqbxaG+SGGZuBTTdk0ITzayzjGRONwClaGjmKAZiw4vGU2hQBHfXgO7U22r/7F5PaO78HA1dFDyHC3Bs/XnryoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=vrbE1oxymsC6jg3z0INPLBTqqEB7qrXk0+gxeInPHvXEHqI8HxSbGDio8kR/cUi1iWqnfWwMvBJeHwYzir7xndvbyUIRzX2aJfu+SELs93WBfTbtaJ/hOaCykNv7arXSOtgjiNrgD9sctIUxd78JoMqPTK70mkPKO2scynu4aew=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 18:12:49 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::14) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Sun, 20
 Sep 2026 18:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sun, 20 Sep 2026 18:12:47 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 13:12:47 -0500
From: Melody Wang <huibo.wang@amd.com>
To: <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, Melody Wang <huibo.wang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 1/8] x86/sev: Make SVSM calls preemption-safe
Date: Sun, 20 Sep 2026 18:12:10 +0000
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1dc557-95c5-4e71-c49b-08df1742c6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2V7HljYqrDoikypL/YAECdrryRyy+jHAv3jvd+/CJJtrBgoK0HzIh0LqtKEt3qZjBmYMmZ2EU0Qwbpff6uWk4OIfOGdZrcKQ3pAP7yiQXnd4aArJLswocGYvk8ltZnOF9XEHaJzx4NGVxIKEoHB54UBrTDf4v0Nkoqu2FmZiVYpPrEFPFPa+G358RJN57WMjr3CeszYTX+LxtAax5thWiaLugqf5pootQNlVr69BlwN0HZe/5/k/iEKMJar2yitSOca4Y2/HVhMcraTXEuSJWcs2oyEQlT4MUuxqR0mK7Y8gJ5x/QG1U8md3XxV1trLQg4Cj0/M5VYZpnPifsaHDhALmcL3S5fbcV7mGOgo8V+Vv0amWQQowwyppzU3CsudQNevKBXhxGL80FQsquigzXRwfJRigCV0NuyZF45rUFHXGe/UTN3Vc/omqrd7zU+oYWGnbVYNg1GiYhIOBk4QF4eEpBxCE/d9rUUvcE+vMGDFd1S1dN6msuvBDag8F4MYRMKFodB8kCWEI/eImnC6t4o2Qz30+1VuWYH2Weh2JUkM3aWvTypoCiRbfyYMvloUvyPg3OLUTJTgQEKsYuHCIqgD/XwUlrl8n9WCfxdxXNnifri9GyC+e4AXnnFKiIGV9Avwfh0zADhlqzVVsP6NrpA/UU2csVr1kCwaJowWVQKGTDapXTp7Hju3Ih9xj7A62mktTHa7BKi1PejG7M9ubZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bcl3N72oiA9KA2Tp0uOTYT2yQzpbzAOzsZYEjrJR2KRED7qo82RrU8AmxroOdtOian+Xpj2QVUADMJOwhaA9RgyuCprqLapy9pMKVmnhGp1Lg7uDOI8+bU2om2L5iqzIMz0I7SonolSPRu9boG9EOOC/u8OZHhDeTvhDMHc0gGTgh5eJrB14iNwulLrPYYk5p/9iUJheA3DeRUwjNc3RU+NFR3q472IMUxD5H7dvhxNdyNrCr9F3ksgWcMYELywQuRql4Iu6ZfA7qWNeLcBW/rcO4X2IbSwWrHYpF+vAU0PqHt7kOsr+H9iOes8i4dRf9wtS/E/wuDTd3Jx7bG8QrILGQMpAft/ywzYH3gHTt1oLF6kYse6QuvLgxnB1epXfDYYM5zNyrnNhtQjnqdjkvpM7g7S66WlxcUb5XcUm6Z7/WJ/GHpABEjWr+M6voFYR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 18:12:47.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1dc557-95c5-4e71-c49b-08df1742c6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

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

