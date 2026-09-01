Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6439A045
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236487; cv=none; b=ADa6CBHI1g15ZGP9FW04Df1uCAjsMlF/TfV5UajNvtB45pCh2uYFAvUKwfT78L+D3TRXK3DOMZSAXbs+YR2b5+ovyEBynXR8umkncVycIiXePNcCOGVrU6KlpiAn1brNCb7bJGRyoynnqWhZwzj9jPTNjcwqYiVwtrtR7YMGx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236487; c=relaxed/simple;
	bh=A91y0GAZWSHlQFnacchEMu82EOqJRPRpRj+zpYkpRiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoohT6INEw8w3+5yeLx28PAP/sLwfYfhgMY5qmubEUvHqOpYaTTxuObLoReOzB+pKFXz1WWV29HCamVP1AWrgDs7VcTwNhvmHHzal63752bTBLwnlrfIIyFhYhG7C2Gxu3mKJLtt3X2s1ZiKOWkwprR84Y7pGgYDybedeqVN71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oM/sTmiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/ip1ID2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oM/sTmiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/ip1ID2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 491B5EC029B;
	Tue,  1 Sep 2026 00:21:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 00:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788236483;
	 x=1788322883; bh=aCb8XytKYiK+aGBbVziC4XVmmijOXVCJCXc78m1F3uI=; b=
	oM/sTmiMBNopm4rFl7cEQQ6Vhficqe/iG37FdSHpUM04oerLvFCB11bXtRo97L0A
	9Nn39f2rbBVlrdwpl7vCzKMDHl+V7rCmX+go8AyGXWN68p3Z4uav2YVzX/24YlAp
	SwxHRvfTELHaZhequ9EDFWRvDeWEOOh9KUmBxKXVV8niWVi7pTZbjnpE8SCcA1so
	R02cfgoj+muXXHL6xu9b85a2DZDJmslyClFWQ2Ni7KKVMYeEjp6Xh4TdJIdJiOiy
	mHrNmrpWcB+Qr6Ox6wcdBK5iVO0YzVusprJQkMV/sUR7IEikdJbPPLDPfzaw6I9+
	x6nOApIbFV+8w3ARLLYQUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788236483; x=
	1788322883; bh=aCb8XytKYiK+aGBbVziC4XVmmijOXVCJCXc78m1F3uI=; b=b
	/ip1ID2fxPmscbTeKW/YiqCX2VgiLkb40zImDpuCcfEwrO/hOz46L29NZVsQS7WL
	B0s3ursmKO4Hifsx4lyBWfuqnv8lwfCs7Lnde+FmpaZhK/dSwtzJOau0KcMWLlJo
	Rals44U6M0pqucbRAcgfpA3yyMxYudksD29LEX/Q+9u8uL3lorSdwFsGB6JipSon
	/9vvHt2qmf+33nUlB7jcZ5mUfOa8cxwUSNIYYRYdnjI9Sxxw1Bc/JzqA+KwcDG2X
	UZ8RkFtqw4FL2UjlQ/mdnv1hbTsy+ZjI3RSQqlN+LM6grK3ewkUmi6Yj242/81gT
	WxiTP0pWYKt0oGnI+VnjA==
X-ME-Sender: <xms:wlKWaoIzwoMVenPfrn4xi8y1eOrJIxSuDbgRWZHvl4eYdZ_0YmTaCQ>
    <xme:wlKWaolwcN3sIGACvo16uH3G0QjAWen3BrmPbs-TxUxj65Z-aDho4O5vFx9K2X8Xw
    VsicV0T-oh9cATb5RQcsyTzEHcu0C3hBaG1bnpxSmaG7JcwnZo>
