Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306008;
	b=rjlcRPDbIrMFtnt/WscM4Tknv0mnGxOlYLcTrqTwpbYLTH6stO9lKLDNdUywn2tC7z0W
	 1xWKiK2bofooH8vaCjZaiWhTW889C6F3D2ECD3wjPtroAAGRWWy8jHUL58ZRkNUiXr48S
	 BITXCILfGVjkrrejpzulramrSI/jeNSf3QRGOgNwIjh3IiPT25Qdpp7A7TLwv8Tl7Cq3C
	 wfnzPkpWdfGTXrBG/UkxIH5YCizcI8MFgX5vpnUhAaR/693IV9IfO79VQSOdXL7K/1pie
	 gEXXEtwgV5bqn7z9iL6QItGmW+0SrYeJHQQ1+55dCbSnZmROm5sF/WZOVtvgyjTboXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3lveHbuvlAIWm29OSBI4KfWvmKMn4MlaR8N+gaIZnQY=;
	b=dvkCBZN/19PZ1e7WTe2ceHeRGWOq/mT6pm2Xrv2yhzFr/UcULuW+XTbEygSFqXhGkx5N
	 1GxiBxErnN9PY0TjzcOXNrM/9DrIrfvFGeX3pjN3bltv8kK3sOsFnnT+5FxSVl6ml+M7D
	 wOx3e6dyjCg5g98hjqMu1k8QkdsP6KMj0MmaYhv7pKQkIwrzdm8cUgQ4gp4TUY0ZTNSBe
	 e/Wk3U8Nt1zNlJcZyLAGYTVEemyTXNubBudp5U2T3Y1enxXj+3lYgon6lLvVc2z9Yjjl2
	 LNQG4ho+ixXB7FPkiYT8f9FZh6r4UFzsIPijuO6q5gL8qeHGLGkIOANLXoacwPG2xqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XSlAvoSj;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37B606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D37B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XSlAvoSj
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so8150a91.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306008; x=1793910808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lveHbuvlAIWm29OSBI4KfWvmKMn4MlaR8N+gaIZnQY=;
        b=XSlAvoSjhIrK+0FlYVA34ci8I/NQe849Jitj5lT9cMRbOjoulPASEQw9BDIcATDXMj
         0M5RkaDtJ8XalpbcJV6Z0EACY063/2S5nXWMLPCRiJEV0pckp61Tpl6W+QVzmu7I767D
         5cZaqDRj1b7rueNhaoEZ6ABocPXkZ1Rdcz8ZHLBWSFg5deK1Y4kzFKybn7OVqnaCU6Kj
         o3TTy3RuMqaam9y2g/UJw/a3h90T7+CufSvMYzw1SNVWpsg1zqA2zygjIC3gMuLVs1W9
         2PjCoKfpA/63Ipt0pzeznL7X+pTwTXNjCspux4dlwYN8cOkfiVV4BRUFO0quJ8DjDhJa
         gXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306008; x=1793910808;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lveHbuvlAIWm29OSBI4KfWvmKMn4MlaR8N+gaIZnQY=;
        b=dHvMVJAf2J4p/sh7RumuEWYhVBiYjUZTj6O5XN2Yh52xZTGbv5ZsBH5FLprVkw1fbR
         efcheV7QAYKEKudJ1VxA89Z7iD2V0UBLCQSYZjt74wT9uLjA48ZINpgUb/UV8fliAFBj
         KCeRe2Bq8GdpXH5wVbdjVlTH8zkDSTDGG6LW/txOEiQLzSVXVkzszX6cf0eBbztfki12
         kWRd200TxXYa7/ZuxtIRTDmZiRG+IB71Go4yTL8USLCCsBaWB4RUU79qGVGMzXOaaVik
         iHnQ4MgDS4OmVo/t69XB9eBO0M6S7iNjq6ouvxMnSPOAI8zR+RLubRroSckUpe7GWibt
         y6aQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt9Zlf+GOfm94MGR1GgHsJlxKYv/d+2D3MwdEUeIa2kCkmk7A38rxPARymBLhC10RNjQiuso4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIvmZm13OpDatR3EYSPCAgn5trg6JVi4JqC033hGkL1kHFjZiF
	qflpPlFlUD1ALN+qPbfmbBxvEqdma8aPcaeE3qHr3VqxmMjb9fwyJCii1m9ZagoGoOJgeoDQS9L
	uZVfofxjjVmOBlA==
