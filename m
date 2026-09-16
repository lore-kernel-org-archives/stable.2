Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683D4C14FA;
	Wed, 16 Sep 2026 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552955; cv=none; b=KrGJqk84knVw32+CB5FN4biBr4peDRc6Yy+eR3OcCj/jX63Z9u1zlJ//tmVpSHVvAtGzpTi/i6ZChpM+Nwk8k3c8o7+gUMCebn4sFZfvOyU8a8v4mSD491KIw0dtowRspb3qtyVdVzhm8R+t3twwNU8TOh5+J60YBVE5OM1SWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552955; c=relaxed/simple;
	bh=EjIVUVIJw2sXKAgu/3pZH9Pdrd6GeTatdPpPEEdMrUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILqSKcrLPUpcDboKGEfQeknMKn1pgEMQhN9NM4mMunH6reNA/RjdFIcUbsMIbZtCyxQnF3nN6VmojUZUfAQdgpz9j/TYzNcO2JoMqylMMZdwtPoadNZmHMFM3ixUX3PE4yJSN+pXGiZHGQJuFHvLn37whFdT5sGqOh6CpGjBnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXmjgfaapqL8_gBw--.61668S2;
	Wed, 16 Sep 2026 18:02:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	andrey.grodzovsky@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
Date: Wed, 16 Sep 2026 10:01:39 +0000
Message-Id: <20260916100139.2012124-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmjgfaapqL8_gBw--.61668S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17JrWDXr13uw18Ar43KFg_yoW8Zr4xpF
	WSg345JrykZF17K3yUAFy8WFyUK3WxJrWIgF4xCw1F9wn8CF95tFyrJw4YqryDCFsFkF43
	tr98Xa9rGF1qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYMA2qqPpSvhAAAsO

amdgpu_ring_init() initializes ring->vmid_wait with a reference to the
stub fence taken via dma_fence_get_stub().  When a later step of the
initialization fails, e.g. amdgpu_fence_driver_init_ring(), a writeback
slot allocation or the ring buffer allocation, the function returns an
error without releasing the stub fence reference and the reference is
leaked if the ring is torn down without amdgpu_ring_fini().

Move the stub fence assignment to the end of the initialization, right
before the ring is registered with the GPU scheduler, where no further
failure is possible.  The stub fence is only consumed by command
submission handling in amdgpu_ids.c once the ring is up and running, so
nothing reads it during the error-prone part of the initialization.

Fixes: 48e9fbd1a284 ("drm/amdgpu: initialize the vmid_wait with the stub fence")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d6bee5c30073..8c12c373ab7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -254,7 +254,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		ring->adev = adev;
 		ring->num_hw_submission = sched_hw_submission;
 		ring->sched_score = sched_score;
-		ring->vmid_wait = dma_fence_get_stub();
 
 		ring->idx = adev->num_rings++;
 		adev->rings[ring->idx] = ring;
@@ -374,6 +373,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
+	ring->vmid_wait = dma_fence_get_stub();
 
 	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
-- 
2.34.1

