Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098001;
	b=hvEFer1OAdCGJpdM8aNWBnKy6RUujgP3w3ShxvGAMdUquqiOHrxlcA55pGr2RgnsuCi8
	 i63jXOMMuvopCv4FXQGsIQt6GExBW8O7eLkDoWt3TC/7t48V70iPM/03tfnhX1LrKY5/l
	 DVz689VZNRpQZaAn3SZKEzmuIOT08f1fpYyVId3tX609Iw7Jyh7q3hEWW3mvULB8wE9I7
	 vz43/H/IzNKho2wRxBaD95MZq1/NVj6yroDuNhZ9nLYmgIswBEah3P5zn3a7PC9RrNkhg
	 vDAbDfSZVv4EQ3GCRcsHpPXys/QeZjScXgnoFoyY3FU9ZrzSuy/Q9yeWqyam1tLJd6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098001;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XO3Ipz5g2FY85G2Oo0X/JP2YNYmABpvwGwdJHFoQ1hU=;
	b=Foetf8jC2nk9tPW7afDenY88I74zd13wnW/uVjqzRNLeVupsnD63ISFIPjJvN2915DtZ
	 KgReYdRwgR9Uxc8hVl5WOzWTK85qf/p/WcdFPGdLMthccbi8LwVVOovcvJMVjlANISQDV
	 7Vh3kOlXq6kPw9b//KQi5oVKBnBdUpg6nGzV0Q5cY5WDqvDlbnz6+eIseqSgUFL7raXrW
	 EZALz8I2PQduiKY6zNdb169SCXD2iX18c0p089gPSEDsEqaWI//HsT6ydQyTofefRCLR2
	 PVqncCYFAXg0vBdEBjk0WLSGDamViDsK2wy4FC2nciQw+yAsI8cvDr8nGlUR+POdW0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xxd0pvOq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CC606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8CC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xxd0pvOq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ9e3ElJ11t7s2TNPTLkC8rt52bRzYVemLbbzAimen6rnWZrJpI4cr8de3ohRLjadNWIipzVDxw1GJjTJXq9i7BKGKc0NpOuZq3ym8UesLTyS8LjsN81PFfjprU6WBRFRxdkkeCC9rDDuwOyPbPrvcbBJMu0QN8Y01FsXO2WZm9xYDleCWQnn+rI/h/nxIOSmf0Z8hhVRdjf8tgAY4D6K54UvjRCaeyzPijYmK29YuX5Fh5XHVls1U7/jhlk0QAc4EIMXSzG+w7JMgGl4nYssS8JotrGP6QB65zKoPM1F48Byh5eGKD0VwIPvlxiuRkd7vIF+UUjbg1AjW5STn0fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO3Ipz5g2FY85G2Oo0X/JP2YNYmABpvwGwdJHFoQ1hU=;
 b=yA3+ku7N3OskchxS33CatJjz30vaRafR6faIJjHHn46RidgAJ3l+OYj5hCSa+BEo55Ug3j4O0YWvBgaRY23G48JVCceMM0hc6TFsvJJJpSmmG7W8tZEuSxaUevFKkMyNHFJGkuHuUjZdyGLudmeclSotKbKXyuPWHA8WLsCMiI+qL/KuWFkO1J/+8RaZr0FUWwJTI+wkbhFLdZ49pARkbd0JyOj6u00Vc4e5zl2bmJBghd7JzcXdcbyO/VXLLSPt2TuZtW3yq48xkT2TnRcu3F/2EauUbvXLFehFCn6Gigzt8z10HbyrhN4OQMbUcSyodF9w+0jVXb715Zu15VGY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO3Ipz5g2FY85G2Oo0X/JP2YNYmABpvwGwdJHFoQ1hU=;
 b=xxd0pvOqd5OaOdU12pdbl5Uf0JST9awyTSi6N52rovLU/Sj/U3En1NFiqsJ12EB1hCWogXc0tCk7PsLUAG8UCsO1+hFUBfJZ3LcMVCzJIGvhREYynOZg1YIjNDTh/5CciNErvX2meoBUmhmW1aFI/7+HVQy9prFMDVl7s3ne/p8=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:19:57 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::53) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 14:19:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:19:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:19:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:19:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Nathan Blomquist
	<nblomquist@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence
