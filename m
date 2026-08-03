Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826D381E91
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800035; cv=none; b=q2CCHPXgLGTYyj8cbe/uIqMNI42LMzcOPVcnc5mtEA2GBe0IInjfUKMMZG+KWBRxPT8vivrWq5/gJvMlm+6sDG/girBICF4+6rIGP2h+IsiCj3PdEgRteffOzU+tSZJfzwYGyIGwRUFa9ECQhOobLnu9Sc70xb3Ke5P+WUjwxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800035; c=relaxed/simple;
	bh=QaXhVUgFYeYNIcX215sba4q+NMD6KmUecnmGWNLojU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3r0Wxin3cMtdQ3K+BHM49K9ycH9zFX+B4SYcust+Fdywzy78wesLhqh6ptZgu7KVvo+RP9ENXcojd4mzR3mHkM1nYFmf61FYnB0UIcIK2oTJC281HF2s6qnHEBeHBVagHKdXLEF1zyuUmrJcUioae/GgeMwM5nBY0DWmCY5zQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSQp5BHz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSQp5BHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800035; x=1817336035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaXhVUgFYeYNIcX215sba4q+NMD6KmUecnmGWNLojU8=;
  b=SSQp5BHzpiZaPp57IpkUCru/QxmepoLwH9bEbCKTH1UYQNhrOp5QN5/o
   eAgdRfK7+UQH0hAWnD4RJZw+OoRPNFciEuAIg8NgMlcIloV55zRdSfOgb
   pNc9lNrdqThhmkq0fZjecSrByfNF1N4tNIJPJ6FLGzBQmJGluGnzBE9UD
   5RcD5oxyCBEsnHg48i1PA2lRK10mAK8EfF44BahNVXhr1+wiPnX1cNvcy
   dcFaVugp74E3T9s1HQ+4CD2GgPTONCqG3ylHuQf7zgcR13EwTNx1YMnV1
   PUeikkSrLzflmLqpSjiRuXpvKWOUdt6tau6IGUmG+VWWIyssPEJhGUIg6
   w==;
X-CSE-ConnectionGUID: NoUnIMgWQqaRPJA3azWPog==
X-CSE-MsgGUID: wIqxQfXPSt6apWOuuWtA0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112895"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
X-CSE-ConnectionGUID: LC+PKYJsSKmznvK4JvFBjw==
X-CSE-MsgGUID: IvV5auR8RQuDqxV0OG8YGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838279"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 00/12] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Mon,  3 Aug 2026 16:33:34 -0700
Message-ID: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
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

