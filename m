Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED24499AA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546171; cv=fail; b=kwQLADvokhl9vx22ukfvlg/bgLyYCz7ZtyuNAVwfigXGXpoRuzHrWAjwgCBtTx7uTWyzSU5bKyZyM07Vw2fJTWcMOSYg/BgIZmlK1DyKbGcVuWjx1El/DXRubzWhQlOjU/NZM/O7xUwtfzbFsWJWsJBEhapgeC4Fq5oBDJUqyak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546171; c=relaxed/simple;
	bh=yx5Sgg6TOz1RyUrsFWD44tZdKB/khc63YIP1IEOjZ2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZVGt09b63mUjqLr5Moj0GhlGhyFnzEZJgv30kXBOtz20jP3S7j04zMo8D9cU0bjaToMZPnsz6ldDNfBDSWDb4jw2diImwqAwvcSTnSpcqIs88xhVhAOAPnN0yVqFZkC7RRwymcachF8ZyxmEmHcO0INwFrfqJeGEshC5NUiR3OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gwg36bC+; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gwg36bC+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXcfJBddC7USD7HvPwv/o9gdFrRcYRMhEV80fGTPh5cRIJFn7+0DSKL55GtCbcq7sekpQXRtYnxl9FQRr3TnpMJJ49d67bnlseCL/HOjFls1nwfebocqC96fIlwD3iSRe5FQ85yuTTBadzBc9d9uuFdY0puOHW2sCo9tRNigjVkX1dMBmZ8uZ6eALTwPWVtEVWCYaOTmTINKCmJgAQfNESmYoOCZsHMCHeMOPUtUiNq6ZaNRBp/gpz9+NrsYLV8Q8CkShmgoCcRew2YznrwhCzRmZ7Gcusr3s6SllldwLpnKxrN2yWT/zEh7PVOL973t3yTKWyPdyTdtKw614nfGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89sLxlGe9xwWexT9B4lujncTy39NyHjIVA2R3mTE+5s=;
 b=DwMqPs9XJ2FoSih98cWncunyuvBsz0PbQ8ipTBItXH2e5ood+CaH3qMY6pFz+8amRDBo3QKM2WglnzjEdiBUAzGP1EPmeZtWK0wk5yLGD9h9GQyvhbOTz0rjRY0xZC3b+sCQbQkkfDdGKJ4z/fBjG/rjhqQlIziGC/Ch7L4lwkqZ3CdWG+PTd6W5QSKutvUXxqpX/t2124cm5JV6BeoamedlIquuYCZ+o1qqsSPJA+qrGPZ5hrJwHKsDyYW+u9SgQIKbEg+vjHe5ALe/xcIiIe5fj3zlpwUI8Vw3abaCgOg+Hagq6ENWzD4OrYdtfniygIkmbfAGlp7jbU9KdmKVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89sLxlGe9xwWexT9B4lujncTy39NyHjIVA2R3mTE+5s=;
 b=Gwg36bC+t1pOzflUjnuWizHhNVNGIwH/W0wPiAsGkevHujf3Lir+W3GMYJJ+cLVe7xQvUN80lqNsLst3h7e+7cUL5KbGnJLF72fgplskI0zVeiJYj/+xYsdtTSVdJItiVyN06NOk4bEQHOuxvyfA79qbthSD0rLKQMl+4efCgZw=
Received: from SA9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::10)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 14:49:21 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::83) by SA9P221CA0005.outlook.office365.com
 (2603:10b6:806:25::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Wed,
 12 Aug 2026 14:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 14:49:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 09:49:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 09:49:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Thorsten Leemhuis
	<regressions@leemhuis.info>, Sergio Callegari <sergio.callegari@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Fix backlight max_brightness to match exported range"
Date: Wed, 12 Aug 2026 10:49:01 -0400
Message-ID: <20260812144901.2154412-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 831f952b-3226-4cec-73ae-08def880e4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	X+q0VOyRSs8wv6pr4PO/0m7tLqUXxT1qE5SVteX06FJukAPcO1bCt5EO9QpssdmVyLk0oe1FEIwaAYHYs3aUAo/tgplpxCupFTCImJ2LQZLzJS2U4gIo+vKbjxh2RkZ2qHJqNFXJOiRVw03EJvTrZdC7Vn/MLCUrQNRXvI+ALsQ2xQZ2BwGshwKT+LGm47k1LguAiVE4wgMPITB32USoP6sT9SL9mMXC2WdLUltvJ+7Zw/p/28C9/6BFmQhYbuY6oSeQBRUmgD4O8C6ybeSH2jAz0UeKDlHgIjujC+L/n+Ht2LqvemqGuKpgydmfBmdgyWlL8j4yl/ByUJg0FeJPhDUXn2Wy++KdE5SpRNBKJGCfLAE7CHlebZO+9XkGYwkzpnzVi8my7xxQsNstm5m70yuEMK1tYYtPjhCkMmq3Odu9X4fSqnrs61lSk7iY6EazA0ihy68TCqdcNi7V8QQhUrCDUmBAha52gtHfVpA/97J/DIAjdzYscyclx1sXxzg1nB/b0SETux/WDiwJ9/HUMPU7GEnTeaWgh5ohp8GmBo0StT6hLKFXvKZ5KOXb4ZnvRbkAlg0gSKgLc9q7tQiuHXUoMZGe0r8aqplnpqtqPGfTUvMtBBggoGfcw+sYEagpQTxNPXmc72o7Gp0ERWZ/EQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4OxMckJxd0aMYn3euJq6cnqTiS6E3sKs9hZVM5ShcOKqPVM6KYJr9kymzqX++5BAtqKv3L+2A3w3JBWlGUn8nOZhTFbF9bRJ4MyXrdjOlod/vn2rJQMWu0MH2A/Zw+a2+hEIvZxCvGQWipRT2xLuqcwzDHO/VxFdkB4LmgpK/449aDNDygrxTbwQmeiFBD1kOvy2V5b4FQB4SZawPtagLstsAnachORRuRs9rBIj/urmvGcuoENsZX6gv7Rax6U43fVfcrcVl7eiixr8r0C91ld1Bvq4APW5QQbJ/NoHOmwnF8zJW/qtS8m2FYXZ1xE1g7vi3GyXX79peAC7S7toy17mRa+lOB0MvCef1mL5uQZhT+iXNFKCO/81/NF2nxuoxAmUnEd7TYfG5R8cdfqTR/7Dk6M1OFs4EVoFbm0jQxJgafY+Eoi43ElFBa7dt8/C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:49:20.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f952b-3226-4cec-73ae-08def880e4aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086

This reverts commit 1191285ecb4233e5bf907da7e9394d7999055566.

This patch is apparently missing a dependency from 7.2 as users have not
reported any regressions with 7.2-rc, but there are regressions on 7.1.

The regression manifests as inconsistent lower brightness at the top end
(e.g., around 98%).

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5562
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sergio Callegari <sergio.callegari@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40d82a3eeec0..6f9d4bea3379 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5401,11 +5401,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	caps = &dm->backlight_caps[aconnector->bl_idx];
 	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = DIV_ROUND_CLOSEST(max * caps->ac_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
-			props.brightness = DIV_ROUND_CLOSEST(max * caps->dc_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
-		props.max_brightness = max;
+		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-- 
2.55.0

