Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFA426D3F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823103; cv=none; b=hwx+jx9wVZfEylFQMXCBSysLzP97hCBSh+3HXWVO6uJ2+3z6el7J4P/kMghR7y9ZjXeuQciDwF8qgBqqaFuymBaswr+rbOMiNbIN3VLx1Fi6OpvxK1r749D/eSi0Wfqu+6feNpnvIByU7kug5JDZOllTwefvJCs8fhM9oJGfgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823103; c=relaxed/simple;
	bh=P3fpSl01EL+JlZZ7pcW5UeLGCEoiQ5sAzTvO6JoKySg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XURVYatF9QTgvu1zBmtOWGtV+TYfU8WbKJrzUXHfgKA5ppSLwLXzZleVuceBDlce/TJL8Ap6HYirWxxc991DQzviMtZiRW1DJtDdlnbEJuMke+eRD4HXcAd+A3ORwWrn1PTVuLrMZyottd+uwb6R7CCCsyeXFWEUgRVDpCOwJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b388f7989fso182647b6e.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823097; x=1788427897;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BJoli19LrMNg//Htjj7MlH5QuL1/UfWbHFfI+Ddim1M=;
        b=T+jpyjdODNw5W0lPvCNEVT92KflPQIyctf+ESaQegg9KljX4zFQcGJODJby8xdJu0H
         Cm8klV6k4WhB1JBFz43CKAjueio8BFFXe2GGXPjNU2CPFiypzhkoEL4MNRbdaECLdkdO
         kKpOdN+/PywvOxC7CFOYjhd4e805QQh7UDgOR+YDK2nPGLatTpQ39cYKG9uanpohktnF
         RSFi/lt7UJC1QFYO1NKNf7W5NDjtIWNjcWc0JRyIzJ6+bkvEJkocMyqzyEowDMMLQCcB
         mC7wi8CzQH6OQP7KzVCaJjQef8cJzXKo2xx/nTwiZoj+TNHwoIU4ACNBUx2vGf9RWIsr
         LpsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3WlUU3kCvCPoD/VehrrWW8sdqdj4DfSTvQXscCuVjBVTTMZiyf2ltMz01t0uI5+91Sp7kNTs=@vger.kernel.org
X-Gm-Message-State: AFuF++n0bAcwKT7R/r6yz3W06sAofPcF+1Nb27/WUiSTPecq6Zrgf1en
	agZhO/JRG31h4oX2zYBoJ6QC7SxSkO0ZvERV2VOpnNMZEyYUxi/3lVPDuxpr4Mq0oYTKMhRjeyg
	J6TWoCOV1/5d2XlO2SI8IxrxVD2fSi1lV3UjGiubbg1No1CXazrQZ3zu7t1U=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3505:b0:493:a860:5809 with SMTP id
 5614622812f47-4b3668b1451mr14124640b6e.4.1787823097520; Thu, 27 Aug 2026
 02:31:37 -0700 (PDT)
Date: Thu, 27 Aug 2026 02:31:37 -0700
In-Reply-To: <6a8c451c.dbb3a75c.7844.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9003f9.27659fcc.2ceef7.0012.GAE@google.com>
Subject: Re: [syzbot] [media?] KASAN: slab-use-after-free Read in vidtv_bridge_on_new_pkts_avail
From: syzbot <syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com>
To: dwlsalmeida@gmail.com, gregkh@linuxfoundation.org, 
	jeffinphilip14@gmail.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14fb5625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=c7fc4794e59786f5b4dc
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1033b415580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in vidtv_bridge_check_demod_lock drivers/media/test-drivers/vidtv/vidtv_bridge.c:145 [inline]
BUG: KASAN: slab-use-after-free in vidtv_bridge_on_new_pkts_avail+0x126/0x140 drivers/media/test-drivers/vidtv/vidtv_bridge.c:162
Read of size 8 at addr ffff88802e860118 by task kworker/2:3/5832

