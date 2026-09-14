Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AA2D5926;
	Mon, 14 Sep 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347557; cv=fail; b=OT/ABszOMQCVDjTHlv+9XmeDNeCkVT2VzxoPnTmcC9yjoiKZBL5aASBwI0MRXOu60KVHRld8rSjSgBsFEGKCg0qb35P5KrCfveVyBeTQA4NW1jFj65zAZY7f5FzyU6O1LNs85fWBVJjs7CsziUPgkBLuRBvY3vl+lfY+Ls3VMHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347557; c=relaxed/simple;
	bh=tWfP2theVb+FGi6Df/pDgswTIV8hFpXpyLeYFndKyFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrdFrP2HKDYSOimFaUi81bGwX0+WyIcHkXdLha3NwUOKfZ+ktyzYqhvVoz0yZzQw16EqrigF/ev1ijIKsUeoReLpdU1bj+J4v62OYC8e0g9aSy1aBJadj6wqRTxU7MB/ntA3N4YUrFpHxRzh9JKX+f1G6o4BkOoX4F1JzD8CyEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aULzuy+S; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aULzuy+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBpIL66UVbh76bPd3dKiKprjcHxfsbLmYqVSXjhRjg3MOk1izQM9h1oqxUekLy8CYCJUT42m9a8fI0EC2oqtubTh90pUPB0OqqcyZwXGOGr4a/eolwyFPQwmP1LRjrd8EnADVXzx47VuEo4vkvsDquMSCqw8I3ri9SyJlGo0d173GGSAD/QeMzz3JUTYTs1vFlyOhcByKHavgv1OE7wre6tIhz+qqFy3BuxgJ+xRFAvZQ2kiSlkh83cCLIfq+FU8E+ww35X7BNPxZJJTjX0Wv3XQaRaqDsCXwOSmmqrxD5WOxtJozx0NTQTWx3RBVWfQ5zNb0YBPK+2y49qxyDInjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=LwwsW23p/b6Gpa13DreenzmJcZwUUTNfeGtikGkGdRm0D8EFtuXTLnY9bWImuLS8C8OdhTG1qlbPYQYMNlq4+P/K70dK5HkYwcySoNjRG8MA/esmSB9OkAXfNc2EZKA+BPZKsIcaoGBdkOt4fttzUUXknnLocuVhH+Kx0xLUFGP+Otn+Avckb4Ba4UNRVE2UI31q55ABivwgqoCbeCh6zL2iljDChn8/a/BUUCIyGtmSZeZbhrDpB+3A9NHbQHJ9ZQ4LOrlcZSl2OwYyKZb+eSDiLi1oEFY89+TPkoq0lC/8rw5h0zdJmtmoDx4EXO55ARAjMXOJ/vuBoZSz1137qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qey5GmSRMu7vCCFht38ElMGD+BbJq2EZTN5l9fXytiE=;
 b=aULzuy+SKlnaoGXBUPkuVkXHVby3Y832I5M0LwMixdxyLMVQZ/ewSvu1NOvhgi2zij7N0PhGzBDDCadcaW5VH0JUk1KGmyR9J9r7JdEWubaeuF2qqeNoLR60YQaWhL34ZkA16ed2B5BPbuxiTJkym2x77GTv9p15fV/5m6MRAc0=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 00:57:55 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::2c) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 00:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 00:57:54 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 13 Sep
 2026 19:57:53 -0500
From: Melody Wang <huibo.wang@amd.com>
To: <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, Melody Wang <huibo.wang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/8] x86/sev: Make SVSM calls preemption-safe
Date: Mon, 14 Sep 2026 00:57:17 +0000
Message-ID: <a5bc0d4a2c462a0089109e145c21626b244b2ff0.1789345277.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789345277.git.huibo.wang@amd.com>
References: <cover.1789345277.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: e73cbcd7-e9dc-445b-5479-08df11fb35a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	11LxPV/ULTNPzZfr4s3RYtt1C+4IKV95/+1zVSHUqfDWaSomQ9UaTLFD3IRfPdBS6dQX/kPrjDb8pb/GhA5GDs/sU8MA6x9tFAepRsGtA+pKNCYfclj/IIYkO4/a52aMqVcKD4CYqJD+IbFR3+GClilHc7+qBOQ3INOevw/Q7hCw7/3J2s0qXiBS7sVBWc9cI3Hj0zmyV0NchwkKddoFvqZH06wArqcHlJkas6AKqaY1vRidmyYWZ1Thqxq/QRwfQQLJF7qzt+lSCx4KRmOdqIyfr4xz/Ejq3UwcJkcpm9nRErVGDV+jpgvdKDlldyPkJ5P+rmY/HUH/U68UNxsIT/as4GnpbZQMnksiZ/Ti3urTEGEwyyn7YJOHu7jI/QGl05/mi/WMq+3AqpU2pnuLjJBJLRzB1LfZgobkOv3gEV+xmYYUEAvr/icLFFsAL8PNis+7r1qjKxpJIm8FeBcBgF6E+/sBdFXhN0iC+R5ctV37Vx6CFnbq2v3M4nvzvJ0l7yRWykOcKjwusJ1gf9wwxLkshNxJxpKvnWqGXC6InKhclHqDnYk/DH5pUo16g7Zd9fZ7Cr0DfbPlTEssFRsjlPDf/iAnqPIj5Nwj2ErmLtwcMh5zAMZhsZbvyEK5aeMsfxwvVsROMQYlpVLzJ4Cn/srPZNCqOfo0t5quIdFDTOI9SeIEYyzr5LuNtsnhLtZuO37gGMVQcIZ73MqvMsEcbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	koTFeN3XDkM7+AQBWQPai7VbIcsuXF/pk26ePptYgFtxKf8stWZkXUUvIkGBeGcLP/t/UV8c3dkTh9oyTyxe2lIZq7/pYtMhFs6ftmM0xYmuMTO6P90hAK5Y9jWpqE1v1JQ8CsOQhtRY+zcJ1Yx6JMU9twM6nhVlhFkYBM3v9hRLNZ/VBFS8zsVheJBx6w3HDrg0FUnx4T39oGJu7V7B17IQwslIGnfafMiotjIn8x2ngLP5WZPIoYI43LlQ7gInNDoe4scD3DKM5TrFREUrZDfLs79SYNNqZFRkJlJg2m9Nl5vA6C2jTAFVpI6QE+171Rk3Fq7CNvnQc3G8EhLbE/+4r/1w7S4ye1nqDEPTAqH4VYujJzyWq7wcsOmYGNtd4e7BQT3JBNlacy6dt9PK3McQF+2ZLhLXAlUcpj+Cer3G4Hw3QtAeK1dmLUaxlHdf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 00:57:54.3765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73cbcd7-e9dc-445b-5479-08df11fb35a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

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

