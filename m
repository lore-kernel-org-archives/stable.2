Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56136E48E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630959; cv=fail; b=XOJkBJR2uByxBVLakYM2QrfbvgXMIgxf6u6ct4jylrONYa69VVEaj+ms/RlPKdx1YNoRGxxyMd/a97tWQ8GLSsyjB2qZ9zjIqsXGyrVtXZFH1tjTpbhXh25Ds8/6NSGozaSG0S85bDGZNJAsVJ2+ixFVkisMrHlJExw99bSddA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630959; c=relaxed/simple;
	bh=jqACvV14O6aS7JoPCSZl4MMy0nrQJfCC6owo7ePNp5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oURwyuHELZvsrmq5ebd6LKbbDB0fp3V5x09icdM/y4qYsSaCEcAzOjwBlQwAEJvtXwjNAUD3tlRBuqIzJYnSJQZfmWLA47T4y9qy2hIAoPRkCfqkGWBY0gsFZASfLd7rfjFJhppOlzEp3f3POw14YXDYlamG++uGfeOmXGDJYnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfucjNiR; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfucjNiR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkYaDOZgM5/NI4wt3laXlVQi5upJF903M5X/VISonro5MTZiFvWapOudZUlMfkzOy4+nOEhQlv0dtME9Pr8q8OZe6zHybu4uQqfwQhp0rVI4dF5y7jA/1JrFQ1WzdlVkzZLgk61hRuF8yjiuNWj3G418YpkWZeAuybY+lFHMImkedDDqEEs6kNEPoOiBuIrxRx5/xX6GDPgZn+V0ckpgFaEnmHZ0Iwv/OHNSHtcYeuPlc09lAdwbD+J7hC/6OKaIEdJ4thvZfiCxsxhr5bWCbE2F/0Cqu/l51SYMKDXoHa21HWJbbLv0yT6f19HnkwXLO7nW0kDy7j16WlcUf+TTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx9Z42h5LKVHqJDbDftIZjR+DthBc9uUgcCrCroQHhM=;
 b=iM1vX5311citL+zLzJEfCAVFi9YD17Ell5+fjRw4ccvCaWKbDGYqjizbOk6JaGAdodxCMyH9zt10EvWx77SRIl4+6tPQDD4fRbSK5uTjwFoRSK0H8IQpt/DJLejqCmrdLbgRO4RFgA04OgaOetKm77fRI7BqKJ0NjoQ4nr1+hted51hhWrX9Fyngiim1S/zglc4K/TYNYzgSNH7WUaukaWUsEknY8UxOmVmFg5BXSU0L7OQHfFU+ukKpkIljOxjLnC8/UoACmPiJEu/JQQk1w4w2+R9qh2u27uuUZhtPgGeuQhXKOuDxp5OBOQZNMRhvT81tdPOuKQyfAgs/cmOs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx9Z42h5LKVHqJDbDftIZjR+DthBc9uUgcCrCroQHhM=;
 b=UfucjNiRWjLNH7+UcWC2Cba9509vorCEseTmQ6k1j9pZOSex3BsU2K09Gzj2oZP1q0FguOVWmSPtShk5XQI/CEEfBGpOlyH4ZCOeOlT17PR/urIh8FhO9UucD/bHUtEfH84XAGv+buKM5ZiFiS3YplX/BoO7XX+jujaRnqj+WkE=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.14; Thu, 9 Jul 2026 21:02:35 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::40) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:21 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	<stable@vger.kernel.org>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 59/80] drm/amd/display: Fix backlight max_brightness to match exported range
