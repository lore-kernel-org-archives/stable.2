Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362343;
	b=HaatV+D/ZjZ0VebMnRoPyVFR1FQSRXYMnRAaRASKJanXuzpH34XpY1FiEWyZaVeWvp4X
	 F10jRa7hgs+e348BjziP72dAhL7u9ffXx0gHZkK6NBErtvB3AJQ489G5cjeoSCeQ95pvm
	 3fd2NDTYMpyKHX3wbFSy9jV2ppvgsZO741iKKCzNkeAyHwecucgfb7RK896Zb5I8PIHYY
	 vVqzRhXLdr3u/SiY6P2P715It7GsQ5YZCZubXTG7DHqEztN8C2ElnLJ+8N56QPaCCcOPk
	 y3q5qhhGBLpOP+tSSKo0s083Aeosz/FyIUADLDOY7VwQXwZ33AU/HQMjkQQiIMAAf8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uSwvx987HAg+p50EMj/avSfDCGaosNhj5MahAuxUCKg=;
	b=PGvjR+8zs5A59XaB0H9OYtSDXX4QyY1tRipK9g5bdNpojGxxjAt/3VbGDJ9dr0gcBlez
	 WTM9n4KK0mAqttZMCHo+LVHfk+YPea+h4aWqlKAdCZkwXVli4nrx5A8Z5OSuLjWnZn/SM
	 IL9YJNipfLcPoT/LD4gbD+hcdV3XjiSOvyiGqwPv5A5bEGyHy/1CzPkk/3DL3v06Zsn/u
	 VYkVbc0I4PcJsjWAD7thzQLoH7RdxQYqKIjcJq7MV/7YxBbGAWTcFxr89Ec7pV/VaG/qJ
	 3qVkrmnRfqjjKsdhd2pEj8CLX0vkpftIIE7dBKUQgPlFSPuHIgtEMWQwZkJfRctAMPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WogXFJiV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14992606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WogXFJiV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359A91F0089F;
	Wed, 11 Nov 2026 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362342;
	bh=uSwvx987HAg+p50EMj/avSfDCGaosNhj5MahAuxUCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WogXFJiV4MiLKSmxD8ATT7DXjPKov0DbLbK+8vSabZ7Mnrvbt0tT11bDlJ6rAXBwI
	 rIz0ZnPXCs30QlF9M4wIl5VgS7tVX2G6ZKS2cxHWnxHVoUNzpQR/AJvzd9uGXy2y9S
	 DgvRGwaQo7jio/ns61Tu/t2kECQYFGTtyanL5PJQEldn4Ru0eAD0oscJeYD5wSSBaZ
	 SoW96B+PaCphJ/I8asf6f7I/KsoYTUk1kss35WulB7hnr8EhwhKyE/sZl1zhlWczbH
	 MHYSGCnPEypOc3YbDeFX7btgx3jXbq/G1+TgZZufApQSdFpyi9jb7EO9yYLA43b5Kv
	 BMQXYPvhZVWzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1
Date: Tue, 10 Nov 2026 20:58:59 -0500
Message-ID: <20261111015832.481125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055610-failed-6.1-ba4c3c202919@kernel.org>
References: <20261107055610-failed-6.1-ba4c3c202919@kernel.org>
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
index 0a5fa026d595e..37782e2b6cf18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -191,25 +191,17 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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
@@ -222,7 +214,6 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
-		uint32_t __user *cdata;
 
 		chunk_ptr = u64_to_user_ptr(chunk_array[i]);
 		if (copy_from_user(&user_chunk, chunk_ptr,
@@ -235,20 +226,16 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

