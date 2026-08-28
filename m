Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C03231A23
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892480; cv=fail; b=AIXXQKt36XmpDoX58/fw75s81A++6V6UVUmF68xuHCP/SK5SugxtSTPFobmfD2qYbJUvqnhCqGIFoT+3UWlpP39Go3d7NiGfT6aLCriXnsBo1Fx0AmQTEVWV+GD+DO7hMTnA2+zwIc1vADu42Fcr3gpA+2off/VD9PQNBEUzAjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892480; c=relaxed/simple;
	bh=6j5UE7BCzM0bXpGK4DfkYKjdh6PfSR1WvpUzPFoZ2iI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rR+qul/4fMw99LxizVVshiJgoH67lpniDZRYbIg+LijnpiO1BrbogUAyO6oONOqj7aoeed7L30tqNqy+f9yh/dVSx0fqq3KXaZr3Q4p1wC6DJANKY6HhduxaTvQP3SzrR0Ai08gSbouorw5RW9BtDcGfmoL7zWgv5NYTThAsDSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muWRSDdW; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muWRSDdW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niaU5bgEEFw1JKKv7NkkkYLNBwMRsc6fqQczNa976hIvo/t5BrkYCNAXvuIb/Z0yJPAvRjt/0Wx8iRXHOwqY4q5L7w4iIIeNIooFdMM08xUSxZ9LNODJvoBL8B13lDM/uJnPjKMAw7q/ckiEJl01Zq7Bf7FMn1q3xlz9XIB0PuT2VMOjuU0U7Bqvvhd4+1jztPtqu/3EUI/afC09zYYDdTYEP/go72IYkkPW3kOTjCwJaS485dYrJ6ojaFskKj0nLCldqrKyL5IrnwdTnxaGi8NMaYfraRYUgpf85gvr+VKxxamZptp67VOyASx3c0zvOp8Uwy7RrwO57HIfmeAeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUO/dWb/7MYme9fn6DZLCOV5xypoEmlu9//jgS8GODA=;
 b=darRb0B8BDpwOTeWcpohwIilPiCBYJTS9BFqVQIjU8waWySvMiTtQaQEscwQXVSGm8b4/51DcnyfpmJtgRq2Xp84gKh2yk61uLPcZL03/BujdyZLyj3ADFnH86v5Lw/CahDGaasKKRIMuhoFV1FfV0tzEcVKgpDQkwWXY0l8qQ/wJAu6iKV7Jb/DPAMlS/dAt5JhC6rKzGuT8+/QvbBw0xFWhOW0l8kTcqIGvqQChxkg+fiP+16ZN2M8JNBWIs5Ic5lL6BQfsLvQDQZnPNTzwylqmUWxFaBHsWSNyl74mHn0YOAr9qC33C0mPOSLWxHewLP/uEaoWUQw8lC3+kjuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUO/dWb/7MYme9fn6DZLCOV5xypoEmlu9//jgS8GODA=;
 b=muWRSDdWw8ukLAzgVRsCuHjcY5euqw1BX/tVLeIZAh+K8uf7lSwtGKEjEfA0G9bDGfZFTyIiITWRhbb15vqAQTLzsG0FsgTAvi56jB5EvG561zXJGdLLcKEE/nA6THs5trrV02VdzNUEILER+Yy8mAtMHPSjnl+zzHNOOhXgzks=
Received: from CH0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:610:e6::8)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 04:47:55 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::12) by CH0PR03CA0273.outlook.office365.com
 (2603:10b6:610:e6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:47:54 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:47:52 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
	<amd-gfx@lists.freedesktop.org>
CC: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Fri, 28 Aug 2026 10:17:34 +0530
Message-ID: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4ec320-2bc8-43e5-269e-08df04bf8649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eyUvu0kD91IRze0b0ft6EzDiwwr0S7VvKkt/XE1cyxVCeP4PgB4DGfhqAEK9IiZAOQcrJWJlfgugFE9LvjKPB5WyqOVGyN1QUi4tRqrcMbo/wNSrDPbYWBDmAne36jIJooCAXUNDp3w8zSs3oPyN8N2zPvK/M1p8GX9lsRDDdHd6zNJeSIjexZ4ccFcwoaRGqZqonVoY1YZFaOUckqkFYQHYwN5dHvwPSYUpRQPcTncyxB7xQoW2XXvo4+P+/HQOLNKDirQNjjWSJuLbmkVsknhNkIytEZYoK86US3jXjSdD3jE3LlNoglBv17UbSh0gN835BvWFFTOSq6De4Z5idGRSCpOkOBdI2zK+P3VNqEsSKGLVVb7EdI1JkiGmdcziLrCrkQQeGpSPB4qu66Why930vjxnhkZtpnkl5L1jDakDJJFpMSzzq0HBif1voqg8XRtpdBwRNsf12704upSB09K3lG+hZjQ/n2sZtBeyqaeeYyyZG/wtej4VQy7HiCvoqZUxpugrAJRkWp4/Hk+MJ3ku674O+NiIFGmXPOE0mXPfyCbE9A7WPsj770nK1WcewsfF6D7J2hE8ipBQ1v6oWzpETIxQR1SWePThe1AQkVtkJEMNML2VlpGCLkhDIwYc3MgfYYiHhDT2KFvyhdTzGPoYReTw/k/ZD776+z5lbaPAuUrE+GQjzpHSPaqXvE+K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pzHOW2SuycqdjD5yONMCpOKU3Cgg6CKv42/nEHU+5Sm/YDPqBPbkgmfNX1f0LETU8hJf9y2GwB1dxAhisyLe/sPN4fRz9eERxjdlFSHpOYxgLygH6e/LdtjGrrCHMIXsG7vXEn6jlj0mgCR4xiarwqjlAkmk28j8/S+44Xoo/L0rvlBaKtb+Z7H7d1KUXiZJ9qGjcFdy56HpXoxSr43XC9urQr58GNNODN1FCJGZo35MpTAQrdKeRUZJhSytSKqhNU5NP8+NRqSUMhP3fGvFgpiY6+lX/F7UWa2EjJsA02dJgdnyoSOd3M41k53vAjvRqnW6QNfdMep9FTYe/hsM7RSJt4Ke4fG/D3997eqVZgI7fpr+MU8cTTvB13HBldYTBGdIFotgWs3Ayxn3Z2HFvAVgb1RnLoAkJTdoX/V8J+U6enKnaJWbNEssIBhlKqhL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:47:54.7463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4ec320-2bc8-43e5-269e-08df04bf8649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
via its direct MC address without programming a GART window, yet the wipe
still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
flush can wedge the engine; only flush when a GART window is actually used.

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Cc: stable@vger.kernel.org
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c07cee8e8777..2e6c98c2f1efa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2578,6 +2578,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush;
 	int r;
 
 	if (!entity)
@@ -2585,6 +2586,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
 
+	vm_needs_flush = bo->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET;
+
 	mutex_lock(&entity->lock);
 	while (dst.remaining) {
 		struct dma_fence *next;
@@ -2605,7 +2608,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 
 		r = amdgpu_ttm_fill_mem(adev, entity,
 					0, to, cur_size, resv,
-					&next, true, k_job_id);
+					&next, vm_needs_flush, k_job_id);
 		if (r)
 			goto error;
 
-- 
2.34.1

