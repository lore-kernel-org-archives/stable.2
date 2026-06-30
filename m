Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620C12CDBE
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842643; cv=fail; b=N+W7A95SkjGyVW5cyiJEFnW4aWWC61vB209STceYqH1izq5Um4/evsfNlV6Mj5qJ1mkLLnpo+7RIaSwhvzgRvfZKD8t7hA4z7+XCoUDkzWC2nwobfD6lpai1pRyJlML6IO0NZTtE991Wdcj/E/wkOr/LIJRKqpPDKq/qmP768iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842643; c=relaxed/simple;
	bh=fyLhi70j+8pVkGjC1H8HRiiFLTJTjXnA5q0FDOuPukE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVG+SXTrGKhpEZGUyd03Rek2ZzvuQFoRYSmnrENQ2mbikc8ZOSlW9QLKxKGJgctr3b9e209BuPVS9R96kv0ccvxxV7ZJV15S3Dm+tBNoUmu7IBz+o0lXgmgdiBY7vM0o4HniAbAeyvgVcZCYoXzruk4soOfuCpZ/xSQI68CpVBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xq4R9JI4; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xq4R9JI4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nf2vkMOWZvSUj4HF0d2H46g9rcFSMWGUl6GAJq1knURx2mT3eK0nFlNb8v3jdHLufYhGcnGl9lzXb8I25Doad/622cSaiie1ALOjaDdTNoBObEGfTuhks312WxsGILe8JhjT5bOgof7h0KrNDxZEZy1ylG/0mmhrpBCRm/nGeGNoZ9Q3FtWE5GdzhyrgmNpzFDtF2iKq1SxO5gX9qHh0HiTWRt3AVmjm8CNT0EC1kLZvSCKAE+oHHeG8ZAQPQ0zoHweKDCgzYS07+vuhRWicyd4+DSA2aWQzrZHhGaB8TaxV5KPVRZgpiN3iUa9geimH9aupzzDnvyfcZFHIzIybWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDdwRciHAiEs1fOdP0WenP48KHaWlCFjQbD94j3bDBc=;
 b=cS5EEaEPJIO+MwqS14NTylVAYSBlBC3eLlFMY26GF/WFjWTFd5K6pFPk6Pa5zceDAzwVxaym6PxLBEZu/2AR1aCqoIAonHQDkVjyjBYyi1JRwKZ5P8rqyWXc5lxJh45LZf/sFOfwRpoZwqb+LCvIBYID6Br6wz8gq3sy8VRRcL283Anw1FeTySqunwYiyW+AmQ2TBfAHlKA6PjdZPOgj5nsuPxbbcDT4aqTKjZzXvc5UcMF8bmNy851QZBkJmN9gv46Az+NuURHeYLenPyr+So7CYkgLW2pYli1uMEBgXp2y2RkrrlFwaDvqtFdeoxJwCB0+qsoV8+kosGGIIuQwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDdwRciHAiEs1fOdP0WenP48KHaWlCFjQbD94j3bDBc=;
 b=Xq4R9JI44JqK6MR69oI+/RrbDqebf2a/IvtdsoQP1l3SNllXU2zT4WwqOxKQed8oOuvKS+GRT/kDozBe7qQmccsQrxf3nJsI6JHtFeHNXXfoqm8vtoTh8QXKO1gEfOCNOIvh515KoTeTb+vfD/l1yn7kIenQ1cG3WmSKhtx7INA=
Received: from DSSP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::16) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 30 Jun 2026 18:03:54 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::57) by DSSP220CA0011.outlook.office365.com
 (2603:10b6:8:3d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 18:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 18:03:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:03:49 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 30
 Jun 2026 13:03:48 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
	<michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
	<chris@kode54.net>, Leo Li <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 3/3] Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
