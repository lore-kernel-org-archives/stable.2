Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE23988F1;
	Wed, 30 Sep 2026 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742229; cv=none; b=lh+j9srww16irO4JwrMiyaJfzT5CX3yuSVz1jvwhMiBDBnK8vOI13QrdoyEGfKnC259mlktpkr9++51zyq4Y8trhzYNodVmEAQBXBn91snQOumMBktfQ+nE34oJZwcY7u5d+lFCqwCjisSXWzRRoT8wlRSoq/lzybnDW7SpsaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742229; c=relaxed/simple;
	bh=tEvoVm92SRcc3wR2MAis5aion0yu5fgJNFcw/tBO724=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wc1FXdvmMEmxnodbuOVA4UKUP57WPCgBfR/KyFp4qA36EOjJ/5WGo+alOA6L5mGADZjxXlk3s+xFBdZZHEfTPkGulSHp7AX1fgPGYwm6e5lMQgIOXd5xctMuwaoAjRA57Gx6GYUdaY3MjUCHXNvokTWExJW3X4+BGfV/KDGeYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MkPkekU5; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MkPkekU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790742226; x=1822278226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RQ6LqhJbtStj/8tHMNPMmnW3TQt00oYBZzWuVKWCB3Q=;
  b=MkPkekU582gC53PSM1CoPia5UWPvOuE3oMzmgA1SIwNtySYw+58tOogn
   K70KFW3r0AGTsY8zffuMiW1VsS0OZh0AsLfie50qjN8Hwk15MiGcPEkAk
   O2tb+zrMtirAMBWzoVsjUGLMX1bvCZsXxrbxYUfXzN9n/vnU9HFnNZgxu
   FcD2ZWL1rCfEknBzt6CWKUH/crKrTiltUWU/cc/dqSr8FF/nKcpxiec7I
   7zK0INTFRrqlYTilYSRfLVXBJ+Zd072X+jlG4gQgBR/P+1ocX5quVQT6u
   b4SHpAek0XqJOsoenchqPTyyFWWxJtOZm8ze8KP3M6TZcfpCTT499vJdP
   w==;
X-CSE-ConnectionGUID: cdD7yDeQRGqxoLYNo2TGHg==
X-CSE-MsgGUID: aIOTW6p8QnOm+r5EJIID6w==
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="29768869"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:23:45 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:20470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.150:2525] with esmtp (Farcaster)
 id 1ec46623-0066-4971-b55b-0db7cef9ddf5; Wed, 30 Sep 2026 04:23:45 +0000 (UTC)
X-Farcaster-Flow-ID: 1ec46623-0066-4971-b55b-0db7cef9ddf5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 04:23:45 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.60) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 04:23:45 +0000
From: Nathan Gao <zcgao@amazon.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Nathan Gao <zcgao@amazon.com>
Subject: [PATCH] ublk: return from ublk_wait_dev_ready_and_lock() on group exit
Date: Tue, 29 Sep 2026 21:23:35 -0700
Message-ID: <20260930042335.16199-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

START_DEV and END_USER_RECOVERY wait in ublk_wait_dev_ready_and_lock()
until the server has issued a FETCH for every I/O tag. ublk defers both
commands to io-wq, so the wait runs on one of the server's io-wq
workers.

If the server is killed after fetching only some of the tags, the device
can never become ready, and the wait can only end on a signal. The
worker receives the SIGKILL too, but io-wq workers consume it without
exiting and then run the queued command anyway, so the wait starts with
no signal pending and never wakes up. Meanwhile the dying server waits
for that worker in io_wq_put_and_exit(), because io_uring_files_cancel()
does not cancel a uring_cmd on a non-io_uring file.

The server is left unkillable in D state, and a warning shows up in
dmesg from WARN_ON_ONCE(time_after(jiffies, warn_timeout)) in
io_wq_exit_workers():

  WARNING: io_uring/io-wq.c:1373 at io_wq_put_and_exit+0x10f/0x2d0, CPU#5: kublk/215924
  Call Trace:
   io_uring_clean_tctx+0x85/0xb0
   io_uring_cancel_generic+0x171/0x340
   do_exit+0xb7/0x470
   do_group_exit+0x2c/0x80
   get_signal+0x8f8/0x940
   arch_do_signal_or_restart+0x24/0xf0
   exit_to_user_mode_loop+0xed/0x440
   do_syscall_64+0x22d/0x500
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

tools/testing/selftests/ublk/test_generic_17.sh, which kills the server
part-way through a recovery fetch, hits this in a few percent of runs.

Fix it by returning -EINTR at the top of the wait loop once
SIGNAL_GROUP_EXIT is set. The flag lives in the signal_struct shared by
all threads, is set before SIGKILL is sent to each of them, and is never
cleared, so the worker still sees it after its SIGKILL is gone. If the
kill arrives after the check, the worker is woken with SIGKILL pending
and the wait is interrupted as before.

The hang goes back to commit fa8e442e832a ("ublk: honor
IO_URING_F_NONBLOCK for handling control command"), which moved these
commands onto io-wq; before it, the wait ran in the thread that receives
the fatal signal.

Fixes: fa8e442e832a ("ublk: honor IO_URING_F_NONBLOCK for handling control command")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
Tested on v7.3-rc5: unpatched, test_generic_17.sh hangs within 3-45
iterations; patched, 150 iterations with no hang.

 drivers/block/ublk_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..dac3084cb86a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4440,6 +4440,14 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
 	while (true) {
+		/*
+		 * A dying server can never make the device ready. On an io-wq
+		 * worker the SIGKILL may already have been consumed, so check
+		 * the group exit flag rather than signal_pending().
+		 */
+		if (READ_ONCE(current->signal->flags) & SIGNAL_GROUP_EXIT)
+			return -EINTR;
+
 		if (wait_var_event_interruptible(&ub->nr_queue_ready,
 						 ublk_dev_ready(ub)))
 			return -EINTR;

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.50.1

