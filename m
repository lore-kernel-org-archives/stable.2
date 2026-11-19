Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094395;
	b=k51sa5ViVPmJ+vivIlkw4wQ5+rdNOEOUGnecgV2FvTMp1cgYUtiLypC1jsvXVDJwJx6K
	 czIFCUsfY4Q3Qebyguq5oBlxQQMzMHa1RKIBMsTAVbe8JdK1tvlIZ+Haeqf2P3bFOzp/B
	 Y/d1tLo0ZtxrwU13t+j6WnVCCpn1ibdj+hAI+5u7OsuDf4TActDjF7oIPpACYDmnvVaNW
	 X5y/36TYp6RQIBwRRkxSq/CemxR1uYApDzLiyodqNoz8kRb257fC5o6vM9doZhfud2VMS
	 Vno7tDOlbdpecIvDPGbLI9zryyouuEBY1SPIAhY9YRlmnknB8/u0S0nYSx5zM0cuqcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lttm65rr0Emb5GQAhMwCGlWva+mW8MFSIkZED0kELt0=;
	b=mgO1QKXrixcfwCihpyA5NM61qC2B9Xc2ZgS4t0CIZvjcdZgIdgzTsYWgldsEUowxEul/
	 OgIyBxeNjUVOgIzpBGhYASouB/pqwTSeJfytwpA5GoIcuoJjc27X8ue6wNly56RwpYI5C
	 pkzRJN9x6lp8ng6UuhO4+w7LWbskSedf9umXO3E7aV4O3n+cDpobcFeWm6mHufbwNQlRg
	 uF4d6iGtywnzBrpPq3cKYonmmzN+qTwai/6WPmnuR8GshdsLcgI1Tum8nyHQzazDopt92
	 nHM0fJnjj88tkJB+TXXZfAvihpLqbkklAstS2+Ar867yi/s5KuYdW6Zfr6tIJ9+KHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZUI8I6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CF606A326;
	Thu, 19 Nov 2026 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZUI8I6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232CD1F000C4;
	Thu, 19 Nov 2026 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094395;
	bh=Lttm65rr0Emb5GQAhMwCGlWva+mW8MFSIkZED0kELt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZUI8I6O2fW4O6fBLyZz0ma41X7iKCcL9Q2JLyPNJGWx3/V6dMDv0Qq920BCXDJ/H
	 4RcHbec5BGa6zAHdd0EzqzeM4MTXE0xDRMscDUvcbE/foQ7598YSkG2khiwxYgWKil
	 krJdmSznt3TrCC4cWdZE+hO5GmI1dDbGpj40JskooZr5rYrZVHJUZxy/Twu8fVthwI
	 llBPUboCo//iXEImpVZTvFm+tKYVvo4c70yZOPRTqPojrgF8zdsaLo2RZf+MQI7lHQ
	 KxPU4oaezp1Lbl3RJViTtOgrlG1Bis8xuldrnIWc1m2ErdUDHDBnK0GuQUUHIg4KBW
	 FmJssBd1KXkbA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Yunxiang Li <Yunxiang.Li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/sched: Fix memory ordering with dma_fence_overwrite_timestamp()
Date: Thu, 19 Nov 2026 14:18:31 +0100
Message-ID: <20261119131830.2535266-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119131830.2535266-2-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
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

There is a memory ordering bug in drm_sched_get_finished_job(). The
manual timestamp flag check with test_bit() is not ordered.

The dma_fence framework now provides dma_fence_overwrite_timestamp(), a
function to overwrite a timestamp in a safe manner with correct memory
ordering.

Solve the bug with dma_fence_overwrite_timestamp().

Cc: stable@vger.kernel.org
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 99252674e266..a065a6d2eb1c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -66,6 +66,7 @@
  * This implies waiting for previously executed jobs.
  */
 
+#include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
@@ -898,6 +899,22 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 	return IS_ERR(entity) ? NULL : entity;
 }
 
+/**
+ * drm_sched_overwrite_scheduled_timestamp - make timestamp more accurate
+ *
+ * Overwrites the timestamp of the provided scheduled fence with the one from
+ * the finished fence, if the scheduled fence is already signaled. Does nothing
+ * otherwise.
+ */
+static void
+drm_sched_overwrite_scheduled_timestamp(struct dma_fence *finished,
+					struct dma_fence *scheduled)
+{
+	ktime_t timestamp = dma_fence_timestamp(finished);
+
+	dma_fence_overwrite_timestamp(scheduled, timestamp);
+}
+
 /**
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
@@ -928,11 +945,12 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
-			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-				     &next->s_fence->scheduled.flags))
-				next->s_fence->scheduled.timestamp =
-					dma_fence_timestamp(&job->s_fence->finished);
+			/* Try to make the scheduled timestamp more accurate. */
+			drm_sched_overwrite_scheduled_timestamp(
+					&job->s_fence->finished,
+					&next->s_fence->scheduled
+					);
+
 
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
-- 
2.56.0

