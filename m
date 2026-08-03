Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A235CB8C
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798113; cv=none; b=SJIbabyjPzXte+B9wDqxjaOc7cPXOQDmTKsVu21JUNrUCaYj70H7c9DtQTbuAyQt8VEve3mduMzoVDfGJkdJ/xkwbSYp+beZ4MaGNS8k4Fu8MB6bCIQLRWi0cRV1K/LT5tAGL5JM7TMripaM+RQTPiCEYucra3vOSI+dyLXyTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798113; c=relaxed/simple;
	bh=OkrfPzhj3YyKJNWDFr7TaG8d7WZ8SNbo8UAuCaAGjTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igIIEaLH7SaCesPwBOmiPAr3zJY0i9XVAO6pMGRIGiZNMTDMy5oX41TRAQabHj+7ET6hjNAYhY5pKlNGAU3t5g4x4ncT4udKNNw4whp8f9W68KCRkAUdviFayHw136HdcjDL/j8oYfwiKF7DhuMKl7DU1diyJdZBc/bkocVfuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV7Lr0KS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV7Lr0KS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798110; x=1817334110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkrfPzhj3YyKJNWDFr7TaG8d7WZ8SNbo8UAuCaAGjTM=;
  b=bV7Lr0KStnLG0BKBHWWnU8eZZFNyk85YYe3StiUOYPoBJsbq1SveJiXx
   M/kohV1boRNm1akAdae7m8s2qu8QExgsUhyxj/8xEIHxR2jMn9dsVXMHb
   WSyRJH97O/ZSkMSGPbRaDXqiUYLPK30A2xJ9s4NYdEL8hhrljKOuPVxm1
   BMHSb1Vy1o7IVrrIG387/f8lXaXWLIY5I7dllzzRE5nDW2rmPNv9JGq3E
   yaTl+QX/PCNMyTq+cgCADy9OvloAWCPqSIH/6OlVkwARNFpUHYa94U2kW
   ATLyAfhY465UjIgBcTEuC+exJI6RUV1D0WJRoYeBhoCflsFW/7rxkNqHx
   g==;
X-CSE-ConnectionGUID: TvOkGc9PTda/C88EjgpsTw==
X-CSE-MsgGUID: rYDpvVVMSkmm7LUIK7rBUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871294"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871294"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: 7fcEt3bbTGac/2SrDlPjoA==
X-CSE-MsgGUID: dQw9xrSCTqie07mPVWZNFg==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 4/8] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Mon,  3 Aug 2026 16:01:32 -0700
Message-ID: <20260803230136.3270230-5-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
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
index 1a7d69ef4fe82..dbaa387a35613 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -203,6 +203,17 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist, false);
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

