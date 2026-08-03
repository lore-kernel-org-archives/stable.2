Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264113446B9
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799580; cv=none; b=t/U9K+jZikx54GrQe60MVq5OxWnUQLRSXJeJokXT0FXEUeHZxy7IjAZbsurAV0zWBlazMz9Efnfnz2/rpwCs/fde0a254jeDLo9khUhWDzgmZaAgrsGM3iyI8lU2XASSIrB9c588nKbkcogYsl/iUMi4bYVfMnmehraCG1AI6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799580; c=relaxed/simple;
	bh=76CWhAP3f4hVH0FFnKJMW+Jm2tq9YXMwkxJtIivqAsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFv5yiftN9ms/V1DuRK9yRjafsQU762Px526eZagAwNY/TE2Oqt4NgQcpZI7RHW/YdtrChYwsfHKM/PKPB9okHFcvwRTPcLlKG7hK/Jbq2Uuap2/f1pr2UMB/uy1Lpvf5gkMUsRGH/YFOenYzRhZrP+JUtJ7K3ap1lpAnlCE6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXFz4qOk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXFz4qOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799579; x=1817335579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76CWhAP3f4hVH0FFnKJMW+Jm2tq9YXMwkxJtIivqAsQ=;
  b=SXFz4qOkyHUtprWP39IFtwUiu7Rn6rENPFMwltmlUcx/8azMXml1686T
   ft9vPm6X91y0X/s/8UG63gRrkuXcoGp3I9ddpi9w8iwS+OxYlPu7qSyaN
   pQvcUpFpY0XbRxRpbbqUiIeYvtjFguIA+AWnuNOov0dt08aCbr5lse0FB
   B3iBhpfW97LY/09Xj104qtx57MeE1G0E0w4WDD5fiDbgBV0YhaEveaDU3
   wABp6YRSZ7rCAJZHILYiW2kfXVenlSh86FtLl8IPBiqGOGCc2o4uDFeQn
   GDsUTNEA7pr+Q9G0uI9ypUFmMIMo7kSx581qT/DPXXEpdji0ckjXLEGyt
   Q==;
X-CSE-ConnectionGUID: s08+Zt6SQ4yGNjKh+Z880Q==
X-CSE-MsgGUID: HDQpQGfoQHmzy/9BEzByZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232419"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232419"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: EVKzJIc/RIeBtsTw7JBDkg==
X-CSE-MsgGUID: yOGH6++vQe2yfJOwQgEdFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932556"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 06/10] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Mon,  3 Aug 2026 16:26:04 -0700
Message-ID: <20260803232608.3276045-7-ashutosh.dixit@intel.com>
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

[ Upstream commit 3a3c3e56db2923daaf1a5353cd6463a4cdaf4ffa ]

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

