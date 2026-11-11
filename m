Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361438;
	b=5nKO9Htjbl6kQ7pWyVkUnJoar8bpej2nuI32SgM1ounQfj+fnVNyL6CJbUmRGYVIeK15
	 cFb7aIsLnwop7AtGwm+easzjFjAEG4UiSeuYOOF2aNdDQNfTQePXK0o39obqLKrr0JYvX
	 qmTfwf0ackeIFWaqP+f0OSBPJ0EIkNz1U75Lo0RA6S7yjAqM/SpmeViFYFx5wRm+HalAG
	 IE9xLVNjGVRpZdqQ97a6n8xB3oisySYcCkY3SztvvTv58rsRSnn+gxQAJie6gdLR/VjDO
	 MLXddvO2+gHENKYne/KmgAx+LtziKuGtyG6dSbJeUoAG8guCcuoOzUThxMJ/+LDGhTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WII2BNJMEvhWhywRZRfCBf8b9yINVggWSODYPyPrsco=;
	b=FdsPANltRidFZtV6+XFE5dCB0j+Fern11M4QhWNOMBXqLn9JWz0QaMIumoe5exwRCCEG
	 2mqR36reZ96yhZyUlHE/XepZWVRcF/fROAsMc5rGhvSYPuV+BzpY3z0dRdKoYHlhtlZyp
	 6HeAimkldh2pA982+tTq1Z+5rPVePTQQwlyt0qunF57eWLoVVwibCh2vuYv/ueZbpmusP
	 /5KNKjgm69JwJpLEpOJ12as1VQRTbhR//oJ6+orYld7+GOH48uY68mbbxjBbyv6SDAC6M
	 A2zE/AUfsRiXy5V+b9RuwwbVfev0fwinwVeYkf6Fp1PSRtZDqT4A4vujlruw+A0LYhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5NJbCJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BF606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5NJbCJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBFE1F0089F;
	Wed, 11 Nov 2026 01:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361437;
	bh=WII2BNJMEvhWhywRZRfCBf8b9yINVggWSODYPyPrsco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5NJbCJbH2q8awWryoXdzOgunEbr95VUvvls2Tr9/5onmcWP88tkl7ntn2Y7IrL1S
	 aofpLQ8HZVpfnL1rUrNFTRBbP2XI/U1ZLj5Jbu/F454JpDXaVGn8MxTY/lqGKSzlfD
	 fVvPWiliKd47mBILDL9nx/PkMfTe6GbusBFb7pX+rLLT6ItIu0rDs8xN9rN0sRieEv
	 WTDd9YD+YvS4fc6uM8VqHNAGccDw/C4Yl5Y65OCBAFkbzi9RCs4JX6P7mi1axRww0d
	 GKsOchiUzFQPraucv/WnXjFlYYRsNII4Vv/wjkvgVGuPhIoLBoP0870owS9bZ7paeI
	 B86Uq3MAzik2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1
Date: Tue, 10 Nov 2026 20:43:54 -0500
Message-ID: <20261111014348.413840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052721-failed-6.12-ba4c3c202919@kernel.org>
References: <20261107052721-failed-6.12-ba4c3c202919@kernel.org>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit d4b6274cbf0b0ee92294d699f138b63aa4796ad0 ]

Replace k(v)malloc_array() + copy_from_user() with (v)memdup_array_user().

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ba4c3c202919 ("drm/amdgpu: reject CS chunks too large for kvmalloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 33 ++++++++------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 502872bfde49c..bb207ba59e752 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -203,25 +203,17 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
 	struct amdgpu_vm *vm = &fpriv->vm;
-	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
 	uint32_t uf_offset = 0;
 	size_t size;
 	int ret;
 	int i;
 
-	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
-				     GFP_KERNEL);
-	if (!chunk_array)
-		return -ENOMEM;
-
-	/* get chunks */
-	chunk_array_user = u64_to_user_ptr(cs->in.chunks);
-	if (copy_from_user(chunk_array, chunk_array_user,
-			   sizeof(uint64_t)*cs->in.num_chunks)) {
-		ret = -EFAULT;
-		goto free_chunk;
-	}
+	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
+					cs->in.num_chunks,
+					sizeof(uint64_t));
+	if (IS_ERR(chunk_array))
+		return PTR_ERR(chunk_array);
 
 	p->nchunks = cs->in.num_chunks;
 	p->chunks = kvmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
@@ -234,7 +226,6 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
-		uint32_t __user *cdata;
 
 		chunk_ptr = u64_to_user_ptr(chunk_array[i]);
 		if (copy_from_user(&user_chunk, chunk_ptr,
@@ -247,20 +238,16 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		p->chunks[i].length_dw = user_chunk.length_dw;
 
 		size = p->chunks[i].length_dw;
-		cdata = u64_to_user_ptr(user_chunk.chunk_data);
 
-		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t),
-						    GFP_KERNEL);
-		if (p->chunks[i].kdata == NULL) {
-			ret = -ENOMEM;
+		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
+							size,
+							sizeof(uint32_t));
+		if (IS_ERR(p->chunks[i].kdata)) {
+			ret = PTR_ERR(p->chunks[i].kdata);
 			i--;
 			goto free_partial_kdata;
 		}
 		size *= sizeof(uint32_t);
-		if (copy_from_user(p->chunks[i].kdata, cdata, size)) {
-			ret = -EFAULT;
-			goto free_partial_kdata;
-		}
 
 		/* Assume the worst on the following checks */
 		ret = -EINVAL;
-- 
2.53.0

