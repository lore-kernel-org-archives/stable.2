Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550A45563C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211836; cv=none; b=nzNG0U3PYCV6LY0Ge6OYec0Xe0g1jFWUd9U11w82twyJzgJ8eqUkXjgFuwJnHqdcFCapIEDXBzX/LUqAFaXTS4Gt1AmT66uE1Du/cN9EDU55s5CiXrC6rXp8RjiOf0ru1i40PTOH2/XGKD01CWEAiDroYVckr+TIjosec022alw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211836; c=relaxed/simple;
	bh=Cax4XiLENYfTbVU4wjtlXO/fSQe/nApsz87qSLP07Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtgVZ079ZtvxZvgGshKzbA6s1o7v/ZlWxkv9y3Lsr26jO3WvIuSfW5lNNkKTk0Bu64/uIqM6XTDWdqtAyaqaBXxj9YQCW0isOgSCZNcZOtdxiPf+p5ePNB3AMro/83qMgad8p0zM3kjkJVNDUZRuyOelLtPnsuBBwUHXhaDmG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJtePRWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJtePRWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E091F00899;
	Sat, 12 Sep 2026 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211834;
	bh=Ckgw7Jizy9G7vjKhQfafZVqX+yvDwB5BG2hr6JszJ9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJtePRWQKLNacrq97IfsWnl7wPbaTflrPzXTh6BmTmMmyHTVu7VZfL8sXtW5lYCAe
	 1F4V3th2Bx2jvEAf2R+qrmtfmvtgrEmPwVdTZE40qRbyenQ4Zc+ANiJGt5PXcOl2KU
	 2/SZ/9n5ATG70stplo0Qmmxidx8D+Dlxk15NJxDyrA7a1f0TS5iSb2utO2s8mGnskd
	 s5xGgWuBjbx4SKlNTV16Bp90JIdLGNCvG7k3b4pW9XPPQjL87btQsnJBPdVoUpgVF/
	 eXBXn+qI0a5zbM+BWT5Sb1SR3VIvY6Sgua7AR2sxyzT9sPHrWiwLBoaGQYjE96YbnE
	 NPu515G34MMAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] drm/amdgpu: add a helper to calculate ring distance
Date: Sat, 12 Sep 2026 07:17:07 -0400
Message-ID: <20260912111711.2285466-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111711.2285466-1-sashal@kernel.org>
References: <2026090943-snugness-plexiglas-e964@gregkh>
 <20260912111711.2285466-1-sashal@kernel.org>
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
index 0098b1eadfc87..1f1dadba92d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -516,6 +516,17 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
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
@@ -526,18 +537,13 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
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
 
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
-- 
2.53.0

