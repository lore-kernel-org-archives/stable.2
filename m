Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381841;
	b=Y0/x6PvOgXm0KqzbgLBdGbfUfoxBmNg76llnsUaweM5Bgcr9d4EfQY8YeHdf9AMQ7CAF
	 WR+W0w95q5NAT4sEXFsf4AbEw9erlWCrM40nVSW1eLbNvuPVxfx6gx8REZttia9NVEXdJ
	 F/UTRWXvCpy8dj168gqUXYgj44FohZQb6KNlMtzcbYc+FZdLIRSAfiL1HYLRVz0NZLXoJ
	 qM/FaTWxDZyTX0aMuSRWnIHZS05ur/QkmObZqJYptMU9S+K18UKkyvdpqZSHivZ5Bwxwz
	 e1rT04D+oPlm8L6dzf2lWt3S0knnWn+5Wm76RXNxbqYXf9XJ2pw1ZOJwUOtbEBA/ShQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381841;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=ID03RBytNGBA9eNwf2RLKsvNI37IhknthtXHZZVwZtM=;
	b=Sc5u+iWuaul0Zl2SLJLE32T2dQO7jWG9Conut7ZU24eUYWSeJQYUfPU0vDtWsnY/ryz1
	 MeNZtjypWcwjGKo8NcAz8X6g6lvHxKhEqTXP/t93VD634YWYMJSg1VKK5FxRgbIXm9O8Z
	 3X566o6SVpvU1PT6/5JuwWH9lQJeBR6S30Ii2hQXBu86EoziEMahLETEA+ZnM6xwRUDDU
	 S1u1BBPg/lpsh6n2rJ49IGbSfKDLsCLHnwZ8J1w5x1gMPS8CCG7KC7T5QeRmtVH3KqUP/
	 Z5g9KWzwNKinDYEuEMho5lFuu4FGeaD37zWkY9KdPmxyJpe40iZwejaY6VVAOOGRRtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9A606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C9A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c7f887ac6bso5383968b6e.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795381840; x=1795986640;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ID03RBytNGBA9eNwf2RLKsvNI37IhknthtXHZZVwZtM=;
        b=xLN0tc3VhdPyRhV62Mz+vHu7r+up956RsYqvz77oLBTbb4n2jMcAzGB8oY0pOMKpY3
         FLnyKgfkaU+MNPTz4k5JzqZW3xiAH3oymp1GCbBLJPTpSmYNsHsYG9kIxLDQdBJaES1K
         waK7SG1IoC+Gi53w2ufq4tIM0ICh2b/9/tqziLy0LLn7jJ5iOkZIH8QlP1jOuifJq9K9
         DJSJQvj3VvutixySqfwWY2yorag0UZqYMcrXiqPyDG7d4RPH6uSX6o6SbNnnatiTz8p7
         L4hJKL6Y5ekGx8WfygvGXk4DuvclB4hyWAox+XmY2DuXtFoO99kbl8mmGGqh67gIEML7
         SyHw==
X-Forwarded-Encrypted: i=1; AL+hErEv3zwL4ownUsOtfld1z8Un+/cj6Uvb7CUNeqBeNhDt0qIC0xaBYjtGoneeMoRC+KBw/iv4YMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8peK86S9+JkMGKN6nHPDSVHG8wgi7SueQlP2Dx7gzEZ18SO9T
	8AdjSpGdiS8Oh6V612nY5MynoKaKq33dUFa4hmU5NE/YzcCOuIiDaIoavh0nkp0A40lVdEau/UG
	7+Rc8PU8MWTHX6PYb2ieumYVQt3by8gMf+K0W73+3TmbH6283dakE9Ed6+dk=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1488:b0:568:1649:9c3a with SMTP id
 5614622812f47-57a0ac2705dmr11593376b6e.43.1795381839955; Sun, 22 Nov 2026
 13:10:39 -0800 (PST)
Date: Sun, 22 Nov 2026 13:10:39 -0800
In-Reply-To: <6b027461.6ccd1e40.868ea.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b035a4f.6ccd1e40.868ea.0020.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in rfcomm_dev_ioctl
From: syzbot <syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com>
To: 25031212117@stu.xidian.edu.cn, 26031212468@stu.xidian.edu.cn, 
	byu@xidian.edu.cn, devnull@kernel.org, gianluca@sottospazio.it, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, leicheng.dev@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, nicoyip.dev@gmail.com, 
	peter@hurleysoftware.com, raghunathpalla.0209@gmail.com, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, tim.bird@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4843f6873f7c Merge tag 'sysctl-7.04-fixes-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115a24ff980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16c0eae9c338e3c
dashboard link: https://syzkaller.appspot.com/bug?extid=11542ff1d167fdffa1fc
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122912bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a0c3162f7b64/disk-4843f687.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81f4f45b477c/vmlinux-4843f687.xz
kernel image: https://storage.googleapis.com/syzbot-assets/856bfc378a1f/bzImage-4843f687.xz

The issue was bisected by AI to:

commit 5b899241874dcc1a2b932a668731c80a3a869575
Author: Gianluca Anzolin <gianluca@sottospazio.it>
Date:   Mon Jan 6 20:23:50 2014 +0000

    Bluetooth: Release RFCOMM port when the last user closes the TTY

AI reasoning:   https://syzkaller.appspot.com/ai_job?id=0137c921-439f-477e-b601-4d5010191e08

