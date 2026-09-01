Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554630ACEE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276166; cv=fail; b=CIl5hjYwGmzU3M1RkR4NmKPAHu5XjBe3qZr18wu7Xf7EuSOGHEB/RA8A3cON2goVJJwFomTMwjfBg4JcwNvskR2ndl4EVASrYvb70+iBD/rtrA5gelmmcqgXU+vc9VPRYxa1v4UEYiqk3fy46gm9tg+IhVaeGFleDxKDYlFP/uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276166; c=relaxed/simple;
	bh=Ph57Cea+AmIVvOBpg3MTW8CwumCbOathM1bMv9MoE50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urHAMN31HT5kL5ry/XDCVVFuwIjQoesuoPf0zG0frvEvu7jsod8SyQj22oviwsrOLWJU+pXHXZ2UVXvNaNFpRhZ/2FLIk+qXsA+q3KWTPwXhAFTaadWxk20G36H37JuFaNMxTBKDlE3il8ZISqPULnsX6gYx1BqmthG7lpVpI/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p2S9gAVj; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p2S9gAVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJv5GecQZhvqGpd9qdKsWTdZDDqJKVEhhEHHYlkht4lRF6DTmRvMEa++0t30IOCNaraTemIycWdwDyDh1TDReFzcz9M9HxnlbDAjYmgaVkkiOedwOpUY0CBT5j8VseIZrPcq4YgAZybNooUp1n0/K1h0IVi+aohhGvjp+KMSYwELtUkRKM1fa3JnP4YdQP9doxvfAL5xAOOApDDezPHZukMqtixASRO2tXD9TYSFyCFiRJ0cIBCQyeZI4h794S7HaxzIajPWNmgmC56UBB6fbcnyyHc/K61ma6LKUpYrr6qbHjkV5SJL/9Z5m/AVtclLia45luEPPQ6MM46ojh3FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2K2X04FBdlLZi6zCm7SfYjrjiOGoAzCRsRdTQmiNOY=;
 b=H26RMzPAptZHn4VsHiWQ0YAozpJ+QflUk8sln9RWYW/hy9dvsJktufgRdhiewZUtxp4IKuc6ZPYsaYLCOw7sZQWUinvhLSuCfheXzxl3og6BYVRE+78I37Tft14w0/N9S38VNEW7gBGJL4eQ736esVuEh1FjsHG3tcVJa/aTwP5D3LgPkvqzrSG29/wQetZjWlZMIU3EDT+2u0Li/9f81MfY2R4viaHm6zeodPjjkYj/MCDdjC8LkL51yMT9xzHASjhXvnEWmSmDEXVO3gWxjK6AcaRXkA+ESNIBW7o3OneePOkRd1mUdG/mpJt+yLo80M046a6eu1hkgnGaJQziaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2K2X04FBdlLZi6zCm7SfYjrjiOGoAzCRsRdTQmiNOY=;
 b=p2S9gAVjHYaAav0lxNPrVyrFFgAKaeNM43IxILCyOCRcZm5Tr01NqospZkbphmBTBVLS52Fyes1MicA/Ndb5YAxqKNzbGiE/St9vl6RMbH6qKDiAz0I0mNUZT1y5eQgCWknlKV+OMO3cA3OfLytVogwgxPQeQBdFOzFbLv+5IZA=
Received: from MN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:52d::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:22:39 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::2b) by MN0PR04CA0005.outlook.office365.com
 (2603:10b6:208:52d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 15:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:22:38 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:22:37 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Roman Li <Roman.Li@amd.com>, Alex Hung <alex.hung@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 6.18.y 1/4] drm/amd/display: Skip PHY SSC reduction on some 8K panels
