Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0A3B05B8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670227; cv=none; b=GH/rGKR6Nu/I0JpGW6gsAB63GgW/hLCr0lf4H+B9rZCsdQc798DIPlSXtAj0cyvNbdUChC3U7ly63BzbIB1aCuov6it1xEwZeQpTg9acwlrz8CS2I45o+IukPxo82CmPSVbDWhVKTz4l9iOtTjziwoLpIhqvitCn9q2EW2R2RMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670227; c=relaxed/simple;
	bh=UWheQ2nWoLtBMNL6cXivQEGBmB8BQUI2JkHJ0NzWFoU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vf33q301tE7MJHiUN0Ydtxo031Zp8/i/JHao4/DRBuPFrkqoOHanZx4jV95t1YDqKWGBLSHBUmTdZWUnyiXJbE5Chq5ywWlDpRuhrmXs958z8GWFXJVj/p0B6j29ay+rgRzR8MbZPmvpydFD5e/L4s3U9Mqrzw1FyAJmnZPRT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCyhqHJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCyhqHJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC2A1F008A0;
	Tue, 29 Sep 2026 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670226;
	bh=qw2hYfx8VroVVTsxV4IfcWCFVgFKdaQVyNgBuPXDB4Y=;
	h=Subject:To:Cc:From:Date;
	b=kCyhqHJzuRnKOgkm8aqUlJy7OzngljpN6bOsPO1o8TLjRKSEgWGS1+SGdURa1quVU
	 bSdMRbczmmrRktw4dGf2StJOq8xspW3KNmRIITt7i6R2bsf7l9da9rLMVsw4tlz5RS
	 aRhUr5ar/QOGszdrdZE+tdoq2WyeGGJAzhJORPlo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:40 +0200
Message-ID: <2026092940-transfer-galore-d90b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aea841bc62a76242396610d22d8ff40c13065f64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092940-transfer-galore-d90b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aea841bc62a76242396610d22d8ff40c13065f64 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 10:01:39 +0000
Subject: [PATCH] drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()

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
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f2b96986851203e9c50ca0d13aaa3581ca3e8ebd)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 686c92e96025..5922406d0a03 100644
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

