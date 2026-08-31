Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E403C1F57
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175985; cv=none; b=SI+01xaJXV0kAEfCMyeRPrmUtosC6YnLU8ErjWkAFFqTzJEZ8kVzanKzH9rMfl8EpG4dxeWCfIiNsnYFIqNW4uYwk4yjQoNV9PVFugFyjoDK3FuGQ9dJUfNueKPZmH4HogP4Zv363rMDtczN/N8ucmN9l/vMoLYVV+ahAkfe46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175985; c=relaxed/simple;
	bh=ascRG5pgZW5X6OzJL9JLsIzANbi9ZIYVvg93XFQr0YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY3oucM85rCPANli/cqKIaTjHhwcW8wUHNObK8E3HlpGhFDDCj+mwMHyDMdtCv74ZLMWvGBDJGs5fWFHiO6JEyZe8XsE0q7mMgFwU6YSfVUgrekDRn5ClkZzJEraWS+iqe5dhPU+/BDryqqm1pjNbMlg7Ga6+0YKHs/GolVMtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=U84S5nyj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKdIRX6u; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="U84S5nyj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKdIRX6u"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E4EB41D0013D;
	Mon, 31 Aug 2026 07:33:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 07:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788175981; x=1788262381; bh=VqTxGxWMRu
	v6iB2zhIKsmb7ISX/2UjY2TKjZPES3o6g=; b=U84S5nyjynz6bReEIpCcXg7g0E
	IeEetnhQk0vVoEptXvh38DXLm7S+t+JlGRaIFFIq/hHm14czaEFh4ZXn26D0mLkl
	G5SV9Sb4wQfvhRuyyE5/SIRGNkJT2rYLE4WIYpAJk990hza4OvAnbxCdLCI1Gnft
	tvVZv9k5iIw9oe5yTkgb/UYkRq7J+hL2zc/v5+N+3LbI0wVVENKXhhlvYoTp4R4K
	wihLIFJ7j/QHztfn46Mxuk51p1vFdPei9Djj+pYlIRPeweP8aA4CjcelyGpIDMX1
	wGBmmqYHQZn3qrMqvivoOz5wYBR7ayb7wZUb3y9GgCd8x/C/joiULD6K+ozQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788175981; x=1788262381; bh=VqTxGxWMRuv6iB2zhIKsmb7ISX/2UjY2TKj
	ZPES3o6g=; b=VKdIRX6uvUicWIM/5KQLHXki3njnLsKJT+rrBZUS5lwiktpt72N
	rBMvVLajlnnU2fmSq4zL2R+uLHSAN7/uCiBjdtYtRRH2af9FyVecOmmNVLG5ccvg
	B+z1WHMe9zSuEd1u3Dga28EPQa/6N/Kbs4Q++MdTAwChmXleGx+HvBBCMT6/w3GD
	u6+SRBDVSt60Dlmt6X7Nr2F6M5JsI7/M6Vn/jRm/0NtStY2jOisHjGRk8iH4YJWj
	Fwi3PwoW/83y2tUIHGGBChP4U5WlE//K9/Pv9LGJ9PiqUk5WU4VfBj5NbfdjXTnN
	vYI2Iag9dWA3ODyx6Wgl7ew4x3nj0gjSC5w==
X-ME-Sender: <xms:bGaVaqhWW_lkOEkRZFjD_jG5GxsyhEqx9n7MdQLkC6sYQQpGH-M40A>
    <xme:bGaVareLQOAQC-WEwkBlsUV8ymwzu8qpe2MOKCav2RitzuDx_l3jpuzfAuDf8bHL-
    836h34EvOsCh823H1dVmvWZoWJvy6KCED88t-JSMFti4R-YUw>
X-ME-Received: <xmr:bGaVaizjvMC7Ar1LPqRDqrJ8ZB9JTvmfq33ihheG7wG-xlbT2WbWyTnyITMV3XRTHfyGDQZGKqr50CIUEf9h2YKZ2aIEMzPvOH2CErhY7hY>
X-ME-Proxy-Cause: dmFkZTGnVr3sdLm1HSHto00NkwYUZdWmlHZPkUQ8KexjbSkYaDJA+/CLVJU3WytnXfIxe2
    KGJkA/doBVmcJ2XfM7i7hw6ronr3xEZJ4D0ejq5JA8Yn2ZAS7SRG+VDrhGk1rbbYhmYV6M
    xuRGwJiKTLP4GVtkaF89tQ4GNhi86HFAOUhthiQmiYcYi8SwHcwHoPwOCkDgH+NDadDmMD
    ZXcWgh6BLzS1Gt/m30Y1BYJMQWXMOPToGPzzQ/ZKCZ60z3651mKv4q/j5lId5ZrqgJz5JG
    +x1rkm0A2tor1RDollnh0Huor4S3haR5dRp5TbDZtA+LWgfiIsnEyuPt4B99tbgpQmSYPS
    PeTVhgFDCkmd9Slg5D3M8CbiTJVw+GwIYx+nQlai74G1TmsSPOlYK8YgJu0vXxBexwzkyA
    oVzuvrMTOCiJaLQzQ6fNmH3k3bPLglIV6X3QbgKIn1VXeCKKHQodXbXcMXnXxLn1T9fM76
    oJ/tZDbPwTer4z310QrxF3UluPF3M68xYHNkErgg9/vGupssVA6APANovejO+Rqc2xvXLG
    T/wkYKl2GC1dG4ltpJmERpkQuSrNy8IU44aRrnZNF8lBbJnkwBAIOPRXJvBBc8VYv2rJPs
    AzbG/C1WWTtmnVYQoD8YUL7NWqfhoBpkLpVdBnHhc5v1Yg9BbrdCeKZ8sF9w
