Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E651B175
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702803; cv=none; b=k3UuMOieEaJ71DGsEs1BIloszyXh4mCnCqUJaQf7kWtdOQO6U9cd4QfnovAA1ZTEJfbX4pSFlBbZGzvLx5XYMBj2QWSssNQuqiCL+nnimjdoC0P8SZ0UvsMB+x8NTDbrBM3DXSN3VMOmtdWom8KgR3qooptjp55XjZvmhROS7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702803; c=relaxed/simple;
	bh=g06TCvAwM2Ibk8hBeTsMBYQDY4Sqyc/XJt9YcDaGmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtoQR64PhWewuvSA306SGIltyW5dtuzkiDW65eMWiWafeP3OGxQzCoTCK16glz71pQGESIONJ638H2zF+ivwChL3SIAxsD+BW2mzLxJZdMgJAYcwI0xPo+fsgnzkK1Wh+DZKCuwwwce8JVDRAlWzBKvbaNGIOQRE/cruZWnyaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfpIDrCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfpIDrCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8504F1F00893;
	Tue, 29 Sep 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790702802;
	bh=eGPKTXnbpZF7sqPzmN5p3jl/WEmARwD+CSCqcm93oT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfpIDrCDw3hA3s2rC+S9uOlxqE9mPX4XJLVeq1kNyUashMZmPKBw5YbyMQFX/Bkt6
	 /OIvzSZZvMPhg7U6/rKyoiYyRHz5Te9n1lZ3vgAaqBxDc95UHitck1BzO+tKvJHhrY
	 jUwD70AhMsrkN0t7RnVSLW1tSpBD3ZrfkLWiNea0BuxoV9FzL5HnSRebL/DKb2hJ+T
	 bF19VjhlTlJ9B5jLwZnnN4+J9O2F3TT/kIPuktEIowi3BMn+jMFQH4K/gv7rO1OeJx
	 9zivsgGSGRbvQfoqD6w15qkqjH/iAM9Y1CrUTLWxALcDxlpjx+bnZ2fRTcQYZJOhGF
	 B+8g3Yl3rDLMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
Date: Tue, 29 Sep 2026 13:26:39 -0400
Message-ID: <20260929172639.247672-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929172639.247672-1-sashal@kernel.org>
References: <2026092916-hurry-appendix-2bde@gregkh>
 <20260929172639.247672-1-sashal@kernel.org>
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
[ Adjusted cleanup context because this tree lacks the vm->last_tlb_flush member. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 560cc53ec6940..e6915641b426b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2942,6 +2942,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->root.base.bo = NULL;
 
 error_free_delayed:
+	dma_fence_put(vm->last_update);
 	dma_fence_put(vm->last_unlocked);
 	drm_sched_entity_destroy(&vm->delayed);
 
-- 
2.53.0

