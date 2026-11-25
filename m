Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611474;
	b=opI5/8rdogqhQJM2NxC6ctTpBEVUndU3F3bZIGsjQP3XKpvZw6BU5I0xLAvJ+aBRfhPF
	 Y0IUT2Tub2fCMkIdwEzvcPixHXRL4x/ImK+WeJ3FKFOhefqUjxu+Pdzy3S5XjcujCrH/0
	 ViEw7VdAkQDoKuiTslRbjtSikQCzQEkK5s4oIP+g5k7DO2aZij8ehuiskVakfCspqzny3
	 VDZCKv25BQppTMfZ17P0bCfgnskrC5Bpw4a0byEKi4d2lzgeXuTa4d8C10mcjjYgO6WC9
	 bYFlGw145MVWHEwv5G+wFfBE03U7/D8Cql5fcjLwY6J/5tnaU79XkkTiA4zl+kzdZJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611474;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oaESiLDbxgkH7nDIJyav/1Pj2lVUnOrkISswsRMmEcg=;
	b=CWiDXUpJi5ubxecHiQKbRRF7u9tlgR31trTl6F1EsCJAgn+NPJ3+f3z4xC73+BuYe1qf
	 RPlZ0dyNsXpW5jvHlQN9vgHp/hU7uVgQUJZyKqpAGyrmH4t+yNRxCgSyHLcFrcub/A5Xo
	 CkljPzjDXV3NpKR8G/OwEJm1G1Lm1ZtkfVyWhHGqQZKiO3hpngHdlAkLxCeJ/78b1PAXe
	 0POdIrqipMEU7+koACMfOV7eMXfIZoYPpBgP08JX9VLNRRU7uo7vfMwRDRkK811JIM+RM
	 Csj3rb6H8zpXMtrAzYqC5fhgscO30n93HOIGdit6NsFfRiKTALehxQjdYTzVej9RMqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NAl8z8ns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19662606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NAl8z8ns
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590B01F000C6;
	Wed, 25 Nov 2026 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795611473;
	bh=oaESiLDbxgkH7nDIJyav/1Pj2lVUnOrkISswsRMmEcg=;
	h=Subject:To:Cc:From:Date;
	b=NAl8z8nsUY/4mFmJkjwBnn04Oo7D5OLogAc6w/gBK1msD54W3d0bdst5DCQ1PZMuQ
	 O5m2JPSXeMZ81cixthHrY4sWjYXHgOFJEzlSl+0LH2dyNBIZLsi2flsXwYucw3dKM+
	 gKnfiE8TzQ2gPWGhHt8pU61MKVFdisYUQxS/4mo0=
Subject: FAILED: patch "[PATCH] accel/ivpu: Defer recovery until probe completes" failed to apply to 6.6-stable tree
To: karol.wachowski@linux.intel.com,jeff.hugo@oss.qualcomm.com,swizzguy76@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:49:22 +0100
Message-ID: <2026112522-arrest-octane-af8a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dc61b19db1f77deb4c15bb71e64f46071447837c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112522-arrest-octane-af8a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc61b19db1f77deb4c15bb71e64f46071447837c Mon Sep 17 00:00:00 2001
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Date: Tue, 10 Nov 2026 13:15:34 +0100
Subject: [PATCH] accel/ivpu: Defer recovery until probe completes

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
Cc: stable@vger.kernel.org # v6.10+
Reported-by: Daksh Sahni <swizzguy76@gmail.com>
Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
Tested-by: Daksh Sahni <swizzguy76@gmail.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20261110121534.3566028-1-karol.wachowski@linux.intel.com

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

