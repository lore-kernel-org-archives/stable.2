Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1844F5E0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897982; cv=none; b=UL3SLXUKjgS+VUOd5uBL7oiYX9nCKOxmbCQE83FkY48KtbnhihqbjQp+MoOYUhoKYSCCzinYMEUHYFM/TJn+W7cmPB8Ko4g7SxBy+aLPw9WRJJj3gooVos/Kf8HS+Mm3Gcf6KKC8JLcgqcgWXXGwGqX6UtVuNZDAhxm/tMgnqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897982; c=relaxed/simple;
	bh=zxIFBiKs5XKDa/O4kbP8TkT7WxJ1CDEi30jDXinS9Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlMTHbeH94CzJEmCweQgzbiuV4h/LV7xWlN0quifBKaM3yvSGkzT2RgqZM5ZCe2vLMa/1XNsRL0H1AAHp5Qk7rRBmlR0TbnSy8BzFuo+VktSYYEZNE9HUemx4s4ZCYtQtF4bwbZ+0MfAEja38frHRNC+Q/Ao98GVW30YLVNuPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcAocPVj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcAocPVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897981; x=1817433981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zxIFBiKs5XKDa/O4kbP8TkT7WxJ1CDEi30jDXinS9Us=;
  b=WcAocPVjP0OexodVhi8QwEjjSpqaRz/SChoUmIzhf5XZ6I0PeF+Z0zo7
   7gXUwWA5iT7ydSkfnW06Z767MP/ACzHTf1ddmnTIMT/diYzqGyOPrkRfA
   YPD1cM+dyS0zyiRZHXlL8k8R4Kz5Qkwoc/KYiHDQxPNhRGG7+M3M/rQzm
   EV7S+ArnoQJ9jCqGaVf5I4d/SmFWs1VfSUKmuJPWQ+fpaXiQb9Oc3x3lW
   n36wRJedl4lroYxCPUr67s2YJfzcmuon0cMoiPG5JnJThaAdnDl7o0J7o
   xPg4k8hsopCo9yjiR0C7ZpSMoD2HPhB/NAVKoaw/iFIEYph0IaG7yhmiN
   g==;
X-CSE-ConnectionGUID: 2HBkSkHMRZKtynpX0P+k5A==
X-CSE-MsgGUID: tWJ2sb70QS+dEbg6T4teNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586039"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586039"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
X-CSE-ConnectionGUID: 51ZKTxrNQr6Z0FRu2IZHfA==
X-CSE-MsgGUID: qUvgQF+7R4mLovF4aPviQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925509"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 00/10] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Tue,  4 Aug 2026 19:46:04 -0700
Message-ID: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
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

