Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650569;
	b=MSZuGXJZfJt/g+/7dsol90uda3mz78iPmE8Ir1+Ey+dEaUltFiAKtdSlpX8qwe6+f6uh
	 bK/32nq+xumdbm9PtIpxRJ/Py0EsHXDIAnCW09wCLbHnr6X7DcHCvzlwRVNUgZILEjmPf
	 MOe8ytCXZHbY1mdvl+AFc0RbLgtTfloSR2ebP/Vcuw0RbVAvNkZmp3ZxDJTWYGjKkjM0I
	 LcPxGXstrL7XeDIFFMuLb5ZuIsMaz6UCQUCcQvx5oBu0h38uJXvEBRYHGuBm/YGBft2va
	 TbZ/dY1wp0kcnHknNUbiItw84IVhAZFbbR3dO7/DBTC+tRf80e9nitC/8EotK3h3uSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650569;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FZsPRwC9QHaR9jcTSJ8HuiB2rU63S/qivo88BsE7+XY=;
	b=cyFlZSR8V8q9Cl5F+Rg03oyb3zD9F6V02AiKyFe3yVDBy9DGLOSyt70fpsCrnpIBjDKS
	 SFBrCa6yS7gaDVCxNDYvCfVssKVnE4y7rnPIGd0LUmKf2mAMrG0RyLfRq/WWgP6ODwzT/
	 /OJV2RxPNPjfaQGowMwpjIU2eP7sNKLNte+Msxg9hKeFOhqJLJSP1IADUU10ayxfzhPQg
	 M+olJgGc2u8+3rE8ZPoJTc6BWHU7HYLBQ6XA7/zWNgiD+DtHWRFONoXOijk6gdoPefg4I
	 fikzhil56Nm7FXapFrtX6+cakVaTDwtr3hrfeQEjz62qh3QNafZoEN87IxgiY4CQm0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnKMOA0U;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B9606A31E;
	Wed, 25 Nov 2026 23:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnKMOA0U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795650569; x=1827186569;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=GwxuvubctCIhxKYRMcjrGACjthFwWFlRdvBOk/t76TY=;
  b=cnKMOA0U8cJjXAGdXO9DzXkV3xb8RCMeaKrbHTOCv7x8moVU+C66V1a3
   p+R8ESc1LOP9FBHlM214HEAC/k1ciGH6VI9yTdfsN0WRxXt+JM1c1wKr+
   +bLcMc0q8ecKxThsJ1oWopy6bDmuZwCKm8wBS7Hegom29m0Ds8igGSdcL
   BuYa1oU3yh65kQDweNQPDMatvbo5Yi7KXbZCAvLkQ/St7xhsrbXKqNWcc
   F7Mouw6bzVvxijfo4s5g0Qjb9A9IUr1gbMsX9SeQNMb3WCbx45d4Dh47G
   /gKFM3nSJdE1LyVWix1zNB+/hF0aZaB0q2re3rZvhGjv2AAiLlIuuGshM
   g==;
X-CSE-ConnectionGUID: ViVjLHbhTPurtNg/P3uXoA==
X-CSE-MsgGUID: cmj5mPUvTG23Sle9ByNhNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4597261"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4597261"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:27 -0800
X-CSE-ConnectionGUID: wjmYA4SrRZCoT02I7/4nZQ==
X-CSE-MsgGUID: WnsQZx1kTy+hyQEibeTojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873820"
Received: from vcostago-desk.jf.intel.com (HELO [10.241.240.61]) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:27 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 0/8] dmaengine: idxd: More error handling fixes
Date: Wed, 25 Nov 2026 15:48:58 -0800
Message-Id: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBBFf4XM2pppy0NZ+R+GRQujjFEwbUUM4
 d9tcefy3Ln3zAKeHJOHOlvA0cSexyGC2mXQ9ma4kuAuMihUJR5Qi3eIydyJC8/khTRYWlserSS
 EuHk62g5xcm5+7F/2Rm1IktTo2YfRfbaHk0y9zS1Rqj/3JAUKjUYXJs8LrKoTD4Hu+3Z8QLOu6
 xderdJSvAAAAA==
X-Change-ID: 20260803-wt-idxd-fixes-1a06bb69b1e0
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org, 
 Jingyi Li <jinli@purestorage.com>, 
 Bogdan Codres <bogdan.codres@windriver.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650562; l=4195;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=GwxuvubctCIhxKYRMcjrGACjthFwWFlRdvBOk/t76TY=;
 b=mSp/nLKRjUNcKHviku27/yDdceEcs817HSUr2gsqxLApYieNsGsPNPgS29qiUjU8qCYmbe0Gy
 9y2BkC9ia0FColhh69eELmVqrXoASWNklDf9OJDZoJENAVpTuw/2jHe
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

