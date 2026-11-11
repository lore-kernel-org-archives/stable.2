Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388318;
	b=OPXpgxhE2WSGHAUCaYpT+13w2NpgRka8xawtv1PrrP/zI9xbNi6ZLEohwAcyDzNIND+B
	 EBaM+SxPl3l12QR48LNJG7IZfXQvUeTC50rVCkS82Gd7ZuS94JzwfRSt7PI7AqVBJJVkz
	 VisdF2zOPk1B9QIfeTrZU8YUKV7b/3qa+CT+GFsujxRApFrSuG4RQLa00yXgq3lRyvrut
	 Ch0+7MbNSGEPwt6sigGYvi6EA0JTsC0ebVEKQMV+dab/yX0Ggm6VQ2ak87yAG8SR0tgOc
	 YddIfUAWD9sZv5IXDtHjQXdI1HWz37tWOmxtuMixNM7EBjd4eSK6uo6k3L5lYy7qtxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ohBxVGJbuTXEGFXZzMoZ5rozX0AsfJWFAIPKoTo3KNA=;
	b=fPTL/B0ET4kR9J0+PqVnpUrWWm+V0f0BB4vbzq7YhHn6fSyfnKpaElnMKci34KOZ7+8b
	 jmOlL5Wvqs1CoJt8+qIvjHHyjt+fffDIlUoiS7rtSpJ3TgwR6XnAwITp95iF06RoU8fNt
	 jR0Lo2ASdj4BmicQws+k3Qyof7lfwhOgqlGce2LRHN30I00yaslUP2P2Y5Ax9g7XJ9zjk
	 ncs+T6Hx3W6hWDVHBcuIT4fZ0Fmyn2YbQZwrgIJC2Ljtj4TkehQJAT5qEtc3+lz0VyaO6
	 12bDD0Lr+zfQ74O9twhREXY7oEG8DBsN063OihE9auPSlZQouyb9Q4kX5ezLr/8VBIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQakFUE9;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C3606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245C3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQakFUE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794388319; x=1825924319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6AjYTXNFEIqq6sHAtKCJjvY66n60FUiybgfrztq3ELg=;
  b=MQakFUE9195putKhaqQAwa3vqqCqzJaktxVIK8VJK9/LsxBmSn2449OJ
   xEE1shvxbPS99w1jCNS+1zyesQA2fccQHpftB1nkpqWlK2g6DrfYm1ifP
   EDDvmvXIITJogywcTmxlW/8cWQxetO2iW2aLZeWiTjnjY2CwyFi9p7A4G
   byXdUaCrcHdQfF+xj49YJF6KqqdD2yxIyrXWCB9w2yXuUtudAPOOCc4f6
   PUh9fCVd2+8ZhZuEjZEThxu8oO2A/iRgjFrXxutv7LfwXRsefDeRsFWli
   R6CGx0KyFWwlYxq3D0Pu0Zm4lyaexDdTzDXtoRCyQjJ0bOuEYQ4rRnPDC
   Q==;
X-CSE-ConnectionGUID: szCN/PbmSqOOWri5pS4V9Q==
X-CSE-MsgGUID: +xDJGYOLRWWaLjxFTy5PqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3189555"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3189555"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:11:58 -0800
X-CSE-ConnectionGUID: er4+4mwbQjy2jUldoyA4Pg==
X-CSE-MsgGUID: 4CcOW4A8SMWNd8z8rwXHlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8297899"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:11:56 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: umesh.nerlige.ramappa@intel.com,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Aleksander Czerwionka <aleksander.czerwionka@intel.com>
Subject: [CI] drm/xe/query: Use ordered clock reads for engine cycles cpu_delta
Date: Wed, 11 Nov 2026 14:34:02 +0530
Message-ID: <20261111090401.975803-2-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_delta is meant to bound the time taken to read the engine timestamp
register, but it is measured with local_clock(), which on x86 is a plain
RDTSC that is not ordered against loads. Either end of the window can
thus be sampled while an earlier MMIO read is still in flight.

A reproducer looping on DRM_XE_DEVICE_QUERY_ENGINE_CYCLES on BMG reports
cpu_delta as low as 18 ns, while the MMIO read alone takes > 1.5 us.

Use ktime_get_raw_ns() at both ends instead. Its clocksource read is
ordered (rdtsc_ordered() on x86).
With this, the reproducer reports min/median cpu_delta of 1567/1745 ns
and no short values.

Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with better accuracy")
Cc: <stable@vger.kernel.org> # v6.8+
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Suggested-by: Aleksander Czerwionka <aleksander.czerwionka@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
---
 drivers/gpu/drm/xe/xe_query.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index dc975f595368..9cc35fc83954 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -6,7 +6,6 @@
 #include "xe_query.h"
 
 #include <linux/nospec.h>
-#include <linux/sched/clock.h>
 
 #include <drm/ttm/ttm_placement.h>
 #include <generated/xe_wa_oob.h>
@@ -97,13 +96,14 @@ hwe_read_timestamp(struct xe_hw_engine *hwe, u64 *engine_ts, u64 *cpu_ts,
 	u32 upper, lower, old_upper, loop = 0;
 	struct xe_reg upper_reg = RING_TIMESTAMP_UDW(hwe->mmio_base),
 		      lower_reg = RING_TIMESTAMP(hwe->mmio_base);
+	u64 delta_start;
 
 	upper = xe_mmio_read32(mmio, upper_reg);
 	do {
-		*cpu_delta = local_clock();
+		delta_start = ktime_get_raw_ns();
 		*cpu_ts = cpu_clock();
 		lower = xe_mmio_read32(mmio, lower_reg);
-		*cpu_delta = local_clock() - *cpu_delta;
+		*cpu_delta = ktime_get_raw_ns() - delta_start;
 		old_upper = upper;
 		upper = xe_mmio_read32(mmio, upper_reg);
 	} while (upper != old_upper && loop++ < 2);
-- 
2.52.0

