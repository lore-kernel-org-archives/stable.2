Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FD264F80
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323374; cv=none; b=uag017/CP3nLnWxzJigWD8TTVwTaCQ7ZqaWZkvIt5qsRag0qLXWh/fKK/h+L7VANFNduOLfMtrsEQ0XDPlQPZFUHCSfxyMp6P2pdnuMC/G9pDJ808Kn2W49FmMwPgXrhR80y3+LmJVbP+Ag7gx+w4M+oGL80j46MtmGiWd4YWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323374; c=relaxed/simple;
	bh=Z96Q4RrzAilkOWD+n29fmkyLpZMkRkdChnqslhA7opI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qMsRC0uT28Nr8upQCyGV7AHc1cck9UK+oh60Pzj9jEfl9qkQJ8QBZ58Je0Kw73HgBAt3AYptEBcASlT4liABdoohFlxVFiOJ3+7zT16SstRW27rjU1rvPpJFQkVjVEtO/etU/fVX60lWWy/5i/Xn7fV5Vt11K4Eay0Ppzms0Dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZ5iNPVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZ5iNPVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234EE1F000E9;
	Wed, 29 Jul 2026 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323372;
	bh=iq4R+f3qfGsqPpzZSShwzHgTrxylROwaEjEza4XkcNo=;
	h=Subject:To:Cc:From:Date;
	b=yZ5iNPVyBLJtCodzhICjSgsCwZF3PdIsWDYHEb8jzzY4ypqcKN2z3rI6tVyoPZWH5
	 xrP04Clf+inco3F/XS8K5fitL6zbRla5cJ9Bo0buLGtZavlz9VjN0+PyWcc4eyEV78
	 YaGZEZlwxGeHbChJTqmw5XurxNbsTbC4FapVEmus=
Subject: FAILED: patch "[PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL" failed to apply to 6.12-stable tree
To: matthew.brost@intel.com,matthew.auld@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:09:11 +0200
Message-ID: <2026072911-surplus-properly-117b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x af80e2bfde9312c76b60cf9274248dce0410b30d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072911-surplus-properly-117b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

