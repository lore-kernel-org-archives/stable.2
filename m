Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361462;
	b=DC4t1Qk6hAN7OpFfrnf5MzTgg4jZA8ppDq/DSyYXY0KDMbNwu6/IgHdSdxLWXOmYNNm1
	 ZxR1bAv7ReMwj6wkdudwmQcDb7SWrOQnq3YYRQK1WxtjQDJS9yJe/UUxP5eY7LP753kT1
	 MQaBqAB+Gms+C/ooaHmmq7YAVK6uRda+nJYqDzC2NrYN2ayJLDCBFd6t2zAG62wnmdA/0
	 dZFeD9/8eu+Fs5K8UqG+NH1I2OoU8JEdb7PRG0BVDDaL0xqatWwcP+B9kmex77rjpopTY
	 cJ464pWTTC1N2BKr3qXr8MS4C9EW3WW0WXqZ5nA/FljYVbQNdXjKbO8BnTqKzU1srjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361462;
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
	bh=6t8ghOG5Fi6nhob/cr7mudblBwVH4uh9QnEezo5zlXA=;
	b=tK3ij810rHH7v2T5RwEOrlg07XcMCrI+g0RGjrcm2rZ3QWfmM5MN+1Wwf99duAgKEtg+
	 IdO584MmHpHpqhXSBJp/1sV5EHN/tvLH1AEEQhFBZWJIRktBE0kOlTIG2PUAqv3oRcTK7
	 AYlB17yFXa6QudWw3eBEiewiYwA31Zw7vXQpP2Hb1DLlHfdiPYDfjZa/UhSc5zgmKjkXq
	 3DqJrfbilzH3ilTYlDuPuLnlVBT/V62id8uiBaiTaCSSWIHmGM0ZSeSOHhknOMvMG8A1Y
	 KkXnGq9K/BI1iHqsIH9pRwMqayjcq/S8CaYQNxO5pRSWzCyv0L4JVmLch/u6k6aEhfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rXU2mRdW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.26
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84990606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84990606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rXU2mRdW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYtN3TfIEZVTkqtUEd1m8hLdXjV46ToCAXjRKKC7Qf22kz+g/jN9VBpCKN/AnpiDANCzd1pQVWCaF93nqIQPpZfwl0qrPdyEMiZMc4GiX+xQIK0P9vY0unBMzOGTY7hfglBZwCJxlzh1KZrFPfLGsSTQf7Xaqvv03mz1qtIt9SQNGYDNUNrV6st/y1nwCjFfqvdWDOOJj0nBQemGG6x+DtvK5C0kmBbzv8ZRFbuGclilrLeQ0Cl5xKOM/mV1ZWsekn8rML8tS/BzdsjaiLiYcrnuetcPHsq0vw5buOjRdbRAJN0zwIL4ABKm08cIE7ZnTsPXE5pme4J3znq/sai1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t8ghOG5Fi6nhob/cr7mudblBwVH4uh9QnEezo5zlXA=;
 b=asnB+MKv82Evmk3eLJ3yHEukKPlrszj/4y3OqTUg3Yu/MMiw+pYO+ojPsYutlcr3+F7NnQhr3g/rILp/gOqa9TEtBinLlHmGvtEx1sXjPt9szzBGmFNdiAjCHx/yzSm4mCygcOwNwQHU7YJBPwpNcXiiwqHVwi15scRjjVEPeae4CBq+o36Dk+6Sfy/En2qvmkKvGibuM47+MQSz4NpXwy7h/9obeACm1TXNr4cbTfngZ2HUIO4bsrWz1qnBK5kP6RrrL0JvMV0mfsolGfqCJ/99hjxPBa0Lt8QU9EKoMl6DbApz3xiRmcVkKxMnQ09yk7p3bqVF1gFMsS66R7fRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t8ghOG5Fi6nhob/cr7mudblBwVH4uh9QnEezo5zlXA=;
 b=rXU2mRdWF4zoyAaYhci6NPjv/IqVIe4UdrtTIk4WM76Qcsw2tJLarg9QCXZ5IBGznH6jZrRC4lkIOsOEvPFrdzQuxB8+i9CAR6JKYG6Q0nxH1aTgl+EbW2CjGwT5Z1r+7QxH7tICoQ59IKZLkoiHA28dVHRn6uwM2lt4eXUOkeg=
