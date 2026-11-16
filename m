Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935548;
	b=gHKdruq4BazT+n5DGzGYnXDlEu3u8899hHJxf/V3jSjDPZMTMMWsklf72wWgOtnHAQlH
	 V4UQ+UYk5AdLIdkrJx55+jpB3TIbPlPPUGVAquMtwagdzT+PIn99DNul08XWmGqYpLXMm
	 fPgCIrJYqd9RdKo5M0irR3AMxb4/Jp8Anaap4XrdijTiM7tO0HM0Bvq29/JA9+Jt8j+F4
	 BG6OQ/0TAb7aXw8a8OiQxItmI7YbKxr83qqww6NmRUYXLh/jdRRmEFPl7sUxK7+LCAJj/
	 ZQ/tgDtPhVjcEjRf6T8/Lbn7w0zViTMus/EVVEdHMXbJOE1q/51tRnTaanFI96hd8lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935548;
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
	bh=C2cFyZ+X/Kxu5ja3JAFdyQ1q58b35+E3ezuqU8+O+Zk=;
	b=TJZYbok+DgYW6+6h0hwxstpfS+yt7EgQfse4eajcT5rC0Qh0GXIAeR3E2f0b1jPoORcO
	 MYV4ENylJD4npgwahdVfHeTIXW1BxkIDBA88ibahlPignsXDCm4F4peuNecD2kEyRGW8l
	 umv8ZvqmLAohTm1pbbh3QeIQwHlSjF8JqsKN/yjC9b8X/V28RPNwrHn4zTkQXMpYZd7rP
	 bZ5NEIjb/+xy6guBDoZgECkUl6mst5DaO0FN++oW7bTlV00eg+7gmKYErtXwwlFk3yCyM
	 h2CQMpW3QT0qemBWAJltCa/KRPJSzdXFbA5dKWZt5KGDmqtnBaCM74USlKzBY44SZww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="t9/3hohp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99954606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99954606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t9/3hohp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMT4la6MBFwU1rjs0tkt0qvuvu30umUyh0hAA4oogD5z+wdj3DEzyQiyGob6cAPFAwpbrHVzv5sqY+AhBvhCzriqH91VWNpcvLF2S3SsUS0b4utSYbqpHns/+WaZphVwTTOxg3JntJaA0Mc/pbe9bzb0k6hA65wmai83fd9JcO+rAlYuF0uEqh1DKo+L/AQXJnOabrD7mXEEC7Z8JByGtpSY82rmjMkQ1nGl7PglLvB7g1p9FBRflg56hD0qTK+sOLqLPFW48o66kZf6YgYUVDeGbFeIkQsVe1nTDqGerHr7GTtGmcd8hxp75SyvLU5PN6MMLaO++/IcduvXGugZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2cFyZ+X/Kxu5ja3JAFdyQ1q58b35+E3ezuqU8+O+Zk=;
 b=CPYIKIIfJRBFdAiflBHEpxlqOw4gxFlKU3WplxDPvz6mkEzuAj9X5xg+/8xDIwwRhjuhYwi9rd17AcgYw2/ryXJBt7eG2i2Ym8KPXezT9yYgWex5gfKb4QFu3ZHx02xBhyFyUamatuquXK9hosmLtP22mfbx300vUogIWbzs+17tb+/dZrVm3AhYqeDrvbb5IBpCHpqyW7wi6ZSHaBPq3sX5VgJm0s/baJlB1irpOwtdMeNJmID/WZE2kGCsGxtoVKViMMMdRpYYecgfjskW2knywK83ZBk4gI8uA/CQmvYI02+Usb+GYfDiysUsi+Q0L6mkZO73cGqSI6kwB4RUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2cFyZ+X/Kxu5ja3JAFdyQ1q58b35+E3ezuqU8+O+Zk=;
 b=t9/3hohpItEfQZwq2mWAOqjXTFcGWF/l/1EQuQfWpb6EIinQw3dwp+gt+2MwVX0uZmnEX9Vc6uVDHKVXrRLEuPHcRqt2WgUugJBHz/fY5+m8UO+NIjoEyfwpMkbbQYfuygY/4QjAUZm0BsgnlDfE4t6QkKcrYWCxQcTzuPgkAe4=
Received: from DS2PEPF00004565.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::506) by DS0PR12MB6535.namprd12.prod.outlook.com
 (2603:10b6:8:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:12:20 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:518:1::24a) by DS2PEPF00004565.outlook.office365.com
 (2603:10b6:f:fc00::506) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Tue, 17
 Nov 2026 17:12:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:12:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:15 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:12:05 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Michael Strauss <michael.strauss@amd.com>, Aric Cyr
	<aric.cyr@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, James Lin
	<pinglei.lin@amd.com>
