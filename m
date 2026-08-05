Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA16A395
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897793; cv=none; b=cwWl+MZwC9aoZY8Z8qqhwOILVuvhkknPAZdG0Ktgux+01ApA24uGN9TetvbczMaHSdrt0yMr5c2xbQjOeraoCbS/TCk5Cask7NekM9w8mD0wWsCTC9L9UtHwU9qu2W7bAcJK4tdW2YjL349iEz5WsZUXmDtzPnZ6v64ZMIhSykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897793; c=relaxed/simple;
	bh=q/1QhneSb11NvV/fvk1QL9Xkqd4utwYNamKOpWUGrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8KEPEgSGO/3TyfrIinmsvKnO0qa0tMmkP5OF/IYalGnzE2ceAxLQVo3ozw5PCdEuzcHknLIvmJSGGdWvueZQFCXQjSYnkoA0Zjiji5tIZwCH9XdihGRybQaYf3TpMgbtuZOQ20Rxn3TqQOxbKuSDASu+fmJo6iHmEyty6XP6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mn0LK12W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mn0LK12W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897792; x=1817433792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/1QhneSb11NvV/fvk1QL9Xkqd4utwYNamKOpWUGrsM=;
  b=Mn0LK12W1EtFaqGdi78Iy9EmMstdO9fdAYikykTZp15NITqhqdPK0zDj
   Ur6umH8kKX/tx/KIH2mab1A/yGzHkkgm5dosgRd9W0kGtU0qwpdZZ6StC
   VTFDYGWXirtdc2FB1lXbd1WN1DjBUlzqd8nTplU/xIaDO/Lha39/yP2eK
   V+LHL5PDZxH4CZqll3/Z/g9soMVO9ONc8nYoBJPuEJtjLc8O5MmhlcZPl
   JAy/wW2nnJN/vktBYKneHLkeGppNgUliXUv/KTJmquks5n9RvQaf4tb2H
   ySwhZ2Mj4EXo94DWYMp4i+BoJgF3mRIt6M4J7FT3CR9PjLPwv7R6oC17A
   w==;
X-CSE-ConnectionGUID: ZAUiSv8mSOeVrE2WSzUltw==
X-CSE-MsgGUID: 7V1/idDOQgOTUQV945BpBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585780"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: 6av2GU2pQXmTZaUmerihKw==
X-CSE-MsgGUID: iCnt8e+LSya/wRvEn/JdCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612679"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 5/8] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Tue,  4 Aug 2026 19:42:57 -0700
Message-ID: <20260805024300.3406307-6-ashutosh.dixit@intel.com>
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
index dbaa387a35613..1a53abbd9a74f 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -216,6 +216,21 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
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