Date: Tue, 30 Jun 2026 14:03:01 -0400
Message-ID: <20260630180301.362070-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630180301.362070-1-sunpeng.li@amd.com>
References: <20260630180301.362070-1-sunpeng.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c640b4-b2b8-47c3-5af4-08ded6d1f24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|30052699003|1800799024|82310400026|36860700016|32650700020|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gVrBtmqhBU0QqRyTLYOUfZz1tjLkD7FJgN4hJnbs63lnt5wqz0WVul86YPW6UzqzrgEFAJkvrXDqGK6f2OWvDgaKvoFKY9Uq1gqobtwHmaMy4aVe7EvRwjlDOsgtJIIYl53yhS+NtWuWe9lJCvx9ZsHoIJO6k3IasinwxocKKJZ9kGftzn+el9Yzxdwi7HyRtBvqYx9OFXxTXm7OOl6Hq02SHR0uBqrUAILAftGVdFDiLJD4AQxt1e05nS9He8qzL6qyc1lrOYroAkM9MS93pVccH4hJvSuvsww797Q1DOhr/n0VjpEe2rx0U10mDDKO7lM4GLY7+z1j5Q2aaOoUwwdS7yLpP/DWIdxfuPKZsJb5Der01luPxcwo8LFW+P7QkAxg1/Wja3AowcAIt7OqZjXilGFF3w+AVhFi2dsatt3tDKFsHSU/fGUJw8hrL8o5Qp7+O4QYCMWHGrrKMJtZUj8HpGgBPdpm6ZXes44kYKZG0seP8jS4WX9iQzcdPCH5i4rGYfKUkhNQOf9K6yVmj1rqZ0PymxR3F7DZL6P3Xyvo5H/RSC+GVNA85BN6Rw+IubOvP3PNVznHpaqg9KaiCZvkjFUH+g9xeBFElTTdYTilrrhE38+gowrG0voV1rfZYPoktUGaBe6HO3GVYwOIgA6zTtzrpqE0g7MzwkqtD8/J4stgzK3EOrxQtf7wgXCGOjGo8pzER2vBXBXlUURYCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(30052699003)(1800799024)(82310400026)(36860700016)(32650700020)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u5xOaExZyp7WLGOZ2ASgyonqOngS7sCQAooNbk4N6XxjGEIEORbeCrw05Gd200zz3HYWSie5OAP8Uh4/+eYVad2DmGX+xIA+od5jzFF0PQHQ+Epr+pOykRIIhfMKZqQQ/vIY7TXpMWrJN0gmzbyKUstMcymHqzOPnv1b4d9TrIBnERIPFH3VAmZ+axK/pzpUhqSj94BT1wiMVjR3KDb5VDmyvbwXjGtLUjPgbJHS5x8zVxXyI+F+/VhSl1vezpHEfk5yXOVGcQqt3KH56BsKP/SQMAyHrWNhJr1oqspbXHH0hBkCKrGNx6hEqul2jA5OdnEiwSfXAIlsPAVLmzRhhNknZdJMoyKdjx5j8vgZfxic0DBidKP6uNHIneJ4sCFDep/1+GO3NbfvYuZA26vFSjhV1S2S3IBG19QTmnHUoxn9cvGjI7jKsakSABKpFrRH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:03:53.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c640b4-b2b8-47c3-5af4-08ded6d1f24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

From: Leo Li <sunpeng.li@amd.com>

Now that proper fixes have been found, let's revert this workaround.

This reverts commit 751414c12388ff2b475e15c15d3c817dcf563635.

Cc: stable@vger.kernel.org
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 754fedbdd7460..43a786f08516e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3526,21 +3526,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
-		      IP_VERSION(3, 2, 0) &&
-		      !(adev->flags & AMD_IS_APU)) {
-			/*
-			 * DGPUs NV3x and newer that support idle optimizations
-			 * experience intermittent flip-done timeouts on cursor
-			 * updates. Restore 5s offdelay behavior for now.
-			 *
-			 * Discussion on the issue:
-			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
-			 */
-			config.offdelay_ms = 5000;
-			config.disable_immediate = false;
-		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			     IP_VERSION(3, 5, 0)) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			   IP_VERSION(3, 5, 0) ||
+			   !(adev->flags & AMD_IS_APU)) {
 			/*
 			 * Older HW and DGPU have issues with instant off;
 			 * use a 2 frame offdelay.
-- 
2.54.0

