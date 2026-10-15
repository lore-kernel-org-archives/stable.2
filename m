Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4231E82B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030113; cv=none; b=spbon06Y5dJhzHf8cbLgp+1GxDbOXH3dtb2gzi5N9K8Z3ifyrtgUPEQxc20zxcoOVN9dLwpvgdD64bkHqQiNpMxqPdfGzk/1GWmKJqUZaeWCwRxGEEpdyQ+2099dzm6+FqL+vTz60XLWQygMhwkWhyyKyQEXWJl1vpnQ4EG+d7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030113; c=relaxed/simple;
	bh=kS+a1Apcqr+JMCWAhw4KQm6oWbZMgncere4OOj02byA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jmFdZNpTvDpYOS0UxQXLYxR2Ej33gRK+yCo2OAO/pSt5dIEKKZHF9cexqCGyOyaMzAb0EiHczIrunswvSQxuZb3p52AN1aY3kTJ7hWKnTvyFAxNZDUfWlVRuI42NuD9ayEnqsK/pVFZHMmwrCiFAfO6+7Jn6zCuuQzjtCloTZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e9eso1483805b6e.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030110; x=1792634910;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dJUt0/SC4NL8tbtp0K3j7ICXwnGIxbLZUqZ7R/dGRL8=;
        b=VQ85O/4c5pRsRUwD+I2X0RRuErFKZQr/kRzyu5H5rRhYOiKXy7WrPPvEVg2rRK20Yt
         dZaud/vjmHci83Epiw9Bcp630LduHDVgq8ybMJvDw6wKC7wqNIBzH95FcFYFTjdjMlor
         c5wMNo/x7D42MNlxQw9B1lWoGcBtSZw87sFyK4cynqsbzeE+4gMTiO6jMBE/6uHbYs32
         1ibbf2nm32AfAOXxELD2fToUDiJdJM1yaLFq/orw3Y6NcZZ4PbFNkCJ0OH5x/GjIPZMf
         9NELPWLW1Xi3WQiLUkkauiTtvIrPp3YM4w5p0zNqclAxLIXmhbRiUJRNmgpF1hUC4RPh
         NQ3w==
X-Forwarded-Encrypted: i=1; AKwUvBz9v0M5Hlps1/d4SuSytOr1jR9kuGMCgxiFJZdYqRJwLE4L0tF1HxgpwM+pky0QRi0MBTLeJOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO+dcA+6v4REtAWCl2u8bWytsYb7QPLlvcowH7w1SzdCbaE52G
	tXbKWsWSJV73jNrH8ijZ17x/wk90VkPv6c7ZhvZhXgUTGh1nfqW1vcB12V9j0MC2eBV+Hjq9lqV
	ybtby42tHEtbMku9IFnS9zDCMRhf+2QeR6nuePa0j5vBkZ3XEdAbIZvjE/P8=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e88:b0:4b3:7549:d3c0 with SMTP id
 5614622812f47-50c4e67e7b4mr13615300b6e.18.1792030110732; Wed, 14 Oct 2026
 19:08:30 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:08:30 -0700
In-Reply-To: <683199ed.a70a0220.29d4a0.07f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad0359e.7ce658ee.3494bd.0001.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in report_descriptor_read
From: syzbot <syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, krishgulati7@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luto@kernel.org, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d419d682257d Add linux-next specific files for 20261014
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f308a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a67c2e7f805a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f7329c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dcce8e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4bce8ec075a1/disk-d419d682.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/757ea19f6a55/vmlinux-d419d682.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de4428185ddb/bzImage-d419d682.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in report_descriptor_read+0xb5/0x100 drivers/hid/hid-core.c:2279
Read of size 24 at addr ffff88802c2b9e80 by task fido_id/6017

CPU: 0 UID: 0 PID: 6017 Comm: fido_id Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 report_descriptor_read+0xb5/0x100 drivers/hid/hid-core.c:2279
 kernfs_file_read_iter fs/kernfs/file.c:262 [inline]
 kernfs_fop_read_iter+0x434/0x6a0 fs/kernfs/file.c:291
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x595/0xa80 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f840a7dd407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe134d2db0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f840a751880 RCX: 00007f840a7dd407
RDX: 0000000000001000 RSI: 00007ffe134d2e00 RDI: 0000000000000004
RBP: 000055f16ea9c730 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000055f16ea9b930
R13: 00007ffe134d2e00 R14: 0000000000000004 R15: 000055f1306884d8
 </TASK>

Allocated by task 5342:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5531 [inline]
 __kmalloc_node_track_caller_noprof+0x4af/0x720 mm/slub.c:5662
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:713 [inline]
 hid_open_report+0x1fa/0xf00 drivers/hid/hid-core.c:1382
 hid_parse include/linux/hid.h:1208 [inline]
 lg_probe+0x29c/0x890 drivers/hid/hid-lg.c:783
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:623
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3065
 usbhid_probe+0x9d4/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x751/0xe00 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:623
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:623
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802c2b9e80
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88802c2b9e80, ffff88802c2b9ea0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802c2b9b40 pfn:0x2c2b9
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813ff26780 ffffea0001fd0550 ffffea0000ae0e90
raw: ffff88802c2b9b40 000000000040003c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 10415342596
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1854
 prep_new_page mm/page_alloc.c:1862 [inline]
 get_page_from_freelist+0x220f/0x2280 mm/page_alloc.c:3933
 __alloc_frozen_pages_noprof+0x1fe/0x410 mm/page_alloc.c:5457
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_noprof+0x476/0x710 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kobject_get_path+0xc5/0x2f0 lib/kobject.c:161
 kobject_uevent_env+0x29e/0x9e0 lib/kobject_uevent.c:548
 really_probe+0x774/0xae0 drivers/base/dd.c:756
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802c2b9d80: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88802c2b9e00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88802c2b9e80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff88802c2b9f00: 00 00 00 07 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88802c2b9f80: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
