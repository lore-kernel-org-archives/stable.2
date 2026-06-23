Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AD2853FD
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233317; cv=fail; b=Xn20wZA1pVBokJt/snYrO6ue7gbrb9egOQAr5OCPN6POEy0ImQ1kRtKADIPeTLnYiKiIurOJvMDYVj/QdOlmUK1EamYgpsWaVsQTO8eTlc9jy81DeBHlKcxMQ6PkI1wf4Vxu/gWKQeNt6U2lRHGycqjfbRoVDgNlFLZyxTN0IWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233317; c=relaxed/simple;
	bh=dzSThcVUfh9KzZvHtl2fiPMf+zm2g71l4IjNkz5T9m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlxIkEWN/v2RzgibNw3s1BvX4GxYveTYDBk01Rtuhhs9aunhZri9+i/jzZ4ijMv/y1ZWUYS72AQQx4H7g7+ugoPXJw09tCHAFMZP10lmoThhLrV/j3R/jYdlALJNV+YWcTCABkKXaNPc+akPlc69iDoHMGoZPdoQJiOU2T2RtNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0W/MLK3p; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0W/MLK3p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLQS1TjBieCLl+W8WLKBfs5E7IZU5iVTZRqRV0ie7dYa/gIkmei9819y1ZZjVbkmwH+SmU2Yuevmhki0TWrKljyfFy6GgRPmTAkoKeSUTxX+h/ULNypr6xSFOdEdxa/yBrcH/KS9CaDxZnRM6RJs+G5BgXiyQpkVazY+ZJBOvtX7TsCNix/f+PATahDENgvZMMm5L5Sb9xK2flFB9E5ICm6WHg5V4eGSBdVj9EaEhKG8UGXkbLhWGXfl6Xq3O9rgLHINNmHByxm9/DeXsRsQvp8On0pvIVYwA7wrvRy2G7Fb/XytjrKPtbYbwCjf1/KZrUJz4r4WzjCwheTWd/TJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg/bCBaXKD6Nq74ubYWoPaOCU31VEaAQGDMZ4La6HoE=;
 b=vVpZoO3SIJqNlT8xGMne9UZlxbJlcmZ8JP8zL8snoLgWIFWNybhRT8WQfkuhhO54/wAJ4TLIWNB/O0al3mw0SP0UDZiPc//Gfyz2fY5ZgkHM3uKH7SkkE2vhwR5DPEhMm37rsikpR6cB1vok9Hs6JOJzi7FmInmAZIXptVr80IW3iM0pu1Yja55JuBBnjnKAutMVyaauyQLA2/X1IFkoRhhuEcFyRlx7EEHOb+IRJ3Uxz3X/Gj4w9X0NcUQxec+/yZHC9JrHVdWzJWJ+D9s6m091a668R8AqJIQlFtkhvJv/o+wTWul3xzU0wt4KEJzya1Ge2dqmVKADdPjXtgaj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg/bCBaXKD6Nq74ubYWoPaOCU31VEaAQGDMZ4La6HoE=;
 b=0W/MLK3pCvnBvZFl5NUT5+WuD9xVpAlAaw8GIDT2USiuw0aQhinCkryp8SyaiPNqhdvJrOawPsUBxBkAzRTBtsjQW9RJq2fREXrLAadTwfvjJxduahmf9AiRPfI9uDSGDE8ibo6l+CkzMKnH9hJ7oPY6rMjn1g5FXrPwAZ25e7o=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:48:28 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::8f) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 16:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:23 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:23 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 11/11] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Tue, 23 Jun 2026 12:48:12 -0400
Message-ID: <20260623164812.81110-12-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9953d323-8857-4eb3-76bd-08ded1474070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3smlFf/8xPlboOJMR5SNHqW6R3G0948VqyEAuTXUMePQ1BL/IYPdoR81fC60T79eOcSqVnIMqHgyNxI3FNUz7BSMn7bTqfKR+51iONpSX9LMgeyGlOS9VbANBO4HixtvzziHNQEuKbVQYHvwKwP3i2GvKXUGE1dvUZsfJ2GBoQPi/oEi2/6hRR697WSYCgSVCMbLdqGpuTxzsnMUkBylatrOhpsfRglxqbkUb2h/DHvxe9+Nz8lLA+eX8cGqrdU4hv5evwCgdlzBziZt1DtEbhj5NwIt1q89MSXMS0GRaInUF8APa53YYdln+37DYKj2jAYHVPVXka6U8xjPkFlj1EKxQ6IuR96TTW75ju2gf1cZe4Yfa/vMTtyI35oxLAG7yA37s/Pl0XqZZ+fz6z9ukkfgZ/+lNjBuLG19UxvcyzElGq9mi465CnrkGlgE/n7MCvmiENTwmo6xsWHD2utp8YszQNGtZ7rL4PxSd9GkD4Fhnbz0WzoOp0QdZyVin6lShPMQiBLnstlWfX8xZULdJ5Hqe/5Blayjkq4P9Q+/99osuJZVRbpQc1rNp8o44HUZsP6yuHXgNCoNNT/Nb1awYFG42XkvdvegMI9AlQqQlXFosG6gqkweDvpjT5DwRoDMhxR4IYfU75TQyEj8s0M/g+w9Q6Z2I71IItCk1rZU0CsE0gibndX5h+M5UfpDpONMiY0J+x0ASX+XN3rmUcpKrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	If+qC22uU2BIx1OXLci0lJKM/ORNJ00xR25Y+EMvy9z9HjukfMSQgw2Oztj26cP0SSS4oAhb9fm8Urkk6Kqk9veeZ/ee1eSMHOgC3ZqxwdHUlN36fPStOAl6ovbed97TykEftRRz1+h7IAaSw+eookKuLffr3QjKizyxtA/u7cBph5UffxASiK+ixjjpn3wUcq48vYk4L4d2ljgaa7PLTLVrTtIdWdHTtOMwB6xvbvSLpvzVb6mE0P3clbsDbEaFno7TK7HfSqH4J9JbboQsSXJpC61n9VkWzbDSAHHkRPnW18iAJqPsBh+y+1YgWPKMtkFI/jBDr+PF4ABrL9yE5MaejlXMKe2BgknIm5Cv3ET+SfVdkuBJJB6/6UkwNugnKwmo8LOsq6Zw2a4QUiSWu4Ms4q+S6l+fY+3f3O004xZuBMYObOxj2n7P4bxtoOoj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:28.6450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9953d323-8857-4eb3-76bd-08ded1474070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

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
2.54.0

