Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DF3DDB0A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341774; cv=none; b=CctP9MKorP1FpryjqoPn2H5RX8idXZ95uh/ZkOQtBcW7ATnGF6KZieXC8zT4in13F1/i3zxpsLclRL4T/Qd7JGIzegITHnic+S7+wx+3r4ZkgFfS/Z3bcFCFdks8mlv4LbS758Lt7j/5Hhd4FPEgwwfl6Y4F049WkFwvQeZzFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341774; c=relaxed/simple;
	bh=KnQhcAqHVpND5zC5Lmi6ykzq0BR0wFTwAN5zSULi2Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ou7hjoTti8o2UfkeFkxDo47mzaOqh0a0Nz+ZKlk2em/JSBvkqBAniTdISS0BJuCKE0RP7dQAxgiI9EfiWezFa3j0Hjg3Wl4GFILBe6IsjisSa2/ENZ3D2bw3WFjg5VniW3i8H53Ry7oo3exjdqtTSyAvgiQyI++tjYYkddlWNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJq7sq+M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJq7sq+M"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0006ea8eso9956511cf.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341772; x=1787946572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlWjtpHXV+lHwlvQU3aEhp/u2CTx3UoLD62N2YTV+lU=;
        b=LJq7sq+MjE4rO19+8CjJ8QXUxYV7CXMSuR/7dkkh0Nn002uplZrH92hnVYFgq04mGH
         VPnYVOBN3w43pRM+u3yAtfAFDC+nLWOs9L+iP7bmxVZznNCKIZvdb1bIS8Rd3Yb4nu8Q
         iV0vYXxlkW2bhFwohMSU6c2znWpRUnz/xDhe0a+q/jfz2aJ1VprDXBzQt4IcR1nGCwJZ
         SfCvppjEQTylDBeZ/y4todcedUmpBdSFcZZXb4kkAN4SAHk6vltIEGfwQvUQInroRxTK
         O118mW9yDVcdEqITAo4dyatYlTm2IeXRFXv4yFT0pWnlTZvVXSCOxJf1+ZvG+KEbbVAB
         hByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341772; x=1787946572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlWjtpHXV+lHwlvQU3aEhp/u2CTx3UoLD62N2YTV+lU=;
        b=Hn4NZX/QdBG5C/tInus1gn1jXwV9iQqhgzqsB8XIt3DZTVkguvhn2V0sLtr+bPk1d+
         moQEkJZQwKfQeoLUKTwkDJBQW9KskGOXov3rf/zk9iaAfsf8swPRclYaxyZ/AVtb4PNO
         XNr7AJWx5+h12cMtrM8Eb1gGW7wWuKmbLp3RqBr+cVHt/LUyDm4A5JIlcNkxlxD/cz5y
         ttBaay88YzI7LlOau02IPQRSm2FPXaiQKStFT00kN04jCX2eHvZpbhU8kuaQg6bxXsHj
         mzGshDrrknTbR0L6H3VvMRu/Zhu9YAAUFIU9ytsdpovQTW4T+sRlgPAsr5lNYIroSSB8
         b7JQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFua0TGtGycaZKfar/rfFdqMHfPRtDKInEdkJRTpA2Ttgdp898qd14bhj7s1pjX1KFMWuM7/w=@vger.kernel.org
X-Gm-Message-State: AFuF++nhQZYwM7rGGpKX5ZIrmH3txa71uZPNTqQ697prhYOq6edypZve
	vS7wzw5g4e4TwR8vN65pvNxHhcVeuirLfAIWuyMfcHNhBRLHMExsQ5uU
