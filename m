Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AE39061C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246767; cv=none; b=i8R93AnYTSk2qZK1XI0ZJdpQYW0Cc4EzXrLNadMxuMVINFEOd6q2fzPaBptdWf/F4jjQjWdHPQxG90j8G1mvXOstyYyJU4hITUX+T+Ew7TY6a3ZBfEePoYkcniHqfWGnFFnswM9PcJYRb37rwtHdn+jvY3Y34e0DRU4/iZ+RIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246767; c=relaxed/simple;
	bh=5Nr4SvFGwWxFUiohq2O0EZpsOgxWub3ER2CVb++UN3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJZGFqyZ7X5NkjpYSAAWayN2igVCclQYqo0lsLkhW3KKCxLUO7C//7HsGV0DWF8XQAE5kwmtaOLVEZEb+wL3WLGh+wI1o76Twf3EVRzO4o+MHJfcqr0VSavAmvtAm161Cx57c4DXNAs7XDciZTbqRDsGnMq9DNXBr7El8XSmm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofUJ5Iqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofUJ5Iqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F070E1F00893;
	Sat, 12 Sep 2026 20:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246765;
	bh=2vtO0tnhyIpdLmR8zChdW5VHVEEP6sEoXUW6ywwaAXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofUJ5IqalL29IUlF34cIjO15LtSvuVEFw0GdlKQLQt75jQjVbyQ/WE1KAk87Nv4xu
	 mOEd3n14KYBcP3eiC4ZIDTB0+PK8UKjTPv3J8NJ8KGp8O+521ZaqQsibvOPgpI5VdY
	 awT3T9Lvubx4mnuEshuOJhoiDyvLbWftuD6d5mAQ3mNyhUi6i2uLy2ZJ2qul1PQVxn
	 juNfqt5332WWsr96ZPFck4DCj5/iPD9rclbFYWXehRi4esdORfn78z05pxVbBrTsEP
	 ENFiKiQTkcne+tN0wn6p4RqywQl06wYXK48tyS/FwKIKvA3lHnMyysCmoZ4osLfzfi
	 ub8Ioj/xkvs4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule() error path
Date: Sat, 12 Sep 2026 16:59:21 -0400
Message-ID: <20260912205923.3934930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-uranium-paramedic-0401@gregkh>
References: <2026090944-uranium-paramedic-0401@gregkh>
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
index 806ec5d021995..2cce0a378ecb3 100644
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

