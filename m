Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7BD3EEACB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276167; cv=fail; b=bWYktQkfIoUs0Q+HNSAbRGtIaX3f3gBdIpKFWhti2MEn0cWpP1yKZ8Qg2B8VsXX/csTrPrmmjpzY519NGq+r8r15qxPfQs9yNjKegooJRE6HwGag8iFEJiqzQI4aYhVae0YikTyPVXwrgtnGd4tD70SWKd0PsRnzNbZtYXZ8wXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276167; c=relaxed/simple;
	bh=6oO3m3eSBGHM5unNLOS9xFEa1GdOR9bZgfKjh0wJtK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0aUdq0p1sbnjf4fKI9r6YcrWkVx8z1+zCy0XXU0rPcLDsfWwt89dXQm65LOHYpV21DVcBgxgfRwKA5oH3g0xPSrmlo7oR825/RJtmMU+r8bryDWzsIR2KrZbmPiNtAgQtXPHMPw/raWkdHrwCPA7XxeVDX+9GedjmG+4kCEsv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oMrqqK77; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oMrqqK77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICjPIciBAYYxWxMiF4wqH90zbpE9RB+urEUUdq5oM4clwkD06dlBKAh+pXNpC6cPTJwniO3t4h8fhE0DL3d2KZxEVwCUDvbBPd4Jep8CISiCSBxr1ccL9l6O1fWYCwI7HE2drCHVc4wzMNIMqDnz62kGxY+p1Gzz9oW3tDHSTxcKhzEqpsmIh95DAsqLjiSLODyFqdKOLKrMuKD/KX4Yat1UCBC6JWLQllrjGBo8Usr4wbD5HJlCWHBfiTs2b7vfYdoAeLV5i3eO7bl48fgY3ZgRWHt3KjR8IdvnNGsUaUPkYy6xPqXduzxooPsqbdOAa4mJkyLcW8WJgo9UVrJhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnUvPlvISb9pCTCZrqS2GRjM5KDNcGWINb1W+O/L7lA=;
 b=ndUc2CvXq+lbRrVSe5FPkecIKpWbWoWo/E/Dn7Ho7maz+zd3bmL1ZITOIIUfFm1iHtI8MDd7ENPwgxF4CK1ES/mTu4g/JgdmxfPEtBiFhmgtWqXA+t3SFpdhLZNv2T3llL6e0myhBcYa7veGGTbMJrGyxzbPu0XwAAZAB1nP/LbmJPNWkyoMr7Fr21e+w+w8THF02IiPAPd9qRyXx67S7YAx2rOL1eroP9XJDgzsy8ycT77dNsyXA4kSxzUr3CIe71Nah1NeoBC8JRfWs04OpASFKiOsL87s57p3wIFKmtE6votb2bmJSjOGWtSbqr6fBHHje8XYmOTfM7Q1MGQIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnUvPlvISb9pCTCZrqS2GRjM5KDNcGWINb1W+O/L7lA=;
 b=oMrqqK77E13h6q7aWo3qKOMhf2QCrS9UxrPaw0wYlvzZSXNhzkkZVAMBR1QvzsXUcB2lHq3Ck1E7fVKrGnx+Rvf29DNpXv0N5wHB1K7LZVGWlyWHKyYiZpnm1MSzPHyLeWFY1Ksg5/WzjjB58vdn3Y2h9B95rQ0LC4SzctyzDEA=
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Tue, 1 Sep
 2026 15:22:41 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::40) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 15:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:22:41 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:22:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>, "Dan
 Wheeler" <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.18.y 4/4] drm/amd/display: Prune per-tile Timing from Apple Studio Display Primary Tile
Date: Tue, 1 Sep 2026 10:22:19 -0500
Message-ID: <20260901152219.2694884-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a017a8-038e-4a9a-442e-08df083cdd4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|5023799004|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R0lPse4c4wWRqYymVbLF0aHpuDBZ+EsADdqtyC3fZdVPnIZfgau8PYcYg7U9a9C4Iu2wYQ71IOsgB6MRewzNVJ2xlSuVr1DolStADpRMJvaoeyhVq2YldArpR8ik7uhvGrS7vyslcewMPAMTCCucVK/Gu5crAz/6D/GfR+SEiazfg1cnx9QbEdpYTyixVpzAAqBBayzSERZuwU5imoOa9K9l8EXj6dqQpjYLW3oXh6t5jJQpTTGDphH/GIrrDk8n834HphTmbie4aUu8E7suDTbVByi0fLx+nqH4FRsM+yVhhhSnst14S23nkbmkeLB07Taq9O3RejEIPRx8jlca+laddO+B97vWATArHoi4xjcNH3sO6gsIdDKUKu+KGpbO1bhG28nPVsVOVQiFnwAQMqH/wQYWxENSN+TCdrteBojOgfYBqnRQp+sxhBb7C8F8W4yrYZu12CA60yDfQP8Dju8tlOWV5j9u7S4AJyaMXyhyM4LkZ6fmlwkNm2Qa6JEheTpcL2WTVBammWxUSF0+NIdW2Zv6ZNLB1FiiKpxUKO28zF67RHh6DsFKmsMWv47DHxcko5oGODWB95k/uS62HdvYfADKYe3kn2BRydVNq/PplQg6Lb14+wjhW+jbGr14gZl4eJfd3+IaEgoPzugVFlItl1oeoNCTz2LyDjqgpVJBu7mYnBcwPqc2qOmw38XDQruLiAULTixf9RpVMsBpzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(5023799004)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Vp0dSBVrTMmpllWvbiUitYsro7UOeASHOs9zmJRRpg6/42ZWgeE9Uk9MGcJ56C+1SMPtggZPhJowcjEL+OhNg9hlvvM5RGE90e4sURLZ/T6k2Zt0Qt6WVaKkAZS93CYsnF5bEeB4kaqEAtRp5BKLjjeRxZJkTaxvUdzTRjeDlHZH4SlGLyqNL+7CeRYftWScco6MI7H+oTKvRrn2i/Pi6E2uPHhZ3SyqRVOoKz0x5g+8gs4/1bfi8DaV+7G8ZvsxoDKeMKU0cKUbGoLnYDZM69KAtSpn4XY3CScXJowokKGhh5Dg5AN0/Xhhy11bVFh5NbANohyzrSkjVrCa966PlWQfyiP+4xuMXjeSCiRDlitvOMD7dC0MYHY96TdqU6Uv8ypie/4N8gOPdZ0Rp/fqiT5f5ItUYYDf5LT+eNFLF20gC3sm9Q9VM+31g+WLqxr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:22:41.3491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a017a8-038e-4a9a-442e-08df083cdd4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037

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
index 1f6663090c25c..deac90c49d638 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8540,6 +8540,47 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
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
@@ -8582,6 +8623,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
 
+		amdgpu_dm_prune_primary_tile_modes(connector);
+
 		/* sorting the probed modes before calling function
 		 * amdgpu_dm_get_native_mode() since EDID can have
 		 * more than one preferred mode. The modes that are
-- 
2.43.0

