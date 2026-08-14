Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB03D5640
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742314; cv=fail; b=Ki1C1Npf69zWhC46BCjzfruy+jPQzYBQQ30Hz5kJ3Seljj+jHH+WIH0z44D35A4Q+NnabMwbCUX20AfkRScDy3DzDBK4/Ko2JhCUh1bBd0Nkx7zwHyDNDTLwLotE4XaNvIchDsxhKyR1G8sxUQQJU6KPc63TnHVMdu4BdGRs0ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742314; c=relaxed/simple;
	bh=Z4T1dwuMAb5XH2D6UMJ5H5/gjCcV38fnNkjb3BIKoX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fug/5kIuXGI0bFTZxdnwBaZvEzTyHws/cvhgBF8EgtQQBuUgMK2XpCsfI76OdfSqOyGTUQyVp9ZXB40anjFQJEsprmTuh7DuZJWQqSzInrJHJe9JUf4fDT9qC77p/GAaertNKU7J0ZNqs8dRJFq8atmTiFw3VMiqMYQIW+n6EZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nvzRxJ0v; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nvzRxJ0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2+HXSI/R5+rXtR2bymlMcGaf9A9D3t9aVCQ9SclNINCoJn93N0LJJkwyaR87fE0G3IOTzNg5boqbWpJcyKXVe6716vezgD8mZ7YpvzkuYoX88GM4oC9VA4YK9MXCG7FAjhcKGM5QrqwoupWgyYTFBDNXhntFD/KicTWH9uzDjQpVHEikbpN2MU9uOlyqk5MFsR1WaL97IauqlgyI2nUT49vXj9ZuWW1On4lImPy0qnuu0s/YMY4og7Cfyemft09P9p8wJkg6WHEZqTHSLCqaNLXtXIv1aBhmNccVkDEBXA2USVucFUkdDJ1JqklcxzBQq6iTvHmtS7uFLI34XSseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVKZBpWtu7K995u7l92rW6zJrzgKjQz1droDq1AAx10=;
 b=pAsdkC6CxcS3qhOtjh9Wb/rvZJb2balKH+c77LabtwqmxKzdjZGZEscn0z6bEbhnkBTiGgTAyJudt0B2Xm0wgbiXO8tND/0dSF2GqaFgkd4/k/JhRY5LmJL0jlc0yvkHmEncgFjJN23DpTfZo7igRJBwHhpsnqJzNC/j9Cs+qE4Lywh3gdDv+Lfr7cFA7lomDODGzkF8HRrkSI1ecyrz05Qk6gq/gJTiY2i6C08YoZMjI5O62Rp7WKKjoZWWEmDddqksC4ly4ERQPgYnsIFIX3qn4640dDdv+AOVvkBzBnSsj9hoAwztcRnWx6KLV7EFohz9W5hN6c34UF2ivmnI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVKZBpWtu7K995u7l92rW6zJrzgKjQz1droDq1AAx10=;
 b=nvzRxJ0v63uSYrvqE8dg6boKJiihQkDv+YBT3CnKftuxgixeAJwhtxliAgACGqjDupP9YNW+JPjw9j86+eCDirPDfooGH9WfkitOEkKit1h6jNqCohEV3guvjY5BnpCu7M9pFvBdlfy1eYqwEeNc8AG1vB67oZvXfrT1r8LRpU0=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:24 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::9a) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:23 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:22 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>, "Alex
 Hung" <alex.hung@amd.com>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 10/10] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Fri, 14 Aug 2026 17:18:16 -0400
