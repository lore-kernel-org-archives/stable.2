Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E53446C3
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800041; cv=none; b=KCh2sMKVLGIiu35oPslYVeYy9ua5zlaeF1FU8pjazGv5nLYvx8ZcVrNcxHm6J4c/3bXxhBJMU+pmjvofKa8y26aVEhDE4b2lw9bD1bVxjUt0V2I/pS9PXuXg4VGz5OiJCW7c2EKKty8cIzLq/XXfRVZoLwmLXKyxSwgOAj3PXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800041; c=relaxed/simple;
	bh=/Q2htPPJ4I52sLSIhlc4/dTeENO8idXDSGHHkCwHD0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuKwybaU5E7S40HIdWrWUjmICv06x1KhT3ClOMKekkDP6rj15dzoKow6H8yWw+55A7wEPtftrnQQ4k6PLsQpr+JrlM+4nitQ/GmQIn6XEEKoRdPJfKy9r9S/4AVEk34/YMYHzvYtAi/ZWtF7Ew/3WMKcdaEz+rD068iPo0PgU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1/RwvGs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1/RwvGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800038; x=1817336038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Q2htPPJ4I52sLSIhlc4/dTeENO8idXDSGHHkCwHD0Y=;
  b=b1/RwvGss47mFUgVwa8a9DhIAy6hRhRX+FWG3UZUHpSxJ5eCQJ9IWuDV
   G31s9vDott2vDl5NDxFT0ylrxPiXmeARoiro0Hfqj/T73CYIOoA8W7HtZ
   B2Rv/wrZgQaekxGYIEq/4/RD2Zcb1f7+cCUg0wQk7Z1Yfo0Qw/X/SBkjn
   0c+k2nQhA2P9d935Rh0ypicDP/AKJwvDKYgS+dahtf4u5LXOdx+jfaFbb
   FvPJTnpDi7sfm0RBxELaxFKm0VKkQvXjXXBbvPKUvVFvndySmPKLaPnTP
   wq4jsNmjNjm9Qm/7RsouLPkEZbIiJZME5gHxzGsN0PiPlB+elD3Rsg5cT
   g==;
X-CSE-ConnectionGUID: 4OwAZshWRbaIDLsbxdHNuQ==
X-CSE-MsgGUID: qt6W3lH9Rnaztfqx8WXtfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112914"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112914"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: bNOsWTY+QL6UuDnVa1NObQ==
X-CSE-MsgGUID: 0g6HfmISRbej+M/OGzB8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838285"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 06/12] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Mon,  3 Aug 2026 16:33:40 -0700
Message-ID: <20260803233346.3277427-7-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
References: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 15739920b71ef3c56868973b4e7e3164a793d09d ]

In order to dynamically whitelist/dewhitelist OA registers on OA stream
open/close, we need to keep track of nonpriv slots occupied by non-OA
register whitelists.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-4-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index d82b14f8d0716..12d12d8f0e99c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -94,7 +94,7 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	{}
 };
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -126,6 +126,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -139,9 +141,10 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
 }
-- 
2.54.0

