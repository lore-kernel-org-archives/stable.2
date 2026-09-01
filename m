Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5F30ACEE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276168; cv=fail; b=VcLnXkb9ptJ6irZ9aCiKaRiE7fLiQLsmoCrUme/WM94QoC3FUzdhBNr5qTYwOvFDaKAa/1MHZIP4h3s/A9mbwxYkBVdNMxMl8rhZpRgMbG8nR3jya7bum+C7NMZ3phi2W2mnjcLnlYkjdtJsPLzmx+L7WLxrwEcBpBDtUpwlWBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276168; c=relaxed/simple;
	bh=IM+QmP4nCs7YgF7WEJGczLWdVNRb/FB04j1bJc2wHhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s84etyjgjesdfpCFBk5wx1B/a1J6H35+lDGgJVHUBcgtRs0hK4qqD5exBgXNlBfWjiliUmoTkRKlVEJjCJBwWTihgWINP52tbYLie00Iy+dqHkEhrS2CSxv+ycZ9V8+zbUmuIhr31kCew4VuMTSj9Kxz4Q7oha6rVBbK3IRXjZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nk7wM+F7; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nk7wM+F7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLuWsXSXVrmhOPZVG7YQWcfczQGgCu+mjATsuvUBLwSKGju5KFV2AkhOpFfo1XHFcD0/1HQDfYqeOw3MEXDbo7Esko4KTDs2ta///MHbZafNugkbftqflNE8aG+OZVyd/wcFPonArbH61jTVyHUnkpmFDcVXMKtEQ0wMJYvFmNWNFjfncigFwF11X0KS9XbNzSdf6976Rd7Y65+JsQia466Gk5TN2KDUmLO+Xad8YjkMYtGFX3/SXo1qaMW7Pmzg8vtzS3c2mfGaXy+XzmL8A20VCgJxhop+mGfNRWiyWl80w7C9LMBXxwElT053OLeIsvTLY1lsp5/R+y0Lq3I4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCU05CCD0QJHT7ES9pQmRe0pUeYnTzcautFRFtYBrxM=;
 b=BBnlVQ0w+DvPagJhSLnfiF5OSK2o36+7GnLjv5utDaQu/07omfCxkKLp+UFw+soD2STbbLToYnQYXeh5dQTrrkKW437hDP8XGx720y04XyxaON1ICrdKriJ8scRTGoVsJC40cx1AYzXQngR9DqY9z/0x23S8jIYetEgljhxQAQu+4LmgMXzz0aOq7/IO4eaTcwzXZFO6EuJgPSpUhlo8JmLvOuJANnNqoHjnZmxADVbsPfd4jY7aBHy6dCwgjXKwXGfRUhhiWIh7xYLO/lqqe4tTG5MB2ulTVm9AYhYMKmsnnNy8ya5Y3uKPvta1pjCABOVM/yVqi0g3p0oG6zfLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCU05CCD0QJHT7ES9pQmRe0pUeYnTzcautFRFtYBrxM=;
 b=nk7wM+F7793Vs6IDtPCsdGmjm9LQthL2Mjy0j+5EW3uC2RbyZ16P4dVTeJHTx+xpwImZF/LtRE54WLvAR5x/US01tneKQhPp0t6P5k3DdFRlwMnObkmXQV4JQmgm9oQyynqtXNL+w2GXk60wRpFWRFW6FnZkA1S+fFNer6FofPE=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:22:40 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::ac) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:22:39 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:22:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Harry Wentland
	<harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 6.18.y 2/4] drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
