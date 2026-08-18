Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608133D4E2;
	Tue, 18 Aug 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035685; cv=none; b=REb1ArlE3+DzIlgDRq0Ne/BseCi+qDdBNq6/NlQQXfr8XGkn85gw8MeF/XOcXVIGCD5+IVwhS4j9nC2DTyjufulT7nLWO4u/nVFVdaRccOq86A2DZO6uHBwwDjLDgilKbiSSRpfCi/FxFKcaDX75gjcDMnVaRJVvyx9Pyrw1DXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035685; c=relaxed/simple;
	bh=kYJKMEgZRvrg/ZmBGoCHoLKuuVLGUWl3c21JlFVTFpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pfq+6Rbp4ELwoy6w0pBAMZHmfeNp0oHM6ZM94BWuBZbsLGMRUlQFTloTSIofwISAZpOcLS5pxoVwUaviaQ0tDKANNV6lw1WvOGq31MC5B8Cw6CkUXV2/j/zBr5EZkWRLufhT73pQSCNKh+8orCQGruTtyF4r0Cld5mVX9KM5zrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJOXoJN0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJOXoJN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787035685; x=1818571685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kYJKMEgZRvrg/ZmBGoCHoLKuuVLGUWl3c21JlFVTFpM=;
  b=lJOXoJN0Vy3gEti8zbu/UxqniLWO68/pvNX6+/U3Y7t9AzV3FeSo1Kwn
   TVLNENNTOhvvpWtw3ZtYROgfO1onOx66QHAdUxfC7b03iJ6h13nNuvUAn
   qElDYPGrHr8odQboao1nW8xkbnJEuEjoQ1YuPKzmRuBtgqiUZrurkxhNa
   dV3GI5mW6+L07uy8fdQrR6cymzJy1F1k9d2uPH8Q1LunawEz6wj1rn9EK
   VwnpIIQti2T6xcWu+PD50zy6XV//N9Ch4VhS6yQ6x3Lnmhassu4FG+D31
   O2tu61Z0yqusAmx9zGZfkwurqRnv2J/yOMxlM5a1t2/FoIh/wyF69TjwP
   g==;
X-CSE-ConnectionGUID: HTX/9UcETg6UEffhHhfASQ==
X-CSE-MsgGUID: 965vwpOHR26XBEcAbgVxRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91200138"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91200138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:48:04 -0700
X-CSE-ConnectionGUID: dvwQPeLBTsipBhtO2dhzRQ==
X-CSE-MsgGUID: MqzIWp3RRXmH4xN95R5LDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="303366159"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 17 Aug 2026 23:48:01 -0700
From: Tao Yu <tao1.yu@intel.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Tao Yu <tao1.yu@intel.com>,
	syzbot+98850521518b962c5bab@syzkaller.appspotmail.com
Subject: [PATCH] mmc: vub300: defer host release from inactivity timer context
Date: Tue, 18 Aug 2026 14:48:00 +0800
Message-Id: <20260818064800.3886851-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 inactivity timer can drop the last controller reference after
the device has been disconnected:

  vub300_inactivity_timer_expired()
    kref_put()
      vub300_delete()
        mmc_free_host()
          mmc_host_classdev_release()
            wakeup_source_unregister()
              synchronize_srcu()

This release path currently runs from timer softirq context, but
synchronize_srcu() must be invoked from process context. With
DEBUG_OBJECTS_RCU_HEAD enabled this triggers a warning when SRCU
annotates its on-stack rcu_head from the softirq path, which can panic
the kernel when panic_on_warn is set.

Fix this by deferring the timer-held final put to a work item, so the
host teardown and wakeup-source unregistration always happen from
process context. Keep the other kref_put() call sites unchanged, as they
already run from sleepable context and do not need deferred release.

Reported-by: syzbot+98850521518b962c5bab@syzkaller.appspotmail.com
Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 drivers/mmc/host/vub300.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd067..21f1b5d6ca862 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -344,6 +344,7 @@ struct vub300_mmc_host {
 	struct timer_list sg_transfer_timer;
 	struct usb_sg_request sg_request;
 	struct timer_list inactivity_timer;
+	struct work_struct release_work;
 	struct work_struct deadwork;
 	struct work_struct cmndwork;
 	struct delayed_work pollwork;
@@ -367,7 +368,7 @@ struct vub300_mmc_host {
 #define GET_SYSTEM_PORT_STATUS		0
 
 static void vub300_delete(struct kref *kref)
-{				/* kref callback - softirq */
+{				/* kref release callback */
 	struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
 	struct mmc_host *mmc = vub300->mmc;
 
@@ -443,6 +444,14 @@ static void vub300_queue_dead_work(struct vub300_mmc_host *vub300)
 	}
 }
 
+static void vub300_release_work_thread(struct work_struct *work)
+{
+	struct vub300_mmc_host *vub300 =
+		container_of(work, struct vub300_mmc_host, release_work);
+
+	kref_put(&vub300->kref, vub300_delete);
+}
+
 static void irqpoll_res_completed(struct urb *urb)
 {				/* urb completion handler - hardirq */
 	struct vub300_mmc_host *vub300 = (struct vub300_mmc_host *)urb->context;
@@ -744,7 +753,7 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
 	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
 							    inactivity_timer);
 	if (!vub300->interface) {
-		kref_put(&vub300->kref, vub300_delete);
+		queue_work(deadworkqueue, &vub300->release_work);
 	} else if (vub300->cmd) {
 		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	} else {
@@ -2324,6 +2333,7 @@ static int vub300_probe(struct usb_interface *interface,
 	usb_set_intfdata(interface, vub300);
 	INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
 	INIT_WORK(&vub300->cmndwork, vub300_cmndwork_thread);
+	INIT_WORK(&vub300->release_work, vub300_release_work_thread);
 	INIT_WORK(&vub300->deadwork, vub300_deadwork_thread);
 	kref_init(&vub300->kref);
 	timer_setup(&vub300->sg_transfer_timer, vub300_sg_timed_out, 0);
-- 
2.34.1

