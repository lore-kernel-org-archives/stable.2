Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045812;
	b=lGV50FEopwVx/ZAUGZnZ+BXh1WlS3HuQMura/HKSip02lGIvnQV+TaIHqpgTDe3oeA1Y
	 9UR2cFZHjnOpG9Pg8OnpwVDYnxvdwLuL2zgnxETwa2h0HA9hEli0um6AkbW61+Z/hb6YP
	 y52qsHj7ur/0grYn94nnY52NumKTLFLx9d/JNhapCtP1SczjgHT5vOnrXs8TW00LF42IX
	 n2fF7ugGshozG2eTPVR16zSvM0mLmrwKMzOHbHmvmd2RanfZ3/4s81hMInpFQ9nS4p/LL
	 DnwJvdIayA3Fprl4Ak9gHbnPEG2L2uCOnYDbaScmhAvt7qJ70OrQff0AMdPu/Xj3RCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045812;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TCZ6qA3TyAiqwGHgA4jPdcFAEDJMFwP4TyiIavt6za8=;
	b=rYfaT14si1J3Vtls5+imkdEBhr7pSqH49dr8n4EGhh/KxycDV7P/t4nvoQYQe1cZSOYH
	 f/UkNHY4FbpY7kE/ye8Ivn+4tQw4wayxYBvfODgsI/+VR1ICZfOqf0qYa37ZyRQmhk/dc
	 8rcXU1a0fm1quYJe6m+kwmdSh2CgXDG9CZbp5r0282Co9C5mk4RbDAseTXg/OuK56hUH4
	 57JmaaEUIk336LudKnxOWj6LPe0uQf3egJ1mlgR4W/IILEXj3M7P+blHg0FLulqOws/ky
	 EOCTNocZhZx08gHSjpAExJk9JLu/T9LcnNIFo+5eLaojYTtpbH6fmGFd7XtLAbkVzwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmGdjJPt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F1606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmGdjJPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830A91F0089F;
	Sat,  7 Nov 2026 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045812;
	bh=TCZ6qA3TyAiqwGHgA4jPdcFAEDJMFwP4TyiIavt6za8=;
	h=From:To:Cc:Subject:Date;
	b=gmGdjJPtLHb53nla5UAOMv4xH9Abf/Bf36SSqo2f79ZQbqjDrUEpcmtQ/CJTXWEpU
	 1rZd1crIBrc63CJBPT/tzIx/vLrVd4GnsNVUHsMsZPW92t02zaC3pUfakX2mVK7BE2
	 RFQyv4y/SUGLJOkb9WkTDGBqMwHG4FC6fXLAGY1gw3uIwL5ZTNJ09mKR8pGQyDVLRv
	 2XJKhSc6Kw/XHGiPjyt6b70cAturln3JejueJor3ZyNY9iFbfgwpxNxDRGHQJBt9dR
	 R/JExYp4h/Inb1LempHCpAgG5hXt4HU2YkB4PO7HvtWiBWilNJga7goeX2OS9Qv3fp
	 blg6/IL5X90ng==
From: Sasha Levin <sashal@kernel.org>
To: matthew.auld@intel.com,
	thomas.hellstrom@linux.intel.com,
	matthew.brost@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:30 -0500
Message-ID: <20261107050330-failed-7.3-c28636489594@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x c2863648959489767f08892fd6e90577d2ea0b6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050330-failed-7.3-c28636489594@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c2863648959489767f08892fd6e90577d2ea0b6a Mon Sep 17 00:00:00 2001
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
---
 drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 6b793ef31537f..64a1d27eccb62 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1979,21 +1979,13 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
@@ -2001,6 +1993,11 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		xe_vma_destroy_unlocked(vma);
 	}
 
+	xe_vm_lock(vm, false);
+	xe_vm_free_scratch(vm);
+	xe_vm_pt_destroy(vm);
+	xe_vm_unlock(vm);
+
 	xe_svm_fini(vm);
 
 	up_write(&vm->lock);
-- 
2.53.0




