Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E558449ECB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323365; cv=none; b=QxagkkMOJVDAFWNZcDY21zllfJJ5jBqzzbKHErOKv1vxkir4TzBBbh4gcWbCBRCZho9ZANHmWbZG0GrQuHk32lA0Aiz7DUWzO9Dj/UeO9Pnxq1oos27pJgp6ZKdhMQCs4xPoXqlS9UzcTXqNu6EdqLnat2kmzH3fQgFQBj0p2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323365; c=relaxed/simple;
	bh=PO1phzpNONo5gBVoKuIHxwAV9lgOMiBVvFhy0AaGrOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CdWO/lSTVbpOsOMKtvd+3LKb0FbkHKfOs0X6i8WAEZdLmiSnx2eYHFdurHLTVvizNEMVdDvbpIUKyrSVLcaqpY9QbcilC/JbJsDUEXDXnlp5wgHfjZPlz8kPODuRUQTPy9TvI78zaGmWdBtyp1YGMrpf0VJyb6GCbkibP0Cyw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vcXQohq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vcXQohq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25401F000E9;
	Wed, 29 Jul 2026 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323364;
	bh=HTOD0QdW+dDRC//fDUxl+eXy3RyQdtniTu6MAyiPNmc=;
	h=Subject:To:Cc:From:Date;
	b=vcXQohq5+q2e4KJxEnKFewd33NlzCP9os5TYtVFZbYRah01baRq9ajy+h5TH396ZD
	 tiWbr3YCI+oT1bkWpzna9vRIQ/han4wQPZ+XT9MYjLu9NSl7VGh6B4cnlu6gnEuCt7
	 tfyXjT278GUWM4KI6EF2R15imLn9O4DotbW5RbA0=
Subject: FAILED: patch "[PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL" failed to apply to 7.1-stable tree
To: matthew.brost@intel.com,matthew.auld@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:09:10 +0200
Message-ID: <2026072910-croon-outlet-91f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x af80e2bfde9312c76b60cf9274248dce0410b30d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072910-croon-outlet-91f2@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af80e2bfde9312c76b60cf9274248dce0410b30d Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 2 Jul 2026 14:58:05 -0700
Subject: [PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index e05dabfcd43c..d5293bc33a67 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -292,13 +292,23 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
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

