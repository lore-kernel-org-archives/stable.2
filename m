Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793143338;
	b=4bYPyQzqYjiu4QntPgDxDiy/Jwr9bWvnHRg3/gkAwM2v16fP9Nu0Ofq3hn12IkbZZOi5
	 e6FPhAm/fMKMOsS06Ebr4Bk2e1qYrvshDuYyhThCOddldUuQ51MkUnXro5Cxcg2WaJQU3
	 wWhoaRndI3wvdpeIgK4XAZkV3MiK1iuO4nHszOBQVDEnlek+Rwi25OhYxHkJJuLeHgnnv
	 SycsZfTZY6gjkpbiWujG0ekhFRCJmpbGOXvf4Fy1x/MvA4VCNETlUsbqgI7crhS6m3iq9
	 yYPYRZn5ZZ1QYgA92/Rtbpq1jWWJm9sla0ooutxRvGUYUQhkM7f4D465M5AaguxSc4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143338;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=HDCSExm/1XOcvPqLSU0reKIRFqo7ScSCFVCxscCbc4w=;
	b=DNCDJWP6TN4yxXBflV9rnJ7/3I21+tPtkk/c0NkOmeGunLtHKknbuTctmV/r3uYEC56T
	 zmkY2n9uGGZC08DwG/vTcjsrDM6fmradQbWwy/Re7TiPjoNpYObouEqYkBgUNI7t7kL5V
	 X2XN36G4qqQGwH7Pr1ePU2XQVSQdreBXMZt4HRnDktj8Q+/QybjGEbftT2WTKR65ArH42
	 4p0s1G/aZNSCJ0qbAScks42pN4KKfVoFR/nSA/DfNZjHZK2wzMaHS+12ySYikH3nDbzZx
	 e87auY3m2t7v+8Mqm/dpovb9JgA1QpLIsKAHgSiVvJWRRBPYAMBt48kflqimUMwDXXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="C+aa/lAj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.23
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41B606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E41B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C+aa/lAj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHSiVtvpY+qDl4lzh+W0hoBJ5fhDBEP9cSq13mhqgMmzz4gUsy4RliUloT7t6aLJ3LgXNOMmyjhHGkToMzq5aTNhpJnFKfb6amZXVgzmNrJx13ruawRjF03nwho7/htdUWG+Ci2Xz1dhHC1VoWuMDCWzspXZSo2054mV0xJLORvdUHIWvIfHSiefdQPNZnqxYQoOZj5bgYFenzR3GvFlD1zuKALcNy+vwNft56KrA1rHn6bqHoMZTuOh4fU/VqR0RPMYMgtLlNH5IrH4AO/anz6nOsu4572fwEz1W7fUBhXUndVwW3oWNnDPEBcbbp9oQDnfC06xh/+k72xJ7HxIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDCSExm/1XOcvPqLSU0reKIRFqo7ScSCFVCxscCbc4w=;
 b=Rnzc/sc3J79RnifKrbHlOxw5Qbz2TO5nbbuiD7XDuqoZ/tVWE7a97O1NcN7qvgj2xoFh5xnERp9HBaNEiV9WUi/1JZ9EjEQ0loJVBwCrlZ7SKhyJVlybDB75wxxBRNd2Row935+bCeoOlOvASb8LGWG0JFcQHCwiMUpvDpgUjznVmBKyAtGW5aXbQDId/gBA5QRbNwG5JW5Kh1eBLQBJtRIfPSL5KrzUpoAxvxFO8ZrHS8YYd9zNtfBtDQE5ffWgczyGfG4DuI0lbcDLfOuIJoDh3U8U/+/oyBo/o7++e2v6polxs4pq3ekT2oEGCXYrh1BqsUCR6tIfpRg0xF84EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDCSExm/1XOcvPqLSU0reKIRFqo7ScSCFVCxscCbc4w=;
 b=C+aa/lAjpZ7+mMz7YWxkGHZl1h38z2LH2mkQDb67RaPgRQKrRFfqxSMvZdYWqh0/cf/Mz8npnMZXb8FyjYKYs9kXGxW+H1NLxCxkZztfefmRxqypSOL6BZpUMrlMK1ifg2jxtbc0a2FkFFAzn+FfotZVTMoro1YdBrMrWcz6LLk=
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:22:11 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::87) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 27
 Oct 2026 23:22:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:22:11 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:22:09 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 08/28] drm/amd/display: Avoid closing unowned DDC pins
