Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE23CAE74
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548338; cv=none; b=lmv+TytwHV5+6Cb1+OhWuG8GfcRwn+vWXkZ/Qc75wFvuWLDLGIP1zWe20d8MPpyaHe+QvqmT9WGacuyjoKR7+nmxFSpsZTq0ZKBGGMf8l+1afbNtNPLglhALUZiiKtZ1i9tLf5bAtel0t12eVB+FIGR2W/lFyMBoafM2aj3/Qxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548338; c=relaxed/simple;
	bh=sM6zusQp/PT4jAH7zPJfQhSW1sWz3vNaT1T2t19TrQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nst1DBKg1z1aoHFBkXYYKOgo5aPSjbN49b05ERvCm6ujIrVfWIVROgAjVj8VZDfNqd2ZSFeuGr3OdHhxR6xwShN4Kx+0JpATBbsARy0GPuL2UUZJLlrXXmU1kxwcdi7E45r7SUaSINQKj7m+cfQGL58pnVapSKv4OZ+A9VDAghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c467e19391so5512528b6e.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790548335; x=1791153135;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ak7YetcBkEWxfi+D/Vs28PDHgHcX4ZHuV0e7+B3EhFc=;
        b=p6FXXPViB2TcUHs70lMIDAgZDlnOTUoRxXU4j5uld6WYL0rizI/JgGq3CPTHHFNc65
         k+y2wA9+srwOFf8wkj3d7uITg3l0O8cZUSV7raczGf6obyUK3XXBP5uEpCqJe+tKDyZ+
         NRko+4N8fZjbAapBXE51dBUDxp0GEfuovjoLE7yOwZrwr5OKxJHEHCmkfhj8BMZFPkzx
         CYO+c1DKqjs4SKnOtHLfFaq3ffp2xADxybPolDzL/jPy6TxdXt+S6txbDRbYbDNqCXny
         mospXOi7EDXhmjWD4wOa8nHyoCx7Di13ilNNZ72BV8Ic72sOnzXKrJ0IyDJbC+kVq3mU
         vHTg==
X-Forwarded-Encrypted: i=1; AKwUvBwkhRNLyhz0kESlfTUOAmUru22ShBG97Otkr/iUqlTqtsS3/A7eLnMoazAu0C2CjiJ/jU5JTlc=@vger.kernel.org
X-Gm-Message-State: AFuF++lBsPdqBaPOrU7AsJllV96kJITdscuEgrHIR3eKOVZpJiOthwXm
	B7Yxo99oM54/2p1Lm/PrRo7wQVoKxiLIoA949VMzv9TK+FxUA6oZS+rhFKd+Tmg/bJvbIrLKMAe
	DFVLmGCYjwc2/fqWBun3VKME4jq1SdA3Ys2DCT7uhmQCsoKcOROkpUu7HsYY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3082:b0:4ea:8166:e1a1 with SMTP id
 5614622812f47-4ea8167052emr1377762b6e.64.1790548335750; Sun, 27 Sep 2026
 15:32:15 -0700 (PDT)
Date: Sun, 27 Sep 2026 15:32:15 -0700
In-Reply-To: <20260925184857.357926-1-qwe.aldo@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab9996f.80e1c6cc.1e8e5f.0065.GAE@google.com>
Subject: [syzbot ci] Re: nfc: llcp: prevent resource leak on repeated connect
 after DM
From: syzbot ci <syzbot+ci3c472c63e196fe9e@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, qwe.aldo@gmail.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] nfc: llcp: prevent resource leak on repeated connect after DM
https://lore.kernel.org/all/20260925184857.357926-1-qwe.aldo@gmail.com
* [PATCH net v2] nfc: llcp: prevent resource leak on repeated connect after DM

and found the following issues:
* KASAN: slab-use-after-free Read in llcp_sock_connect
* KASAN: slab-use-after-free Read in nfc_remove_device

Full report is available here:
https://ci.syzbot.org/series/5e0cb36e-53b9-46fb-95cf-63d7aa556657

