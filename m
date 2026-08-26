Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B43515F3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787786294; cv=fail; b=Rpe1W8G1V6LGyyuEuMVktiRzsT//4XD+6UVeC4rIUjwMSKzaSRam7pzIsMzC6lE7TxDUWFY52NhodW/CxAUTNHtkdTneBzr6FZav2rSn4Mym0bd+T2boNNzfVHmxsweSmJK1TByNccLh+skPZx3+2gZVbD7DVClj5AMGILVFsTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787786294; c=relaxed/simple;
	bh=SQdM/E1jd8eK59OPXKWg4K9M62BUVCmE34/nfufsJmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDSRkuJ94szxPU1i7ediub3NdrvjV4NIY5mrFSHnba+qr4CAj25QnnNIfM4EhK4qXfq5wmMvaYp6Ibl/A8oLGO9p/Tcnvv9+dlIGNkQucf7NoaMuIE8N46bsiF9VkWw77jWDL+uCVd33pfbT3tj7uf2VMl8d2rsJxWbz3rdXTRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0la4YOi0; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0la4YOi0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmoGHwusoKnp1tAvMvUBDtzkKJWkF1ygk8jJ+5+5FZVSQ8eViToiOCCdEiN1TH28uEKxHJeX/Yr4b9XPymcSgexgoPfQdPLvrHRhpeIvOcfXWyKaDmbv3OvrVVP7coDshwuthFfi4b1S4nfFy3rVY3O6t3lEWAarBDoUVlWQhLkVFCyXnb0IEXmDcgrhdqn6VVS622cEK2Qwn8qtyVJnBnZTPei7k6Z3x5qzwMMXCZTucT+KLxRW1mIPVeEmy6++3CJI+JrE+sJCnn0pxfhobki1vYmwH/HHlPy4s2KG9UDHup+AqTKgkD79SN93GgMNs+Rt+U6rjr1O7jFpt1n3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDU4Nb5CuIP2IE4txldWHJwHB8PKg5ZkxYwwrVumj28=;
 b=tHa6Ade4D8TWSSTkqruho04rN8sQRTYmRhkz7GVj/sUKuOWiECh26DjTrM34X4e0EKOYzTWb7GonJXONt9JnbAJkRINdKWRGJ9P8XwskG8rYDIvGVWsyZrdgJsUy4q93v37I9rU2WFcEHMJQIefUzhAEdtxKThkJeXuo8ZbVDhVmgtNKuOI4Fnn1g71JHMFn1er12waTV+ZOmMapEJ9OVnYVtvUpcaM5exDQ3pmeuJmmAdnoPVTxHTuuKGAOXo3NyWumggITQq36aECRsV6N9mxxOSBdWUExIknLqF5PTW0/SQUUT5mMjlLPtOdh2Y/8hYowubgaousdF/4zQYW+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDU4Nb5CuIP2IE4txldWHJwHB8PKg5ZkxYwwrVumj28=;
 b=0la4YOi0i6QWM8aBQoKv+D3YdRvhD6OsRV9OHeukjT0gypArEIzttWAhwsayAI8VVs21vAXytjEXykTKaOmeDUwCjVjkWWcygBFxDaaLL+CT+A6MC9EWPLeTrVjInsRtMCjNLuJZyq2fOf6wVLQfSbno7GPjWVzPQyeDnQjQDNM=
Received: from CY8PR11CA0005.namprd11.prod.outlook.com (2603:10b6:930:48::18)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:18:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::6d) by CY8PR11CA0005.outlook.office365.com
 (2603:10b6:930:48::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.9 via Frontend Transport; Wed, 26
 Aug 2026 23:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:18:08 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:18:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 07/59] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
Date: Wed, 26 Aug 2026 17:04:38 -0600
Message-ID: <20260826231519.881949-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: e919fa4a-e850-4f9f-19e7-08df03c84a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|30052699003|1800799024|82310400026|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	nz2FIsFmP4zZ1apuiZIA93x9BI/Li3JITz931SMzW6BjAYkqT7lGyMfxldjEtTjCnxhAdXr8+0q1hffQDHMU1i0FRBaFn3oLUV7DntRT+OQUNIWoM8NEM15hVf68ly/8NtMNIHaeJOoZZSrWznWCF76zkc2dfEB16I83SH1qJzTTq2kcEyAvgtb4NzGRZyj0kvRReiSnxRWhf2yWiCkQhpzdj9h/r5vElBAdqeP7w3WxvbJiDYQ1AeOsP9HHSzqFrAyO5+3k1yV3Fa3VyOf6TQuS7+qz5xewZy3sEQUfRdEAvuW3t1MBiu2+xZQ0WQ1p1gIx/x113KPruZLqjcgX0ZM631KOTOuzU7VFbV3VFn12t+F5O/q2XhTEce6j4MNad0JuRGfuENdQG6HSmNCNiy2eomWnqbZlJ41N38US/xp5MRNCBSZ8/z4IldnQTb+jHyAzykbdMS5FTKgEi8m/uIGQNy7ewYctBzzp7Ri1TLnb6a9+/jctxFG2ffzuF50ImXjAEkr4XHb/PIvSaUtgtE1WIjkVzcdzd6rwQSxB92UoY07ZGwKUa6wiHbML6jIcGdjTJMd1mUWf342zGCBhOQ51fHWRTA0PN6anw9e55qI7cy9ysbObvRNF/W+gRoRxG12EG2IWICoZaDxabGVDIXGsjEQ4NWh/HUj9Ztq/6ywZkOevSfbQ1JE0fYDlx3LCfbEOW8mZgfgyXELZltwtRA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(30052699003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F6OqfXwkUjmJFuABQ08WmW8om2LLu86rLYDOxgLe6V75cGRqbJVJ6nj6/MiQYnDCdyNW9JXaROQ0+g4sOYFOykT3aclChCc/q/uuzzVQbfRMPNqeMOG5eKLUZEwjEaxgXjAJqylW3Zlz+1EibAyBuwdL2s0QxOG/JbsL5FSkBkkTJwd0t/sK6kHalG0n/vPrjS+bMf/KXJt+M62snu+G6FTvUoF/DKbgdFvdvWyBYXD2WjJ4V4RsIe6TOqM4idh25uK71CAdWCre9x0M1odD+1ue1HV1mRVDiHa/sBuG5VkU57gSs9POw5Zj/W9GAog80IIi8SXNJKP1QSk6L31fq9gW5BgskbDO5bgQ2Y/j+wcGSb8ZgOQziFXZSavA6xgNeC9A1G6ZB8GqLMyLhu/JNKi4Mc7CGW0GGIsWiwJB9GvEM9QE7wgzgVgr/6VkkgCL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:18:08.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e919fa4a-e850-4f9f-19e7-08df03c84a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

From: Roman Li <Roman.Li@amd.com>

[WHY]
Splash screen corruption on some 8K monitors.

[HOW]
Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
calculations, avoiding the corruption path observed during splash.

Fixes: 115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index 166f10b8862f..c82886323a51 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -301,6 +301,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
+		out->gpuvm_min_page_size_kbytes = 4;
 		break;
 
 
-- 
2.43.0

