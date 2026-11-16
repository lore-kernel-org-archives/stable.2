Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935765;
	b=dxy87er7aLSS24uhKVscnTsqyO4QNBWaaKkIBd7qbF9gjA+qsIzCZQyFHdczuRgYwNh7
	 tyWI2s9zTs2sP40kldl/9FIqcRbNPVOj5Mj69Y0UPxLgp7Ez4u/TMjU8O7ywY/dtwYmsH
	 Wvy0N/vpVnkZDWYq90Lzdl/iED8PB3p8bzp5d2gcEXkzIRvlHhvyw4tspa/do78SrTZ2z
	 aaEcgCgN9FPPYldAqxsbEuCnBUpcA8JvipxO4LfPT8JJemFJtfduTm5777ruY3nKSbq8F
	 XHj7htV2bc37KXcazw8neTj9xxpmXqNtrPD5J4doFGsJZsdcm9E7Tl+zpHLhCz7p0gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935765;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=v9QIGsGpsDWxp+6ngNarKfkobvGuOwNjAkuV0ubTIdI=;
	b=bP3DwNRoNk/ltDFMaXi0zRvMHrkLOpjdFf7bAad4vDYa+HZzGuvJIGKKqze+9gzTF82q
	 hdbDO9+bAt8CvtwLpQV8O6OpQKsZ5xSDVqcuUjnZs2/iIfrUzYJ4nqYRbCQSo7hl43fMo
	 ny8rlqNdrYwMbgzXX22mrw9h1Y+4mg7w+ug0AvGxPMagrgkMs9D8JsHKjtLnHSh7XGtIq
	 DmKLT0gAaefJDxQATnSH3qzp2xpqQnNWDuEgmbXvm8ScWUkid/fs0J0CtECMfodUzHRPO
	 9P137g1gZbF13jXYZdRGcI+sfEpqcd4IfZYC75uMakTTjWIEadwCcvtM3d2tVdD2qOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VGMGCZxt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7191606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7191606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VGMGCZxt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMnQmTGmziJVJ6C0rPk6BizKGqsImvC0odqynDt9mk9RvrLLCFf+odAYgmStFUYAjWgGFNiCn9U5SHGNvjG0RN+KjDLAJsBbEVzWIVEO+/DG3RDRVGFYrKhg2EFkLLzfNdSQUk5aG5nkfJcmvLOT9xNBGMxwowaQ0EiIAeZZhCEkwZQUxe3CbIPsTuPu2NhVsXM5T5w4vVWpMnUGxI8QpXOyBoKoh4j001mL3QiyNbaiQjx1xqovDgpNRS0yIY8tQ/f1cSEhPF543Eqg0V8q9ilshO/xVEotsjAY4xNWzfB2xE0wX6rwwjBc+Jmp5EDtGtdpso99KMR7Ee1ozuN9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9QIGsGpsDWxp+6ngNarKfkobvGuOwNjAkuV0ubTIdI=;
 b=eh9DZ4sOmJPBhkmBFPTyEYBwmRXXVDrdlJDS+E6UkrG3QuXcyhOIlTyh3xN+yv7mhoEyQLZFZI8QdR5rUbL9Z0oy7/TqKoT7SCdoPrzzzra7TdLvD7DLmMAqpF7s7mi4L+O+77fHAwKlRyxiOdROuaYd1ELvb14wtEjBLrrwuJB/XiQ3RhRN5VhiBCtGTWcxNehWsRVPCTjCmHO4m7HaeXpX25hSEBT/PlTnK68HWWF5z+xBYRLFW7memxyT1MXuYaMns4HCP218pZlMAl1IJCTJeHWc37VEwWoxv4monY2F3GITLRCtPrZ+CdvFIY7vhQOeYXB3r7IDdHkWvHYTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9QIGsGpsDWxp+6ngNarKfkobvGuOwNjAkuV0ubTIdI=;
 b=VGMGCZxtWnLZ9PmsO8GV3byxelY8s6bam17w+n9lCAfjNXCkVoop1p1ZW1RtDjfz3hUXMmnMhfC9Evj0a95KZy1k53TsMVwi0czfpX1P/xS+akBaf+WAYT2Udre4PYFKb1+b+S0rmRXEpIIGaMz3nUdvUxXGBhUarQiQZOhGMHk=
