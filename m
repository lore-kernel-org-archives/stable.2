Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361505;
	b=KhB1sRnISzWTGHIRVouLCsr9VndMl0ckZvqC5nxQVHp06u7q5FaxiryusTRszF79tIjG
	 euzaSw8Dw2VbkgxyuoBF5CyTBYHWeEhllLaqQDvY3gLuM1ra/jkDEbxuHC89lDEpzFs2M
	 eWko14OsnDXYGcennbyHGNlvQMlRvzuxbHmbv5xWS+4K2RuT+4gwzXG9bjDiTJxtcsXNu
	 9T+LUff5AWIaHYcwqzlPkHtbr3yJVV1HEx8sLu04FjlF7b2yxfUw0Yw8AJq76fASXh4Nu
	 PQMEIRDVSDLvaVM1g/7ykbcfS8L9ihq470BSy9PVhHCFCkKwI6FRa4yQalVAEThoiOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361505;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dwy0FVtpvgljNd9sOKl9wO5baLQ+ZLPMtY3HU0q2krc=;
	b=b21/oAAzPzeWxoq1JJ7Y3Ic+vIbHAzHGJ0JOG0V2pkidwAlWpCRuzJblmZURtEGt+seH
	 s2fLh2udPqA0jZcRfUfo+PFliVKo1N7nADTfNxi97zl+AffXNcpPABC8MXj4dmS6LLK6W
	 rkihUXvFWkQ62Mq4by4qvNyi4a+/aXs0YfYA8mxtCwslUxmP+epVxfGCvIxxQm3hxzU0S
	 K+oQ0xLAoXTn8CQZGaPnLKnwCR4+mufOnCumEz5lfqv5iepf2qO88QkT3Rvi79lDAXLSf
	 uwaSDOZuq5225sNdymUIkWU/y7hkZt8Cam2nlAIziFITo+p9zxgm3ybHRcD4nObKyFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eRzqWUYx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B3606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eRzqWUYx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR8uZ8c8cBXenImRTayHrupoAYPC0hgAsIjvpK2nRA7O72s4FUYX8IdTSPi64Kc0MuV2hOls/wENHYr5Dn+Qp8rBs8tYIBXNEHioU+44194kxtO/xYn2cwhesE/mVBqbiZETOeIgxMFPF0U/dXttCJc0JbVUweCahmm2h4KPzHzJTjruDxzGv7RC/gofY2R+nbdzZ7X/375+ePtyEcMoFPKzs+VXJW1LNMF5sv3dpJBj3qj4F+iYj6lcKkevuibekjDPoUNUHFCW2rruvn0Z9vi1ZxUe77wbl94MyMSAaD2TiplMOABV9+3EFnLvJZDwI1iyeMyRGeG/NA3ZWntyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwy0FVtpvgljNd9sOKl9wO5baLQ+ZLPMtY3HU0q2krc=;
 b=RSFtvAsrKLNyrCErUdBfYgBBhwrqVZI+Sflwrt7mpv5DTdIsROpAEBnzZFYs5NwUGPTEh04RGiEgyyR7P+d+cGxB8MismpgRoo9CjcRSw6C+WIT8c8trSY5qWRW1Ev3/2LIJ5wQTTkDYRYwyj+g0yKubVd+omjekvPG111ffqUjXCAIvBUeOXPV0XN6IkWnklqBXSkXfKX7bo/T9S6JnuCJ408SjdM/omsiaf41aQl5pzV0hqxnsY0U9LSLMbjizQC4yYgUgtpVDZmtrYDx3ZUIXxW6TiWI3qtp8z+P4Ixt7I9xLw/xct4rNQJ63lXCl3aLUWd4yQZtEEVqRF8tUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwy0FVtpvgljNd9sOKl9wO5baLQ+ZLPMtY3HU0q2krc=;
 b=eRzqWUYx0dBqbvZ/CQ044gb2KpT68sdFMJkqNl5k/EY0kK+Xtoi3ptdJc8SzoL2HP2bqbSdw6VJdIiLDMJR9fCrX4uLFMQJehgRntHjdVmXodnCVl+mjSdgurqeLniObtDUldVaMa3cMm+s+3WUF0qDoNLEOLVWf9tpXxCud2gw=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:44:33 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::2d) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:32 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:23 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wayne Lin
	<Wayne.Lin@amd.com>