Date: Thu, 9 Jul 2026 16:48:27 -0400
Message-ID: <20260709205936.5719-60-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: c742b571-e764-4e23-ae19-08deddfd667b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lCTuRedHA5qvkKyxJAq2QXAKbawf6ldSgnSwT757pJjv3EfmZaneD2lM+hf5nd+58cHj6qlOPaztNOUqGbw80+4/LKH18WOiD3SUlMAJbH8ln1eguYzdjQZkUi5jVP9TlRU2EvtJ4NPNKFGQN8+nU5Yxxv6CrvjaeG6BiqniPoidGXp7p7G4CRmswWQ0rbBzHvlzXOK20QDOUmHIB1bUmPCQ1/qcFI+X4ySByOpX+k9NJjI7XXz6IbDgBlN13J1VyIN4rpk/3PtgqhYMzX3tdFNiZYEP0LDcF0sbvTemanMVzuIzRxRuOHKXJQ/jsDW/6mhqoowzgcf7iXvkJ8sVgv0jtO/xz9M6jPUV6h1a5gmIr6iaZIxF0S3w5L0Pp9/0p0/v5xRg/M3BwYuPyTfeNssZZt/CRqeI7vHG5VzFqq+c5pvEUkp8rq1WLJr5rn512wb4oTznzWm+adP7mOeT1M0Ts4vfmlelJsNV0C1YDD6Be9/lhxqBLnZOC7akzOmfCnEIdEQXfnCC5ddzpIfahb+F4DZCiN7WOY+4YhDgVh2XzMzd9msIEq1K+krmTicWpH9KZ+/zUuyAJVl9hqSt0xLjIA2vNHht39IsLt/ACTfUUhjWKSNdgBrt7lbkqhttFi5uXJa8eWtQPRJovMaOJjNvA1tb10dmU0c6hkV4Sw1z+wh1P3hZKEzN75tV7S2bjPP4Vtgj+bNDX6m5k+tJ/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3m8HCB3Fojy0CKqghusGarOeNjbSgSF0RbunF2qQBDzCGPIgXcxlek2YoF3Wb4PxXdP6t5zlPtUoHKADm2H+jmCiiAaok2QM4oomaoCyc4tKzeSmTrNIoXJ9x3QQ7PUNDATOSitIDbpeAU0vjsGaCz0IK9iI8vk7MHVdY6m6QCjHnyyCabHDOfSyva3ZcQvebul6fdQ5XTeT/Lv3PIIYC3osimcZD8taeLuzh3DP8DlZGk7AhlnU/PQO0dSbeD698WYZKb7yrvLNCeoRDq3dod9i0w3NVWM3AmLm0u1twmd9LNZQRUNXldboNj5xec2EhRjEJYDN5XXU2KslqmS8N87MPwpbHO62c22UNVEYfSHZVX/vR5rs/864lPO6N299efOoa0/eF6R+52bl1MI6O1C7E7s5LSIk0jtjISrUKczB/QNc1vG9h+pt7JWaGWgC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:34.8668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c742b571-e764-4e23-ae19-08deddfd667b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
FWTS autobrightness fails on eDP panels because actual_brightness can
read higher than the advertised max_brightness (e.g. 63576 vs 62451).

The conversion helpers expose the firmware PWM range to userspace as
[0..max].  But max_brightness is advertised as (max - min), which is
smaller.  So reading the level can return a value above max_brightness.

This regressed in commit 4b61b8a39051 ("drm/amd/display: Add debugging
message for brightness caps"), which changed max_brightness to
(max - min) and undid commit 8dbd72cb7900 ("drm/amd/display: Export full
brightness range to userspace").

[How]
Advertise max_brightness as max, and scale the initial AC/DC brightness
against max too.  Update the KUnit expectations to match.

Fixes: 4b61b8a39051 ("drm/amd/display: Add debugging message for brightness caps")
Cc: stable@vger.kernel.org
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c   | 6 +++---
 .../display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c    | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 11d54897a894..ca60c72855fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -407,12 +407,12 @@ void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
 
 	if (get_brightness_range(caps, &min, &max)) {
 		if (is_system_supplied)
-			props->brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level,
+			props->brightness = DIV_ROUND_CLOSEST(max * caps->ac_level,
 							       100);
 		else
-			props->brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level,
+			props->brightness = DIV_ROUND_CLOSEST(max * caps->dc_level,
 							       100);
-		props->max_brightness = max - min;
+		props->max_brightness = max;
 	} else {
 		props->brightness = MAX_BACKLIGHT_LEVEL;
 		props->max_brightness = MAX_BACKLIGHT_LEVEL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index adb896022a27..8ebc0f263e3e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -799,8 +799,8 @@ static void dm_test_backlight_fill_props_ac_linear(struct kunit *test)
 	amdgpu_dm_backlight_fill_props(&caps, true, false, &props);
 
 	KUNIT_EXPECT_EQ(test, props.brightness,
-			 DIV_ROUND_CLOSEST((max - min) * caps.ac_level, 100));
-	KUNIT_EXPECT_EQ(test, props.max_brightness, max - min);
+			 DIV_ROUND_CLOSEST(max * caps.ac_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, max);
 	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_LINEAR);
 	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
 }
@@ -825,8 +825,8 @@ static void dm_test_backlight_fill_props_dc_nonlinear(struct kunit *test)
 	amdgpu_dm_backlight_fill_props(&caps, false, true, &props);
 
 	KUNIT_EXPECT_EQ(test, props.brightness,
-			 DIV_ROUND_CLOSEST((max - min) * caps.dc_level, 100));
-	KUNIT_EXPECT_EQ(test, props.max_brightness, max - min);
+			 DIV_ROUND_CLOSEST(max * caps.dc_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, max);
 	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_NON_LINEAR);
 	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
 }
-- 
2.55.0

