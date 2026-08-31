Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901333F823D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179349; cv=fail; b=KmW9mAN27uUKjWt0nUyYvb15rrkM/pkgGOFJRLPLF9LviXHB7qHZOeVOs7JeZKkShjYIffZnEhGjg2M1UPzRZbmB6OwnKrMUC6X4nyqKfBIyzhpJ5mVc5rzNLW4t4reK3+9P/0KBqyCA/j1VEzjM4YjnD9UCiexR/XrKn8iLvR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179349; c=relaxed/simple;
	bh=y8fnVvjBwW+Zhb5Ey4eBTZJN1QJi44cbsONwpYrZ5+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mLc5Mr46fNS6evh4gnXW9F4TgAkY6LY6sjiY58bga+MYdKizIptFy1WgGQN/1xKasyOAzvGVNjq76WguAU7DRcr7cwaBm0bJvAdxbSYP4TeRg+DpZ/LywbK2/SABLMb4s4L9UUJzrXtbHSH4ZH/ShDx4j0swFQVkvNsQXLfKS4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CqJJp05H; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CqJJp05H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfsIEqD2gOWRcK1vrgnHjVQVAqAAwjvuTTQeL78+dypT56/fXLwD+sZM29ZHJIfR4jfeb2AEMJGEOcMXRmlo0YOU8HapLPtc5x8s7em4d2vo5RbW2smt6PXUB6U1HzUVPobe1EA89dEhMsiVVobZUyFscTOFUoxr/WLqP4T9vEjdlSDBGHzOrwaBAwMK5ak8+O15wkVxpQTOaVDgsDZ2yYOcImTUVFJ+ijvmk1Js21GX1ZOgryTz+WAiaUC87CV6Vv5pP1upyDb3bqUfJ6clavuFtg1w+3uq3mI6IWva5ZtnXJ9fY61ss+JAOGtErItQOLeL0PWRVCZ9xmhTMQYeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYD7/aOA2oW1HKeGICcfDSIHI7n2/zCOQkxI6erLE4Y=;
 b=BEukdNgijLhBdEAdPfabAkm9La0kH5lWdZ7R31clHUlu6OVnzasMBEN9c/AdLUzfbkSa9Ak6XUV4s+hfP7sZlQWmjOmkcqEuxZNW/Fkz66DMSLK05x8lgTyJsMsTflzSwEZgSzT95JXwOn2EcWvgidfqv39ZevIeJbKTXYeO+QGYwz31fCYA7QV/2hFqBzm23jXY1vfOHSfbet7ZxRPbUO/ViOpvcAzz23arLcpIweHfslCJ6l94KDGhDDxHeGAXA07XmeLwDb3vPj7tEppEPKerT6DaF91AkoWF9l8X0BVPIHp+bk9PXL2rFYe2+Ikog4jkXo3xg/K+GYR+yfLmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYD7/aOA2oW1HKeGICcfDSIHI7n2/zCOQkxI6erLE4Y=;
 b=CqJJp05HNXMAN2wAMHiCi1LEleKWXIQVsSExmyj5ZGSn+EWcILu3Qkpz+5ZmPtm+WtEUjDPT/QOnDEFw5ju/A8ZLtjqrBehieSGgjvpDkWzwxgCAqR0m64bVP0uwiKEGzSnP9a9+Kq0IwLVZRlfhrhdqKfyBHscLvgneHuEDdkA=
