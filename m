Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8236B913
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800042; cv=none; b=ZQcDGwa/MkfW4XtNiK4AEKrA9Lp1fzzLbZzJJFWK84ZJPQ/eQXCvkPD7VVykIgtKDedWv9Nk0ay/TpBEGARJ86cFzqMuJA5gBu2yOwU1h7m66ZFGma9DqUdF+9i559X6o2OzxhceVduiy7XTQ2OcOqNBqJhvUeYb4nnCyzbCq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800042; c=relaxed/simple;
	bh=B+GE3tvrzNB4fnD3OS5vOAvjbWRRa0CQ3hpdxBLivVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdH6nTqvQlO62I0xNa7o/Kg7Dte6CxzYH3wslA9s5hSItet9aD68C5KVrTxvGjZGAHBQwYZxU7QufZzXRAAShNhRm1/+6CCk+iq7B+ioTxFx13bjC5caYgxWEMzVuEcKzbwjilXfgZTl54R2pbc6XOWi7WTI79qua7XnGO+j7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl7IhRpJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl7IhRpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800041; x=1817336041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+GE3tvrzNB4fnD3OS5vOAvjbWRRa0CQ3hpdxBLivVI=;
  b=jl7IhRpJBnyiOXrgq+dLROzPV2qh7h3jEWN/isVxZCiVjnNNBlOBON6+
   iKJ3Z3MjBzWuh2az3fidx1sY9IpNkEF/e8qcxs7mbKqeNNPozJ4zst8cY
   qJPEviFd8WHdZNieMzRNSWTbES67dzekg2WIA2Team5C8J3rj7iwD6ExH
   DgH0oB2N5ES63SG4D9zibIvQhXqtoJ0RylfJg3bszWGQkh2MA6voljBXw
   /BW5w8pZX5Ko0C0wifvFF78uODeEQO50Iu/EXRwJiZpaoyFYLSknJSKMj
   6moeTzo0VWo40CQgDETNgVsTgGpjP8NdW+y5D1D5lF/xY6EBp9LFbenxF
   Q==;
X-CSE-ConnectionGUID: HuYTN2LmQBqrXsT0L1qUlw==
X-CSE-MsgGUID: CXEBkX1ST5O9waYqxjvmdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112924"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: RT2zwy0JTRePB1ZgWeXWTA==
X-CSE-MsgGUID: j8M7PodoTCeFAWcuHRQa2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838288"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 09/12] drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
Date: Mon,  3 Aug 2026 16:33:43 -0700
Message-ID: <20260803233346.3277427-10-ashutosh.dixit@intel.com>
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

