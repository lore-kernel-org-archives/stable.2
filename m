Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CD367F31
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376904; cv=fail; b=UYEjoVlJa1VuOIJnXvYzOfPPDxTlS/ic/Fk6o2hRaLjFQt5EjIc6cHaeV2pvQ7xTmGBmZpLxT1QIo8Tn83CG+prLrQ/ax5YlpSJbd4U78Gmi9R/kSF8kjcFPGeBYJDi0/eLFccGAStpw5gvSLPZPCMGzmFRCGan+e0Os51dTEiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376904; c=relaxed/simple;
	bh=mzmBpUYW5ewaKGmLGKEwsdVCq2Ut+ISfqoTZ+f0Pq9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akZ34O7Yxz+8HR5FxIItleB/XX2dXhpjeW0JEi0jkYyeBI5t3THwmOxSj8qMgMG97OG4Vj+DMNPXNTpk1sDBjklXj5zAo3uEmDt1YsDQzkQCI9pjfH0uyPOD95Qy9dTRbpFNBZDPUsPuGQoM+aSxR7B/pBT9YBeaBI/mx60pUpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8r/upPb; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8r/upPb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsF/zxRI8bhpWeEsSI98rZITAO57dW8a3dVdRLSJDiBXXleQ0eWv1g836L01gWD2E5VZziLmVGJLygYqPqvvYBxEia48lKNvu+juio2uZnG3xePNeIH6mHoiHATCz4o5r6la0/eV8c4fT/WQgKMtK+BRldsMgyQ9jajsz4qRphluUG43l/ecocR7U6bCg/MCZQIGecubHws55EZ0ZhmafXKrALjR/UATgXWxrGGdY53bcQ2+1czIS65/mLNWpnE2Vblaf3hFi9gz0E8tynfCeK6C8e/pUKX+S8euya4KRWtpOwODSrvMIhTDy5KopMm37Yz9maoW1AfMQOJBQycZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9KHAiZsNoHLr4/C0wku8akkh/GCT43rMdRbjJzPyxE=;
 b=fM6orXQuZpqUGcuzZ/ik4/o19zb7PUm1kFG3cvEtdnRHD0kfi3QjPel66PjMSiGB2LYNhGCgkthcNYV+vE5oY1r6qgM0Ecm85W18Q7hiS/7b5JFRjQX4VwjUKP0jD/8UXdGvUA5J5cUh80sp8Ougv2MPr0Ade32lommaTzKCf+PB3RDHZYDJXRX1hL16ln/LvgRelLIinnNC1YvNsxvx0yY/EbfCz/vrsKCkACL2G0RWmk5BqKt4LNBnoEJ5NuAaYOTEE+8PFr+EsujUtDPlplT7ntCPR60xwceTiq/5BaO8R7vJ7pJS4OvctcRc7d+ZPQ9hRsrTkxKX7YRPDNPW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9KHAiZsNoHLr4/C0wku8akkh/GCT43rMdRbjJzPyxE=;
 b=N8r/upPbrR8z69X0CfGGKPvpZnRfa7efw7cjyq7VhQiPq+U2tq1bsz7kLIbFCJK8712dQOUw0leM1JvUdykGgWOgaTqnymML016jESw9wqYtVMx3nacyEpxs487To9RgAM7k6rXYTSm0/UuWDQjtOzhwNs17Uu2jPJpyimrn+NA=
