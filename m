Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E052FFDFC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274970; cv=fail; b=L7578rmrju53Xq5ogHXqUrZTK/mM+/ZiCyiBUVAJN/lNE0Wupm0gy3bRWojVWPrLw4HMCHJEJKtDX+Famn8NCv5R7AF2weMtptUCOckl85qlDr3emwp+o2VKVkwra5OGdBFhqzwzKIebyHWOpef0XALb92GTLe72y8+ewRA3cjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274970; c=relaxed/simple;
	bh=2r8EELBzPEnX+mzY5bdy0dndrRVq/WXPMS9GIPQfUJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2eJLamakZs9UH3rGhMxVdtFzPvd8RnRWjlEZM3QqK9XxM0H7onY47UBRX+bIdQagS19IWD9x0fWblnIFyli0u7mklSinLaLMCVNS+uj7xprZ6uWGyVk61KZWrIufcRrVAn0JlHZcmpgcVpbq/+RYvrMD7aBbV6xewy2Fm3IWpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w4lfJ8Ci; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w4lfJ8Ci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLgcw9GJw8PAYwtrWM7ZgYARkEjOAsr+4aO0GelZWzVZruYfY5X7tkVFIuTg4Bg0FcW/A7CTSXmubhEDXWc8f6IDsK/WpRIPeQ88EcfpHvMleMaYAAUdRgnc4dG/9fbXBg29IGaJDtfLJX1xr6MDVRKYVNH7WRvBST4mdRZuuphB4p4A1KXuRhDKH5VU7u+gUkjKv3x77T51oKMjGHUHsS5bdcDI/B7URiBip0ICpE4ANwflZwlv3HGAkKt4JnX+7K3QB1jDPbh0LowGI/Tnh65pxeen8Y3Cu50AtkmzpNbUWEFXMreW1s6ORNz+xSabgfRKfIkiBOsm9XUFXskxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXcntE0T5zNdncBJ18o2n+MDruRCA0cuhZWC7NP4O7E=;
 b=ohHBfDpq0fgpKuJNWw8HLM+OVkU5xxWvTI/KvPtvKwIm9imeuX/l18nWIrvTWevHRVarwbIuWP/UPkClleBzXRgtJMyV1eIfqly+/g+VVFpR89iOKjKEjyv0m7V07YvvEmigauDQq88iBzNWen3Q5TRU/8tBQFBGTRiz40ZUbS3ssyY/A2Ej/iXtBb/xYRHPxufyIWgiwAMr1skcU1eR4dT68AlUprYLP2ba2y7np8KwYE9JeH1iBA6cqIPRmqeOH6RuX4Z8zQ4yrxuchETruefaF5UH2yM5A6v9dxDLrehB+5333rWln+pjomcLVPNV+/Go+3niQN9JeuGwjS9P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXcntE0T5zNdncBJ18o2n+MDruRCA0cuhZWC7NP4O7E=;
 b=w4lfJ8CicEbwBGfrejYUYKeEoYDbr4WpfBAzfB4vEGsmZZvn5GEf4Fltp43E6Wfe3CC4s9wE+sieiSY2/7Ns49MpePBgjRsgnDcaGJn7ICowyD+YDAHSrUFdDTDSytCLZIbbgosRqRKAl3gNO8LTF4mC4UFj1Ix0pH+Sr1bCwZA=