Date: Tue, 27 Oct 2026 17:17:04 -0600
Message-ID: <20261027232005.2879750-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6ce1ed-a302-4829-5ac5-08df3481209e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|3023799007|5023799004|261022113327099003|11063799006|261021121427099003|56012099006|10067099003|261009223027099003|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	YMJlCw039M1xKJx3muTI8UEYFTMZE39D/SlI2rtcskkXowlio3+1U/guqvZRtURBEnthazVcM+Gvqbm39jEzkAAy08CNX48e1Yb8JvXEd94VS6arC78/tNhdDrZVq4g10XInra5zDiYkiR2m31Ng+qTg/2diebv/sfev32GyVCX320u8gf7BCZNzy5ii8UfgrDxGMylpyusUTI44xVJ78phvgwFzgc40X78JXVzjDUQWYiR8G1NhJJZYbW93ysgbmiQ0/nkohju+QVf8PnjoWDrNBcXtrTZ/YFkXl8iwqWBhosiry35E8wB/uu61ilu/g0JwvR9KHrio79gBTo5FY8AFdWJPqTw6uroPeHjPiESbPdDCeBay1K1D2/4udOFMNThrx6Nj3IafN+Y+O22K6wslM1epbxgPz2WauKv7azUDEwJC/yH/O8lKa96uzdbAh69F41srdGW8YvI9d7VMyRbhzfX4Gub5lh8NuaX9sAqKc3Y0/W+2jSxjKB8MHFrdG1XRQE6CBho7tsn6o7qkUmb6zaEYMtaJxFP7pZee4G8UxA1I0dzFNI5ErodnXv/e/oojakUY7g+KzmTwXm2vztWO4MkER5GKtK/PvZFTXkJBEtokNmPXX7y//wTFPobsZY1df1DqLEkGthqURBsRea/SsdkaYrEou/WVapkazkDE2s4LJoxRdEHYq5o88WJ1WgDZlSHXm8rpW52mPXUsYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(3023799007)(5023799004)(261022113327099003)(11063799006)(261021121427099003)(56012099006)(10067099003)(261009223027099003)(261021123027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+KVVieoTec2JrpCZHarqLuNMV5wpsuTiqrTsGgpB47eMGmLAKA21N3W7LTRkZ6xVr2H83mvaOSlsHYRqLu2vhoX2Zn4+869hTlTiQnHHYY13uqArdPaNxntDKDzFVSCAgUEG95Y7ENj6FdgE1Za1ye4cN64dTpNw60xB94VvAGJqNFEUO/d5hTTuYMhhfiJywbvOiAJfh5OQqSPuNGFtyicj96ZZM7Q67wnLLVc5D4f0vU23493tQaRhjyxjjASLOKfqzUk7xOtKgUMQ3sXd+/RVgxePMmmYnfXqcDMZTJBGydgY54uTg4J0PQ08XWD9B//sZ2dPivvGivR/0yS2w9U+yGvPs6WFWDuyrcMe6CcEiFfqnp65psE9GPiK4asuilG2yQrBXLukEG+93qkKsClRa05+uTKIPZM277mdZuCxWl0eaRhQe9cE/VMCr1u7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:22:11.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6ce1ed-a302-4829-5ac5-08df3481209e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

[WHY]
dal_ddc_open() cleans up pins it acquires on later failures. If the
data-pin open fails, this attempt acquired nothing. If opening the
clock pin or configuring fails, dal_ddc_open() closes the pins it
opened. An extra dal_ddc_close() is unnecessary and unsafe:
GPIO_RESULT_ALREADY_OPENED can mean AUX owns the existing handles,
and closing them here would disrupt AUX.

[HOW]
Remove the extra dal_ddc_close() from the failed-open path.

Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d..c487c5b87dfd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2602,12 +2602,8 @@ bool dp_is_sink_present(struct dc_link *link)
 	 * which indicates we need additional delay
 	 */
 
-	if (dal_ddc_open(ddc, GPIO_MODE_INPUT,
-			 GPIO_DDC_CONFIG_TYPE_MODE_I2C) != GPIO_RESULT_OK) {
-		dal_ddc_close(ddc);
-
+	if (dal_ddc_open(ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C) != GPIO_RESULT_OK)
 		return present;
-	}
 
 	/*
 	 * Read GPIO: DP sink is present if both clock and data pins are zero
-- 
2.53.0

