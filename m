Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634769;
	b=pETdjHj0zuSgluJDITpCL2OUtzvcanyaVbMnzZLHQ2Ol+hwzEjS8IQboI1Bf2F6Da477
	 IMWSO11ReigpjHsT7JD/VG+e8d38cjRoucD44ZP/5hCG1s4B6wC6Qek/1j6ic6+rt6G9i
	 NAD35Z1aIenpbNE+pZrwNHx2QEroiF3iE+G7fWbNfFzZJML4cAYipcuUBVwUro3AXfX8P
	 nYE+pYT2dZy2LpJZjL+aafF16CSjE9aJQ1JMgn94kS///XVzX3XIttQPzpEGOzB3ijVnX
	 10ECVapLaRoQ0iSS+ep1CSIEEv+u4sOepe/zGb8VS2Ow22PdDchRczsbS99V6LSZsxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=elKP4DtgXsx0z2L39kbUZh/lWuO+Xswm9HyUKljvFUo=;
	b=Nn2Kq3YYuckDIEmhEvf4gD0+fhNsBgyr/mJ3d2QXqJa8mB1yqtqRN6x27Nwup3LmPXDE
	 Z/rXx8sW5d8T75pUSqY5e46Qk6VdMyov1ixh8TG6I+JiWzrswO20P4dPY92CQ7oO/DiiT
	 VCHd1Lb/QUOHB2VBIDABf8r4psne+a9B2lP2O+CXSlvczTAgFvHWiN0Tf9HYdxEVjdn2L
	 ev8qKtzC5KKot0JEuVTWz2xnzj52RgdkdAgImVLUZaTmpo1qC1Uyzm+YuQH0RKD5uFGUb
	 V+AUbjkIGnp/p87NSinBxypBrRNTdNPTG7HroCvZGPj6XiFfGAqPAa8EQU4MpumpEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nqwvrmuj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC759606A33B
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nqwvrmuj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08151F000C5;
	Sat, 14 Nov 2026 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634769;
	bh=elKP4DtgXsx0z2L39kbUZh/lWuO+Xswm9HyUKljvFUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqwvrmujJrG8Vtl/GkjgMo828s4L2W0HRnU8w3afMurFS9K7iBKAjZJ+2bEmwIwVS
	 MrdYQz6SbV1baO75dusHu00XSgTHcJbqTuzz4CVQXGmdehJQt4Tt3h9eQ3XW3gUpdU
	 uqo5Eg1Q1EG636Yz/UWD81/VuptE6Pq5uS59IYvD7NWmzqElCG4ogJUpwBbEHoao3v
	 xBcLe5QRxXmEfrsv0SQ0VfbJ6G+s5LB62rqWL9OF7BQZuZbXLRqt2FhyN8OcwYJ1ef
	 R3eXYbm6P4Pi6Tki0cnDhBR9hi8OT1Q9hc6b1scxDOVBzQZd0Isk1qmU3fBWUveafM
	 yz85/RfBvtaWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Sat, 14 Nov 2026 00:39:27 -0500
Message-ID: <20261114053914.2933164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202858-failed-5.10-ade92d50aad6@kernel.org>
References: <20261109202858-failed-5.10-ade92d50aad6@kernel.org>
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
[ sashal: Adapted the allocation change from amdgpu_cs_pass1() to amdgpu_cs_parser_init(), retaining kmalloc_array() instead of kvmalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 40146957996f0..2ad2433646591 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -135,13 +135,14 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
-	p->nchunks = cs->in.num_chunks;
-	p->chunks = kmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
+	/* parser_fini() walks nchunks chunks, set it once they exist */
+	p->chunks = kmalloc_array(cs->in.num_chunks, sizeof(struct amdgpu_cs_chunk),
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

