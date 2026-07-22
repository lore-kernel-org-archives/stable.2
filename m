Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655B349CC1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727990; cv=fail; b=G8/MKlYKtkgwAWPFXrbhiANYh0BpIgxl8cAKBT+71eIAr5/TQmggApLkbvhOeSQIydh7MKXKB4jtuYp/EKdRxGcTvDCu5jPF1+pT8TkXwg3TqqFMlbcQmr/IZYduV9uUHxCPXSDAheGPVzFADNdAl/ed9tvlDLoUfb4lsmga5Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727990; c=relaxed/simple;
	bh=awGJMrqrIHjCm45s6RJEfzMQWMBd2zSgS+uKqJxxuA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIKKdH/2bZqod5ETCI0PWQ/r9KFl8C/k2J03cekwnaxoAmj6qgBjeSdl2QQfxfv0iDi/1Xd89wq8pK5YinQF2moYgV1rNSivA8/CIaqasLrhTY8v6sTL1NjWkdZDdFcIHKCpg1xDmmT5PhQDGm/NkAWIW4zD2nOOFS8iFKQXyow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L38l6p0V; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L38l6p0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgCN4pqvqS8DGXswKGG4ZDaFXXwpRQBDAGCr8I+4lsYiL4WfFdtDvCOoSX+kq6edjqwSvpP1yFJVDCxada21aWRK7dCx6qo9OG53hjQUvv0MRJRNyt/Ws96reOPK/XofUXaFjjiA9ei6NoH+EjIrS9t9V/hB3QhuGPPQqR32Pw37O0uQV8SAb+s9O3XplkCQ/fzrW2CSnEDAd4n5f9WKDiLVhn3P6cmgikqRZWg+QE2xAs/Om73AbohGN/ElNOuM0r445b9l5f1WoogxMgCWj5aPMNkSDtZl6vixuaqe5RaUfOnJPZnk+fp1ZRhBUL/nnhZaMtEzsbyZxEng0KnNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6BS+VBgDaNb/3vu42QNw4S92x/idYXyXgXGx9IlRzw=;
 b=fBmDZ3ZmpZg7KPD8mvJkf3PFr9PCRL6nCFNOGD4NUL6nlfoVGfkT5LAQ4VoGQattUNKsY1g/5t8hWGGBqDQEgWP17PsNBQluPARwUakj539sNZpAxIbh9g+ggeIUXYRGT4f4rLrpBwra+BiaCtnYrfs60xsanijeQYruInGUEcSNS/oKlClymrbuTbYNKH+CuYJW/know3+XIWOdpcC3wONduEG9/kJR7N6BpBbtHYLZlv9qaebMKHXLdywrQX96JsYyqtPiUUHQboJIohInPLFydjdP1Nk4KAvfSLEpyIAPmbFjG4v0RaUbWBYEf1DG166CClb1cqwUG2S9PauTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6BS+VBgDaNb/3vu42QNw4S92x/idYXyXgXGx9IlRzw=;
 b=L38l6p0VgZ0611ybM9m+XrZAmtz6g0TcgqnCKMeAV475qGgZZmkuAGOfIXHjah3Zq+z1HBKKdMTps9tkj1lRXG0RUJBEJHTpEA5468UowGrJtVVJS8iSGzvzxK+00c1ueng3kLyT4JodPdKSM4UCKti4wS7zkwFBX+akYi3IXQM=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:24 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2b) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:22 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:22 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4 11/11] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Wed, 22 Jul 2026 09:46:07 -0400
Message-ID: <20260722134607.136293-12-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4f7756-52d5-42fa-bab6-08dee7f79eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Ty3/WEx0IHXnjAP4gA73c48LWWY0P5e4EpvFkJ/GiP8xAYa+opCdIidbWoQYrpmkEvOSNikkvx7arIJHD1sNog2WrMVqfD0PLcEKPciw+6BuhM99Djk0l1XDT2QDWj4Eykx6nOELfwUTKY0yFE2eIWrRPG7I5QxGvD5HNfmJUS25pJbwWUeIrSZ3ZNoLP9OFIZ1GoewziGyZJtfVW9OQIOdqaHId7/xMAjg3BcOLl3u/NsdHrmYae2AK8Np38DtU1ACEHo+U0JzZPy3shd+52H+jcafu+43k3HLM4Vhv9X/iovm23MDZLgmaWMrlx3Bg5I0pDEEsX4cjb7DEnB40U7D8YmlB82IPvipz0fek5UuUOycOL+OwlfgA8QSdfX3ykQ8ICAIdEr5z83sNqJIzs7lcNsplN53hVVxhHcwUCxXXr+gOjDAeHq5SsRWgICOe+Y+CtoQMVzP1H3NcuYWfQ2hgJVFfBYziZfeIDXCRgU0m5VCIlxQkW0u5nHLw4yhJ4xgV+YjNvHZBUSru0TaecV8J0s47Cev2h6pVs4CupODSm5zFCucQOjnJCY9yWzcvIbCa/vLoAvb9NjjHtX3BjBEyw4dOgc7aCfkMqngarruMQ53jmJzF6T5PzxiCn87xZJFpkUP2WXxBIIHVCST9B72UTTu8/9TXfQwE7t7VheWQyI4OFzypXXTLqRFexHVGquVqVAbRHdpNn+wBGhGdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hnK593+SI5OIQR2jNRxUjBGEl399SgOQ+3N2JW4g8weXimaTXg+Q3wErs2twX6aE7IQ/hHN+3NszQZUdOO6A/vJvaDo7NwwufH/TGH1rpAHiylgTgeHcz8fgsAnvt5/ZrWgt/7NA0r8IA/G8eyWFnefBYcjSucSHVI71nrv0D05May0C0IJGiGevMpoT57Ip4Jmy/3FKxEZr5w2IHcpcck1q3NFrtNUts8WxKR5cnzr4q2mBUHVEIIuRXHZNRpc7fstf5nXfRCunCCVRz8iPsH9e7coW8wP3YiTxZ/ZrQGPsVrxEiLblyZaV8cpQv3V0ICL/1s3NJ2VK5XOivWJVF9rbhv8458VOfzQYgvuCt3zM2BoXWkYC0RyQbMHLmaKnq9bhM8A5VYE5I0aw/P26SpL8u8VVOKgIRM9o2iIXNRycrLHm5Wzu/uryvduC79IM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:24.1279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f7756-52d5-42fa-bab6-08dee7f79eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895

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
2.55.0

