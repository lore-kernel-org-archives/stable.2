Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781224248A0
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274987; cv=fail; b=G1CPdHo009/D7Fj/hBEH+m8Tkdi3yFS1GeAYVVOaO4WdjG8pJ0DT0gmFOZjOA4CInbeoYfSXJ7VgyUiC6w6N+2M9iLVsWHP5fmKHyERo/4i+QT9Hl0GHnZA2W52ndGDGYntW+4Ki/VkzxXfGjxskQ1RlCEtvX+vSj1GKReQqwwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274987; c=relaxed/simple;
	bh=51lSyyNoqC+eIB2tln4zmXnIFTfHkEyOfWIMdcd05zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOdEE+Eq7nSdbuXVoPJSkRaX0LnDAEBNMicGxhF+wMlISzGKpC60sHBoaWznQZtgWDfrsC6Ujsmp99mE11zx37wcUMg2fYjBBGOUp4vOLrN7QO0H56qZJ5Bst9X0HObGCI/Nhi4P+zDZ/2IDYmTdLAsM4gHg24iZyBmHmRTCLSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cp/x8j8t; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cp/x8j8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4A9l0D8iv6u+VP2BB/DJwAM15qOZHUswXjpA3MatphypudhidwyDGKGQAdp2RSi63zpsPjTClPYvTp76xz0JH05novwSSA/B4Tsu1Ub5lDqZyehOIafg3g3wv6EC5nmfjxqPtaCZCHNT490jn5eA7tZV46CmdKX/xDBz6DWpQATs7rP++fqT8zMe1U2fIWrLtUCrovu5wonEzXeCgJ1DIEbb3dKqdgTIJvyvW/Ywc+T52Jew5s4saVqBZ1TKSELVY2E1cPxA5lEmURiEsUtIGwr3jSlAlVmbTZyekS0p1HcCKn71Y3QAUBWhDu/lWMUpO/CLyBywtGNj57SB3T8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITUnYuv4F1qYJ1jjZVM/vKT2uzebaBKqr9oBGvPjN18=;
 b=IZSTCa+xxI/aDecaZ8P2A/eqxrgYeS1dFsYlAM9cSSEJ9FtXlKDZRs8l9PUz/rqxiPmT/nr0Cs59BqUoCJ7Vf0naoWGrnhWeQlh7d+VENaSkjk/YpuH//4dQHNbbeKNKJcmLPm7WBJwBbf+9u+jFmFBgUnTqqoWLxi6iYAuZPQzMuOS/eJ+hA3Ig4HKgybXnUPG1zUXweBmYfxNJacmuS6hsuGXUJcdz5a22tJFeaEBrncC3j/XvcTy9bdaec5tLyxmTDNCk2mjfd2GCisgBKpkD2IpL2X3YvIm7DOYJA/2t2JOdSD5pL6AmUOjLjaLPzeZEOaNgtUEgxDVC6pdLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITUnYuv4F1qYJ1jjZVM/vKT2uzebaBKqr9oBGvPjN18=;
 b=cp/x8j8toSA2bQTclNOXrK53kldRvE9gQkjhghjvGo1h2TLHCNNTp4rwnMhHXL+spPrX1+sScKFWhQmm6a8Q1e1oo2zgve5rVAM/P0LUPIvJak4JQZ1GkEfcJJ5UeX2mdt1qBmUY8nvUnjzcaSnc0HcOlimhSGfO1506yKFgowU=
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:02:56 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::6) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 15:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:02:56 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:02:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>, "Dan
 Wheeler" <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 7.1.y 2/2] drm/amd/display: Prune per-tile Timing from Apple Studio Display Primary Tile
Date: Tue, 1 Sep 2026 10:02:44 -0500
Message-ID: <20260901150245.2671521-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901150245.2671521-1-mario.limonciello@amd.com>
References: <20260901150245.2671521-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: b997af26-1e75-407a-ab32-08df083a1b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|5023799004|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z7vGwCpjWG+HHWvKlMwTl4IM+KHfYr6dF3WmeorhYqKvv1/UNHN1yFFTHXTINjZ5uEh5dJiSS6swmrYq47kphmXLodiCWE3yMWDLPCoBYEDU11IrexbMydhknQzr50VGfiz/AqI4LTXEp9BxYHxrz8mJTjebSzC7m6QLyNK4d8uJeNkh2CR5gS1llxTip41eHO8OXsjPbjWy7gIfD886MwMAkWyozU4yFVf5eTasB3OQIBuit+PwOMoj/Axr7EVdvE3arB+CowsPj8mI+c49Z+NmKLbrVr36jrUsAoX6RQgRC8ReqqORLaX5SqZzFIyDg5XVPsN6jsoPiuzevK4mpu89f3DLVO8fK/UAij0AXNMElld5uPtWjMjbpRuEhteuQDgzZ48KChRXULWwGDM5gNTKohLWdPSL5dkAAKUfVgS/YLB53/yw1wHpOSDMO259Qhsex664JSM3R4cmLQttxJW7DzUoWz5Kx9kn+4Qw9NqrW5nb9TsKAxIc2ia1HVM8oCIaNjg4SaKKOJY46UfaginQJMoQ4aVzXy8JiAcz5u+fByAKgiWbYWxZ+Qqf3PiNBx6LwC7iEA2JpQ20WhWLn07qwLx91ojShqb3iNneRKVj3c1jkKhwapJ7h5fab47qbiZOmivWle9DR3p235JjEUnyzHT/6/LY5fLhX6nzds6bmxCd2BBVN876zE97JsJOtRkMquhyrDd1zK1aKPxdaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rHyfrqFL8/iHSto3cQUcEZuf5rZpIiYo4V36Zztbs7p60H0ZfnDOdKuTT3DEHtlw/RCVIscV1W0mvEkVPhlqrNAREx1yVw93kBQU/cZVLF13MKCEzOoOKZJQz2Xu0MMoadKtd2883FF5CAYzmSkudOGyvxIIgWJQ5sJSxw6gLE0PFPrZZ0ME3TPZRw5XkRIthwnFdsEkfSG0qBFm8AvyAXeGWSya71Rn9EZNVqIRdhRu7Sg6H0Ofx77feIbe+dUNE2f5YmwmFxs94KdCzu6/XVg/cJdprhABYD1HBlcVFP0RJnFnF3CKn4GPsaI6i3QTvtedHKGXcRucsam3iX+yYVAe7+6lHXxx3swH2SWIEygGj0ytEG0jaC3A+CLKuHxY2zw4yuOWuGDtVb+7xdCl3jGBjVTi46y66dqsn2rRNuGCpnVBLupZn2h7auNM6M1I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:02:56.5207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b997af26-1e75-407a-ab32-08df083a1b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

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
index 1e59cdac5ed5b..f5cb36fc5238c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8869,6 +8869,47 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
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
@@ -8911,6 +8952,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
 
+		amdgpu_dm_prune_primary_tile_modes(connector);
+
 		/* sorting the probed modes before calling function
 		 * amdgpu_dm_get_native_mode() since EDID can have
 		 * more than one preferred mode. The modes that are
-- 
2.43.0