***

KASAN: slab-use-after-free Read in llcp_sock_connect

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      415f2044228cc8b948dc04e079aaa86a4d1aa1d3
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/b9c88e36-7160-4be9-b8c4-0246fd730eef/config
syz repro: https://ci.syzbot.org/findings/64002827-5231-4183-bfca-0d91bded8543/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in kobject_put+0x2a2/0x550 lib/kobject.c:733
Read of size 1 at addr ffff8881ae430054 by task syz.2.20/5885

CPU: 0 UID: 0 PID: 5885 Comm: syz.2.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 kobject_put+0x2a2/0x550 lib/kobject.c:733
 nfc_put_device net/nfc/nfc.h:103 [inline]
 llcp_sock_connect+0x2f5/0xc50 net/nfc/llcp_sock.c:701
 connect_socket net/socket.c:2141 [inline]
 __sys_connect_file net/socket.c:2166 [inline]
 __sys_connect+0x316/0x450 net/socket.c:2183
 __do_sys_connect net/socket.c:2189 [inline]
 __se_sys_connect net/socket.c:2186 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2186
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f012ed9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f012fb8e028 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f012f025fa0 RCX: 00007f012ed9e159
RDX: 0000000000000060 RSI: 0000200000000380 RDI: 0000000000000004
RBP: 00007f012ee3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f012f026038 R14: 00007f012f025fa0 R15: 00007fff3cb60738
 </TASK>

