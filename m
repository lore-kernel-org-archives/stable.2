Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36103451C1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222877; cv=none; b=qzyxPTZXGEdn6Rh7wT0Ar4KEXWLhWQqkh/u6GQNVbpaN+E4eshGCwSyWDmsmahsJpk3zBObFhvhFEQUyO6vGAPEYbYNGL7pLwYFKxtG6LHTONpQgB/mgkAKWpXllFmp9lDwUeSZWK3zdPzn/njlispnOru6pTWZjE0Q3v5lm82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222877; c=relaxed/simple;
	bh=96X8YMvv0ay2mVIoaEN2H5UYv3hSeLy007VCOo+pEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwDinGOORTQFpgEaupK1hgyHaneDdO+6Y2ELGyZBkveo0iL9Ke4m/y9CPeU7wFlSVqGyuG0U9imx7YGA0xeANUFpmyRs4mK655W8PPxOJL/dnHz7LzEvoJ8jQYCWXnm+oR/zV8iGer1znAuGYyYp3T8iCZs/kD9/ng4JKuq6dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW8yXYp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW8yXYp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3955C1F00899;
	Sat, 12 Sep 2026 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222876;
	bh=jXP3WwfZOlVR11en1JXl2zHhQ6cqo8lPIGye7aLxaxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RW8yXYp3xdrUCyDCZnByaYYoSZnFBbbXLX6+EcAbF6O5RcIIKgrya/T78UM7YBGpX
	 csSli3PUw+NoEnqNkYavA+3xVjVRbWEdfOX8ZHEyOWqj9WKi+RaBu98JXXwCrRo+qc
	 Sm7pPSVNYKD2T5OnjmPaB/WE/coi6v1I680cC6oRu0NuVtnabOe45HInAsLKNKloTX
	 dtExRiJYsfGpdXeBp7SKTGFzGadJF/n6RxIRnxHkDXA4rllukRrticvK81NMmbMqCR
	 2oxoIn6sc/7ohtW4wk4VU7QfVVkCwIIMmJp1gQvIA2cvHHd6uyc5CyYTufuAnQmfiS
	 4PILK7WdT4qLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] drm/amdgpu: add a helper to calculate ring distance
Date: Sat, 12 Sep 2026 10:21:11 -0400
Message-ID: <20260912142113.2915311-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912142113.2915311-1-sashal@kernel.org>
References: <2026090944-nutmeg-wasp-168d@gregkh>
 <20260912142113.2915311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 08e7d6c3cee880bd3ec3eb14c478f9fa805b0bdc ]

Add a helper to calculate the distance in DWs between
two wptrs.

Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6760f5cb12d2 ("drm/amdgpu: avoid force-completing uninitialized UVD rings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3eb74f8457802..743699df8ae7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -431,6 +431,17 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline unsigned int amdgpu_ring_get_dw_distance(struct amdgpu_ring *ring,
+						       u64 start_wptr, u64 end_wptr)
+{
+	unsigned int start = start_wptr & ring->buf_mask;
+	unsigned int end = end_wptr & ring->buf_mask;
+
+	if (end < start)
+		end += ring->ring_size >> 2;
+	return end - start;
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
@@ -441,18 +452,13 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
 					       unsigned int offset)
 {
-	unsigned cur;
-
 	if (!ring->funcs->init_cond_exec)
 		return;
 
 	WARN_ON(offset > ring->buf_mask);
 	WARN_ON(ring->ring[offset] != 0);
 
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur < offset)
-		cur += ring->ring_size >> 2;
-	ring->ring[offset] = cur - offset;
+	ring->ring[offset] = amdgpu_ring_get_dw_distance(ring, offset, ring->wptr - 1);
 }
 
 #define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)			\
-- 
2.53.0

