Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA134887E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222877; cv=none; b=PJMwIbc5O5sjdC3okhJo5mhFoQELKwbWMmR6Jep10H9l35i3FxYDcd95iy5zZORPJDY6dgD6ayRCf+R/8sFXSIV/Blj+S2I1ER2e/ppPv+5h/b5Geo/+Ti7pOpGW8+g3Ff0QYegFvtMu90Q+fQgKn5/ZU7mCtcFyJEKmos6FCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222877; c=relaxed/simple;
	bh=DFpmtH6FyjY5RTPe6+Ob5Oq8o3lUOFqfrwusAClKRXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK1WUbIH3+ubkewXtEssI31YI9J1a2vrhxDymwkR2BakzC4N/DPxsjBd9fyYWaWE1Roxz7yZSUHUiBffxpeHH6vMTTK1Y58lz1ld6Qa1I6IIgm009I36m9V2w6u7uM1WBu9UJ8nfXyxDtegOYZX46PNDjF8sP08iSmPcD0+EHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8I4+x4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8I4+x4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540EC1F00893;
	Sat, 12 Sep 2026 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222876;
	bh=lbLW66e+FkGOXuc2nnXi3+VlSLiiUAX3wu7NH+VQIME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L8I4+x4/vAx+yWC4Q8cFeWP74Pt6z17m/d9q0RYGCy9vGshvP+JkiYujyVio2gMpR
	 Mcec6jGFLfcDEDXvjbK2w5tmHTKZj9uDifnOO0xqlP7oIa3mTETE+kts7WIcz3CTqF
	 dzsT+y58YHgJBvgZDZho5mWl/tp1VP+XFERa7P/RCUJkxcm+E5Z4EC76ytcjx/8jSm
	 S53MBoY/G3wSAxtyAlYKnsQvekU5W+FJKXJ436GLeflk4nI6LwiLQtCrI8dFiQlEYN
	 yJHpjterlelrNVu9Xg6tMBUFo0j0kaVjs+Cg90XaEa0lb2VosCGpvy14Ab8QPvD3PI
	 oJbV43ENKcSCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule() error path
Date: Sat, 12 Sep 2026 10:21:10 -0400
Message-ID: <20260912142113.2915311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-nutmeg-wasp-168d@gregkh>
References: <2026090944-nutmeg-wasp-168d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit ba038065655c45728be346d0b174a6da08d8a5c5 ]

amdgpu_ib_schedule() returns early after calling amdgpu_ring_undo().
This skips the common free_fence cleanup path.  Other error paths were
already changed to use goto free_fence, but this one was missed.

Change the early return to goto free_fence so all error paths clean up
the same way.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:232 amdgpu_ib_schedule()
warn: missing unwind goto?

drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    124 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
    125                        struct amdgpu_ib *ibs, struct amdgpu_job *job,
    126                        struct dma_fence **f)
    127 {

    ...

    224
    225         if (ring->funcs->insert_start)
    226                 ring->funcs->insert_start(ring);
    227
    228         if (job) {
    229                 r = amdgpu_vm_flush(ring, job, need_pipe_sync);
    230                 if (r) {
    231                         amdgpu_ring_undo(ring);
--> 232                         return r;

	The patch changed the other error paths to goto free_fence but
	this one was accidentally skipped.

    233                 }
    234         }
    235
    236         amdgpu_ring_ib_begin(ring);

    ...

    338
    339 free_fence:
    340         if (!job)
    341                 kfree(af);
    342         return r;
    343 }

Fixes: f903b85ed0f1 ("drm/amdgpu: fix possible fence leaks from job structure")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6760f5cb12d2 ("drm/amdgpu: avoid force-completing uninitialized UVD rings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index dea7cf04fc984..a60b7b5596be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -217,7 +217,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			return r;
+			goto free_fence;
 		}
 	}
 
-- 
2.53.0