X-ME-Proxy: <xmx:bGaVaq0o4tACS2qbEhGKL9jy2wbHT6rKJ-_LcXmfWIJjNzdrQw17xQ>
    <xmx:bGaVaoz4-Bl8cAgzRLGylDETst3bgc4y7SHrJ1nF0ja9noNcV5O1jg>
    <xmx:bGaVavWc1HcPW4w_Yqox8k5HgH88s3W1ULTToc5tDjUm6kX_jUN5IQ>
    <xmx:bGaVak_KhI5W2gOHLlNJcsqPpQxI0N2Xa6IDWk2AxPLXmLf7QMQQow>
    <xmx:bWaVah6PgySYGW34lGjzeiM-9muoRDN-YR7YS2lJCke7NQj8flQL86qO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 07:33:00 -0400 (EDT)
Date: Mon, 31 Aug 2026 13:32:57 +0200
From: Greg KH <greg@kroah.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: stable@vger.kernel.org, Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 7.1.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Message-ID: <2026083114-framing-dried-c03c@gregkh>
References: <2026082517-sitter-shriek-9502@gregkh>
 <20260825181727.887465-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825181727.887465-1-yanjun.zhu@linux.dev>

On Tue, Aug 25, 2026 at 08:17:27PM +0200, Zhu Yanjun wrote:
> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> 
> free_rd_atomic_resources() iterates using qp->attr.max_dest_rd_atomic.
> Updating max_dest_rd_atomic before freeing the old array can make the
> free path walk past the old allocation and trigger a slab out-of-bounds
> write catched by KASAN:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resource drivers/infiniband/sw/rxe/rxe_qp.c:180 [inline]
> BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:171 [inline]
> BUG: KASAN: slab-out-of-bounds in free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:163 [inline]
> BUG: KASAN: slab-out-of-bounds in rxe_qp_from_attr+0x1e88/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:712
> Write of size 4 at addr ffff88802b8dddb8 by task syz.3.451/11063
> 
> CPU: 0 UID: 0 PID: 11063 Comm: syz.3.451 Not tainted 7.1.0 #2 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xf7/0x600 mm/kasan/report.c:482
>  kasan_report+0xe4/0x120 mm/kasan/report.c:595
>  free_rd_atomic_resource drivers/infiniband/sw/rxe/rxe_qp.c:180 [inline]
>  free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:171 [inline]
>  free_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:163 [inline]
>  rxe_qp_from_attr+0x1e88/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:712
>  rxe_modify_qp+0x1e2/0x530 drivers/infiniband/sw/rxe/rxe_verbs.c:623
>  ib_security_modify_qp+0x223/0xfa0 drivers/infiniband/core/security.c:625
>  _ib_modify_qp+0x333/0xec0 drivers/infiniband/core/verbs.c:1915
>  modify_qp+0x13ca/0x1940 drivers/infiniband/core/uverbs_cmd.c:1932
>  ib_uverbs_modify_qp+0xcb/0x120 drivers/infiniband/core/uverbs_cmd.c:1958
>  ib_uverbs_write+0xb86/0x1030 drivers/infiniband/core/uverbs_main.c:680
>  vfs_write+0x2aa/0x1070 fs/read_write.c:686
>  ksys_write+0x1f8/0x250 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fefc75a70cd
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fefc8495018 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fefc7835fa0 RCX: 00007fefc75a70cd
> RDX: 0000000000000078 RSI: 0000200000000240 RDI: 0000000000000007
> RBP: 00007fefc764f10f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fefc7836038 R14: 00007fefc7835fa0 R15: 00007ffcf0586aa0
>  </TASK>
> 
> Allocated by task 11063:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5296 [inline]
>  __kmalloc_noprof+0x32a/0x850 mm/slub.c:5308
>  kmalloc_noprof include/linux/slab.h:954 [inline]
>  kzalloc_noprof include/linux/slab.h:1188 [inline]
>  alloc_rd_atomic_resources drivers/infiniband/sw/rxe/rxe_qp.c:155 [inline]
>  rxe_qp_from_attr+0x3f8/0x2150 drivers/infiniband/sw/rxe/rxe_qp.c:714
>  rxe_modify_qp+0x1e2/0x530 drivers/infiniband/sw/rxe/rxe_verbs.c:623
>  ib_security_modify_qp+0x223/0xfa0 drivers/infiniband/core/security.c:625
>  _ib_modify_qp+0x333/0xec0 drivers/infiniband/core/verbs.c:1915
>  modify_qp+0x13ca/0x1940 drivers/infiniband/core/uverbs_cmd.c:1932
>  ib_uverbs_modify_qp+0xcb/0x120 drivers/infiniband/core/uverbs_cmd.c:1958
>  ib_uverbs_write+0xb86/0x1030 drivers/infiniband/core/uverbs_main.c:680
>  vfs_write+0x2aa/0x1070 fs/read_write.c:686
>  ksys_write+0x1f8/0x250 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88802b8ddd80
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 0 bytes to the right of
>  allocated 56-byte region [ffff88802b8ddd80, ffff88802b8dddb8)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b8dd
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff888015c418c0 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4651, tgid 4651 ((udev-worker)), ts 123427165316, free_ts 123425874255
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0xfc/0x120 mm/page_alloc.c:1853
>  prep_new_page mm/page_alloc.c:1861 [inline]
>  get_page_from_freelist+0x75b/0x3220 mm/page_alloc.c:3941
>  __alloc_frozen_pages_noprof+0x27e/0x2b00 mm/page_alloc.c:5221
>  alloc_slab_page mm/slub.c:3278 [inline]
>  allocate_slab mm/slub.c:3467 [inline]
>  new_slab+0xa6/0x670 mm/slub.c:3525
>  refill_objects+0x278/0x420 mm/slub.c:7272
>  refill_sheaf mm/slub.c:2816 [inline]
>  __pcs_replace_empty_main+0x2ed/0x640 mm/slub.c:4652
>  alloc_from_pcs mm/slub.c:4750 [inline]
>  slab_alloc_node mm/slub.c:4884 [inline]
>  __do_kmalloc_node mm/slub.c:5295 [inline]
>  __kmalloc_noprof+0x68d/0x850 mm/slub.c:5308
>  kmalloc_noprof include/linux/slab.h:954 [inline]
>  kzalloc_noprof include/linux/slab.h:1188 [inline]
>  tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
>  tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
>  tomoyo_realpath_from_path+0x18c/0x690 security/tomoyo/realpath.c:283
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_check_open_permission+0x2ab/0x3c0 security/tomoyo/file.c:776
>  tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
>  security_file_open+0x7a/0x1b0 security/security.c:2739
>  do_dentry_open+0x57e/0x1690 fs/open.c:924
>  vfs_open+0x82/0x3f0 fs/open.c:1079
>  do_open fs/namei.c:4699 [inline]
>  path_openat+0x218a/0x3190 fs/namei.c:4858
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  __free_pages_prepare mm/page_alloc.c:1397 [inline]
>  __free_frozen_pages+0x763/0xfc0 mm/page_alloc.c:2938
>  selinux_genfs_get_sid security/selinux/hooks.c:1364 [inline]
>  inode_doinit_with_dentry+0x903/0x1320 security/selinux/hooks.c:1563
>  selinux_d_instantiate+0x26/0x30 security/selinux/hooks.c:6658
>  security_d_instantiate+0x123/0x190 security/security.c:3704
>  d_splice_alias_ops+0x92/0x850 fs/dcache.c:3141
>  kernfs_iop_lookup+0x23f/0x2d0 fs/kernfs/dir.c:1289
>  lookup_open.isra.0+0x659/0x1080 fs/namei.c:4484
>  open_last_lookups fs/namei.c:4611 [inline]
>  path_openat+0x17dd/0x3190 fs/namei.c:4855
>  do_file_open+0x20c/0x430 fs/namei.c:4887
>  do_sys_openat2+0x101/0x1d0 fs/open.c:1364
>  do_sys_open fs/open.c:1370 [inline]
>  __do_sys_openat fs/open.c:1386 [inline]
>  __se_sys_openat fs/open.c:1381 [inline]
>  __x64_sys_openat+0x141/0x200 fs/open.c:1381
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>  ffff88802b8ddc80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>  ffff88802b8ddd00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >ffff88802b8ddd80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>                                         ^
>  ffff88802b8dde00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802b8dde80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> 
> Fix the OOB by moving the assignment after free_rd_atomic_resources()
> so the old array is freed using the old bound. This matches the original
> ordering in commit 8700e3e7c485 ("Soft RoCE driver").
> 
> Closes: https://lore.kernel.org/all/365C68B4923F8214+30195a67-0b90-4b92-ab96-2ce41517793c@smail.nju.edu.cn/
> Fixes: b6bbee0d2438 ("IB/rxe: Properly honor max IRD value for rd/atomic.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> (cherry picked from commit de329533792a373186d79dca1ca120f8fa0afd05)

Ok, that's the upstream commit, but:

> [This commit is based on the upstream commit 6f7014237405 ("RDMA/rxe: Fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp")]

What does that mean here?

Why isn't the original backported properly instead?

thanks,

greg k-h
