Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694654;
	b=d8k+t5HTOmcUwgZx0e0MoablFUwj+a5Jj8d3gM4SnzMQ3chRKlvfw15LJIQjQp6NenzA
	 4NxM/3Hu2C4Z7eLQi5ZFGnw8GnFji+XW0GFyUrO7ZFGLNWwCDIY3Mc6goacokb4plx/v4
	 q9ApFSUylHgyPgdHwRbRSlte/sKpyxe03AHQ0PuVH5uP7zoMQVI5PIJqGY0uHta9BWzQB
	 OaQ/PmHWmM8TVpyU+M3fMSd0rHFPsaqBWQk+7uk1dutnzD/RyzIET3Gxgz8G8v0+rfCNN
	 8E/H6hUOXQ39QDNJ/lox/KIV3YHhXJeec5ebo2RNAkC9jdCTdwY/PdCm1IEa5eQS68g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694654;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=UctO3145cL9Mnt0rgKiILCyiKir6F3WDinvtjnpXP0I=;
	b=4ISW1fhCt7kI4m+uYUwU0b3EmtrfH/1XP9iVGbMb3MFwwW8Ah6FuQZqw4AmneYiJGbCo
	 Y5cJygzRKKlrWsqoTk6mOwbsMaYxyyJmBmNate1Knt/odxpMEilfpWuWaDhChmYsAG1K1
	 DPzD0Yb0j9ZEEPAZw9F6SvdIQcDave8esdltqn2iNeq2dl45xQbNNtB/9Qog/Xjm3PAdF
	 dv852RjIZxVlN1rVDm4KThtpCCa53Y3yAEFeWQ29qRwk7fSNip/Kd+4qXnZI2Sh8Ugf/k
	 QTv4JiHnB2WkSXDRiU1QoUSxiNTjXTl7r5i8DLDju+dZCOw5EECGmqsPDrtdtk1wqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A236082BD4;
	Tue,  3 Nov 2026 08:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A236082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=UctO3145cL
	9Mnt0rgKiILCyiKir6F3WDinvtjnpXP0I=; b=oNe9AzvaOhtWvRoA/pB52kEUxx
	wWg0autPMksve/Jajd1H9VdAN9o2+GLYxMfRP0kDAlK33s6t+df6r5wet1sNhDaa
	5qikmhRALqO80N2SAs42JyV/y4oLSKjQy1rY/SJgxdTl7hsgKxRs9wK8nVReZDOK
	PI/CBFAUsXP4UchF4=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCGqgCwm+lqS+8dAQ--.21892S2;
	Tue, 03 Nov 2026 16:30:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v6 0/3] media: dvb: fix use-after-free family in dvb-core and dvb-usb disconnect paths
Date: Tue,  3 Nov 2026 16:30:36 +0800
Message-Id: <20261103083039.33430-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkCGqgCwm+lqS+8dAQ--.21892S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw1DXF48Ar1DWw43Gry7GFg_yoW8GF1xKo
	Zagr4rX3Wrtw4qka48AFnrGF4agFn7u3ZxWay5Ar4q93y8Wrs8Aw15Kw4DXFWkXr40krnx
	t34qqrZ8GFsxAFn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYL7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUGjg5UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2roqcKe4wABsb

Hi all,

this is v6 of the series fixing a use-after-free family in the
DVB-USB disconnect path, seen with a Pinnacle PCTV 400e USB DVB-S
receiver (ttusb2 driver) on 7.1.2 + KASAN/UBSAN.  v6 keeps the
structure of the series and addresses the points raised while
reviewing v5 (see the changes below).

The root cause is a lifetime mismatch:

  1. open("/dev/dvb/adapter0/frontend0") grabs a dvb_device ref and
     starts kdvb-ad-0-fe-0;
  2. ioctl(/dev/bus/usb/BBB/DDD, USBDEVFS_DISCONNECT_CLAIM) unbinds
     the ttusb2 driver -> dvb_usb_device_exit() -> dvb_usb_exit() ->
     frees everything the still-open descriptor can reach;
  3. the fd's ->release(), or the in-flight frontend thread / i2c
     transfer, then dereferences the already-freed
     "struct dvb_usb_device" (usb_mutex, i2c_mutex, i2c_adap) and
     the already-freed "struct dvb_device".

Patch 1 fixes the "struct dvb_device" object itself:
dvb_remove_device() dropped the minors-table reference before it was
done using the object, and dvb_register_device() published
dvb_minors[minor] while dvb_register_media_device() and
device_create() could still fail, so an error there freed the object
- and the driver private data behind it - underneath a concurrent
open().  The minor entry, which is what makes the device reachable, is
now filled in only after registration has completed, and it is
published under the lock that open() takes before it looks the entry
up, so a concurrent open() waits for a complete device instead of
failing with -ENODEV.

