Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDE2AE8D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123326; cv=fail; b=kkMsPgoSZZa1RTXcqdLblhcwgUOftPVLH3bfe/S6RkuTwC5iFna1oIsPOmMclC67lF45NYF8ZswvtEN1Oayi/NiMgfUN8cOGWkjccAO1bbmvZwbIiGgBSLn2Iu1mI2guTjqAtOC4vN5vq7/FRCOTnjHxeFJBtHCuLXKqTZ4qGXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123326; c=relaxed/simple;
	bh=PQ2jrB866ns886snYA0gx9l9IAQFaC5sWohOXAP4Hgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H06YeFCxMTVaqbYZ85+iscqgn6VLzlPVN7ZTaPzMrD7DTGKIiQhWxqh3tFl0+yhPVhqcnrWAfrt1iyza5+aZQNG0gl0OCjPYoDSyAhc5rtCx0/rb7K3H5mNHWAiNrYNayZDH+h/2/WjEuHcqV0jriLaBmXtFpgwdhRwvW/ZXbOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNIXQOiy; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNIXQOiy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOnzqGqrzTxrgO/8puH/20gs8porjVqoyQVjuYnzphehaPavYLWdEW/h26zTAitM8U7n1lTRuaMl4usaryqI7nlKnS82BK5tCtEpgDKIL+dzCQFyQOGLCHo+UNab2RJ2/FypBfQk3Dlhe3xjrR+TCQMQI1R1hnFB5YiJC7Cc1OY0orrvesAwOMvBeL+j+5aVOjw/E0wQO7SDZOazI/IlLgfBS36LTPrTGwT4i+vp3f+/+/8JilOZdhV3J9XyJilpR/WmD9KoxdicmDwgTd4wjK1P3J4QIcs2CRT1Ng6YP6CqfeTFupfquvdwNhv3iGka+71UtXMEpPnmeQs74YTKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbj5RkskGRsMrW0/VRu7P2GNTLBMDhfX1r6koRhU9C8=;
 b=GV1uQuECGSHxzcLgdmuA14AicevahpWCczPS098c5qcERjRoplMDIod89LMl58JMuHCHbiwj/RZ1e0TNipluJHGzFfnxgdbzXc97fKHK5nse0LmB/WO/MxrRIJpzDW9sBGNCv13vC5MMItf7naFpS2ElI+u97dmoQMXrmjhG2hq24inP/Nb6/uEW2uVt5Yh3six3BJt2jM83IQvyblQFGNh81ZMHNDhAuxGlZrQnZwM3yv+P0BGuNbaGR77PROz9Dum6hR7aE8T+cIEazI3UmZntpJ2DElZBbNP77Nn1C09OyXBo2ijQl87BfP4VzbfSyjnSE5JjlnxuAUjQyW+5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbj5RkskGRsMrW0/VRu7P2GNTLBMDhfX1r6koRhU9C8=;
 b=eNIXQOiyQf43Lm5DT/qSuKiRl3kEoCiF4mY8Ci0J8BfJBtV2qNUUQVfiJ1+EQBQgQuLiWFvSmWylJVAuActJhibsHykEa5sikKNXE1x4glL4EdY+GPOuxF+IUaZYzWbYexCRJWYuje1mrdYpMsiMBN7lrBJ/aqEYrogXCjtYZ1E=
Received: from SJ2P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::10)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 13:48:38 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::5c) by SJ2P220CA0002.outlook.office365.com
 (2603:10b6:a03:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:36 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, WenTao Liang <vulab@iscas.ac.cn>,
	<stable@vger.kernel.org>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 59/70] drm/amd/display: set new_stream to NULL after release
Date: Wed, 15 Jul 2026 21:38:09 +0800
Message-ID: <20260715134432.1975118-60-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: d22929b7-8641-437e-2a87-08dee277c5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ME5uZ62HVSSET4yed5oPRK81HfFhqhTkoZtc3v6PMuAKPqjpCqydchQI08UzHImtFOG8Gf9Bj2ZZm+8zOlxFWzk20T+ghnUDzPNxaW/CsI4qoNLux5+U3i/8pMB4ca2huskMCRAMnnX7cohdFAG583NKY5KK8zyfoeJAgHTzwzTQamGiGW7UMWqwIwPFbYp0miaXky1/nb4wz79bCCoaq1MH2HY3RpczTp2glkrXR2Dj3efk5f1VWpjbvneDIr9dLysecWK22AN8ueKWo1mqWL3bREqAthbuXl06H6FruiUAo2JjYOscFg08Ebrd1cW0FCLs5qA8I7bWV1DvV3ZLAka7df1r8/hJ4DMCiNfAp3tfEp2fzAtb3aQVtdQvPP5fR4jLL7kO4rEAykq0xWdCad0YhMx6V9ybIxMo53ohe6X7CYG8C0nMTQbRa5gELbJb8VoTJ560PvWZuel1gunGx91DNZoAueGClZzc7LzE5/SCwNyUJfhzCptVgRMQWXeiRT3cgPnbmRgbZlDHKvoV87tV3uXw6YEINOXAhyiTZbdgy41JKM4ghRYaSkf3nesXAoIJ9uCkw//gaeRoZYhhZ4NFKPVVy4hFGZQ6lUVmRVs9fUDINkh/oxJWf8zkDK9ASZlSRQO4t3o10VyfDh3K1NTQjYzf4NP0k3b09mFKTGcCVhfhfDVco8QTdsq0Fz1ncql/IjYvjKB2CFgnOxL1SA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xWafth9erGJZUH9mHph+W0NPE+1ZL78VYU9fymWgqIibkYX5u19bTrYlSH+hEMsAiKSFAePIoSXPnUCokMy1iMn5ME4wHPirtKg8XE6VzwH0osRUzGjY1/+54HChSWzq48ndJUtSOEFIGD4VMZT5VzBM5DEPgzY6ifGIpZxxwVEbpIJEhiEF4VSVyZPLwN9EVEURZS/8GrFroea+b9+cAZd6jOsO9Sx6NUalymw3R3FIwFII9hFWw4rqhM9B6m+ZV/yI92cexOYJvbeKiiOMM+PAXWNOhxr8KMAuPQLXCMIbN+yDLQPcJzQfJy/17kIdfOVHFJ4hW1OIhHNG9LBuW+Rzzi+EiF2QoJVgr7qGqLSxXLj20QCxDWcmX1cvzJxSkWXKaJ/wEyK5JXzIY89n6CFMmIcKkKl9jpTbuEVorpHdwNH+syLwe88Uznc5FYlG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:37.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22929b7-8641-437e-2a87-08dee277c5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

From: WenTao Liang <vulab@iscas.ac.cn>

In dm_update_crtc_state(), the skip_modeset path releases new_stream
via dc_stream_release() but does not set the pointer to NULL.

If a later error (e.g., color management failure) triggers the fail
label, the error path calls dc_stream_release() again on the same
dangling pointer, causing a double release and potential use-after-free.

Fix this by setting new_stream to NULL after the initial release.

Fixes: 9b690ef3c7042 ("drm/amd/display: Avoid full modeset when not required")
Cc: stable@vger.kernel.org
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9a3f78c17a5a..5a9afc0607b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6063,6 +6063,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.43.0