Subject: [PATCH 61/74] drm/amd/display: Read DRAM channel width from SMU init table
Date: Wed, 11 Nov 2026 09:29:07 +0800
Message-ID: <20261111014100.3596072-62-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: a2985b7d-7d60-46c0-1b88-08df3f955610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|261021123027099003|261021121427099003|10067099003|261022113327099003|261102123227099003|260925021311599003|260925021911599003|260925022911599003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nReI5wYa3dI+zQzAijsizpmGXxwggMHWYLs9F7HhEUKT/1m5Jw4UPVSGZB3BqNAvRO7Cf9AEP9TNp8zlcz+m8rUZ10QnBEOrOIgWhgShhEwr3KYh5h5jzwALFCH8jkZVZ3AZFm31kp+ZMOVd9nXbMK+gBjJ4YFYzNRumaJuD/rc+tnC+IsNdgx/0WsZBsgwuPbiQixom5BIoVSTdHcE2JlnlAkiFdGxiYL640ZlWnu/DJPuPjyVwdoLy+GfCzTeIytLw+tJ3bm1rANulvZP59kHfj7fptvVNWynZ+97S0kMMs6709At5jiPHmAIJJBuLkWELO/5AwgQio1M1XW2rmqxLbbaG31k/su+GpX9OO/zb7nkghSFDsWhDXoTHfEBaWXgS6uPKkw6myjfO5dEFKy24PpijI+t2dgsxo6Fs3mvpOjSAnIBgKmmViPquQvpl5LC9rbh32RzI/NxC4MjncQu/B3Yr8Kd0Na0SIEmRFyamWWaGUumj7KAOq9zseTNizd0Kn9TVwNE1frEdWLRrpYiQDQQFiD8m0KtCDkULwUa+gGpS026RXP/NKOrJEMijTwWm66xRmLtI9sK0MwA3Kq8xMUm5pG2AvLFGUtDOYFgkrkWWnUE4euJw/x0gyOmuf+C3x9Z64J/WWLc2w357K3rGhDmq/7P15KU62pgjfrsKxcP8Z6MC/lJrXFwKFda7/ZcrE1ZBE5MRjanOdoQEYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261022113327099003)(261102123227099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nSwvXOJNtRsB8g/g09hFGnvjCu8VucRukg0AzsjvcTFcN9XFNbrFUjGbmLYq5ozqwEMhWqkcT6QXrN4BwUvcnEnC3173JSgWd/wFeeWf+iX0818h6BSqEy3wDT8ZzlH/lJgPY0/rhtK/8jKyBaOlazAU6+Zh0p4M5UMhvA0Uo9WQXakSp13IjWLSBTXriWaUhxBT7Rm4gXw4kzZXhWV9oeme5aAkPXd4j57wZF7ydAZOSYD9rvAa3rOn3tQnIO5vFN5NUl2WDZvwmgA20C1qMyugeSuiPQ74hDtfn8uXflr9G3pzDvRM9kAyWfKAib4G44OTGFhbTpNAejWvTXop/YS+gE6+XUSR38SC0Mh5PZkhFE2LfzBHF6gcaltTM9SheVRMUh90FRq5nAt1yYSjIIBdX+IdHwlT2quXzcuAKByys1nIfobMmEUcvl5vxJSK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:33.5109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2985b7d-7d60-46c0-1b88-08df3f955610
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The channel count came from the SMU init table but the channel
width came from VBIOS vram info. Both values need to describe the
same memory type.

[How]
Add DramChannelWidthBytes to MemoryConfig_t, using a reserved slot
so the layout is unchanged. Populate the channel width in bw_params
from the init table instead of VBIOS vram info.

Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h        | 3 ++-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
index 234777bdd183..ea3927223117 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
@@ -77,7 +77,8 @@ typedef struct {
 
 typedef struct {
 	uint32_t NumUmcChannels;
-	uint32_t Reserved[3];
+	uint32_t DramChannelWidthBytes;
+	uint32_t Reserved[2];
 } MemoryConfig_t;
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 8eee54c7d5d5..c5d56757eafd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -747,8 +747,7 @@ static bool dcn60_fetch_dal_init_table(struct clk_mgr_internal *clk_mgr)
 	//dcn60_populate_dc_mode_limit(&bw_params->dc_mode_limit, init_table);
 
 	bw_params->num_channels = init_table->MemoryConfig.NumUmcChannels;
-	bw_params->dram_channel_width_bytes =
-			clk_mgr->base.ctx->dc_bios->vram_info.dram_channel_width_bytes;
+	bw_params->dram_channel_width_bytes = init_table->MemoryConfig.DramChannelWidthBytes;
 
 	dcn60_populate_utm_qos_model(clk_mgr, &bw_params->utm_qos_model, init_table);
 
-- 
2.43.0

