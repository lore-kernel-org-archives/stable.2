Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C19381EA7
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596719; cv=none; b=O1zWoQU5wj8YfZgZrfHIegHqlMXMI3hTUuH5XKLyDYyeivVkvsDF7AsDHkbFoSgWzMcw9kFtp5cdK9Jg5iaj4cmOTLF4HDjlV7B7WJeWQtz6c3KFnGu5mzjBpNSS73XoKveUdqGT8Qrlhb6CnZaDaMQx5r9zg0Ws3Wok1X8mPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596719; c=relaxed/simple;
	bh=+Q7rgmOnBjGvoscKuocPB82Ms6NlV0sL/Adp6DIBr64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYRO6Forq/At+U4oGM4Rtgvi4qqRdjtNHQvaxHLCIRyUstqwDmFR/p51F8oNlA3naIGXa1Jy4jgAIEDu1vZV9KhFq+YCD1T3VhKTYxp4ZCoosX8Sno3N1yni51LK/XmxQxX9YI3Nuw0TrJnRKH4HR+Rq24GKmkbsWRZBOD911IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMPlR1HW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMPlR1HW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787596718; x=1819132718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Q7rgmOnBjGvoscKuocPB82Ms6NlV0sL/Adp6DIBr64=;
  b=jMPlR1HWj0W89uhoBuo3FDI7AwxER16HKxmQ3In1oy7+GOX9O/UV0yoF
   pFcQ8cIFSEPCcQDmdEh8Q6JbyPVauLFPXyosfh4wy0nTFqK7+ZdFeyV3L
   GCIMhIwkC3IROUFl1H+JSw3Ch34zxk+qpzhPGaUeYEPMe9nrgVjzmvWu8
   q7P+HMr6acxJjMQ7THfa7StIt601bgyxCZuxsM2RZPRx0UVGuYdkjVUSV
   KlQ1gPToud7XXYohfL1rrmu8K/entn9p/niYwNQGot/1Uwh2cN+Nkas1r
   Q2IXP7u1JJ/O50yc4NDXlqspwBD6mBtrw2rxsHLhL7fmCmIDYNnPzNzFR
   Q==;
X-CSE-ConnectionGUID: CZ2EQy8sTMOXipzJZrP6vg==
X-CSE-MsgGUID: zHZdG8o3T96mt/iE8mipYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99404724"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="99404724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 11:38:34 -0700
X-CSE-ConnectionGUID: i5kCid+MTD6E2q07ztRvmA==
X-CSE-MsgGUID: c2Fjy6Q5R/+23ZIVrP6ndg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="266551612"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 11:38:32 -0700
From: Jagmeet Randhawa <jagmeet.randhawa@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	Jagmeet Randhawa <jagmeet.randhawa@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH, v2] drm/xe/migrate: Bound pgtable update loops by current_op
Date: Tue, 25 Aug 2026 02:38:17 +0800
Message-ID: <20260824183816.299110-2-jagmeet.randhawa@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_vma_ops_alloc() sizes the pt_update_ops->ops array with num_ops, the
number of operations reserved, and allocates it with kmalloc_objs(), so
the entries come back uninitialized. Only the first current_op entries
are ever populated. xe_pt.c reflects this and bounds its loops by
current_op, and xe_pt_update_ops_prepare() states the invariant
explicitly:

	xe_tile_assert(tile, pt_update_ops->current_op <=
		       pt_update_ops->num_ops);

xe_migrate.c instead iterates num_ops. When fewer operations are
populated than were reserved, both the CPU and GPU page table update
paths walk past the populated entries into memory that was never
initialized, read a garbage pointer out of it and dereference it.

A syzkaller reproducer triggers this with a VM_BIND / MADVISE / VM_BIND
sequence that reserves five operations and populates two:

  UBSAN: invalid-load in drivers/gpu/drm/xe/xe_migrate.c:1836:13
  load of value 107 is not a valid value for type '_Bool'
  Oops: general protection fault, probably for non-canonical address
        0xed6d696d6d6d6d6e
  KASAN: maybe wild-memory-access in range
        [0x6b6b6b6b6b6b6b70-0x6b6b6b6b6b6b6b77]
  RIP: 0010:xe_vm_populate_pgtable+0xd0/0x380 [xe]
  Call Trace:
   xe_migrate_update_pgtables+0x32b/0x2c90 [xe]
   xe_pt_update_ops_run+0x835/0x25e0 [xe]
   ops_execute+0x691/0x2630 [xe]
   vm_bind_ioctl_ops_execute+0x46d/0x1820 [xe]
   xe_vm_bind_ioctl+0x3d5f/0x45f0 [xe]

The value 107 is 0x6b, POISON_FREE, left behind in the unpopulated
entries by the slab allocator.

Bound all five loops in xe_migrate.c by current_op so that only
populated entries are consumed.

v2:
  - Add Fixes tag, Cc stable (Matthew Brost)

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Cc: stable@vger.kernel.org
Signed-off-by: Jagmeet Randhawa <jagmeet.randhawa@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_migrate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index f79d0047bec6..6c95c51c5156 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -1827,7 +1827,7 @@ xe_migrate_update_pgtables_cpu(struct xe_migrate *m,
 			return ERR_PTR(err);
 	}
 
-	for (i = 0; i < pt_update_ops->num_ops; ++i) {
+	for (i = 0; i < pt_update_ops->current_op; ++i) {
 		const struct xe_vm_pgtable_update_op *pt_op =
 			&pt_update_ops->ops[i];
 
@@ -1873,7 +1873,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 	bool is_migrate = pt_update_ops->q == m->q;
 	bool usm = is_migrate && xe->info.has_usm;
 
-	for (i = 0; i < pt_update_ops->num_ops; ++i) {
+	for (i = 0; i < pt_update_ops->current_op; ++i) {
 		struct xe_vm_pgtable_update_op *pt_op = &pt_update_ops->ops[i];
 		struct xe_vm_pgtable_update *updates = pt_op->entries;
 
@@ -1941,7 +1941,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 			bb->cs[bb->len++] = ofs;
 			bb->cs[bb->len++] = 0; /* upper_32_bits */
 
-			for (; i < pt_update_ops->num_ops; ++i) {
+			for (; i < pt_update_ops->current_op; ++i) {
 				struct xe_vm_pgtable_update_op *pt_op =
 					&pt_update_ops->ops[i];
 				struct xe_vm_pgtable_update *updates = pt_op->entries;
@@ -1978,7 +1978,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 
 		addr = xe_migrate_vm_addr(ppgtt_ofs, 0) +
 			(page_ofs / sizeof(u64)) * XE_PAGE_SIZE;
-		for (i = 0; i < pt_update_ops->num_ops; ++i) {
+		for (i = 0; i < pt_update_ops->current_op; ++i) {
 			struct xe_vm_pgtable_update_op *pt_op =
 				&pt_update_ops->ops[i];
 			struct xe_vm_pgtable_update *updates = pt_op->entries;
@@ -1996,7 +1996,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
 		update_idx = bb->len;
 
-		for (i = 0; i < pt_update_ops->num_ops; ++i) {
+		for (i = 0; i < pt_update_ops->current_op; ++i) {
 			struct xe_vm_pgtable_update_op *pt_op =
 				&pt_update_ops->ops[i];
 			struct xe_vm_pgtable_update *updates = pt_op->entries;
-- 
2.53.0

