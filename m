Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF13B42CF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321504; cv=none; b=HLgS0xkbIIuW5FRIJhk1y1BB90FXtcQS+N9DWht9yFIaDuGUrChFryaXHUuTPlhj9p1H/OQQULY/xMQP4h6g7bOenW/KwZCrOas7Z5lL4GkRkWEbJg8FT8D/Lop1f6RoP72JS+5bMTkjhTVW9rOaQbqam4GJtQZhuMFeVcqg70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321504; c=relaxed/simple;
	bh=sUln9z4jT3az/pYXxiMO6xABIbOq4G1h53tsQjkwsTY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UZdmJ773PhjYSnH0BVfk2Z4z48SXFzXCypvHbdQYzTKznfo1nCzbqmOIzIzlgYeE7YVxR/CozRwLbWHGgdK4Wc1i0XbMeSyFkAyHsxaeDy0zBS0zn+ILcD8uRMjTp5JorGG0UthJO3lFPO8DBittNEum+N4k5Ry3R/ep+mZDhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bABMF2rc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bABMF2rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5BE1F000E9;
	Wed, 29 Jul 2026 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321502;
	bh=pdt8Jv1EeePbNRzLfqCNpoMaHUlOvi0ENzVz9qrD+v4=;
	h=Subject:To:Cc:From:Date;
	b=bABMF2rcw8zbfwnzJaxhS6Frvlxk9xflPXycXcaPf0EtACTw8hJiwQGfWxi18fept
	 aOTuL8TSyTfIAi33JUPhu1ATA0pj/J6ubEqcsaal9PP8wbJG2hbp5Vt4cwwx0nlEo+
	 nLywc0PHulxTa7yC0ZGxKZnVOZP5K3kia1AFhUB4=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow" failed to apply to 6.12-stable tree
To: asad.kamal@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:38:09 +0200
Message-ID: <2026072909-backlit-bannister-14b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3e864bf2a32a1cbdf1e0f9c5a5a4176e8575f4a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072909-backlit-bannister-14b9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e864bf2a32a1cbdf1e0f9c5a5a4176e8575f4a3 Mon Sep 17 00:00:00 2001
From: Asad Kamal <asad.kamal@amd.com>
Date: Fri, 5 Jun 2026 23:44:08 +0800
Subject: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow

The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
kernel page fault.

The IB only needs to be a minimal NOP shell to schedule the job; the
cleaner shader itself is emitted on the ring via emit_cleaner_shader().
Fill 16 dwords to match the allocation.

v2: Use ib_size_dw variable (Lijo)

Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bf21af331ebf72d0935fd70c73192414a422c03a)
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1e190fb54a97..85372af1216d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1664,12 +1664,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	unsigned int ib_size_dw = 16;
 	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
-	int i, r;
+	int r;
 
 	/* Initialize the scheduler entity */
 	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
@@ -1687,7 +1688,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
+				     ib_size_dw * sizeof(uint32_t), 0, &job,
 				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
@@ -1697,9 +1698,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	job->run_cleaner_shader = true;
 
 	ib = &job->ibs[0];
-	for (i = 0; i <= ring->funcs->align_mask; ++i)
-		ib->ptr[i] = ring->funcs->nop;
-	ib->length_dw = ring->funcs->align_mask + 1;
+	memset32(ib->ptr, ring->funcs->nop, ib_size_dw);
+	ib->length_dw = ib_size_dw;
 
 	f = amdgpu_job_submit(job);
 