X-ME-Received: <xmr:wlKWapb8TaMHZANFjI5ICsyT9jX4xk7G4VXkCn6uPHWi-RyA4vVfUS7q_2qH85gY0j2z5BNZu6PQDWPHCdovVyf7XGqidntwF_u6J-aRFY0>
X-ME-Proxy-Cause: dmFkZTFBkneFTkEJxiwrXTp0V8iRZ+3VY7Aoo1Hi407RXSg8kKUp2J2AdEysnyDtL1yest
    FK9I5kXjPF990iISPs7qz1p0QsNUGEFVwEwR6FJnFnDmq0cJrnJzqs0a0rVNRr9tSybiSi
    gkAkIopaTUp0HOxMlVs4FZH+zhiv3MeJjil0io09twTHI/M42A6dgGoWSpkWSxv5gW6dQb
    PfkM1XLk7KPxMAUsynC8RbVglLQc39KWAjZyg3/nat5ZSV6TxsioXOku9xBm1Rqtm71n0V
    xlSCet2KXgEOmHfVWW/hwGOXiNnxZRNFoCB5ye1Sxya8RJi+Ng3/bSYwXegp/vRPERV6WW
    N2UdZ4XYk1E+BhIotIPaGrYtv8L2Opd/+Ttc5gC5Ox512GeCysRUUlxgQB1xdeUbdwptjY
    38v9Zpw6vN6bZejyxYXid7mVHX+5olELP34qcXCEF8CKKD0bzBaObzjt+HrC8+HSLNm1m3
    uZvpxCsPgSPkMYy0IhS3STz/I97G705F6JX1RvniTJqExS5rUyDz3bhuVQW1dftws8y3S6
    9y+AK9A6yZdEKNKSB6Rl866GSg3NpOR9SW4H80vbNf2fKy5DswssJPu3tVcuVfwJrmWMj8
    I6fLQmtHOwwRS1sAJlR6u6azXptLN88kPrS0fXM5WyvjGpRgv7yB724gyLFA
X-ME-Proxy: <xmx:wlKWas82N_8i-HCjQeBUQagI_HkEHnw3NJCC7MiTQmBksaUbo2_Shg>
    <xmx:wlKWagaJOsLbwE1TzzFHcr3GD3FCs7gYiMB7HMFMOaXrm_jBHNhNKw>
    <xmx:wlKWaue8BAAGg1fOUCixkVMsHyk4XlG8DoP6l3huua6KWc-mlXly6A>
    <xmx:wlKWalnQzRbMsxjH7kjHnOBmg4hX1QpeAh4IZIzEZV3HRsQNWFuQcQ>
    <xmx:w1KWalh8PIOhZkLnJf4e5jvhYvSIrc7djDCwTnajkbay6_lAPr8bLf6_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 00:21:21 -0400 (EDT)
Date: Tue, 1 Sep 2026 06:21:17 +0200
From: Greg KH <greg@kroah.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: stable@vger.kernel.org, Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 7.1.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Message-ID: <2026090154-upwind-radish-bd37@gregkh>
References: <2026082517-sitter-shriek-9502@gregkh>
 <20260825181727.887465-1-yanjun.zhu@linux.dev>
 <2026083114-framing-dried-c03c@gregkh>
 <05a2f047-90c6-4fc9-8a2e-641a7526f46b@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05a2f047-90c6-4fc9-8a2e-641a7526f46b@linux.dev>

