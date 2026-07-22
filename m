Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15278285CB9;
	Wed, 22 Jul 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727362; cv=none; b=b21q8k1ijNMDOB5a+31Kr8xy4FZ8k/9Be1lAn7u93Mt9xxTeWaYUu29jShCRFjLjPrx0NHE+GqTH1/IbLXQ6VZHnq52mt8tC8hmLGEo5DtfsgPexcTeLMrl1x1X+xMybxBFMhR048gM1f2UgPnRn+nzbXjiGOb4TmH1deIVZ4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727362; c=relaxed/simple;
	bh=y0wvHtSgFiZwH8ITcd1jsX94SmFkZXoWNd/tNNe9eKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGWZKKMZaq7GLrSodOBbuPRKExI8tGM0GSHqt+iZvR/2KYcuNy2rRU4aslesu/XfLS4Iq54oJ6q5pukVE50exUKj02P+kzDdKyP8EbUJn6h2XhXZIjpytC4ut4gMRwUksWGZ/dJnpq9IFkwZMEAGDMQYon70gp0wwZWWsuMLSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuNyKZh4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuNyKZh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784727360; x=1816263360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y0wvHtSgFiZwH8ITcd1jsX94SmFkZXoWNd/tNNe9eKI=;
  b=EuNyKZh4wupLrkXvD6NI2AEN6gBnoOzAauJu/egEviOMUIOtlfVe9mfH
   tW47OzU7LcI6cFa74P/RmpTxAEZCW3MeotAyin5lyFPfmMOZMiSwuSV54
   ZnY/aEk8fpKj6ZSBVkPc6L+R7TkKUEPdYlAJ0v9Aw8sQOmdt9VnFqbZbH
   T5SPNu94u/zRF5fjKq2t3hxPi3M/oK8yY3c8doKs/o898nhkk3SD2rruy
   V2+tAb/88KIZH4FpESl3agY9XuijvsFc6U5p+3CJhwA9/0mvbG5lBYP6e
   /g4zxKkoD9BpMxTCmN/upYMlTWCPvYFTQM2iTDavcRkTlhJIzI8zJDZKh
   w==;
X-CSE-ConnectionGUID: e/k5cVNrRQCJsxJLf58+tg==
X-CSE-MsgGUID: cnLbU8jkQwysXYIDau74kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85453386"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85453386"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:35:58 -0700
X-CSE-ConnectionGUID: pvtSgkwfS2yxrXQPaLBcqw==
X-CSE-MsgGUID: OxZ/bLWMQs6H3GinT1Y2YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="263040962"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jul 2026 06:35:55 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v6 0/3] drm/xe/i2c: alerts and controller enabling modifications
Date: Wed, 22 Jul 2026 15:35:51 +0200
Message-ID: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changed since v5:
- Leaving the interrupt de-asserting to the firmware.
- Re-asserting the interrupt before declaring the device wedged.
- Preventing the SMBus Alert from being masked.

v5: https://lore.kernel.org/lkml/20260715153153.1243751-1-heikki.krogerus@linux.intel.com/
v4: https://lore.kernel.org/lkml/20260713155601.711389-1-heikki.krogerus@linux.intel.com/
v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/
v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/

Heikki Krogerus (3):
  i2c: designware: Global register definitions
  drm/xe/i2c: Fix the interrupt handling
  drm/xe/i2c: Keep the i2c controller always enabled

 MAINTAINERS                                |   1 +
 drivers/gpu/drm/xe/Makefile                |   4 +-
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
 drivers/gpu/drm/xe/xe_amc.c                | 187 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_amc.h                |  25 +++
 drivers/gpu/drm/xe/xe_i2c.c                | 165 +++++++++---------
 drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
 drivers/i2c/busses/i2c-designware-common.c |   2 +
 drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
 drivers/i2c/busses/i2c-designware-master.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c  |   2 +
 include/linux/designware_i2c.h             | 107 ++++++++++++
 12 files changed, 431 insertions(+), 165 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_amc.c
 create mode 100644 drivers/gpu/drm/xe/xe_amc.h
 create mode 100644 include/linux/designware_i2c.h

-- 
2.50.1

