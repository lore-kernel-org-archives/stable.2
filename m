Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73916477999
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256283; cv=fail; b=WuICMLZx1wPj2UpsflMdVcHYsGon2yhJ3rxYMrvtsaL50lmyk7nHKJCluYRvdkDHfXicQ67AYOkBMv0kvCZDSznp8sSE+k8Y7/emSY+OgV6LBWlIBpamVMyGAw2QV+Y5TqOleRHqQntGFnihSlcMA0EG8IFcSb8rBN8LQShhV8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256283; c=relaxed/simple;
	bh=YphRgDHplkxracuN5xo+t6pNc9aLHHcxcSa8fCZWi24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XFOdfA1T7U4i50JMKQTWDUJqCrfvywtL6gNq/EZHnVt4xJqF5bADGl+gs/G9jqAJ7gxVA5X0CwFmxZhLmeAFxeeEeV3SWcPg4PrUHEfEOSfJGi8CXY5eJyMIP9EkdpKDb7lrwpILaGQSmsBYmY3UJCibxgJOQOFaRWiUtyPxZU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjws1bSj; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjws1bSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB3GLhCSewcg347SBD01iagDY3hu6QZyvp+TdhR8pWta2mH1+HpguiRdh1j5S1tzrg6zfaBTGRhqWS4T//zeONwQrl5wfI3VPDEW1trImQ8bL30SsG9wFijqIJLJNPLx4AMIpggnbkmK+zggbC+aL3lKJWxPD2c6QpmNbXPXO91nD+md0tgIVgoKlRyv8jOMYaaLNXxHUSKrg4SNjJs+oYGVeDfnsxWKenTSD2uHdSLPUDWPJa7Zh/y1Xj2hyHYqf/NuHl1/S+UmCV51p/c0ZdCnjlUYJa9L5DNE716OkyB6G9t/aGHoAzqvSMPdybwabaTLloQNLE07G3hh0NuVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyk77mHZyOhjA/5xnPzfyzomLymV+Fl0AY3Mfr/IEik=;
 b=kMEsoU3ulfH+dxMPK9v7fKsHuHGLcb10xuO5HkzR/IjHZHaI6ShAlHkgxAvdYx5Tc8QwRMpR0euPxYXH5ZWdx08IDsR26AEpmV/DYy9xNa18KA7tUAI4HVJ2YXY+S5k7iDF4AXTrbF7a8H4oxOseuHDBlxT3gkCbx/R0rhIfpib/6Tpb4jjcfFvF8yGumlIagqwoACtJpgFUtWT99mhq8VqhNT/ynDbu8nRL6cSVvz4oo3RekXzF6J/bYKyE3nCSjtJrMaiammerKnji07LDTXYo4z1u5p9b/TZFlUb6N10vZ67oSDlOyltwnrE4T5Ij99JFoa5Tsw6pxoR01iNEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyk77mHZyOhjA/5xnPzfyzomLymV+Fl0AY3Mfr/IEik=;
 b=kjws1bSj5VYuI152wzQtYiSbRPTpMTLAePbyXTAO0Lq0sq80pfVI0ln2cQPBbCr7hYW4OZG/4l/fX/h1pC8peSvmHbe1lSN2z00PPcPKxCvt4yZRdNFQXeK2w5xcVPvZJMxZIXtmocw1fsW3kMTzQBsWs/s01j7HpY9oWW3Vgh0=
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:51:17 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::37) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:51:15 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:51:12 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <timur.kristof@gmail.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Tue, 1 Sep 2026 15:21:00 +0530
Message-ID: <20260901095100.79673-1-Arunpravin.PaneerSelvam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 45edd8a3-1840-44a4-68a0-08df080e9048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|13003099007|56012099006|10067099003|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	FDGLJuvTKXm/cucxtcZP0Qm++JQV2BKtpcrS+pufklAb8QxPRnMxdQqFSvg3OgkCwZKWU/Dh0nnBejvo5qxPEL9BDUGv/mV0GK8FOaBxh8M6bH4XUX7k6ra71ecMqe74/tXJPcwMzDL7n/9AgUvRyN0lFu3b2yHrxChCVR9LgULVPZxcACeYn3EEe+kFXinEBsHi3eM/7YRH7v5ufnDKUPC/jfEBe0xNFKi38LeLYAaMRUHnVuaotQQAjkIHZ4RaVmy0EOBrr1hC/QCVWPCVlqscrEHML9oE8F+zawCK3qn5xvWmKgmnX3cC8tKzxExdW2vhF98n6B5CNp8EHdMWB/vJgQqCOlHwGxud7vtkyLaW+63naRsmMHFJ6RmNcjTcU6i8AwaoauwBUZDTbYD0rM+T4iQpbfBYzld/J5wPYlFbqPXEoV9iGSBna6kjZwGQ89jL0i3EPMKEfO3FDCLrbKJ3wqZ6ukX2uPLHI5fMAN9my3IZQ6T6InJ9rVG6koYoZJFVB86631L7+YQWPlGjxSX8XjcKETinPiscDnDUyJ7+pV/LhFEBinY2SPJpLN+aX7VrjSnxbGi/N9AQxOSjNDuDUMXnnz+4PbWOkZ+DZJukkS4+0KKj3vCWZxPiFkQn6yhiF5f1uaM0XAXbAY4iKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ViwCtxYtkwEve1gW4F+D62KTXxqk1YMscvjUQiAG1L2N8EKwnfDXi4iVL/d+T7lgju8DDIEq6fSpKsXlZ8hIoJWw6mQm0gAW+lQEdxpSDSrJK5iu6CKG4YM9VQatdGUDGr48BvtQE0qbe/yfk5glfaqLfxNfX6KbrvQZ3KD7wH0AILf49DoWWQeW81MawpD6NXeKxV/F2djGwfzpGZuuN8CNTXDC08vIFRLlFjWmBCHiKC6KVqfAnqkZbFuXyM7jJF5eSC218Sp4V/1cmKyWiea3m8RsP3ve2m8avxepcEiqhC/iwBk5eyA7Q4TljcWAHFmJabgKMhYy9eIZFxVQFEVtXo7icQjlnjwC0w3WTeRixzJTBR66Iss6S+4toTjtcPpHksedm8Y0XbR++G+SPojwfhrkHT64wLG2ARS51oA4hyUCxdycbit29yEhjnHi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:51:15.2739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45edd8a3-1840-44a4-68a0-08df080e9048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
via its direct MC address without programming a GART window, yet the wipe
still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
flush can wedge the engine; only flush when a GART window is actually used.

