Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE061419305
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274967; cv=fail; b=O0Nz+ZmjN9/y8uBfT5JQ4gl/5c+lQB/Z4a2Fq7m6ndMaXJff1WZeyEaPtdiNHGcW2e08hC2iLUVbMQySBYldHT9PY231tT52SxTdvoTMpdeaV4VW2LhkpneUHSxM5VHNGCLe+cTJe57Sn5o3VPpjDbXWabUYx4ne47Am56KAQ1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274967; c=relaxed/simple;
	bh=AYzMkccV5w3khUYNT36uy4g7rMGZUWIHCgVF3em2aIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1GhrTRknsWjJbz1mUme1z+zQN7PmY/h7djpfYJmYzWfMjayT0LV+0MV6Owgmx3RODFtsjh2uOigyzNwTT2XanZ+klR2LTQ25kRcZUbalO72RHDdFjQF8I74a7ZIlPHsLUtZcRHnAp985wymrDUOKH5pNOulJ/2vybF2PUrtEco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p2KbpxOq; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p2KbpxOq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG2kHzN6GgOpDJa5qVxE2+30eW8n3pJs9t8mlCvgDvPMQLkvijkah8vFE47gSbNE9aU+xrL7noW9jezIl2Gqhjb94eENa2oAX5pgFla+K6XDQSpiJ3uDErvcRNDL7yq0DAM6UZ0padKs/4r4aVFcixvRvjSi3pe/bRvGL95nCk6cp4bF1FZXbuFy9TIbVBxihqHiRHgnLgfYvfHdZa6hM7q++GMHWogaLmLiC0qJJoavb37925Nv+7mWk7JTtGz4dLCI5YBH2eYNw8dSKPzqlp70oCB9Amsk2c4UROAS864al+LYeEUke0WCCqYnCy3xrymZ8RAPd9jmM0Ycj3WeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+wABTQdi3RgbuvDBFtrp1dgkuevRlrCH/FivQLwGTw=;
 b=Y+KOsObrZxTrIYRP5KfJgC4e3+Hqawywv0fJLw4V5vzssc/q44ChJFjLVy7VFQpUfft1AGRovRrFtshoX+siO13Z33Hr0Zr3nQ1/J48XLCMmC5gO+qoqnHbbxsnbhgDOp09RrD5apCDXKeXsCHK/qywWQgkXqb1orFFtoTFa52dNpqZ13IXTTrRxcWyp6th2d9zTjxJn9nS3WneIU7tYhkYB+CoMDRjnaQxO5aQOmXTFc+4+LUiJlNZYrsXCj6yIxezAPYac3yZSQcc8/NQOdOapLnxS5R09jYjjsMwL1d8jQSxPMcDl8yswyPvtW2LMimyu9adkNXSoo39EkffWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+wABTQdi3RgbuvDBFtrp1dgkuevRlrCH/FivQLwGTw=;
 b=p2KbpxOqXhr0nrY8oJXqcpmK2P72fqSWHGzj947Y7i7weg97glFr+eQOkh+0MMtbn/3XSikrirari0SZUfpHLz3cFVG7WMWiutun9j6xWrggkTmCv1p3ZcktXPX5ZH+dA69U8wkgERaEJpIjeC+g5TIDvF4WdopREY6vwp7cg4k=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:02:41 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::a1) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
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
 15.2.2562.46; Tue, 1 Sep 2026 10:02:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Jerry Zuo <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 7.2.y 1/2] drm/amd/display: hide Apple Studio Display secondary tile
