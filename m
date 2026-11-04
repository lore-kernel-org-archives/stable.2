Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764610;
	b=VIOYG2N6yQ7xurG8C7loUb0aMSpahi0T4mDdUW2h1DwRFgUszHeTOzNGAav3jw0QULfV
	 9XSJBzNEvCf5/0eNKsJrYCeCvTN1snmBn6kUKl8ULtaXfe7LUsgbtQrpnM7fb+3PQ9Z9b
	 CFf7pSeB8lgNOdkwwv2+FmMVtEYFy8N2bBQM0ZzDtNZ+hzpbXrg089AGmgapra6SXYK8a
	 hoOFisPf0GZKT9824TR2ciEuvVL9sQ38FkjrstUzOGu5JQeDZPUkjwave//Y/Qwr+PQnC
	 gEO8EJtt3JlpENTbssZxDqAUDwaeMqBJCoXf2U++3XR0NZARhV/au/VH9eyTgy+tUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764610;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=zQMNiRLijtXoyvp2ptnROm7d8gMS6zGJfqNXBpaqeuk=;
	b=fznS49/r88IOYnv7nGsxHvt+8I5y59dhaHrvKGAF1Ow2a4BeSxD6WcPvQ0YEW3QoE24R
	 7FJoxOHxyYWWWOhDro9FJjFSSzM9qioY36xpZki47fQyKYQuyU+liEAuTBaRdrQAaO8TJ
	 B7+MM0Z93xHBcBdWPsn4XwtVncnwYqyYdoyvujhWcgflsnu+6taa39zkn+rcbHrhTI6ez
	 Fn3XV9RQq9Ewxu5qL8mI5W+qs1m1MDR1LaKg6xhLh0rVTba4H5AJSM9CewzWAyWmFtxzD
	 3GjzUhUHL5pdXjMIQDDoFNffJ0/ZgTgw3h2OPI4kgv6bz3vzrXR0uTHtmFyA24esPHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDCB606A31B;
	Wed,  4 Nov 2026 03:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DDCB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=zQMNiRLijtXoyvp2ptnROm7d8gMS6zGJfq
	NXBpaqeuk=; b=om07jGblih2B3vCV+vcHmJcSYzp/32JmYZB7FXRh7H/cxMtoB3
	eKDIdOra0w3jhwj3DggkITSQbfkhsvVP428PcDSQMPWt6+erWsuXJgP5/PzEkmeR
	PA+hKgzB5djSFfOEmUs8s4gLiqmmMoa7U4tw1ybFTLV1tEyiUD6l/AvTE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.67])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gP1rOpqJAUiAQ--.35940S2;
	Wed, 04 Nov 2026 11:56:38 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v5] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Wed,  4 Nov 2026 11:56:37 +0800
Message-Id: <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104000031.679944e7.michal.pecio@gmail.com>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
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
X-CM-TRANSID:BLQMCkC2_gP1rOpqJAUiAQ--.35940S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tF1ktw1UKryUuFWfur4UJwb_yoW8Ww4DXo
	WfZrnayF4rtr4DA3yFqF43tFyfWr92qF98XrW5Cws0gFWfZ3Z8Gw13Ka13Xay7ZF45K3W3
	A342qryFqrsrGrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYm7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE
	52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGV
	WUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
	I48JMxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07boHqxUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2rp+NVnWQABsd

A KASAN slab-use-after-free read was observed in xhci_stop_device():

  BUG: KASAN: slab-use-after-free in xhci_stop_device.constprop.0.isra.0+0x395/0x430
  drivers/usb/host/xhci-hub.c:479
  Read of size 8 at addr ffff88804e85d2f0

  Freed by task 585700:
   kfree+0xf8/0x390 mm/slub.c:6566
   xhci_free_virt_device+0x3f/0x50 drivers/usb/host/xhci-mem.c:881
   xhci_free_dev+0x286/0x350 drivers/usb/host/xhci.c:4131
   usb_disconnect+0x6b6/0x910 drivers/usb/core/hub.c:2391
   ...
   usbdev_ioctl+0x6f05/0x86d0 drivers/usb/core/devio.c:2826

  Allocated by task 572283:
   xhci_alloc_virt_device+0x171/0xb70 drivers/usb/host/xhci-mem.c:986
   xhci_alloc_dev+0x475/0x840 drivers/usb/host/xhci.c:4271
   usb_alloc_dev+0xe8/0xdc0 drivers/usb/core/usb.c:661
   hub_event+0x1c82/0x4050 drivers/usb/core/hub.c:5953

