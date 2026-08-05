Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACA23D7DF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898164; cv=none; b=LlneRLygqBia8dsExO0nkhrjRnd8CRc40ktrGa6Ei5Ut4DUeCzrboJG+itEqdViBimCXoVzBGG9EiKzVNwxyH0NBfEJFzbMHWBjU8IeLgqFAcz0Td1Dwd2TeSOcSYiHYiXZNVE1gjkyx5APveGuiAEaeQ49xoSSMb+LsW8AKEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898164; c=relaxed/simple;
	bh=dtlmuszZ3xkrqtNbwgObxaKU91NbAr6jnR9iZxsi8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVu4L1mj6/15Dioi4Q2t/whkoPImXAjGQhVjwW+/I44bhX1UbFTB6AhAXELRK7pSGmMNGjInuYxVicV7DFhILw0nXmE6FG/RlMGICIJe24BVYlEVwhdbi/Wb2qjKXZ3xqImNtaOtZXWTGhfDlx6OyyN464ww9PjM+uVwWOKEjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIhMdXbA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIhMdXbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898162; x=1817434162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dtlmuszZ3xkrqtNbwgObxaKU91NbAr6jnR9iZxsi8zU=;
  b=IIhMdXbANtfVf10hLjsyQsbjsrL47bb9UFwzI1tCe3TjIx7jgpGE482n
   SLwDy1X98h+DTcYL76ZMMg8bIVzOD2UnS02zr8qbjuYEvmEpnNU2VwhTG
   aaPjVUL6D5l6288wCCZ0pgdACs4kx7DnGwEIbBfVC0UikGiIPiFetFibo
   3mYbNGuiDn1IlovFysEyyrFwlFVlG9WkATs98jkGgJJDEIIV6occWLV2n
   v7SDezEW4RkELM7eL2hZ2ZAR3zyFf5rMjlUSnmVcmG8TnjGQEOd/TCYUZ
   VYOTat2YRre0vRepNEp8T+gv3FA77SWQPviS3y0rVckEfWh9DZ5UPv4pd
   w==;
X-CSE-ConnectionGUID: MskfmAw1RO+TN9YXWO3EaQ==
X-CSE-MsgGUID: qmOQ4H75QXuGw5QObps9iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826115"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:21 -0700
X-CSE-ConnectionGUID: R/+zk4f9TdaqHtl8ddrdug==
X-CSE-MsgGUID: M6J8fL0kStmAMYlvY4PSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911785"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 00/12] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Tue,  4 Aug 2026 19:49:03 -0700
Message-ID: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport of the following series to Linux 6.12.y:

https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/

v2: Fix upstream commit sha's (Sasha Levin)

Ashutosh Dixit (10):
  drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
  drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
  drm/xe/rtp: Maintain OA whitelists separately
  drm/xe/rtp: Keep track of non-OA nonpriv slots
  drm/xe/rtp: Generalize whitelist_apply_to_hwe
  drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
  drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
  drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
  drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
  drm/xe/rtp: Ensure locking/ref counting for OA whitelists

Lucas De Marchi (1):
  drm/xe: Apply whitelist to engine save-restore

Michal Wajdeczko (1):
  drm/xe: Introduce xe_gt_dbg_printer()

 drivers/gpu/drm/xe/xe_gt.c              |   4 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c      |   4 +-
 drivers/gpu/drm/xe/xe_gt_printk.h       |  31 +++++
 drivers/gpu/drm/xe/xe_hw_engine.c       |   3 +-
 drivers/gpu/drm/xe/xe_hw_engine_types.h |   8 ++
 drivers/gpu/drm/xe/xe_oa.c              |   7 ++
 drivers/gpu/drm/xe/xe_oa_types.h        |   3 +
 drivers/gpu/drm/xe/xe_reg_sr.c          |  53 ---------
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 147 +++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_reg_whitelist.h   |   4 +
 10 files changed, 189 insertions(+), 75 deletions(-)

-- 
2.54.0

