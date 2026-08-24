Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC6136728F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590120; cv=none; b=CjQIJ3tiP1/1l67tgz8+ClIedxRda6YGbUos452X/O1vYQ9S8RDUcz2BKiYc4WzGHuWaiUf6TH3xzFaNJZoZvRdnLQkahcKWypcb0w08b7bN9/8LnVdyD4nf7c+HN5ZFQqFgOjewwWYCHKJJ/5LHNCzaL7dy+NZcN8RJiutbKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590120; c=relaxed/simple;
	bh=TciwayOsxxorse3GHwPR+ReTFwDlI/7fhMU/ChCAlRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eksZ6mKwWqw7ncWlcsgQZsMtir/L2OqPFc44z5RVgdqbf7osoHcJ9DkmK80MHCQOctQC17Jc/FmH2EttvYrnOLFAfJj0DPpXDAKn9JXJH1yjuT/DeazGBNnEHaUv5AXYL/077rbjkjZ2FgZ55Engc/YJD485lu9x8kXiaGjZ6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDImUCCU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDImUCCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787590119; x=1819126119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TciwayOsxxorse3GHwPR+ReTFwDlI/7fhMU/ChCAlRI=;
  b=VDImUCCUNMz4HUxQM/cA3v1PUqxkKGMUXmFpqcKcFcKqKLWMEcODeAjf
   7ga+Shl7MW7+GIFgNvGSSbSHCzZTIeP/Qc2gEQ3HRITG7QAaJMTDS/RcV
   Y7FV0idJOPDh1TxerPZnm6WAdSme6G5KVuR2ZjKFAYWGvm8OSv81fck54
   GUALcoUrdXb4V1fbzgu2FqBVW06cKqJMO/iTDLM04QryfhrxnLyRCkkOl
   KPqPbX5kk+leZjAkNSKDMV1shRXM+/1qIr15gXPh7usW6QJSIO1XkTo/z
   yDdfEjyTUyhLqnKD1Jc96WRNxHPri9RhkDTl9DWU18aEYeidt88mf4xnR
   w==;
X-CSE-ConnectionGUID: uAQuz4pfQhOdhm7EnjXwLg==
X-CSE-MsgGUID: V9d4qiszS5C1v2u5rVmoDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98722913"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98722913"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 09:48:38 -0700
X-CSE-ConnectionGUID: XO9b57XlR2K7gPYlu/1iaA==
X-CSE-MsgGUID: 7Z66bDxnSMeCOW4TLERlvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="270839928"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa004.jf.intel.com with ESMTP; 24 Aug 2026 09:48:39 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Mon, 24 Aug 2026 16:48:28 +0000
Message-ID: <20260824164828.498481-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824164828.498481-1-jia.yao@intel.com>
References: <2026082055-unhinge-monstrous-7eeb@gregkh>
 <20260824164828.498481-1-jia.yao@intel.com>
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
(cherry picked from commit 9daa302a82590eeee7bdc68023ddad302df4b88c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
(cherry picked from commit 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882)
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 35168447a90b..a4932a45120b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -413,7 +413,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

