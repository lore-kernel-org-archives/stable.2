Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630660;
	b=G62ewnBMmP70WYwPhiC6BBIdkz0ju70LhxTQW3YIQGW4XW1FUonVIK/F90eUqpX5GlQ1
	 +U2GxMZ0akvqqVBZVbgnC8aY927wzdGF0pate//DfjRS2Ye43L4zUVWuQ/0De5pEscej2
	 3Pp5qKNDuYWPh1OtDQwodHmFOJUiF3UNoRrq7BmPUtvf/yff7QSYPOwM2mLki5009c50P
	 0Ii2Z5443cv6L0TLV064qxjCG7Q3VwJ9H5ttTCnZfH22WPo/yQPyFT/lfw1k2+M/eZav9
	 ujkhU0pvxUqfOKpm6ovJzXd2YYNQv7S/mKkbK4sE8TqBuPCSLcXhPTcUdAV7sZB8Rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/dOOqt1PbI2Tb7oHeV6EDINR2Z6kREnN7E7KjieWKt8=;
	b=yDNP9BF1mV9+aZFCI+9xccA22Ve3a+TNjj1I6zJ/1lVrfww3mOng5w8BPE77QCSxBqol
	 44BqmQ5xarC+Fwkh3F7UdBzdj8J4XbYy3DQi10ze3A3/EIPndQJLUWOJrShEsCK0n0XPc
	 H4jyAwlDL+N7RhABQXRvKDApJjOaFJrIC50vtJXH8pkLyQjDFqNFDHbaHqzJKcBfjVLD6
	 1qVDRur3ObJ0DI1pRAoWJsr60GOb3l805OBbjAkNxjWYUV01t9CKGv7qsr8QysZ7z6Jbn
	 gdkDFohKf2+QGNcNwyoHEE80XMkJY8EKv0bsIYMXULNDzp+O62mWF3T7+DCoaajkOOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5oh9jki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC8606A33B
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5oh9jki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F51F000C4;
	Sat, 14 Nov 2026 04:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630660;
	bh=/dOOqt1PbI2Tb7oHeV6EDINR2Z6kREnN7E7KjieWKt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K5oh9jkiC9ec8BuEzQG+Dwo/1wwwTOdBrlHDFRe3eQ4ZEYif2bjfCAiQ/Um8y6L3f
	 0xrFrKeD2zVi+XVtP6n8HxpPlXzGFtUwvmq4nwUKSm/1IE2uy0CjOr6eINnhiFoji9
	 sTsxWVgsTNvjlIx2s1GQsl2eYT5+pecOjpGs2pfrud4nIyjIL+bVI/oeBrbzFQzyqy
	 j5fCN4uKxnhnnNuFJBC/TZuoWi6C9NYMuo01GddwB97F3xCQ8iYtks2HpItAhAO77Z
	 EyWMN2LcI8JMtTeBwDCi3t3SXnrJU0IU/P+chOeIGpLQ09fqCyIHsZX/RivM5eaXbJ
	 hprcS2CCcRNBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Fri, 13 Nov 2026 23:30:58 -0500
Message-ID: <20261114035319.2634521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202433-failed-5.15-ade92d50aad6@kernel.org>
References: <20261109202433-failed-5.15-ade92d50aad6@kernel.org>
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
[ sashal: adapted kvmalloc_objs() to kvmalloc_array() in amdgpu_cs_parser_init() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b28e98ab94ece..d1e99112a1931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -134,13 +134,14 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
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

