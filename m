Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312949;
	b=2vS/n4hAacC3cuhjdNIVrQebV1GXoGUJJ8uW/lVB0J45EFTprz3SW/LpRBHwaHonHMo4
	 tg4KBO04TwVja/DfSrMVg5QzTMGM0m5G0l3l/Bw7EYPUPPIM66rytkENyYWP4F0gMoGej
	 TpX/pA5D1hjNkCMlXbzITjy1nlrd3NIC6nG4zkDoC72o0V5v+VlQDEA8Qm/QUprTqGFVy
	 RN2WQ64TIDgdgUDQgzkfHwRKgwezejaJSUfUxPGkCeOPPaQ+4vU7zt8nHRwnQlNWzVERy
	 Ay8911UhIztEqfsCwc8mT6X1SGjfPVC0qHMEpVpxPzOI1hpy8wU2jPD7gAbOP+xi20Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312949;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hLL9hgbbpD/qooLOEtJXDVB9p4qL2B4zHza+GUzc22s=;
	b=CRKaMD/W8r02MhvpiLbP7CFXjeCnDMS4jLv9o08YDOtjbuDw/lsJpMNH7FA5bQ8hd8HE
	 6zK2B5TsB5GmltuiaGu8uV35mwDT3J2Gs4/2G0fyEaFRr2vnd1Xm9avPCHZvRleWp5XN+
	 g2vI6GJCOlmsEFtpblJz4no51Uh5+OEZ2LJyaBz+T35Hx+CWvchdTBu23pzf54cVQuroK
	 Wf8H6xLfb3abwXqwRCb+7epu/kQpcophkYztCQs+7RP0+DhzUFgCh9PsdNZ9yRscR0d9E
	 +TmxIcsGXYGwyT/lF1YKa9l/Z6r4UtZn9bTfzwaqX47zzzWWW9oW3Sx6CVi4tBt5CSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWqDjOED;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECE9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWqDjOED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794312949; x=1825848949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l8AZHUbBT10rst5OFdt5Z0mDYj7qQK9sYESz6Ge7jes=;
  b=kWqDjOEDzj9wVNPTkfIEgvY4VcxmMm7p7rEhIKDfUV0iTcCzD2AUIFyM
   ebmiCSwwlOYCYTrRmdH/kJt5B5A2JnBtElkC7ezsLo0rI7vnKy6hItu2O
   XXz1MM36mtRwpHXnIhd9HGOj5M6HiBTJWkmb5B1IdK1BmxVKbWu9tp4pX
   JnUsVGkPYEECXDJCWFbViQncEfTWqOBeL467uPDprx+3oyr4Nk+cISX5v
   kwYCT31I9RMb7GqxFNak2XZCSup+K8EM/BmyilNgJ/nMiIs04dFWAYoJM
   VU3JbDP7u8gLVBAsalasZKjSpRIemCdgPQxoY8NyRFzaWAfJnQ6BwlH5U
   A==;
X-CSE-ConnectionGUID: ThMZpyAvR8qoyGf0yZkN4A==
X-CSE-MsgGUID: DuXqHjn/TDmDu3aNxOSY9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2962379"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2962379"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:15:48 -0800
X-CSE-ConnectionGUID: ed6m2X4pRcSXwkMq9opBfw==
X-CSE-MsgGUID: JfABqc8UT1i0jAGjSI3Hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8730891"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:15:46 -0800
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: Daksh Sahni <swizzguy76@gmail.com>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dawid.osuchowski@linux.intel.com,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] accel/ivpu: Defer recovery until probe completes
Date: Tue, 10 Nov 2026 13:15:34 +0100
Message-ID: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An error IRQ that fires after ivpu_boot() enables interrupts queues
recovery_work during probe. If probe then fails, the device is torn
down while the work runs, and the work faults on the unmapped BARs:

  BUG: unable to handle page fault for address: ffffcfc6680200f4
  Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
  RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
  Call Trace:
   ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
   ivpu_boot+0x9e/0x270 [intel_vpu]
   ivpu_resume+0xa4/0xd0 [intel_vpu]
   ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
   ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]

If probe succeeds, the recovery runs concurrently with the rest of
probe, and its pm_runtime_disable() discards the initial autosuspend
request, leaving the NPU active until first use. Any recovery that
starts while the NPU is idle loses the pending autosuspend the same way.

Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
A trigger during probe still runs diagnostics and masks interrupts, and
ivpu_pm_enable() runs the deferred recovery before the initial
autosuspend request. A trigger racing with ivpu_pm_enable() can cause
a second, harmless recovery. Request autosuspend at the end of
ivpu_pm_reset_complete() so the NPU suspends again after every reset.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Cc: stable@vger.kernel.org
Reported-by: Daksh Sahni <swizzguy76@gmail.com>
Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---

Notes:
    v3:
    - Request autosuspend at the end of ivpu_pm_reset_complete().
      pm_runtime_disable() in ivpu_pm_reset_begin() cancels a pending
      autosuspend request and pm_runtime_enable() does not re-issue it, so
      a recovery racing with the initial autosuspend request in
      ivpu_pm_enable() left the NPU active until first use (Sashiko).
      A trigger racing with ivpu_pm_enable() can still queue recovery
      twice. The second run is a full reset that leaves the device in a
      consistent state, and autosuspend is now re-requested after each
      reset.
    - Replace pm_runtime_mark_last_busy() with pm_request_autosuspend() in
      ivpu_pm_reset_complete(); it marks the device busy itself.
    - Shorten the commit message.
    - v2: https://lore.kernel.org/r/20261110085003.3527014-1-karol.wachowski@linux.intel.com

    v2:
    - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failure":
      https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
    - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable()
      instead of disabling it on the probe error path, which is too late as
      recovery may already run concurrently with ivpu_boot() (Sashiko)
    - Run a recovery requested during probe from ivpu_pm_enable() and wait
      for it before the initial autosuspend request, so the NPU is reset
      before use and the autosuspend is not lost when probe succeeds

    v1:
    - Link: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com

 drivers/accel/ivpu/ivpu_pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index aa813262253e..e4b79c946ca0 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -150,8 +150,8 @@ static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
 	up_write(&vdev->pm->reset_lock);
 	atomic_set(&vdev->pm->reset_pending, 0);
 
-	pm_runtime_mark_last_busy(vdev->drm.dev);
 	pm_runtime_enable(vdev->drm.dev);
+	pm_request_autosuspend(vdev->drm.dev);
 }
 
 static void ivpu_pm_recovery_work(struct work_struct *work)
@@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
 	atomic_set(&pm->engine_reset_counter, 0);
 
 	INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
+	disable_work(&pm->recovery_work);
 	INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
 
 	if (ivpu_disable_recovery)
@@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
 {
 	struct device *dev = vdev->drm.dev;
 
+	enable_work(&vdev->pm->recovery_work);
+	if (atomic_read(&vdev->pm->reset_pending)) {
+		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
+		flush_work(&vdev->pm->recovery_work);
+	}
+
 	pm_runtime_allow(dev);
 	pm_runtime_put_autosuspend(dev);
 }

base-commit: 54d3ff1b5ac08d0e28029b93a1719ddd9ff670a4
-- 
2.43.0

