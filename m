Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36B463B6D
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521753; cv=fail; b=s0UbJRnJyx9ZfC4f2VgnvfesPscw1udhYrCPMvGk/Y+TkppiquxvX9iELhVtlL7BJuwIvFZcZMznPc3191o9J/OAVVv8YFV94sKjMocbnBkatKbboRR//Ko4h0T0En97QCeZPIm37X0fOszWriTVhG9CKiWSLEtzV4Bc6Hr/ihE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521753; c=relaxed/simple;
	bh=Z4T1dwuMAb5XH2D6UMJ5H5/gjCcV38fnNkjb3BIKoX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUQQ5DJA6Y2gYi0IZ0pfiKsCTN9QLUdqaBbZrCNoOwJr4kJRXeS0I5uPZ1aagCaRacSNyFqvxkx3FsNn1DmgJavpJXlKqD6ngPfhTTDuSj+h35/1KkF0y2yhOFBhtfUC4U9VDfNWu5KXcibegH1ebIAnyABb29CUUmKuKfbQBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B0ND1YVA; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B0ND1YVA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POAfRb0Jzfwd0b46W2v+xtrLtZCKrY/zNasN/faR3F5eOiZqZce4wsSYfFvVjWwRUSB+5ifYm1Z9L5LTlRBt8KPAVvurl/5Tmj1GxTnkkBLYe/bAEqSF4UomfjjaOlSphlTimuF/ayrRinZPLQF64uJFSCgCgdv2T4eZPNsWjL8Ofqys2D4hRQ2DCYtVbcC6QeecmFRlUW8MzLUpBPTRixz3ZGjvhW3TByX0WazEJE8NXphPL97W18uqrGrKCXB9yUVt+xHqnxhi4fDBXOvTamciQ3rpFZO791EHIZpmhYagyYn+Zy838wYcPE65M8Tof7a6HOAd2R5+sGD2Jk+WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVKZBpWtu7K995u7l92rW6zJrzgKjQz1droDq1AAx10=;
 b=OopE9djTWlZgMQX8TTOYssa9yPj1BBC0KzB7mu0S1j5mexGGVYj+B6nPKqZYKWQ6k7ePvdEllQgM+/jQO99iwtd23ame74AOITwovxm4gr5S0A3kMj6DEr9PyqQAgFjpRF/Y2zWO/UTExgTYlOVrh0UHBD8E1vv/H/haGqzLCzcjKQrMf3cpyZPJp5orer/p/IYVEh0lBkcEF1lMFKVET97wIsJLdVIUrdzKZP2VoVCCPCI2jQ61C7FCd103jENUP22aTDLI5HfHfcOmWltBa1dBH+afT0kjOA++uZGsNl8uVDcvHNRC7x2aGb+2IgxkIQv4ONr7jn8XmbFV5dx6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVKZBpWtu7K995u7l92rW6zJrzgKjQz1droDq1AAx10=;
 b=B0ND1YVAc+iWn/+vRnXlm+yHnB5ZVo04NITDMUmwJHR/IzckrLYHsXLjTCafeoITx3sFETS6OflxSC/LDGptQGniJhZKp3ZM2SCiyu8KCoMnB81yqBctkUCdVymAQnBTesZ92lm3x/D11woxRfO4rYeagyjCCUnRFhLym9/kIn4=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:36 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::e) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.10 via Frontend Transport; Fri,
 31 Jul 2026 18:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:33 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:33 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>, "Alex
 Hung" <alex.hung@amd.com>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 10/10] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Fri, 31 Jul 2026 14:15:21 -0400
Message-ID: <20260731181521.681990-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fddbce-2196-4ee2-e290-08deef2fb793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2Dlo5M8wlIzYvEGOqpKEYsy/VcmSd6eXgBBjSWDiSZ0lvyR0XAZKkaHiMPu7GhVAmZtYXK3FmTU9MJC/KVtNwb3ArlY/gofxQCMh1CvFEG6wu2l9KJ4o8urQ7R+S44Dq95rXoidpt8J7Bdgmb/Rk1bPtrsuwW8HPhopJ6aD6K+eljtJZ0ES9VSRu6FX+6HbiX7Q4cH8kHOrWTP2XAfrZr+TEQwn5+4qAH+nYZTyJwgIgd39PtvfCgaiI3khM3Ru67kQCautbfk51Ztb47nmz0Pz3I2m4eFCNhs5EXWqOrPbCw5SXkse9hc+s8FmRdma6u6Nw4orlrj72OXMKKCvIfAiASIObpv3doQchkcMnQUej4uVo9Ko57QKQ7vnxlIY6bY1nYImnaqLLCHJ6PQUP/MTVgnCX3NnIMZCt/Z7WBvxZ5fmPBoA1z3V2pGmOvEpXxdQMoe8OxjSTS40PtP9KDpDC+INzUl9y9t6Ag9a60cv8l8nunRrnVSe48pqUk3j3w1GLGj5q8AZ49xhbO1ErZ9AN7vLFC06ZRcnKRQsmx6AtljDWjGf3lqJBq1VOb47l2LDbvgfpkkfGce/gdJHraH3yyZnkCLPxF+HE//MpHtT8Aq4gVAmGUL4iPJ+zgwRcPC+EMUlha2Y+nD+oG0/JkM5Pu0MaAi11gD+65Q2BKysd/LqWDKrHOsvVQ0EGKwkAZZvNR7CF7waDgqvcvK165Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UoNFxWcTvyMzL3KNGsoCqr38pTK9qFNxw5Ap7/3RZZFbOWwtG0TRSBSMzO9gVmBqziyTGBuBxwoz5sq6FPEUsuKEEjmd9j5hfHsznRYydp4/1nNCQIZLssX798o5lpS3YCrQe8TjwSW/YRSgXZ4QfFgJsnAUlChkOAk/D+4pHlFgJY9RB2PiOqpaFYdDPc306gmITCpIt8BMZrowZGPmFZwXyteKaEnlCeglQCuOUUTM0RleddXfN8KItwLcBwX/vng23qNIUSRrkbUTXV9+LeOHw5eDyHUeKEphw0aqivvUUDd6vXep3ggIyo3UURI6zRJ99M62BO7013IzNE0dIkGpD1odSFusjzpBxROBk75EMmHhIZdjI1Ho2T0LzNTXiZOlyQ3f/iQba3c/3alg9KOIhpZTCdg0FU9TVnYLnO6uuK6HEhdHVAjifHZIUV5t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:35.5182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fddbce-2196-4ee2-e290-08deef2fb793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

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

