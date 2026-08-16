Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23D12FF69;
	Sun, 16 Aug 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896683; cv=none; b=W0oGJr8U1E7kIkOzy0iwklbl7ISmmQrGKDdH4Y/FCzr8IM1pOFuqpNY/eCZX9JEmxuEq53Z6BXg8OZnunM8ul565jAitLeBYAdRAEdJFgy96sHZymDizhxbveBYzxu2/g9bacUA2wOdNTEEALEy/Ojc58aBwlbVd1Atdaf1PLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896683; c=relaxed/simple;
	bh=B0xH7282wEonwKJuIpT7PcOpcLbv8IJHnA8PFCVeSpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aitI57NHyWJqdota54ODFBiGsFoHCqnnMyR8bzn3pxMYhBRYp+uAMty+IYqL4Q4e3ISIpqiKJMsOTHuNUTpdDxQ4jXCpAXfPt6h5qEHCrxKwhjBxVG/zoGMffLQqA4TGmB1ARuysGdKThYYLYY4oCNR5r1D7CaZ44FAnUKUmw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO8L9Vz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO8L9Vz5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5094C2BCF6;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786896682;
	bh=B0xH7282wEonwKJuIpT7PcOpcLbv8IJHnA8PFCVeSpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vO8L9Vz5lBVjlZqtjCi2ARCaO2yh5g2CknSQTKRw76W6Hy51Sj565jKV+xVhKpf4m
	 1ek8Cl93TaC85zQJSk06DWdtCBAGwtFKAkcPYNbIZmtRjPBmkdVzgbrredNw62ROLi
	 oPHjLVeft9MIyDexleSJcqrXWsy7bPbkYfCT+MRq0BZqx7ZDu7tbo9E+FpPOrF/vbg
	 W1NL0j990CDYBm8mrVfRu0qtqXXGtydlJcnTu84lbK8ZHVmOXAMT31Des4qRpDYvDy
	 aaG7sktB3zfSjHh7wBkyFY8CRFBnLDSGPrLnECDtlLKjrm0yCB7AdPxhkiqpjVpdUV
	 lm44GVLCpSMGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFEC5B572;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 00:11:18 +0800
Subject: [PATCH 1/2] drm/amdgpu/userq: cancel linked fences on fence driver
 free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-amdgpu-fixes-v1-1-36d5298da646@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5115;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=2astBnZBsX4+8nD4Zsb9SZRRyac5fnId9PzuwVaoLfg=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMaHmhWnInneP0oq3szipf5c4PytHWJejOcenXpnG
 P5RiTmmvLejlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJpLDwshwXFjw7EO9X8ee
 tL15dPPsxEkbTOXlzfRdjxZ5St6XD1u1iuGf4vxXKrcKHX32L3/a41rjeHL74vRnT6fNirv7zNJ
 qp/NmTgDgm02F
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_userq_fence_driver_free() drops the queue's reference to fence_drv
but leaves fence_drv->fences alone. Each fence still linked there holds a
fence_drv reference of its own, and the list holds a reference on the
fence, so the count never drops to zero and
amdgpu_userq_fence_driver_destroy() never runs.

A fence stays linked when it has not signaled by the time the queue goes
away. amdgpu_userq_fence_init() uses the wptr read by
amdgpu_userq_fence_read_wptr() from the user mapped wptr buffer as the
fence seqno without requiring it to increase, so a signal with a wptr
below the previous one leaves the earlier fence unsignaled on the list
while userq->last_fence points at the new, already signaled one.
amdgpu_userq_destroy() waits only on last_fence and returns at once.
This leaks the seq64 slot that amdgpu_seq64_free() would release, for
the lifetime of the device.

Cancel the fences that are still linked before the queue drops its
reference, in a helper shared with amdgpu_userq_fence_driver_destroy().
Like amdgpu_userq_fence_driver_process(), the helper drains the list
under fence_list_lock and releases each fence outside it, so dropping
the fence's fence_drv_array does not recurse into the lock.

Fixes: edc762a51c71 ("drm/amdgpu/userq: move some code around")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by code inspection; not tested on hardware.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 71 ++++++++++++++++---------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f74ad378e407..eea351a887a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -114,6 +114,45 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 	xa_unlock(xa);
 }
 
+static void
+amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+{
+	unsigned long i;
+
+	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	userq_fence->fence_drv_array_count = 0;
+}
+
+static void
+amdgpu_userq_fence_driver_cancel(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	LIST_HEAD(to_be_cancelled);
+	struct dma_fence *fence;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	list_splice_init(&fence_drv->fences, &to_be_cancelled);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
+	list_for_each_entry_safe(userq_fence, tmp, &to_be_cancelled, link) {
+		fence = &userq_fence->base;
+		list_del_init(&userq_fence->link);
+
+		if (!dma_fence_is_signaled(fence)) {
+			dma_fence_set_error(fence, -ECANCELED);
+			dma_fence_signal(fence);
+		}
+
+		/* Drop fence_drv_array outside fence_list_lock
+		 * to avoid the recursion lock.
+		 */
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+		dma_fence_put(fence);
+	}
+}
+
 void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
@@ -122,19 +161,16 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
 	mutex_destroy(&userq->fence_drv_lock);
+	/*
+	 * Cancel the fences still linked on the driver.  Each of them holds a
+	 * fence_drv reference of its own, so leaving them behind keeps the
+	 * driver - and its seq64 slot - allocated after the queue is gone.
+	 */
+	amdgpu_userq_fence_driver_cancel(userq->fence_drv);
 	/* Drop the queue's ownership reference to fence_drv explicitly */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
-static void
-amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
-{
-	unsigned long i;
-	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
-	userq_fence->fence_drv_array_count = 0;
-}
-
 /*
  * Returns:
  * -ENOENT when no fences were processes
@@ -186,23 +222,8 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 					 struct amdgpu_userq_fence_driver,
 					 refcount);
 	struct amdgpu_device *adev = fence_drv->adev;
-	struct amdgpu_userq_fence *fence, *tmp;
-	unsigned long flags;
-	struct dma_fence *f;
 
-	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
-		f = &fence->base;
-
-		if (!dma_fence_is_signaled(f)) {
-			dma_fence_set_error(f, -ECANCELED);
-			dma_fence_signal(f);
-		}
-
-		list_del(&fence->link);
-		dma_fence_put(f);
-	}
-	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+	amdgpu_userq_fence_driver_cancel(fence_drv);
 
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->va);

-- 
2.51.2