Message-ID: <20260814211816.1219597-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: a25c02e1-d1bf-486d-cccf-08defa499339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1kwACb/7zkefYghGHPHTb3NS1I5GvGDhkjjLLuTNEOPRhcATGknYLc7V1UlE8reEzlR6eU5Ygvpq4uZ4XpeaI6vr3+Zyf9EobGz/474UNu+TFhiblVxZf+G3W85pHYNq1TzbWm86UYxTQhoB8jM9VEe+4js3chvqPdFUVEuwpQ1LgAIoFtEY07mbRpE4skMYtXWKIWKMCR6n/oDAG2rUXGyYdPvL5moCZR+0kmUEQSLThBCwITn9eRe+i/Copu7JLJFSOd/SaNX3De3rJDUU8ExzZIO8y/7LyxoNjHDdgmMsUBUBJc2VaHZiLbhtXoacyXCGdaAm09xOhSzpj+mvLlVjEFQZ7TcoP+gOzvb+aBfHsxuobFaCe76CKuwz1yHt3Bg9O0l/evbkjofwoVixiR+uGYjV352PjEZSWywChXuRoXHi4JsG6T0U8zf9dZVnxGb6mQM5U87rCyPpm+dXb8H3z+sJhlp2LPfFimn0Ydt8iyNbEfVxnF149n6+CENphMTOHThqI17ntK14HNvOKFQtdhWbQAMNOYGuJRv4S7feMAhHkL4/QQCmREGdLwEMEuTmuYqyzWQhsoO3bnJUJHldaQMjVh8uG7oi6G2ajQBPW1DXBLlU/2wapxzhdQmQ9nfryICzBA4XCwb8CT6Hpz0KgrZslIFGZ9WR8lmI8/4Tbl355DNq1OCRdiiPe+un1vN+r7kNsWxuH0dRoL1KFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I3hyYDl/9oTJzBVlck8Q2RGG2Me1/gjQrLPqwb//O6BiuhB6nEPxVQ4zQZNF75LpWZn4SnFpaw4UorJiIEXt8ma9pKlIsWbweIk2iI5Ne5k4y5AqhZrLThOwqeApW5ypwZzwPoWkDCs/0zzn0XP5wvFWFxEWPjoi6RsjjWXQVxbEyd4rgTCVxcgHe3oo1rB+5jGJfNu5dsUlrjRK8t56ZxwCnyxSCAaV7hj+vRCtzLGWrPRSf7IMhTYy0n/KJheZ8yYhgdFBJncai3Bz51lpCGKYKwpiV9/4epcb6P965UFQV+/6J4v8Wm68KbrXezsrpyegJbl6IEjGJGS/vnrvr2je6BdZe0MPHo2di930cFv/6MREIB4mzeOo5n450QNwk5JvfsIIb2wuNtV5INJp7gBir3kmxiOxMnhZWkvzTm8Svlf2Z0Kkw0PsbQXKlJQG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:24.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c02e1-d1bf-486d-cccf-08defa499339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

The ROM early-return checks for PQ, Gamma 2.2, and HLG in
mod_color_calculate_degamma_params() do not consider the map_user_ramp
parameter. When map_user_ramp is true (indicating a subsampled surface
that requires post-scaler degamma via GAMCOR), the function still takes
the ROM path, programming PRE_DEGAM instead.

For subsampled formats the chroma channels must be upsampled by the
scaler before degamma is applied. PRE_DEGAM sits before the scaler in
the pipeline (CNVC domain), while GAMCOR sits after it (CM domain).
Using the ROM for subsampled surfaces means degamma is applied to
subsampled chroma before upsampling, producing incorrect results.

Fix by gating the dcn_arch ROM capability checks on !map_user_ramp,
forcing PQ/Gamma22/HLG through the GAMCOR LUT path when the surface
is subsampled.

Fixes: a8bf71649088 ("drm/amd/display: Internal refactoring to abstract color caps")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 03d88e78165d..5786ef5787ac 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1696,7 +1696,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			return true;
 
 		if (dc_caps != NULL &&
-			dc_caps->dpp.dcn_arch == 1) {
+			dc_caps->dpp.dcn_arch == 1 &&
+			!map_user_ramp) {
 
 			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
 					dc_caps->dpp.dgam_rom_caps.pq == 1)
-- 
2.55.0

