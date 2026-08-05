Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB41D63E4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897987; cv=none; b=GW9rhPZw1xbPs8k0JiRekgx9t6zQiclSDe3u/qO+IiSa4LDuFgv7KgQx+bOb7DXtEiKjbug9Eal+S+Vph5204y0jgimqghJvKvuWcg+ge5gPFszoTtpn0+V/Bhp5Utojiu1pvTATbY1QBOFfI5Kg0/BCW5M4oDX12KHp9yYyhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897987; c=relaxed/simple;
	bh=TURNOMOm+bkwsjo3AwqJKVN8rYAiAsEvzc1dZXOPOlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/i84Ej9Hb6CQRObT/gMwB5wjecvgiigeUH8e1+yR4tptGL+7kdIZMCwUzEU5MA3hmmALpTiy91qXP66ecsk0QG1ik+qc5iwCG/RArklUl+qeGiFjD8+h9wGJ8eRt1bp+2NQzEmNzWVEuoJt6i7m5lW+JYdclIB1ur7klz4pD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeVGG/Aw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeVGG/Aw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897986; x=1817433986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TURNOMOm+bkwsjo3AwqJKVN8rYAiAsEvzc1dZXOPOlE=;
  b=IeVGG/AwlvoupErNy3oeukhhSeJrDNvGJaivdN6ueGOjF/cNKt4vCusv
   FZLtcBi1o25g7Qja/sv3o5md+hdl2Jdb+RWOw5ISTUTVQ8jllAZLAe1yI
   1CR2dJekRdhNWmdioLHp85T4K2J0VZSQIUppXSZDKLorCprlZuuqMuMD7
   Z6DaQg07RK+h0x9ZMC500PVt7mKPyx0lHjee05KInFWy04Gwy+nyazREj
   tWh1Uuy7VndT5RplEAa5mwxKsFs+jiw88+F6vdyYXZRrybt+yJbPXWNjM
   QFg5pLJM9QWa5GYC1Ly+OWrzK9nglc0ueFTnM4XAey5J9PDgXUg55rMmh
   Q==;
X-CSE-ConnectionGUID: P2KPGbMkTYeoMmRDR2tgPg==
X-CSE-MsgGUID: pUb/w+ZKSXaV5l3UNCvTUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586056"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586056"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:21 -0700
X-CSE-ConnectionGUID: q4Oj8xApTqq58jhTUxSOOg==
X-CSE-MsgGUID: Mopg2FhQRf25jZ0PMk7COA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925518"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 07/10] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Tue,  4 Aug 2026 19:46:11 -0700
Message-ID: <20260805024614.3406679-8-ashutosh.dixit@intel.com>
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

[ Upstream commit b422babd77fac2c96b92db484050e460899bddaf ]

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

