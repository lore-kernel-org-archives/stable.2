Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BA25B0BF;
	Wed, 15 Jul 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129519; cv=none; b=F5xpNXo811bVVZB7tWVNf9ou1iyIF0f3A8suoH27gQDvb51zRZfNaKIfW5+EVngSL6Udm7e1KW/LsEGVXRYZ7UIWn6+UWRsdpVRxgHgv8K87M5bJlZqzc/LJecLPxbKzYYta8H0VUx+lgh0ihyefW4fJH2eETeeDlMPpcBv7Qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129519; c=relaxed/simple;
	bh=FBDfEbbD0ZBsCKoS9kt+d1+KGWXl4hcd6C91pS+Epmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNlqSAsCMJmKSFWdhZ2L9RANUv1mrEnoDibh5bqec5fn8azt4tjqlNWDCT+4OgdltVO2K56XneumPTo5nVlu6j5qFSZkpq4A6bSKGQ8FnDbx7fB/q1ZZmecgJ+m3/evTT4yRqLhGYDUU2yGgzaWMSb7UXGNgMPGopP7wyNwjAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMzB0g1t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMzB0g1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784129517; x=1815665517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FBDfEbbD0ZBsCKoS9kt+d1+KGWXl4hcd6C91pS+Epmo=;
  b=DMzB0g1tOR9tdgCjQ/bTnuamm/6LrcngFBQFsEEE9mTig0Qq4sumPcqq
   4x5svspEW0Oj/uOxmId3lyvvyyIG/pGI+LqVmkW6sX6c8EO4WTlNI9ARq
   8mYcOGbelLIqFxzRwIeRdJKg1SXc7VJTCAXqL0oX7K8HzZZVruow56zN3
   owgU53iPGIYni86+GCeQoY6ae+lT1jlOUyN54F7lKDRgcyAHC9SjZPIVe
   JCSpjePYw/rrNofrdpWPeaC4AtlOCkWwlJSHxUxkJ33DYjf94v2xZ6AW3
   LU6GslhLa6deUzIsDqQB17gQMqK8WhcQFLG+41/eLkjCjo25604FA0lW1
   w==;
X-CSE-ConnectionGUID: RI4iQOPdQiaY7AIonN18xg==
X-CSE-MsgGUID: +M6dL+ORS227fw7nrC7+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84654748"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84654748"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:31:57 -0700
X-CSE-ConnectionGUID: Pzqu46wTTuGKj7W3nTjyqg==
X-CSE-MsgGUID: l9avW3+aS26/8oP/WgGbPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255093475"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 15 Jul 2026 08:31:54 -0700
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
Subject: [PATCH v5 0/3] drm/xe/i2c: alerts and controller enabling modifications
Date: Wed, 15 Jul 2026 17:31:50 +0200
Message-ID: <20260715153153.1243751-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changed since v4:
- Moved the interrupt deassert/reassert to the wq.
- Now using the DW_IC_ENABLE_*.
- A number of cleanups proposed by Raag.

v4: https://lists.freedesktop.org/archives/intel-xe/2026-July/133085.html

The hardware challenges that these patches address are so severe that I'm
marking both of them as fixes. In both cases the GPU may silently end up in
unresponsive state (or worse). The second patch has been refactored so that it
includes the direct AMC alert handling in Xe instead of the normal alert handler
registration. The subject lines were also changed to highlight the fact that
these are fixes. Ramesh helped me with the testing and with the implementation
for the AMC alert handling.

Changed since v3:
- This was sent for internal review only. I'm sorry for the messing up the
  version.

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
 drivers/gpu/drm/xe/xe_amc.c                | 184 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_amc.h                |  25 +++
 drivers/gpu/drm/xe/xe_i2c.c                | 163 +++++++++---------
 drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
 drivers/i2c/busses/i2c-designware-common.c |   2 +
 drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
 drivers/i2c/busses/i2c-designware-master.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c  |   2 +
 include/linux/designware_i2c.h             | 107 ++++++++++++
 12 files changed, 426 insertions(+), 165 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_amc.c
 create mode 100644 drivers/gpu/drm/xe/xe_amc.h
 create mode 100644 include/linux/designware_i2c.h

-- 
2.50.1