On Mon, Aug 31, 2026 at 11:36:10AM -0700, Zhu Yanjun wrote:
> 
> 在 2026/8/31 4:32, Greg KH 写道:
> > On Tue, Aug 25, 2026 at 08:17:27PM +0200, Zhu Yanjun wrote:
> > > From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> > > 
> > > free_rd_atomic_resources() iterates using qp->attr.max_dest_rd_atomic.
> > > Updating max_dest_rd_atomic before freeing the old array can make the
> > > free path walk past the old allocation and trigger a slab out-of-bounds
> > > write catched by KASAN:
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resource drivers/infiniband/sw/rxe/rxe_qp.c:180 [inline]
> > > BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:171 [inline]
> > > BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:163 [inline]
> > > BUG: KASAN: slab-out-of-bounds in rxe_qp_from_attr+0x1e88/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:712
> > > Write of size 4 at addr ffff88802b8dddb8 by task syz.3.451/11063
> > > 
> > > CPU: 0 UID: 0 PID: 11063 Comm: syz.3.451 Not tainted 7.1.0 #2 PREEMPT(full)
> > > Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > Call Trace:
> > >   <TASK>
> > >   __dump_stack lib/dump_stack.c:94 [inline]
> > >   dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
> > >   print_address_description mm/kasan/report.c:378 [inline]
> > >   print_report+0xf7/0x600 mm/kasan/report.c:482
> > >   kasan_report+0xe4/0x120 mm/kasan/report.c:595
> > >   free_rd_atomic_resource drivers/infiniband/sw/rxe/rxe_qp.c:180 [inline]
> > >   free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:171 [inline]
> > >   free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:163 [inline]
> > >   rxe_qp_from_attr+0x1e88/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:712
> > >   rxe_modify_qp+0x1e2/0x530 drivers/infiniband/sw/rxe/rxe_verbs.c:623
> > >   ib_security_modify_qp+0x223/0xfa0 drivers/infiniband/core/security.c:625
> > >   _ib_modify_qp+0x333/0xec0 drivers/infiniband/core/verbs.c:1915
> > >   modify_qp+0x13ca/0x1940 drivers/infiniband/core/uverbs_cmd.c:1932
> > >   ib_uverbs_modify_qp+0xcb/0x120 drivers/infiniband/core/uverbs_cmd.c:1958
> > >   ib_uverbs_write+0xb86/0x1030 drivers/infiniband/core/uverbs_main.c:680
> > >   vfs_write+0x2aa/0x1070 fs/read_write.c:686
> > >   ksys_write+0x1f8/0x250 fs/read_write.c:740
> > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >   do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7fefc75a70cd
> > > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fefc8495018 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > > RAX: ffffffffffffffda RBX: 00007fefc7835fa0 RCX: 00007fefc75a70cd
> > > RDX: 0000000000000078 RSI: 0000200000000240 RDI: 0000000000000007
> > > RBP: 00007fefc764f10f R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007fefc7836038 R14: 00007fefc7835fa0 R15: 00007ffcf0586aa0
> > >   </TASK>
> > > 
> > > Allocated by task 11063:
> > >   kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
> > >   kasan_save_track+0x14/0x30 mm/kasan/common.c:78
> > >   poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> > >   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
> > >   kasan_kmalloc include/linux/kasan.h:263 [inline]
> > >   __do_kmalloc_node mm/slub.c:5296 [inline]
> > >   __kmalloc_noprof+0x32a/0x850 mm/slub.c:5308
> > >   kmalloc_noprof include/linux/slab.h:954 [inline]
> > >   kzalloc_noprof include/linux/slab.h:1188 [inline]
> > >   alloc_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:155 [inline]
> > >   rxe_qp_from_attr+0x3f8/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:714
> > >   rxe_modify_qp+0x1e2/0x530 drivers/infiniband/sw/rxe/rxe_verbs.c:623
> > >   ib_security_modify_qp+0x223/0xfa0 drivers/infiniband/core/security.c:625
> > >   _ib_modify_qp+0x333/0xec0 drivers/infiniband/core/verbs.c:1915
> > >   modify_qp+0x13ca/0x1940 drivers/infiniband/core/uverbs_cmd.c:1932
> > >   ib_uverbs_modify_qp+0xcb/0x120 drivers/infiniband/core/uverbs_cmd.c:1958
> > >   ib_uverbs_write+0xb86/0x1030 drivers/infiniband/core/uverbs_main.c:680
> > >   vfs_write+0x2aa/0x1070 fs/read_write.c:686
> > >   ksys_write+0x1f8/0x250 fs/read_write.c:740
> > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >   do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > The buggy address belongs to the object at ffff88802b8ddd80
> > >   which belongs to the cache kmalloc-64 of size 64
> > > The buggy address is located 0 bytes to the right of
> > >   allocated 56-byte region [ffff88802b8ddd80, ffff88802b8dddb8)
> > > 
> > > The buggy address belongs to the physical page:
> > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b8dd
> > > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > > page_type: f5(slab)
> > > raw: 00fff00000000000 ffff888015c418c0 dead000000000100 dead000000000122
> > > raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4651, tgid 4651 ((udev-worker)), ts 123427165316, free_ts 123425874255
> > >   set_page_owner include/linux/page_owner.h:32 [inline]
> > >   post_alloc_hook+0xfc/0x120 mm/page_alloc.c:1853
> > >   prep_new_page mm/page_alloc.c:1861 [inline]
> > >   get_page_from_freelist+0x75b/0x3220 mm/page_alloc.c:3941
> > >   __alloc_frozen_pages_noprof+0x27e/0x2b00 mm/page_alloc.c:5221
> > >   alloc_slab_page mm/slub.c:3278 [inline]
> > >   allocate_slab mm/slub.c:3467 [inline]
> > >   new_slab+0xa6/0x670 mm/slub.c:3525
> > >   refill_objects+0x278/0x420 mm/slub.c:7272
> > >   refill_sheaf mm/slub.c:2816 [inline]
> > >   __pcs_replace_empty_main+0x2ed/0x640 mm/slub.c:4652
> > >   alloc_from_pcs mm/slub.c:4750 [inline]
> > >   slab_alloc_node mm/slub.c:4884 [inline]
> > >   __do_kmalloc_node mm/slub.c:5295 [inline]
> > >   __kmalloc_noprof+0x68d/0x850 mm/slub.c:5308
> > >   kmalloc_noprof include/linux/slab.h:954 [inline]
> > >   kzalloc_noprof include/linux/slab.h:1188 [inline]
> > >   tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
> > >   tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
> > >   tomoyo_realpath_from_path+0x18c/0x690 security/tomoyo/realpath.c:283
> > >   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
> > >   tomoyo_check_open_permission+0x2ab/0x3c0 security/tomoyo/file.c:776
> > >   tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
> > >   security_file_open+0x7a/0x1b0 security/security.c:2739
> > >   do_dentry_open+0x57e/0x1690 fs/open.c:924
> > >   vfs_open+0x82/0x3f0 fs/open.c:1079
> > >   do_open fs/namei.c:4699 [inline]
> > >   path_openat+0x218a/0x3190 fs/namei.c:4858
> > > page last free pid 1 tgid 1 stack trace:
> > >   reset_page_owner include/linux/page_owner.h:25 [inline]
> > >   __free_pages_prepare mm/page_alloc.c:1397 [inline]
> > >   __free_frozen_pages+0x763/0xfc0 mm/page_alloc.c:2938
> > >   selinux_genfs_get_sid security/selinux/hooks.c:1364 [inline]
> > >   inode_doinit_with_dentry+0x903/0x1320 security/selinux/hooks.c:1563
> > >   selinux_d_instantiate+0x26/0x30 security/selinux/hooks.c:6658
> > >   security_d_instantiate+0x123/0x190 security/security.c:3704
> > >   d_splice_alias_ops+0x92/0x850 fs/dcache.c:3141
> > >   kernfs_iop_lookup+0x23f/0x2d0 fs/kernfs/dir.c:1289
> > >   lookup_open.isra.0+0x659/0x1080 fs/namei.c:4484
> > >   open_last_lookups fs/namei.c:4611 [inline]
> > >   path_openat+0x17dd/0x3190 fs/namei.c:4855
> > >   do_file_open+0x20c/0x430 fs/namei.c:4887
> > >   do_sys_openat2+0x101/0x1d0 fs/open.c:1364
> > >   do_sys_open fs/open.c:1370 [inline]
> > >   __do_sys_openat fs/open.c:1386 [inline]
> > >   __se_sys_openat fs/open.c:1381 [inline]
> > >   __x64_sys_openat+0x141/0x200 fs/open.c:1381
> > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >   do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > Memory state around the buggy address:
> > >   ffff88802b8ddc80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> > >   ffff88802b8ddd00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > > ffff88802b8ddd80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> > >                                          ^
> > >   ffff88802b8dde00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > >   ffff88802b8dde80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > > 
> > > Fix the OOB by moving the assignment after free_rd_atomic_resources()
> > > so the old array is freed using the old bound. This matches the original
> > > ordering in commit 8700e3e7c485 ("Soft RoCE driver").
> > > 
> > > Closes: https://lore.kernel.org/all/365C68B4923F8214+30195a67-0b90-4b92-ab96-2ce41517793c@smail.nju.edu.cn/
> > > Fixes: b6bbee0d2438 ("IB/rxe: Properly honor max IRD value for rd/atomic.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> > > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > (cherry picked from commit de329533792a373186d79dca1ca120f8fa0afd05)
> > Ok, that's the upstream commit, but:
> > 
> > > [This commit is based on the upstream commit 6f7014237405 ("RDMA/rxe: Fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp")]
> > What does that mean here?
> > 
> > Why isn't the original backported properly instead?
> The original patch cannot be cleanly backported to this older kernel version
> because it depends on the upstream commit `6f7014237405 ("RDMA/rxe: Fix
> responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp")`, which is not present
> in this branch.

Then provide that patch too.

> The corresponding upstream backport is based on that commit. Since the
> prerequisite change is missing here, the original patch does not apply
> cleanly. I therefore made a minimal adjustment to account for the
> differences in the older code base, while keeping the same fix and behavior
> as the upstream change.
> 
> So this is not intended to introduce a different fix, but to adapt the
> upstream change so that it can be cleanly backported to this kernel version.

Please just backport all of the needed patches.

thanks,

greg k-h
