Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552843659EB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468868; cv=none; b=D4det7XA3rWvVs/0FNUKMrqH3AwBkPt0/dSvfSbAxdHfQxYxZMsfZ6QimV5PvN5NUeGjUg2SPSEQpXOkOjBTbbKOSTLq2GaIDhBU0wTGmieuwSqXq6CaKFpOTrfvkQT8OiDyJvoKeznQUmX1BHS/dERNGweoCnCRwoy40W3kWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468868; c=relaxed/simple;
	bh=cN5ZuWZDIAU+kQ7Udn5SiYafXl8vRzAvQiLkg2LwMWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WNV/IV4/fx4ukjjkEDQPEY7ozKlb3FMH3KDWKAxso6WD7vpH9MoM68PRoK+a33sNJbTkd6hZksTQqdFHVWisFsRsHTd74JHeQ9KhwcRYldSMEZoHOtPJs1az6FeFo9pmWPflV0pBpYkkgElwqjpIqlFUOZ8a9YlB4Mm+l634jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69dc9cb3663so10578269eaf.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 23:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468866; x=1781073666;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/l/m5lHUJsJap9MAms6EJQlc8zuBSTF5f+B8GIWI9o=;
        b=aiXSCXEqMsUWWwj+olRyp0A++meLG5RnemNqMp330NJSxJqGuuUNbYvORC56YbUEBT
         YjfIJrImJ5g06veamJTwWv7TboY8f8RPIjKq98wFMWhzfI4iMfa/AIVl9+SngmQ6Z2cH
         Tuqu+ma1jzTBm8hnyjvK+7RM4tRnEaNSrUEQyg6/UDvBiIF5lY9WnMOF3U2KHLTTZs0y
         17n50AUVYWTCnJXpR5zeu8/asRDtOgpUNzDvsYqZod3GW6h0UU5aJ4N2c1MN1pmBmnrx
         Y0EsFN6vGEy7s+bTtNdcT1SqZGNlXYNXHkZQJN+e0piv38gXLCGvoLV5h+/MqI//bc1g
         +KLw==
X-Forwarded-Encrypted: i=1; AFNElJ8vdR1+0cxOGjD5/ELSfQylcIMxL+Bak9OiHGbR2VuOnOZTtkUPBk4tqhWrq3WgmAChR0gHGt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhOol+ERQcNiNByMB9vlfk53PdO/7Roo9pJrxPpiBjnAjpvur
	b7diHzHhNY5ym81+O0mBL9yrN4VkEci6AjybxRofIM9Ml6P9SDeFLE3Gragiilx2a00w65tNqFD
	UqsTIKDksm4CTHc/kmI4Y7zNKl/z4S5ZXRP6MV72tIKSZ+yVQrGHBEyxwvkE=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8106:b0:696:806e:fd6 with SMTP id
 006d021491bc7-69e480b26acmr1483032eaf.40.1780468866505; Tue, 02 Jun 2026
 23:41:06 -0700 (PDT)
Date: Tue, 02 Jun 2026 23:41:06 -0700
In-Reply-To: <20260603021035.3690601-1-vulab@iscas.ac.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1fcc82.b4221f80.1326c5.0007.GAE@google.com>
Subject: [syzbot ci] Re: block/fops: fix refcount underflow in __blkdev_direct_IO()
From: syzbot ci <syzbot+ci54b64cdbaca88ef6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, vulab@iscas.ac.cn
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] block/fops: fix refcount underflow in __blkdev_direct_IO()
https://lore.kernel.org/all/20260603021035.3690601-1-vulab@iscas.ac.cn
* [PATCH] block/fops: fix refcount underflow in __blkdev_direct_IO()

and found the following issue:
KASAN: invalid-free in mempool_free

Full report is available here:
https://ci.syzbot.org/series/3498c893-003a-4780-92e5-c3090ee3fe45

***

KASAN: invalid-free in mempool_free

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0616259e-7b19-4982-aeee-0a50317c4cc6/config
syz repro: https://ci.syzbot.org/findings/d2d98b4c-c6a9-4ecb-b313-ebd5a6d1b0d8/syz_repro

==================================================================
BUG: KASAN: double-free in mempool_free+0xec/0x130 mm/mempool.c:711
Free of addr ffff888177994400 by task syz.0.17/5875