Patch 2 fixes dvb_frontend_release() and the dvb_frontend_open() error
path, which read dvbdev->users after dvb_generic_release() may already
have dropped the last reference (KASAN at dvb_frontend.c:2903, and the
same pattern in the open() failure unwinder).  The reference needed for
the check is taken before dvb_generic_release(), while the file's own
reference still guarantees that the object is alive, and it is dropped
again right after the check.

Patch 3 gives "struct dvb_usb_device" a kref and a "dead" flag.  The
reference is held for the whole lifetime of each registered frontend
and dropped from a wrapper around fe->ops.release(), so the release
callback that runs when the last descriptor is closed after a
disconnect still sees live memory.  The embedded "struct usb_device"
is pinned the same way, and the USB/i2c workers check ->dead and bail
out of the actual hardware I/O instead of touching a gone device.  They
take no reference of their own: they already run under the reference of
the frontend or of the bus binding, and a transient reference there
could be the last one, which would run the release function from inside
->master_xfer().  Everything an open frontend can still reach through
the device - the I2C adapter, ->priv_destroy() and the per-adapter
private data - is released from the release function as well, when the
last reference is dropped, instead of at disconnect time.

Crashes addressed (excerpts below the diffstat):

  KASAN: slab-use-after-free Read in i2c_transfer        (reports 1, 9)
  KASAN: use-after-free Write in dvb_usb_generic_rw      (report 2)
  UBSAN: array-index-out-of-bounds in i2c_transfer       (report 3)
  KASAN: slab-use-after-free Read in dvb_frontend_release (report 4)
  KASAN: null-ptr-deref Write in ttusb2_i2c_xfer         (report 5)
  UBSAN: array-index-out-of-bounds in ttusb2_i2c_xfer    (report 6)
  KASAN: slab-use-after-free Read in dvb_remove_device   (report 7)
  KASAN: slab-use-after-free Read in dvb_device_open     (report 8)

All three patches pass checkpatch with zero errors and warnings, apply
on top of the media fixes base (git am reproduces the exact trees) and
are build-tested on x86_64 with gcc 11.4: drivers/media/dvb-core and
drivers/media/usb/dvb-usb are compiled with CONFIG_DVB_USB_TTUSB2=y,
once built-in and once with CONFIG_MODULES=y and CONFIG_MEDIA_ATTACH=y
so the module reference accounting in patch 3 is compiled as well.

Changes in v6:

  - [PATCH 1/3] holds minor_rwsem across device_create() and the
    publication of dvb_minors[minor], so an open() that races with the
    registration waits for the entry instead of failing with -ENODEV.
    device_create() only runs the devnode and uevent callbacks, neither
    of which takes minor_rwsem, and dvb_device_open() takes
    dvbdev_mutex before it acquires minor_rwsem while registration
    takes no dvbdev_mutex, so the lock order is unchanged;
  - [PATCH 3/3] removes the transient references from the transfer
    paths: dvb_usb_generic_rw() and ttusb2_i2c_xfer() could otherwise
    drop the last reference from inside ->master_xfer(), where the
    release function would call i2c_del_adapter() underneath the
    transfer that still uses the adapter.  The references taken by the
    bus binding and by each registered frontend already cover the
    callbacks, including the remote-control work, which
    dvb_usb_remote_exit() cancels synchronously before the framework
    reference is dropped;
  - [PATCH 3/3] documents fe_release in the kernel-doc of struct
    dvb_usb_fe_adapter.

Changes in v5:

  - [PATCH 1/3] fills in dvb_minors[minor] only after
    dvb_register_media_device() and device_create() have succeeded,
    instead of publishing the entry first and gating dvbdev->fops.
    memcpy(dvbdev, template, sizeof(*dvbdev)) copies template->fops,
    so the fops gate of v4 needed an explicit reset and still exposed
    a half-registered device; publishing the entry late needs neither,
    and the error paths keep releasing the object with kfree() because
    no reference can have been taken.  dvbdev_register_lock already
    serializes registrations, so the chosen minor cannot be handed out
    twice while it is unpublished;
  - [PATCH 3/3] releases the I2C adapter, ->priv_destroy() and the
    per-adapter private data from dvb_usb_free_device() instead of at
    disconnect time: dvb_usb_i2c_exit() no longer races transfers that
    a frontend can still start, cxusb's ->priv_destroy() no longer
    destroys the mutex that the frontend release path still takes, and
    tuner callbacks no longer read freed adap->priv;
  - [PATCH 3/3] marks the device dead in dvb_usb_init()'s error path,
    before the adapters are torn down, so callbacks that keep the
    object alive do not run against a device whose initialisation
    failed;
  - [PATCH 3/3] keeps the v4 handling of the module reference, the
    frontend unregistration on a late frontend_init failure and the
    ->dead re-checks under usb_mutex / i2c_mutex.

