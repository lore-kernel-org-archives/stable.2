Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95F3546FE
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798108; cv=none; b=itTCapa6S2kWGahF7n09q6KUC5opZANxDo3IgL1HOfsIDh0pluasxUdmCLgJyRkcqgPu9tEtLqe9vYI1jwUAbOaYMSnt1dpxgrLVE0/Mh619LqkJ0komrjWBLVdeS0eXMtkw3j/sRE+c8kwLT5rKHDkcAnYAPhAQM9tRSi8Q4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798108; c=relaxed/simple;
	bh=odnxSP63BWiqPiomE4F189ohjXoLGj8NHXkFlr0ZUBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nO0w2RxHrkIbMzHwgdeApxqYyhg5eufL5zwbc2zp8MuNENagqyY0/NUDvD9yRM6HtkjD+FKf8jhUTuG+7PeQVQEX2TqkZQBwMasfKEN5MSeoKaru6qTJG8Xy610+6CH/sFjOlS+27xUu+Apb1desTmHamo670TJVx60kUfp1WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD3bjWDT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD3bjWDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798106; x=1817334106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odnxSP63BWiqPiomE4F189ohjXoLGj8NHXkFlr0ZUBI=;
  b=SD3bjWDTcgwY7OJ4YJUDHuTe4A6NDd6ielp6KovcY9OCqq1MxAFf8coa
   Zr1S6hbL1AoKIJY9fv98EBMuKsnkSXNV/C0KvGTQGopAbd5hYjW7bdSso
   N5ao2s21Do+KDlM/wjDNm/1cO6xuML4UDlSV4b5lhDwTCH+xhldwqvLUs
   vCBnnMsQwvLGlIXP0aIH0ypnR3oZPLObXIvZNCcVrmlVA7ytnu3O/xkwh
   FR01pPeQS01135BYpxx7lv2hS/0yFqGATVHcK1Cnlbeu7V6y5hnVoWw39
   vTr0ziC4BRPOmlwA8FzJwHnGhVmVHyD05peLfT7Vi4sB+dTOqC41ILehY
   A==;
X-CSE-ConnectionGUID: DcAKxFVoR9G6ZGSGjBuFZw==
X-CSE-MsgGUID: bHDUm+8kSbifVcHreustWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871281"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: sZinqzpwRpC/bTYtgLpisQ==
X-CSE-MsgGUID: 1JhBh8E2S+OvXmF/cQDYOA==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 0/8] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Mon,  3 Aug 2026 16:01:28 -0700
Message-ID: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
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

