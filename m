Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674318;
	b=ERqH3y+8PMWrpMmlhYmK64abDaYg3E7r+gNAjmGFD0rxV/LcRPC+/2BUcuBUSACYx4ir
	 b/vrKt+QgxZ+kOmU113bilY8ewJNhnNYvGz+px791ZLxa/Endw0fhpmpQomU36JV+jbxq
	 APyxZN8M3eJB8J8iV0tNciKZahBRCHw/Tmidg/1yrSoEMcClSI4bAsO1LIoyFDaS9BHZN
	 ggCua9T0QCUFCdYWKYVHzRZKY8Hegt43pa3+qZMN8yve9bXE6dxM4c59cg0WpJxC5hYMR
	 xWGB0PBhS8Ug6M3chQhb1qlxPyD/KbDrnPRTmd8eVpPvnjEyS+srTAjh14UywXocKOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674318;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mlXICMOXX+H9lkSL2rmOSdBQGtb03rOmdR75jVFuoNs=;
	b=XWmWmGV53ozzIe2oGrZ7/dfxqYsSfcfb+JIbfhteE2GoJCpHuMksRXqjrV+9DfrSYc/h
	 VzvsE6DSnmhCZEuVRY+cB8x/bZtX8SB48sLZRi89oe2RZFFwa7QtgacGc9cMWOexMkFQ9
	 2poraKZ8Bl+7XiHgEqH5WTsryh+ZeyHiST3J6Rmi0eizXti4n1xgX5ZAP0DrV2bKquEoy
	 noP43MSRWfjtZ9daA4Bf39VLZtSue4On1I/wUsjU5kY0Q+DEh20HHd2Oh7cUG2XhSP1Ip
	 f0Bs0lNrfvrOi8Uo49CdtHDM2raNfSdprLqxwItN7/KfPJNTKdph0kc7hYbMf5LSrpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ+lsT1n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCC606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ+lsT1n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D178A1F000C4;
	Sat, 14 Nov 2026 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674318;
	bh=mlXICMOXX+H9lkSL2rmOSdBQGtb03rOmdR75jVFuoNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQ+lsT1nDwqb3cc4BVxTwOugf/KvRG1Th8ClvQP726qNHmCrfJo6XqTTz7uTKqCCX
	 O8+0s9Qp3sx3Dp7tJSR+SjN2S7b53N2s0xpomwM0XpX9ssV5NIuYOOJuqB+hCtQmhL
	 ULvacazeilOBOX/9+zfYstzRO9KPyMnyQUrVCuXoAdYwKKuF0cv0TXcZ3n5CWVuUX4
	 t70O/065Xe3tFyG7711eK9nZe2BiC2/TwsRizKPmjGWBMDIdQRM23v4ZhdS3Sutgid
	 0D+SjHHuNMRWTfaseCnPDRm0gAgR0Ir7jtXSnifeLfMR/J9B7dIWxiWURfYhNUHcyd
	 Kjimu7p/5HIpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lang Yu <lang.yu@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amdkfd: Map wptr BO to GART unconditionally
Date: Sat, 14 Nov 2026 11:38:35 -0500
Message-ID: <20261114163823.4070300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200953-failed-6.12-da2897ee8b81@kernel.org>
References: <20261109200953-failed-6.12-da2897ee8b81@kernel.org>
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

From: Lang Yu <lang.yu@amd.com>

[ Upstream commit 30837a49bd0aba0f311d4056cd48753955f60d40 ]

For simulation C models that don't run CP FW where adev->mes.sched_version
is not populated correctly. This causes NULL dereference in
amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart)
and warning on unpinned BO in amdgpu_bo_gpu_offset(q->properties.wptr_bo).

Compared with adding version check here and there,
always map wptr BO to GART simplifies things.

v2: Add NULL check in amdgpu_amdkfd_free_gtt_mem.(Philip)

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: da2897ee8b81 ("drm/amdkfd: use the queue's process info for the WPTR BO eviction fence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  3 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 23 ++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1a92f04c63ace..2de2895e3850b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,6 +368,9 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
+	if (!bo || !*bo)
+		return;
+
 	(void)amdgpu_bo_reserve(*bo, true);
 	amdgpu_bo_kunmap(*bo);
 	amdgpu_bo_unpin(*bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 445fba8e4bbdd..4a3ed391b3c7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -278,20 +278,17 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 		 */
-		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
-		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
-			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
-				pr_err("Queue memory allocated to wrong device\n");
-				retval = -EINVAL;
-				goto free_gang_ctx_bo;
-			}
+		if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
+			pr_err("Queue memory allocated to wrong device\n");
+			retval = -EINVAL;
+			goto free_gang_ctx_bo;
+		}
 
-			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
-								  &(*q)->wptr_bo_gart);
-			if (retval) {
-				pr_err("Failed to map wptr bo to GART\n");
-				goto free_gang_ctx_bo;
-			}
+		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
+							  &(*q)->wptr_bo_gart);
+		if (retval) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto free_gang_ctx_bo;
 		}
 	}
 
-- 
2.53.0

