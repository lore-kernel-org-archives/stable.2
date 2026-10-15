Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276028B7C8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030964; cv=none; b=uAp5sUGMIpiNoZZPhzupIGqmapxiD7Kvp9qLUq6T70Gr8NwObp5IYyxv20Ac+U9Dg2AJSl/uiLpa8gZVjD68n4t2LFkUQ0Ec3Ay97xwvHzdY5h4v4JrRqr72EqBxZVabsqEdH6sZ/58AeFqSPAHL6Jbs/e018By6jHj/8XQILao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030964; c=relaxed/simple;
	bh=nKxf5sNbd1xCyLn2CFlTWenwxkEH9kgFLk8OoHjfWR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XE5flLdrZV+6a71n0Ujre9t97SMLaEns1zebm6ptEefMLTbxcDnM51COo89vIizhVorpofR+EsnENnWUynnkvpuUXNOX4rMSccYJjWOUtT2y9ihQbLe9qLlONGotlbh3cnuYMna5OPsu8e8AVkpH3ioTK91cqTP09IxJA7yyR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFJhzagz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFJhzagz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso576742a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792030962; x=1792635762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jLsAFvGouKNswLfy6C0ZCOuNuWMWwLBVKQhNgoltfw=;
        b=MFJhzagzhhhhX72J+r9nnybiTamikMQnJsYgsajU47x+YGjT0jcPdktA463eA0M4ZG
         mOnhv4QBKv0pxs/97Sfb4tjCx890fqrXwjEsPnjOXoQzLihjH/QbJ02zR0tZtMuiy1w3
         5H0GdLHzrBPhJFA0exiS5aproNKRgzQfC8j1M+GIhrP17uxj4mgPWojF7uvNifEcfNfF
         5RUCssxSgoeEiT4G+VzNb3ZB66KHNbyOXu1V9vj0iNH0y+EIq/4C6NYZg87w6ERcrpES
         mO0o0+peJ1xBlH806YOcyqxb0M4Su1sndAaGUtk/f+lBTAZarh8bS1+Rdh0z4AbjE/a/
         KmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030962; x=1792635762;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2jLsAFvGouKNswLfy6C0ZCOuNuWMWwLBVKQhNgoltfw=;
        b=DtSSSQ+ubMWcBLXhVov4sCgcnld/Y9/h5lXSC/++2bcAqraRRE9zdMpF5av4StRNTz
         9lU3eDUMTew0EXKjL/0gvDZg61YZK3vU4WcfWKOldF43vPYPj5mXJIt2hG+gLPxYCZ0G
         7fEjmwIixfk9QlD6yGSuJ1h3LhVNEb7zVtyPi7SeYvMHS906IF6jtblOw4s4W0CPtJmY
         9xaA5gA3AyEXxPlMGBajkRcNezPUvaa9WBMoQiK6V7GyONyOMH+kb5kiAyg/Hzye3lJe
         UPKlFQe9LNEmOH6Tn7eceWJANliHKM/4czkP2587fcVUIbqtsk/wCoauTR9xpibGmMaB
         o6AA==
X-Forwarded-Encrypted: i=1; AKwUvBztqm8jtRp7jYu3DOMvHWWmvJQXDE1/nDCpuEs9MP3YER40xGZ8IKTosDhK6HWNNeGhAB7a7bo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFMZ453OZf0D/TxZ3kG03tlmgjEmoBD7YvDn/cXvsJaJVytM2n
	YCMN2RKCY4/aXIOUfvqhgOnlS3LB5pdrvQyDivOVJVlqW4acBAOdXnn0
X-Gm-Gg: AYBFou2wmjarMRZ8VPliU0xUKOhGih3DDC1eB2tBHbciwDWO2Viouqk0pJeDNy5xVhf
	X63wfkccpuabMeQlR7IJM3qqs90jGiHPueBK5Bt00c/QY5j9d1Cu1kQplG3grL3ZQrTydojqFgP
	FMcWSRVGhI//+FlZSE7eD+L1hyad5o+JYkXGR954cNOA1NGtrp2maTTwm3l5uTJBWVmbYhe9f9j
	kTlV9PaGVjlODKFrnlJ/gc4nlJZ8JTJXvQ9dmdyObbKL3xZgCrLnVxx2uhTMnIUWk+udgbBuxgJ
	32sSbjAG3R13ozIzS9x/wL/RinqUDedQgG1eHKm7JNWPbnXGCS2b0RxMkrX78Vg/ccRgr/ewlTS
	8LgQnHkaPB9SoBLBO4khpiFtvvJWXeYnvZKJ+kUeo2sLL5xApQOd+J3GFIrmWT1oWF/NWA1Qh1s
	LshHYAS3Z9c47lH231n4yi2uv+mdOn5jhyVvIlzPXCfCrMh5QIofjysJyl7p+Mb8m+uQ==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3ab3a7a2437mr14922014a91.34.1792030962242;
        Wed, 14 Oct 2026 19:22:42 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9437a82esm2092296a91.1.2026.10.14.19.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:22:41 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	kurt.hackel@oracle.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ocfs2: dlmfs: Hold l_lock through the unlock wakeup
Date: Thu, 15 Oct 2026 10:22:35 +0800
Message-Id: <pm-ocfs2-objects-candidate-0055-v5-5a07cf78ed1c5bd13e50@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The user_lock_res embedded in a DLMFS inode must remain alive until the
final unlock AST finishes accessing it. user_unlock_ast() clears
USER_LOCK_BUSY under l_lock, but releases that lock before calling
wake_up() on the embedded l_event. user_dlm_destroy_lock() waits only
for BUSY to clear, so it can return before the callback's last access.