xhci_stop_device() reads xhci->devs[slot_id] without xhci->lock and
keeps using the pointer across xhci_alloc_command(GFP_NOIO), which may
sleep.  All callers drop xhci->lock before calling it.  Both sides of
the race can come from userspace through usbfs: a hub class
SET_FEATURE(PORT_SUSPEND) request to the root hub reaches
xhci_stop_device() through xhci_hub_control(), while releasing the hub
driver interface through USBDEVFS_IOCTL() quiesces the hub and
disconnects the devices below it, ending in xhci_free_dev().  USB core
does not serialize those two, and xhci_free_dev() frees virt_dev under
xhci->lock, so the endpoint loop can dereference a freed device.

commit 88716a93766b ("usb: xhci: Fix panic if disconnect") added a
NULL check for this case, but that only helps when the device was
already freed before the check; it does not close the window.

Look up xhci->devs[slot_id] only after taking xhci->lock, and bail out
if it is NULL or if the device is already being torn down.  The
tracepoint reloads virt_dev->udev, so it moves under the lock and only
runs while the device is still attached.

xhci_free_dev() clears virt_dev->udev without xhci->lock, and only
later detaches the device from xhci->devs[] in xhci_free_virt_device(),
also under the lock.  Take xhci->lock when clearing ->udev so that
xhci_stop_device() can rely on it while holding the same lock.
xhci_free_virt_device() clears xhci->devs[slot_id] and frees the device
under xhci->lock, so a device found there while holding the lock stays
alive until xhci_stop_device() drops the lock, after which virt_dev is
not used anymore.

Fixes: be88fe4f4dda93e3 ("USB: xHCI: port power management implementation")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Hi Michal,

Thanks for looking at this.  Full answers below.  The code is unchanged
since v3; the commit message now says how the two sides of the race
reach each other, and v5 corrects one detail in it.

> But is it not a bug in the first place that we are suspending a device
> which is being deleted or deleting one which is being suspended?

Yes, and that is exactly the interleaving.  What makes it possible is
that the suspend side does not come from the USB core suspend path at
all:

  CPU0 (control request to the root hub)   CPU1 (disconnect_claim, hub)
  --------------------------------------   ---------------------------
  usbdev_ioctl(USBDEVFS_CONTROL)           usbdev_ioctl(USBDEVFS_IOCTL)
   do_proc_control                          proc_ioctl
    usbfs_start_wait_urb                     usb_driver_release_interface
     usb_submit_urb                           usb_unbind_interface
      rh_call_control                          hub_disconnect
       xhci_hub_control                         hub_quiesce
        SET_FEATURE(PORT_SUSPEND)                usb_disconnect(child)
         xhci_stop_device(slot, 1)                hub_free_dev
                                                   xhci_free_dev
                                                    xhci_free_virt_device
                                                     kfree(virt_dev)

The port suspend is a hub class SET_FEATURE(PORT_SUSPEND) sent from
userspace through usbfs, and the teardown is userspace releasing the
hub driver interface, which quiesces the hub and disconnects every
child under it.  Neither side takes a per-device reference, and the
usbfs control request is not serialized against the hub driver being
unbound.  That is also why xhci_bus_suspend() 100 ms after a disconnect
looks fine: this is a different entry into xhci_stop_device().

CLEAR_FEATURE(PORT_SUSPEND) is the resume direction: in
xhci_hub_control() it ends in xhci_ring_device(), so it cannot produce
this trace.

> Would you mind revealing your secret sauce and posting complete stack
> traces of how you got there, including xhci_stop_device()? What kernel
> version was that? Those line numbers don't match current code.

Fair question, and I should have been upfront about it in the commit
message.  This was found by syzkaller running against the xHCI on QEMU,
on 7.1.2; the patch itself is against 7.2.10, which is why the line
numbers in the trace do not line up with current code.

