Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680742F6FF
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071477; cv=none; b=uRjJ7VkCRhE8+liZjzt2Zyrf4f/qVuza/r3tu9e0A/Ht8gLpwjpFwblPoEl8NIJD35ujYUyYSv0cliHHn0kbGH6W2YVI/HCUeMeBWjb7+siZnRYPUhp1eedFQEPOjKa8LT2VHKMqWw6SDZ57nmzdrulo71mzPwq/ZymJ/bARp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071477; c=relaxed/simple;
	bh=KV57zEaBOQEPvFv/X/GjFa0YhFxJlImTSEAGcrrXJuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAGr2jyyoVVE7v7jzMityA7lN2wVCY7lxcgm8PrTdCYPygronT1zNvCVATpiWs0N186OMwOKCL2MwYq+0l5jOGe1FyBXWeGbhKsKcsWR5LLoed55lOyIo+/ZI5YtxV6YlNHsfspa9gly42zR1dMk4DDdsLQULc1UsmQgw4yk1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/PNCdo2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/PNCdo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784071475; x=1815607475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KV57zEaBOQEPvFv/X/GjFa0YhFxJlImTSEAGcrrXJuI=;
  b=T/PNCdo2wVC2SEchBegU8pWrEqy0JieKXf7LMl5XrQhPFLxqLM+8UT6q
   LRxIzFYpYTkef8OHjqsYOqyKNe3FhjMK0NsFAPwn7R6iQ0OlijkzO05pR
   IdETNmlnrgWwG2l3E/UWwx8S7bd5+yldYnU2+nB0cYzXx71PD1NeVecH8
   514M7n2cK5c/3k5NJWtTkGBC7QSgeGJ+3XP42Ln7H9gx1aCyu8DrbxKl7
   yzci4nstb40QNADYHxTmEuxV2kArqk2vctZcBfasCgs9TeZ0xtWR9hDE+
   3PmlV/gPeWTd7MEqknq+CeVd91EmvqWz4UrWVu0aMvQIw7kikjIf/4dxN
   w==;
X-CSE-ConnectionGUID: UxUC5aDqTf6T9LOwqsFXYg==
X-CSE-MsgGUID: OZwlz/lTSEGl810bH3qz+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83826292"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="83826292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 16:24:34 -0700
X-CSE-ConnectionGUID: kGqiNYYeTuWawuXXGmMlPw==
X-CSE-MsgGUID: KhnYWDRcSfy3Yfm3Cig86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259573795"
Received: from dut4072bmgfrd.fm.intel.com ([10.105.8.119])
  by orviesa003.jf.intel.com with ESMTP; 14 Jul 2026 16:24:35 -0700
From: Zongyao Bai <zongyao.bai@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	Zongyao Bai <zongyao.bai@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
Date: Tue, 14 Jul 2026 23:24:32 +0000
Message-ID: <20260714232433.2737533-1-zongyao.bai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713230830.2662760-1-zongyao.bai@intel.com>
References: <20260713230830.2662760-1-zongyao.bai@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_pt_update_ops_init() fails to reset current_op to 0. On the
vm_bind path, ops_execute() calls xe_pt_update_ops_prepare() inside
the xe_validation_guard() / drm_exec_until_all_locked() loop. When
that loop retries due to lock contention or OOM eviction
(drm_exec_retry_on_contention() / xe_validation_retry_on_oom()),
xe_pt_update_ops_prepare() runs again on the same vops, and each
call to bind_op_prepare() increments current_op without resetting it.

After N retries current_op exceeds the array size allocated by
xe_vma_ops_alloc(), causing an out-of-bounds write into
SLUB-poisoned memory and a subsequent UAF crash in
xe_migrate_update_pgtables_cpu() when reading the corrupted pt_op->bind.

Also reset needs_svm_lock and needs_invalidation which are derived in
the same prepare pass and would otherwise cause wrong migrate ops
selection and redundant TLB invalidation on retry.

Fix this by resetting current_op, needs_svm_lock and needs_invalidation
in xe_pt_update_ops_init().

v2 (Matt):
   - Add details in commit message.
   - Add Fixes tag and Cc to stable@vger.kernel.org

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-sonnet-4.6
Signed-off-by: Zongyao Bai <zongyao.bai@intel.com>
---
 drivers/gpu/drm/xe/xe_pt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index e466f714bf86..598c6b2571e7 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -2371,8 +2371,11 @@ static void
 xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
 {
 	init_llist_head(&pt_update_ops->deferred);
+	pt_update_ops->current_op = 0;
 	pt_update_ops->start = ~0x0ull;
 	pt_update_ops->last = 0x0ull;
+	pt_update_ops->needs_svm_lock = false;
+	pt_update_ops->needs_invalidation = false;
 	xe_page_reclaim_list_init(&pt_update_ops->prl);
 }
 
-- 
2.43.0

