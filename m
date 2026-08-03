Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217E394798
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799581; cv=none; b=KgBAY8O16PXBTqHerQVDRmbB/waeDgb4VTzmJZXOXsfr2RFOXxvdUj0GTwyBTZ7KGjnLAU+za5soxUMOJbFIHKPyyrf5omzoqICrz9sVKbmsOyFTHts9AyUqQgMsthB56uujUAa5lUM197CGNAL46CsIdZCF0oDjbWgFHkSvBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799581; c=relaxed/simple;
	bh=TBVFyFL+ZH++XstZGMmL8l5IgN94HT1E/L0rROEnAhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AshfVtUL63Orx8AVLUTsyhHMcSPVVq9k3wy9CLqpdzD+9JwMkzh9SObG/gERYkfZpuUBtNn3T3UrgXAIfhIJVkCaU9DbfNmZ59SngD7EZkr+h4hN6I8vdPEL8mVrdiLyX+s1jAA+36mSjsH6dU2eTLJ8AY7A7Cdy7rOYiMzEexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfVEIdSF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfVEIdSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799579; x=1817335579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TBVFyFL+ZH++XstZGMmL8l5IgN94HT1E/L0rROEnAhY=;
  b=MfVEIdSF3HbydQmCsHSZE9+xbGsx7q84o25qPHNaJeUIfFg5pp+6kS/3
   UfyZvZCtfjgx3v3M3HS928FgFDe2I9EHsrFCthFHOj0LF+3F6BSPSm5o+
   RRM2mGLi5+RtP5oEVbgF2s6eoZ6ofVMRZbWNY1kf9OZzyd9GrI42JX0eM
   gZNVIWPbQ89llksNNOpI1ntNkAPH89f8f1V4I1KfsjDRNtKFLa5xkVdLg
   s+ZygwhD62ELYSB2yzjluX3Aqt5UmJUiOvhMelP+hlnbIVZM0zpKGyVPM
   4PVS1uizvJM/89dLM1B0CVlcjRbi/YAsYZiXFtqfjongiLsKAG50Md49M
   A==;
X-CSE-ConnectionGUID: 7A6JCnJcQAu7k3jpHfpGgg==
X-CSE-MsgGUID: 5NooNT43QL6G4yPtOlq2EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232422"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: z5rBVHK8RTK/N6oS2J8wlw==
X-CSE-MsgGUID: WioPbeWTRj2MbkppC45IKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932557"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 07/10] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Mon,  3 Aug 2026 16:26:05 -0700
Message-ID: <20260803232608.3276045-8-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
References: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit aeaa7d2bb017272ab9e18759fe00bf758cd3299f ]

Whitelist or de-whitelist OA registers by setting or resetting the 'deny'
bit in OA nonpriv registers and writing new register values to HW.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-7-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 4f7391d787fb0..4922b3561dbf4 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -161,6 +161,21 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
+__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+{
+	struct xe_reg_sr_entry *entry;
+	unsigned long reg;
+
+	xa_for_each(&hwe->oa_sr.xa, reg, entry) {
+		if (whitelist)
+			entry->set_bits &= ~RING_FORCE_TO_NONPRIV_DENY;
+		else
+			entry->set_bits |= RING_FORCE_TO_NONPRIV_DENY;
+	}
+
+	xe_reg_sr_apply_mmio(&hwe->oa_sr, hwe->gt);
+}
+
 /**
  * xe_reg_whitelist_print_entry - print one whitelist entry
  * @p: DRM printer
-- 
2.54.0