CPU: 1 UID: 0 PID: 5875 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation mm/kasan/common.c:-1 [inline]
 __kasan_slab_pre_free+0x104/0x120 mm/kasan/common.c:261
 kasan_slab_pre_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:2634 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x130/0x650 mm/slub.c:6378
 mempool_free+0xec/0x130 mm/mempool.c:711
 bio_free+0x1e9/0x330 block/bio.c:205
 __blkdev_direct_IO+0xd89/0xf40 block/fops.c:290
 blkdev_direct_IO+0x121a/0x1790 block/fops.c:438
 blkdev_read_iter+0x23d/0x440 block/fops.c:841
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_readv+0x288/0x840 fs/read_write.c:1020
 do_preadv fs/read_write.c:1134 [inline]
 __do_sys_preadv2 fs/read_write.c:1193 [inline]
 __se_sys_preadv2+0x184/0x2a0 fs/read_write.c:1184
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f125c99ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f125d829028 EFLAGS: 00000246 ORIG_RAX: 0000000000000147
RAX: ffffffffffffffda RBX: 00007f125cc15fa0 RCX: 00007f125c99ce59
RDX: 0000000000000005 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f125ca32d6f R08: 0000000000000000 R09: 000000000000001f
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f125cc16038 R14: 00007f125cc15fa0 R15: 00007fff02d2e3e8
 </TASK>

Allocated by task 5875:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4906
 bio_alloc_bioset+0x599/0xc90 block/bio.c:571
 __blkdev_direct_IO+0x294/0xf40 block/fops.c:186
 blkdev_direct_IO+0x121a/0x1790 block/fops.c:438
 blkdev_read_iter+0x23d/0x440 block/fops.c:841
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_readv+0x288/0x840 fs/read_write.c:1020
 do_preadv fs/read_write.c:1134 [inline]
 __do_sys_preadv2 fs/read_write.c:1193 [inline]
 __se_sys_preadv2+0x184/0x2a0 fs/read_write.c:1184
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5875:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6378
 mempool_free+0xec/0x130 mm/mempool.c:711
 bio_free+0x1e9/0x330 block/bio.c:205
 __blkdev_direct_IO+0xd6e/0xf40 block/fops.c:288
 blkdev_direct_IO+0x121a/0x1790 block/fops.c:438
 blkdev_read_iter+0x23d/0x440 block/fops.c:841
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_readv+0x288/0x840 fs/read_write.c:1020
 do_preadv fs/read_write.c:1134 [inline]
 __do_sys_preadv2 fs/read_write.c:1193 [inline]
 __se_sys_preadv2+0x184/0x2a0 fs/read_write.c:1184
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888177994400
 which belongs to the cache biovec-max of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff888177994400, ffff888177995400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888177990000 pfn:0x177990
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000240(workingset|head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000240 ffff8881604148c0 ffff8881622adc48 ffffea0005de5010
raw: ffff888177990000 0000000800070003 00000000f5000000 0000000000000000
head: 057ff00000000240 ffff8881604148c0 ffff8881622adc48 ffffea0005de5010
head: ffff888177990000 0000000800070003 00000000f5000000 0000000000000000
head: 057ff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5065, tgid 5065 (udevd), ts 29098398773, free_ts 24434603765
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x2593/0x2610 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 kmem_cache_alloc_noprof+0x37d/0x650 mm/slub.c:4906
 bio_alloc_bioset+0x599/0xc90 block/bio.c:571
 bio_alloc include/linux/bio.h:367 [inline]
 ext4_mpage_readpages+0x13b5/0x1f30 fs/ext4/readpage.c:355
 read_pages+0x193/0x5a0 mm/readahead.c:163
 page_cache_ra_unbounded+0x794/0xa10 mm/readahead.c:304
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0xae4/0xe80 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2664 [inline]
 filemap_get_pages+0x897/0x1ef0 mm/filemap.c:2710
 filemap_read+0x447/0x1230 mm/filemap.c:2806
 __kernel_read+0x504/0x9b0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0xc1c/0xd30 mm/page_alloc.c:2938
 vfree+0x1d1/0x2f0 mm/vmalloc.c:3472
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3392
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888177994300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888177994380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888177994400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888177994480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888177994500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