v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
    and drive the clear and copy paths from that. (Christian)
v3: Make the vm_needs_flush output parameter mandatory instead of
    allowing NULL. (Christian)

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
Cc: stable@vger.kernel.org
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c07cee8e8777..bddecdd64f084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
+ * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
+ *		    needed) or false for a direct address
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
@@ -220,9 +223,12 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
 		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
 			mm_cur->start;
+		*vm_needs_flush = false;
 		return 0;
 	}
 
+	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
+	*vm_needs_flush = true;
 
 	/*
 	 * If start begins at an offset inside the page, then adjust the size
@@ -322,6 +328,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	while (src_mm.remaining) {
 		uint64_t from, to, cur_size, tiling_flags;
 		uint32_t num_type, data_format, max_com, write_compress_disable;
+		bool src_vm_flush, dst_vm_flush;
 		struct dma_fence *next;
 
 		/* Never copy more than 256MiB at once to avoid a timeout */
@@ -329,12 +336,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
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
 
@@ -362,7 +369,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
-				       &next, true, copy_flags);
+				       &next, src_vm_flush || dst_vm_flush, copy_flags);
 		if (r)
 			goto error;
 
@@ -2578,6 +2585,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush = false;
 	int r;
 
 	if (!entity)
@@ -2599,13 +2607,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
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

