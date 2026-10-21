Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618599;
	b=pVRQ7nOTyCBvWnhP/TWfUIj8pxTQo5tfmmFLsMsvm9HC3WV6yIuGh2Y1jqsSgOa34c+x
	 pPdCbLtVXWYEnumEoJRniCjUoGljhxSvp/M97zvgJ/hcwbfl33WmNnmpJtQV6Q5coyjjX
	 EssvEC82Ugr5tfwtJJ1E2A/s9bUgzoGE5ZdP7mCspQVkLZg4gMJOWOXp61xsOOTgAahpW
	 xlxAAJ/BCrDuEl8Q2BgtIuhZFUFPo3II1El/xOp05rcyJkLR/3pVqhRkwLNaHVsOOQ0Ve
	 cZmTZQrPGG4UOPIXEaSth8HsC2gaw2UIB1W9Jueyl4yCmeyppJUpeviPhW/ovo/D18g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jnun6sbU6VBj84jfHvtGQJNTckQSj767nwutNWam7sM=;
	b=SFEj8VD/O/JEHF0uQpX1sy5rbX8200UQnvfltkglahYJhxeNNnGN484lu3F+tJlickHu
	 RTLytJIlhD5gDtcRHb2Hwgkcg5NS9AeN7Un25+90qVqh/TEpswRf0U6bD61krVCa5jtxf
	 PxWNh1Cn9yqpboR0l2cRu+qSEIdreiwXJM5iuhLev4Laiv1fcgpEWX9DQm51r4qe/qXc+
	 H6ilEoS+hQIomOPLrq7qmAXN70YupaLNPOQEXufcI+pQNCeXOvf2buzl/NTWYZnSi3Z//
	 XYNjYGdP/ZNsvdE386LgmtdIqs7dPifgCQX08bU8NJk1qzHVKexvenNZ7Vomhfexxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ3E68lX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EA606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ3E68lX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8C31F000C3;
	Wed, 21 Oct 2026 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618598;
	bh=jnun6sbU6VBj84jfHvtGQJNTckQSj767nwutNWam7sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ3E68lX4PLHoqRI5DDrzmj05ggTey591tq2By3G7MyP9eX8jTM52AeXFU+4Jm9l4
	 tW/UK2uqM6gVwo+uVsWrpStgI3I/xr30nL/yFhsZhD6pVgYKDFNyxB9IG3J0pbgedr
	 uF7o+O0ZVMlBOdAjyCUz6cVphTAfP7dK3Ex7FZNcJNyNfA/4ZeTT5PnHr5rfcf1cpM
	 bmKS9GjVStVtn2I85dzRmmocO7fDrjil4DuqIZLcAWiUhWIAmZs5u6GvLNWslmpA8U
	 hojH9CmjciQTv4DH3hLLpyGj/CeKKHNACJ9qAJrPqMAmazs2qsJAee9sBi3JcAek0w
	 HRfruO/MvpWhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Cheng <benjamin.cheng@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] drm/amdgpu/userq: actually validate userq BOs
Date: Wed, 21 Oct 2026 17:36:35 -0400
Message-ID: <20261021213614.467885-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021213614.467885-1-sashal@kernel.org>
References: <2026102137-thermos-preaching-3697@gregkh>
 <20261021213614.467885-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Benjamin Cheng <benjamin.cheng@amd.com>

[ Upstream commit 32d0771ef4ca69c30a1db3aefa34dd177cd2a047 ]

This was supposed to loop over the individual evicted list, as the
kernel and always_valid evicted lists were already handled in
amdgpu_vm_validate.

Without this, BOs that were created and evicted before a userq was made
would never end up in an eviction fence rearm.

Also add the missing ref to the BO before drm_exec locks and refs it.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 18decfc9e8cc0fa70b6de9944cc27a37729edfbd)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9352efa98bfa9..f014faf7eb1cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -937,19 +937,21 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
+	struct amdgpu_bo *bo, *tmp;
 	int ret;
 
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->always_valid.evicted)) {
-		bo_va = list_first_entry(&vm->always_valid.evicted,
+	while (!list_empty(&vm->individual.evicted)) {
+		bo_va = list_first_entry(&vm->individual.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
+		bo = bo_va->base.bo;
+		tmp = amdgpu_bo_ref(bo);
 		spin_unlock(&vm->individual_lock);
 
-		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
 					   TTM_NUM_MOVE_FENCES + 1);
+		amdgpu_bo_unref(&tmp);
 		if (unlikely(ret))
 			return ret;
 
-- 
2.53.0

