Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A02582BB0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655794; cv=fail; b=JUk077MjvezjIE8ZhNxZAeYteVAyoFklH3mLD2NAkr8eSqbuY+lvzTxOOJx4eEGaKWmbqeDUSXCEjQSQAS+dTyOqQsqXpjZbvsNm9Qqw1MmvCbzXbNLIR0rYn89sMR38IBrsfngxyTUwt38SAzhWdqD+wo8ZauhoaOGmP1z5GZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655794; c=relaxed/simple;
	bh=WeMhkQp+DcD2HrlXl3DFPQp7DMZWyf/14v8DZ5DRFbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMlXADxt4o9kGWkJRhOGQwe02VJFEFtCz+bS1dtaYy/73QrjGyDKWuZw4zIzEP3Gb6E+pMk9MCa1X57vYn2OqnnmOgWiiItDpf961YZsxU4tuR9nmM4J3HR7R7DLOqu2FLerw5Z7vDwIhBHMyoqRLIx6rmIaR29Mzcxa0yYUjYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZrbJz7w9; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZrbJz7w9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeLe1yJur0ik2tPLyj+lglwG8HxT5asYL0GtIQVDogjySf0//oUNQ/hPpzfksmSIlW8GEdnGUcLHRWNU7OjvA0N5Wgi9CkSimOYq2xfL+XL6HsWrQ205SWH4eyF6OKO+Ut69cYitLq24FqTW1P7DSC/QBdgXHLMfLL6yr8DrqzpVl83jbqmPoXz6eSco1KJazWauRagKTy7x8Y7FzFJ8JvNt8cRyCC+45Gqf7BWwbPjXq8ypJholBkbFY4/TfZpX0Rpl+iSVXZ1HcxmZ+cTFjAwEaxHYL4JfiLOBezXQ2cjNFmcOtaHw4Rr6yQslrBodygU9CyuII2M9tZMVp/jvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwy954mkwAAfyH6HlFgYBD+vq4rOZd4cNwJ0C/cmxn8=;
 b=HthPpoh2W1EKaABu3eyBaA2q86eoAH064qlyZ/+KeJYQMHtXOgVnejghW6+kOP0H/Yb9LMx1ikRo7Bgv/S9j3RcryW4rbQiP0CTPnqIanPFn5pfoDmwyCycc2WuTVufGoYVJlaIioGNhuTW4mZ+fo/iaSY3tJlVA1ph0j5tWoV93A2jE55wkqSePim2pbx2uvXmGbdzugwfHHWwP3AgJ4mXg54i7r4e9QP1YJPc8sUmvVYyDR0GhM1nYrNvE2+3j7I9uKEQCQ+9QOI0xMPt2KUGZPLqXWzPmE1HgsLo4dHgNdbz2/5hV9U0UnL3ckLS4zpUT+72S+ukYDM/i5Sc/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwy954mkwAAfyH6HlFgYBD+vq4rOZd4cNwJ0C/cmxn8=;
 b=ZrbJz7w9ghk5OzLXIzLiqH5GAyUffSVVfHo8meFSnCYgZThGii8jO8YubGHi7CL8VbJxNP+mw5Z86K6F8cVzpiQozLuJNTFAs6CgPJE10xjLQJau1NvtXWBwWY9m5d8i1VHCiwX1JM9mOq6+pNCqiQeh25KtjabHNgO1RDR2cCU=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 14:36:21 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::55) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 14:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 14:36:21 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 09:36:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/amd/display: Honor EDID overrides for connected sinks
