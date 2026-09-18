Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D13BFE33;
	Fri, 18 Sep 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700076; cv=none; b=Obmocx6mClQa+hRB3Q+fEIpPDBzDb89TcFkbUl6RCxaWezXnlN42cM/bg5FVI5xHNY4OuHUPb5ZRlMY4QqdCxiiQwYwsRtNf0ClJQ1/WdsG9BskagCNpujPOd/djYb+4a+VG00Y8N8KVrKU5K2IMcMqxcCvOSsjDjQ3wSuOdGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700076; c=relaxed/simple;
	bh=9QxRyDdG8aZRlEDR8VSb3fn44o1LRBGrhLBxQ0Jbwgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7HdJMOFs7Ld2Qw/sbQtFD5LJP362xMV19xPGmj0nEgivl0hcLVxxDJkYivApuO359ZnT+hDy8saE4tqW4T8a0lNTASFGHPvnPzYkANr/PHHy0p1raoJgwL9qa/pfbnvGR14xc+hwaD4UN93UGgvJ60CrT21vbqmJQnE6QAfR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=o74alXKo; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="o74alXKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789700025;
	bh=nvNhm30bTkmpK3DlDj1rjF67y0Iph2DAMagdKkZjH7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=o74alXKoJqH9H+cVUyE6hodMGIIczClWt7Z9AiDMlkzbmlCHJjNi+Xbb+VvvLwe2M
	 21kuUIu5kOM16JdMsrLx60iSudvhWvFohkil2K/zGPzL/z4kp4KMtfLt6190AigbLc
	 9mSg4zXuRsJCg6DjPBlI7H2W/P/5x271t4IKwe/w=
X-QQ-mid: zesmtpsz7t1789700020t017278c2
X-QQ-Originating-IP: SEBRYKhRUBS3UfK9etoK6JS/aqRVVuu1ncdaA015qI0=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 10:53:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15087163559953025601
EX-QQ-RecipientCnt: 7
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: lyude@redhat.com,
	dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH v2] drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()
Date: Fri, 18 Sep 2026 10:53:12 +0800
Message-ID: <EACEF2F4E098413F+20260918025312.2814889-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NgaJKxROpQTjQ/vxQilMFXJhaxbLfLcdJkTqcNpOCBsOkeHlcnT2Z4uD
	/q9OrKzhFLE34/PIAlpb/TUQdvrieOQbPHze+SvvhtPeOOGCmG06LnXzTabZJNNCLcgJWNm
	anjlQn75a/PKde8M2eVqJqHHOceDycJZRC6hUJusx4nYY+LP0dXqdGDyyziXWJSOvnfArAb
	nYMq84WS/MExcFRbljnUfEK7Qq3sOKkkoaGfEIThz6I+VXr5/lkeU4fyiwTVAGuc1NzRAfC
	lW2yc2J3RBR+SKiptwR2nWkEqdAg/rH2Wh2pgnNS2vfYJlpCs2g0OcEI0AKkcYoGx/3mELX
	ed4wldfwLlV7178bRamJS8JlA+9BD+HUPPRXRhMO8HhxkxFYzU/19poktQBVdNAiblhSd9G
	mj/OeCdbb052Dyner60lDvdQQ28nYJy/YdnCBJjkDAdMML9MJM/9yIpEl7J2I2EuPZIv5QR
	tV+D57agjMGtm1XignSBtRSTlHxhA02hlPN0fF69BFySCJwNh1tMzk3IHuF8LLLcNvK4k47
	hXzyrpHXC+DI0kpzuGmWzUV0fSNyNpyuVcb2j9noxA6SoOvC4d+7nlskuf3d09Pv8sl5/30
	MP693Dopb0iVIYZ5evCwGrWV28e7m3maTcmC1p87KJk8sL/66wgBpUAWRhCR/6xQmfeOno0
	huEwINUbClP19DOK7qd/lRT81vatz2vFz5haR9oqeM1OS6dqa9glttlpHtZdGm6JFn0XzLx
	xLbTt9c84+z1M4voVQJ4jTdb5rWEcJsmV3ieHZIroT2QmjQVV2PCqKXxnidr4RfwGHvMYO4
	VjdkXK90TuaBQObfEkaK8NGG3qOvq0GBsoQxqPdnUqh1I3jKIxYT35PTzuTtZx+5KN9wd9/
	Gp1Ae6Oz3aU/r5bSFrZnpLJ+MY/ntA0WfIsiQnoUumbYSBFSvjDY/634zutzWKI7dLJ5sWq
	gWnqgiphl0STcF1lJaP8sSgt58HVykSHklGsBMqWrLb6scrjgKtBvGsg+xVSE46sxc9LYMy
	/n1LenTwhVWLXdZhcAU1WM4Txe+zLK6IiRjLvhPJoiBgSBj+uxtJRKi+3lRxYZPkqjp5PTj
	Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

