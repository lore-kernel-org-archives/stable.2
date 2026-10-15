Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035E3F3295;
	Thu, 15 Oct 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080718; cv=none; b=VXRxfeOiSAtTmuWQ0LNiihqn0m4vKaXuHMHAUhnCNG00ft3Zz9uT2ip74/ZJilZ7fclaKO4uu+rpBUkc1vmLraX8HowzOqCNHsTbde3OEPkfBZUJZL/P++ZqLrwqfOPqnhvilnN15sAsQeFGjsNHKV7luGsnMoSj60KmmIYHMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080718; c=relaxed/simple;
	bh=SdLv18HHxs0qWXFcCYzRL5GNPy5WMm8CpcbuiXA9MAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGyTFsYp6oDreJUQntsopKbbswBEzYeIv0oy4wUNFo+sdGvFTCGnPYDrLRqqy28Orged0wI8z3x2LP0OdgbHpTJYcjdIRz+AkfoCOSsrc95q3qGB8r1Knij76fE7J/ullB4I9d4HPjIQ3u3TVWa9i+dZgBIg5U00GEtAggNYkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=ezJ6sf2b reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="ezJ6sf2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=G1MwgO1e8o
	WlY3RW1KA1ILjwCVJjj12PpmHtB2q557Y=; b=ezJ6sf2bQN2GWnc9lLw8ymgssi
	FHu3f4KR5aj8Sfl6KfJKJSZgPBpIuKsan2uoVNGocTCazZGJ8lBYwCJhdLkKON8P
	xhKyfhN/N6W2j8p0LfSOSZbvMdtLeEKnUtnAwpaWQLGy0VdHZv0qCeGNe0WLpdiA
	ueVOUQGLGShP1aLlc=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.59])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAWOwE3+9BqqQmlAA--.58379S2;
	Fri, 16 Oct 2026 00:11:36 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v2 0/3] media: dvb: fix use-after-free family in dvb-core and dvb-usb disconnect paths
Date: Fri, 16 Oct 2026 00:11:31 +0800
Message-Id: <20261015161134.10425-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkAWOwE3+9BqqQmlAA--.58379S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1DJFW3GF4xZFW7JrWxXrb_yoWDKr13pa
	95GrWYyrWUKwn7Zr17A3WUGF95Aa1Sya4Fgry3Gwnagr4fW347trykKF15uws8Grs7Ja4q
	qwn8WFy8CF17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjfUUOzVUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUHD2rQ7rwJiwAAsl

Hi all,

this is v2 of the series fixing a use-after-free family in the DVB-USB
disconnect path, seen with a Pinnacle PCTV 400e USB DVB-S receiver
(ttusb2 driver) on 7.1.2 + KASAN/UBSAN.  v2 is rebased onto the media
fixes branch and reworks [PATCH 2/3] per the CI feedback on v1 (see
the changes below).

The root cause is a lifetime mismatch:

  1. open("/dev/dvb/adapter0/frontend0") grabs a dvb_device ref and
     starts kdvb-ad-0-fe-0;
  2. ioctl(/dev/bus/usb/BBB/DDD, USBDEVFS_DISCONNECT_CLAIM) unbinds
     the ttusb2 driver -> dvb_usb_device_exit() -> dvb_usb_exit() ->
     kfree(d);
  3. the still-open fd's ->release(), or the in-flight frontend
     thread / i2c transfer, then dereferences the already-freed
     "struct dvb_usb_device" (usb_mutex, i2c_mutex, i2c_adap) and
     the already-freed "struct dvb_device".

Patch 1 fixes the "struct dvb_device" object itself: dvb_remove_device()
and dvb_unregister_device() dropped the callers' reference before they
were done using the object, and dvb_device_open() could hand out a
stale/freed dvb_minors[] entry.

Patch 2 fixes dvb_frontend_release() and the dvb_frontend_open() error
path, which read dvbdev->users after dvb_generic_release() may already
have dropped the last reference (KASAN at dvb_frontend.c:2903, and the
same pattern in the open() failure unwinder).  The reference needed for
the check is taken before dvb_generic_release(), while the file's own
reference still guarantees that the object is alive, and it is dropped
again right after the check.

Patch 3 gives "struct dvb_usb_device" a kref and a "dead" flag so that
frontend release/init paths that run after USB disconnect see a live
object and bail out of the actual USB I/O instead of touching a freed
usb_device/mutex. This covers crashes in i2c_transfer(),
dvb_usb_generic_rw() and ttusb2_i2c_xfer(), including the qspinlock
UBSAN splats caused by unlocking mutexes inside freed memory.

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
drivers/media/usb/dvb-usb are compiled with CONFIG_DVB_USB_TTUSB2=y.

Changes in v2:

  - rebase onto the `fixes` branch of the media-committers tree
    (media-patchstyle test-valid-ancestor);
  - [PATCH 2/3] reworked per the coccinelle mini_lock findings on v1:
    the extra dvb_device_get() is now taken *before*
    dvb_generic_release() instead of after it, and no path returns
    early any more.  v1's version could touch a freed object inside
    the get() itself, skipped the mfe_lock unlock on the error paths
    (6 warnings) and leaked the frontend kref there; v2 keeps the
    lock and kref control flow identical to mainline.

The patches are real git diffs, produced by "git format-patch" against
the media fixes branch.

YuanZhe Liu (3):
  media: dvb-core: fix use-after-free in dvb_remove_device() and
    dvb_device_open()
  media: dvb-core: keep dvb_device alive while checking users count in
    frontend release paths
  media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open
    chardevs

 drivers/media/dvb-core/dvb_frontend.c    | 19 ++++++++
 drivers/media/dvb-core/dvbdev.c          | 58 +++++++++++++++++-------
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  | 20 ++++++--
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 32 ++++++++++++-
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  | 15 +++++-
 drivers/media/usb/dvb-usb/dvb-usb.h      | 13 ++++++
 drivers/media/usb/dvb-usb/ttusb2.c       | 18 ++++++--
 7 files changed, 147 insertions(+), 28 deletions(-)

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

