Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312093BB9F4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897791; cv=none; b=eK/AIGgA2uQwtebaIAoLOezg0v044ftF7diKZnKJPhFfftOEJHNsgvSMCbZEUDSOnPJB8Gq7XPRqZaJRi2jRT9aGfJ7iMouiWhYRQpoUZ2BswIG44UGOOYHCSz+NtNIes+6pOoJq8h01foec+LRNpE/KXPaApIfEeZPI/yZbgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897791; c=relaxed/simple;
	bh=qg2TZ/oXILWrh2apzpZyDp3PbjhrPCp2rjC4E4FHA3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXmRbal8a0T1CHK1AGTwjeHvsFYPZWIraOb4uqIC8MCOzxEU2N7w/E6bmrnoPxHVLRSiOjBUk/AHKMHCMBNkCiYOvYo66SAcN6ehiMTIM5DGeiIYrsdNuX/IHEGREFw95gwve610JgR/Mi2AmEmmlYJEXW4ZL+NBdSdHeZ86nZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsRe7rxF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsRe7rxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897790; x=1817433790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qg2TZ/oXILWrh2apzpZyDp3PbjhrPCp2rjC4E4FHA3k=;
  b=nsRe7rxFG07XbtbLI6xmhgfKqO8BlDBogfzwowXl0DClTu1/dX5RxV37
   8rcmWfKf10EiuFFegz3gX8dYaONluLmkx3Pxx6y+qUNmFFP+lnsvG1nxx
   L6s0FBqWjgkJ8h6ZnJ6D5Jwn+K/5ePWYI/y83/qL+PFw8mIqcN7RoaGnX
   FluiMaEOZsGmr2ed5h/s09XWtCOU2zxaTgAgsrw9wZ1AOSr2sT+MUdrcI
   WwhP+gYAdXqrg4Kkq8nCGjCxvNa94dQOKti8fn0DpWoN3enG8/7y6TDGm
   cJB+42YzeithPK16SfAkvpGAsNaDSw1foaeEDVeR8Q5eINEu7u8pvFT5O
   Q==;
X-CSE-ConnectionGUID: y3G7q4S4T2Cx5q2GN+gDQg==
X-CSE-MsgGUID: JJSesSsgT7S3PAiPIT2t9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585774"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: 7+f7t9c/T/yk6NY790qvqQ==
X-CSE-MsgGUID: ovIGTfGTTUGkVsfdwi7f/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612676"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 2/8] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Tue,  4 Aug 2026 19:42:54 -0700
Message-ID: <20260805024300.3406307-3-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 60d49ea28bb190a640bd8dc3f4c946e0811a948c ]

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
index a0bbf4b745a1f..00f00002afcef 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -147,7 +147,7 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	},
 };
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -179,6 +179,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -192,10 +194,11 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist, false);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist, false);
-- 
2.54.0

