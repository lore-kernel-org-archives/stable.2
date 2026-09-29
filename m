Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA53C73C9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670326; cv=none; b=MsmfOjZkOeMjq/sybxoNnpQibE5ywbUAxAM50e+pdhg3fju5/wJ7FOThutZfVuKamAu+eGh0hyaRLspghMXdlqvR9JPKytWmarTVmG/eiJjfU4p84WK0zR5n1a5kS50LnFVMlqKVbwIgFlgXpkJ/b2CV/KrkbL5oWz2KzBoMHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670326; c=relaxed/simple;
	bh=vHF5jRf+IKg1Mzky2nlY+oEWXRmqbH9G6gXhQdcMUSE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UTsKjctTsgPqfqR71QY3QAf3bvNQHwdfGPgjvUNMoQIAlFp8r7EpeQcpn0AcN68Iu1i3wpJmsq4Iq1w5iJl2KMv3IH/9WeQC2+CzAyza31ooAILbCw+mlJF0XGGc+5FD0PvP//3nQiWYVDVGQdoUhGX0MPy4gGl0xzFK4wYu41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SANPR6c3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SANPR6c3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B251F000FF;
	Tue, 29 Sep 2026 08:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670324;
	bh=FX7gb7tu4Lyq402RrexTo1lEP/mg38aBzgfGlYkjaL0=;
	h=Subject:To:Cc:From:Date;
	b=SANPR6c3barEtkTVu431Ht4NgLhNZiVWXKw6zSswU95UtnKVU2kz/rp9DZedc+WhE
	 9jnrx/Z8t4pXvbaJVHZPi6GeY9G27wHdviPWpX99xcm9A1hF0XGokYX3j778itTshW
	 SJWAD+GJWcRh5rJz0PyhzhPymxYtcFwII/jkMM8o=
Subject: FAILED: patch "[PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs" failed to apply to 6.12-stable tree
To: matthew.auld@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:25:19 +0200
Message-ID: <2026092919-qualm-steadily-7858@gregkh>
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
git cherry-pick -x 24a22fb3c731474b68e986af6804db450fb88617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092919-qualm-steadily-7858@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24a22fb3c731474b68e986af6804db450fb88617 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 18 Sep 2026 14:10:35 +0100
Subject: [PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In xe_vm_close_and_put(), external-BO VMAs are queued on the contested
list for deferred destruction via xe_vma_destroy_unlocked(). However,
xe_vm_pt_destroy() was previously invoked before processing contested
VMAs, destroying vm->pt_root while those VMAs were still linked to their
respective buffer objects (vm_bo->list.gpuva).

If a concurrent thread evicts one of those shared buffer objects,
xe_bo_trigger_rebind() holding only bo->resv walks the BO's VMAs and, in
fault mode, calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(). Because
vm->pt_root[tile->id] is already NULL, dereferencing pt->level causes a
NULL ptr deref.

Fix this by deferring xe_vm_free_scratch() and xe_vm_pt_destroy() until
after all contested VMAs have been unlinked and destroyed.

User is reporting hitting a NULL ptr deref in xe_pt_zap_ptes(), which
could be explained by this race.

Assisted-by: LLM
Fixes: b06d47be7c83 ("drm/xe: Port Xe to GPUVA")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9290
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260918131034.598078-2-matthew.auld@intel.com
(cherry picked from commit c2863648959489767f08892fd6e90577d2ea0b6a)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 23952ad8951e..ef20e205a734 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1947,21 +1947,13 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		vma->gpuva.flags |= XE_VMA_DESTROYED;
 	}
 
-	/*
-	 * All vm operations will add shared fences to resv.
-	 * The only exception is eviction for a shared object,
-	 * but even so, the unbind when evicted would still
-	 * install a fence to resv. Hence it's safe to
-	 * destroy the pagetables immediately.
-	 */
-	xe_vm_free_scratch(vm);
-	xe_vm_pt_destroy(vm);
 	xe_vm_unlock(vm);
 
 	/*
-	 * VM is now dead, cannot re-add nodes to vm->vmas if it's NULL
-	 * Since we hold a refcount to the bo, we can remove and free
-	 * the members safely without locking.
+	 * Unlink and destroy all contested external-BO VMAs before destroying
+	 * the page tables. Otherwise, concurrent eviction holding only bo->resv
+	 * can walk the BO's VMAs and attempt to invalidate/zap page tables that
+	 * have already been freed.
 	 */
 	list_for_each_entry_safe(vma, next_vma, &contested,
 				 combined_links.destroy) {
@@ -1969,6 +1961,11 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		xe_vma_destroy_unlocked(vma);
 	}
 
+	xe_vm_lock(vm, false);
+	xe_vm_free_scratch(vm);
+	xe_vm_pt_destroy(vm);
+	xe_vm_unlock(vm);
+
 	xe_svm_fini(vm);
 
 	up_write(&vm->lock);

