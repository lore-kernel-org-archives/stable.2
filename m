Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603711;
	b=gWNlr1NVSmEHfXyP0jSzEjJaN2kK00FKH3j4QIBMgY+l/+c48cLbURG02eMeUVRypYXm
	 N/sENKhWnV3Lz4nO1D2C8v/H11ozDeUiQIGmoOi271uMSKGiKlr1zSUFOqD+JcpmYQgIw
	 qCGUwiZnlpFzCDyjquR5tooXcQ0bymYq8gPpkO60fhKIzPIEgyuqllPV/fH5UL/4hMRAI
	 hfsAiL8iHoSkRwKZNx8tvH8O9j2YWgiv8wM4R1g4iC1vqRdcVzBthEnZ+peeT2pDjUz/R
	 puW/QE5a07FQKfoW46TT+WbdTuaXWHCpbBZzQ7sjUbFUKYxGeYCi5C0TbgSqN2g6ncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603711;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SzzLvfu9njWXtksbC/geLqkVjirRrp57uQ03AdVjf4A=;
	b=KfLbuMtlIjEY5xtOi1erBKIcKpLZoOtHnO2JriVUQjIw91a68Q859pN2IkGUyU48AL6h
	 3qIJ1vQTsuv8rzBgJSqqhTiv0OLz292FzuHrG+ruYvKxjOmN56omW+zGSLRM3qS8X7MQd
	 sbRkNVcWyKyDNXkm5dxg151qHoF7ueHZ6YT8NcwjE4RlkWRcIsBVLVcHHNe8Bv7saHHnC
	 f5rwIOBIQbJBRiY+HCAKVWi+0HV4uViRUSyMiqB2nojIQLcd8E0QLdD/ODDRxYH0LhVjU
	 +5br6PKsLQbbCyOZcOJGHSkz8cmr8yILUHY4vbSAL60XSvBBbby07Vn+Q+xnF8Gucuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/RuuoUC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D6606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/RuuoUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4551F000C4;
	Fri, 13 Nov 2026 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603711;
	bh=SzzLvfu9njWXtksbC/geLqkVjirRrp57uQ03AdVjf4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/RuuoUCmRg9wZP2XxEkDV7JA+BjTYEs5BBsxDayz5Zkb3KhsHQ1ZJGtzhnFvq58j
	 PlWZFMcoH/+wIdS529J7TBbRPBCalQmm3kVQx4jnIbVPQ/wNtuSaYJONNqzhsZYpLI
	 woWt998AladxXzFDW9dlrEApZ4TtiUvyLkiTnzpmToq9XO1GcaudWFgC1J18SDjhoN
	 uGTb0xFTxex8h/jfrCM4cx4geQauzzP+nicKTWTeGBCzMMY7Vro9kjNfaGbjWEDwZE
	 /CikNb9EXbTfwZkcKy2FRGQ02v5POrV/DRKzBJk27G5hKMhwDxV0JVvafc7MRlesgv
	 DHAppb4kKBUlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Fri, 13 Nov 2026 16:01:49 -0500
Message-ID: <20261113205810.2471533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201932-failed-6.1-ade92d50aad6@kernel.org>
References: <20261109201932-failed-6.1-ade92d50aad6@kernel.org>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit ade92d50aad6799a5a9d7e73cd1604fd0576e656 ]

amdgpu_cs_pass1() sets p->nchunks before allocating p->chunks, and the
allocation failure path skips resetting it. amdgpu_cs_parser_fini() then
frees the kdata of nchunks chunks from a NULL array. On navi48 with the
chunk array allocation failed through failslab:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:amdgpu_cs_parser_fini+0x35d/0x710 [amdgpu]
   amdgpu_cs_ioctl+0xcae/0x7a20 [amdgpu]
   drm_ioctl_kernel+0x180/0x320 [drm]

Set nchunks once the array exists.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0c828445757b86aaa3ed2638832d76f450022bdf)
Cc: stable@vger.kernel.org
[ sashal: replaced kvmalloc_objs() with kvmalloc_array() using an explicit element size and GFP_KERNEL ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 894989f453fff..35fb733fef646 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -203,13 +203,14 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	if (IS_ERR(chunk_array))
 		return PTR_ERR(chunk_array);
 
-	p->nchunks = cs->in.num_chunks;
-	p->chunks = kvmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
+	/* parser_fini() walks nchunks chunks, set it once they exist */
+	p->chunks = kvmalloc_array(cs->in.num_chunks, sizeof(struct amdgpu_cs_chunk),
 			    GFP_KERNEL);
 	if (!p->chunks) {
 		ret = -ENOMEM;
 		goto free_chunk;
 	}
+	p->nchunks = cs->in.num_chunks;
 
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
-- 
2.53.0