Received: from CY8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:930:4e::14)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:44:16 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::73) by CY8PR12CA0011.outlook.office365.com
 (2603:10b6:930:4e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:14 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:05 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wayne Lin
	<Wayne.Lin@amd.com>
Subject: [PATCH 58/74] drm/amd/display: Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
Date: Wed, 11 Nov 2026 09:29:04 +0800
Message-ID: <20261111014100.3596072-59-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d167fd-45c8-42c8-e233-08df3f954ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	9vlncgXkaXO52qVuGHvUERhCtumiI2U+HUq/t+pmr2lTGZv5KShbsByVfL4x66v1xNfRGAfPdnT6dhybojGMw2nWxKg5XngLiZC1/3H590zuwW6dXKTkqYhKvaIeu3ElUvVdAFWGELuruQC3xw5HeczJOM5J+ayrwz/Xb1mQQphLiMalzpWDT2Faymir41qKUYLCZ0Z0aigYFheH+SCkc5VZcJMF1mfgKXWvRD77RAqEu7T6UxpnMQUUOq4KIvjpgHXPbVburRrtGNG3jW/W679dw+DEuXzV4QSbSqQJPX1WxC/j9iZRZSZsdrzkI+m3QOVo0HS5ATO96upunpEllWQD4nNc4Py/MYVxfCPH1Sh1ZDMSeO48pzj1QzDYX87HkGPPrV/6jy4wfHvHZnfj25M/btXhC7eVQqVZmlEgmyNIvqfAwwkdP8olOrXJVrzUO3buEfba+J9W/VdbJIDImEpOhlmi08kv4kAW8FSMeuGkiy/ulwLIa23g/FhUkwWVX/y6NbvCWlJi5yzqYL4itY5wxzZ1pJmKO5vLo5ZnsL1IvRdgUr9IqNwUGwcP0RfHkw6g1dalhovCSNmA6PuiGWlKQHk8AjFgIrXdmm4oZFfSQZtRXoZjV6p2suQpVdad8vYSXhE4gwuS6/c2i/Rc7hvGYZiCcMA/hgTdYZkqCA8gzPuPJZgPtbjINuskvnVFXgYbp/wVAnCDFMKY2H7ZZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JRlCC8vDyAbdBkq3v0Tdeo5+Gg/vxKLQtkn/1DZ6lUONR4DxbvxkYLE/2TQmYB4g7D2F7nV4Buhca4guAgVp3aahhqbqb+Lr6JiWg1QNfnIAe3qOQuU1F0Q9TdBcFv7AEwjqhiNCsJa+uCTM6+x4VzvCfiJF4SWr0pUDrS+mM0eSHy+y2BpEGGCXUVSVCUa/LZaJE5qBVLflaEY/QLqGDTT1WGzNh2/ibJD2uHQRoSMqbZbQtGe8yF5NBI0WeFv5XOVPcy3PHU32nBBdxHyS9bsIogR9MO9JnL5NgwbqUjbKhTVdlgb9cTXRhZv9DLi8KIDMf/D1+X0amQ73O/tr3SGTyivHoKXQubOq7nn3R89WS/C0oBb1uI77gvLORVtebc+xcbv2oGUeFto9FHNe6EFHr540T4cYqhFKYAiSF/Vr7l3NcL/Abejd7aub6L6W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:16.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d167fd-45c8-42c8-e233-08df3f954ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Parameters for dml2_core_utils_get_segment_horizontal_contiguous() should be flipped.
Should be swizzle mode then bytes per pixel.

Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 09cfb5046c81..569ab02ea080 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -836,7 +836,7 @@ void dcn5_calculate_swath_and_det_configuration(struct dml2_core_internal_scratc
 			p->SwathHeightC[k] = MaximumSwathHeightC[k];
 			RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
 			RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k];
-			p->request_size_bytes_luma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->BytePerPixY[k], p->display_cfg->plane_descriptors[k].surface.tiling)
+			p->request_size_bytes_luma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->display_cfg->plane_descriptors[k].surface.tiling, p->BytePerPixY[k])
 				== dml2_core_utils_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle) ? 64 : 128;
 			p->request_size_bytes_chroma[k] = 256;
 
@@ -846,7 +846,7 @@ void dcn5_calculate_swath_and_det_configuration(struct dml2_core_internal_scratc
 			RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k];
 			RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
 			p->request_size_bytes_luma[k] = 256;
-			p->request_size_bytes_chroma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->BytePerPixC[k], p->display_cfg->plane_descriptors[k].surface.tiling)
+			p->request_size_bytes_chroma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->display_cfg->plane_descriptors[k].surface.tiling, p->BytePerPixC[k])
 				== dml2_core_utils_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle) ? 64 : 128;
 
 		} else {
@@ -854,9 +854,9 @@ void dcn5_calculate_swath_and_det_configuration(struct dml2_core_internal_scratc
 			p->SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
 			RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
 			RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
-			p->request_size_bytes_luma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->BytePerPixY[k], p->display_cfg->plane_descriptors[k].surface.tiling)
+			p->request_size_bytes_luma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->display_cfg->plane_descriptors[k].surface.tiling, p->BytePerPixY[k])
 				== dml2_core_utils_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle) ? 64 : 128;
-			p->request_size_bytes_chroma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->BytePerPixC[k], p->display_cfg->plane_descriptors[k].surface.tiling)
+			p->request_size_bytes_chroma[k] = dml2_core_utils_get_segment_horizontal_contiguous(p->display_cfg->plane_descriptors[k].surface.tiling, p->BytePerPixC[k])
 				== dml2_core_utils_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle) ? 64 : 128;
 		}
 
-- 
2.43.0

