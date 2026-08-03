Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0C3947B0
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800040; cv=none; b=uXwKW5ZHO5ZKnYX0Jxt0GNUcu/s3pBKHHyP3Gvn2XwdwE3HImH3nyYx4DbKegpfXlf97XxzVeg492YVOJxIKhLVCagVB3eQaRLeoIUDpNo5wTrsVcd25WMQgpqs3HuO5eBaGGoJfE2zpPUn9npH77AUCRfBliLl3ry70rTb0Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800040; c=relaxed/simple;
	bh=2fRHDNrcYy+gycraM9IrJFJUj6vp6m5hT1CPpTkLv3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0ouUfdvWzxfyxVzXjMm/euChiWOavUm05S1KrjM7S3d9jLq7VKaDOMfRnC94QhvFqIDV+zaBW8TUKLbUBwWq0S4VYqjDZu+to+IWWp6KGrCSgUPPx7VRlyX03miDWc8xtzmWLYy6npQdiZ+IChnuenPbmw9MM5kL7TNIr7Wi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys5TqP0/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys5TqP0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800039; x=1817336039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fRHDNrcYy+gycraM9IrJFJUj6vp6m5hT1CPpTkLv3o=;
  b=Ys5TqP0/9I/S/ViOAZr7cZeaFg/dckvGukWAxGzsF6ZFg7L0pJAo4i+6
   eHc8ngrDOBEgFgGvDoIRFh6UWmQMTiy7gq8euz2QI/BS+u1InQHfu7Jg6
   Eef2b0CfDhA8fCVR5a0rFDqWWOnVI0giw/NsH1+EaPBsc3JuTWlEbjkXD
   /1pxemYKisEEP1hJm+J5zS4ZWHxq8+hi0FS8w222IF4549BtXpBGZPTlK
   cxonvJJZ2XGt4/H5fxqzN2aT+9JQj0TLYj5uMSWOoxkp7mnaDvqOresb6
   x6PxK1crCMKHWrDPXGCyBgYTe0YbPeHtMU1/P1K8okePyI9W/f5DvLaKM
   g==;
X-CSE-ConnectionGUID: pbkYWgBKT8a1IfVaN4Kg2Q==
X-CSE-MsgGUID: ge+HCQclTASlmNU66Tv5+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112920"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112920"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: 4hGzMp1nTBuUJT9kuG+LOg==
X-CSE-MsgGUID: mk/gIvPpRtCW0ixwBpMP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838287"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 08/12] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Mon,  3 Aug 2026 16:33:42 -0700
Message-ID: <20260803233346.3277427-9-ashutosh.dixit@intel.com>
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
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 47beb473f6a29..a3a45f470faa1 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -148,6 +148,18 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
+
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

