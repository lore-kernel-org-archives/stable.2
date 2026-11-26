Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713681;
	b=MKCTXC9q01Lbaz0o0oCKbNAtbX6zwHiTZNMZm9O0uCQhpHuWvBNEwR4NtRsjiihdqKpp
	 opvOukJGrEblc2Na9VidJpGpop1b7K7uvs1gjBExap1XoRojc4Dc4P43GsCjinaVc1XBf
	 LUK4Is6AzSG+E/KJhI15c+icuMRJ1Devq8QwJGKpKFsbUDrHMbvz69lGQvuOV06/MOxUG
	 1EijVIax8TBceQ1emJNNWjJ768u8BTZDhuzjY19295uCiWKj16a6mykufVZ0gOGIAdzAu
	 2KARtXrweChwDRiN25XtkRy+kps7n7k+Ml4+ZsbkJbKtKVERUGTRrKPyjGQpolPguRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713681;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qsGW6dVCn6imW0/lV9Clz9pMRKg/IwJXR5iUl70F8/M=;
	b=X8m7uGMDWujE/B4GkJEOkmux98neq4N6SL9AB29142+cwxBHvg1tWr+xwI6+JUGA6mkR
	 VybHbhegYYv6euVTgvqVVoo/tNxOE5A1m4eH6ccSfygjirbG7xZRVbwUHHz8KabmKRi0o
	 1s7CahmE+5lAz+HxW3Xg2pKeFzobidsg8dcuSfcytB7Oqt6lgtwKWbwf+XEDThUCwAvt7
	 SZNCdfwgI6yoi2UJ0zexjgN5KTojn8kf82fQupz2kPT2OnQbf0DmO7KxwFd8Yi9MKKApj
	 95I0X2ZUk9fIlUsVXsOEwyK8Fvr0YH/GwNfn0RndRxtYFvuOqDp2PiyRMjRsVFKTWXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJ40hVab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA63606A326;
	Thu, 26 Nov 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJ40hVab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51571F000C6;
	Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713681;
	bh=qsGW6dVCn6imW0/lV9Clz9pMRKg/IwJXR5iUl70F8/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJ40hVabU2mFW3Sk1Nnq/KWHeDsN3SleHx1p5lIwOStC3wYLO+DKPJhQAdjLwzYeF
	 PDP1la/VPtjsMzKckH36pFkwz8fQPbcSOV3o+6dodWnK9eLya8t1ILlpLwa6pjZ6sb
	 YctBM667YvDeqwXd+2wDO5KDU/lfPGKU9w+NJWEqBP2mm/JNQbUl/XLPfJngV1Y5so
	 7bCN3hK4Bq6foMexYiXtXQDhJ3V7WwvEJ3FugcAT8vIaxZD1F5Vy9+xwJMyv4SGu58
	 KmDpd4ym25yX3zWWHayCpO1vdDNR0otJqkMTwr0Jx3MiEJ4iuoplmRRWL+jHlPAtLh
	 MN1m6Lcw4KsXw==
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
Subject: [PATCH 2/3] drm/sched: Hot-fix timestamp misordering
Date: Thu, 26 Nov 2026 18:20:46 +0100
Message-ID: <20261126172046.2473303-4-phasta@kernel.org>
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

Hot-fix the scheduler's manual timestamp evaluation until we found a
more suitable solution for mainline linux.

Cc: stable@vger.kernel.org
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 99252674e266..3d26a48ff1c3 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -928,8 +928,16 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
-			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+			/* Make the scheduled timestamp more accurate.
+			 *
+			 * TODO
+			 * The test_bit_acquire() is a hotfix against timestamp
+			 * misordering. Replace it with something better.
+			 *
+			 * The counter-part of the barrier is located in
+			 * dma_fence_signal_timestamp_locked().
+			 */
+			if (test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT,
 				     &next->s_fence->scheduled.flags))
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
-- 
2.56.0