Received: from SA1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::10)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:41:38 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::56) by SA1P222CA0025.outlook.office365.com
 (2603:10b6:806:22c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 08:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:41:37 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:41:34 -0500
From: Honglei Huang <honghuan@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
	<Christian.Koenig@amd.com>, <Mario.Limonciello@amd.com>,
	<amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>, Honglei Huang
	<honghuan@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<superm1@kernel.org>
Subject: [PATCH v2] drm/amd/display: use kvzalloc to allocate struct dc
Date: Thu, 25 Jun 2026 16:41:21 +0800
Message-ID: <20260625084121.3053587-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4febb5ad-d1f1-4e50-7b87-08ded29591da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	1IzOQwFfGqSh59suf1aujkdQpakCdgrgshm+n+wId4Cwlp6ngvMngzMcNDfTWUzXAR6WfAfX+DaZGjguruc0EBJdp/BXfyTkBcVnLtaGYxCLiD6eBTeFIlFvGs5qqUvH7jeQ0UEcTtsCwahI48s/aWaXKBCd9X1jSi4VfMTv4OGQJdMlRIYlj1mc1I1CLuhM51H/XCu0muGw0QjxTr2B8iAf0dexKRei6UM+lFUDnaMjElJ84p0+peGdJqGtNWziRrPcQxLa+v4BtnY6yFdD+qWsJpSwD+46YKO4y2hRGItWspOtobrut05S9ZfZAMyTSma6yFXyye9mKq00sihUrMIxaAY7uMnJ1SSGjIeI/sXo6mM+opQ6PyODvMqhOSH9qT84pzdRZA93aJDtDEo7Ye7ixDz0Xhm6syaSqPrEB3p7Qsbe9YsmWgEcod5KWiACDLWMfSfFqA4fj/MCarhwOYJksntdISg0W43j3fYgQ4d6Jr7vs3tveuGsEZviI9N6iOgbauJ20yQyPFx0XOeeO61W7p9MbDH8fMNFBS5ghUHL4CCJfvVTlI5seGCz16ng1p20MJMd2hAZhnC7wRM6CtJVS6+1P5ve3oTrTQstjOQGVpMO4OqZlijfIJa0PRKcx9B+LfgQYXbsfoHJsPrmXfsZxqneugK37ahJUaLoPdYs9AtPt9PfEidjdUljxhpHxM2Of2qS2PNrT9A40NYxkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fj5b1fFkf4Tdn9nWuK833pLF1I+4HHsCMRwNFAKGbLheXvw2sESOnNeijyuOMAJUCYmWnjXicwwGpSv9DBpmuczidoW2rjQSJTZrscrIrYDLGdsMZt45hrEvNa1dE9dCJwwQUt8jv6qLKiwiYtsuy2VpuPBjO42kecXlTOtyz5TS4twirMpSObPGZpl/Fq7GYYSaw6q0JhdgPJLYFp/gnbcyKmaKr9coy36gWVVw3iQRDEyxB3R4zQJp4YLRpNjkwmXR1inRFUTK49i0+/ayyC7OGtymU1Pwm4MaaK8mITmezwkhFDXpquBbb4DbYjIdi4AGxvORRfy0NRILoc93Ar//Qn/srVKtxReJ5p/TvGrIxZggcjabojX1doJUQ8Y1O9Wrx03N1/ROfUu5K21jzfxF3xIrfwmI1lyHz2TfYxY1gEA8Xr4n1gjgzP7C9hbz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:41:37.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4febb5ad-d1f1-4e50-7b87-08ded29591da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

struct dc has grown large over time (most of it the two inlined
dc_scratch_space copies) and now sits close to the page allocator's 4 MiB
contiguous allocation limit. Its actual size is not fixed by the source
alone, it also depends on the compiler and the .config, so it can easily
cross 4 MiB, e.g. with a newer GCC or a config change.

dc_create() allocates it with kzalloc(). Once struct dc exceeds 4 MiB the
request is rounded up to order 11 (8 MiB), which is above MAX_PAGE_ORDER,
so the page allocator warns and returns NULL. dc_create() then fails, DM
init fails and amdgpu probe aborts with -EINVAL:

  WARNING: mm/page_alloc.c:5197 at __alloc_frozen_pages_noprof+0x2f9/0x380
   dc_create+0x38/0x660 [amdgpu]
   amdgpu_dm_init+0x2d9/0x510 [amdgpu]
   dm_hw_init+0x1b/0x90 [amdgpu]
   amdgpu_device_init.cold+0x150d/0x1e13 [amdgpu]
   amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
   amdgpu_pci_probe+0x1e2/0x4c0 [amdgpu]

dc_create() then returns NULL and DM init fails, which aborts the whole
GPU init and makes amdgpu probe fail with -EINVAL ("hw_init of IP block
<dm> failed -22"), leaving the display unusable. The subsequent
amdgpu_irq_put() warnings during teardown are just fallout of unwinding
a half-initialized device.

struct dc is a software-only bookkeeping structure that is never handed
to hardware DMA and is only ever kept as an opaque pointer, so it does
not require physically contiguous memory. Allocate it with kvzalloc()
(and free it with kvfree()) so that the allocator can fall back to
vmalloc() when a contiguous allocation of that size is not available,
which also avoids the MAX_PAGE_ORDER warning entirely.

v2:
 - Rebase to amd-staging-drm-next.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5406
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ae776519e6e..99d08bfad53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1509,7 +1509,7 @@ static void disable_vbios_mode_if_required(
 
 struct dc *dc_create(const struct dc_init_data *init_params)
 {
-	struct dc *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
+	struct dc *dc = kvzalloc(sizeof(*dc), GFP_KERNEL);
 	unsigned int full_pipe_count;
 
 	if (!dc)
@@ -1557,7 +1557,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 destruct_dc:
 	dc_destruct(dc);
-	kfree(dc);
+	kvfree(dc);
 	return NULL;
 }
 
@@ -1606,7 +1606,7 @@ void dc_deinit_callbacks(struct dc *dc)
 void dc_destroy(struct dc **dc)
 {
 	dc_destruct(*dc);
-	kfree(*dc);
+	kvfree(*dc);
 	*dc = NULL;
 }
 
-- 
2.34.1