Date: Tue, 1 Sep 2026 10:22:16 -0500
Message-ID: <20260901152219.2694884-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7c809b-dccb-4459-24a7-08df083cdbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KKHwM3n//FxgVNIg7psUTu4F4zmx+pewvUKfZYIBfpRRD2oQng70mMifKJrHVZQphvPx/2zjBU51z8kzrzlksWnzMB/+2gvJF5RYrFo7DLxkvkX6eJ+2R0Igt1H9qWmSWANK4IGfb65sISQRAZDXCducFPnRaeXfKm82Z1MtJHniXlOzGgT1xiKGcW/yZWoOOs8lE3Oc05VRQNR5W1FLcLdrg0mFtll04GyqwRqdqd25YWzAp6gJHWUPWaCbeKep4YLwSboTH8v5yNqdi2+zh//Yn8clgsSwkME8jTHR4qfzlp8wRP9oFruTiNTikvs91Qq5yC1IZFuBgvxTsQRzjYky7X48k8f6CQjt0P0QMsIdHLNuobXWXJOurf5g3dSUf6zbH9ezFxd0gc5XXsJj3bgvyi/3v+QxWcwg+9h4ZXR5JJxbPUDNU6XgsRzjzdEYJ3xEzNX//iHdiWNDS3LJj+VP8hNLEEr5gflUMZupE1KE8+86oJ35W0h+56lbvq6e9F0F8rDygrpCvZSrkISHxATIEJQzjmxP0OA6T/tBMIjZtAYWaPUCMoIglPITTb58sRjLQ+tMQvhmpGfKIXMfkeaKuNZy57SG2WPfUsQae7y7aM/DFRxPE6mcMX1S8G9qWg4Ro4fNfSVEqBOrZCDSdzxjZS0/1Ah8DzRfhNVTS7FV8Br77C64GNESdQD2KqwgnuxCqYsdhD0iZNh9iCP9Lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P8bGADN/u8o3ejhQqBZI8oLy9/6Fs6haWMnaYC/Sw03s13JZ2rPr3bFCtrrv/OkkYYzqXq43RD48uuY2Hd3qGRj1vLJe9xWHD15yVVg5+UghPkbnPSHqLFyIf6QQ2RXpf3rQvEC4vqsZNgP86HHCCPnpjikT2cPfK43Vvfa95KG+XVzR6aHGEdZ/y8IEMYSvtLFlwbTKPtOsuMKAxLafsRVXdAEkOt+3wZbSphC+n87QteWY2vzIO0759VJOC68pC/TnY+LI8ehnK3dqRg0P4uFQxJhemh1N0njCxp+KyFC+wy9RcvLGOK1CWY/YF8uXIuG+/LdtuZXCJ9clik7Wb7T8HMReO0dzP9B57zbQRp/bzIjUhCijIek3B2FKOSufqo4Ab9SudgtIyOUz0Jh7SsPu1W1GHxyeFad69CHlaG1AKkcf11vlKTm9gmC4N8ba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:22:38.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7c809b-dccb-4459-24a7-08df083cdbd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

From: Roman Li <Roman.Li@amd.com>

[Why]
Some 8K displays cannot tolerate the reduced phy ssc value
at high link utilization and show corruption or black screen.

[How]
Add an EDID panel-id quirk to utilize existing skip_phy_ssc_reduction flag.

To pass the link into the quirk handler, change the signature of
apply_edid_quirks() to take link as an argument. The dev local in
dm_helpers_parse_edid_caps() becomes unused and is removed.

Fixes: 5fa62c87cffd ("drm/amd/display: Add option to disable PHY SSC reduction on transmitter enable")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 144169e7be0831e09958a906d08d1856751aa6c6)
(cherry picked from commit fe7945d092a1d3c340febc2ab176cee50d0f6c80)
Adjust for lack of HDMI 2.1 FRL in 6.18.y
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d0f770dd0a956..21f391e01ca7c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -56,8 +56,11 @@ static u32 edid_extract_panel_id(struct edid *edid)
 	       (u32)EDID_PRODUCT_ID(edid);
 }
 
-static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct dc_edid_caps *edid_caps)
+static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+			      struct dc_edid_caps *edid_caps)
 {
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_device *dev = aconnector->base.dev;
 	uint32_t panel_id = edid_extract_panel_id(edid);
 
 	switch (panel_id) {
@@ -87,6 +90,11 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
+	/* Workaround for monitors that get corrupted by the PHY SSC reduction */
+	case drm_edid_encode_panel_id('D', 'E', 'L', 0x4147):
+		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
+		link->wa_flags.skip_phy_ssc_reduction = true;
+		break;
 	default:
 		return;
 	}
@@ -108,7 +116,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
-	struct drm_device *dev = connector->dev;
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
 	struct cea_sad *sads;
 	int sad_count = -1;
@@ -138,7 +145,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
-	apply_edid_quirks(dev, edid_buf, edid_caps);
+	apply_edid_quirks(link, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
-- 
2.43.0

