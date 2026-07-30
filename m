Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3E3161BF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372467; cv=none; b=glsQLCab+5cvYRmtjngt8LaT0tDG0VT7whqFPM5QYLet6iG9pHXRtbk+lLw8w5RzAXn8isZYkcPd3x2MGVef9w099U1SK/Ucv3/Z8BOn2NYxB0ERoMdKNzIFdZpAArrdQtAg0wYjoXd01vLIpXu8NANc7ivBz6XaqoItbVPucbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372467; c=relaxed/simple;
	bh=0nstxKOPdS3ODtmDh5MBXpA3KCXgZuMU0AF34DzETs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7BbMOtCJwCo9vSyvSD9M4fW+AGLa4w0dY3+6skggbXTZmeLfd0Q2XyVcpN9BAA13qEJxQMoo0lOo/EptYJfB1JgpMW3DYiS8OoLdJ1pIhl+/0XNwVWOtQt2O3UzH940Hhgk1GoMTPV7GPDcT1vk8X5VTZ1jusyvxTeTe8TRh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtA632ma; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtA632ma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785372465; x=1816908465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nstxKOPdS3ODtmDh5MBXpA3KCXgZuMU0AF34DzETs4=;
  b=XtA632maG+e1ENU7Sv5qx2Z2zzWpdRJFH70cF1hqv7r6MocUGvroQMWU
   NhBy0qT5+C4f0RM7EormK1YSs4pd+cXrMoYLXruGuuh2I4/1zD1Ut3OmE
   F2MktDJOmtt7R//iJaqQhfW/ziJ6NOSCH2faAVwrHjJxxj4ITX0vkJ7GC
   swypT5WUQl8PGp6D8pGkPwqXIWjOH3lN0VXk8I6zehGKES2vLoCmLWsYl
   pWGq1dqdiRkq9AmKQDC12MOxSr2iHzcEQEK7oPV+iW/9B1tes8w6dbnqH
   ywSLzIT0lkDw9USUshTWuYrGmAF8ZWjtXU/mKZ/meuo39nS5RFv1Xk6NY
   g==;
X-CSE-ConnectionGUID: hfXbnspmTXavNn5b+LX9iA==
X-CSE-MsgGUID: goWMVFmoS5iIEWp/aq0f2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85935326"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85935326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:47:44 -0700
X-CSE-ConnectionGUID: UXHUikiVRGKaIRB5hXkUQg==
X-CSE-MsgGUID: JvgPKOLMS6+Feq60BRUUXw==
X-ExtLoop1: 1
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2026 17:47:44 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v4 0/1] drm/xe/guc_ads: allocate UM queues in a separate UC BO
Date: Thu, 30 Jul 2026 00:47:32 +0000
Message-ID: <20260730004735.344627-1-jia.yao@intel.com>
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
  sudo xe_exec_system_allocator --run-subtest threads-many-execqueues-mmap-new-race

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

Jia Yao (3):
  drm/xe/guc_ads: allocate UM queues in a separate BO
  drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
  drm/xe/guc_ads: use uncached mapping for UM queue BO

 drivers/gpu/drm/xe/xe_guc_ads.c       | 100 +++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |   5 ++
 2 files changed, 80 insertions(+), 25 deletions(-)

-- 
2.43.0