CPU: 2 UID: 0 PID: 5832 Comm: kworker/2:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events vidtv_mux_tick
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 vidtv_bridge_check_demod_lock drivers/media/test-drivers/vidtv/vidtv_bridge.c:145 [inline]
 vidtv_bridge_on_new_pkts_avail+0x126/0x140 drivers/media/test-drivers/vidtv/vidtv_bridge.c:162
 vidtv_mux_tick+0xb95/0x1460 drivers/media/test-drivers/vidtv/vidtv_mux.c:426
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e7/0x6b0 mm/slub.c:5484
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 vidtv_demod_i2c_probe+0x6e/0x8a0 drivers/media/test-drivers/vidtv/vidtv_demod.c:421
 i2c_device_probe+0x658/0xd10 drivers/i2c/i2c-core-base.c:593
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1020
 dvb_module_probe+0x165/0x310 drivers/media/dvb-core/dvbdev.c:1039
 vidtv_bridge_probe_demod drivers/media/test-drivers/vidtv/vidtv_bridge.c:354 [inline]
 vidtv_bridge_dvb_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:430 [inline]
 vidtv_bridge_probe+0x370/0xa30 drivers/media/test-drivers/vidtv/vidtv_bridge.c:510
 platform_probe+0x106/0x1d0 drivers/base/platform.c:1507
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
 bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:383
 bus_add_driver+0x305/0x5b0 drivers/base/bus.c:763
 driver_register+0x1e2/0x360 drivers/base/driver.c:174
 vidtv_bridge_init+0x52/0x80 drivers/media/test-drivers/vidtv/vidtv_bridge.c:602
 do_one_initcall+0x11c/0x6f0 init/main.c:1353
 do_initcall_level init/main.c:1415 [inline]
 do_initcalls init/main.c:1431 [inline]
 do_basic_setup init/main.c:1451 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1666
 kernel_init+0x21/0x1e0 init/main.c:1556
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6035:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2678 [inline]
 slab_free mm/slub.c:6372 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6687
 i2c_device_remove+0x81/0x280 drivers/i2c/i2c-core-base.c:632
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 device_unregister+0x1d/0xe0 drivers/base/core.c:4006
 i2c_unregister_device+0xf5/0x270 drivers/i2c/i2c-core-base.c:1076
 dvb_module_release drivers/media/dvb-core/dvbdev.c:1061 [inline]
 dvb_module_release+0x69/0x90 drivers/media/dvb-core/dvbdev.c:1055
 vidtv_bridge_remove+0xd8/0x140 drivers/media/test-drivers/vidtv/vidtv_bridge.c:556
 platform_remove+0x5f/0x80 drivers/base/platform.c:1524
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e860000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 280 bytes inside of
 freed 2048-byte region [ffff88802e860000, ffff88802e860800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802e864000 pfn:0x2e860
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801c042f00 ffffea000071b010 ffffea0000993a10
raw: ffff88802e864000 0000000800080007 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801c042f00 ffffea000071b010 ffffea0000993a10
head: ffff88802e864000 0000000800080007 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 15032077504
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35b0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3267 [inline]
 allocate_slab mm/slub.c:3382 [inline]
 new_slab+0xa5/0x640 mm/slub.c:3428
 refill_objects+0xe3/0x410 mm/slub.c:7305
 refill_sheaf mm/slub.c:2805 [inline]
 __pcs_replace_empty_main+0x372/0x680 mm/slub.c:4677
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4907 [inline]
 __kmalloc_cache_noprof+0x47b/0x6b0 mm/slub.c:5480
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 wakeup_source_device_create+0x46/0x2e0 drivers/base/power/wakeup_stats.c:144
 wakeup_source_sysfs_add+0x1c/0x90 drivers/base/power/wakeup_stats.c:183
 wakeup_source_register+0x154/0x3e0 drivers/base/power/wakeup.c:218
 device_wakeup_enable+0xce/0x2e0 drivers/base/power/wakeup.c:336
 device_init_wakeup include/linux/pm_wakeup.h:238 [inline]
 alarmtimer_rtc_add_device+0x1da/0x320 kernel/time/alarmtimer.c:99
 device_add+0x13cc/0x1970 drivers/base/core.c:3799
 cdev_device_add+0x12b/0x270 fs/char_dev.c:553
 __devm_rtc_register_device+0x456/0x8d0 drivers/rtc/class.c:418
 cmos_do_probe drivers/rtc/rtc-cmos.c:1112 [inline]
 cmos_platform_probe+0xe3b/0x1100 drivers/rtc/rtc-cmos.c:1451
page last free pid 24 tgid 24 ts 14981723256 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_pages_prepare+0x586/0xe00 mm/page_alloc.c:1463
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:7060
 __free_contig_range mm/page_alloc.c:7105 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5322
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3462
 vfree mm/vmalloc.c:3511 [inline]
 vfree+0x108/0x730 mm/vmalloc.c:3485
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3415
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88802e860000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e860080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802e860100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802e860180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e860200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