X-Gm-Gg: AR+sD11cjfTQ92mfRBb+waCLtD4bQ5LhCITnz+d+6SMMWFdUh56tV20bkNM9hDDcGv3
	wN1rESu9awuPbMBnt2/bdRv0xY8sfSxanSEGBnxSFlTH/pj1xhj1WWAHtFCwNM5xOWHs7bkj63t
	ZdQjUbglgSHkChS2ZN9gYBx58z2n6rzWpQWHtmpuztEU3L7wlV1yPCR64J45Kro6TOwEIux72N9
	gQOEvVaRwFi85mGcq9+tIOiM2Gm31huQ7e9sQJ/zlXDIQjuPkWtotPx1YMUEHD7MWK+ffO+n+hV
	W2gxm4OQO6stMj8AJUiGFWb1A2/TRsWAA0dYXPrIUJhPngQo/QUppjoZ0yP0ogzLgU7q+i278mh
	so97+a0+NKj0/gJNs0Tg87D7lxIP78F0s+8a/IZ6YPuJhhXjqTlgvNmsKC6ixPCkE1Yq4q5mGow
	s8n3KX33sNkpjj72keC2H5qnz0Xqu+iU2hzu6UEA3XPX8EXA0odpZW6kM5s7qtivFp7DV4E/I0i
	gxlTA5pzaSCHbhHb3TpmKw=
X-Received: by 2002:ac8:5d45:0:b0:51c:404:af7a with SMTP id d75a77b69052e-52e09cd0959mr5394621cf.31.1787341771771;
        Fri, 21 Aug 2026 12:49:31 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099baf17sm1975801cf.12.2026.08.21.12.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 12:49:31 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [BUG] RDMA/siw: KASAN: slab-use-after-free in siw_accept
Date: Fri, 21 Aug 2026 15:46:21 -0400
Message-ID: <20260821194704.835548-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in siw_accept

on commit: bd5f485f3f026225b86573e559af0b7254ef4184 (2026-08-18)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/28addfcbf79470a62d5b4cd784e95cd2

The reproducer triggers a concurrent userspace QP transition to ERROR while
siw_accept() is unwinding after a QP initialization allocation failure. The
QP ERROR path drops qp->cep and frees the same struct siw_cep before
siw_accept() stores cep->qp = NULL.

This report is separate from the withdrawn follow-up patch:
https://lore.kernel.org/linux-rdma/20260816061353.4059242-1-shuangpeng.kernel@gmail.com/

That patch concerned a concurrent QP-destruction path. This report instead
involves a normal userspace ibv_modify_qp() transition to IBV_QPS_ERR on a
still-live QP.

We also reproduced this issue on a tree containing
a93949718259 ("RDMA/siw: Fix use-after-free in siw_accept()"). That commit
covers the qp->cep != cep case; this report exercises the distinct
qp->cep == cep race during a concurrent userspace ibv_modify_qp(...,
IBV_QPS_ERR).

The QP initialization failure was induced through the built-in fail_page_alloc
fault injector, restricted to the siw_qp_modify() call stack. The failing
vcalloc() path is a real -ENOMEM path.

The diagnostic patch shifts source line numbers in the decoded trace; in the
unmodified tree, the corresponding access is `siw_cm.c:1758` and the freeing
put is `siw_qp.c:663`.

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  409.854273] ==================================================================
[  409.856424] BUG: KASAN: slab-use-after-free in siw_accept (drivers/infiniband/sw/siw/siw_cm.c:1766)
[  409.858419] Write of size 8 at addr ffff888176620068 by task siw_accept_foll/8801

