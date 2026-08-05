Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7523932C5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898171; cv=none; b=Ynxrw94cr/1271BVxJd8DS1iQr406qR06WzXK92bhNBqnZuBN38CnZxTK7rZHYM9RIfj9chJGJWJzFb7adcNMgwRdwdM/M0RXBN+6AXNG64hP3DdCqQCsvv3EoVugFkqxZxPlA0CLJixdXMDvHBsN/Lgc4RZOSOeR841raUYXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898171; c=relaxed/simple;
	bh=J0cnlikwYZ8YaOIpsI5FbjMAyxW/S+KBe5ZQP1Sjjx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwyhovQKENXRfEY26BhxlQvwJSHB4yB4sehPUlpethZ342Dp5l5GJg/lEvwwsC/+DGXLjnwZSdzA1X7wXaqnEy2d8OR8crAiraQLQvz7Pjv3Gd0RD3nkklgwb6clVgRYXiGTRHd+/GwmmIT/T0Vy1YehQvAHmTy8GkAeqWJTkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4QZw75u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4QZw75u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898170; x=1817434170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0cnlikwYZ8YaOIpsI5FbjMAyxW/S+KBe5ZQP1Sjjx4=;
  b=k4QZw75u5TZzfv0Z/xLnFsGrqmHZsDmJ8YTljRHL+zHmzQPTQtFPLE6i
   pBAzETG4uTH/677H+SFnITzn6xuO0BKNLjGnwODsfpI23n6fTA3ztsQHX
   sPC/lmiBMh+IagSPVDxDDZlODxNcdh4EyT2VVhYqQp78+61nfC0ovTuFF
   det6wBC6DeSpZUqeINCFxw+T7o9wsnZSgzUttel6cumqdzHCfl9DE10aV
   6sgS+OrnsBjOz2429vhu0lUTaSBICfPHab78XPMj5oFc6EKChVcelu5JT
   Wnahw5Dch5GDEGFLBP1bEVVgPbgonevq+lwajep8KX+KxsnTvN+mqKWUh
   w==;
X-CSE-ConnectionGUID: Gdm3l5VkQJW4QfUYHNrAwg==
X-CSE-MsgGUID: ePPcQJZZRMiZnbN6cpSe6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826138"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826138"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: ZatU0n/rQaa5oyWIZRRNew==
X-CSE-MsgGUID: 2la+AGPeTdi7cFM0sUGaDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911799"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 09/12] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Tue,  4 Aug 2026 19:49:12 -0700
Message-ID: <20260805024915.3407033-10-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
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
index a3a45f470faa1..39f577a0cac71 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -162,6 +162,21 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
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

