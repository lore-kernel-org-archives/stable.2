Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F1488210
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700691; cv=none; b=g90SEgKdOw5LWd0KD1ql34HLe8OVPZYuMSq6/cD6kp3ZpKz/uTtMaGTUlZTwdIJ1cWABiHMvyb/xiNBoMPdarMVLCW0HVNzcaCpHyyRw0VEZsU/0P2tlA/nJZUcYRGch/00t0t5vee7aOOTEUSfkx77aKEK3UkPbKyFtdOe+acE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700691; c=relaxed/simple;
	bh=QhU7JzCPmCzIVSsOwyUff+OzMLwVq/rtHOtc8CqMscQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lu+hzqgXFzKcH0Wa30eeohGH9jl7uD9Jshla4FuTgZ2AERQGTCeuvjKgLl+s30/rwgLCpUAuZ8n1C5xbUYGednzCuqjwSEHdrJHTP/koJsoiy86c7hwd6DH0qszwBbzmMhs2mLe0bb+BrnsZcPppZB7ij8bcge2TXn/6zDCPWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTOf439K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTOf439K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700690; x=1819236690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhU7JzCPmCzIVSsOwyUff+OzMLwVq/rtHOtc8CqMscQ=;
  b=CTOf439KkZ8VQkmmQWzCjKD/ru6/vA0fuzpROV2TdpN3Pt6rWjbGP2ZD
   OrS8+KWs91Djjxi3kxPnrLkqkfxQDDXDHRyvbDCFUw8Qe5OXmEWFR3Xmj
   vUYrxgSWsNTyi5/1XGRbonlsZgS1UViZRWXphV4Gv8fmog4leWKNTgTZJ
   EA9ig6dDRd9G/5ru42kKeas86RIQegQturfl9s5y/80AGeBW0AHxDIoFR
   t80JcqV1Kl3VPrDLmuviVGiwbe0kxqum42S3VCeYihNWH544LCeskX4Lh
   GnWIrVC7ujF7OUyUJPMruz+uy6ZBwgInzsbeFBCfoo/vtaJD2AFNL4pQ3
   g==;
X-CSE-ConnectionGUID: nZke1IEiRHeq9Q/j21sU5w==
X-CSE-MsgGUID: y/fydV/DRDqfj7RP7U5NGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99335338"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99335338"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:31:29 -0700
X-CSE-ConnectionGUID: rPe6oKq2QqGbp3HY1sKslg==
X-CSE-MsgGUID: eqlj4cVSQFWIH77yBGC29g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="290941892"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by fmviesa002.fm.intel.com with ESMTP; 25 Aug 2026 16:31:29 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Tue, 25 Aug 2026 23:30:53 +0000
Message-ID: <20260825233053.1504506-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825233053.1504506-1-jia.yao@intel.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825233053.1504506-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
(cherry picked from commit 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 4f48356ae622..63017ae2c381 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -405,7 +405,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.43.0

