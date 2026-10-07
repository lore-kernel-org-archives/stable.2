Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FC3783BE
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387425; cv=none; b=RlrcvtZ3zxsZt7U8MI9ACTZ9GI4m7DuugHXumdW4aYHzqrm3Mhg6yHzGqn9/1GBHrtYV01KnhM3qglKsZwmjNsOGsbEn8ermaV+IrVyWCjUdHRRtrvLjk95Ap2o6QCqdCp8fP8sYqhcd6kVHt6aO6308ZCcH8hYIWMhj2sagyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387425; c=relaxed/simple;
	bh=oqGquNhYv9lBDrIUsGR2l/ExzkE8Y5cxEfGHv0t5gT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRw0mSrU9+lF4gviyQ8xt76EH/7QJdhjRESa02SHhEnv/K/JusNkpdzg1L2NGt6eQWTCjIBQcUqlHEL4e1nkXBOkO+COIx+HPrhzGW1V0pvhafk1vMNPhsnYPX3DsYbvFEIAbmgEPrkmq4TVoAi/N9Nj9+K6q8Nj4xPvqO8S8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5IeN6XY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5IeN6XY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791387411; x=1822923411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqGquNhYv9lBDrIUsGR2l/ExzkE8Y5cxEfGHv0t5gT0=;
  b=D5IeN6XY/qWhRLvkt6s4f+2vccqTjS+dNRuGtBzCgjXU4aJ1fl5WAmE2
   bQbNvK6Dl4dnh8lUiTYYSLQobShs/Nruf2kr80G4DbCkZrrRqjHe3z5zi
   yxiBAwEkmNKPGSnwHQEBFq0NbS04SktmMRrMuAf1RU8jWg+uPqukr5M+x
   tnjU1hIpOZpZ7Em46ozTCYzUpodqpKMIjJdn3c/6tmrhS3oiijRhl6qzg
   JRRRRuYO4STzCOJRdru0w3cn+Uy2bAeAd51eZMcvhBw1Ya0ikimY3ewqW
   KP//49sTuV9M/N1DeFxA7lUww18gJdjd/BSVd4/FxVpguc7ZSGqrBvhMV
   Q==;
X-CSE-ConnectionGUID: kRP7uRcuR3WLW1RvjkpRGQ==
X-CSE-MsgGUID: lumo1RZuRhibHKhJhG2D6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="148786"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="148786"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:36:50 -0700
X-CSE-ConnectionGUID: 5OJabNkRT2qCbxQDkXX9Ow==
X-CSE-MsgGUID: DRpgFUUsTl2EH1lnGPAQqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="277583533"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.246])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:36:49 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/xe/vm: make PREFETCH to TT sticky
Date: Wed,  7 Oct 2026 16:36:08 +0100
Message-ID: <20261007153605.1743626-7-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007153605.1743626-5-matthew.auld@intel.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When userspace explicitly requests DRM_XE_VM_BIND_OP_PREFETCH to system
memory (XE_PL_TT), xe_bo_migrate() moves the buffer object to TT.
However, because XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in the
buffer's default placement (introduced in commit 5c87fee3c96c ("drm/xe:
Attempt to bring bos back to VRAM after eviction")), any subsequent
validation during exec immediately migrates the buffer back to VRAM,
completely undoing the userspace prefetch request.

Use xe_bo_migrate_tt_sticky() when prefetching to XE_PL_TT so that the
buffer remains resident in system memory across subsequent validations.

Assisted-by: LLM
Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after eviction")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index ef369df4aa26..093ad3e39608 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3428,7 +3428,10 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 				mem_type = region_to_mem_type[region];
 			}
 
-			err = xe_bo_migrate(bo, mem_type, NULL, exec);
+			if (mem_type == XE_PL_TT)
+				err = xe_bo_migrate_tt_sticky(bo, NULL, exec);
+			else
+				err = xe_bo_migrate(bo, mem_type, NULL, exec);
 		}
 		break;
 	}
-- 
2.55.0