[  409.860281] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  409.860284] Call Trace:
[  409.860288]  <TASK>
[  409.860291]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  409.860298]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  409.860315]  kasan_report (mm/kasan/report.c:595)
[  409.860325]  siw_accept (drivers/infiniband/sw/siw/siw_cm.c:1766)
[  409.860382]  iw_cm_accept (drivers/infiniband/core/iwcm.c:670)
[  409.860388]  rdma_accept (drivers/infiniband/core/cma.c:4643 drivers/infiniband/core/cma.c:4727)
[  409.860484]  ucma_accept (drivers/infiniband/core/ucma.c:1208)
[  409.860504]  ucma_write (drivers/infiniband/core/ucma.c:1856)
[  409.860528]  vfs_write (fs/read_write.c:685)
[  409.860554]  ksys_write (fs/read_write.c:739)
[  409.860574]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  409.860579]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  409.860583] RIP: 0033:0x7f179cdf6fef
[  409.860588] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c fd ff ff 48
All code
========
   0:	89 54 24 18          	mov    %edx,0x18(%rsp)
   4:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   9:	89 7c 24 08          	mov    %edi,0x8(%rsp)
   d:	e8 29 fd ff ff       	call   0xfffffffffffffd3b
  12:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  17:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  1c:	41 89 c0             	mov    %eax,%r8d
  1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 31                	ja     0x63
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	e8 5c fd ff ff       	call   0xfffffffffffffd9b
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 31                	ja     0x39
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	e8 5c fd ff ff       	call   0xfffffffffffffd71
  15:	48                   	rex.W
[  409.860592] RSP: 002b:00007ffe992e7720 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[  409.860599] RAX: ffffffffffffffda RBX: 00007ffe992e79c0 RCX: 00007f179cdf6fef
[  409.860602] RDX: 0000000000000130 RSI: 00007ffe992e7800 RDI: 0000000000000003
[  409.860605] RBP: 000055f0d1977070 R08: 0000000000000000 R09: 00007f179ca7e700
[  409.860608] R10: fffffffffffffaa5 R11: 0000000000000293 R12: 0000000000000000
[  409.860610] R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffe992e7800
[  409.860615]  </TASK>

[  409.897413] Allocated by task 8115 on cpu 1 at 408.747286s:
[  409.897984]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  409.898409]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[  409.898822]  __kmalloc_cache_noprof (./include/linux/kasan.h:263 mm/slub.c:5489)
[  409.899305]  siw_cep_alloc (./include/linux/slab.h:988 ./include/linux/slab.h:1309 drivers/infiniband/sw/siw/siw_cm.c:210)
[  409.899712]  siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:982 drivers/infiniband/sw/siw/siw_cm.c:1077)
[  409.900176]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[  409.900666]  worker_thread (kernel/workqueue.c:3486)
[  409.901080]  kthread (kernel/kthread.c:436)
[  409.901451]  ret_from_fork (archkernel/process.c:158)
[  409.901865]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

[  409.902511] Freed by task 8817 on cpu 0 at 409.051801s:
[  409.903051]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  409.903477]  kasan_save_free_info (mm/kasan/generic.c:584)
[  409.903930]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  409.904366]  kfree (./include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6692)
[  409.904718]  siw_qp_modify (drivers/infiniband/sw/siw/siw_qp.c:669 drivers/infiniband/sw/siw/siw_qp.c:823)
[  409.905144]  siw_verbs_modify_qp (drivers/infiniband/sw/siw/siw_verbs.c:600)
[  409.905609]  ib_security_modify_qp (drivers/infiniband/core/security.c:625)
[  409.906082]  _ib_modify_qp (drivers/infiniband/core/verbs.c:1912)
[  409.906502]  modify_qp (drivers/infiniband/core/uverbs_cmd.c:1925)
[  409.906890]  ib_uverbs_modify_qp (drivers/infiniband/core/uverbs_cmd.c:1951)
[  409.907339]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE (drivers/infiniband/core/uverbs_std_types_device.c:44)
[  409.907989]  ib_uverbs_cmd_verbs (drivers/infiniband/core/uverbs_ioctl.c:387 drivers/infiniband/core/uverbs_ioctl.c:526)
[  409.908469]  ib_uverbs_ioctl (drivers/infiniband/core/uverbs_ioctl.c:555)
[  409.908898]  __se_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583)
[  409.909319]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  409.909729]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

[  409.910480] The buggy address belongs to the object at ffff888176620000
which belongs to the cache kmalloc-256 of size 256
[  409.911716] The buggy address is located 104 bytes inside of
freed 256-byte region [ffff888176620000, ffff888176620100)

Best,
Shuangpeng
