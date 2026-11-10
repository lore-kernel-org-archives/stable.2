Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300632;
	b=wjJA1isUHyAPXrJKGmzin7Cxlm3M1xUHtEWNrlFqYAuEyJYAAXZ/IN+G1z8XhmGOhvQP
	 tQe5HETGnQSX6Ik7++wx1aY6YMHnhwGauE/NE0jQxJFMIw3nddfvN/GFIqyMJy2C4QaD9
	 mUN4fVra0f74UEY43kzz3rjCbl8neCUsAy55niCOsXSNY8RhkOsTHgXgOeDRTMXtdN+qH
	 g4qcVtJGXXETZvZAoLktIctM6UMY8Ni9xFvSU7yBZ9B2KWYva0L9qSPvAOZAlep7omNRH
	 WBwo0y54ajv0O/pTaA8P58V/78hK0cCnGsK6cUjPfe7Q+9AcOqhF41XrAGV3FK3zWHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300632;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NjQFAhSeTWIWpT+1S57I9rB95YZoW9dR2wN90LrRZAY=;
	b=427dg95CXi6YamZjFJyTlgbHQsIsT5KP9Ua0H4SWbuX+EytKoZAQBNcslZjIFUwfiAfX
	 3ZNr4AJGWv9dyQ3U2KKxdGYrLaMQz30qmjVm4tHYORX/wBhI2WJ0x4/KUwL/0YJI5gZ1J
	 Xw2UROub5/pFv+XzDGNn4WDo9v0G4LsCUBS4gEhol22xqnqECcnQSGujaneV/X+4OnBKB
	 ANbC7/XGj7SPvAvCz3lONhL4mV+/wQbfOxfe4xF5M0N1VA33ysDYJslQboOfsGmLNEvgA
	 8tbkkU9EjGsHGzrDwak9lg8mqYPcqAry9j13S2yAXgeM9hNiAIxSb8qxsQJAHaOFrEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSssBIow;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSssBIow
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794300630; x=1825836630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q20DvwvqLsFDeT+enxYPA3k8ZsaXV+mv66BbeRUNPxs=;
  b=RSssBIowdKZaj6LcfXmJqoBTk6NpMzr3EVwJEb8/SLG+luwWDV1e2bcz
   Br0liwa78vtjhfBFmX5Fuqhlj6a4VTeFmHvk6i4hau5aZ5k7hoG4pFknS
   mrzncvcPajDq4Prl5i+vRjAM0LA+qxmn4i5QYzuXQt+kI+XSoTTPNIfri
   BrXPM7YRp+nbfoIs1nwNJHT7vn5QTLYwzEji9tVijME3NBKf0GGp2mP95
   e/xIlgJpH5bzH28s4Z4iV/sjTRijbWDpUBxDGn7Fm650kLQXGX1GVVPdA
   zMj2fcOYyB2mR29YKa8vzNmnKZ0hHmj/Gz/aAOwOjcUUskVhqnvHr8P6O
   w==;
X-CSE-ConnectionGUID: qNfRDbpfQ3++lHsMicEqWQ==
X-CSE-MsgGUID: rHOOmgy+TfmB0E1knGBTgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3037314"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3037314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:50:12 -0800
X-CSE-ConnectionGUID: 4qIv2JsKSJaOn1cNj1kayg==
X-CSE-MsgGUID: 5fFetuAMSBaqzAFiMhYQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8399914"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:50:11 -0800
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: Daksh Sahni <swizzguy76@gmail.com>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dawid.osuchowski@linux.intel.com,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] accel/ivpu: Defer recovery until probe completes
Date: Tue, 10 Nov 2026 09:50:03 +0100
Message-ID: <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107174215.15818-1-swizzguy76@gmail.com>
References: <20261107174215.15818-1-swizzguy76@gmail.com>
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

The Buttress, MMU and WDT IRQ handlers call ivpu_pm_trigger_recovery()
once ivpu_boot() enables interrupts. If such an IRQ fires during probe
and ivpu_boot() then fails, the probe error path tears the device down
while recovery_work is still queued or running. devres unmaps the
register BARs and the work faults on its first register access:

  BUG: unable to handle page fault for address: ffffcfc6680200f4
  Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
  RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
  Call Trace:
   ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
   ivpu_boot+0x9e/0x270 [intel_vpu]
   ivpu_resume+0xa4/0xd0 [intel_vpu]
   ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
   ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]

If ivpu_boot() succeeds instead, recovery runs concurrently with the
rest of probe and can disable runtime PM while ivpu_pm_enable() issues
the initial autosuspend request, leaving the NPU active until first use.

Disable recovery_work in ivpu_pm_init() and enable it in
ivpu_pm_enable() before runtime PM is allowed. A trigger during probe
still records reset_pending, runs failure diagnostics and masks NPU
interrupts, but cannot queue the work. If ivpu_boot() fails, probe
unwinds with no work pending. If probe succeeds, ivpu_pm_enable() runs
the deferred recovery and waits for it to finish before issuing the
initial autosuspend request, so the NPU is reset before it is used and
the request is not lost. reset_pending is checked after enable_work(),
so a trigger racing with ivpu_pm_enable() cannot be lost either.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Cc: stable@vger.kernel.org # v6.10+
Reported-by: Daksh Sahni <swizzguy76@gmail.com>
Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---

Notes:
    v1:
    - Link: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
    v2:
    - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failure":
      https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
    - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable()
      instead of disabling it on the probe error path, which is too late as
      recovery may already run concurrently with ivpu_boot() (Sashiko)
    - Run a recovery requested during probe from ivpu_pm_enable() and wait
      for it before the initial autosuspend request, so the NPU is reset
      before use and the autosuspend is not lost when probe succeeds
    - Add stable prerequisite 69a79ada8eb0

 drivers/accel/ivpu/ivpu_pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index aa813262253e..7aee728b19ef 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
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

