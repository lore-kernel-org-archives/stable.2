Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEC3A0B2E
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790453587; cv=none; b=mMShw6PKZT401FW8jByxp0OIXTHslDJiZ5+MiibH0a9kR2DA6JPiu9dLYZ6Im6fTtseBPw44zMf0+wSW+zlT1jgPrB6gYMGDJSA3I56yDOwYQ7bA+icRDQpwtakRl5ldv3KJHbqtj1GDz4LuGze7XSQD0BYHOSacp5oRfupkljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790453587; c=relaxed/simple;
	bh=U3L+YHQPZ9Fdg5xPpvxHXwBpO4HqEwdZylo0vbzA2J8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WqSotNLaaTLlfbPNhwn7DZakPr1soGSAWflqpP3u+v9bCSS8seNc5jJaH0TrJiujZwxb412FZBB8rs7ziLXlyVifBEZd1wi0ObPgGvt/m4PnovR4wS2lslnbG3s6TOjzeHsCDs6zV4oF4x+GiLmC/0paQDK6TTXGjJCjsIGoZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab4dd46ddeso2036358b6e.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790453578; x=1791058378;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZBbSho+P85GL1kTDFS5QcK1B7GkOen3bl7RXC8pXvK4=;
        b=cQkJOkuBRYHVKQ7XPViZZNSqtAqpbUBB5CPTVuYs3X5amITGhjZa8a00k/L6mEOK6j
         F4XRHqJ8gCpQFApeFZeQX9/E4jVYnIRu6PEltf/QghXbaltmkShTwJCvt9bc3wzWzJpx
         cEf1wTti9AkJP5iS6hJO+ljlih1VIO1EXz8c9huOgsRyY/gotkcn9zVtCH0NqT6jvy1G
         W3eDfiCkvhDffUSFnBTUwX9LLolrF2s8Av1jrwGrWtN8vnu35x2h5YBpgwKFp568XuIY
         krGdOQ91zfqeSQkR9VZ00aqc/ZtALMxpDW7Rl2cydTxwHbeXXrJ1fUbQDlVKk2Kttm+k
         AeIQ==
X-Forwarded-Encrypted: i=1; AKwUvBygQN9Lh06cT6f50uqcrK0ERBpMLaVDgaAEYuy46zaNHMkCE5dp74ajycjndDKFUFNET/3lqUA=@vger.kernel.org
X-Gm-Message-State: AFuF++kM9nMnvTscAcGdcVcba/Sg61WxRU84F/7ZIazAEwWAYJ3SYnhH
	dPxEe+SYXywRXJlijb8cCOXJ6/rd+VALu2lw3B1c8SmQUkfXPEEH1cT1q/OdQ86UArFiUkYcKgz
	0LkFm6rP/3iBj6xSRgtYPYx+eqWMDrVsiBzixDPXWKI2kKW7QT8DY2XQkz5c=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1599:b0:4cb:d056:b14f with SMTP id
 5614622812f47-4dc57e2b419mr5560159b6e.1.1790453578422; Sat, 26 Sep 2026
 13:12:58 -0700 (PDT)
Date: Sat, 26 Sep 2026 13:12:58 -0700
In-Reply-To: <20260924070410.2629558-1-benquike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8274a.80e1c6cc.1e8e5f.004a.GAE@google.com>
Subject: [syzbot ci] Re: hfs: validate allocation block parameters in hfs_mdb_get()
From: syzbot ci <syzbot+cie54066e4e095b471@syzkaller.appspotmail.com>
To: benquike@gmail.com, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] hfs: validate allocation block parameters in hfs_mdb_get()
https://lore.kernel.org/all/20260924070410.2629558-1-benquike@gmail.com
* [PATCH v2] hfs: validate allocation block parameters in hfs_mdb_get()

and found the following issue:
KASAN: invalid-free in hfs_mdb_put

Full report is available here:
https://ci.syzbot.org/series/cf0561b3-479e-4e81-9209-dcf5e7c97d22

***

KASAN: invalid-free in hfs_mdb_put

tree:      vfs
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/vfs/vfs.git
base:      84086827932b58e7645d93d970bbc566c4ee408b
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/23fc2a96-ed2b-4fed-8d8d-653b871c6c0f/config
syz repro: https://ci.syzbot.org/findings/d2c81756-7cff-47d8-b984-468d9efaef7b/syz_repro

loop1: detected capacity change from 0 to 64
hfs: inconsistent allocation block parameters in MDB
hfs: can't find a HFS filesystem on dev loop1
==================================================================
BUG: KASAN: double-free in hfs_mdb_put+0x15b/0x270 fs/hfs/mdb.c:467
Free of addr ffff888117e9bc00 by task syz.1.18/5837

