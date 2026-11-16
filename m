Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935758;
	b=mwmPUy8QuJHw2IcLFXOM1uUZmezw78X376hqtrmj6TPTT3aBytYHu/s9DlaiIxQP24Ch
	 /KbijKVe+UP7FKr0xZiVrg+RwZnc2eddyiT4M38DhKYMltQZNijukWB/CzHKULCDl9Z7V
	 vNn4awV7p7/H155w0SmQSjioFIazW1jd2GylVdJ4jWa2t85fusrKS/pUkJ2TeozXZ7OGE
	 pLQqSbpM5VKs6w/QKBpLE4eemoSMmC+JxY3PFOCY6anlzOMFyqxaEeuyy4bO5rUvHe5IB
	 Kkm30iMgKkgHbrOmxM6JvL64QvNO31fUBDRuhBq2xu7HNmAnHsmbkyzdoB05y/y/Nsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935758;
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
	bh=G0MOK8MVkH601Jf3pT7rnx5Rl0X0h90tZCe59VsQ2qg=;
	b=Hu8Ibe/pIcK32xAPbBhOuPtxay0SEwFHpff5UHWrUlAbNilNkQ6uRRLoqLjbDQmPJdJC
	 A7LuULRPumbNHTmFvPHArBXSFiUQG2ATwjVKp+kVxcv0v9zbw6/vYwXHPhNRfVX1Df/1I
	 stOlzPk6DOsMk2L9ZjWAm0JwEzEJQFqfvZWxUmlsWShlKyFwOgugIZ+3FSTBhHAnlEMix
	 wTRp8Su1g8x1AWxCdWWgEuep/P9Q3kGM31cpbE2pVciJjM7sWR+Chn4P3WzbF/hNNDRPR
	 MjCBImKdq6mHrdxTBEYSZTsOXZTrjwXHvFmU+hyplZCTM83Q9XE3kWecJKGTWyzvSFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R8MBZmN+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B813606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B813606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R8MBZmN+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPQyuLQBoPRuimL6O6ZdqpcUNWW1r1HS9I5hQQ7C8bhkQJ4BMGbAg7zJ8iaFno7N0dznpnPrE/KQbARwpBVPxsLhU8Uxl7fCpbWFo21Hb7MqPirOQpNvFiRrCvAd0dOCJ/CxjpimHlpeoK2V4D2kFHxA2GeCR/Z/lQocyEpvFOaiRtTJH1PfgPwrrxdpGP5dlrQxCBMGifbvHNye4IsD833f/6ZupvWM3GwRCxp4fFaO39X6pS+TMKjIjFvS+nqEl9wmKA6ZV2LBq2HR0uPx+gpBWGdrGMsxGvRpxJumKJtiEGM6w5Rw7f7xC+FyjktRq98nGm9LEQpCvf62U2fCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0MOK8MVkH601Jf3pT7rnx5Rl0X0h90tZCe59VsQ2qg=;
 b=CGL5/PZtFrjgFcVQ3zCivB0eSNA53CqzvDywwwx/xEB3WBDKx+JhWIiKB9E//VW7BZK5pvHD4a3wgZJLD+u5vjDbCgDd6JP5ui3Yj4YGo/nwcBWHztS9X5ikZkoHKvUvpJjV7pIITjzYv2qf5RyDHcKjjQVTmdXpjG0kM+QTDgEmZQ6P4mqpu2pYw++3McbGh0cd9QNRq4S6atbhDGDmtLgbfPcUEN7tbY46m3zyV9r5CdMTu//FQyEIbdnyKvdv7FRQDbR+AmvTsCIOQxibXqY2u4Pv9JANVycpH4l0eche82JUwd4EKmyZb3hrdbY/1K04SGauCJT9D3mBtAFO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0MOK8MVkH601Jf3pT7rnx5Rl0X0h90tZCe59VsQ2qg=;
 b=R8MBZmN+Ga8RWWcEhTysi+anBt6/qh+qr07y++2EtPP3PLN4UbE9EJrYMhmyoih28LtgnYJq6v/DFALqQDGDXsWdXYh89M5dbAnycOQFHwRL+xX39EB3jvP6gFwuZxi43YZcEkXkNHdaowt4Q41/s7cHuIAIXFxozVPWHNKyoUI=