The report, trimmed to the stacks and the dmesg lines just above them:

  xhci_hcd 0000:00:04.0: USB core suspending port 1-3 not in U0/U1/U2
  usb usb2: usbfs: process 585700 (syz.6.213219) did not claim interface 0 before use
  usb 1-1: USB disconnect, device number 108
  BUG: KASAN: slab-use-after-free in xhci_stop_device.constprop.0.isra.0+0x395/0x430
  Read of size 8 at addr ffff88804e85d2f0 by task syz.4.213206/585661

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xa7/0xd0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5d0 mm/kasan/report.c:482
 ? _raw_write_unlock_irq+0x60/0x60
 ? xhci_stop_device.constprop.0.isra.0+0x395/0x430 drivers/usb/host/xhci-hub.c:479
 kasan_report+0xaf/0xe0 mm/kasan/report.c:595
 ? xhci_stop_device.constprop.0.isra.0+0x395/0x430 drivers/usb/host/xhci-hub.c:479
 xhci_stop_device.constprop.0.isra.0+0x395/0x430 drivers/usb/host/xhci-hub.c:479
 ? instrument_read_write include/linux/instrumented.h:55 [inline]
 ? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
 ? queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 ? do_raw_spin_lock include/linux/spinlock.h:187 [inline]
 ? __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:133 [inline]
 ? _raw_spin_lock_irqsave+0x72/0xb0 kernel/locking/spinlock.c:166
 xhci_hub_control+0x1b6b/0x5590 drivers/usb/host/xhci-hub.c:1315
 ? dma_coherent_ok+0xa2/0x280 kernel/dma/direct.c:77
 ? xhci_set_link_state+0x30/0x30 drivers/usb/host/xhci-hub.c:805
 ? unpoison_slab_object mm/kasan/common.c:336 [inline]
 ? __kasan_slab_alloc+0x2c/0x60 mm/kasan/common.c:366
 ? kasan_save_track+0x10/0x30 mm/kasan/common.c:78
 rh_call_control drivers/usb/core/hcd.c:650 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:815 [inline]
 usb_hcd_submit_urb+0x90d/0x1c20 drivers/usb/core/hcd.c:1536
 usb_submit_urb+0x86c/0x1740 drivers/usb/core/urb.c:586
 usbfs_start_wait_urb+0x10a/0x3a0 drivers/usb/core/devio.c:1149
 ? kasan_unpoison+0x23/0x50 mm/kasan/shadow.c:178
 ? usbfs_blocking_completion+0x40/0x40 drivers/usb/core/devio.c:1132
 ? kasan_unpoison+0x23/0x50 mm/kasan/shadow.c:178
 ? __mutex_unlock_slowpath.constprop.0+0x360/0x360
 do_proc_control drivers/usb/core/devio.c:1249 [inline]
 proc_control drivers/usb/core/devio.c:1280 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2645 [inline]
 usbdev_ioctl+0x33e1/0x86d0 drivers/usb/core/devio.c:2826
 ? instrument_atomic_write include/linux/instrumented.h:97 [inline]
 ? set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 ? set_ti_thread_flag include/linux/thread_info.h:104 [inline]
 ? __resched_curr+0x1e2/0x270 kernel/sched/core.c:1192
 ? __css_rstat_updated+0x15e/0x470 kernel/cgroup/rstat.c:97
 ? cpu_cgroup_cancel_attach+0x10/0x10 include/linux/workqueue.h:759
 ? root_cgroup_cputime+0x3d0/0x3d0 include/linux/find.h:67
 ? instrument_atomic_read include/linux/instrumented.h:82 [inline]
 ? _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ? test_ti_thread_flag include/linux/thread_info.h:133 [inline]
 ? test_tsk_thread_flag include/linux/sched.h:2069 [inline]
 ? test_tsk_need_resched include/linux/sched.h:2088 [inline]
 ? wakeup_preempt+0x1cd/0x330 kernel/sched/core.c:2260
 ? usbdev_mmap+0xa00/0xa00 drivers/usb/core/devio.c:286
 ? update_load_avg+0x176/0x1880 kernel/sched/fair.c:4983
 ? update_load_avg+0x176/0x1880 kernel/sched/fair.c:4983
 ? set_next_entity+0x1db/0x630 kernel/sched/fair.c:5743
 ? pick_next_task_fair+0x10da/0x2320 kernel/sched/fair.c:9283
 ? futex_wake+0x1aa/0x500 kernel/futex/futex.h:240
 ? futex_wake_mark+0x230/0x230 kernel/futex/waitwake.c:112
 ? __fget_files+0x1a0/0x250 fs/file.c:1103
 ? usbdev_mmap+0xa00/0xa00 drivers/usb/core/devio.c:286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x877/0x1640 fs/ioctl.c:583
 ? ioctl_file_clone+0xf0/0xf0 fs/ioctl.c:238
 ? io_schedule_timeout+0x150/0x150 kernel/sched/core.c:8079
 ? do_sys_open fs/open.c:1370 [inline]
 ? __do_sys_openat fs/open.c:1386 [inline]
 ? __se_sys_openat fs/open.c:1381 [inline]
 ? __x64_sys_openat+0x12c/0x1d0 fs/open.c:1381
 ? __schedule_loop kernel/sched/core.c:7268 [inline]
 ? schedule+0x7e/0x2f0 kernel/sched/core.c:7283
 ? restore_fpregs_from_fpstate+0x7e/0x100 arch/x86/kernel/fpu/core.c:210
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xad/0x480 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Allocated by task 572283:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:57
 kasan_save_track+0x10/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x77/0x90 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 xhci_alloc_virt_device+0x171/0xb70 drivers/usb/host/xhci-mem.c:986
 xhci_alloc_dev+0x475/0x840 drivers/usb/host/xhci.c:4271
 usb_alloc_dev+0xe8/0xdc0 drivers/usb/core/usb.c:661
 hub_port_connect drivers/usb/core/hub.c:5470 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1c82/0x4050 drivers/usb/core/hub.c:5953
 process_one_work+0x662/0xdb0 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x58b/0xc70 kernel/workqueue.c:3478
 kthread+0x394/0x4b0 kernel/kthread.c:436
 ret_from_fork+0x37f/0x7b0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245