The patches are real git diffs, produced by "git format-patch" against
the media fixes branch.

YuanZhe Liu (3):
  media: dvb-core: fix use-after-free in dvb_remove_device()
  media: dvb-core: keep dvb_device alive while checking users count in
    frontend release paths
  media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open
    chardevs

 drivers/media/dvb-core/dvb_frontend.c    |  19 ++++
 drivers/media/dvb-core/dvbdev.c          |  27 +++++-
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  |  58 +++++++++++-
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 108 ++++++++++++++++++-----
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  |  17 +++-
 drivers/media/usb/dvb-usb/dvb-usb.h      |  21 +++++
 drivers/media/usb/dvb-usb/ttusb2.c       |  20 ++++-
 7 files changed, 237 insertions(+), 33 deletions(-)

--
Excerpts from the KASAN/UBSAN reports (Pinnacle PCTV 400e, 7.1.2,
CONFIG_KASAN=y CONFIG_UBSAN=y):

Report 1: KASAN: slab-use-after-free Read in i2c_transfer

  BUG: KASAN: slab-use-after-free in i2c_transfer+0x324/0x360
  Read of size 8 at addr ffff8880050a0f08

   i2c_transfer+0x324/0x360 drivers/i2c/i2c-core-base.c:2312
   tda10086_read_byte.isra.0+0xe7/0x190 drivers/media/dvb-frontends/tda10086.c:65
   tda10086_release+0xa3/0x180 drivers/media/dvb-frontends/tda10086.c:692
   dvb_frontend_release+0x179/0x2b0 drivers/media/dvb-core/dvb_frontend.c:2934
   __fput+0x3a6/0xac0 fs/file_table.c:510

  Underlying object is the dvb_usb_device, freed by dvb_usb_device_exit()
  on USB unbind while the fd was still open.

Report 2: KASAN: use-after-free Write in dvb_usb_generic_rw

  BUG: KASAN: use-after-free in mutex_unlock+0x5b/0xa0 kernel/locking/mutex.c:579
  Write of size 8 at addr ffff8880050a4eb8 by task kdvb-ad-0-fe-0/268

   mutex_unlock+0x5b/0xa0 kernel/locking/mutex.c:579
   dvb_usb_generic_rw+0x216/0x460 drivers/media/usb/dvb-usb/dvb-usb-urb.c:59
   ttusb2_msg+0x1f2/0x5a0 drivers/media/usb/dvb-usb/ttusb2.c:97
   ttusb2_power_ctrl+0x8a/0xa0 drivers/media/usb/dvb-usb/ttusb2.c:483
   dvb_usb_fe_wakeup+0x84/0x2d0 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:254
   dvb_frontend_thread+0x216/0x1620 drivers/media/dvb-core/dvb_frontend.c:677

  The frontend kthread issues CMD_POWER while the device is being torn
  down; d->usb_mutex belongs to the freed dvb_usb_device.

Report 3: UBSAN: array-index-out-of-bounds in i2c_transfer

  UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
  index 6996 is out of range for type 'long unsigned int [2]'

   queued_spin_lock_slowpath+0x7de/0x820 kernel/locking/qspinlock.c:285
   _raw_spin_lock_irqsave+0xae/0xb0 kernel/locking/spinlock.c:166
   rt_mutex_lock+0xa9/0xb0 kernel/locking/rtmutex_api.c:89
   i2c_transfer+0x1b3/0x360 drivers/i2c/i2c-core-base.c:2312
   tda10086_read_byte.isra.0+0xe7/0x190 drivers/media/dvb-frontends/tda10086.c:65
   dvb_frontend_release+0x179/0x2b0 drivers/media/dvb-core/dvb_frontend.c:2934

  Mutex in the freed dvb_usb_device has a garbage ->owner tail;
  decode_tail indexes out of the per-cpu qnode array.

Report 4: KASAN: slab-use-after-free Read in dvb_frontend_release

  BUG: KASAN: slab-use-after-free in dvb_frontend_release+0x28b/0x2b0
  drivers/media/dvb-core/dvb_frontend.c:2903
  Read of size 8 at addr ffff88800632bd60

   dvb_frontend_release+0x28b/0x2b0 drivers/media/dvb-core/dvb_frontend.c:2903
   __fput+0x3a6/0xac0 fs/file_table.c:510

  Allocated by dvb_register_device+0x1d6/0x1230 dvbdev.c:472 /
  dvb_register_frontend+0x3ed/0x640 dvb_frontend.c:3051.  The struct
  dvb_device is freed by dvb_remove_device/dvb_device_put on disconnect,
  then read at line 2903 ("dvbdev->priv") by the still-open fd's
  release().

