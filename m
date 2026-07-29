Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2846A617
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323531; cv=none; b=ti9QvA+RUz4jquqGA9LZ5VILIWVxFBEgB9A39/zOiEh4MiQfcSJyOtN972D9zuN9OZu5WNVsSUS+rzrR5hqz1WtIVO0uamd5vD5Gtjr6V0cw7dF/MtqFkFls+cKiPw/J2GqI4EjqRvQ/URgnxWqqIcicFC1L6MgtrSJBdHCY/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323531; c=relaxed/simple;
	bh=hl/LvZCrvnvVth/eGPrCClKcFGz2io+1hzTb6eCkC9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=toEFh78VJ5YqhHl1v0q0RAb7GYp2Yibq97D0YRqghDcl1VCkJmVqV9D1GS7Bx9ZHiF12VkiciKMgM6lzHvv2AKieG7fAwO+uT8BDhkrSHo+KQssyuemoFXmcyyF9iS9wa9iIhC0ccnzsAYV0rN48mFLAv6bBjWbqrh7sGvDo8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJtoh3/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJtoh3/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A685B1F000E9;
	Wed, 29 Jul 2026 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323530;
	bh=1Hk2ePptn3+dZ/3kHUmWt16lPU8YNc9ljQnrf9lEVj0=;
	h=Subject:To:Cc:From:Date;
	b=AJtoh3/xiG0UfUs/wyxvBHWipgN2X2xRUxOGShwYt3G3D97U73EIgZdqjvYvVnd6q
	 NHxM2YpUEe7Vdmw0jkz1v/4u7bJU2wIJdPFstYO2UIBAD635tN2s8JttmEGi5fKQd3
	 zLrMOYVp0QzN2uiU/U1+WU59pASuM3MTkK9WsfuI=
Subject: FAILED: patch "[PATCH] drm/xe/madvise: Skip invalidation for purgeable state updates" failed to apply to 6.18-stable tree
To: arvind.yadav@intel.com,himal.prasad.ghimiray@intel.com,matthew.brost@intel.com,stable@vger.kernel.org,tejas.upadhyay@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:11:56 +0200
Message-ID: <2026072956-shy-compare-d895@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 57441577bac3637473da2c9644336eaa0ac5732f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072956-shy-compare-d895@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57441577bac3637473da2c9644336eaa0ac5732f Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav@intel.com>
Date: Tue, 26 May 2026 19:24:47 +0530
Subject: [PATCH] drm/xe/madvise: Skip invalidation for purgeable state updates
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Purgeable state updates only change VMA/BO metadata. They do not zap
PTEs when switching between DONTNEED and WILLNEED. PTEs are zapped
later if the BO is actually purged.

xe_vm_invalidate_madvise_range() waits on the VM dma-resv before checking
vma->skip_invalidation. Since purgeable madvise marks all affected VMAs to
skip invalidation, this wait is unnecessary and can stall on unrelated
in-flight work.

Skip the invalidate path entirely for purgeable state updates.

v2:
  - Replace inline 'args->type != DRM_XE_VMA_ATTR_PURGEABLE_STATE'
    check with a small helper madvise_range_needs_invalidation().
    (Himal)

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patch.msgid.link/20260526135447.2973029-1-arvind.yadav@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Cc: <stable@vger.kernel.org> # v6.18+
(cherry picked from commit 134377098b9c14abd31c3bcac00c9653f0f0c4c3)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index 246fe1843142..0474768a38aa 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -332,6 +332,20 @@ static int xe_vm_invalidate_madvise_range(struct xe_vm *vm, u64 start, u64 end)
 	return err;
 }
 
+/**
+ * madvise_range_needs_invalidation() - Check whether madvise needs invalidation
+ * @args: madvise ioctl arguments
+ *
+ * Purgeable state updates only touch VMA/BO metadata. PTEs stay valid and are
+ * zapped only if the BO is later purged.
+ *
+ * Return: true when the update needs PTE invalidation.
+ */
+static bool madvise_range_needs_invalidation(const struct drm_xe_madvise *args)
+{
+	return args->type != DRM_XE_VMA_ATTR_PURGEABLE_STATE;
+}
+
 static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madvise *args)
 {
 	if (XE_IOCTL_DBG(xe, !args))
@@ -708,8 +722,9 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	madvise_funcs[attr_type](xe, vm, madvise_range.vmas, madvise_range.num_vmas, args,
 				 &details);
 
-	err = xe_vm_invalidate_madvise_range(vm, madvise_range.addr,
-					     madvise_range.addr + args->range);
+	if (madvise_range_needs_invalidation(args))
+		err = xe_vm_invalidate_madvise_range(vm, madvise_range.addr,
+						     madvise_range.addr + args->range);
 
 	if (madvise_range.has_svm_userptr_vmas)
 		xe_svm_notifier_unlock(vm);

