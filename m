Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361438;
	b=Phvv4zExCOkXGDViFWK4crpu+dfAno19HIbfErO46TRxx6oGKuK/FDvJH7zAhSec5deC
	 QS7dbXuw9hQCaIxqI2cx8hSO6sqcAsmY7L5EKOFhQjhUriisA01V73KzN90KuxXzFcZE7
	 RngEJBIgMzr/yaHb1vNyyCgjfKKvIRumNLV/V6G+kGMzeVN9VtaY0sJycH9BLKQ2RFtpc
	 7B8Hlko/IxzR9/DyzOV1qs9z9GZzEwyWJhPlRR2bCXWrKIlwQ3LcfohIABXnXPVyH+C8r
	 qVIbVYD8eBvwgIMthhP2F9cLgsKIsYwAyprW/Kfu/GAG4BwM9LlNFT0/m2DeE+6TOhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yl+85OYHeETK4xBKiGMvGsUysW28OqXBf0lxG9wLQjo=;
	b=Qb3VzDSYDI+D6FV8LKAg5i8XEhSke0/jM82U3PFY9D5Jy7oiTLcTSsmt7uq4Pcs9hUtQ
	 tO5XLOI9gnUGSl8huvqV/dFZzV8LsCXNIw65qlqsSEO0krjaE+pTEza++XxMTLWLmwSL0
	 I54/IE+QkzOJK7XCK9qo9B89tgfxXgUhQ4bTA5CSV9NdioPyWqjmu0sghaitKaWMmf8ab
	 oyczQ1X9mxpWAa87zbhDG5hr/lz1tuAq37D6buOyoa6rfeQInDs3x4h3AKID5/WyXf/ob
	 q/CuyTINRzmFuQie3qGtChJ5EdK5hFMwfULx2Z2gIrYjp+955zgpIBSIaitV4mOg77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Upg4IKIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80837606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Upg4IKIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D591F0093C;
	Wed, 11 Nov 2026 01:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361438;
	bh=yl+85OYHeETK4xBKiGMvGsUysW28OqXBf0lxG9wLQjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Upg4IKIwkbtPl5Lo4DeNDj0Wmbiisq2Xvp6WROmr8eFZWLIscN2k49B0uC3VfIobb
	 J2cSE9M9YxdM5lZEG/6psCbaQJ2VH9OfpLWI4vfxbDLm+CHNUxHeqlJFDn6vCV8yEm
	 SRgdjE09NCvSdrGcJ3A2ccaLBlJ+q/HWeObaWqOtgC1iIzKJM9sZjmxXpCiXfgCFWv
	 FGSpUGtI8Hgd9PGcdf2L1t38IepHfMmPL5umI7GZNQ8kAphQ2gd8vPiFbzRNEg0/uP
	 LWsK5zH23AKUSz+Sd6nLOoZj2qWD4FrQ87v3yWrZ1kF3dp+R+yWzxBAVebw1tyiwg1
	 Tj3P6zvyi731w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 10 Nov 2026 20:43:55 -0500
Message-ID: <20261111014348.413840-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111014348.413840-1-sashal@kernel.org>
References: <20261107052721-failed-6.12-ba4c3c202919@kernel.org>
 <20261111014348.413840-1-sashal@kernel.org>
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

[ Upstream commit ba4c3c202919405f461a393e823e4b72c8518494 ]

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dab5f5280406088591645f499f048dcfefab8d7d)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index bb207ba59e752..c49aabb343a72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -239,6 +239,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.53.0

