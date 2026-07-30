Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0B476CD8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454044; cv=none; b=FKXaBk/Bv75GzFe+LMIK06Qgat+04m0Hb1uExcU2FKjPVycug25RcRlcRcq3CVnGDhWnuF4k/ODOQstqo1zRssygIl8dH1mVmvbRzOZTaABVjgtkAovCA9LW7vZZvjH+jtCv4c/t2jcyPJ2ebZGIFxm6PZWHAlFNu2eOtN4Xq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454044; c=relaxed/simple;
	bh=BrJBbbIKgbwmiyNUubFhLWVL9xPnuASwabzuM5OoEoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTi1JxkoUwP6iYi+EoMETFApqriz1ol1T8IGvUSPuZ90Wa6cjJkIjunngfQm2KL+1RRqPZ1SqPwZ5dVRTecdJZuxgN5eHU590o0oN5LsMfohnmzeddrWDqunNsLNwh/DhRJUi4Nfv/ObP6H87bl5j/P9wbuu/l9yw5mdGMvOEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayjHm39M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayjHm39M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785454038; x=1816990038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BrJBbbIKgbwmiyNUubFhLWVL9xPnuASwabzuM5OoEoI=;
  b=ayjHm39MonUt5FOC7qCLz1obvIrei59E7XIsvIuexi1xXHORX0+BKSNB
   5Jrxp6wSmTIiTj1S+jysXNH0Qgb749rPVY0QUqCSvj9Cu0xTZm9Npg6dT
   0LsylfNmmzFJ9qqmDCYnZWpPFlmvYYOKECdbcRA30rJksmV9r/8t8RwKG
   V/ynXO4EE1VnPuvcAOI72MOf1lFnabXFsA1pbzB6Tcn5KhaI64wOVGiLD
   Xu3r83+fWao+2glphMDzr/iWzsi9wbtg7k0irwqqOyK4BfnSIAOUg1ahY
   XbQdb6KPsyBFijGPxnQxBXTgJfs6o7D5P0dQOKErxEZPxXVzzY27WXC7d
   Q==;
X-CSE-ConnectionGUID: eiNoIbCJSO2qbE2IXnUTeA==
X-CSE-MsgGUID: XlBMZ0XWRwiRzAkdgPl0Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89895247"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89895247"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:27:14 -0700
X-CSE-ConnectionGUID: Jv16HRFYS+200luprTyHVw==
X-CSE-MsgGUID: oKC98dqMTue4j5fIEtnvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="283764143"
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 16:27:14 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v5 0/1] drm/xe/guc_ads: allocate UM queues in a separate UC BO
Date: Thu, 30 Jul 2026 23:27:09 +0000
Message-ID: <20260730232712.517989-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722053410.2767369-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

== Problem ==

On platforms with Unified Shared Memory (USM), the xe driver maintains
three hardware page-fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE,
ACCESS_COUNTER) inside the GuC Additional Data Structures (ADS) blob.
The ADS blob is mapped WB on the CPU side.

xe_guc_ads_populate() is called on every GT reset to reprogram the ADS
blob; it begins with a full memset() of the blob to zero.  The zeroed
cache lines for the UM queue region reside in the CPU cache (LLC, WB)
but are not immediately written back to DRAM.

GAM hardware writes fault descriptors to the queue via DPA - a
non-coherent path that bypasses the CPU cache and writes directly to
memory.  GuC reads the queue via GGTT (WB), which hits the CPU cache.
As a result GuC sees the stale zeroed data from the CPU cache instead
of the descriptor written to DRAM by GAM.  The driver then receives an
all-zero fault descriptor and returns -EINVAL, causing an unnecessary
engine reset.

This is documented in HSD as:
  "When Fault queue is updated by the SW (Buffer zeroed), it can reside
   in the CPU cache (L4:WB). A non coherent write from GAM HW would not
   consult the CPU cache and it will eventually get written into the
   memory (depends upon eviction/flushes) and CPU cache has stale data.
   When GUC HW reads the fault queue it gets it from the CPU cache,
   which is stale data."