Report 5: KASAN: null-ptr-deref Write in ttusb2_i2c_xfer

  BUG: KASAN: null-ptr-deref in mutex_lock_interruptible+0x61/0xb0
  kernel/locking/mutex.c:1059
  Write of size 8 at addr 0000000000000ed0

   mutex_lock_interruptible+0x61/0xb0 kernel/locking/mutex.c:1059
   ttusb2_i2c_xfer+0x60/0x660 drivers/media/usb/dvb-usb/ttusb2.c:374
   i2c_transfer+0x1c6/0x360 drivers/i2c/i2c-core-base.c:2292
   tda10086_read_byte.isra.0+0xe7/0x190 drivers/media/dvb-frontends/tda10086.c:65
   dvb_frontend_release+0x179/0x2b0 drivers/media/dvb-core/dvb_frontend.c:2934

  i2c_get_adapdata() returned NULL after the dvb_usb_device was freed
  (0xed0 is the offset of i2c_mutex inside it).

Report 6: UBSAN: array-index-out-of-bounds in ttusb2_i2c_xfer

  UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
  index 8284 is out of range for type 'long unsigned int [2]'

   queued_spin_lock_slowpath+0x7de/0x820 kernel/locking/qspinlock.c:285
   _raw_spin_lock_irqsave+0xae/0xb0 kernel/locking/spinlock.c:166
   mutex_unlock+0x9a/0xa0 kernel/locking/mutex.c:582
   ttusb2_i2c_xfer+0x490/0x660 drivers/media/usb/dvb-usb/ttusb2.c:428
   i2c_transfer+0x1c6/0x360 drivers/i2c/i2c-core-base.c:2292
   tda10086_release+0x100/0x180 drivers/media/dvb-frontends/tda10086.c:692

  mutex_unlock(&d->i2c_mutex) on the freed dvb_usb_device wakes a waiter
  list that no longer exists.

Report 7: KASAN: slab-use-after-free Read in dvb_remove_device

  BUG: KASAN: slab-use-after-free in dvb_remove_device.part.0+0x1f9/0x250
  drivers/media/dvb-core/dvbdev.c:606
  Read of size 4 at addr ffff88800611ce2c

   dvb_remove_device+0x1b/0x30 drivers/media/dvb-core/dvbdev.c:596
   dvb_unregister_frontend+0x62/0x90 drivers/media/dvb-core/dvb_frontend.c:3080
   dvb_usb_device_exit+0x1a4/0x490 drivers/media/usb/dvb-usb/dvb-usb-init.c:338
   usb_unbind_interface+0x188/0x770 drivers/usb/core/driver.c:458

  Freed by dvb_remove_device.part.0+0x1c8/0x250 (dvbdev.c:601): the
  function frees dvbdev via dvb_device_put() and then still reads
  dvbdev->minor at line 606 for device_destroy().

Report 8: KASAN: slab-use-after-free Read in dvb_device_open

  BUG: KASAN: slab-use-after-free in dvb_device_open+0x32c/0x350
  drivers/media/dvb-core/dvbdev.c:99
  Read of size 8 at addr ffff888004b50618

   dvb_device_open+0x32c/0x350 drivers/media/dvb-core/dvbdev.c:99
   chrdev_open+0x145/0x400 fs/char_dev.c:411

  Freed by dvb_device_open+0x29c/0x350 (dvbdev.c:113): open() grabbed
  the dvbdev from dvb_minors[] under minor_rwsem and the
  dvb_device_get() succeeded, but f_op->open() then failed and
  dvb_device_put() at line 113 freed it; a concurrent open() follows
  the stale pointer.

Report 9: general protection fault in i2c_transfer

  RIP: 0010:i2c_transfer+0x1b0/0x360 drivers/i2c/i2c-core-base.c:2312
   R14: ffffffff81ff8926  (call *(%r14) - garbage lock func ptr)

   tda10086_read_byte.isra.0+0xe7/0x190 drivers/media/dvb-frontends/tda10086.c:65
   tda10086_release+0xa3/0x180 drivers/media/dvb-frontends/tda10086.c:692
   dvb_frontend_release+0x179/0x2b0 drivers/media/dvb-core/dvb_frontend.c:2934

  Same i2c_transfer UAF as report 1, but here the freed memory was
  reused so adap->bus_lock points to a garbage function and the
  indirect call faults.

-- 
2.34.1

