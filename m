Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363317;
	b=y08DFtCNLixhJseKyHvC603KpU67v0YtXuKT+eG4t60DuYj80PaqGRcgNPQ4ZFszl4Ld
	 G3FJSdEj3U+4niu/XirDcpqXL3yGJK5qIXfs3mQzH/DnzTLoHIa1vc8LpCKQojg+2v4W7
	 4d7depsllnLwyqJRxu+hg1S74uVLPJqwP445MpLVkrk4J63aY798GfkeDJhmC1KEdYM3g
	 1H/m0m5PSb4y/Q7Ml9x9P7fIbzY4zUqzCmk8AJlMb7XJ9hg2aXmn0yi8ecaPMoJhXnMeA
	 zK2VjNlAM1ZSFIJKhLrmbxWV9sDeJkCYwNNVfTiXPAF9uOHSkc2ygSQin7M/+kVPjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HuzmWabq/DbmoKZgjzn9HOpqDuTM6C5AzTnBBNnQUQ8=;
	b=PhIIKBJBHYa/0+vS2AaVpy/RAUAPk8RZzsUiSGaUjsGexqjqmzkwu9CCfYf4fMMufqwR
	 PTOCcZbrOJeycIHITroEFEUK4mI+AwuhWFdcCkqWp3ACuO5jU+cmZpwIaxTbgEn7FCX/b
	 rhd7bYeXrvv5Xiy59bMSv32qUVvwHv84YCAqKnbtM1sjAX1B3GamonOLWi3mtdF+zokf9
	 OSZbjXADFxafd76OoAFEzQ0KZLUJIhP2+3O2uzlMi9Vf00yAeUybv+CEtc1U/EO7EbYaY
	 TVe8pgkrR0qkTLClGP1l82gwlG//kL7LaOmYcfwqvRzj/w3U3p8T8nKeiXL+Rh+wmOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V8OlfE/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A36606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8OlfE/p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFA11F0089F;
	Wed, 11 Nov 2026 02:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363317;
	bh=HuzmWabq/DbmoKZgjzn9HOpqDuTM6C5AzTnBBNnQUQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V8OlfE/pgGrRTE/gLAWsOucN+Xu2DRisCoUDQE8nicrzFYDOJEYwC6sSKR2wR776w
	 9ZumC5ybupbSIZ5f4SDFCc/03ijiQdFGwpD0fr66KWa2AhtJ/5+g1lBEp48LPt0AhS
	 3YSgnaSg/kFjPkiCLmGVgB6yW+PHNQvNhwTzGCA6BA3+/+CNMQPPxStoVCY76BaJ/i
	 8SMhJPLch2Dz2gByMngHlLNIJtLsUuA2d+Xk/j6FHifTvdj9smaMaDAUQRb4/6cou9
	 RmeMN2t8ej3bdEafTsEy0LlolmSPFUx4pM7OlKGOQTvskwNo7BMWdOfJnKyXWx7VHL
	 zKwjHQsvYTS8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 10 Nov 2026 21:15:15 -0500
Message-ID: <20261111021455.607602-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063006-failed-5.10-ba4c3c202919@kernel.org>
References: <20261107063006-failed-5.10-ba4c3c202919@kernel.org>
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
[ sashal: placed the check before kvmalloc_array() in amdgpu_cs_parser_init() instead of vmemdup_array_user() in amdgpu_cs_pass1() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 536935fbeb672..40146957996f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -161,6 +161,12 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		size = p->chunks[i].length_dw;
 		cdata = u64_to_user_ptr(user_chunk.chunk_data);
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t), GFP_KERNEL);
 		if (p->chunks[i].kdata == NULL) {
 			ret = -ENOMEM;
-- 
2.53.0

