Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050F3C0A1A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022327; cv=none; b=ummUUNphnE8P4dJtfgNQfYx0a5VInHG/ZzB8+HyE4lVJxLsW37zDnF2ysJyhhVqkHsgooUEtQFO+90vJpVQxtty+gRWgwoOFmY+a/N97Ev8cTArzoDDO/jAJAzqS1JRyaILl5gSFKits1Jofa8qBzNDe3xL7TQIyUoVGBOvFXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022327; c=relaxed/simple;
	bh=+uVNsC8PLQ5cZxPlsCOIdSwLRtbWGb6Q4b/gIrk0V2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dHOpzuShYfoLIeXIJfRjZ+U5rj04S6KMH91My6nEs5o1lxNse9Ca61RTJV+zdgAjVXOES6zB07+fy4ASScCRYrh+VMDh/swnS8oLJGDn0ea5q/AtiQe8sll1yCuq/IO01wtA+2toWX5QO+2XhwVbYlBOLCFaNJr2ovsB1vLVzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=TsGebiqr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="TsGebiqr"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c9879395so4407948a12.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1789022324; x=1789627124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04LZdWbbV4h34Pdf4Ddo0m60ir31MT0deNLvhJP7A6A=;
        b=TsGebiqrDtTO+F6yjW6HW/ddBPtwfC4N8PjJr+BLke/TyRTViW68k5O8urzhmkT5AC
         k/KLbbezZX+qgdb3ByUkx0Q453NVSXl4+3i2S63QWQMhJEkPlImOiOUOi3bRitrkZ9xs
         Gc/vMBQ/3tJyfa64Arcj9xq8Ct3p1SVwlx7AdaIrJl3p3wOGSdqYKHuhqqAKiXXfyRlz
         bU3YyDD9Jm5hyi36sl6P0V+p6SjItN6ySsXBhY6F4rt76QrNK6smBNWhoIR45Qnk2TXQ
         tXbqcTD9Ip6EUvsUTOF7HBmITYIaizydCf4tRftFMZ/l0L/16I/NcmReWUArXbXu1HRY
         1FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022324; x=1789627124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04LZdWbbV4h34Pdf4Ddo0m60ir31MT0deNLvhJP7A6A=;
        b=qKtSk0fikF/z72Hrsy59V7AzEAtvTIURIm6AchMs5ZHd0faKcd77T8OUd+sDa9P/5T
         E3svcUxbWhg7P/MzwSpQStBe8k0HDuFTgM660a78zhrwjC0UxrFMve1xPy44TKwI9FYN
         PRHQ+AaiGWilzuB9vmDbhYx2+VGTcFoIa2Sjoaa4MiiYNKLvKW+DhfMEkdH5F4/XWMhl
         RO4Yocs9eJln4PkD91pyYklItpHnvQhn3fTDVYdJeQ4yT7khNeJ+MP6cCXu39lVMZnjb
         KQ8+zWLRei0URvPXsVV6ww9UFWP4GU+dMLBEuFnhaXBq2ZiXwtJ8hcFUN9YT5ZLo0QLN
         S9oQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1ubyyuQ7Qt0bakHhRXN+PDUajS+feNlyKhUF0TZiox+UEfVGsEjriwu4UUSxRQXagBESVtXk=@vger.kernel.org
X-Gm-Message-State: AFuF++miIpIfSvxlgHePLw/PWJ/rJCQyDpTokle2xNu69RNtNP8Erdnt
	SPKjAFDwwpaN9tGWpt5kkTsBPoip3nWQARO0D7g7BKodDTW0QwZ+Aq/ArSD05xgJT9g=
X-Gm-Gg: AYBFou0BhJXoYJaBp/fPdvJGY2x32sxZsT9wMJjav2D45YCphehhvLIZNWihJuJxTbU
	kdVCOJzYKI64rtGXoyFP74wtIu1T95V3yEEH4QY3iiVaU7lZKPOg7zE0tHFypFvhIwwSdIRX89T
	aMtv+1VLmeOJ5AG60q0TLiwiUGeWfdIuizAmlbvOIcgtFKdGJ+7psvedFDBirdugiXEeUpynTDb
	uOYQ/yiVgNyKcZFUJvyZSgJi65RIWQdPuykKytyGV/igBO5g9BD3MN/JDSct6WuNKJzAeT/DG+W
	Nk/B3nA/hglPqIXey92cY0IitIoNXJ0kmw6ZgJfdGXMF+QnuYvfaib8SE7PeSF2KO7FLVfzTtNp
	A2BySsLfjOTGtx7AP+72ryXJX9KS+KzegfHAr+kNCpASUUHpSragdN7P2oHA6hv6BOC5bj6Rrw1
	nWeaQhZCvmO43eEWWbg2566fTshXbTNlOSfgHlBg5xtLuarLYb14szOZS9uzMEu3+n0E6yJaEyE
	QWdmPBaS3Df3sM=
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr60877151a91.17.1789022323758;
        Wed, 09 Sep 2026 23:38:43 -0700 (PDT)