Date: Thu, 19 Nov 2026 09:19:44 -0500
Message-ID: <20261119141944.2994497-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 628a9d28-089c-4830-aace-08df4648307d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3uttG3YnGhGfdCHSMJXWOZ2DnQSbaRsckk4KvbUbuzAVkuqOfcrVBHJ/A/vxEAqQsCZ1A9Lft0dT4NXpOZL8ranav/D76x1AszgWnwlt1EkeiArb6bYuL/ipggXFU3Z1jFqhHuHydxt4F/8zW3ZFVa0JPmItrM892B9kExJLRPmTJvo9uej+TJsBPzZP5At6n+RTJOt6ZhQFhpZTGnZ6n9Esly+fcxoaLO+f/0RzOv/w8IRCnnOMEZwtuIXCLPTR23Ui8xVD4q7itMV6xpdKiapr/uaDZVaiu7nq22PQJ72rAmhDaACd3fEMSmBaXd//qCmJLWWo4udddwjWvwe2DEWmnl0+Hs2BcnK6t5rwQxF8GKQY5qIPK0l1RU9PaB4XuEfjS5N276lwqPRzqMKe3WfilY7LbuE7p9miqM3K8AT5FwIn+1VJ6B+z4oRyVSP2MMTMO7gZZHkA2b9vXhj6VvBgIp1wz7N6ZQvTduKsKQ6MN+0XanW1Knh8xldWTOqtyIZ8twov5a35p/oDXFw30iRLYmvAAgh1EoAf9Th7A4uEeGcsfmGIGQHP7ho9OwQRHsYmoyTFTaJuSTKw8KzoqclEIM4w47S8K7LuZTDXuO0Zb2TPpw1mwbDQwPeEBulOv1L9A0+TAS0OHyWjcdWbnWTxNwBanGOoNrMyAwl5a8s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	448stcjKLN+0UTwIrmgBiB41lqRBnJdRnC6Bbk9EvKZn1N5ZYcV5S2KDJZhgJ5E8mmN0yhye7jsJvIenzQSHMRJ3vAZCB/Rc8iNx14xriJ/b6+g1VsRMO9mFcXb/F9nA96Q18SYHdUq/Cn45Gt6VagUh6uxvlfvNXPQj/3HPQOs213qItxxtSM6JJGcQzoPyzoh1zyqQi1EUCRTufA/En5HzAtd5i+Tzx4V4CRB/QmZqPs4R2IfITzG9C5aDmJf3l33BPoRyHucqHAbJ5Okg7jwKm21Yd16MJjs2/k0vlW7/TKqnC95dUNA2vtBc+wC/AoO+rK82a9JiWbJPqKAYH3Rw5TB3R3X30K0JJW2kesfqRmo6+jt3LPAHRNMsOQ14pKcFudiuzqoqQphRxkyv6NTYKkSTl6qQi+fD0TyI6a8y21Q4Qb2oTB2nuJpMCDTF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:19:57.3679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628a9d28-089c-4830-aace-08df4648307d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

From: Mario Limonciello <mario.limonciello@amd.com>

On Navi1x/Sienna Cichlid with runtime PM, when the audio function is
enabled, BACO entry and exit are delegated to PMFW by sending
SMU_MSG_ArmD3 instead of going through smu_v11_0_baco_set_state().
Unlike the v13/v14/v15 helpers, smu_v11_0_baco_set_armd3_sequence()
does not update smu_baco->state, so the driver keeps reporting
SMU_BACO_STATE_EXIT while the ASIC is armed for / sitting in BACO.

At runtime resume amdgpu_device_baco_exit() checks
amdgpu_device_supports_baco(), which ends up in
smu_v11_0_get_bamaco_support().  Since the state never reads ENTER, the
"already in BACO" shortcut is skipped and the live BACO feature bit is
consulted instead.  PMFW clears that bit once ArmD3(BACO) is armed, so
the check reports "supported but not enabled", the exit fails with
-ENOTSUPP and the ULPS ArmD3 message is never sent.  The runtime resume
caller ignores the error, and a later secondary bus reset leaves the
device unreachable.  This shows up on a Navi 23 being handed from amdgpu
to vfio-pci:

  baco_enter: in_runpm=1 audio_enabled=1 armd3=1 baco_state=1 ret=0
  bamaco: state=1 ... feat supported=1 enabled=0 in_runpm=1
  baco_exit: supports=0 ...
  runtime resume: baco_exit ret=-524

Update smu_baco->state in the helper, mirroring the v13 implementation,
so the capability check short-circuits while in BACO.

Reported-by: Nathan Blomquist <nblomquist@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
Tested-by: Nathan Blomquist <nblomquist@gmail.com>
Fixes: 13d75eadfa1a ("drm/amd/pm: correct the runpm handling for BACO supported ASIC")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patch.msgid.link/20261103141457.2558235-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d515b2694eab5b35533c7fb7af5bddff53ff60d3)
(cherry picked from commit a26ec190925733dd205507493e936e59dbcd2b19)
Cc: stable@vger.kernel.org
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f0b2e7da67b1..d2dfa2bb50a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1421,7 +1421,25 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * PMFW owns the BACO transition once armed, so keep the driver's view
+	 * in sync.  Otherwise smu_v11_0_get_bamaco_support() falls back to the
+	 * live BACO feature bit, which PMFW clears when armed, and the runtime
+	 * resume wrongly concludes BACO is unsupported and skips the exit.
+	 */
+	if (baco_seq == BACO_SEQ_BAMACO || baco_seq == BACO_SEQ_BACO)
+		smu_baco->state = SMU_BACO_STATE_ENTER;
+	else
+		smu_baco->state = SMU_BACO_STATE_EXIT;
+
+	return 0;
 }
 
 int smu_v11_0_get_bamaco_support(struct smu_context *smu)
-- 
2.56.1