Date: Tue, 1 Sep 2026 10:02:21 -0500
Message-ID: <20260901150222.2671040-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6f5899-fd0a-48a8-ea02-08df083a11ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	OtIrmPK6vawefdDIwHh/CPt13D3XYzTdGBxFqsWJZUv9QugKY4Uwa8stJhzYeG+rl6syktq2kCXHTSxJ/jz9rWx5pjLWzIXNfTlJQcIflnoF79ew+7ET8Gsp8Flw2IiMFfpVcRRo1tjub2zrrVVs+E3GBhjQJ8f2lEMjoEksm6M54r0NLEbItl/NSDd7Ptmrpv3Kb80HEHO31PBFDKToVhkLq5m9jAU+GtaPPqSFVyVC4E1ZmX1hROG9pqT1wVJG8Oa9MaII/QEFItNRaMcn11qF+OmfbrRRkah1dQF0CE5QRttYdtCU2auNz8PfVDVVRGDeXVFZcgeE0w2Ec2Q+a8qgLw42fx5qhlAqKc2dzOWrbIH1KPxdyQ3PUmL8reDd53VrV1xMRC/ixlEEDVLIWrx6TBkeuX/Bmw2YiGIRgsSNWl2PyRXU7npL3Q44B2Kf1ppDs1O4TZ6j41C3nXI7FaSNxcdM1CNQx8AbrE2a5b0kHmUeFPBaa2I8pYWIFB6eZtEdgVeR0+/hN7KfDwRfL/SJ3A+RqlcMdRKZBLLQxnskNysdHovRLy9+lmgWnUzGl6NB866eFXaVGVi6PFf3BfOlJ/fn/gXj+RJsUR2CoKZGv2Zhbe8pqXl5gBiwHMUH+Jn8W85pFM9yzSzITrVymEMyerH8e40RGaqaymz929Yoh1Te3fZ7T1YPGzAQFEOTk/LoKQXD9oxlnJSbd79CPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hED46dI6Pd1J3v3/VKhlY8WMe+xYH+b6dV3ACou3He4d9pP+O9bZVSFJJYusmWQTMTI9vqiroM7HX7Ngex5YgxyoL1ay07aO0NycpNgZnE0qmpmkw9AMkEL2jYtUf2voR+kdv0iSdEc0DEgv71LYtv+850iBrUQ2hB9RUbW+qvk63t+H+ou/7nTVKn4gbfGpu+aEU061VvdBmlSrmNN1fOt/Skq5v+So1t8RH2UZf7IGQJIK10Yd/GjngOr6FnUfAjObOI8GM43LVWlA2TPX825ymnVKLQYwjUJuHDGLXbXOzUdjh0E1NjeIMTY+ZMkIjhM8jVuv7cjVa29j8AA0OY/8NxsJSG2tRbIxJRni4rlGpo7lqTagh73qv2xxr0FChNr7XnaU+1byUNBoDiF45b9XnpWlswEHTTGdrBHS3NKi80s7Vc2+l2p0Cl+DmX74
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:02:41.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6f5899-fd0a-48a8-ea02-08df083a11ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01

From: Jerry Zuo <jerry.zuo@amd.com>

The Apple Studio Display exposes a 2x1 tiled panel over two SST DP
links. The primary tile advertises the full 5120x2880 mode (with DSC on
the bandwidth-sufficient link) while the secondary carries a per-tile
2560x2880 timing on a link without sufficient bandwidth. Report the
non-primary tile connector as disconnected during detect so compositors
only see the primary DP link and configure a single 5K mode instead of
driving both tiled streams independently.

Drive the behaviour from an EDID quirk: add a disable_second_tile panel
patch that apply_edid_quirks() sets for the affected Apple Studio
Display panel IDs (0xAE3A, 0xAE42, 0xAE46), and have detect() hide the
secondary tile when the sink carries that quirk.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 49521be4809d63fe3efb6bc68ee11cb1e1ef3d63)
Adjust for lack of movement from amdgpu_dm.c to amdgpu_dm_connector.c
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 ++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 941c1a3128249..6604ce25255d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7846,6 +7846,39 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	return status;
 }
 
+/*
+ * Apple Studio Display exposes two SST DP links for a 2x1 tiled panel.
+ * The primary tile advertises the full 5120x2880 mode (with DSC on the
+ * bandwidth-sufficient link) while the secondary carries a per-tile
+ * 2560x2880 timing on a insufficient bandwidth link. Hide the secondary
+ * connector from userspace so compositors configure a single 5K stream
+ * on the primary link only.
+ */
+static bool amdgpu_dm_hide_secondary_tile_from_userspace(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	if (!aconnector->dc_sink)
+		return false;
+
+	if (!aconnector->dc_sink->edid_caps.panel_patch.disable_second_tile)
+		return false;
+
+	drm_edid_connector_update(connector, aconnector->drm_edid);
+
+	if (!connector->has_tile)
+		return false;
+
+	if (!connector->tile_h_loc && !connector->tile_v_loc)
+		return false;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] hiding secondary Apple Studio Display tile from userspace\n",
+		    connector->base.id, connector->name);
+
+	return true;
+}
+
 /**
  * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
  *
@@ -7889,6 +7922,9 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 		(!aconnector->dc_sink || aconnector->dc_sink->edid_caps.analog))
 		return amdgpu_dm_connector_poll(aconnector, force);
 
+	if (amdgpu_dm_hide_secondary_tile_from_userspace(connector))
+		return connector_status_disconnected;
+
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6be7f6edd0b29..41aa8f9bb152b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -134,6 +134,17 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
 		link->wa_flags.skip_phy_ssc_reduction = true;
 		break;
+	/*
+	 * Workaround for Apple Studio Display which exposes a 2x1 tiled panel
+	 * over two SST DP links. Hide the secondary tile from userspace so
+	 * compositors drive a single 5K stream on the primary link only.
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE3A):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE42):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE46):
+		drm_dbg_driver(dev, "Hiding secondary tile on panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_second_tile = true;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4ed1efa172709..6482e275e63bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -187,6 +187,7 @@ struct dc_panel_patch {
 	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	bool disable_second_tile;
 	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
 	bool oled_optimize_display_on;
-- 
2.43.0