Received: from icps5-ESC8000-E11.. ([163.152.219.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d76aba5d6sm4027882a91.0.2026.09.09.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:38:43 -0700 (PDT)
From: Hohyun Sim <tlaghgus0425@korea.ac.kr>
To: Abylay Ospan <aospan@amazon.com>,
	linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hohyun Sim <tlaghgus0425@korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] media: netup_unidvb: set the vb2 queue lock
Date: Thu, 10 Sep 2026 15:38:26 +0900
Message-Id: <20260910063826.112147-1-tlaghgus0425@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netup_unidvb_queue_init() fills in a struct vb2_queue but never sets
vb_queue->lock, and the driver never implemented the old optional
wait_prepare/wait_finish vb2 ops either. Since commit c780d01cf1a6
("media: vb2: vb2_core_queue_init(): sanity check lock and
wait_prepare/finish"), first released in v6.13, vb2_core_queue_init()
rejects exactly that combination:

  WARNING: drivers/media/common/videobuf2/videobuf2-core.c:2645 at vb2_core_queue_init+0x524/0x540 [videobuf2_common], CPU#0: modprobe/271
  Call Trace:
   vb2_queue_init_name+0x1a7/0x240 [videobuf2_v4l2]
   netup_unidvb_dvb_init+0x294/0xe80 [netup_unidvb]
   netup_unidvb_initdev+0x90c/0x1100 [netup_unidvb]
   pci_device_probe+0x46e/0x900

vb2_queue_init() therefore returns -EINVAL for the first frontend, and
the driver has not probed successfully on any kernel since v6.13.

The failure then oopses rather than being handled. vb2_queue_init()
returns -EINVAL, and netup_unidvb_queue_init() logs that through
dev_err(&dma->ndev->pci_dev->dev, ...) - but dma->ndev is only assigned
in netup_unidvb_dma_init(), and netup_unidvb_initdev() calls
netup_unidvb_dvb_setup() before netup_unidvb_dma_setup(), so it is still
NULL:

  BUG: KASAN: null-ptr-deref in netup_unidvb_dvb_init+0x683/0xe80 [netup_unidvb]
  Read of size 8 at addr 0000000000000000 by task modprobe/271
  Call Trace:
   kasan_report+0xed/0x140
   netup_unidvb_dvb_init+0x683/0xe80 [netup_unidvb]
   netup_unidvb_initdev+0x90c/0x1100 [netup_unidvb]
   pci_device_probe+0x46e/0x900

netup_unidvb_queue_init() is static and was inlined into
netup_unidvb_dvb_init(), which is why the reports name the caller.

The series that added the check also fixed the drivers it then found
with no queue lock and no wait ops (atomisp, pwc, msi2500, hackrf,
airspy, rcar_drif, video-i2c); netup_unidvb was not among them.

Setting q->lock is not optional any more: since commit b70886ff5833
("media: vb2: drop wait_prepare/finish callbacks") vb2_thread() and
__vb2_wait_for_done_vb() call mutex_lock(q->lock) unconditionally.

Add a dedicated mutex to struct netup_unidvb_dev, initialize it before
any queue is set up, and point each queue's lock at it before
netup_unidvb_queue_init() runs. Neither mutex that already exists can be
reused. vb2_dvb_stop_feed() calls vb2_thread_stop() while holding
vb2_dvb::lock, and vb2_thread_stop() waits in kthread_stop() for a
vb2_thread() that itself takes q->lock, so vb2_dvb::lock cannot be the
queue lock. vb2_dvb_frontends::lock is the frontend-list lock, held
across vb2_dvb_register_bus() and vb2_dvb_dealloc_frontends(), and none
of the existing vb2-dvb users make it the queue lock either. cx23885,
cx88 and saa7134 are the only other vb2-dvb users, and all three point
q->lock at their device-wide mutex rather than at either vb2-dvb lock.

With the lock set, vb2_queue_init() succeeds and the error path that
dereferenced dma->ndev is no longer entered. That path is still wrong -
dma->ndev is only assigned later - and netup_unidvb_dvb_init() still
ignores the helper's return value; both are left for a separate change
so that this fix stays minimal.

Fixes: c780d01cf1a6 ("media: vb2: vb2_core_queue_init(): sanity check lock and wait_prepare/finish")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Hohyun Sim <tlaghgus0425@korea.ac.kr>
---
Found by automated driver testing (differential replay of the driver against
an emulated device), on a KASAN-enabled 7.0.0 kernel running under QEMU with
an emulated NetUP Universal DVB card (PCI 1b55:18f6, revision 0x2) at
0000:01:00.0.

Reproducer -- with the card present (emulated or real), on any kernel v6.13
or later:

  modprobe netup_unidvb

That is the whole reproducer. Both splats are hit on the probe path, before
any DVB node is opened, so no userspace interaction is needed. Real hardware
is not required either: an emulated device that reports PCI revision 0x2 and
lets probe reach netup_unidvb_dvb_setup() is enough. On systems that have the
card, udev autoloads the module at boot, so the oops happens without anyone
running modprobe by hand.

Impact: the driver has not probed successfully since v6.13. vb2_queue_init()
fails, and the error path then oopses in probe. This is not a security issue:
there is no unprivileged trigger -- the oops happens once, in probe, when the
module is loaded.

Tested: the patched driver builds without new warnings with the toolchain
this tree is configured for (version 15.0.7), and the patch applies to v7.0
with git apply and to a drifted tree with git am -3. Booted under the same
KASAN kernel against the emulated card: without the patch, loading the module
trips the WARN and the NULL dereference above; with it, probe passes
vb2_queue_init() for both frontends and goes on to the demodulator attach
(which fails on the emulated card, as expected, so probe returns -EIO), and
the module unloads cleanly. The runtime path that takes q->lock -- vb2_thread(),
reached only once a demodulator is attached and DMX_START is issued -- is not
exercised by that setup; the choice of lock rests on the reasoning above.

Deliberately left out of this patch, so that the stable backport stays
minimal:

 - netup_unidvb_queue_init()'s error path still dereferences dma->ndev, and
   netup_unidvb_dvb_init() still ignores its return value. With q->lock set
   the error path is no longer reached, so this is now latent, but it should
   be cleaned up.

 - netup_unidvb_initdev() calls netup_unidvb_dvb_setup() (line 920) before
   netup_unidvb_dma_setup() (line 928), and vb2_dvb_register_bus() already
   publishes demux0/dvr0 via dvb_register_device() (dvb-core/dmxdev.c:1427,
   1432). Between vb2_dvb_register_bus() for a bus and netup_unidvb_dma_init()
   for that bus -- for bus 0 the second bus's dvb_init and CI setup, for bus 1
   additionally the msleep(1000) inside netup_unidvb_dma_init(0) -- a userspace
   open plus DMX_START reaches the driver's vb2 ops before
   netup_unidvb_dma_init() has run for that bus, so dma->ndev and dma->regs are
   still NULL and dma->lock, dma->free_buffers and dma->timeout are
   uninitialized. Same bug class as above; it needs a probe-order change rather
   than a lock.

I am happy to send either as a follow-up (or as 2/2 here) if you would
prefer them together.

 drivers/media/pci/netup_unidvb/netup_unidvb.h      | 3 +++
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb.h b/drivers/media/pci/netup_unidvb/netup_unidvb.h
index 2a98202..59f2f62 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb.h
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb.h
@@ -11,6 +11,7 @@
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-device.h>
@@ -113,6 +114,8 @@ struct netup_unidvb_dev {
 	u8				*dma_virt;
 	dma_addr_t			dma_phys;
 	u32				dma_size;
+	/* protects the vb2 queues, used as vb2_queue::lock */
+	struct mutex			vb2_lock;
 	struct vb2_dvb_frontends	frontends[2];
 	struct netup_i2c		i2c[2];
 	struct workqueue_struct		*wq;
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index ec08023..f205d5b 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -422,6 +422,7 @@ static int netup_unidvb_dvb_init(struct netup_unidvb_dev *ndev,
 	}
 
 	for (i = 0; i < fe_count; i++) {
+		fes[i]->dvb.dvbq.lock = &ndev->vb2_lock;
 		netup_unidvb_queue_init(&ndev->dma[num], &fes[i]->dvb.dvbq);
 		snprintf(fe_name, sizeof(fe_name), "netup_fe%d", i);
 		fes[i]->dvb.name = fe_name;
@@ -803,6 +804,8 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 	if (!ndev)
 		goto dev_alloc_err;
 
+	mutex_init(&ndev->vb2_lock);
+
 	/* detect hardware revision */
 	if (pci_dev->device == NETUP_HW_REV_1_3)
 		ndev->rev = NETUP_HW_REV_1_3;
-- 
2.34.1

