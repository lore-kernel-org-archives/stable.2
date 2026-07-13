Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F1306776;
	Mon, 13 Jul 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958167; cv=none; b=KgZ0/1j2E7A6cjGri+FP09ZZX5ORmh1OH+BYcXJ3nfyzleq2TJuRI7ehQ/wmx7CA0j6HPhtLay2aue5KJczFF94drOgjEPiAY6bxNdKmt9z0/662gQ+DO+X1DgTwyGIxrr3dKtE4MhxovByJnnS065K3gIw3vuDGk2A6wIunnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958167; c=relaxed/simple;
	bh=usnlRUfQMi+kIpY+f2d1ev+TXNjf0dTNMkmAhvdAuhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1UvscDJdB+XHzKfat9ChP7hwXCs/0OrvnUF4XZ9dD7ecjmVlqyMkiSuDv/fV8DE1IaezFPpH3XUepXOjm0sM7983teDJ/ezHbUvG1d7YtVz0raw70ObIRD7WLRUMBaey+my0VBO4SOTiW+YWYgMB/pWebnew4Om3kbQdkr13yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfQk2JwQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfQk2JwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958166; x=1815494166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=usnlRUfQMi+kIpY+f2d1ev+TXNjf0dTNMkmAhvdAuhk=;
  b=jfQk2JwQlH2S6LSiwirgHPTgMieIUrvAb0G/kEFnPQSN0gzhmu90R4GT
   OYlcXhmCIzYxX3Oq4cOdv7Xp08oZ2mXpCKp+7+MWWhGyo8r4BWACSdT9k
   7KfieWrward35c66vjpKwoWKSDmHTRT+kzfgfUKQ5McP3naxdpstzgFhD
   QLIwLaWiB5SoFEqYLLxQJW54BKyMEvujIJCCJr1ohG/Td8ZPEqAphXNPN
   H1IMie2qGYNm5dwvGi9YfaKKZuUGmR3qZvY6SSGk8rw5QDjG3OL/f8UC1
   YQCzlR72ixQ5V9vtG3oUfjbq62F726+Ylp273NEMP7dEPQnJCQuhqefmd
   g==;
X-CSE-ConnectionGUID: mPqE3p/2SS6LD5FWSLo/wA==
X-CSE-MsgGUID: 1BWqbw+ERY674d1QX4bQlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88393409"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88393409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 08:56:05 -0700
X-CSE-ConnectionGUID: xUShJ/UoTMuUDL2JTKyxAA==
X-CSE-MsgGUID: Xh6mQCHcQTqfB2Na1Mm7vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293774647"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2026 08:56:02 -0700
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
Subject: [PATCH v4 0/3] drm/xe/i2c: alerts and controller enabling modifications
Date: Mon, 13 Jul 2026 17:55:58 +0200
Message-ID: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The hardware challenges that these patches address are so severe that I'm
marking both of them as fixes. In both cases the GPU may silently end up in
unresponsive state (or worse). The second patch has been refactored so that it
includes the direct AMC alert handling in Xe instead of the normal alert handler
registration. The subject lines were also changed to highlight the fact that
these are fixes. Ramesh helped me with the testing and with the implementation
for the AMC alert handling.

Changed since v2:
- Added Fixes tag to both patches.
- i2c-designware is no longer supplied with an interrupt so it will be in
  polling mode (ACCESS_POLLING will be enabled). The IRQ path in hardware can't
  handle the amount of interrupts the i2c controller generates. Only the
  interrupts from the SMBus Alert line are left enabled.
- The registration of the default smbus alert handler is dropped.
- The AMC alerts are handled directly in Xe. All the alerts will cause the
  device to be declared as wedged at least for now.
- Cleanups proposed by Raag.

v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/

Changed since v1:
- Global header for the DesignWare I2C registers which meant a bit of
  patch refactoring.
- Selecting CONFIG_SMBUS in CONFIG_XE and handling smbus in xe_i2c.c instead of
  separate file.
- Storing the alert device to the client array and providing enum for the
  clients.
- Allowing other fields in the IC_ENABLE register to be updated except the
  Enable bit.
- Can't sleep in xe_i2c_disable() so using udelay().

v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/

This includes support for the SMBus alerts, and special handling for the
IC_ENABLE register.

Thanks,

Heikki Krogerus (3):
  i2c: designware: Global register definitions
  drm/xe/i2c: Fix the interrupt handling
  drm/xe/i2c: Keep the i2c controller always enabled

 MAINTAINERS                                |   1 +
 drivers/gpu/drm/xe/Makefile                |   4 +-
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
 drivers/gpu/drm/xe/xe_amc.c                | 173 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_amc.h                |  25 +++
 drivers/gpu/drm/xe/xe_i2c.c                | 136 +++++++++-------
 drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
 drivers/i2c/busses/i2c-designware-common.c |   2 +
 drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
 drivers/i2c/busses/i2c-designware-master.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c  |   2 +
 include/linux/designware_i2c.h             | 107 +++++++++++++
 12 files changed, 405 insertions(+), 148 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_amc.c
 create mode 100644 drivers/gpu/drm/xe/xe_amc.h
 create mode 100644 include/linux/designware_i2c.h

-- 
2.50.1

