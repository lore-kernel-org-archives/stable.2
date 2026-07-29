Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239839792D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335892; cv=none; b=ER9h1K4JJRt9aX1NKrL/b1nPycfvQcBBY3RpneAIEz/yVo8j0GpNh/pi9uNdKlTtoQEJ5qKjVmtRd2B3Z33wG7X+0iRGAkhnHNy7K9VlHf3EtkI2eGvi549mCuSd0ZgFRBcZSa4e9Jzdfxb9EB0NRMySRekpxLmnewSkXXA31qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335892; c=relaxed/simple;
	bh=crpU8/ryFZF2OEhZ8cRAVjVjAfWir/TzdNA/Mv1+UZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl4mUYiMO7r8yyuH8L/ogrCUshvMrlVlDf91OxubMjzZ4d8fwGQxtc5WSULJJiq/B9bei5asmLFYWvHhuxOx1t9Qt2TuVOruJTlRSor/c6j3f2Fk997RG5h+Rhdtz5xszvQOZvspkvxAL5PZJc7aTFI8/W+jh+v3iaiRtMw/kYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTXTPCus; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTXTPCus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785335887; x=1816871887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crpU8/ryFZF2OEhZ8cRAVjVjAfWir/TzdNA/Mv1+UZg=;
  b=WTXTPCuszcRbbbg4/5r0p4IxRJOOCrKpkMiMhsf4hbo3Q5NwX5d/NX2o
   gz42ZfhPWXXEunO6SgOBCTICxm19tzTz2g3okI5pmBH9m66VhGgnBLdU3
   pBM6RSs9R1WxzsW0XlPn21LNGoFm7+Vx7ed2gTz7T11PILGTc/3BipUfM
   EqP0GE67I6Bl2v/7Zb2/Bc1lTThMybW4M9gzFEDM7bj0tvToAKhJ7gM00
   QSzaZEEggeXM21LWx7zsC6GZtPq1NQ7RdXRGaC5GlxWpSF8x8xD8lbMTv
   8EW8uBm5GkYECxR8f3hXo+u30Oyp+VmktW1vMaSYeHqZ7avVnpbXl19lY
   g==;
X-CSE-ConnectionGUID: Ui3x/0MZQmKpvTuMa8K+lw==
X-CSE-MsgGUID: QKd8o8MvRY6dVB0/gtefDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97455341"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="97455341"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:38:04 -0700
X-CSE-ConnectionGUID: 0WirsqYwQB+EJ/sXVEybUw==
X-CSE-MsgGUID: BdBXoyxXRmm3gW9dzWzVHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="265058137"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.54])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jul 2026 07:38:04 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 6.18.y] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Wed, 29 Jul 2026 14:37:59 +0000
Message-ID: <20260729143759.152317-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072910-darkroom-avenue-7ff8@gregkh>
References: <2026072910-darkroom-avenue-7ff8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation in xe_vm_bind_ioctl() to reject PAT indices
with XE_COH_NONE coherency mode when used with
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.

CPU address mirror mappings use system memory that is CPU
cached, which makes them incompatible with COH_NONE PAT
indices. Allowing COH_NONE with CPU cached buffers is a
security risk, as the GPU may bypass CPU caches and read
stale sensitive data from DRAM.

Although CPU_ADDR_MIRROR does not create an immediate
mapping, the backing system memory is still CPU cached.
Apply the same PAT coherency restrictions as
DRM_XE_VM_BIND_OP_MAP_USERPTR.

v2:
- Correct fix tag

v6:
- No change

v7:
- Correct fix tag

v8:
- Rebase

v9:
- Limit the restrictions to iGPU

v10:
- Just add the iGPU logic but keep dGPU logic

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: <stable@vger.kernel.org> # v6.15+
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260417055917.2027459-3-jia.yao@intel.com
(cherry picked from commit 4d58d7535e826a3175527b6174502f0db319d7f6)
---
 drivers/gpu/drm/xe/xe_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 8f7b8f2da06b..08ee586cbc7b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3393,6 +3393,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 is_cpu_addr_mirror) ||
 		    XE_IOCTL_DBG(xe, op == DRM_XE_VM_BIND_OP_MAP_USERPTR &&
 				 !IS_ENABLED(CONFIG_DRM_GPUSVM)) ||
 		    XE_IOCTL_DBG(xe, obj &&
-- 
2.43.0

