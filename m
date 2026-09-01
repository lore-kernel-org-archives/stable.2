Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97434229D0
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274981; cv=fail; b=i5NagrRQUSJhUx2NQ963gQHOvDiYB7DwKpSPXezWDjVqFirQph4Ju+FbMFqiUiCYu8ZN3aP/1IfA95MfWm6SD8k+TPMMqVaIDFPRC3angneKmKqoftGBIj/ZRPamg4lBGNEFARLPj9/4AX8XYPcRMC6L0H4siIl4dG8/SjyN2l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274981; c=relaxed/simple;
	bh=YIVH4AmqftbvkqEU75CtvtAumPzgRZr6NbJolKsjD+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyAcb1uuF5u64Ba42jEJFEwPFJupW8rxfdb2pesVMk9YennlTE8GqCeRIuqZLFv4TOTm08Qb25bUp/v2rRAFMora8f0PnpdZR0KyuOD32fRhF3n4HmA8AouJJuRz9/UgAKevS3OLgCTkGP2WPYtQSXMLQlutDWdrODc0SFt5DSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GgYT/fGT; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GgYT/fGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+264iJ1n75/LROfjvOD690HdKg8tAX3AMZd6uNLMjPHR20RFDJdCmRIllbZ88bRZk5573GCpVe3DEmlfGmlzI4SeyNsaXrEdCoApXg2atCtQVh0m0yfzqFl9CZk5/0W6+JdFqGP8P8B/h9hD8yq6Yxj+75PPZ3PqTAHGDYEVkng3j7dZv4GLO7FhByjRW+mG5EuEcIILeP90udlNy6v3+5eRKmsxH/M/BfIG9f1Bm7+bzaXCw7dKwvgf1DlR3JasH9WazDjgStLu7Li+B6SQjoZTNYMJKgeeNwmCIThtbRvStoZ19L4mKRxVJdr+J1we3oA2lF5/2PcsMCAPPzj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+3v/6p05iTw8iaX+i7b+ZAplNUvLOzg42M7JSvOLUc=;
 b=MJ6F2gvFXFbES9E3IQJZlwV4K/LdoHMoN79gRb2c3aNHJDMsFKbrSwHkiU2MIZsLA0Gr8JkP7fceKcHOV1wtZ1Tqt/USPoRRHaCFiraMgCgwPEG1fF2t25Uz8ZnqX6jzYJeCyAQGNcd4Nf8vTY3m1JlqmqG0pr/hP4U8EQvOVixYwU9h1bdfbLwMRlF3QOekxrmpBJL+HpMGfT0+pDrBkwrjMBnX86Zw9x2iM9JLw2ubMbc2m2VsJTsttlIMF4b+DqPAj1FJZMwF5piMsODwMeOMiTP7Ny03uJH/VV4Y7szLCxbHTwTwTZoZa0SMdl9iaHOsl47Uoosj7ZyI3aoGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+3v/6p05iTw8iaX+i7b+ZAplNUvLOzg42M7JSvOLUc=;
 b=GgYT/fGTco/Tvpgj/x2byKSYYlPixzrBkN04+DnJLFtZo8y1FlALwIgdomk9lW0/wqivKv/qnwlkS6VFUezYlL9wvAOS4DX7k70J7ofX/hic1sBMXD/p+MWdM+ijhNnlvPCNm3fv9c3+FgrVtSKhT2yZU4VgRM8s7mpGIwKzSww=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:02:56 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::2f) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 15:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:02:55 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:02:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Jerry Zuo <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 7.1.y 1/2] drm/amd/display: hide Apple Studio Display secondary tile
Date: Tue, 1 Sep 2026 10:02:43 -0500
Message-ID: <20260901150245.2671521-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b456f3-6959-43d4-3345-08df083a1a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|6133799003|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Z8EXM2VLwzmsZvd8SELUubu740KSLpAWwXRwFXACLp/6jh9Zn6JvNaat0s40Ao8z32gpHYd7KCkEwBKfaBiGUdKFuRtaPTSCawp08hw3HIsb/h2sxgxRq0Sun3ORN7m91DAYN+lH75TXWmOZKsVoOMOLaSOt3CE3Fn3+ulAf/wW9kEPRg3MP7p35KHzEq2yTohLCRoVr7XobYgXHV26w/2dihL9IMgTsJPLtzN4T7Ej/OG/O8rzXpufN5oHXYZVnYi20iHWueQ/TPSVLUyI555ezR3IbhIpxvLnyiYGjPujt+clh3Ap2ic0byc5JtILTwmbTOwrt/9iQmMXOG4t5ZwwonfdpNjO9xc4FvcPYPY/EHeD0D1B4S22OTlWGeUvepFYAFq60b9FHo/mUhrrXxN+AgQLQdMGE4Aenpo+IG0mwnGFhPLJIjZ79hc9iFVovWA1BbkUrebCKzPXCoMGD0CvleT0y/OImwr6oBl2wEC4Vny50L9ON+gXTAWzBVguZASCtRVhUJfQ8TdmRwJoZ6bDc+yuN4jTRZ/2LJ8zKzGh72gMKkkeiH4Uecr9zcHnBR5Q6wwooLiUWYH/JesWA0XSNHQzxUVQLmHS3PG1Qbbiu+qLQcnCu8f3Otl6cswmORp6dY8Fqk5BYbn/99bbrOvMdFe5xP6k7NLJcT/FPYXpQspUVW8/EcazF8I4TOch8GhuDYF/zs2nqq6OfGZAsg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cY+qPGCxHjuAeo4tod7yS+CUGcxWGvd1qxqa7vC1DR960uWui7n2xo92DVlk5T+USSdX/yRQR7RJ8hQ5gkKvquczRbt1CFTa1xcdCQiNWP70Uv9Hfd6mxqc0V2KRMNbJv1QOkB4/DVbTkmjrnETBpAJB7fZXPqEVlEsx0mFf9VtGyVE1bBYB6gz2/8L8mpfA/fWXL5KtRAyNwxsOlxaUZBbR9yuHFutxl5hiCBBKnuvMBoJfarjO/u59kGwjAUQypOChw8h0jYY5uL3s2X9ww4hhh5GaQ9MHBJ8fl+DiFq/e8nnNSlxtyyXKkzzjUuWPoTCab6udW9yJsXCFnHMCdjQW3O2E+rHqKtZZEwgxabR4syi4W1DtG75SLJ27ySwDJJxsjIrWoWarP+69zdv8JwYSxQdsEH7LF1SXktNK7mWYZKvU2GU4j06XI5JceEIM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:02:55.0405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b456f3-6959-43d4-3345-08df083a1a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

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
index a2b6470d381c4..1e59cdac5ed5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7600,6 +7600,39 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
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
@@ -7643,6 +7676,9 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 		(!aconnector->dc_sink || aconnector->dc_sink->edid_caps.analog))
 		return amdgpu_dm_connector_poll(aconnector, force);
 
+	if (amdgpu_dm_hide_secondary_tile_from_userspace(connector))
+		return connector_status_disconnected;
+
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ee214f7592e50..cdf59ffa70d2f 100644
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
index 62e35dcb585cb..1bdb5a99edc71 100644
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