Date: Thu, 17 Sep 2026 08:59:49 -0500
Message-ID: <20260917135949.2552704-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917135949.2552704-1-mario.limonciello@amd.com>
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dfe1af-8add-4c44-b6c5-08df14c90adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	U2l909DfGRySuPQtSCYYKM6JVVo43YRyOWAOcafzyZCz1HqC0M/kjF7QBTBDC3skMYlY38QQyRdCVDU3Tup4suNVjPnjIOr7WoNLo79HGqIUDxJOEuHa/SYcZyIm30/5CsDO57p/PzM7O0gitFGZ/LxD8o7pNjwF6X60+snyAyaM+oy9Il85igdQLfIOcV09RhhQRAVm5kBVntB2JXmXKj6CXPXuNWsTRGG8x9Co+UEFyZDk2B+F+FOZ4P46Ab2v2NCCrgcI6blEK4XYagY4+gi/vSkgKqGlTClwy6GsE6BnSfVDr5xevMT07deCRoUmU+fJWBPaIUMozravtKWsUaJNd3wV1oXFhb3t5Q/D//UCxgvd5XiZHlFmxxdqhSBpb3yQuSy3Zclk8M+dxjSVBdlWTkF37aSgg2UtD5DDrtjpxCPdqqW37OpL/FMQV10ItsLYiMi/tXkXxHUYrVXaAVv6/ftuoRBkpmswkiXhVFG67+qBTcdlf/mne65LuMQQ8qY+tVdVZNig/zEJY8cXv/wWI6xjMaKkg0DzPs7q4zE5xVdVRvmm6DxKK30pn9StJXE7cp1C15fHynwkd2YFK6HTbA9uSGA1pUHfNv8ehKIlOLey8CiOigoyUpKYkOAQUZPT/SNIGfdBGQluKH0jPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j5xfZ6PX2LQT0Kk/5CLCRKW4AHjq8v6oyBrL4Rfpfl2+ofcypn8nvXKO+caUYDOm02bdkDs1DvzANqr0HL701H9WPen/ihkTQ0xqbxAvkDoTQq5L8R9KHvPcZM7O9355M6nCCk6Djtt9r7QkkbvkdglKlOTHIR5kojafiXp5wRpT2B86Q1tCaGdlDpD2JRI/UG7FmMce9tompNBaxciRYsAs5zv1MgQfUU6mplQ0W1eSRGuC29Rq1sA7kSwXRCc4M88S6EfAS34ow4jkd/HhSFbUuA4r6hayA/9yG1zhCMfUjDLktC9U+Y+K/DH/J08fMjS2x7nRu5kGwb006Z44Id/LIPHu070qgN9s/HwXuRoXWKfOhs4ZkTM738XX+SUnF5ps/Kb/BmINfOONMW/EXw/uwjKgaTO7zCPS8lfg6WFubVvGJ1/z4RdtqaE+l4Ca
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:36:21.2027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dfe1af-8add-4c44-b6c5-08df14c90adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

Display Core determines whether a digital sink is physically connected
from HPD before dm_helpers_read_local_edid() attempts to acquire its EDID.

The helper currently calls drm_edid_read_ddc(). For an unforced connector,
that function probes DDC before consulting a debugfs or firmware override.
If a present sink stops responding over DDC, the probe returns early. The
configured override is ignored, and AMDGPU creates a 640x480 fallback mode.
That also prevents DRM's later override fallback from running.

Read an explicit override before trying ACPI, VBIOS, or DDC sources. Since
DC has already established physical presence, this does not make the EDID
override force a disconnected connector on. The existing successful-read
path updates the DRM connector and copies and parses the EDID into dc_sink,
keeping DRM and Display Core state synchronized.

Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5779
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d451082552e83..b8f02c854667e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1244,12 +1244,16 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	 * do check sum and retry to make sure read correct edid.
 	 */
 	do {
-		drm_edid = dm_helpers_read_acpi_edid(aconnector);
-		if (drm_edid)
-			drm_info(connector->dev, "Using ACPI provided EDID for %s\n", connector->name);
-		else if (!ddc)
+		drm_edid = drm_edid_read_override(connector);
+		if (!drm_edid) {
+			drm_edid = dm_helpers_read_acpi_edid(aconnector);
+			if (drm_edid)
+				drm_info(connector->dev, "Using ACPI provided EDID for %s\n",
+					 connector->name);
+		}
+		if (!drm_edid && !ddc)
 			drm_edid = dm_helpers_read_vbios_hardcoded_edid(link, aconnector);
-		else
+		else if (!drm_edid)
 			drm_edid = drm_edid_read_ddc(connector, ddc);
 		drm_edid_connector_update(connector, drm_edid);
 
-- 
2.43.0