Date: Tue, 1 Sep 2026 10:22:17 -0500
Message-ID: <20260901152219.2694884-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901152219.2694884-1-mario.limonciello@amd.com>
References: <20260901152219.2694884-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fde386-d85b-401c-8164-08df083cdc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CwZrSODZhgZBciz4tNAFY0gjNZxof/0aHz28BA7wU8Zsx0lP3siZAlWDCcXbXfkQVH7kKmGCRy/V67MEoi44O6RnEIj/17HR9dwqGP1EI/35NMJD+vP61URDV4fEmqae2Rvb/GsxTmpjeEFaxt6alwG0wN4CtbwQE3pQSRRumX1OMl0XYU2mpdFmXysnHswxi2B6WsfaiWiII1JitHfHO4louXa8ANyFB9Xo4Odb+AfkktIJK7l26Xi1knubG6wI0Fx48S2YQJMu9kI9HiX3RnO+FpI0zoXCCNiUp3fEmtYvhQxjt+F3wpjFI0AHE+OtcapK7HxJGsX968dYMjrF9VWp+J3xKX3Y+GAsoCZmpUjprRo+25d1BDY23AVkQWtjbqxTtiixcLqFS2WyinqbI7n/2J8UHzhfeZ3XWQclgtnZC8PByJI7orsSadxinvAxM1GxmkX8rFzGJJrSIlVJ7YHHsD8jpC44s8eKRViM4Vmi28R5SvKBrivv/MdNLz1prT3syLLUQHBBtWG5G2LKeyT06OLu5zP4TXmpi9yhL7HGmBq82scECGQOuKpJAiocQM5wZ5mQOSXin6LY7/6yHWmqRUXq0Tyoi3iq9NPASPrCAHyvMFHnzHjKShw3IM6AYVYebOD9CnP6ucv/Ol5TCmwST3LsVPhuqCjTN71BOLC8qkq1Zu4/rIBWCF8rMI5nlurhb1wvXX0KH8sUKljXXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nwa6ZyOaAqNaZvPtdUCJC5JlR6jROdYa5vePXFGilKDzERDg8kQjqJiJxrpR8NCyZaaUGo42lvyl6S7q3g9pUOLPtFnWcsVKSmh8G+qpVudnw4BVOuz78g6FZSF+36ZfKET0egbbvykbtQ6XQGvbUb/80mTxFhwQ1qkv8blJo5DvnUg0o/LRqxCeuEJ8gBwyr6pOsikQULFdlIYnaQDpr09GfmzDxuY2p4uvyIdfW9aDjf+JvYOSXY9bYIiBWyNQsxoocoeOlgIKrTamqHekKAwTfXZBYYXZaQexYYVVZzZu1uNA7Eg1Y2PfV3PjcEhBPBSlDdlkpVYwK8qsUnfk72U8MM5OgltnvKDF03CX064kEAc7NYrMX4ev8hKBOBvVlJ/BwiMaKjlNxef4DkNn54atutvFUIM8lUnzIZWGud/vB5l9ndI22T66qEfdjDeW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:22:39.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fde386-d85b-401c-8164-08df083cdc68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654

From: Timur Kristóf <timur.kristof@gmail.com>

Prepare for polling analog connectors.
Document the function better.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8223a605744bb471f31018eac9075a539415b16f)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fd5a6c6532a1e..d70b94c688c3a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7327,29 +7327,32 @@ create_stream_for_sink(struct drm_connector *connector,
 	return stream;
 }
 
+/**
+ * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
+ *
+ * A connector is considered connected when it has a sink that is not NULL.
+ * For connectors that support HPD (hotplug detection), the connection is
+ * handled in the HPD interrupt.
+ *
+ * Notes:
+ * 1. This interface is NOT called in context of HPD irq.
+ * 2. This interface *is called* in context of user-mode ioctl. Which
+ *    makes it a bad place for *any* MST-related activity.
+ */
 static enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
-	bool connected;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
-	/*
-	 * Notes:
-	 * 1. This interface is NOT called in context of HPD irq.
-	 * 2. This interface *is called* in context of user-mode ioctl. Which
-	 * makes it a bad place for *any* MST-related activity.
-	 */
-
-	if (aconnector->base.force == DRM_FORCE_UNSPECIFIED &&
-	    !aconnector->fake_enable)
-		connected = (aconnector->dc_sink != NULL);
-	else
-		connected = (aconnector->base.force == DRM_FORCE_ON ||
-				aconnector->base.force == DRM_FORCE_ON_DIGITAL);
-
 	update_subconnector_property(aconnector);
 
-	return (connected ? connector_status_connected :
+	if (aconnector->base.force == DRM_FORCE_ON ||
+		aconnector->base.force == DRM_FORCE_ON_DIGITAL)
+		return connector_status_connected;
+	else if (aconnector->base.force == DRM_FORCE_OFF)
+		return connector_status_disconnected;
+
+	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
 
-- 
2.43.0

