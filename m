Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E3932D3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627805; cv=none; b=Sia2LRvzDM1sAX5qZi5s5OHFj4laOzPbX0iKVNS3ErsUWFNP2ctZ5s/SCnjuc7T7O/PcFM6ymP6KDmLcApfuJEUncJWqhuvzwNPEeB4GzeOBaCPLQSd2ClOnak+XH8heAyd6FXg1FsM0rz7i4/7kP7oUZ4c7KNU5EfuorezAPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627805; c=relaxed/simple;
	bh=t6kE/mozQ9uQi3VvzR1Ykordl5s4CyK4LoNJeMEsvas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugJtCLqy8jaPw+2epkE//BkW3cs1kqlCDR/8G8Nqp9VzSJ1b4MUXBJc1RSomhH/Rx1he5e6rgiZwePQWQupk2PoCXtitbuubqNaIBfgG14kw5zJ4Ti2dgA7KVWV8+ceC0G8cqBWWpo/cqjitXqO/QImVKL0+i+EtWA11xpLhmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9bH3T6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9bH3T6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B701F00ACF;
	Sat,  1 Aug 2026 23:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627803;
	bh=cSmXrGN3HTxj/4c77mG5K8TnGAji9punvApvwtp/oAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9bH3T6iUTMKlbIaF9vTcA1GbW0Xpwk+IJMrWCecumzXrqMupmie9q+NHurtLDi5Y
	 OPZZtG1iBRik+Un9RbotFmQTcOljHV+cMBEiygXuagUoZj6lzSmqy2atmS9muOXAub
	 thzRpvU9h7wgS2VKgBaN7t3XK75FB85z5vcwhMwr98MuhwYKjevpAEkTbgDxjyLT6P
	 eInI8Mzy1v3kNZja22DoJ5Nxd22o6hxo6zrMGoRFnVSuMZL6lpaSbXb798zfhXMfYy
	 mZZlOhfzzPBhXpjoF7UxV3jQ/GgOvHC0uC1nGy0b46WmVCkAsMzKaMpdg/TyKgbSVA
	 ysTLozum+zZbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/xe: Wait on external BO kernel fences in exec IOCTL
Date: Sat,  1 Aug 2026 19:43:20 -0400
Message-ID: <20260801234320.1848118-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801234320.1848118-1-sashal@kernel.org>
References: <2026072911-surplus-properly-117b@gregkh>
 <20260801234320.1848118-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit af80e2bfde9312c76b60cf9274248dce0410b30d ]

Before arming a user job, xe_exec_ioctl() only added the VM's
dma-resv KERNEL slot as a dependency. That slot covers rebinds and
the kernel operations of the VM's private BOs, but not external BOs
(bo->vm == NULL), which carry their kernel operations (evictions,
moves, ...) in their own dma-resv KERNEL slot.

The DMA_RESV_USAGE_KERNEL slot is the cross-driver contract for
memory management operations that must complete before the BO or its
backing store may be used: any accessor is required to wait on the
KERNEL fences before touching the resv. By skipping the external BOs'
KERNEL slots, the exec path violated that contract and could schedule
a user job while a kernel operation on an external BO mapped by the VM
was still in flight, racing against it and potentially reading or
writing memory that was being moved.

Replace the VM-only dependency with an iteration over every object
locked by the exec, adding each object's KERNEL slot as a job
dependency. This covers the VM resv (rebinds and private BOs) as well
as every external BO, mirroring the drm_gpuvm_resv_add_fence() call
that later publishes the job fence to the same set of objects.
Long-running mode continues to skip this, as before.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260702215805.4011228-1-matthew.brost@intel.com
(cherry picked from commit a6b842acf3ddd1efc53a56de9260cfa718fb35e7)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_exec.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 886d03ccf744..04a88c16d835 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -270,13 +270,23 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_exec;
 	}
 
-	/* Wait behind rebinds */
+	/*
+	 * Wait behind rebinds and any kernel operations (evictions, defrag
+	 * moves, ...) on the VM and all external BOs. The VM's private BOs
+	 * carry their kernel ops in the VM dma-resv KERNEL slot, while each
+	 * external BO carries them in its own dma-resv KERNEL slot; both are
+	 * covered by iterating every object locked by the exec, mirroring the
+	 * drm_gpuvm_resv_add_fence() below.
+	 */
 	if (!xe_vm_in_lr_mode(vm)) {
-		err = xe_sched_job_add_deps(job,
-					    xe_vm_resv(vm),
-					    DMA_RESV_USAGE_KERNEL);
-		if (err)
-			goto err_put_job;
+		struct drm_gem_object *obj;
+
+		drm_exec_for_each_locked_object(exec, obj) {
+			err = xe_sched_job_add_deps(job, obj->resv,
+						    DMA_RESV_USAGE_KERNEL);
+			if (err)
+				goto err_put_job;
+		}
 	}
 
 	for (i = 0; i < num_syncs && !err; i++)
-- 
2.53.0

