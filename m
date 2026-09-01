Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB00399342
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276170; cv=fail; b=eT9+smimhm7yfAcXtnk/tyn4Bj/B1ZcjXAO+kAmplplUAo8E/f13aplqDv/5Yjiu2blz7/nSAljpAULNIt9R66F+XDxNbqAB+IZ93mLHztixYz6C2VJdBuVJvTEB6sGxXTivsbiUyvEUU1eyE41/9OcaWHsZoD6V/Umv1C/tJDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276170; c=relaxed/simple;
	bh=FR+IhDVjifRTfykk++Qn5LtZP64E+eFN31gGOgh0LzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIek5KDOK4782AxuavL/7+z9bIMZXQiAJ9uLH2IhMFtk3fmxjMDiTlMYCY1/6+Wiar0VuRFNVMW2xX/b0IQFZqMv8tfugeI7ONgD0J2XmQjiy/5f9wBjaJgZUTsPxWYqdTxE2fb4Ozf+rgpDz9WZoG98ebnbdcfby2/TtecoRAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RuQb5KLq; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RuQb5KLq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVW/JMwcwmgPZn5S7X3ShOA9FVkgDdn9OfxbczpD5FDY6YC50v+gNGzCXCWk9B1KrYprqrT5FZLecko6kIUc+tfwfhXT2H8YNQ65X4JIG3mDAyntNc94dRwNEfTKfyfxHRWhqtrpwPx22NdnKQP7Z9Cl/+CIJzVRsqEuP8UqPChC/nhjiiqdAj9cRb9Wu15i3YoWSy1o5OlQzfbio48tq4V7NQcgOd7ztAENZgxjtmx02stxxt9yYez8zpfyK5+A1PkdKpatULr95Bt0LK94BfYgNAduYAVFe0+HMvgCWc4SCoK9KtmiXVI9zVg94SRbcraW847NJy3pmx1cnH/0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LIWKoyiyg4JZVztFSUPFArOfBfNC+cYZpre1wVOTMo=;
 b=wH2Q3zDuoyvFDnc1xg79PpZkFRb+ugfK1nAJTZWXQCzFfI2ujisl5a86vxevcVnE+RS44oHHspELZ8PII9NZE8s6GyWefOrblKLq1lLBsdF6hgmq7VmdFmL7W+YRzl0u4h7Dw7KxXXZlubFy5DHduS77XOyz9ZNZYAaUDlOh/OH/cgwWAw85EgZT1MzLNW7uu8+zGkDr8mpDgFLbWNssoyvboLtGKTpXfe0IcNAK2YvLOw4OH0iyEFMMxRM0r/RRXkpqzqbNT0WP+J4IFvxhRrE6GsiQFdUeQU6HHbbt+e7K4GDX1ZRZIZOoPR6NJTBpjYT4ET4/LHXgOfw5K2fHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LIWKoyiyg4JZVztFSUPFArOfBfNC+cYZpre1wVOTMo=;
 b=RuQb5KLqqd9gZ7uFh83rB//PsvCaDGlv7rg2S4Ye6EBeNhG+c5rHgP5Vl3Tq8F9Y7qXslgEPwi2HjSOhIw92dI/UI1dVL6Or3FOFfCI0K2AcSU3eXqgfcFRl5PhjAr/2nqAjMuCxz2vvmQP2CICLnoMo8QH+k6lCtQzfQdpRohA=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:22:41 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::22) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 15:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:22:40 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:22:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Jerry Zuo <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 6.18.y 3/4] drm/amd/display: hide Apple Studio Display secondary tile
Date: Tue, 1 Sep 2026 10:22:18 -0500
Message-ID: <20260901152219.2694884-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901152219.2694884-1-mario.limonciello@amd.com>
References: <20260901152219.2694884-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c71b06-2c2f-4a55-39dc-08df083cdcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cdF2R8g/70JrsVQPD6z09pJuEaXF31e3hRFP+Nn7+j4HI3PAfXaEovoibUUKuuWOMferM3YNyM8HscUAHJqDasWVfGogXD45z5y3H+cqfw9AKMt8vKtfeJ6cnjxcbD7oxNuP5CgDyihlibIbP4rgKbeD8VRn4zmthN/oBkCQTX5bauDoaggHa6C4a0cWt/dUn1JIJMPeNL/53wwVZnVrYgO6okORQhbnSYS7ayupcyL11pGnzQmynuNBB/twvqxMdHj/67JyFhBmA5s8vHUPVxt8z2ngFxw+K2sEcJFKZ3mfDF32e8zvE/kLDlq8lcpfIQe0tgnD103c/wqZjZBk1x9LrmSWO9gUs/I3lY3UpFcHheRZF+Kmxtauo8uS9/+3ytnZFp4Ey4Me+y6f8EcsVNpRzdnoetD10BqIVhYFC181HSlcIvQT9pjOHXYySnq9Cr8mKfxsikDZfw/RVx+b6/AvQnuYUzmGWKpv5mJ2qOuowYbFR7USVsko1ZbBT6L1e8XOWDzJJX2NYQyPTQktELL2WeSdorXId1w+PgYyMZZ77ph4D4uy1P/GZ3vOevKBSfTO96NOyr4YFOK26C/M0JkQBHEH09Ij7H3vqVr5TQvyqJGpNNiDPX7yHKdRM1sLD22Y+IwTATXblgItJR6xRm1HmtU5feVydD+dbwGqW1vhXzKqjUc+ydb6/sJ+liUojJVPbWgckG5vL3/oQoVB8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PflmClFTbVJOEskXyiVwZ/MrNMKKM7fdmzN8qLz0jQNUHqkKXIYt4rcpD7Xfzb76CPiDuG84zshRMcxxWnWWGTMEgFp8Zunb3cKYdpyBWX6P1XwA1IF67Yf0MgsG8/c/597DXst5OGTs9i34Wr4J8A0F9hspm7hl1rLjar50bs/gkTfVQ4es9oa6MLxAVrmnfsLyVTd7wsJUnZy8GVQA4JIfEzoHTUMTVaiYw7jOLqhsDCzyEqt++6X72iZrWaUlv76Kg727pgkCjB+w1vAduG9KZkeyqjz8lZeTE8PB62QJgIEK1VdRYTuZnR4WapRK0MkF36I/kGacHuq9OiVmc7iX2AQHVjIpyrop2GzKpJfXPPULBuZYbeExtJAdS45DMzd1/RaFdbsjRVN/Keyz80geGCWgivr2h3lFBdBpGohhC9XmvY9YzyS9VpUlBDcA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:22:40.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c71b06-2c2f-4a55-39dc-08df083cdcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

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
Adjust for lack of analog connector support.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 ++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d70b94c688c3a..1f6663090c25c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7327,6 +7327,39 @@ create_stream_for_sink(struct drm_connector *connector,
 	return stream;
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
@@ -7352,6 +7385,9 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 	else if (aconnector->base.force == DRM_FORCE_OFF)
 		return connector_status_disconnected;
 
+	if (amdgpu_dm_hide_secondary_tile_from_userspace(connector))
+		return connector_status_disconnected;
+
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 21f391e01ca7c..25923b00667a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -95,6 +95,17 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
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
index b5aa03a3e39cf..ff06a1dae5c61 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -178,6 +178,7 @@ struct dc_panel_patch {
 	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	bool disable_second_tile;
 	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
 	bool oled_optimize_display_on;
-- 
2.43.0

