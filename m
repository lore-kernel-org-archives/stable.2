Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB4395AC7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799579; cv=none; b=AmjPVqWjkNVcvT69+IurQ2jIwpOGnRfbdCcLyJYMXoPAL8UMVJfcg8umfGO0zXWAolgW1zg0CwrS7pXUa3EmP/6wakxS+jvNLUZyFWCqCozfpR8/yFnbLZJhHAP6FrsI+AwZL1u50cTuKVhGKn61MwAABir/T+xuE+UWbCzncok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799579; c=relaxed/simple;
	bh=MzaxIJNo41A64tUgNdA6TYMd8XoIvBX4muJywrTpgh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdgGe0D9+l0kGeSMQHDqnU2WmDoqv8gteT+ktLa5o4AFJxdogBUUQ9uxzBGabpi9kvVH10idHJEeBAarhiytrRYXrzl3foKOU/Sv9E+1On9afjqi+ijZTThZoTETne6Kn6QRMNgSSXnr0ueRzhqtckEzxbpr8PdQ/a240w3vbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDW0bbIj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDW0bbIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799578; x=1817335578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MzaxIJNo41A64tUgNdA6TYMd8XoIvBX4muJywrTpgh0=;
  b=NDW0bbIjCrV5Gy/Hj+pbNuUwFtkdsgfNzYWHZ/wduoQcbo0eyCPiD6u+
   F6qyUNb9isBa5Tr95UqffK8DDkRmEmiSpDrn2rD0RU7SRj3yIV3pyvopv
   FCYZDmhBjSw277TOO8fVO05nbEKzBjn9T6av6fpRrC+soo6EAGNlavmtV
   p9/CyVhA+muAs3MFqSYCSBfuIIBk2s1gdbcvYVs/2fegVWXCIjx+sgX1e
   YEXdTuYADgslbiwG7tChY29rPuM7chsqC6IMF/+BC1zzQHrtPemB2JWGd
   0zA+fUWTusD2ro3X7ZQlNOpfHsRGCTaNtTCN+lmx3kru3Q+MJiK+cJuo4
   w==;
X-CSE-ConnectionGUID: 6VelFZ8QTUivdi3gCmhiog==
X-CSE-MsgGUID: 98tCDvHvR+eeLAU1Kc7iUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232401"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232401"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: SwTo/2g5Q+efKzaa8ok0PQ==
X-CSE-MsgGUID: 1Ayxvbp2RLq6IgDRtc2dAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932549"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 00/10] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Mon,  3 Aug 2026 16:25:58 -0700
Message-ID: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport of the following series to Linux 6.18.y:

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

 drivers/gpu/drm/xe/xe_gt_debugfs.c      |   4 +-
 drivers/gpu/drm/xe/xe_hw_engine.c       |   2 +
 drivers/gpu/drm/xe/xe_hw_engine_types.h |   8 ++
 drivers/gpu/drm/xe/xe_oa.c              |   7 ++
 drivers/gpu/drm/xe/xe_oa_types.h        |   3 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 119 +++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_reg_whitelist.h   |   4 +
 7 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.54.0

