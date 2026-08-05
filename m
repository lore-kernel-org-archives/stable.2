Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6A2BE644
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938492; cv=none; b=XOdE8YvcO+YBsqQSy7OSB2h4VOn8MHyXtmKs0JIAmHCOuWISk/ZSwRQ6t7t9HeAnQ95SH93JBN0UivvwG8GdIMofXXy7Qc4JW9EcMgPITfgbKkl7+N1uyN4jr+tSZgHOOnmM8HU/t6s0GlkvkFPXjgnX8uKshdk78ea69a8YUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938492; c=relaxed/simple;
	bh=k2fhYxdCRfpecQ2myWXJI5lz9KYdQfTTJ3HbH5BTX4s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g3gOzSed3KSA8OXO5XTwZ7GoJXaGyM5XE3t+AKFk54KwSCB46fxaSTsusOitZ21/G9Aa74vGXFTYkCt1kL8KXed1HMVOFe1JwggPMpd7lKALblq1o1OqCPsFdDn8UD2Nd8jod8tcJbjR+EgoEsPLgKyoPaaKgyuu4DCcJYcNdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so636526a34.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938489; x=1786543289;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0QdrHkt5hZY2NWnOKDR/D0JaMn6oDghAXHp9WeWqdoU=;
        b=POcsu8HKC7fjP5uwxdjqqg38TbDWd1TjAtX5WTDJC9BWp5b8HzTWLPNmy2tOqgcuio
         HUX+tqtFf9zN8pmIzVzvuxmFbJ3t+w21gZ+TkrHuBs3ZfS63QVTqgWozymEflb0HDl+a
         E7/LomesxTq6xVWnOc+fgNCe96P3mCba75kOkVhjanfOZoPMkkk6OFMtfGGFnV6XztzU
         jX5VAleGgPSZZjXnXgtloWoFUHfsGOX/xtQgO/NfQeNrARev3TaU2upXM+txgpz2SO43
         EI0DfMKlmfY8LLgijcTHhn5HZhwZreW5CisAcDAt2mU00N8KlrDg3n8eAuj8G1hIo6mo
         Wlxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/b7rwtxLVVmERyl+xK9fEftYIm9+WF3+mxUlMMWivni3VgRJma6JHeS3TZ36vfYLPqeMQYwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0w8zZvT7t8/nb8qTL/emqIgZYiMye+TzmQCbQhc6/SldM8H7
	Ycj8k6LLH4NmsVym2UIZd0fnLDm4T8GxauTJM4tLYbZz2N7TfBpbr2ig9hhFxt+WO30Kpp3ymgV
	oRAQAYEqFUgLd5S52bkq4eJ0Wuf0KT4zanIXNvRI8E/5tObTOe+YQMr4m0Nk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e841:0:b0:6a3:8738:4106 with SMTP id
 006d021491bc7-6ae96f22d3fmr3721052eaf.26.1785938489456; Wed, 05 Aug 2026
 07:01:29 -0700 (PDT)
Date: Wed, 05 Aug 2026 07:01:29 -0700
In-Reply-To: <6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a734239.d1b4d54b.5552d.001c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] KASAN: use-after-free Read in kvm_xen_shared_info_init
From: syzbot <syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com>
To: aha310510@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dwmw2@infradead.org, dwmw@amazon.co.uk, halves@igalia.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	paul@xen.org, pbonzini@redhat.com, pdurrant@amazon.com, seanjc@google.com, 
	souradiptodas6@gmail.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ceecc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16080e49580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
Read of size 4 at addr ffff8880719c4900 by task syz.4.159/7379

CPU: 0 UID: 0 PID: 7379 Comm: syz.4.159 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
 kvm_xen_hvm_set_attr+0xcef/0x16a0 arch/x86/kvm/xen.c:806
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7514
 kvm_vm_ioctl+0x1560/0x4180 virt/kvm/kvm_main.c:5381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11c5d9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f11c6d15028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f11c6026090 RCX: 00007f11c5d9e019
RDX: 0000200000000840 RSI: 000000004048aec9 RDI: 0000000000000004
RBP: 00007f11c5e3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f11c6026128 R14: 00007f11c6026090 R15: 00007ffd79c7b7b8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xe pfn:0x719c4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001865f08 ffff8880b84414b0 0000000000000000
raw: 000000000000000e 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 7379, tgid 7374 (syz.4.159), ts 201002456742, free_ts 201021576054
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 folio_alloc_mpol_noprof+0x36/0x260 mm/mempolicy.c:2509
 shmem_alloc_folio+0x135/0x160 mm/shmem.c:1917
 shmem_alloc_and_add_folio+0x371/0xd40 mm/shmem.c:1959
 shmem_get_folio_gfp+0x6ad/0x1910 mm/shmem.c:2512
 shmem_fault+0x1f9/0xa20 mm/shmem.c:2713
 __do_fault+0x10b/0x440 mm/memory.c:5425
 do_shared_fault mm/memory.c:5924 [inline]
 do_fault+0x2db/0x1750 mm/memory.c:5998
 do_pte_missing mm/memory.c:4566 [inline]
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault+0x187d/0x2a00 mm/memory.c:6517
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x1178/0x32a0 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1752 [inline]
 get_user_pages_unlocked+0x30a/0x7d0 mm/gup.c:2681
 hva_to_pfn_slow virt/kvm/kvm_main.c:2903 [inline]
 hva_to_pfn+0x871/0xd60 virt/kvm/kvm_main.c:2999
page last free pid 7379 tgid 7374 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 __folio_put+0x3b4/0x5f0 mm/swap.c:112
 folio_put include/linux/mm.h:2124 [inline]
 put_page include/linux/mm.h:2193 [inline]
 kvm_release_page_clean virt/kvm/kvm_main.c:2813 [inline]
 kvm_release_page_clean+0x1dc/0x250 virt/kvm/kvm_main.c:2807
 hva_to_pfn_retry virt/kvm/pfncache.c:246 [inline]
 __kvm_gpc_refresh+0x1a63/0x22d0 virt/kvm/pfncache.c:330
 __kvm_gpc_activate+0x2ab/0x490 virt/kvm/pfncache.c:424
 kvm_gpc_activate_hva+0x73/0xa0 virt/kvm/pfncache.c:444
 kvm_xen_hvm_set_attr+0x395/0x16a0 arch/x86/kvm/xen.c:798
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7514
 kvm_vm_ioctl+0x1560/0x4180 virt/kvm/kvm_main.c:5381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880719c4800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880719c4880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880719c4900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880719c4980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880719c4a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