This series fixes error handling in the idxd driver.

1/8 and 3/8 fix crashes seen in a kdump kernel, where the device reset
fails during probe. 2/8 fixes the same kind of double free for failures
after idxd_setup_internals(). Jingyi Li tested them on 10 systems with
DSA. 1/8 to 3/8 should be backported together: with only 1/8, a probe
failure after idxd_setup_internals() still destroys the workqueue
twice, and a failed device reset still double frees in idxd_free().

4/8 to 6/8 fix the device registration, idxd_cdev_open() and WQ setup
error paths.

7/8 and 8/8 fix terminate_all(). Since v7.0 it releases the WQ's
interrupt handle, so later transfers on the channel fail with "Device
error 0x19". It also sleeps, and frees descriptors the device may still
use.

7/8 and 8/8 overlap with two patches of Daniel Byrne's series, "dmaengine:
idxd: keep the interrupt handle across terminate_all" and "dmaengine:
idxd: quarantine terminate_all's descriptor slots until the device has
drained":
https://lore.kernel.org/r/20261019150630.4026341-7-daniel1.byrne@intel.com
https://lore.kernel.org/r/20261019150630.4026341-10-daniel1.byrne@intel.com

Left for a separate series: currently, on a shared WQ, two opens by
the same mm share one PASID entry, and closing the first one removes
it, so the completion records of the other's page faults are
dropped (pointed out by Sashiko on v1 5/6). Proper support will be
added on a later series.

An AI coding assistant was used to triage the v1 review comments, to
help write and review the v2 changes to 4/8 and 5/8, to help write 6/8,
8/8 and the INVALID_INT_HANDLE check in 7/8, and with the testing.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Changes in v2:
- 1/8, 3/8: use () after function names (Frank); add my Signed-off-by
  instead of the Acked-by (Dave)
- 1/8, 2/8, 3/8: add Cc: stable and Jingyi's Tested-by
- Move "Fix potential double free on probe error path" (v1 3/6) to 2/8,
  next to 1/8, as they need to be backported together
- 2/8: keep flushing the device workqueue in idxd_cleanup_internals(),
  before the registers are unmapped (added after Jingyi's Tested-by and
  Dave's Reviewed-by)
- 4/8: also stop the registration error paths from dropping the
  device references that idxd_cleanup() drops again (Sashiko)
- 5/8: fail the open on xa_insert() errors other than -EBUSY (Sashiko),
  and disable the PASID of a dedicated WQ when ida_alloc() fails
  (Sashiko)
- New 6/8: initialize the WQ XArray before the WQ can be released
- 7/8 (v1 6/6): don't release an interrupt handle that is already
  invalid (Sashiko); add Cc: stable
- New 8/8: don't sleep or free descriptors in terminate_all(), leave
  that to synchronize(), after the drain (Sashiko)
- Link to v1: https://patch.msgid.link/20261012-wt-idxd-fixes-v1-0-30a35a445077@intel.com

---
Steve Wahl (2):
      dmaengine: idxd: Do not call destroy_workqueue() with null idxd->wq
      dmaengine: idxd: fix duplicate memory frees on initialization error path

Vinicius Costa Gomes (6):
      dmaengine: idxd: Fix potential double free on probe error path
      dmaengine: idxd: Fix the device registration error paths
      dmaengine: idxd: Fix error handling in idxd_cdev_open()
      dmaengine: idxd: Initialize the WQ XArray before the WQ can be released
      dmaengine: idxd: Do not release interrupt handles on terminate_all()
      dmaengine: idxd: Don't flush the descriptors on terminate_all()

 drivers/dma/idxd/cdev.c   | 12 ++++++++++--
 drivers/dma/idxd/device.c | 24 ++++++++++++++++++------
 drivers/dma/idxd/dma.c    | 47 ++++++++++++++++++++++++++++++++++++++---------
 drivers/dma/idxd/idxd.h   |  4 ++++
 drivers/dma/idxd/init.c   | 27 ++++++++++-----------------
 drivers/dma/idxd/irq.c    |  1 +
 drivers/dma/idxd/sysfs.c  | 43 +++++++++++++------------------------------
 7 files changed, 94 insertions(+), 64 deletions(-)
---
base-commit: d460a02aa0ac6ba9e5d87f8462f75d78be83146e
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20260803-wt-idxd-fixes-1a06bb69b1e0

Best regards,
--  
Vinicius

