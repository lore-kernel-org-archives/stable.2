Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB23DBD44;
	Thu, 23 Jul 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792182; cv=none; b=ruT04/RsXM/9V0X6NVBtcC+HCqbwlHJ3ZuV/sW/cblx56ilHT6371c6eyMeNGf9waPrz8AvZh2NPqyq7ibFYbHYG7TrBR650hnqvovzf131iodOjgd6BmJ+rNdoAGdN3xdE51LpMBZSqYVplIvLLQFirEcxwnA2MaI6p8+EqKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792182; c=relaxed/simple;
	bh=GrG4vV2RtoebV8i/GVowvCtKF/L/ugb1P9lgKvce0WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JW5BJtJtMp9GgD85cmla/D28VGWnmsgsWSJ3xE4Ey2ke076cbdpfdlLwiSesITdzqrc1tX3WiHVR7zdxp9YKc5KbIaemkQ1Wj+uivmgTbinvniW9WYmBnMlQZv4eJu7NoMYbnCrJBFoH/rIXxmpPG1ZIyOOxvKenyVe3ph98gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCipW+o+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCipW+o+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784792180; x=1816328180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GrG4vV2RtoebV8i/GVowvCtKF/L/ugb1P9lgKvce0WY=;
  b=dCipW+o+UBjHwdN9HUTh2rULv7tWwk9Jf5vo/1MmytdqYirRQeKKwqX+
   5hHeArcwb+H7sXOwVh+FpcUAp9/9z5XHZJw2f6+AIO+ALUIetsO1td5/3
   y67ZCr4//26WK8eR0bcXfgHt4O4EjDzNFjn7lTzhQQyQ5TJvXmH0KVYfr
   3260s5SDVx/onD8G3QvCc6677mpHWU1d3h0UQs3/doHuoBw/pbBGiYQ8M
   PteATKjzTNRxHz8oG2FRgXsvKW9Q1mKBGGGwPp48iZJ2CsdSfiw6U/YAt
   x6zyVxbX5P9oGm1rqN3EfBjOxJIubUDW067CExfxcvHKfKxVK/ImtX+EZ
   w==;
X-CSE-ConnectionGUID: iDh0HhnBSruBhya1Q0MmDQ==
X-CSE-MsgGUID: JL9ZCY0AQtWaqZjlLrm7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96811114"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96811114"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 00:36:19 -0700
X-CSE-ConnectionGUID: Me1te3cmRGmFNS5sDM6g0Q==
X-CSE-MsgGUID: hR1hqNHTTXS4fYAORG2KNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="261888899"
Received: from serinyeh-ms-7d25.itwn.intel.com ([10.225.65.16])
  by orviesa003.jf.intel.com with ESMTP; 23 Jul 2026 00:36:18 -0700
From: Serin Yeh <serin.yeh@intel.com>
To: linux-media@vger.kernel.org
Cc: serin.yeh@intel.com,
	sakari.ailus@linux.intel.com,
	jimmy.su@intel.com,
	sarang.sapre@intel.com,
	bod@kernel.org,
	kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] media: i2c: ov8856: fix debug message to report actual CSI-2 lane count
Date: Thu, 23 Jul 2026 15:40:50 +0800
Message-Id: <20260723074050.369595-1-serin.yeh@intel.com>
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