Allocated by task 5885:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x600 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 nfc_allocate_device+0x129/0x560 net/nfc/core.c:1065
 nci_allocate_device+0x1da/0x380 net/nfc/nci/core.c:1206
 virtual_ncidev_open+0x75/0x1a0 drivers/nfc/virtual_ncidev.c:141
 misc_open+0x2d5/0x350 drivers/char/misc.c:163
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5885:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6801
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 nfc_put_device net/nfc/nfc.h:103 [inline]
 nfc_llcp_local_put+0xb7/0xe0 net/nfc/llcp_core.c:196
 llcp_sock_connect+0x2bb/0xc50 net/nfc/llcp_sock.c:698
 connect_socket net/socket.c:2141 [inline]
 __sys_connect_file net/socket.c:2166 [inline]
 __sys_connect+0x316/0x450 net/socket.c:2183
 __do_sys_connect net/socket.c:2189 [inline]
 __se_sys_connect net/socket.c:2186 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2186
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881ae430000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 84 bytes inside of
 freed 2048-byte region [ffff8881ae430000, ffff8881ae430800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ae430
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff888100042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff888100042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 057ff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5818, tgid 5818 (kworker/1:6), ts 69407176292
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_node_track_caller_noprof+0x548/0x720 mm/slub.c:5545
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 __alloc_skb+0x2c1/0x7a0 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack+0x165/0xcb0 net/ipv6/mcast.c:1810
 add_grhead net/ipv6/mcast.c:1921 [inline]
 add_grec+0x119f/0x19d0 net/ipv6/mcast.c:2060
 mld_send_cr net/ipv6/mcast.c:2185 [inline]
 mld_ifc_work+0x6f1/0xd60 net/ipv6/mcast.c:2739
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5677 tgid 5677 ts 63170557312 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_pages_prepare+0x9eb/0xaf0 mm/page_alloc.c:1463
 __free_contig_range_common+0x174/0x340 mm/page_alloc.c:7072
 __free_contig_range mm/page_alloc.c:7117 [inline]
 free_pages_bulk+0x48/0x120 mm/page_alloc.c:5322
 vm_area_free_pages mm/vmalloc.c:3461 [inline]
 vfree+0x231/0x490 mm/vmalloc.c:3510
 kcov_put kernel/kcov.c:451 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:556
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1012
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1155
 get_signal+0x121b/0x12c0 kernel/signal.c:3112
 arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x10e/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8881ae42ff00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff8881ae42ff80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff8881ae430000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8881ae430080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881ae430100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

KASAN: slab-use-after-free Read in nfc_remove_device

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      415f2044228cc8b948dc04e079aaa86a4d1aa1d3
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/b9c88e36-7160-4be9-b8c4-0246fd730eef/config

==================================================================
BUG: KASAN: slab-use-after-free in sysfs_remove_file_ns+0x3d/0x70
Read of size 8 at addr ffff888177b8a048 by task syz.1.3888/17756

CPU: 0 UID: 0 PID: 17756 Comm: syz.1.3888 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150
 print_address_description+0x55/0x1e0
 print_report+0x58/0x70
 kasan_report+0x117/0x150
 sysfs_remove_file_ns+0x3d/0x70
 device_del+0x503/0x8f0
 nfc_remove_device+0xa7/0xc0
 virtual_ncidev_close+0x56/0x90
 __fput+0x418/0xa50
 fput_close_sync+0x11f/0x240
 __x64_sys_close+0x7e/0x110
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb42af9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb42bdab028 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007fb42b226090 RCX: 00007fb42af9e159
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb42b03506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb42b226128 R14: 00007fb42b226090 R15: 00007fff6f3d29a8
 </TASK>

Allocated by task 17749:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x93/0xb0
 __kmalloc_cache_noprof+0x321/0x600
 nfc_allocate_device+0x129/0x560
 nci_allocate_device+0x1da/0x380
 virtual_ncidev_open+0x75/0x1a0
 misc_open+0x2d5/0x350
 chrdev_open+0x4d9/0x600
 do_dentry_open+0x816/0x1380
 vfs_open+0x3b/0x340
 path_openat+0x1443/0x1d60
 do_file_open+0x23e/0x4a0
 do_sys_openat2+0x115/0x200
 __x64_sys_openat+0x138/0x170
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 17756:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x40/0x50
 __kasan_slab_free+0x5c/0x80
 kfree+0x1c5/0x650
 device_release+0xc4/0x1f0
 kobject_put+0x222/0x550
 device_del+0x4cb/0x8f0
 nfc_remove_device+0xa7/0xc0
 virtual_ncidev_close+0x56/0x90
 __fput+0x418/0xa50
 fput_close_sync+0x11f/0x240
 __x64_sys_close+0x7e/0x110
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888177b8a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 72 bytes inside of
 freed 2048-byte region [ffff888177b8a000, ffff888177b8a800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x177b88
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff888100042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff888100042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 057ff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5596, tgid 5596 (syz-executor), ts 59551528746
 post_alloc_hook+0x1f9/0x250
 get_page_from_freelist+0x2209/0x2280
 __alloc_frozen_pages_noprof+0x217/0x5a0
 allocate_slab+0x7d/0x620
 refill_objects+0x2d5/0x350
 __pcs_replace_empty_main+0x2c8/0x6c0
 __kmalloc_node_track_caller_noprof+0x548/0x720
 pskb_expand_head+0x22c/0x13a0
 netlink_trim+0x1b3/0x2c0
 netlink_broadcast_filtered+0x6d/0xea0
 nlmsg_notify+0xe3/0x1a0
 rtnetlink_event+0x224/0x270
 notifier_call_chain+0x1a5/0x3d0
 netif_set_mac_address+0x393/0x4d0
 do_setlink+0x9ad/0x4670
 rtnl_newlink+0x15a3/0x1c30
page last free pid 15 tgid 15 ts 54085035095 stack trace:
 __free_frozen_pages+0xc93/0xd90
 __folio_put+0x4b3/0x590
 skb_release_data+0x573/0xab0
 __kfree_skb+0x5d/0x210
 e1000_clean+0x4ae/0x2bf0
 __napi_poll+0xaa/0x330
 net_rx_action+0x61d/0xf50
 handle_softirqs+0x226/0x860
 run_ksoftirqd+0x36/0x60
 smpboot_thread_fn+0x565/0xa70
 kthread+0x38b/0x480
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30

Memory state around the buggy address:
 ffff888177b89f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888177b89f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888177b8a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888177b8a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888177b8a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
