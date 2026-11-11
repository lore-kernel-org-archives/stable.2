Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362010;
	b=xO/i+RBKQVTLDEmFPxpfAxZdhpQj1meGSkFtF1CRWDIur7Gx/RwRUwNKUAymhB/sJ3Oc
	 eXkP4LI1FV+kMGk1/x90Y1qFgkXQ8SKgzxlhlTMQrg5BH2Zx0pS3VPj4cKK9V9wZMRKB7
	 dJqaTD3oqC648DT2juQ3lHEJkhDy8e6VmX2hvtey/zqqWvmhjpUuSNyjacaXfPeCIKvEc
	 WI1RkZn6J1+wVx9ll0FuNIxTJKC2QIyX4hJYAo0XHJCNjdl8N/PbLQx0d60wEqyaJjC30
	 rHaP2BJAsDEjTbkWbikqzRwD5i0pCXIvSPf2G9+wWfF/Yebm5iJ6QbxvqtM+vtcApdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YXk/nxXJOAfSqCjtf30vxZNaUEdCGHuQDVl83G5ATdc=;
	b=jA1iUWdt2bGQDDsTirC2yLG52xHdGcsIIJSsv0QLDYLXuvfcJND1QtjEMv9imtge8M2j
	 Uz1Aj1qGy+FHZ2Quo4MNxVjkIlsNXUnaVNJUyVPP2JPyzLZ7EL9x+lXzHwbmzNPHYKKuH
	 yZ2JSWMvnaz3VBb9d5pmC1E/gSemluhijirWiSQvvvbJRDgy0l2q0IA/DwPiZIYtR3OGF
	 50jIWPCw5I7T8ffYu+LlB03xA2NOOzrhrG/JaVNEkkPLLIb7NUNXEVlPTjBz//i34a8aF
	 3LvccTY/Vqdx0tPC3PRd+XeMgn8GtL6oEVc//cmlGSu7VpGYH6JDNEVXX9KxZcoQoyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LekYSWDh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA73606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LekYSWDh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A6A1F0089F;
	Wed, 11 Nov 2026 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362010;
	bh=YXk/nxXJOAfSqCjtf30vxZNaUEdCGHuQDVl83G5ATdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LekYSWDhcTSx4palg9uU4frfYBNDciSpTHsjOW3qWbuJ3Zp9LOz5Wt3Ze19CD5V05
	 UCO8Zgk4UsdfVO/EBIp7OjvpYUGw7QS6BD/peBZkwRxOQwCvV+xqMdak5i4PWFohpg
	 gcPh8T1Q1LYf2AJ0cCmeUi27DKLfHCdXZeU3D+WB4D0jx1Fv7JrjHaRyRCnLKLX9Rk
	 O/KzBoLXuazA6u7vxJfc2z92+9NGAnPEgU3GXpe4TVVXb0IAR61IQHPxa8mB0TgYx2
	 A5f2O9iOF8iRrWjk6itlTMhbxL99FzFAQ0sod5+U2IC2vlQ6+hMN7VyenIc4OBXJKX
	 QdPi1JJIYvb+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1
Date: Tue, 10 Nov 2026 20:53:27 -0500
Message-ID: <20261111015121.433726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054012-failed-6.6-ba4c3c202919@kernel.org>
References: <20261107054012-failed-6.6-ba4c3c202919@kernel.org>
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
index 12000996f7a45..d43bdd14ed4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -202,25 +202,17 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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
@@ -233,7 +225,6 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
-		uint32_t __user *cdata;
 
 		chunk_ptr = u64_to_user_ptr(chunk_array[i]);
 		if (copy_from_user(&user_chunk, chunk_ptr,
@@ -246,20 +237,16 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

