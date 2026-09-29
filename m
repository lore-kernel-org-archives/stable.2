Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49253B38BC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670236; cv=none; b=tteTdZdQIj986zBbjDDKM+1mCv2XaxICd7D8Zafnw+nCBb/1L0AW3HrfhANrR7vWV3atVpZ8NjKuT3SsRYUtaCOdhRpn/zGzgymsD3VbdShY2Y4FqzLCzgLpnF7KmdLJh4Hk6Dt4WifIjW0MQ3DSpHtZm/g0r9MKQCbL1ptdpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670236; c=relaxed/simple;
	bh=h+0fnXeUX5oDE5/BDhL7mDi/L5GG8naLYalmFyamOlE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jFh4iZ9rWTkXzQvWSFw3CFKPn3RgP/oK7mi/5uztznXHPBdzIVcEwgdk7pZ434I36n9Kt00YiU9dttvgvhvcB1MO6MIr0SrsZDfyVqkGV5MjRXkvYoGhhX3KWyU1CrL+FwSJ5Ki8KyRlZfyoRqCsQaGdcy7EEJcqrddaO85CDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cR+3GjX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cR+3GjX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C171F00898;
	Tue, 29 Sep 2026 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670234;
	bh=hpZoa7lbgp8TE4eKkucKIU+8iOy9tdHJ3sOMZetpTLk=;
	h=Subject:To:Cc:From:Date;
	b=cR+3GjX+Nh10d6vyQeCfXq4bGdpqGBnt4enDN2nfYtoYrrofHXY+xyNXz3Wmxb5qj
	 gRYvn123ULZUn7cq1Z5SsnxhDir6Zivfn2GUF4Cbp0J0hxcfGCxQbp0ghMemtV157Z
	 xJ5t4Mbb6T8Ibz3RDSx+gryBXr5qyb1wHXgF8cHQ=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:40 +0200
Message-ID: <2026092940-colonize-monopoly-48e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aea841bc62a76242396610d22d8ff40c13065f64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092940-colonize-monopoly-48e2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