With the native userspace stack, fs/dlm dispatches the unlock AST
asynchronously. Unlinking an attached lock with no remaining local
holders can therefore reach the following order while the parent domain
stays mounted:

  Unlink and inode release          Native unlock AST
  ------------------------          -----------------
  submit final unlock
  prepare_to_wait_event(): enqueue
                                    clear BUSY under l_lock
                                    release l_lock
                                    delay before wake_up()
  test BUSY: already clear
  finish_wait(): remove waiter
  return from the destroy wait
  unlink and evict the child
  RCU callback frees the inode
                                    wake_up(&lockres->l_event)

The queued waiter can observe BUSY already cleared, leave the wait loop
and run finish_wait() without waiting for the AST's wake_up(). The
callback holds no inode reference, and keeping the parent domain alive
avoids disconnect draining the callback workqueue. The delayed wakeup
then accesses freed inode storage, causing a use-after-free in
waitqueue locking.

Keep l_lock held through wake_up(), as ocfs2_unlock_ast() already does.
user_check_wait_flag() takes the same lock, so teardown cannot observe
the cleared BUSY flag until the wakeup has finished. The callback and
its wrappers do not access the lock resource after this final unlock.
The waitqueue lock is released before wait_event() tests BUSY, so
extending the critical section does not invert their lock order.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3d/0x60
    Read of size 1 at addr ffff888117dc93c0 by task kworker/u17:0/871

    CPU: 2 UID: 0 PID: 871 Comm: kworker/u17:0 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: dlm_callback dlm_callback_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? _raw_spin_lock_irqsave+0x3d/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? _raw_spin_lock_irqsave+0x3d/0x60
     kasan_report+0xe0/0x110
     ? _raw_spin_lock_irqsave+0x3d/0x60
     ? _raw_spin_lock_irqsave+0x3d/0x60
     __kasan_check_byte+0x36/0x50
     lock_acquire+0x113/0x300
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? pmbd_probe_hit_cookie+0xee/0x1c0
     _raw_spin_lock_irqsave+0x3d/0x60
     ? __wake_up_common_lock+0x27/0xb0
     __wake_up_common_lock+0x27/0xb0
     user_unlock_ast+0x21a/0x490
     ? __pfx_user_unlock_ast+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? process_one_work+0x7c8/0x1b40
     fsdlm_lock_ast_wrapper+0xf2/0x130
     dlm_do_callback+0x2e9/0x6c0
     ? __pfx_fsdlm_lock_ast_wrapper+0x10/0x10
     process_one_work+0x9a8/0x1b40
     ? __pfx_process_one_work+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 492:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_slab_alloc+0x89/0x90
     kmem_cache_alloc_lru_noprof+0x205/0x5c0
     dlmfs_alloc_inode+0x2a/0x50
     alloc_inode+0x69/0x230
     new_inode+0x23/0x1a0
     dlmfs_get_inode+0x47/0x2d0
     dlmfs_create+0x18f/0x2f0
     lookup_open+0x88f/0x13e0
     path_openat+0x95e/0x2020
     do_file_open+0x21e/0x470
     do_sys_openat2+0xf4/0x1b0
     __x64_sys_openat+0x136/0x1e0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 0:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kmem_cache_free+0x242/0x580
     dlmfs_free_inode+0x25/0x60
     i_callback+0x4b/0x80
     rcu_core+0x6be/0x1ed0
     handle_softirqs+0x1fa/0x8d0
     __irq_exit_rcu+0x113/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    Last potentially related work creation:
     kasan_save_stack+0x33/0x60
     kasan_record_aux_stack+0xa7/0xc0
     __call_rcu_common.constprop.0+0x80/0x280
     destroy_inode+0x131/0x1b0
     evict+0x543/0x9f0
     iput+0x680/0xb80
     filename_unlinkat+0x36d/0x660
     __x64_sys_unlinkat+0xb0/0x110
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888117dc92c0
     which belongs to the cache dlmfs_inode_cache of size 1464
    The buggy address is located 256 bytes inside of
     freed 1464-byte region [ffff888117dc92c0, ffff888117dc9878)

[Physical-page and shadow-memory dumps omitted.]

Fixes: 8df08c89c668 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
Changes in v2:
- Clarify the queued-waiter interleaving through finish_wait() before the
  unlock AST wakeup.
- Correct Fixes to the original dlmfs introduction.
- Add Joseph Qi's Reviewed-by; keep the code change unchanged.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0055-v4-c1574edc9949e3a22edf@gmail.com

diff --git a/fs/ocfs2/dlmfs/userdlm.c b/fs/ocfs2/dlmfs/userdlm.c
index 617c92e7b925..60653db7b411 100644
--- a/fs/ocfs2/dlmfs/userdlm.c
+++ b/fs/ocfs2/dlmfs/userdlm.c
@@ -253,9 +253,9 @@ static void user_unlock_ast(struct ocfs2_dlm_lksb *lksb, int status)
 
 	lockres->l_flags &= ~USER_LOCK_BUSY;
 out_noclear:
-	spin_unlock(&lockres->l_lock);
-
+	/* Complete the wakeup before a BUSY waiter can free lockres. */
 	wake_up(&lockres->l_event);
+	spin_unlock(&lockres->l_lock);
 }
 
 /*
