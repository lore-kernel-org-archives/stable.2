Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF13B9DA6;
	Thu,  6 Aug 2026 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996846; cv=none; b=TEo8xo/c6/r0L1NlS50dCQWcuGzXqSVXG0PQnfO934c/2gpQ7+cf9BzrR/SF2ite3urHO+FiM0hhKqcN1xeYS0vlsDCfwXlFi6lLPgF2dGhrr91KaKxOegcIc8y2+cwO7odHmXXDFqOBj95dm2vtxxIbDR7leRWD3OweeQcwZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996846; c=relaxed/simple;
	bh=GrG4vV2RtoebV8i/GVowvCtKF/L/ugb1P9lgKvce0WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3XOt4RtN0NoqFVs0BSZqcmOr7X76w398i9PoQhMW61354KdGfT3qWvsHqKUzzqHWrL7LlesOW8WXRXTM6nIroKlmTYMpqCrlccz7qTETVaHfoZNRTGpzSHYftT0JQkfIh9Mi5hDXOZ/vXRCvLTkLIJcICPq8uN3Cjny0d3Eh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1MCkGgT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1MCkGgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785996843; x=1817532843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GrG4vV2RtoebV8i/GVowvCtKF/L/ugb1P9lgKvce0WY=;
  b=T1MCkGgT7qTESIb2SQUgPPhxSJZYg93lOAbxMIEdidh116Lv3yGFQlTT
   bfTDtjr71D6Z6fxP7fSLwpNcx2jBNNdI4ykjFa9WDpSsKW0cT0rPMIAY0
   Pm0L1/PVXKWvgoE20T3aW9L3IPgZpJiGtY18SjbENQd6uv+ntH4uy38eb
   Ltjp+WLz8uKPoiZ20l6BwWLfYlAB+puFpKiy+ad1LDcuCNZPYbamL2/Xt
   NRgeGdLj9fkLLS6O5vTy5U9rW01ndL41Z8i+8bLm3kFUEfGw6JoCqLjQ3
   zi3HwJi7X+u1D5cNYRjwiBYUa/BZqfRsDlm39BEltS+CtHzpoBvHDbXNi
   A==;
X-CSE-ConnectionGUID: BiahoSG5SZq0MvExZ5JQFA==
X-CSE-MsgGUID: rOSecERQSG2QBFSwekvfUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="98093825"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="98093825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:14:01 -0700
X-CSE-ConnectionGUID: JDnsc6xsRs6bVUK9VMFeLg==
X-CSE-MsgGUID: yyAuJkJuRx2YyMbwC+qOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="260242645"
Received: from serinyeh-ms-7d25.itwn.intel.com ([10.225.65.16])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2026 23:13:59 -0700
From: Serin Yeh <serin.yeh@intel.com>
To: linux-media@vger.kernel.org
Cc: serin.yeh@intel.com,
	sakari.ailus@linux.intel.com,
	jimmy.su@intel.com,
	sarang.sapre@intel.com,
	bod@kernel.org,
	kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] media: i2c: ov8856: fix debug message to report actual CSI-2 lane count
Date: Thu,  6 Aug 2026 14:18:19 +0800
Message-Id: <20260806061819.1359931-1-serin.yeh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently prints the number of data lanes using
ov8856->cur_mode->data_lanes in ov8856_get_hwcfg(). However,
the ov8856->cur_mode structure is not assigned to a clearly
supported mode at that point. Due to the missing pointer,
enabling dynamic debug may lead to a kernel panic.

Instead, the correct number of CSI-2 data lanes should be taken
from bus_cfg.bus.mipi_csi2.num_data_lanes, which represents the
real hardware configuration determined at runtime.

Fixes: c492ec9ae9ed ("media: ov8856: Add support for 2 data lanes")
Cc: stable@vger.kernel.org
Signed-off-by: Serin Yeh <serin.yeh@intel.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov8856.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 9d2b0469a576..6011233a218d 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2318,7 +2318,8 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856)
 		goto check_hwcfg_error;
 	}
 
-	dev_dbg(dev, "Using %u data lanes\n", ov8856->cur_mode->data_lanes);
+	dev_dbg(dev, "Using %u data lanes\n",
+		bus_cfg.bus.mipi_csi2.num_data_lanes);
 
 	if (bus_cfg.bus.mipi_csi2.num_data_lanes == 2)
 		ov8856->priv_lane = &lane_cfg_2;
-- 
2.25.1

