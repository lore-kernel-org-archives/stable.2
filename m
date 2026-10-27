Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066299;
	b=ahM96i/7ZPbjeTwRLZhF/WISX7sJ2tSiNkXZuCbcwebIoNK2wvPX+NTUYbgsONBmF6ss
	 enggHkYyTqjY6NwEu0WhCnq4TF7VZXHrxSMrQrl7GLXxahleJpIoBhiMrlhfGFDBGiGlj
	 gfSGwCht75luRqqckfCs+mPPfUNmKKuyYSDyAS60f3B1WuhV6yd225dgXQO+m/sSePS/T
	 HkcMokeN/XYb5p2RFcPJnUqzBWig0DIJzcidF/agbatMdWlygVmZDLTdzPxvh5AIJwGP7
	 evrkBW/QQzcea8yhjNwP5zFqsRM1KYaBX7nGnJYBad/9vTE1C/dFXGoOK+/8pwhXKWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066299;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=XZL4QZS4sczr0IU3gOA3qnWDJuegfInxTkPsTDLwvqY=;
	b=TNzGsQFrmonKabcxpXW77KQilYiZtLArKkqeRLgR2O4EMyy4CL+J7AMWXXh8Ra9VxYB5
	 LQc6RmAi3yP4xb+WAwy4UNfLlQQdturMXCIbPIYZ+IIcmqrf3W4Yr5shegDtsiG7Ku0KE
	 AC9s8B9PuT20d0cw4QN2zMQTG9ApCewDvWgAgNjp9wKx1DKHyfqwN7ceMEEpMA8qwozLI
	 nENWYq/6qldu0fSnCBZ8owb81iG6udlOXIY29ltMuyBeohWleiVivscL/VXq8b2DdOCa5
	 VeeMpwyTX8ScT5qsw3xs2gGR9Vu8dt1ZGqUnngCI/QbfPH/hP8lNytoGKT4aGyr5lhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16756606A31B;
	Tue, 27 Oct 2026 01:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16756606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=XZL4QZS4sc
	zr0IU3gOA3qnWDJuegfInxTkPsTDLwvqY=; b=bVMFMUhzo1yEexBYu0LhDT554X
	Rg/MlVbEApab19n2EvwBckjJDDviFmUwGEqCWxZes97TjA9lKuloA9AQcIxbGkbg
	8t7Elxf9mD1k8lTbSeSvtfLgA9dZdZEl/BMrVd2x6CUJ3kB02LL+ztSfAqirkzaB
	pulqKbh1X9/ohT++0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnAEsBeBqxnzsAA--.34537S2;
	Tue, 27 Oct 2026 09:58:05 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v3 0/3] media: dvb: fix use-after-free family in dvb-core and dvb-usb disconnect paths
Date: Tue, 27 Oct 2026 09:58:01 +0800
Message-Id: <20261027015804.13148-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnAEsBeBqxnzsAA--.34537S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1DXr1fAryfKrWUZw4xZwb_yoWkWF43pa
	95GrWYyrWUKwn7Zr47A3WUCr95Aa1Sya4Fgry3GwnIgr4rGa47trykK3Z8uws8Grs7Jayq
	qwn8WFy0kF17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUk9NsUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2rfb0FCrgABst

Hi all,

this is v3 of the series fixing a use-after-free family in the
DVB-USB disconnect path, seen with a Pinnacle PCTV 400e USB DVB-S
receiver (ttusb2 driver) on 7.1.2 + KASAN/UBSAN.  v3 keeps the v2
structure and addresses the problems found while reviewing v2 (see
the changes below).

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
done using the object, and the dvb_register_device() error paths left
dvb_minors[] pointing at a freed device.

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
is pinned the same way, and the USB/i2c workers check ->dead while
holding a reference and bail out of the actual hardware I/O instead of
touching a gone device.  This covers crashes in i2c_transfer(),
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

Changes in v3:

  - [PATCH 1/3] keeps dvb_device_open() as it is on mainline (the v2
    restructure changed the dvb_generic_open() serialisation and let
    dvb_remove_device() free the media entity during ->open()), drops
    the minors-table reference at the end of dvb_remove_device()
    instead of moving it to dvb_unregister_device() (which broke the
    direct callers dvb_unregister_frontend() and
    dvb_ca_en50221_release()), and clears dvb_minors[] in the
    dvb_register_device() error paths;
  - [PATCH 3/3] keeps the reference for the whole frontend lifetime
    and drops it from a fe->ops.release() wrapper, because the
    release-time i2c transfer is what runs after disconnect; pins
    struct usb_device with usb_get_dev()/usb_put_dev() and re-checks
    ->dead after taking usb_mutex.

The patches are real git diffs, produced by "git format-patch" against
the media fixes branch.

YuanZhe Liu (3):
  media: dvb-core: fix use-after-free in dvb_remove_device()
  media: dvb-core: keep dvb_device alive while checking users count in
    frontend release paths
  media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open
    chardevs

 drivers/media/dvb-core/dvb_frontend.c    | 19 +++++++++++
 drivers/media/dvb-core/dvbdev.c          | 24 +++++++++++---
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  | 42 +++++++++++++++++++++---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 41 +++++++++++++++++++++--
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  | 21 ++++++++++--
 drivers/media/usb/dvb-usb/dvb-usb.h      | 14 ++++++++
 drivers/media/usb/dvb-usb/ttusb2.c       | 18 ++++++++--
 7 files changed, 163 insertions(+), 16 deletions(-)

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

