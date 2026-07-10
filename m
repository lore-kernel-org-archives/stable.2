Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66ED21B191
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649837; cv=none; b=ZZklk1Lzutb5eaNji/5esFoDjZBFUeD33HKJkayfD/tdqiRiAunRG3N+62NWqk1uS+FZNkU+5OWs8jVWw+JPqs9qZvGFVvL975gvb4FgO7MznI1H6Ub2CIEkYsGYLSeb7PDtRKCScsn4O+nOfDIWUyWvbEkN8+J3Gep9wIM8SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649837; c=relaxed/simple;
	bh=uv8d1TMBC+ZVQf88DxS2mqMPDYx3jXWrpDqSm/tuHcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGNT0wCNJ1hOyvX9M6qIpvJstsvhTvBRejv7Ziwo/bPWFBd/GSOccO2WW6zNBc8BFIBQeWMooRlJLq0CugIFMaO5qkR4cHXuYhZQkDnN/0RAja+WZPxd3bufdXsu26YWiSh3qCjLG3cPtd9kMfLt9/P8JTGkGccr6dmFw11OPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcMitfl3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcMitfl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783649835; x=1815185835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uv8d1TMBC+ZVQf88DxS2mqMPDYx3jXWrpDqSm/tuHcE=;
  b=UcMitfl3rUw4SczCz2euaifheGfkfomwBB1SwcH+6eKAyQBleUb/h/7/
   eKuhrzvpryj6pkyOIALA0LVpyokwF4mXxueTlFjPF7vGF1K7ml6i6q8Xx
   UEfXjH3uLZYHtlWoP+oF3joPRzEHfkLjAhDj8XhoN4hO6gYzJjxYMalJl
   XHfUGfl9SUKYTfhkDGz0M5l0SqVRHUWIfTGgeC3mM0FEwV6pSAAywvnEb
   vkWuSmq8SbDX8Pvnf9pmku35ODMRh03fS4ycqfUng5QxcfXLs/uKa4CN1
   +4mX0a4slRJUdbsCKX1G4twl1KFTikVB/XfRPd8r0YaN2JMF/CPgyndDp
   Q==;
X-CSE-ConnectionGUID: AMnBmtDCTbm9ujqnx/Y9Iw==
X-CSE-MsgGUID: EyBeN6Y+StyVoIc+gZqIgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107146194"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107146194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:17:14 -0700
X-CSE-ConnectionGUID: qoBkzzXgRTu9Fg1VF3lQ6g==
X-CSE-MsgGUID: 6oIJe+y3SRKFCqop2Rjhpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253647476"
Received: from osgcshtiger.sh.intel.com ([10.239.81.49])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2026 19:17:13 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/vm: Reject invalid prefetch region for non-SVM VMA
Date: Fri, 10 Jul 2026 02:17:00 +0000
Message-Id: <20260710021700.3611909-1-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC (-1) is only valid on a
CPU-address-mirror (SVM) VMA. On a regular VMA the value is used as
an index into region_to_mem_type[], causing an out-of-bounds access:

  UBSAN: array-index-out-of-bounds in drivers/gpu/drm/xe/xe_vm.c:3260:28
  index 4294967295 is out of range for type 'u32 [3]'
  Call Trace:
   __ubsan_handle_out_of_bounds+0xa7/0xf0
   vm_bind_ioctl_ops_execute+0x9b0/0x9d0 [xe]
   xe_vm_bind_ioctl+0x19f1/0x1b10 [xe]

Three related changes:

- vm_bind_ioctl_ops_create(): For a non-CPU-address-mirror VMA, reject
  both DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC and out-of-range prefetch
  regions with -EINVAL. This is the primary fix for the OOB.

- op_lock_and_prep(): Tighten the xe_assert() to
  'region < ARRAY_SIZE(region_to_mem_type)'. The
  DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC exemption is no longer needed
  since the value is rejected earlier, and '<=' was an off-by-one
  bound (valid indices are 0..ARRAY_SIZE-1).

- xe_drm.h: Document the CPU-address-mirror constraint on the
  DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC UAPI value.

Fixes: c1bb69a2e8e2 ("drm/xe/svm: Consult madvise preferred location in prefetch")
Assisted-by: Claude:claude-opus-4.7
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++--
 include/uapi/drm/xe_drm.h  |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 080c2fff0e95..9430b2be18e4 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2495,6 +2495,15 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
 			u32 i;
 
 			if (!xe_vma_is_cpu_addr_mirror(vma)) {
+				if (XE_IOCTL_DBG(vm->xe,
+						 prefetch_region ==
+						 DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC) ||
+				    XE_IOCTL_DBG(vm->xe,
+						 prefetch_region >=
+						 ARRAY_SIZE(region_to_mem_type))) {
+					err = -EINVAL;
+					goto unwind_prefetch_ops;
+				}
 				op->prefetch.region = prefetch_region;
 				break;
 			}
@@ -3236,8 +3245,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		if (!xe_vma_is_cpu_addr_mirror(vma)) {
 			region = op->prefetch.region;
-			xe_assert(vm->xe, region == DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC ||
-				  region <= ARRAY_SIZE(region_to_mem_type));
+			xe_assert(vm->xe, region < ARRAY_SIZE(region_to_mem_type));
 		}
 
 		/*
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 509202a7b13e..e159c44e380a 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1075,7 +1075,9 @@ struct drm_xe_vm_destroy {
  *
  * The @prefetch_mem_region_instance for %DRM_XE_VM_BIND_OP_PREFETCH can also be:
  *  - %DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC, which ensures prefetching occurs in
- *    the memory region advised by madvise.
+ *    the memory region advised by madvise. Only valid when the target VMA
+ *    was created with %DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR; rejected with
+ *    -EINVAL otherwise.
  */
 struct drm_xe_vm_bind_op {
 	/** @extensions: Pointer to the first extension struct, if any */
-- 
2.43.0

