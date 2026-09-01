Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859722F5498;
	Tue,  1 Sep 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244462; cv=none; b=uSwhMSPpHIdxtjYa92n/XrJYb5yKqRiFwSJeznr74+NTVT+AI9TfMhu/jioqio3sXXl7O1QTNBBfnGhXnmw/xUoUruxZqvAZVo5eOaOnBbRclOzuRSTjj/xirfsjC0cOmdNWidK1nXI62CDMHFiq2YkrossSvFc5Re3k+Ycc4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244462; c=relaxed/simple;
	bh=Cm9Hjy6+mxCcf6JZoHOSjbpP3hs9mUNtWmMlwqjLLUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIHrReH0xxl/ReMyVYNjeprvB4K8dBcL/BvxoShsZ3dn9cNCeEi3Mze2z5CxZVtdjig2mxx5CtBF0BgeqXYJGC7alySmZtfYe2LtSwN25R6dQTwEaCk9MNTs6JPAC4ToCZL305SI+f0Nq9lWRG0dfpfBKhFrrwt0iI4O0xBkr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=08eeIomL; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="08eeIomL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1788244399;
	bh=UJHJeBdKVMDLiEWAAfXdHkcZi16T+NbvJSHuK0zRgQ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=08eeIomLJlC68W+hzlQqdGN6cWktKIxWitwqL2/jFaVDRniNKWBPpTPl8gXPS77iD
	 furoLQ5Bm/s23kbOu05vikuSuL1jXzLt5IEB4xL0Rfbz2850waG5fDVCsvQGaD6YWK
	 H7wlmzwaNfwKNRlIXMGCq/5Dj5OKcCNInGetkQ6g=