CPU: 0 UID: 0 PID: 5837 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
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
 slab_free_hook mm/slub.c:2693 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x173/0x650 mm/slub.c:6801
 hfs_mdb_put+0x15b/0x270 fs/hfs/mdb.c:467
 hfs_fill_super+0x4d2/0x7b0 fs/hfs/super.c:403
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1897
 vfs_get_tree+0x92/0x2a0 fs/super.c:1957
 fc_mount fs/namespace.c:1209 [inline]
 do_new_mount_fc fs/namespace.c:3785 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3861
 do_mount fs/namespace.c:4194 [inline]
 __do_sys_mount fs/namespace.c:4408 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4385
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0f2619f3ca
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f27037e58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0f27037ee0 RCX: 00007f0f2619f3ca
RDX: 0000200000000180 RSI: 00002000000000c0 RDI: 00007f0f27037ea0
RBP: 0000200000000180 R08: 00007f0f27037ee0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00007f0f27037ea0 R14: 0000000000000305 R15: 0000200000001800
 </TASK>

Allocated by task 5837:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_node_track_caller_noprof+0x4b4/0x720 mm/slub.c:5545
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 hfs_mdb_get+0x895/0x2350 fs/hfs/mdb.c:194
 hfs_fill_super+0x482/0x7b0 fs/hfs/super.c:352
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1897
 vfs_get_tree+0x92/0x2a0 fs/super.c:1957
 fc_mount fs/namespace.c:1209 [inline]
 do_new_mount_fc fs/namespace.c:3785 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3861
 do_mount fs/namespace.c:4194 [inline]
 __do_sys_mount fs/namespace.c:4408 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4385
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5837:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6801
 hfs_mdb_put+0x15b/0x270 fs/hfs/mdb.c:467
 hfs_mdb_get+0x1935/0x2350 fs/hfs/mdb.c:318
 hfs_fill_super+0x482/0x7b0 fs/hfs/super.c:352
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1897
 vfs_get_tree+0x92/0x2a0 fs/super.c:1957
 fc_mount fs/namespace.c:1209 [inline]
 do_new_mount_fc fs/namespace.c:3785 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3861
 do_mount fs/namespace.c:4194 [inline]
 __do_sys_mount fs/namespace.c:4408 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4385
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888117e9bc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 512-byte region [ffff888117e9bc00, ffff888117e9be00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888117e9b400 pfn:0x117e98
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000240 ffff888100041c80 ffffea00045caa10 ffffea000440b710
raw: ffff888117e9b400 000000000010000c 00000000f5000000 0000000000000000
head: 017ff00000000240 ffff888100041c80 ffffea00045caa10 ffffea000440b710
head: ffff888117e9b400 000000000010000c 00000000f5000000 0000000000000000
head: 017ff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5611, tgid 5611 (syz-executor), ts 59180259569
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
 __kmalloc_cache_noprof+0x39b/0x600 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 device_private_init drivers/base/core.c:3606 [inline]
 device_add+0xb6/0xb80 drivers/base/core.c:3657
 netdev_register_kobject+0x197/0x350 net/core/net-sysfs.c:2340
 register_netdevice+0x1433/0x1eb0 net/core/dev.c:11503
 __ip_tunnel_create+0x3e8/0x550 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2e5/0x820 net/ipv4/ip_tunnel.c:1137
 ops_init+0x35d/0x5d0 net/core/net_namespace.c:137
 setup_net+0x118/0x350 net/core/net_namespace.c:443
 copy_net_ns+0x53b/0x780 net/core/net_namespace.c:582
 create_new_namespaces+0x3f0/0x6b0 kernel/nsproxy.c:132
page last free pid 5575 tgid 5575 ts 47941916741 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xc93/0xd90 mm/page_alloc.c:2962
 __slab_free+0x274/0x2c0 mm/slub.c:5823
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x2b9/0x600 mm/slub.c:5010
 alloc_buffer_head+0x2a/0x280 fs/buffer.c:2881
 folio_alloc_buffers+0x1a4/0x630 fs/buffer.c:749
 create_empty_buffers+0x3a/0x520 fs/buffer.c:1587
 ext4_block_write_begin+0x610/0x1560 fs/ext4/inode.c:1193
 ext4_da_write_begin+0x879/0xd70 fs/ext4/inode.c:3167
 generic_perform_write+0x2d5/0x8f0 mm/filemap.c:4374
 ext4_buffered_write_iter+0xd4/0x380 fs/ext4/file.c:354
 ext4_file_write_iter+0xae4/0x1cd0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739

Memory state around the buggy address:
 ffff888117e9bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888117e9bb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888117e9bc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888117e9bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888117e9bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
