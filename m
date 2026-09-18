Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AF3B774A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737054; cv=none; b=g1PmWzeZBDHT9NLYMiX7hoTvq6a8xs7XtV4TX4wd02JEuIsJf8r0KFUEwTM8+UIEPLfM0iW9fcj6O2MflOI/+JP/7hNSdwz7AKirDol9FvOPJnW6n9Rglc7aRPNZLOKxJZ+S7mHhSJV0roW0c6iw5/6r9ZCpmA5JDOx9DhWZ1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737054; c=relaxed/simple;
	bh=08s0nUfFfgFtWNY0epk5/ASsmlssl/l5/0UOkn4p6qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pbxhA494alppZDBbTNH+ggJmxWu9BcxcjWdxaRXu6LoBMvU9FUL50TcHKmTZUJFHWn7u3WxH42hgpPJaMPfrvC88GCwLGqIpiMcZRIsy5co8Zp5oMwNhnrN3+5xYk5DfO4AbrwgBfuWkCcrMKCOwOsoBhOk6ASVVRY8YQgzYPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO7Uwvo6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO7Uwvo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789737048; x=1821273048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=08s0nUfFfgFtWNY0epk5/ASsmlssl/l5/0UOkn4p6qI=;
  b=gO7Uwvo6YQelrc+9pL3cB2XB33rFP85GIYqupogSozm13tlm4xOf5ebs
   XJZ5RfJFVXVVT3SQQgZD5LqQ1HtHRu1WIdUlU8/shvJHWHwoOOynAESCw
   J1npyOnVKpLwymLsUfi2PT1TcdFxM/Ou3kDQCqH1fF8ffIFDgvCIL30yk
   kgl8eJPDZ6eigWkl/ltifznsW0X1RSK3GSf4/AyfqtF73RBiZmlHsMj2F
   +aI0UK9YOSZjiCibCjFREvhlC30HY821jPZIF5sFy7S2LXKOUb0Xhx8Tn
   A3pbESHSSAbJk0x2J1NyH+UJAHi1/TuM8xcfCqT2lvR6Gpv68ScIzGvbX
   w==;
X-CSE-ConnectionGUID: BYcjVF65RYWxs33xY0zkdw==
X-CSE-MsgGUID: KR9jxDyzSpK8whAr/Z6AtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100838059"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="100838059"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:10:44 -0700
X-CSE-ConnectionGUID: rALQkDELTAmNXPg8949eiQ==
X-CSE-MsgGUID: t9gwWTIhQwebCwz6s1hakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270709239"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:10:42 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs
Date: Fri, 18 Sep 2026 14:10:35 +0100
Message-ID: <20260918131034.598078-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
---
 drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 17dc4debe7c1..390da884c727 100644
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
2.55.0

