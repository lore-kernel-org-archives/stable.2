Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5F3806B8;
	Sun,  5 Jul 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265770; cv=none; b=lgNyxflwoHui224QGK2kSnjIZOGu6Gz+rnlW/ES7xSJi09KAOmP0890qPmJdOgra3xapQrg3qsOD3/7wB6Ho5yGugLNQDtJdANT02b9S7r6QwgsPGbMbnUg0sXbvaNb2/3rddGMJeALhWvxZldfdgjO2QYhWhL3botfZZW85gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265770; c=relaxed/simple;
	bh=FIBQTRjSsQkq8zw8MXkPQDQWSaRbf84TlRswMQcNhw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lh3EmmhMmHPGc7Y+RfziPu3OspbQyjiKHynwFLfa52xwSscppRTnVgu6Nh+Tz0+CcWYzo2LzBo+bhDy9UHP/rzTt3ytyuCM0WZZHS7tjT4E7Rhp+WvUBKnhU/GH6Uu7OzRsTGLRSiGqkY5pmPsLLhY9XXrAhD3RDNaBiO4ijY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGZClY8r; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGZClY8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783265768; x=1814801768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FIBQTRjSsQkq8zw8MXkPQDQWSaRbf84TlRswMQcNhw4=;
  b=fGZClY8rhaJr4pZOFdOtx7CqVvcUhk21S+sbrViyZPSTx1xbd5clvlMa
   9tMjK0vSG9pUVjjfaTMw1n2UGEtbnIw1PCla7WWH/AiQTCCgE95WCGTny
   CdpxVyHeEVQc8yepuS0jJBRzaKUHsq5XIynVoy2vFPJR3pr3jXsQ5OSTg
   b6ZLhgNj8XGHWk/f01Id4Ks383E4gE5Ks+VEpICl8dSwlj44jYdhIwb7R
   AROr27F0VHoQn3bA5x//t372S0M/ewXxunXASp9peYWoB4wGMtayVDfm/
   dGLvwOBXZ48GjtY/b9Dr1jXV/FxNwPx+GbqQAQgkLrNuIiFWEeXleCkZs
   A==;
X-CSE-ConnectionGUID: UOWRKppHTby9KEuIMrozBw==
X-CSE-MsgGUID: cm6qBd8RSgm6xTxmT/X/IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95420725"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95420725"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 08:36:07 -0700
X-CSE-ConnectionGUID: RajXxjX/Qy+y66vBiMxlOw==
X-CSE-MsgGUID: bL9jTMeCQJCWuV3HA4loLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249519729"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 08:36:05 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Menachem Adin <menachem.adin@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [char-misc] mei: bus: access mei_device under device_lock on cleanup
Date: Sun,  5 Jul 2026 18:12:59 +0300
Message-ID: <20260705151259.3054795-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix couple of problems in mei_cl_bus_dev_release():

mei_cl_flush_queues() is running without lock.
bus->file_list access after mei_dev_bus_put(bus) can become a
use-after-free if this was the last reference to bus.

Protect queues cleanup and WARN traversal by device lock there
to avoid the concurrent access problems.
Move WARN traversal before mei_dev_bus_put(bus).

This file uses bus variable name for mei_device, adjust
code of mei_cl_bus_dev_release() to use bus variable too.

Cc: stable@vger.kernel.org
Fixes: 35e8a426b16a ("mei: bus: Check for still connected devices in mei_cl_bus_dev_release()")
Reviewed-by: Menachem Adin <menachem.adin@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index fcde082eb5e3..cfb87ab8667f 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -4,6 +4,7 @@
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -1330,15 +1331,16 @@ static void mei_dev_bus_put(struct mei_device *bus)
 static void mei_cl_bus_dev_release(struct device *dev)
 {
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
-	struct mei_device *mdev = cldev->cl->dev;
+	struct mei_device *bus = cldev->bus;
 	struct mei_cl *cl;
 
-	mei_cl_flush_queues(cldev->cl, NULL);
-	mei_me_cl_put(cldev->me_cl);
-	mei_dev_bus_put(cldev->bus);
-
-	list_for_each_entry(cl, &mdev->file_list, link)
-		WARN_ON(cl == cldev->cl);
+	scoped_guard(mutex, &bus->device_lock) {
+		mei_cl_flush_queues(cldev->cl, NULL);
+		mei_me_cl_put(cldev->me_cl);
+		list_for_each_entry(cl, &bus->file_list, link)
+			WARN_ON(cl == cldev->cl);
+	}
+	mei_dev_bus_put(bus);
 
 	kfree(cldev->cl);
 	kfree(cldev);
-- 
2.53.0