Received: from MN2PR06CA0030.namprd06.prod.outlook.com (2603:10b6:208:23d::35)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:29:01 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::8c) by MN2PR06CA0030.outlook.office365.com
 (2603:10b6:208:23d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 12:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 12:29:01 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 07:28:58 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <timur.kristof@gmail.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Mon, 31 Aug 2026 17:58:41 +0530
Message-ID: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8d6fd2-717e-4620-9d04-08df075b6ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ln03CBMaewQbfuY8UpoFmX25wESSay45zMZmAno+GGGXYtfeYAWyvvDsWSS28cQ+RPsG2YDnRzizwez/cxNYJAS7nll1smlVSU15TPx8vtEtmTdKvQtyiNDlax/T0wwZGtFOfJSRhf1Tbo2rmTOlRwxMrUkcVfPIf+XI8iL9XTKUFpELAtkLnid6TiK/upbp0VGRi87+ptn8qwyOUuBcM8ScmOewiocIRjClRgCGs3rflppcb2w9XKVx6pKjOFzxe9VbDx3fgZZsqoQBQNjYJbPRwkL+V4WivkcFP7EbnQpzPlUjDB7WXW3rIFI2tX2X9wqcLdGZhCkZHIf2xuNSERVHKorTRkqT3w+ztz92I1zRpMZZclQ8H2B2MbLrwEme1TUixLs27pWLJrHFB47hu6FaTtHFrsIa71oI6CiH2DMxz+mlCLQMm0ukPoNRt/8W2wi2c61OlY1hiQEB+Lf5PZe6JUDBI3DTeStaj84g1QBaagvBtW6rDDJ4h3fCN+pGRf90u5djaJwRUDamHMFWUN8TAhy3UDrcJUN3R9c6w6C4LFLy0W0mRcJ72lOUxs/ZJGT1fRghiwL5KarY2jqQKt5p6qNI3eF2X7bS/jzR9EEGtFik3m/smsIu2Nwx1PAAL7D2lUQh32JdnoOxH3rO9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ihPaerjFB6E0+mvPJAx5bSzwJXxI6oQoDnl9pmz45gdQyuBJo30RAr0pFosMdg2wQ8KfyWs29AlrJ9tL9F561p02e/FcDLXtD30AzoukpGTBco9PeNdyEYxHEje2uyHrI2LUUwMIhyqhOYiXlgxnusNzxIRHvWm7M/JW/I/iE8OhtqPWneRUvK08klf+y3safhqqzRPPsAFOX+b4JY8THImiWphiNYxp383uX7CnNBSkFXHI1NMFZbURZguGRDCMQL0LoloDsaJ7y+/cSot9xl3ITsl1lvoYmYfiTQxc3hSxUKPc8BMNT0Ya2aTQrLLo0kmFGnpEIMMZrqINED7UCogfG1Kon9dSPbxJOshbk6dUEMm0wo/+mwBlDU4njUggAgvJmRy39m4K7Gg6MXg8Pn6f2GkWkjfIGUuI4fkHDFuuG89uwyNuOEA4YY+Kk1QZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:29:01.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d6fd2-717e-4620-9d04-08df075b6ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
via its direct MC address without programming a GART window, yet the wipe
still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
flush can wedge the engine; only flush when a GART window is actually used.

v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
    and drive the clear and copy paths from that. (Christian)

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
Cc: stable@vger.kernel.org
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c07cee8e8777..e0bdd95c64de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
+ * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
+ *		    needed) or false for a direct address; may be NULL
  *
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
@@ -199,7 +201,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
 				 unsigned int window,
-				 bool tmz, uint64_t *size, uint64_t *addr)
+				 bool tmz, uint64_t *size, uint64_t *addr,
+				 bool *vm_needs_flush)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	unsigned int offset, num_pages, num_dw, num_bytes;
@@ -220,9 +223,14 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
 		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
 			mm_cur->start;
+		if (vm_needs_flush)
+			*vm_needs_flush = false;
 		return 0;
 	}
 
+	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
+	if (vm_needs_flush)
+		*vm_needs_flush = true;
 
 	/*
 	 * If start begins at an offset inside the page, then adjust the size
@@ -322,6 +330,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	while (src_mm.remaining) {
 		uint64_t from, to, cur_size, tiling_flags;
 		uint32_t num_type, data_format, max_com, write_compress_disable;
+		bool src_vm_flush, dst_vm_flush;
 		struct dma_fence *next;
 
 		/* Never copy more than 256MiB at once to avoid a timeout */
@@ -329,12 +338,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(entity, src->bo, src->mem, &src_mm,
-					  0, tmz, &cur_size, &from);
+					  0, tmz, &cur_size, &from, &src_vm_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem, &dst_mm,
-					  1, tmz, &cur_size, &to);
+					  1, tmz, &cur_size, &to, &dst_vm_flush);
 		if (r)
 			goto error;
 
@@ -362,7 +371,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
-				       &next, true, copy_flags);
+				       &next, src_vm_flush || dst_vm_flush, copy_flags);
 		if (r)
 			goto error;
 
@@ -2578,6 +2587,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush = false;
 	int r;
 
 	if (!entity)
@@ -2599,13 +2609,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		cur_size = min(dst.size, 256ULL << 20);
 
 		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &dst,
-					  0, false, &cur_size, &to);
+					  0, false, &cur_size, &to, &vm_needs_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(adev, entity,
 					0, to, cur_size, resv,
-					&next, true, k_job_id);
+					&next, vm_needs_flush, k_job_id);
 		if (r)
 			goto error;
 
-- 
2.34.1