nouveau_bo_pin_locked() checks whether an already pinned BO is in a
memory domain compatible with a new pin request. When the domains are
incompatible, it sets -EBUSY but still calls ttm_bo_pin() before
returning.

Callers treat a failed nouveau_bo_pin() as not having acquired a new pin,
so the extra pin count is never decreased by a matching unpin.
This triggers the warning in ttm_bo_release():

	WARN_ON_ONCE(bo->pin_count);

Found when fuzzing the nouveau driver with a modified Syzkaller:

	WARNING: drivers/gpu/drm/ttm/ttm_bo.c:256 at ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256, CPU#1: syz.3.24/2212
	Modules linked in:
	CPU: 1 UID: 0 PID: 2212 Comm: syz.3.24 Not tainted 7.2.0 #24 PREEMPT(lazy)
	nouveau 0000:01:00.0: gsp:msg fn:103 len:0x40/0x20 res:0x19 resp:0x19
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
	RIP: 0010:ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256
	Code: 02 00 0f 85 51 01 00 00 48 8b 7b 08 e8 d2 20 01 00 e9 80 fd ff ff e8 d8 15 c0 fe 90 0f 0b 90 e9 e1 f8 ff ff e8 ca 15 c0 fe 90 <0f> 0b 90 e9 a4 f8 ff ff e8 bc 15 c0 fe be 03 00 00 00 4c 89 e7 e8
	msg: 00000000: 05 00 d0 c1 04 00 f0 f1 01 30 00 00 2d 90 00 00  .........0..-...
	RSP: 0018:ffffc9000f5cf710 EFLAGS: 00010293
	RAX: 0000000000000000 RBX: ffff888018e5d2a8 RCX: ffffffff82bb1b36
	RDX: ffff888017b68000 RSI: 0000000000000004 RDI: ffff888018e5d2a8
	msg: 00000010: 19 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	RBP: ffff88801261c720 R08: 0000000000000001 R09: ffffed10031cba55
	R10: ffff888018e5d2ab R11: 00000000000000f3 R12: ffff888018e5d290
	R13: ffff888018e5d2d4 R14: ffff88801b219c18 R15: dffffc0000000000
	FS:  0000000000000000(0000) GS:ffff8880e0f6f000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 0000001b31223ffc CR3: 0000000028e00005 CR4: 0000000000770ef0
	PKRU: 80000000
	Call Trace:
	<TASK>
	kref_put include/linux/kref.h:65 [inline]
	ttm_bo_put drivers/gpu/drm/ttm/ttm_bo.c:325 [inline]
	ttm_bo_fini+0x55/0x80 drivers/gpu/drm/ttm/ttm_bo.c:330
	nouveau_gem_object_del+0xb2/0x1b0 drivers/gpu/drm/nouveau/nouveau_gem.c:90
	drm_gem_object_free+0x5f/0x90 drivers/gpu/drm/drm_gem.c:1165
	kref_put include/linux/kref.h:65 [inline]
	__drm_gem_object_put include/drm/drm_gem.h:562 [inline]
	drm_gem_object_put include/drm/drm_gem.h:575 [inline]
	nouveau_abi16_chan_fini.constprop.0+0x44f/0x5a0 drivers/gpu/drm/nouveau/nouveau_abi16.c:195
	nouveau 0000:01:00.0: syz.2.23[2209]: Unknown handle 0x00000000
	nouveau_abi16_fini+0x1d0/0x340 drivers/gpu/drm/nouveau/nouveau_abi16.c:225
	nouveau_drm_postclose+0x18b/0x3e0 drivers/gpu/drm/nouveau/nouveau_drm.c:1284
	nouveau 0000:01:00.0: syz.2.23[2209]: validate_init
	drm_file_free.part.0+0x6d6/0xb60 drivers/gpu/drm/drm_file.c:267
	drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
	drm_close_helper.isra.0+0x11a/0x160 drivers/gpu/drm/drm_file.c:290
	drm_release+0x1ab/0x330 drivers/gpu/drm/drm_file.c:438
	__fput+0x39c/0xa60 fs/file_table.c:512
	nouveau 0000:01:00.0: syz.2.23[2209]: validate: -2
	task_work_run+0x15a/0x230 kernel/task_work.c:233
	exit_task_work include/linux/task_work.h:40 [inline]
	do_exit+0x82b/0x25a0 kernel/exit.c:1009
	do_group_exit+0xc2/0x280 kernel/exit.c:1152
	get_signal+0x1d6e/0x1f30 kernel/signal.c:3046
	arch_do_signal_or_restart+0x7d/0x6e0 arch/x86/kernel/signal.c:337
	__exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
	exit_to_user_mode_loop+0xdf/0x440 kernel/entry/common.c:101
	__exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
	syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
	syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
	do_syscall_64+0x4f8/0x690 arch/x86/entry/syscall_64.c:100
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7f12bac8594d
	Code: Unable to access opcode bytes at 0x7f12bac85923.
	RSP: 002b:00007f12b96e70d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
	RAX: 0000000000000001 RBX: 00007f12baf15fa8 RCX: 00007f12bac8594d
	RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f12baf15fac
	RBP: 00007f12baf15fa0 R08: 00007f12baee8000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
	R13: 00007f12baf16038 R14: 0000000000000006 R15: 00007ffe2ed394b0
	</TASK>
	irq event stamp: 47867
	hardirqs last  enabled at (47883): [<ffffffff815cafc6>] __up_console_sem+0x66/0x70 kernel/printk/printk.c:347
	hardirqs last disabled at (47892): [<ffffffff815cafab>] __up_console_sem+0x4b/0x70 kernel/printk/printk.c:345
	softirqs last  enabled at (47880): [<ffffffff81434277>] __do_softirq kernel/softirq.c:656 [inline]
	softirqs last  enabled at (47880): [<ffffffff81434277>] invoke_softirq kernel/softirq.c:496 [inline]
	softirqs last  enabled at (47880): [<ffffffff81434277>] __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
	softirqs last disabled at (47875): [<ffffffff81434277>] __do_softirq kernel/softirq.c:656 [inline]
	softirqs last disabled at (47875): [<ffffffff81434277>] invoke_softirq kernel/softirq.c:496 [inline]
	softirqs last disabled at (47875): [<ffffffff81434277>] __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735

Fix by calling ttm_bo_pin() only when the existing placement is compatible
with the new pin request. This matches the correct behavior in other DRM
drivers such as amdgpu_bo_pin() in amdgpu.

Cc: stable@vger.kernel.org
Fixes: ad76b3f7c7a0 ("drm/nouveau: teach nouveau_bo_pin() how to force a contig vram allocation")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: LLM
---
Changes in v2:
  - replace goto with else branch (suggested by Lyude Paul)
  - fix Assisted-by tag

 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0e8de6d4b36f..6dcb92575eb4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -578,8 +578,9 @@ int nouveau_bo_pin_locked(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 				      "0x%08x vs 0x%08x\n", bo,
 				 bo->resource->mem_type, domain);
 			ret = -EBUSY;
+		} else {
+			ttm_bo_pin(&nvbo->bo);
 		}
-		ttm_bo_pin(&nvbo->bo);
 		goto out;
 	}
 

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.43.0
