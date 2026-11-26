Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713688;
	b=p7WT0Pi3P6+sbfcA03sfKFegMnxobCEc+ZfFouGW+FiG0F1y/VW7MHaponXE7lVEi9xH
	 8augEcIswOGH0dxmdWQnybi8lXiJqCMPPt/l8TcQ83b5LWJwcb5NwJ91v+jG9YH8WSR5C
	 0GH5ycy29EffEGpe63FPqCoVa8mgXos89rhELlZ/l4JTVC6NSA2Q5FOcyvucTj6BmaOJl
	 7kG76xqF6L6Sx3fr2XVivlfn0i5CkCAXTCIWQ9SSbWZhvZF60htFvCWWLcHw0hOM2aXhJ
	 M6lVFAOfnHDkCjx5SYbvBBxDk2IOCSxhrWHO3y9LSFqZGtqSsA9yD9B0Rgqu83vs90w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=STF5w+Sia/U7FbjQIeDG5ejbW9/U+HhTK5QG5ApBzGQ=;
	b=mYaO5CWGxKgFs5xF8j6Y1FBjNx5zmc5HSmLJ2iolAOTOtbgKw9Bj8evV/NVLDpDXxxkA
	 h3UqNSwV9K0FkLC1y0jGtSv1Y1mM/ozePvsmope1Qi+euudPDKPwfmIkeP2Is6+gE/8kx
	 b8C0mnLdYo8nG1b+P3qZ/FkVZTCKPsGBBpBhtjyOdnK3f7ndwb9dazZTUs89M1bYjpSTo
	 x7YTWy9/vf//BtAtsaapJwFSjNUdvtBOk3kxKub4wodOFceuHBBKZbOMZpvy5lECQvViP
	 UZXGlJ/IItnmniBcJjofNkmrFzor23fvY8G0V8yWsc9e5TegA8vhuonV5u1ibmIFH8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWgRZV5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD0606A32C;
	Thu, 26 Nov 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWgRZV5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580271F000D3;
	Thu, 26 Nov 2026 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713688;
	bh=STF5w+Sia/U7FbjQIeDG5ejbW9/U+HhTK5QG5ApBzGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWgRZV5sCKigzA2O3op/bPaPQ/GPKQSPM2w9wQ8TZsWdoVqgip7Theap/RvWPS654
	 042cH2hY3JrO5+sUvPu6+RQk1hSb7myK0SL85XLXTd7t1+E4izNEQeOXUQ9eWMAVk7
	 xsUgjD/ybDUT2C8bN6wv+7N3BAwhd3k3HEFiCyI5jgLD+AksQ8YoqRfcEnRT9sVaS4
	 hjA3NEkwSA4AnLoob/osFV0PyFNqaomDsPQdOy8vgQONz2g1ALMnFhReQ1ijcxiYWl
	 ElwA7l7PYEdDsjzvORWrG9OXXbZ8mFRAK45Uyg64QyQiiRBHPIPgEl16yfD79R8+Uc
	 ZBUMR1b0kCWTA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
Date: Thu, 26 Nov 2026 18:20:47 +0100
Message-ID: <20261126172046.2473303-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126172046.2473303-2-phasta@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_fence timestamps could so far be written and read without any memory
ordering, a bug that presumably got overlooked because x86 is strongly
ordered.

Hot-fix amdgpu's manual timestamp evaluation until we found a more
suitable solution for mainline linux.

Cc: stable@vger.kernel.org
Fixes: af0b54167009 ("drm/amdgpu: Convert to common fdinfo format v5")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2f0349233695..415f23aa08a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -177,11 +177,11 @@ static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
 
 	/* When the fence is not even scheduled it can't have spend time */
 	s_fence = to_drm_sched_fence(fence);
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
+	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
 		return ns_to_ktime(0);
 
 	/* When it is still running account how much already spend */
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
+	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
 		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
 
 	return ktime_sub(s_fence->finished.timestamp,
-- 
2.56.0

