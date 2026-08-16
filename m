Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5C3A961B;
	Sun, 16 Aug 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896683; cv=none; b=jKYQp1yntOHeZcmssQ0ApXj7kBwxllW2iKLQwoUt2DC40VMBfR50FxGW3ioz+OfJUVAIqlbSrzQbeG6WViDduMcIyZc37sQXU+RgSwSwTz+d+qnbHPQn6Pjn/nlk7YFQtwQez30GS8CGgyN9JMytms/6pg+bbAJUm8DARCM3ScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896683; c=relaxed/simple;
	bh=EyX93B7kBk3Vm+nJOx08mFmucBcQdi1SaFFZ9cZpeRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3QdK5jFJdTMxvHBZT5gFZjyLfj08cdhNA2iY8CyHYYkiXzlqyAjgyqvhHloLVmOq/PEHiK4v41qnXSNNFxihwqoezi+tWwykrXn6Kili0ymtUZ4OVUyGS42Q1/nHrfLhO3F+ykD3gmPQojZB/HpwyjcYEXZPXCwvXrSB752s4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlTLP4xQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlTLP4xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0FD2C2BCFB;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786896683;
	bh=EyX93B7kBk3Vm+nJOx08mFmucBcQdi1SaFFZ9cZpeRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DlTLP4xQxDaw/7LDYclMUkOWrHnv0kLj/VzzxvOe0z8J0DER0ia7suJBGq6zv5CFP
	 mO5BBKJAnw4dCYD8JRFtBespny4VMfdOAUDS71bQtX2u6ktE3WOd82IiYzXcDT2DAS
	 xh+LYuQU2LkdT4O2b4zUC0FVTM5/CRjbpx5A4tHDrZtmLdRFKgYOpQEr1OIjIKj9+1
	 rg70st5XSPeW0eatZGIvSHwk6yDJ6DzzGJSnOE7yBTvTRUSUEcPLS6WoLeLljbmVmb
	 szKV1alWhfXg6b24zC/DblAtxS8OFhjNzaFxnPBlm1KMg0ZCKCvcoWRGTPutF7RcCr
	 niCya8hy5NyXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7057C5DF6D;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 00:11:19 +0800
Subject: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
In-Reply-To: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=y3B8NHJuJxaEL+O3aaSutDQSpiooXLOV9M+cF0KhZRE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMaHmvNWpKcX1nM8XNVawd7doT7RlVv6wqme30Ilo
 jlGYcvmdHeUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARFItGBkOztW8c91v7x2W
 cIvJzO7cPNOCptfkGXTfdGKoLZqYw2rPyHBF7uXXn4bvj0XOvyd+q8tr98VTyVVRKfP/r9VlN2I
 +WcoKAI5PR9I=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

mes_userq_detect_and_reset() walks adev->userq_doorbell_xa with a bare
xa_for_each() and dereferences every entry: it reads queue->queue_type
and queue->doorbell_index, writes queue->state, and passes the queue to
amdgpu_userq_fence_driver_force_completion().  That xarray is device
wide, so most entries belong to other drm_files.

Nothing keeps those queues alive for the walk.  The caller,
amdgpu_userq_mgr_reset_work(), holds no lock, and amdgpu_mes_lock() is
dropped before the walk begins.  Meanwhile amdgpu_userq_destroy() erases
the doorbell entry via amdgpu_userq_cleanup() and kfree()s the queue
after dropping its own uq_mgr->userq_mutex; that per-file mutex cannot
cover another file's queue.  xa_for_each() releases its internal RCU read
lock before returning each entry, so the pointer can already be dangling
when the loop body touches it.

Fix by holding xa_lock_irqsave() across the walk, as
amdgpu_userq_process_fence_irq() and amdgpu_userq_mgr_cancel_reset_work()
already do.

Fixes: 54d18bc6003f ("drm/amdgpu/userq: add a detect and reset callback")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by code inspection; not tested on hardware.
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4e44a581a78a..f4d12e4b2d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -208,7 +208,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	struct mes_detect_and_reset_queue_input input;
 	struct amdgpu_usermode_queue *queue;
 	unsigned int hung_db_num = 0;
-	unsigned long queue_id;
+	unsigned long queue_id, flags;
 	u32 db_array[8];
 	bool found_hung_queue = false;
 	int r, i;
@@ -230,6 +230,13 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
 	} else if (hung_db_num) {
+		/*
+		 * The doorbell xarray is device wide, so this walks queues
+		 * owned by other drm_files too. Hold its lock: the free path
+		 * erases the entry under the same lock strictly before it
+		 * frees the queue, so an entry found here stays allocated.
+		 */
+		xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
 		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 			if (queue->queue_type == queue_type) {
 				for (i = 0; i < hung_db_num; i++) {
@@ -238,14 +245,16 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 					}
 				}
 			}
 		}
+		xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
 	}
 
 	if (found_hung_queue) {
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+
 		/* Resume scheduling after hang recovery */
 		r = amdgpu_mes_resume(adev, input.xcc_id);
 	}

-- 
2.51.2


