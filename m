Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598564;
	b=wdhsJolPaWt4LH8D6gcgFDDzH+/bjwODZ/QcQKBmXIxX/8wTMqiviFzXAHH4kGoUABpb
	 9b3RYKW10+FKGGtjt1cKukSJymQfKDBGvgq/O0Nk/B0bK0KSLy6XgyXenb3eYK+Ge+gHa
	 P25y4VjfNcC9dQbjsBjdEqh/dLDrAt+tNNnJ1BHrFW4AgYOuZfUpoKzRR+fCvlLYS5ktb
	 yeGlalyHS7XtKYY6Wx+B7oCAkJJ/N/mAjz1Zbl1+A0oxM8+zlnh5G9MjnmN65fIOvQ9QT
	 MfqzBJqzVCDX95dsJ4lgg4zQ+o7eyLw3ME/er1w1MLvROIsj+6qDmBOypiovWnunRwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MhL1dopo+6HT3A1/s6uDdPtlRUQ2J6NgmMVPi9TVFDA=;
	b=IwQCugDZVdyutchLIi3wzeT2DvO6vd97f2B4bh5mCFuKFFkpyq5yynI5jxzsXyaqRFyJ
	 mt+9rv5IW3KAyh+pGhHlhuF4iH76sWpghcciCRlWeEc7LO6bW8FKEwRMbaWCjYHyr/gHY
	 7rWd/FDBcGRvSiO1boCQGYGQiuOg+CpzgCTGeeOj5pvS82HcNQhsmSeyfaD7rApmz3iZ5
	 Aj3e98o7+BK72R1tktS+nYaNW8MqVOjzddsga6E+YyDoDkkFRwM1061mRUFltROxbyPO/
	 MOSdkRwDIYJmEOAW2cglVlNw/lYH2W99HmRX0qLSV6jtDMlO1QHUZsUWm8M3oIKCa+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL3i3V1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B3606A886
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL3i3V1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9691F000C7;
	Fri, 13 Nov 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598564;
	bh=MhL1dopo+6HT3A1/s6uDdPtlRUQ2J6NgmMVPi9TVFDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CL3i3V1M699h+bDK5a9IxyFMEOTBA7tkIn0vDsR2LcDUKH0K4/tFuy+zt9nLY1eMi
	 fqiwX6WEm6sl2ekkDnzPfF+dB+0HtqN3NDkVNpz+a0OkZUtbdKausBXmhGPWmESWUa
	 8Z5DtVyxmR+/pN3WXnCv/r3Ic17ZiDOHJvkgWgbvWPfQWr3PulCWwOXI+jn/r0Lmov
	 WyDghXUqZAcZx1E3EM5AfXHQyvEzPz0XalBZPXAuBzf/E1TojyzUlaM3vpLopOnZwj
	 TjiweuIqP3fKA753NO3QP9ZwR8SmcpzFbOuRle1+IBCkWuVb+WqAABBC+fG3soQXrp
	 G+h4Xo2J/Jd2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Fri, 13 Nov 2026 14:36:02 -0500
Message-ID: <20261113193429.2314835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201433-failed-6.6-ade92d50aad6@kernel.org>
References: <20261109201433-failed-6.6-ade92d50aad6@kernel.org>
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
[ sashal: adapted kvmalloc_objs() to kvmalloc_array() with explicit element size and GFP_KERNEL ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 99de46eda59be..6d42290d68fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -214,13 +214,14 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