The window is narrow but reliably reproducible: run xe_exec_reset
--run-subtest gt-reset followed immediately by
xe_exec_system_allocator --run-subtest
threads-many-execqueues-mmap-new-race.

== Reproduction ==

  # Requires a platform with has_usm (e.g. Xe3 iGFX)
  sudo xe_exec_reset --run-subtest gt-reset
  sudo xe_exec_system_allocator \
    --run-subtest threads-many-execqueues-mmap-new-race

  Symptom in dmesg:
    [xe] ASID: 0, Faulted Address: 0x0000000000000000, FaultType: 0

  The all-zero fault descriptor is the tell-tale sign of the stale
  cache line race.

== Fix ==

Allocate the UM queues in a dedicated UC BO (ads->um_queue_bo).  UC
mapping on the CPU side ensures the memset bypasses the cache and the
zeroed data lands in DRAM immediately.  GuC's non-coherent read then
goes to DRAM and sees the correct descriptor written by GAM.

A separate BO also eliminates the secondary race where a descriptor
written by the GPU between GDRST and GuC restart could be zeroed by the
next call to xe_guc_ads_populate().

On dGFX, VRAM placement is used so that xe_bo_main_addr() returns a
real device-physical address (DPA).  The original ADS BO is explicitly
migrated to VRAM by xe_guc_realloc_post_hwconfig(), so its
xe_bo_main_addr() already returns a correct DPA.  A separate SYSTEM BO
for the UM queues would not go through that migration path; on systems
where physical pages are allocated above 4 GB the IOMMU assigns an IOVA
that differs from the physical address, so base_dpa would be wrong and
GuC/GAM would access the wrong memory.

Why not just flush the cache after memset?

An earlier approach called drm_clflush_virt_range() on the UM queue
region immediately after the memset to evict the stale zero lines from
LLC.  This reduces the failure rate significantly but does not fully
eliminate the race for two reasons.

First, the Linux kernel maintains a WB direct mapping (linear map) that
covers all physical memory.  Even after flushing the vmap alias, the
CPU can speculatively prefetch the same physical page through the WB
direct-map alias, silently repopulating the cache with zeros.  LNL is
known to be particularly susceptible to this speculative prefetch
behaviour.  XE_BO_FLAG_NEEDS_UC calls set_memory_uc() which updates
both the vmap PTE and the direct-map PTE to UC, closing this aliasing
window entirely.

Second, the flush approach leaves the memory mapped WB on the CPU side
permanently.  Any future SW access - a debug read, a tracing hook, an
inadvertent touch - can re-dirty the cache line and reintroduce the
race.  UC mapping makes the correct behaviour unconditional and
self-documenting.

Changes in v4:
- Split the single v3 patch into three logically independent patches:
  1. Separate BO allocation (root fix for the memset-zeroing race)
  2. VRAM placement on dGFX (fix incorrect DPA when pages are above 4 GB)
  3. UC mapping (close the CPU cache aliasing window on iGFX)
- Corrected the dGFX description: the original ADS BO works because
  xe_guc_realloc_post_hwconfig() explicitly migrates it to VRAM; a
  separate SYSTEM BO would not be migrated and its IOVA would differ
  from the physical address for high-memory pages.  The previous
  description incorrectly attributed this to IOVA aliasing a PCI MMIO
  reserved window.
- Added physical-contiguity verification for no-IOMMU iGFX systems.
- xe_guc.c: removed the post-hwconfig reinit_in_vram call for
  um_queue_bo now that dGFX allocates it directly in VRAM.

Changes in v5:
- Fix the first patch conflict
- Update the ASCII block diagram of ads
- Simplify the contiguous memory check
- Improve code comments

Jia Yao (3):
  drm/xe/guc_ads: allocate UM queues in a separate BO
  drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
  drm/xe/guc_ads: use uncached mapping for UM queue BO

 drivers/gpu/drm/xe/xe_guc_ads.c       | 100 +++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |   5 ++
 2 files changed, 80 insertions(+), 25 deletions(-)

-- 
2.43.0

