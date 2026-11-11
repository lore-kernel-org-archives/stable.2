Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362011;
	b=vzj1rzAfNtCWTYZIBAAm3LN1reZJ4jAGtBXHuhck0wA1l/sDHLTBPTHxuVh60gf8uMO8
	 qht0v/kmyNMZy7kcjrW9F0y5GZ3FSFrkMmkB1mSFCx0WCtkKvX6zH8bRTS1MvL9Fo1FvK
	 kXdn3YOk7qT7IFRS4R1VBqAikLPk17Vl83mPgnCaXeyM8rp2+TBjshFOgIwjjoRvOfmKu
	 GraXisZf0hgy+cEAWbRu8OPmWwtZ59yVxHmUONi03c1g8LBC0+yhsppVAbFNqtfknD7vK
	 7gCPWXYtqnDu+VIss+8mPondwoXcWq7yIs/9JXLNNGAfAjgCJ+rstUjszFHlV3iFOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qOPAU0eL0I3OzvXLyj5hYKv8zLsvIfqt5TjqywMOXMM=;
	b=qydDanRhczqNRgPRxpoBUo9DkPxkRYoox3v6VGJ2ui85eWEqG3ox1Ex92TNNtlhJVlHL
	 EhEjB8DRTEz0DtWeyg+CWI70VB+hdL5l1B9IDpDwk/JJXiufqw6moL6hUUHEjwCgCGJbD
	 bu+GoAOfiyoBA4V42OgJsqYikwfqKAjIWC5eqra/yJL1LURPP5NkQgy3UrR+cgngaxymq
	 pDkwpeivVf5QJ9rDdIJM+65B/fd3qAOwR2X8QSbDPRi6aGk/DaBQmkD2Y6q5OhQbOICxJ
	 cRSpSFC/P4TYZY4RbkoBl/Wxj/Nr9IB9Tuzan1QLDYgXRK3SbILPqSPOUHZZlFOjEsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMFPEUHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CA606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMFPEUHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB41F0093C;
	Wed, 11 Nov 2026 01:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362011;
	bh=qOPAU0eL0I3OzvXLyj5hYKv8zLsvIfqt5TjqywMOXMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMFPEUHiuZLOi6qKYUbky/JdeE1hjL7ImEdVeVy5lTFPaLDNz8l4H1frycQ5xwZG8
	 ZtHp8VjDtgLCaG7DD/EtNR5ePJa1LJoyr4tUl2BTO1vhGDs1VD798F57OLRQlkSgAQ
	 tL8PeEpvtlVkJ05wZFrcbAYsnjw7Ts8B5sbmhbSg/2vM1guWXkTPkNhaSQ137LBkEk
	 GLN+pvU2qeKoZb+2W/88XUMZ5icAy5k4FUWUlv7+1mIwY46ynWGHwE3taBSh/myPOl
	 ozvoL7UO9CUAZkBzdM6OZ5DzYzD9MXkdSgnOtZiy+snRarf+jJdRwJNr9avVtTM3sl
	 g2jPH330k5sgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 10 Nov 2026 20:53:28 -0500
Message-ID: <20261111015121.433726-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015121.433726-1-sashal@kernel.org>
References: <20261107054012-failed-6.6-ba4c3c202919@kernel.org>
 <20261111015121.433726-1-sashal@kernel.org>
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
index d43bdd14ed4da..99de46eda59be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -238,6 +238,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
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

