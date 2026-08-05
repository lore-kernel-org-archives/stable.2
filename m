Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262C352038
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897986; cv=none; b=cc1yigKZjirWAaOk/2HQiIdl3zC20a5iX5/Sm4ve5sY6T2qgXLt/GE2xgbYIDjN7k0ICeHmX08EofyOTwEoXIoWjVkVnMikwcvL4Bbe5zNycPd6P9xUVivXgUEWGR7P853oYinhsIRSlfaYbd9frNXlEr3pixX43T1bxbOmo5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897986; c=relaxed/simple;
	bh=na5H4SwhwMFxYFG4BI/0/MzB7YTKUFhx6f//TzOuvoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb1hGZcgR7DxCdwCANCY7BPkSSSvtKoiMb8CuhCtppi6kXHwaODpHcL/Z2jowQnqqiApKgSUzs20Y8Go06NOFqIkw0xbAJgAxnSRhkGoxi5EI7UKZuzr4A93oXr8vOBl+j6jVN06YDGeZJgM9GyIh8qNXd384K6IFEzNL9akvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXWEc13R; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXWEc13R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897985; x=1817433985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=na5H4SwhwMFxYFG4BI/0/MzB7YTKUFhx6f//TzOuvoU=;
  b=HXWEc13RrayBUXR+sOvJ0dqfKw09zuF8kAeijJd3DRt6PtZRvMEB9J9m
   +HYnY7+4UkNq5+l+ix8TLBsYfTozPfu4UvNbkmVoq0O0U4nt0ish3VXef
   qZ5gklCljzjnIu35iHoSZh5ba/kCFK0XXVtl1Po6tqEzzcG7wUx+nskfu
   9IRbVoS4lz9ZzG7r9Nhsy8dfA8Lj60yAopyZEsmkQnw0G06OJZstLLNlp
   Avskn+ZjoyhKLwDDiWVxaAWlo9Rg1C9OPE6W6bX0Secd+XHelFWLDcW4X
   O0brupVmKDPHUH5XB7muHmrTdxYhJoRUfrpCN9JTwHEbYzxNYIA7Bmbtu
   w==;
X-CSE-ConnectionGUID: K7+j28OvTxua8moCS26Afw==
X-CSE-MsgGUID: lM/yz7v6R7+6L6NRSEEFhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586053"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586053"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:21 -0700
X-CSE-ConnectionGUID: /ppP16fiQRiZj3rXcdHgxQ==
X-CSE-MsgGUID: 357sHNeWR1KfRtm5jPRIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925516"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 06/10] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Tue,  4 Aug 2026 19:46:10 -0700
Message-ID: <20260805024614.3406679-7-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a19a83721a28ccaddace846da70da5c53d7dd052 ]

Now we can save OA whitelisting nonpriv registers to register save/restore
lists. OA nonpriv registers are saved to both hwe->oa_sr as well as
hwe->reg_sr.

During probe, resume and gt-reset flows KMD will apply hwe->reg_sr,
ensuring OA registers are de-whitelisted after these events. For
engine-reset, hwe->reg_sr is registered with GuC and GuC will apply these
registers, ensuring OA registers are de-whitelisted after engine resets.

hwe->oa_sr is used for whitelisting or de-whitelisting OA registers during
OA operation, by toggling the 'deny' bit on oa stream open/close.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-6-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index cc9f0f598e49c..4f7391d787fb0 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -148,6 +148,17 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist);
+	/*
+	 * Save oa nonpriv registers to hwe->oa_sr, from which oa registers are whitelisted
+	 * or de-whitelisted, by toggling the 'deny' bit on oa stream open/close
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->oa_sr, first_oa_slot);
+
+	/*
+	 * Also save oa nonpriv registers to hwe->reg_sr, to ensure oa registers are not
+	 * whitelisted by default after probe, gt reset, resume and engine reset
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
 /**
-- 
2.54.0