Received: from BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:02:42 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::44) by BY3PR04CA0019.outlook.office365.com
 (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 15:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:02:41 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:02:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>, "Dan
 Wheeler" <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 7.2.y 2/2] drm/amd/display: Prune per-tile Timing from Apple Studio Display Primary Tile
Date: Tue, 1 Sep 2026 10:02:22 -0500
Message-ID: <20260901150222.2671040-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901150222.2671040-1-mario.limonciello@amd.com>
References: <20260901150222.2671040-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d39f2a2-c231-4c22-41f0-08df083a1261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SSJkFx+2DMov2ib7G2iD1+aI7gySvmSa9mF+5eeVsiJdBYdGIWOJjJUchFXhvGeFjU4+boVlg4GuCeh9IIOM79jeefOsqpeFx56LUsIN9DmyLBGnsDu+DgkKmyPaDwTpdhtFemxo5bvnmuFciDOflbFXmrgaBpVEa2sipR5DJ0ywibKs+TY+e8cE7WZVIfaYm2z1K0+5NVUXvFbowjN4/eDjj9EldoSNaowx2XHNYqw6CyKjFB5HifHlByAiLJcuXWrY2ndyEceDm1TFMFgFkeb6Po17+9IxWy/PEpFpI6c8J7GYWCkovcOWrn7+cxctdX6DMjFxbI1F+lF7TOA3nARG611HcAt3Pu65XrxVWfj93UiARts0299P2RRzBkAk7U0q+mL+w5wcfKHyw+V3i1jfS2RK/FLcanSkoZs7TOnS9UJQLui9Z+Im2j4hzJINrBhpLGXt8ssPCcO0CZDrLjzwSiTjlGtuelJChTqZRw0m3C9PS7Jl1NmBdyhjniiQbc8nfX1sZlj2JwCm0Chgsm+YWw5vF0q7tEhahaTJObKFcsBHuE9Lv7HPJEOxRAxS1HgFA8XH0Jn+ZdMv0qpMwYivi0lmkKQQirosKFAVB7d86RXdSZyyeaF+UnoKKvgFIGyhRULxvmcZlO6EvQ4iW33tmBWYsz1t3B7XjpM+kLEd/n3UwXlTof/xaYhvfTrBAeC2+jLhZlAvJGpT1llREA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kGjOB7g+cEXBjIiT0KJMAoR/eAzRFgdwQSKNsQIV10K8kNVsfcNkTFeYdIQCPxYaS2PTa+dXi9jxMq5hsYw7EadbIKEB1cJq98cY4chsaLI9CswAM4arZbfNea8CdxIp7kod5WXc5cVG+qrAlM5HZCp9mhITFe4m/15TcNaabaCNb4AKZvvphk52NJnJyAe72wieu7UuExVsA6Xz4+/wLHPd03NaSaFgX3iKIFYzJD+QxbpsB/DpWiVGjZzxN5wWeDlfNDikWrcTObo7H+qbwoq35hVYzm7CiEOnhc1Ia9K2D1Cnnr/1Zy2XLTUzXA9T/c1b+WymCMb9hQyJm/kLZVL2k+Z2L8m1S4v2QKtrHJ4NGtNz9vxtkVpLo+F7homsSyUCyk9emAtVllLzIzZT1oqckj+oNm4bWRvEE+cUQJjHDobZfLIB86aSEru+Mr1g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:02:41.7739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d39f2a2-c231-4c22-41f0-08df083a1261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

From: Fangzhi Zuo <jerry.zuo@amd.com>

[why]
The Apple Studio Display primary tile advertises both the full 5120x2880
mode and the per-tile 2560x2880 timing. With the secondary tile already
hidden from userspace, the stray 2560x2880 mode on the primary connector
can still be picked by compositors, defeating the single 5K stream goal.

[how]
Prune the per-tile timing from the primary connector during get_modes:
when the sink carries the disable_second_tile quirk and the connector is
the primary tile (tile_h_loc == 0 && tile_v_loc == 0), drop any probed
mode matching the advertised tile size (tile_h_size x tile_v_size) so
userspace only sees the full 5120x2880 mode.

Fixes: 49521be4809d ("drm/amd/display: hide Apple Studio Display secondary tile")
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7a4dd08c3f921576c6a7524f60e4f0e4601835d2)
Adjust for lack of movement from amdgpu_dm.c to amdgpu_dm_connector.c
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6604ce25255d8..9320e49e44289 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9116,6 +9116,47 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 	}
 }
 
+/*
+ * The Apple Studio Display primary tile advertises both the full 5120x2880
+ * mode and the per-tile 2560x2880 timing. As the secondary tile is hidden from
+ * userspace (see amdgpu_dm_hide_secondary_tile_from_userspace()), drop the
+ * per-tile timing from the primary connector so compositors only pick the full
+ * 5K mode.
+ */
+static void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct drm_display_mode *mode, *t;
+
+	if (!aconnector->dc_sink)
+		return;
+
+	if (!aconnector->dc_sink->edid_caps.panel_patch.disable_second_tile)
+		return;
+
+	if (!connector->has_tile)
+		return;
+
+	/* Only prune the per-tile timing from the primary tile. */
+	if (connector->tile_h_loc || connector->tile_v_loc)
+		return;
+
+	list_for_each_entry_safe(mode, t, &connector->probed_modes, head) {
+		if (mode->hdisplay != connector->tile_h_size ||
+		    mode->vdisplay != connector->tile_v_size)
+			continue;
+
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] pruning per-tile %dx%d timing from primary Apple Studio Display tile\n",
+			    connector->base.id, connector->name,
+			    mode->hdisplay, mode->vdisplay);
+
+		list_del(&mode->head);
+		drm_mode_destroy(connector->dev, mode);
+		aconnector->num_modes--;
+	}
+}
+
 static void amdgpu_set_panel_orientation(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
@@ -9158,6 +9199,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
 
+		amdgpu_dm_prune_primary_tile_modes(connector);
+
 		/* sorting the probed modes before calling function
 		 * amdgpu_dm_get_native_mode() since EDID can have
 		 * more than one preferred mode. The modes that are
-- 
2.43.0