X-Received: from plld11.prod.google.com ([2002:a17:902:728b:b0:2e9:5b68:4b7d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2cc:b0:2e2:df9c:ff71 with SMTP id d9443c01a7336-2eb3646e7c7mr4803995ad.49.1793306007605;
 Thu, 29 Oct 2026 13:33:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:20 +0000
In-Reply-To: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029203324.1637772-2-dmatlack@google.com>
Subject: [PATCH 1/5] vfio/pci: Hold memory_lock for all calls to vfio_pci_set_power_state()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hold vdev->memory_lock for write when calling vfio_pci_set_power_state()
from vfio_pci_core_disable() and vfio_pci_core_register_device(), and
assert that the lock is held for all power state transitions, not just
transitions out of D0.

vfio_pci_core_disable() calls vfio_pci_set_power_state(vdev, PCI_D0)
without holding memory_lock, which allows it to race with
vfio_pci_core_sriov_configure() when userspace writes to sriov_numvfs
while the device is being closed. If the user left the device in D3hot
via a config space write (which leaves the device RPM_ACTIVE, so
pm_runtime_resume() does not bring it back to D0), both threads can
transition the device from D3hot to D0 concurrently.

For devices that need_pm_restore (NoSoftRst-), this can result in:

 - vfio_pci_core_disable() restoring the PF's BARs after
   vfio_pci_core_sriov_configure() has enabled VFs, since the D3hot->D0
   transition sleeps before restoring device state. This is easy to hit
   and triggers the following warning:

     vfio-pci 0000:01:00.0: can't update enabled VF BAR0 [mem 0xe0200000000-0xe020001ffff 64bit pref]
     WARNING: drivers/pci/iov.c:1062 at pci_iov_update_resource+0x170/0x3b0
     Call Trace:
      pci_update_resource+0x1a3/0x5b0
      __pci_set_power_state+0x597/0xb90
      vfio_pci_core_disable+0x13b/0x1180
      vfio_pci_core_close_device+0x144/0x260
      vfio_df_close+0xf2/0x210
      vfio_df_unbind_iommufd+0x89/0x140
      vfio_device_fops_release+0x85/0xf0
      __fput+0x2d6/0x720
      fput_close_sync+0xe8/0x180
      __x64_sys_close+0x7f/0xc0
      do_syscall_64+0xbc/0x320
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

 - Both threads observing pdev->current_state >= PCI_D3hot and calling
   pci_load_and_free_saved_state(pdev, &vdev->pm_save) concurrently,
   resulting in a double-free of vdev->pm_save.

vfio_pci_core_register_device() cannot race with other callers since
the device is not yet registered and device_lock is held across probe,
but take the lock there as well so that the lockdep assertion can be
made unconditional and catch any future unlocked callers.

Taking memory_lock in these paths does not introduce any new lock
dependencies. vfio_pci_core_disable() already acquires memory_lock
under dev_set->lock via vfio_pci_runtime_pm_exit(), and
vfio_pci_core_sriov_configure() already acquires memory_lock under
device_lock.

Fixes: f4162eb1e2fc ("vfio/pci: Change the PF power state to D0 before enabling VFs")
Cc: stable@vger.kernel.org
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..95aee6b7cbb3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -325,12 +325,15 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	bool needs_restore = false, needs_save = false;
 	int ret;
 
+	/*
+	 * Serialize power state changes and accesses to vdev->pm_save, and
+	 * protect the check of vdev->sriov_active below.
+	 */
+	lockdep_assert_held_write(&vdev->memory_lock);
+
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (state > PCI_D0) {
-		lockdep_assert_held_write(&vdev->memory_lock);
-		if (vdev->sriov_active)
-			return -EBUSY;
-	}
+	if (state > PCI_D0 && vdev->sriov_active)
+		return -EBUSY;
 
 	if (vdev->needs_pm_restore) {
 		if (pdev->current_state < PCI_D3hot && state >= PCI_D3hot) {
@@ -699,7 +702,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
 	 */
+	down_write(&vdev->memory_lock);
 	vfio_pci_set_power_state(vdev, PCI_D0);
+	up_write(&vdev->memory_lock);
 
 	/* Stop the device from further DMA */
 	pci_clear_master(pdev);
@@ -2273,7 +2278,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	 * be able to get to D3.  Therefore first do a D0 transition
 	 * before enabling runtime PM.
 	 */
+	down_write(&vdev->memory_lock);
 	vfio_pci_set_power_state(vdev, PCI_D0);
+	up_write(&vdev->memory_lock);
 
 	pm_runtime_allow(dev);
 	if (!vdev->disable_idle_d3)
-- 
2.56.0.317.g454f8302e1-goog