Freed by task 585700:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:57
 kasan_save_track+0x10/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x37/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0xf8/0x390 mm/slub.c:6566
 xhci_free_virt_device+0x3f/0x50 drivers/usb/host/xhci-mem.c:881
 xhci_free_dev+0x286/0x350 drivers/usb/host/xhci.c:4131
 hub_free_dev drivers/usb/core/hub.c:2283 [inline]
 usb_disconnect+0x6b6/0x910 drivers/usb/core/hub.c:2391
 hub_quiesce+0x159/0x310 drivers/usb/core/hub.c:1405
 hub_disconnect+0xd1/0x460 drivers/usb/core/hub.c:1811
 usb_unbind_interface+0x188/0x770 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:621 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:613
 __device_release_driver drivers/base/dd.c:1352 [inline]
 device_release_driver_internal+0x4b6/0x660 drivers/base/dd.c:1375
 usb_driver_release_interface+0x105/0x180 drivers/usb/core/driver.c:640
 proc_ioctl drivers/usb/core/devio.c:2359 [inline]
 proc_ioctl_default drivers/usb/core/devio.c:2402 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2766 [inline]
 usbdev_ioctl+0x6f05/0x86d0 drivers/usb/core/devio.c:2826
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x877/0x1640 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xad/0x480 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

> As you are .edu, perhaps you have a reproducer for this bug?

No, unfortunately.  syzkaller reported the crash but failed to
reproduce it, so there is only the one trace.  The new part seems to be
that a usbfs control request to the root hub can reach
xhci_stop_device() while another thread is tearing that hub down.

> That's an old bug, not sure how such things can still be happening?
> It seems that xhci_free_dev() doesn't return until everything is
> cleared, and I would naively expect USB core not to suspend the bus
> until all devices are suspended or finished disconnecting.
>
> In testing, I see xhci_bus_suspend() 100 ms after disconnection, so
> this race seems tricky to trigger. How have you done it?

Agreed for the bus suspend path: usb_disconnect() is long done by then.
xhci_stop_device() is also the per-port suspend helper for the root
hub, and that path is reachable from userspace without any of that
ordering, which is the window above.

The patch makes xhci_stop_device() re-read xhci->devs[] and the "device
is going away" marker under xhci->lock, and give up with -ENODEV
instead of touching a device that xhci_free_dev() has already detached.
For that check to mean anything, xhci_free_dev() has to clear
virt_dev->udev under the same lock, which is the second hunk.

If you think the mutual exclusion belongs higher up instead - do not
let usbfs suspend a port while the hub is being unbound - I am happy to
work on that; from your message it sounds like you would prefer the fix
there.

Thanks,
YuanZhe

Changes since v4:
 - Commit message only, no code change: the request that reaches
   xhci_stop_device() is SET_FEATURE(PORT_SUSPEND), not
   CLEAR_FEATURE(PORT_SUSPEND) - the latter resumes the port and calls
   xhci_ring_device().

Changes since v3:
 - Commit message only, no code change: the v3 text described the race
   without saying how either side is reached, which made it look like it
   had to collide with the system bus suspend.

 drivers/usb/host/xhci-hub.c | 14 +++++++++-----
 drivers/usb/host/xhci.c     |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index b0264bd8577a..9a3437248e04 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -463,17 +463,21 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 	int i;
 
 	ret = 0;
-	virt_dev = xhci->devs[slot_id];
-	if (!virt_dev)
-		return -ENODEV;
-
-	trace_xhci_stop_device(virt_dev);
 
 	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
 	if (!cmd)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&xhci->lock, flags);
+	virt_dev = xhci->devs[slot_id];
+	if (!virt_dev || !virt_dev->udev) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_free_command(xhci, cmd);
+		return -ENODEV;
+	}
+
+	trace_xhci_stop_device(virt_dev);
+
 	for (i = LAST_EP_INDEX; i > 0; i--) {
 		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
 			struct xhci_ep_ctx *ep_ctx;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5c759ad28199..9e375eb48f38 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4128,9 +4128,12 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	trace_xhci_free_dev(slot_ctx);
 
 	/* Stop any wayward timer functions (which may grab the lock) */
+	spin_lock_irqsave(&xhci->lock, flags);
 	for (i = 0; i < 31; i++)
 		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
 	virt_dev->udev = NULL;
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-- 
2.34.1