Received: from BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19)
 by CH9PR12MB809658.namprd12.prod.outlook.com (2603:10b6:610:314::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:16:01 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::29) by BL1PR13CA0404.outlook.office365.com
 (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Tue, 17
 Nov 2026 17:16:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:16:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:57 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:15:48 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Aric Cyr <aric.cyr@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, James Lin
	<pinglei.lin@amd.com>
Subject: [PATCH 22/33] drm/amd/display: Skip DSC padding borrow estimate for zero padding
Date: Tue, 17 Nov 2026 05:50:59 +0800
Message-ID: <20261116215641.2800595-23-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|CH9PR12MB809658:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcb577a-5017-43fb-5db8-08df44ce7432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	WHI0j//kDtxGTNfFePlG/6/vefVn2psdIoNDPZy/6pd8bSaLUswzRRWDZ3QvY+z2f6DOQX2WnNEy9FIVF2d0ecQpa0bhGrAywGzfpk9LP0ORZbJWfRmKB88IgBhepygn5G9mABOgSphMWM2ai1xOHLOwvsadL8Btzqq1a2CmJNUCkRSaJ2j1XDLGc9YKOO0J9MsXdR2xtE6Rzu6XYc8pYmuuah1uV12PSH/oGX5BTLjBsLeHhk2ZsCwVB522elTm/734eyNRwS7RFluoxYe921okRC7CHPSCiOXm4lMdaGyAM7r1czVAdeGVOM5zy2U+VCFTDh1CUvRH0NOI7ekyXUBT/wiwo5BuzuUlozLd/x03HcroJcOTq8k0I3jAooRzp02oUNy/7V/3VHohARjYNz/SHxTiJiTD1U2mZWY9HOtg206urrs17ySUQX9pHagIUSUCh7uWNAnbyjjicjYxGvC4Lhe7kW3Mgyt7+ZsRIg8FlbWsPIEMSPGAcznwQhTVqSXx9CcQtSTKYSKWBx458CKq0aAURTR9AJhhVDPq90uiUFOoTZI049LFUmbE+w8HC72nv6tolIwnW6LpUkBWTtmSSWwQMm90OYWOU2uE/1NkkuILTwEM1592zYqlPU8Bb3ZE3qQKbI9iVFm2VaJVFbAjLGgppHYHBLVV/htKVkjVnI/hEM4MQlB8UTJQJoRzKc8jZ98n7VUOc9r7zDfnrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gt9O3ylyzj/fEn9PxtmCJXTEP4BBlYEhH1pXVrvEfra/yMkeU1i58+302rFocVNTPSfGkS0KCHV3QRxffhOHNZPHOgjBooTOiM2HlkuXQHeMkk4h/sMeL9V2qgRP6ELmWo6dA5DolKmSU9MRP5/Zu2LkeHajzB6jR+i6IEOI87UcHTf5oQ7SPoplaFsEVsoqgbYQ3oTstXVqDyv6qcyVZHkVhTMPsry42dijYXWDnpWTn9H26OBKkuC5VWnZzO4BFmy4fDnwpn0ex7Y3sgPS10RltfJMVdyaCYicMCrZdF+y6m83TsWq7Q9rMJ2f/npqHvUxpKpIoWYz0YKPuNuxelViwLHgFJ2RzKapi7nCWuZN0ZzXCcLXCkOK8AKsrlHQ5yKAzKAE2OzVWdc+NZo7oUueHMOLKSzZl88w6JzHPm+2qtYgk4ofApQVSBXmUspn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:01.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcb577a-5017-43fb-5db8-08df44ce7432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB809658

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
For non-DSC streams the DSC padding is zero.

This causes the borrow-mode estimate to always borrow instead of
falling back to FRL_BORROW_MODE_NONE.

[How]
Return early in update_borrow_mode_from_dsc_padding() when both
hactive and htotal padding are zero.

Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 2eaa830662b0..cb201c9ee3c6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -1173,6 +1173,10 @@ static void update_borrow_mode_from_dsc_padding(struct dsc_padding_params *dsc_p
 	uint32_t h_blank = timing->h_total - h_active;
 	struct frl_borrow_params *borrow_params = &frl_link_settings->borrow_params;
 
+	if (dsc_padding_params->dsc_hactive_padding == 0 &&
+	    dsc_padding_params->dsc_htotal_padding == 0)
+		return;
+
 	borrow_params->borrow_mode = frl_modify_borrow_mode_for_dsc_padding(timing->pix_clk_100hz,
 		h_active,
 		h_active + dsc_padding_params->dsc_hactive_padding,
-- 
2.43.0

