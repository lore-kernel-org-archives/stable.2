Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576949;
	b=AY8hdxKK5arXw8/ZlBeH0XpUMXju1IO1+OVfJEFHED9SMSUN96qo3ro6lu6qhKDv9g3f
	 jOWBXK8/En82TaXvYG5qqctqdjDviBluU2K6xJHpAmZwEPuix+7Kqh2PTYCylI3oLJM8L
	 wPAi+rykJyjs5P6yOhh6Wh24cnMAdvlO8laKbAXwUXg8yGQ3YnnqyitejkwaTDkKS2rUx
	 0sY43Hky0Ax0RJsE2ipeKUwDTv2yglv0QxJH56GzUUj1qF2lFbRoqZ4Hb7uiy1bQTeJG4
	 hwQ2BwzaIe4gA1YwYIrbNI8bIMEt171naATEr0M3ajA81eESwhydtfX0MdNQp4zC/hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PrSaN7DxesGinxmbIt6dDh+R1v9Rxy2gAHQB0lYbsqg=;
	b=xSX7Azygno53H1W5NXky6pcRE7COR2vthC5Fhl9dPRt0li8Nga/4x33o4qEZ5ZSiLahQ
	 BanoIsgJwmCkkeiep9CwQlL+VkojvoUVuIO+hZBby2KN1/6PG4ooJSk+kXBHi5tle3wfz
	 T8OWgK3yuGK6g7blcYGU4R6jEUHB0D1obQ1LPjiafW9aVksdfSSqqi33cQkUGGZxyLOxw
	 o5ch++XtL5p0ssWQMvx3ork2H+Q85Boh9hfMgo3CnIYCHyoIY1pyM6AtM6vXBUeSOjFV2
	 vewQ4ljpJk2xwH4eVBw/X+im4EfT4WbEZ46H+8E/TxdBf6im9EQNGTRRPqgbvw/QjqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eh7tI6oc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E0606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eh7tI6oc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A311F000C4;
	Fri, 13 Nov 2026 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576949;
	bh=PrSaN7DxesGinxmbIt6dDh+R1v9Rxy2gAHQB0lYbsqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eh7tI6ocsFLCdbTiehtarGKl84M9oriwm050HW1hQ8s3TIwXPNwCUKzA3vLc7cGHJ
	 cVsIonWcpRXU/5YGTPamfpZ63NAHW1FMZpRfWiKdOkCb/TX13kPf7Dz1z/sEegL2ad
	 d0h/9BbFGAvnhJvB5EUfzWckd+jg5DWJz6dSJvknjtKc1tODTZCxbRnJqYDtb1t8uX
	 +QqNATucMAKh8NE1/yFcfFRfHsEgTU2P10gjzmwByHXTHfu4psG+8AwhsEi8kgBqLd
	 aPZe38NSFZrMZn53WhcfP05v+sgK9BNFAd27gYKkRFm/AAzt4cJ8jz29fCew6x6lEl
	 Y6WiiogDZV0QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues
Date: Fri, 13 Nov 2026 08:35:47 -0500
Message-ID: <20261113133520.1178040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200530-failed-6.18-623507b8f4fe@kernel.org>
References: <20261109200530-failed-6.18-623507b8f4fe@kernel.org>
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

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 623507b8f4fe24851b2f1cb2c177f8ae3c8584b8 ]

The user queue map and unmap helpers talk to the MES, but only the
create path holds reset_domain->sem around them. The eviction, restore,
destroy and suspend paths can submit to the MES while a GPU reset is in
progress:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
   mes_userq_unmap+0xc3/0x140 [amdgpu]
   amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
   amdgpu_userq_evict+0x52/0xf0 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]

Take the semaphore for read in the helpers instead, around both the MES
call and the queue state check and update. The reset changes the queue
state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
waits for a running reset and acts on the state it left behind.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e6a8b8588f43bd4d7054ac47cccc35f56ad2df90)
Cc: stable@vger.kernel.org
[ sashal: left amdgpu_userq_create() unchanged because the outer reset semaphore lock was already absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a0bf7c82b83b6..0b3502f3f1e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -148,6 +149,8 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
@@ -168,6 +171,8 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
-- 
2.53.0

