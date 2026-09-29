Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7D3A759C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698433; cv=none; b=GfYWFi480wS4YUes48hUtkFlTOcBGi8yTxC1QbttF+4+7ihmUXMMLAYM7qkyExEOTNRi/s0S5jL9qPSb2+GG5R4/GEWnW/kvtPsoAwUrLf1PuuMUCbbOo5VvylmwynPXM3PsCATNrpogQ/diboS1vAEYdfFd/oLBqLeMcJqhN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698433; c=relaxed/simple;
	bh=4qBZvOJaVxz20L4ghrCw3UjxPQdEaPJpu0iBfz4lWPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSifZAQg9DJDHK/ba0QcVh1jbq1jny2Qjf3VRafNYfcbXh0pALFSzNdfG46maqoBje+NID00HMcJWa+Y4sUrxUMcqntRkAysipY724qFvJeKp0EmmEo9FC7p4SV030XMv8B8xDii1SKW58fELDbpeVZJfNO+Sm6P789c5QLPo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=capZB5B0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="capZB5B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B47F1F00899;
	Tue, 29 Sep 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698431;
	bh=I8dYGe3x4gdnsK0JJ3xmNJ2+Db0cStGnKNJWWZ8gq8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=capZB5B0K3nYnWPtkoPmRXjR8VLx078MQvkiDlJAYEA9LDJjExKPdm4YEv95CXdhv
	 rDgcZ8MWzV8rKdi7pCGL9DcEUxemDV3k7nYLmI7DNqnEoph4QzpZcEpMsw5faaBOhv
	 5IIeIbKCKwiFZbRAYPJ9GFcjeO86ygVnUHbDzwuv2eDwsm2l4Ou9zgvTgGk9XjaY4+
	 nTWE2K6x5snTLcXHOBXe/vBEK2Gtn3oUWxEFCjbC3d6Af6HmzHSR0R0tH0uPbRFvzr
	 OqYPeKT770JNVm47KDKYsBXIq3lgPtnXMe6EoXArl5OdpaXT5Y/lc59uN9CBhpm9Ci
	 TtHgRDzXbw2bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
Date: Tue, 29 Sep 2026 12:13:47 -0400
Message-ID: <20260929161347.4118377-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929161347.4118377-1-sashal@kernel.org>
References: <2026092916-yearling-rise-4267@gregkh>
 <20260929161347.4118377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit b4f7b4459b1b155e4c4977a6482b5df2cf08758c ]

amdgpu_vm_init() initializes vm->last_update, vm->last_unlocked and
vm->last_tlb_flush with references to the stub fence taken via
dma_fence_get_stub().  The error label at the end of the function
releases the last_unlocked and last_tlb_flush references with
dma_fence_put(), but the reference stored in vm->last_update is never
dropped, so whenever the page table root creation, the reservation of
the root BO or the PASID registration fails, the stub fence reference
leaks.

Drop the vm->last_update reference together with the other stub fence
references on the error path.

Fixes: 187916e6ed9d ("drm/amdgpu: install stub fence into potential unused fence pointers")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e7979c84fc05a176bdf855ee664871b1648404c9)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 65808307e824a..ce3093a34b830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3089,6 +3089,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->root.bo = NULL;
 
 error_free_delayed:
+	dma_fence_put(vm->last_update);
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	drm_sched_entity_destroy(&vm->delayed);
-- 
2.53.0

