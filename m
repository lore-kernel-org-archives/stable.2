Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED3248881
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897789; cv=none; b=Ke92yosRQLSOILwrPHCl1WrvNPoqJ+G2jOJo2KWYdbQXf2K/fQTgACI96iiJNmz7CO0xRZRpFxmIHjoiAGCDtClKaP9dbLDo1rZPmtal/OCGRoykUOyg5QdLK37MC6MG17z/rGU7hBYwnMfoVO+/+iC6sf+ikPgTtUAIeVtN5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897789; c=relaxed/simple;
	bh=B2ySGNq5kQanpzdvu8EippjFZxeefw2XxCuyXxiXU2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDlI202DClF1lKoYgWNWRbgSZk0F1qQZkFb/1eCAW0BQ6U2ugGztAdXccT5Zt3Y5PE9kyLYBQ9ijjnp5mD62KSbRnUM5J/tX8TsafTaG56svdMKevUd+C3MTAfqyOPBYT/YxIo0m4/5HzxLB7stjPN8OsjnLkl1kBkQXh1S8Z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUinAz2m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUinAz2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897787; x=1817433787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B2ySGNq5kQanpzdvu8EippjFZxeefw2XxCuyXxiXU2E=;
  b=NUinAz2mwDoM7wEzWSE508qH2p6F/FLTRUxdRwu+TsSl78kmPW0r2Y1T
   4kAPpX/DBfavvAKpgxmLGbJmFIjhq5eIWpTZlu9VuiB6z5Jqs6m+RMK+T
   sf+gj98r2y0ffDnMIoCCptOjtVrOJ7aS/ufPywYumvAM7r7ocCE217xkV
   I8wG1U8Fn8ah/46aYvm33Ka8W6ZJbuIWTVGWvKKBHSx8ycNYO3Sdec3Tp
   b+rrzpFxZ44wMtUaq4ExwgyMhocB1YqMzldIPnHbPjUTRoVFSD1fSAQsp
   +fBL4X129P7geZz8mCxFqDbMQ3u+zgbuMJcdi4PnUmy2xBUOXDow9g/fw
   Q==;
X-CSE-ConnectionGUID: Zdh8q/4nQ6abIsE84BX0qg==
X-CSE-MsgGUID: CbMGlzCIQ9GK16ONFcdg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585770"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585770"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: Jeg6EypwQNWyBnzXyBQd2w==
X-CSE-MsgGUID: c6Z/SfuSQDirhQnjVPk8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612674"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 0/8]  drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Tue,  4 Aug 2026 19:42:52 -0700
Message-ID: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Backport of the following series to Linux 7.1.y:

https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/

v2: Fix upstream commit sha's (Sasha Levin)

Ashutosh Dixit (8):
  drm/xe/rtp: Maintain OA whitelists separately
  drm/xe/rtp: Keep track of non-OA nonpriv slots
  drm/xe/rtp: Generalize whitelist_apply_to_hwe
  drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
  drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
  drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
  drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
  drm/xe/rtp: Ensure locking/ref counting for OA whitelists

 drivers/gpu/drm/xe/xe_gt_debugfs.c      |  4 +-
 drivers/gpu/drm/xe/xe_hw_engine.c       |  2 +
 drivers/gpu/drm/xe/xe_hw_engine_types.h |  8 +++
 drivers/gpu/drm/xe/xe_oa.c              |  7 ++
 drivers/gpu/drm/xe/xe_oa_types.h        |  3 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 87 +++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_reg_whitelist.h   |  4 ++
 7 files changed, 108 insertions(+), 7 deletions(-)

-- 
2.54.0

