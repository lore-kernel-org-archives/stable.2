Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1919D074
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897983; cv=none; b=ZSoOv8v5YIVNnCXShoZkGurkRgUWL9y+rRhmEYm6QDhWPqCeDuR092KCl6YusDofMVfzjot/ZvGhvGmwgKiTv8ExR86vXdLrwwkE7mDQFbaQv6Kmvrc750aQSn3pWbl3r50LX+dkrVnCa30d45OI+kuFZDH7oesHWrbw8DSbY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897983; c=relaxed/simple;
	bh=PNajYqjZC34yYyANf6uKioJE7ekOi1G+BwQYWeiCdkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPXT+5B4WXHR4RE3MHX2mMke9Ta8uMook6Q8NQJNBOUXoTlXgADExYRC21NVF12UVGZRA6Tc9D6U5Joi4zRwUPp0Ven4If4P1dch3dHta9Rh8xxgPRTm43KjBbhnLhUXD+oGEfO3emhE6EHYAz4miJd8uLPB8++Jwtdc4/FB5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giXLyQMC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giXLyQMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897982; x=1817433982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNajYqjZC34yYyANf6uKioJE7ekOi1G+BwQYWeiCdkI=;
  b=giXLyQMC2BZOzU/+oAGdalYke7QKg4UaJg3sEU80UAclobpN1d3bTfCh
   miOBV6CR9O9nhbbV9QJisJVfw13KFYu3ftfhai1r3sUizifmI+nKR2CfE
   HwNyNnuwGYkQ2xG17KQ7znG6f6+kzP2xacM9YKE8J3dndpDUkfQlDDMg4
   MIT5R7VtxMErKXIs4Ujm0i6GbKZlj42lIR1H2CTTHsjqMr5TOCYSriC+p
   +kqU7x8lmH2l+6kc2rp4zIxNnqEty/4lDY3rFw4bZNcGz99BkHC1TyWSQ
   V93Ibcetqo85TK3vxLvzIAqFakd1haTJ/ZJIk7Smj90uCBL0wyzoTmCfL
   Q==;
X-CSE-ConnectionGUID: vV9Xj6llSGSfeDijubsEdA==
X-CSE-MsgGUID: gCfTpAEkQEqcF7ULUwv/lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586042"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
X-CSE-ConnectionGUID: T6PbV/KnQf6qconc/dzpoQ==
X-CSE-MsgGUID: 3CNJFq3WT7WDcxLB4fwSsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925510"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 01/10] drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
Date: Tue,  4 Aug 2026 19:46:05 -0700
Message-ID: <20260805024614.3406679-2-ashutosh.dixit@intel.com>
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

[ Upstream commit ed455775c5a68b75e5f6ad6c8e0e3e9c98fd3f64 ]

Minor refactor of OAG MMIO trigger register whitelisting for code reuse
with OAM MMIO trigger register whitelisting.

Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20251202025115.373546-5-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 29 ++++++++++++---------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 21763dc51150b..47fb3e74b567c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -66,27 +66,24 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
-	{ XE_RTP_NAME("oa_reg_render"),
+
+#define WHITELIST_OA_MMIO_TRG(trg, status, head) \
+	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+
+#define WHITELIST_OAG_MMIO_TRG \
+	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)
+
+	{ XE_RTP_NAME("oag_mmio_trg_rcs"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
 	},
-	{ XE_RTP_NAME("oa_reg_compute"),
+	{ XE_RTP_NAME("oag_mmio_trg_ccs"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(COMPUTE)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
 	},
 };
 
-- 
2.54.0

