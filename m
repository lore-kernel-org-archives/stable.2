Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063397;
	b=vyESWZmQLeWwfgl5R3bKfNLL32RHNOU/76008C8g0gnIqFH9Ptn8KpYBtEzSsjdt6pev
	 ZdgA5g7GcjBRYTaXC3M8lkYiXrfdVrWJ8IQ3TkY4GLvzlgyoUMm5NlPAeUphbnHR/vGjR
	 B/KiG4tv4ifOVBaBs5v6jNynWd3X/OozvAXSPDu12o2o5i7NjLoF6RnMZnYcs/sjMVgYm
	 3doZdBs6Eh396soa+/nlkfTf5FhboWCSqbXhWqZ3WQqyb7QdHZlrmkdGfwZ/2ExQa/yCp
	 N8CQ/qMfMOjmMJO8LJ/lKhujObSgNZCYfoXm95SaLOu5SCm5/xLF+LhwiTXQxIfu1nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063397;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=/E0eR9WiCi6zHnW8I2TtCUddVHVorDZBpRUABzGgD00=;
	b=M4Mrzqm6mXMA5e1gaRkBeT6oyoqayIrZTVwmU//JIOwIu0+dSVfHuhiiVUeWmipACIJx
	 F/vVvOcoTudAWist7ntx2wylzE7smlkqztdVSde45mJY0e4i5dRE3bIdJydfN0MSv7HIa
	 e2uiWEsivDVv53cTkr6VifcExE5W6iez1W23efX1fBkPJ3lEbFbHRxhgklDp2cpGrOuHX
	 NETul1MhZwmu//Mn4if6XXSOMMNP12ChvN/1LRtCUDoloDklY8udEBRqBTJdiknSso1KR
	 5x1B+YS2dPVvnrnsOfs9c+TWCWfq7yPLkm86ZohGZK9TzcyduDRDgMaEsTFRvC4+PIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DA606EE81
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321DA606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-466d41a1d9aso1607358fac.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063396; x=1794668196;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/E0eR9WiCi6zHnW8I2TtCUddVHVorDZBpRUABzGgD00=;
        b=kaHo19x21IkOgandI9WmjWOcditiP9lZAxWZ/2YIOtF4KkBQQgEVamEePzuBQlcY1T
         j6/TWyJ3GoNf3HfoTPhHxcExPROgu1dHO+vfkxi5fubdPGmErVpYBORhXsOI0V0vAm+R
         RWFBIGsiwbpc2po/o9yGJ71TfK4HPEDlKDIvuo7O3WHv9PBHkVFb0scbO2B2NJRzVwGi
         Mc/UmUG44kC+v0KlGdc9rQ7KCJuDc6dM55W6HHkaAo882A5D0akjl3e69hqhxtJasnvL
         pg5zbevqZYhCoOQ2XYPvq1dGdqqDI7qee3XC71lXiIrcFlusJHsfKsDC8OaQUkQxe9IK
         vwzg==
X-Forwarded-Encrypted: i=1; AKwUvBz7qFnlMjUvINMqQEk1TYHmu7Rm7O8c2pegWqhO3nOj8HtHoqLiiIGgn/Te2A8TfS0AheaQ4wA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kTV+RqWWgRnrXnDb1MX9wvyJiFiDevnOLbR4607IhHKLAWcKr
	w/iWv5GjanBQPN7pQNi8DCoRiUs1SoqVWvCSQjljOgT1JZjINRzlUj/DvPjMp+5OpJ7MjWK99/V
	7Sl3m9jwmVubuC2emRt4x5+A9hmZXC6L8DqLw1ZkXqcOdaBMcX4XCR8ThDTg=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:178f:b0:53b:87e5:8c9b with SMTP id
 5614622812f47-567e17ded1bmr4875998b6e.61.1794063396141; Sat, 07 Nov 2026
 06:56:36 -0800 (PST)
Date: Sat, 07 Nov 2026 06:56:36 -0800
In-Reply-To: <6abae226.69bd487b.a6f8c.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aef3c24.4dd4714a.f8d02.0003.GAE@google.com>
Subject: Re: [syzbot] [usb-storage?] INFO: task hung in usb_stor_scan_dwork
From: syzbot <syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, usb-storage@lists.one-eyed-alien.net, 
	xiehongyu1@kylinos.cn, xy521521@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ddfe51b0a0f5 Add linux-next specific files for 20261105
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c79abe580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dffa811bfeed6b4
dashboard link: https://syzkaller.appspot.com/bug?extid=30552b4cbe99d6d91306
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b8cd69580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b8cd69580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/181043a4bd52/disk-ddfe51b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a69d8b670c38/vmlinux-ddfe51b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/906d515c0893/bzImage-ddfe51b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com