Received: from PH8PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:2d0::9)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:15:51 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::6b) by PH8PR02CA0020.outlook.office365.com
 (2603:10b6:510:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:15:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:15:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:33 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:15:24 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Harry VanZyllDeJong <hvanzyll@amd.com>, Leon Huang
	<leon.huang1@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, James Lin
	<pinglei.lin@amd.com>
Subject: [PATCH 20/33] drm/amd/display: Honor the Replay stream regeneration wait event
Date: Tue, 17 Nov 2026 05:50:57 +0800
Message-ID: <20261116215641.2800595-21-PingLei.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7b5315-c18b-4e5f-af82-08df44ce6df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	OwP2b1ivZytfriL3MyxOYsUjWSgxv+bXv5y5qqXrMgqwSppki1cFtoxTOgwtrMHosozym4Y1P3Gop7bZHY5stJsviBiUbxVjMp/HL7gWbESsJG2ZPAOtCwryY9+C01FFw9GVHDoWc/49g1UyymJQvkkW1YJGp5MBpPKLARiXskwEnxvXiMN4lcvn4jUGLJczId52yj3Cd3csgvEGD0oj2wheOsvzVhXbvBDWYQuSblIULDYapc4QUZiLfmWGURiDn4/5JCSR2ynS0dTQuOkGTNaqZef6/wvzaB1/K3jDi0SLG7WVIW9wdKblNIEXYb6ywGQISeKaKXfvehWxdJ5XCslFhVbAsqB6Ch7R1Z2VS7sdrCPg0oNRXqqsDlqjLj2+LVddqgRqpPX74hgGc0a1PyvX4potI2zyMdW8xmE0clUzUI0UsPbQBTk5dPitkFmae0iNmcttb5UBZ5IhI+4IB93vb770ckTBgKksm4eEGqElh6zROihPPPFVOhwmwJ5lrpGaiIa3s/HH9rHKlEmCDTLhaXsMUQv5Oon0b3fKl3zHbhkp2C5UKAV3u2ydt0C6OvMQr0UoybFinaS27uQNEir3B10C38fVVt4Ali32leHkZ56vWLxX6mdeI4k273QNH0M6CQRK0L3OUTrEAJvNqmOXctzWk7ihphkgzPOqI26Kyr63glUBOHOmhbeL7hxXmNnATgkUL77lcR76rAanwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAwJKFDp0GPQVSx4l842EZ8NgWJ3/v4ezqc06pSDdB6nxjcn6nlBn8pbceY71hS6v9GkSSx+NUs/tumwhmQc1Uc3xA1wB4+PPzQ1ZIrlzj81KPCqH7PVJtYnDw6/GPDEVITEM5ccj2XZRaOdRl53yBIS1Fl/LmE6ZA6xJJb9WpSoeOWaBnwdGH0qW2tUVIStC5mxmzCy7Law+X1Q3SMA1O+Nxn+N1DUSG6Wm0ytUiLhNHGy8dBzK+SDujE1LRDWDZqNuHLl11B4DbyvxbQWsaAcyIoQkfcaDfqHET7Dykhe2S0Aptmt+lrCuSRTj/x9t+GdQ4TukBD5KnjCZj72tfWW6x8gmBUNJn+y4Q+/kd2OL4aVtwbbwLnQ68X1pOoXJ6qSBSx33OHqTk7whXP3X/6hLndJSsXN9DlGlw1F0XGn84YO0mO2brvIgtHp6EpVT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:50.7465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b5315-c18b-4e5f-af82-08df44ce6df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[Why]
The shared FreeSync Replay inactive mask omits the stream regeneration
wait event. Replay can become eligible before the regeneration wait
period expires after stream enable.

[How]
Include the regeneration wait in the inactive mask. Exercise the
public event API to verify nominal coasting while waiting and
restoration of static-screen coasting after the event clears.

Cc: Leon Huang <leon.huang1@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_replay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index fcfb6066066c..6b1955ff2109 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -232,6 +232,7 @@ static bool mod_power_update_replay_active_status(unsigned int active_replay_eve
 			replay_event_sleep_resume |
 			replay_event_disable_in_AC |
 			replay_event_disable_replay_while_detect_display |
+			replay_event_waiting_stream_regen |
 			replay_event_infopacket |
 			replay_event_crc_window_active))
 		return false;
-- 
2.43.0