AI-generated root cause summary:
In net/bluetooth/rfcomm/tty.c, __rfcomm_dev_add() publishes a newly allocated
struct rfcomm_dev in rfcomm_dev_list and releases rfcomm_dev_lock while holding
only the initial port reference (refcount 1), without taking a reference for
rfcomm_dev_add() to finish registration. When RFCOMM_RELEASE_ONHUP is set, a
concurrent task can open and close the RFCOMM TTY device during or right after
tty_port_register_device(), causing rfcomm_tty_install() to take ownership of
that single reference and release_one_tty() -> rfcomm_tty_cleanup() ->
tty_port_put() -> rfcomm_dev_destruct() to free dev. rfcomm_dev_add() then
performs a slab-use-after-free write to dev->tty_dev (offset 992) and continues
accessing the freed rfcomm_dev.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=11542ff1d167fdffa1fc

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com

The cause commit was identified by AI and may be wrong.
If you agree with it, please also add:
Fixes: 5b899241874d ("Bluetooth: Release RFCOMM port when the last user closes the TTY")

==================================================================
BUG: KASAN: slab-use-after-free in rfcomm_dev_add net/bluetooth/rfcomm/tty.c:335 [inline]
BUG: KASAN: slab-use-after-free in __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
BUG: KASAN: slab-use-after-free in rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
BUG: KASAN: slab-use-after-free in rfcomm_dev_ioctl+0x1bb1/0x21c0 net/bluetooth/rfcomm/tty.c:576
Write of size 8 at addr f
Write of size 8 at addr ffff88802d209488 by task syz.3.20/6147

CPU: 1 UID: 0 PID: 6147 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 rfcomm_dev_add net/bluetooth/rfcomm/tty.c:335 [inline]
 __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
 rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
 rfcomm_dev_ioctl+0x1bb1/0x21c0 net/bluetooth/rfcomm/tty.c:576
 sock_do_ioctl+0x101/0x320 net/socket.c:1328
 sock_ioctl+0x57d/0x7f0 net/socket.c:1449
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95b4bd9559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f95b422e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f95b4e55fa0 RCX: 00007f95b4bd9559
RDX: 0000200000000000 RSI: 00000000400452c8 RDI: 0000000000000006
RBP: 00007f95b4c68136 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f95b4e56038 R14: 00007f95b4e55fa0 R15: 00007fff9fd86628
 </TASK>

Allocated by task 6147:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 poison_kmalloc_redzone mm/kasan/common.c:412 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:267 [inline]
 __kmalloc_cache_noprof+0x3d0/0x670 mm/slub.c:5680
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 __rfcomm_dev_add net/bluetooth/rfcomm/tty.c:221 [inline]
 rfcomm_dev_add net/bluetooth/rfcomm/tty.c:322 [inline]
 __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
 rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
 rfcomm_dev_ioctl+0xc11/0x21c0 net/bluetooth/rfcomm/tty.c:576
 sock_do_ioctl+0x101/0x320 net/socket.c:1328
 sock_ioctl+0x57d/0x7f0 net/socket.c:1449
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 11:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:599
 poison_slab_object mm/kasan/common.c:267 [inline]
 __kasan_slab_free+0x70/0x90 mm/kasan/common.c:299
 kasan_slab_free include/linux/kasan.h:239 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6637 [inline]
 kfree+0x1c7/0x6d0 mm/slub.c:6930
 rfcomm_dev_destruct+0x25c/0x300 net/bluetooth/rfcomm/tty.c:99
 release_one_tty+0xb4/0x280 drivers/tty/tty_io.c:1497
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802d209000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1160 bytes inside of
 freed 2048-byte region [ffff88802d209000, ffff88802d209800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d208
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff16000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff16000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1247, tgid 1247 (kworker/0:2), ts 141949996549
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1873
 prep_new_page+0x22/0xb0 mm/page_alloc.c:1881
 get_page_from_freelist+0x280d/0x2850 mm/page_alloc.c:3963
 __alloc_frozen_pages_noprof+0x230/0x470 mm/page_alloc.c:5505
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7546
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_noprof+0x546/0x790 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 neigh_alloc net/core/neighbour.c:525 [inline]
 ___neigh_create+0x719/0x22d0 net/core/neighbour.c:659
 ip6_finish_output2+0x6e3/0x1480 net/ipv6/ip6_output.c:130
 NF_HOOK_COND include/linux/netfilter.h:314 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:248
 dst_output include/net/dst.h:472 [inline]
 NF_HOOK+0x177/0x4f0 include/linux/netfilter.h:325
 mld_sendpack+0x890/0xe10 net/ipv6/mcast.c:1890
 mld_send_cr net/ipv6/mcast.c:2191 [inline]
 mld_ifc_work+0x842/0xd60 net/ipv6/mcast.c:2739
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
page last free pid 4966 tgid 4966 ts 141932783724 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1415 [inline]
 __free_frozen_pages+0xfb6/0x1090 mm/page_alloc.c:2971
 __slab_free+0x26e/0x2c0 mm/slub.c:5926
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:364
 kasan_slab_alloc include/linux/kasan.h:257 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 kmem_cache_alloc_node_noprof+0x3f7/0x660 mm/slub.c:5105
 __alloc_skb+0x1db/0x7a0 net/core/skbuff.c:705
 alloc_skb include/linux/skbuff.h:1391 [inline]
 alloc_skb_with_frags+0xc6/0x760 net/core/skbuff.c:6940
 sock_alloc_send_pskb+0xc75/0xda0 net/core/sock.c:3093
 unix_dgram_sendmsg+0x4ff/0x17e0 net/unix/af_unix.c:2160
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x41e/0x5d0 net/socket.c:2283
 __do_sys_sendto net/socket.c:2290 [inline]
 __se_sys_sendto net/socket.c:2286 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2286
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802d209380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802d209400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802d209480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802d209500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802d209580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