Subject: [PATCH 01/33] drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable
Date: Tue, 17 Nov 2026 05:50:38 +0800
Message-ID: <20261116215641.2800595-2-PingLei.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2bc081-46dd-49df-ea1c-08df44cdeff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	LDoGunhGhoWDJTQcKZ+MqIZKeVheDClaJIAt3udV+/PipPmiU4Sz0zTCCFG2QgnfQ6i1mN320vdmCvtvMYZ9MATbRafMXfZUPEzLyFBcmS3ZeXtFrcXDrNkgfXLWwjEGGb+SBOY+bYwi3iJlcnhAU2ytCdYeYzDyAxdXx0U0OWWPSKtCiNLW9AgK+ez7WjPtksC4AxN6u5WOxrIhzEwghaMKptJ8DPMS81HXcaGI4TgQw6HoMWGdOuQN7Yq/NXUlEo46PagVK9kgsGW+xiHnU8QobNvfJ4PP4J/iQaobiNC88M1abevoKGh+7axDoGoj7ZaSJzLTGXk9M5xCgGrx1YIHWdtOiE/330U8/CJ49Oa/nfmBfVhXHwjFSHUf+Wq9radmCRP/hhDkinUPX7OW5FozSYsuqA1JY6s3tNmW0PWYAVrdcuurrgAz3hTZIs41rJ32W5Z7ZRj1h581t8w4Y3owP0CNsvCHWkKb6hXIOFIt7nPIsN8lriyDg/joVNIVaP7ZcrrKfgsikq6Nvd9VpaIzFVeGpKRtF0qJ6CVe3Mk2niHnxbAWriZmvMvs8rRms9NoGk4aSnIg8Nclb+QaM0Yv6s/7UVsVRigO1tIBscd19VMYn6w90K3IE8nwN4kQiEhChPQN+Wa/9bQWhrj2q3smEIICB+q+CFh6FhJCWpcYEE1VNmjtmBVn43qiHpsSrd0LXHccSc/6m66HjiKs2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hqpOknVmABiEaq82lf16LiqMApuwSxkDZjRE7y7h9sYDOhe3yeZVnZp8c8UAtvsw1vm+5CKcx3waW+rtr9cxWPajkFIkQsPI3ATsc2NSCHqcXhMFQTUXdut2MmauN3uKvmw9MnMpjKDdScoVIS59E7+bclcKc1uowyMDmv6gfRPBHncgo0J9rSAmnXG+Rp5xkX3yslsCQwyUtDg6yCwYyXwDn3R69dgOScRnfEKnnoARSL3CwDc6q0+r3kw8pq2rgHxEuyZw1r363R71z5Sdq/q/47H50WSLdqrw+U0c6TB+zK5DNNXjUiCqq5q2+3PD6eoYZjyT+2OsJ+qX6Bn4yCnAB9nsuJeUIR9Zr+0/lzZR2RyUSp6fklMJermrlEDpO2WuBHq9Jr4gHURXlJuKR9SNLZs0RjGp7fyg9tYCODkVNzEJvW5rXk9XFgKmJY+x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:19.3621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2bc081-46dd-49df-ea1c-08df44cdeff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
A frame-lock reset trigger sets OTG_AUTO_FORCE_VSYNC_MODE. If the bit is
not cleared when the OTG is released, the OTG keeps forcing vsync on
every trigger event.

When a display stream later reuses that OTG with DRR enabled, each DRR
manual trigger forces an early vsync and cuts the frame short. The
display then runs above its programmed refresh rate and underflows,
leaving the external monitor with no signal.

[HOW]
Clear OTG_AUTO_FORCE_VSYNC_MODE in the DCN31/314/35 disable_crtc so a
released OTG is left clean.

Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c   | 4 ++++
 drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c   | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index ce9cd32b807a..7706f5f16a68 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -143,6 +143,10 @@ static bool optc31_disable_crtc(struct timing_generator *optc)
 			1, 100000);
 	optc1_clear_optc_underflow(optc);
 
+	/* a stale frame-lock force-vsync would cut every DRR-triggered frame short on reuse */
+	REG_UPDATE(OTG_VERT_SYNC_CONTROL,
+			OTG_AUTO_FORCE_VSYNC_MODE, 0);
+
 	return true;
 }
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index f5faa49680ef..5ec70e849cce 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -142,6 +142,10 @@ static bool optc314_disable_crtc(struct timing_generator *optc)
 			OTG_BUSY, 0,
 			1, 100000);
 
+	/* a stale frame-lock force-vsync would cut every DRR-triggered frame short on reuse */
+	REG_UPDATE(OTG_VERT_SYNC_CONTROL,
+			OTG_AUTO_FORCE_VSYNC_MODE, 0);
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 406446e5eae5..b4b4792167dd 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -162,6 +162,10 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 
 	optc1_clear_optc_underflow(optc);
 
+	/* a stale frame-lock force-vsync would cut every DRR-triggered frame short on reuse */
+	REG_UPDATE(OTG_VERT_SYNC_CONTROL,
+			OTG_AUTO_FORCE_VSYNC_MODE, 0);
+
 	return true;
 }
 
-- 
2.43.0

