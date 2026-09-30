Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D523ABBE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790185; cv=none; b=KkyL31tuKy/SW9NAQ2pWh8cqmn73Yf2iM6RF4fTGkONscuy54KIfMyAredwZRs0J6PSTtB1sWRnPvGAzt/sT/0XFe3uUnEUfTp03mWm+hPBJ3TbKkKWs2hb9aM0YCxuhGZKhkM94DlVKGZA2XMvyrA/GHPMfGCB1YGqr7DkEBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790185; c=relaxed/simple;
	bh=9TJCI0aGpT3MNwcDd0bQURQkN943szThLXmLYQcoxR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzLSRYu2WgwDyY5Y6pm1wJHLVmS2FQWfmu4uVlbsPoo3gfyLiZa6LCxpNv9I9P4gfjluLfJBcVqhbMqgh18ez4jDCxfmR9wHA9GeWcBLzZ0g99MCb45ueM5Zl5tOUeFeZ3ox113qa2jt8e+40K1o09lgn+nvbDmOoC5HjlZ8Z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd8JcEHM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd8JcEHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790184; x=1822326184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9TJCI0aGpT3MNwcDd0bQURQkN943szThLXmLYQcoxR0=;
  b=jd8JcEHMitkpbqLVo2Cye3TyeSma5+ECh1+ZnkxyJwHEswF3nzGI4PY6
   nTRtvXilEdfbPTarmKGF3QeLq92SoNaE4yBf/0W+XM3K5fAyNc96Bf6xN
   QjXJ1bKN3N3poCmucV9gHy6QxSbuBbcZUiwT5RMfkt0IUQxPVjloFZ+ZW
   J+FKTf0gBHNx0f4IRQR4FBv3MYpexfuOYw4Ezt/YJLSPSstl2me+F98OI
   Cksuu1j5mE36VgxiOxCpQVN8b7BLBzyiVbztc6totP0o5PZQCFrXrElAX
   8KOPpXTWydfV3jx8zzhzqcp1uwdSaKVWOlmoE97qj+M+ExzRNX/dKn8E9
   w==;
X-CSE-ConnectionGUID: 2XXgS63qRfKHOv8n3t2zFw==
X-CSE-MsgGUID: A4TQreERToy1Ynuez4ikrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91633299"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91633299"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:42:52 -0700
X-CSE-ConnectionGUID: at8FuPuyRi696BpxAHw3iQ==
X-CSE-MsgGUID: XZwnvEkKTFy5lGqvaBYNUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303684025"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2026 10:42:52 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Davi Chaves Azevedo <davichazbh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 7.2.y 0/7] Fixes for cache aware scheduling
Date: Wed, 30 Sep 2026 10:48:02 -0700
Message-Id: <cover.1790790344.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greg,

Here is a series of patches backported to v7.2.8 (commit 9a66fdc0d7fd)
to fix cache aware scheduling.
The original commit ids in upstream are listed as below.
Upstream commit ids are also listed at the beginning of commit log of each patch:

commit f0d243a96f26 ("sched/fair: Avoid creating misfits during cache-aware balancing")
commit 0d6526f82c3c ("sched/cache: Keep nr_pref_llc_running in the runnable domain, to fix LLC mis-scheduling bug")
commit d6013e2465d9 ("sched/cache: Honor migrate_llc_task semantics in active load balance, to fix LLC mis-scheduling bug")
commit 28f9c0e0a0b9 ("sched/cache: Decouple sched_cache_group from mm to fix UAF")
commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp to fix UAF")
commit 65efcccddc83 ("sched/cache: Skip kernel threads for cache aware scheduling to rubustify the code")
commit 3cb0243767fd ("sched/cache: Refresh LLC capacity across CPU hotplug, to fix capacity underestimation bug")

Thanks.

Tim

Chen Yu (1):
  sched/cache: Skip kernel threads for cache aware scheduling to
    rubustify the code

Davi Chaves Azevedo (1):
  sched/cache: Refresh LLC capacity across CPU hotplug, to fix capacity
    underestimation bug

Lu Wang (1):
  sched/cache: Honor migrate_llc_task semantics in active load balance,
    to fix LLC mis-scheduling bug

Tim Chen (4):
  sched/fair: Avoid creating misfits during cache-aware balancing
  sched/cache: Keep nr_pref_llc_running in the runnable domain, to fix
    LLC mis-scheduling bug
  sched/cache: Decouple sched_cache_group from mm to fix UAF
  sched/cache: Introduce task_struct->sched_cache_grp to fix UAF

 drivers/base/cacheinfo.c       |  11 +-
 fs/exec.c                      |   1 +
 include/linux/mm_types.h       |  15 +-
 include/linux/sched.h          |  20 +-
 include/linux/sched/topology.h |   4 +-
 kernel/exit.c                  |  28 +-
 kernel/fork.c                  |   2 +
 kernel/sched/fair.c            | 467 +++++++++++++++++++++++++++------
 kernel/sched/topology.c        |  22 +-
 9 files changed, 432 insertions(+), 138 deletions(-)

-- 
2.32.0

