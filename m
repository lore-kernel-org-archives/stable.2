Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363078;
	b=hf7UWoAF3X48MfctTBReLEy71W4Mra8TL48WWcDMBObEgvqZCTK3nuv0H879Pps8g3H5
	 AIo5/uzURDrhZfRS/5mJNJfYALKqkHt6tKGU46Nq9xvZyKNe0fmV8dAY3t+golizwB5IJ
	 MjhM/iHMHsfmYtwEmG8eXKvWXmPV5lpbaF8Yz6kepgIN4wLZBp3Q5UlCXZeAJAdrGSMeB
	 zDrXjyvRK4357GJ6S2CsSmBHWrPfLJ8W1yurpWdtQpdm1v9EE+pUXxgGavEZrysb+IxYZ
	 +1XZfYO6AZFAqTK0LrXM+qteLO+wmSqJ1Hz6r1QWDpmwMvZc73yblmoC8Y1XrpuaoPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E/JGh/tZsQF4zK7ojPbZXirLb5RtyknIwhwpWEw5riw=;
	b=PRqMpNngaYIKqXlZfPpOGAdO7g6aJJDxwFQsStuWcG9WIwIw5OunAa+UeO+nn8RAtUrD
	 Z92BUdxgdRg9Zfakjs7z7+bZoGWvE2jFXDF5oDOfNsm2pEoe264SHKhvnADbYHCt3Bs9u
	 H0oLWxDYwxlX9O090BtbCFTHrxrraqY6mTXpyt3WaCGW7QN5vTHcWpvhqhfqJP9p2NPEz
	 scYdAQy4bk9VNxzaD98ZEidrkyWPbs3wFHQbuld/PbNfF8ghjFMkvPnM9AvTAFU3lV4Bf
	 xS5nkGgufjO6Tfw3SZlY5hKoJiD3cEr5qaiFgnih0un297MV8fhJqFKbHr1A/nAQhKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4i9KT3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6EB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4i9KT3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F093C1F0089F;
	Wed, 11 Nov 2026 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363077;
	bh=E/JGh/tZsQF4zK7ojPbZXirLb5RtyknIwhwpWEw5riw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4i9KT3iq/cxS2R3npEx++5zFK8DKem337agx9J9aoih7yE6gdT8zgbrENhtNemCB
	 TCya/uu4V23Bn+Zb/F+9qkaAszS4z7C9UmRiWXMTW6GS5ZhmCmuLU6M3lXfUve0B/S
	 4L0lkv8quWlb4HNgyq6SHxQ/QxApArcDEKQh5z5YyBOJqpfHB/47b8VO74QvABQLEd
	 8j3eKXgXgVhvxyY+GVGUMYcXd9GyLvNYwLPuKQas1ti7bbEL2q7f8ZeYjl76XiLj7Z
	 3PIfrjk9xWSx6VEWKPi8VyTIFqg0SaSj+5bSZKhRUfpGeRfXth/jQUjjQK3DPoIed8
	 NdPaSIlMVXvQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 10 Nov 2026 21:11:15 -0500
Message-ID: <20261111021054.542361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061306-failed-5.15-ba4c3c202919@kernel.org>
References: <20261107061306-failed-5.15-ba4c3c202919@kernel.org>
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
[ sashal: Adapted the guard placement from amdgpu_cs_pass1() to amdgpu_cs_parser_init() before the existing kvmalloc_array() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index bb7c1b53c4fab..b28e98ab94ece 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -160,6 +160,12 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
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