X-QQ-mid: esmtpsz11t1788244394t2b63edd9
X-QQ-Originating-IP: bUbLwYgJA56und4dsc4CWvLpPXFtZXw8CqxnLIPEJOM=
Received: from hepeiyang-vm.wu.lxd ( [36.152.24.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 14:33:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1832829884341944784
EX-QQ-RecipientCnt: 7
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/nouveau/uvmm: fix UAF in bind job cleanup
Date: Tue,  1 Sep 2026 14:32:55 +0800
Message-ID: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N3jdWkaw18IN69PFcz9rxQ/HrGPcG5hyalWhx4tDEKNHsIAiiOaO7VeK
	WdoYjq2iDFymOhuXI6TA+8tcwFaBwxnqF+jX7PXHmmu+OWAxXp3SPKaZhrSBXogvXRJfHIX
	aKUd6a5VXMFsVuU/LTFsSnKhJzIbSIkOo9JORuoasqqBji8jqfeu8PJPjKZKJRJso9xXUEP
	KCL6KnrrsvKOAUzpX+qT42Luh38TaRnlKaXDPcKley1lmkUJJVljEMWrUcJ1UkBJbsYyz+m
	wy+belR/Iu0Vqfxg+fIJnUYuWKeeeX3yEZqS9U2WZ0C4s+1z+/g8nYiU8SpGgsmT+0bRJsL
	Tmq1tr5zz/1/2lNRtLzs84ZosPrsgnW/eK9VtakeLpQskI/4eUJnhzvTx6R8NEpcKZW+U81
	pT4/4KjC3BFIVyd9F7/4Si1lW9XudXexoUEfDvE5f9jyHOT2Hida0n1X1vStRTQyhX4QBhb
	lCTBYWAbtn2zbfLulRfLbySh2rRBcdzvxQ5yqb/dCo+82DygsGlCf36DGX2eaO+j1CaAu67
	PgHMQ6x4UEVYjSEqPvRjCcsweWpGxdLsmBgRhduoyfFQWc8A9wS8KzQMfEf4SULCwtuYm8n
	HGDbPtVQJpn9UPFipGoIV9Nw7/X/BxloFyw24j36Vn1FfKmYEl1Eu/aDz0F+hwGanzmKjKj
	p32wRbUKcB5qk+HI6qJfi7nHX6dFcuuSNuIGxC7e1i3ObeIQyZM/kL69VPOJ5RHU15KRRvg
	xpf2g9BqN7/aUC8LXwmu5s4bXKtnT9U/4S042tV6BLQYIMQLr6JHujquHpgaCs8Pc/QYl+I
	ztNQGtmF5tSAvBDVFGzNbH+pNKnZ/TapJcrzIfpG1BK8ClyhjTqB8PEdG9dnDx1GPpwZt6N
	UxpOS4HSstMIJ+4zRk+VBcPqqlVTAEyDdibtEf4Ll3J+M/hV+I7Zra8U/GLZiLbUDZYTslP
	PYVbbnvU8STaDNsl6UTYo97Shh+eAfDl0kkJaBy/HfFSQjyMKi4KfOYEor7TbXs/lUJ/ZQQ
	W3vsvwVY4V8Jx4cp2IrfFrrcowzi42pWEjkPz1Uw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

OP_UNMAP_SPARSE stores the result of nouveau_uvma_region_find()
in op->reg before the bind job owns the region.

A first sparse unmap can look up the region, prepare its unmap
state and mark the region dirty. A second async sparse unmap of
the same range then sees the dirty region and fails out through
unwind_continue. However, op->reg is left pointing at the looked-up
region even though this job never took a reference and never became
responsible for cleaning it up.

nouveau_uvmm_bind_job_cleanup() later treats any non-NULL op->reg
as job-owned cleanup state. It can therefore tear down the region
that is still owned by the first unmap job, leading to a UAF when
the failed submit cleans itself up.

Fix by clearing op->reg on the unwind_continue paths so failed
submits do not carry a stale region pointer into cleanup.

Found when fuzzing the nouveau driver with a modified Syzkaller:

BUG: KASAN: slab-use-after-free in nouveau_uvma_region_sparse_unref drivers/gpu/drm/nouveau/nouveau_uvmm.c:174 [inline]
BUG: KASAN: slab-use-after-free in nouveau_uvmm_bind_job_cleanup+0x6e1/0x7e0 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1568
Read of size 8 at addr ffff888129b7c108 by task syz.2.125/2454

CPU: 1 UID: 0 PID: 2454 Comm: syz.2.125 Not tainted 7.2.0 #5 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5a0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 nouveau_uvma_region_sparse_unref drivers/gpu/drm/nouveau/nouveau_uvmm.c:174 [inline]
 nouveau_uvmm_bind_job_cleanup+0x6e1/0x7e0 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1568
 nouveau_uvmm_vm_bind drivers/gpu/drm/nouveau/nouveau_uvmm.c:1731 [inline]
 nouveau_uvmm_ioctl_vm_bind+0xadc/0xd20 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1817
 drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
 drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914
 nouveau_drm_ioctl+0xea/0x2c0 drivers/gpu/drm/nouveau/nouveau_drm.c:1338
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x180/0x1d0 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd3f9f8594d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd3f89e7008 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd3fa215fa0 RCX: 00007fd3f9f8594d
RDX: 0000200000000600 RSI: 00000000c0286451 RDI: 0000000000000004
RBP: 00007fd3fa02c22b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd3fa216038 R14: 00007fd3fa215fa0 R15: 00007ffef3a1fa40
 </TASK>

clocksource: Watchdog remote CPU 1 read timed out
Allocated by task 2457 on cpu 1 at 138.974794s:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x299/0x630 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nouveau_uvma_region_alloc drivers/gpu/drm/nouveau/nouveau_uvmm.c:249 [inline]
 nouveau_uvma_region_create drivers/gpu/drm/nouveau/nouveau_uvmm.c:341 [inline]
 nouveau_uvmm_bind_job_submit+0x1a4a/0x2820 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1310
 nouveau_job_submit+0x70c/0x1240 drivers/gpu/drm/nouveau/nouveau_sched.c:301
 nouveau_uvmm_vm_bind drivers/gpu/drm/nouveau/nouveau_uvmm.c:1724 [inline]
 nouveau_uvmm_ioctl_vm_bind+0x8d6/0xd20 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1817
 drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
 drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914
 nouveau_drm_ioctl+0xea/0x2c0 drivers/gpu/drm/nouveau/nouveau_drm.c:1338
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x180/0x1d0 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 125 on cpu 1 at 139.013117s:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x383/0x590 mm/slub.c:6692
 nouveau_uvma_region_free drivers/gpu/drm/nouveau/nouveau_uvmm.c:264 [inline]
 kref_put include/linux/kref.h:65 [inline]
 nouveau_uvma_region_put drivers/gpu/drm/nouveau/nouveau_uvmm.c:276 [inline]
 nouveau_uvmm_bind_job_cleanup+0x4df/0x7e0 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1573
 drm_sched_free_job_work+0x33b/0x5d0 drivers/gpu/drm/scheduler/sched_main.c:1013
 process_one_work+0x8a5/0x1900 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5dd/0xd80 kernel/workqueue.c:3486
 kthread+0x31d/0x420 kernel/kthread.c:436
 ret_from_fork+0x662/0x940 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888129b7c100
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 8 bytes inside of
 freed 128-byte region [ffff888129b7c100, ffff888129b7c180)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x129b7c
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100041a00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888129b7c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
 ffff888129b7c080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888129b7c100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888129b7c180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888129b7c200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.4
---
The first clearing of op->reg is enough to prevent the UAF,
but I also add a second clearing. Now all unwind_continue paths
in the OP_UNMAP_SPARSE case can properly clear op->reg.

 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..aad14316cbef 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1318,6 +1318,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			op->reg = nouveau_uvma_region_find(uvmm, op->va.addr,
 							   op->va.range);
 			if (!op->reg || op->reg->dirty) {
+				op->reg = NULL;
 				ret = -ENOENT;
 				goto unwind_continue;
 			}
@@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 

base-commit: 786262be6048deab760f68c8acc2c85607165894
-- 
2.43.0