INFO: task kworker/0:2:53 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:25320 pid:53    tgid:53    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_freezable usb_stor_scan_dwork
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5583 [inline]
 __schedule+0x17dd/0x5830 kernel/sched/core.c:7382
 __schedule_loop kernel/sched/core.c:7459 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7474
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7531
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c4/0x15a0 kernel/locking/mutex.c:821
 usb_stor_scan_dwork+0xec/0x2c0 drivers/usb/storage/usb.c:987
 process_one_work kernel/workqueue.c:3505 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3588
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3669
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor339:5675 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor339 state:D stack:25984 pid:5675  tgid:5675  ppid:5674   task_flags:0x400040 flags:0x00080802
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5583 [inline]
 __schedule+0x17dd/0x5830 kernel/sched/core.c:7382
 __schedule_loop kernel/sched/core.c:7459 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7474
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7531
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c4/0x15a0 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1109 [inline]
 usbdev_open+0x151/0x760 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:413
 do_dentry_open+0x80e/0x1360 fs/open.c:1000
 vfs_open_consume+0x4a/0x350 fs/open.c:1131
 do_open fs/namei.c:4851 [inline]
 path_openat+0x16fc/0x20f0 fs/namei.c:5016
 do_file_open+0x23e/0x4a0 fs/namei.c:5045
 do_sys_openat2+0x115/0x200 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1789 [inline]
 __se_sys_openat fs/open.c:1784 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1784
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x16a/0x530 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007f51c95c0f57
RSP: 002b:00007ffcc92de380 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055557438e400 RCX: 00007f51c95c0f57
RDX: 0000000000103381 RSI: 00007ffcc92de420 RDI: ffffffffffffff9c
RBP: 00007ffcc92de420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: cccccccccccccccd
R13: 431bde82d7b634db R14: 00007f51c9641c40 R15: 0000000000000002
 </TASK>

Showing all locks held in the system:
locks held by khungtaskd/35: 1, last CPU#1:
 #0: ffffffff9035a560 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff9035a560 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff9035a560 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by kworker/u8:2/46: 2, on CPU#0:
 #0: ffff88813fea4150 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88813fea4150 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88813fea4150 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #0: ffff88813fea4150 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
 #1: ffffc90000b67c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000b67c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000b67c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #1: ffffc90000b67c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
locks held by kworker/0:2/53: 3, on CPU#0:
 #0: ffff88813fe66150 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88813fe66150 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88813fe66150 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #0: ffff88813fe66150 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
 #1: ffffc90000bd7c40 ((work_completion)(&(&us->scan_dwork)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000bd7c40 ((work_completion)(&(&us->scan_dwork)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000bd7c40 ((work_completion)(&(&us->scan_dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #1: ffffc90000bd7c40 ((work_completion)(&(&us->scan_dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
 #2: ffff88807f54cee8 (&us_interface_key[i]){+.+.}-{4:4}, at: usb_stor_scan_dwork+0xec/0x2c0 drivers/usb/storage/usb.c:987
locks held by kworker/0:3/1244: 6, on CPU#0:
 #0: ffff888022689550 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888022689550 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888022689550 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #0: ffff888022689550 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
 #1: ffffc90005367c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90005367c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90005367c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3470 [inline]
 #1: ffffc90005367c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3588
 #2: ffff88802b35a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #2: ffff88802b35a1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff888024ada1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #3: ffff888024ada1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x430 drivers/base/dd.c:1106
 #4: ffff888024ad81a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #4: ffff888024ad81a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x430 drivers/base/dd.c:1106
 #5: ffff88807f54cee8 (&us_interface_key[i]){+.+.}-{4:4}, at: ene_ub6250_probe+0x375/0x610 drivers/usb/storage/ene_ub6250.c:2362
locks held by getty/5393: 2, on CPU#1:
 #0: ffff88803791f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032532e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by syz-executor339/5675: 1, on CPU#0:
 #0: ffff88802b35a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #0: ffff88802b35a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x760 drivers/usb/core/devio.c:1054

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 35 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:377 [inline]
 watchdog+0x1073/0x10f0 kernel/hung_task.c:598
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 3a ad 02 e9 83 17 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d a3 ea 29 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff90007ca0 EFLAGS: 00000246
RAX: 0000000001e595ff RBX: ffffffff819ce03c RCX: 8000000000000001
RDX: 0000000000000001 RSI: ffffffff8e9f0244 RDI: ffffffff8cb01080
RBP: ffffffff90007d78 R08: ffff8880b8233d9b R09: 1ffff110170467b3
R10: dffffc0000000000 R11: ffffed10170467b4 R12: 0000000000000000
R13: 1ffffffff2011df8 R14: 1ffffffff2000f9c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888123159000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564b99d54168 CR3: 0000000010148000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x1cc/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:458
 rest_init+0x378/0x3a0 init/main.c:789
 start_kernel+0x392/0x3e0 init/main.c:1247
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x157
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
