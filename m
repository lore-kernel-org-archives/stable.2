Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CF3EB815
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791949430; cv=none; b=XsJjfOq5grgqrJAX7P2w7HGRuK/FCyncMUpQdktsyyhdpwsdghCKNSWgXH8iC56U06ZUDhPGcaq/NvvFw3mmLi/NAqSXtd/S/oZdkZdi4uFjZ/waquGpAWBTX4Ii7IE+kRX9rQntFOESpYm6fycgdWoot6BE4GqQz9m2IVQ2W1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791949430; c=relaxed/simple;
	bh=uAIPZvQ99EKhl4bzVyWX50RMipQcVv95QeJ6Gk6Fjr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MznHRwCv1YpWmdl6ngd91+kDO5x6RhF9Hie0SHbtusciWglaT1uAL+/jQYzIWkCaIdeh6pYpaNgEtXioykW44itAB2tpD+orW8kqJfAFtklIPOtTZlUKtGGq68bJMw5kZ9NqajEhWliPu4XOBtF+8mji3j/vf8FWCFDbtPzR4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajyxnyIQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajyxnyIQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e940d5d2beso283255ad.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791949427; x=1792554227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPZ6CMVllg1ExTGuLIWcOTSOQLgRxBXxWD+/IcCpGYk=;
        b=ajyxnyIQuUKkRnnZk+t9MpWRQs5UIkfyW3Y0u3A3BAqgvSWXMQZWJFr8D51Nodf5Cc
         VvRNaMpQ/wo5afNdjCN+NUoGwt/yJPPhi/YgaOTevbzMXENDPV5lh77GzuIiPpepoIvr
         ZUd8LM9Sq1rFDTYIl0zbDqquHeskklerY6sA7FCjCZ1337zPfEwsoSuzq4UM7iTA40mW
         N4tp31vG25/qQDIhM+j9aGMPdK2Pp+NqSXxvhSAQRUoEZQGU5A2/URiWWqRTz1tDwD6w
         W034RP0LiFM/HvroWET0z3v/JDWIEmd92RWBh0BAD+piDEyzQdpmVxJCpR+ESDkRHrFh
         adlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791949427; x=1792554227;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPZ6CMVllg1ExTGuLIWcOTSOQLgRxBXxWD+/IcCpGYk=;
        b=a0oMvINqq/7nuBIcaIrDMYn+wWAnXU8unmYVTFOSRFeaN1mt9iNT+pgh7SPm/acvXD
         afLZQkFC0vxcvc9W0FQnLWQJaDlfwtxxhvjPmsQYX4mfRifu37Bu0gEiBns1NX5MgO6e
         P0SwjUPt2W6aKV6KjbEbOOy2Xk7To9gUPfpf8rWKDMBRoLZJAvxMovV6wOzSvmg1atUw
         GXBkaOpCLefi8ArzFVBaCOgY6VrnhTAOmuhXu2TXqQjuRDzPzth8CGmKh2dhsH0y90K+
         064iyT4iqRbcn8AjuIW5RUPZt9FHhlK3KC27oAkMbrdEiZotE/K0bZ1j6GBRqR4KQ3gq
         hRRw==
X-Forwarded-Encrypted: i=1; AKwUvBztW9ty+clwp5T112xxU7sRT7c0N1UEMiGIrjQN2ZnnDoGZBS+W/baJlrUUIfK2AfaEXXlMbEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz6DdPTuDxLmoljOjSZ69ek3loTX7obIVkiqdDxFwWgkB3sXE2
	IK5QVDBDuPTB3n1hrLY5skj6tGyjn53kNbqRX3Rve56ZU1zibFMc1BJv
X-Gm-Gg: AYBFou0L+gTw2JJALMytmBvgQvGM920e77NouIb8vEZKiz8LzIHFTTSIQC8PUoqpGS7
	YeLB8xAwkFhywC3eYOKgaFXVudq+qEd9d2ZN1c0mY0DgLWTQQe3g8qO+4n/UEGNzkMQMmnpr9i4
	ABeykahKgMusEnr1JmZ0og/v5S0Y6836ZIQ22lZMmT0i1wbiV4DD+pX9PLI9WIYWa0NIHvDdqHp
	6iBtSaAMRRd3+zGunSh/Q355cAAbwJv/oGn0kLGvEZz9eYGLam0toub0fWmZq1Fjdz9TumeviaZ
	+5FhiL18GlU+JRVW4iut0PBbfrIKpEjKNAbYe4r/7S1M/BhYh5mfK/ZRczH8ybABoUmsetkpEMd
	NtHH/4kM/6EIpLaaqWwUr0o0fnKhVOn1OgOQwbqSV3jhiceWOlpPV/BPpQlw3Ozg4N7FfgBjyoK
	aJAa5+WNM2K2Fm5tpHVvSeRdRNtm89YHJiP7mpk4EE/UowNoG2FMxUW4LxLS16fb+e8g==
X-Received: by 2002:a17:902:cec2:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2e842bcda99mr120161875ad.35.1791949427055;
        Tue, 13 Oct 2026 20:43:47 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4ebfsm65092695ad.78.2026.10.13.20.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:43:46 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	chao@kernel.org,
	jack@suse.cz
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: Cancel quota sync work before freeing quota info
Date: Wed, 14 Oct 2026 11:43:40 +0800
Message-Id: <pm-ocfs2-objects-candidate-0052-v3-b4904bd6c85daf033adf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OCFS2 quota info owns dqi_sync_work and must outlive both its timer
and qsync_work_fn(). ocfs2_local_free_info() frees that owner without
cancelling the work, relying on the quota suspend/disable wrappers.

Loading quotas on a read-only to read-write remount can successfully
queue the work in ocfs2_global_read_info() and then fail while attaching
a dquot to an existing inode in add_dquot_ref(). The quota core unwinds
that failure directly through dquot_disable(), bypassing the OCFS2
wrapper:

  Remount task (s_umount write)        Timer/workqueue
  ocfs2_global_read_info()
    schedules dqi_sync_work
  add_dquot_ref() returns an error
  dquot_disable()
    ocfs2_local_free_info()
      frees oinfo
                                     delayed-work timer expires
                                     qsync_work_fn() reads oinfo

The timer core can then write to the freed embedded timer, or
qsync_work_fn() can read oinfo->dqi_gqinode before its s_umount trylock.
The outer ocfs2_disable_quotas() cleanup skips the failed type because
dquot_disable() has already cleared its loaded state.

Cancel dqi_sync_work synchronously at the start of
ocfs2_local_free_info(), before dropping the global inode or freeing any
owner state. The work is initialized whenever read_file_info() succeeds.
dquot_disable() holds s_umount for write, so the callback skips its quota
scan via down_read_trylock() and can finish without waiting for teardown.
The synchronous cancel also handles its self-rearm.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in __run_timers+0x9e9/0xa10
    Write of size 8 at addr ffff888111b0aad0 by task swapper/3/0

    Call Trace:
     <IRQ>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? __run_timers+0x9e9/0xa10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? __run_timers+0x9e9/0xa10
     kasan_report+0xe0/0x110
     ? __run_timers+0x9e9/0xa10
     __run_timers+0x9e9/0xa10
     ? __pfx___run_timers+0x10/0x10
     ? __lock_acquire+0x5a3/0x2140
     ? __pfx_do_raw_spin_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     timer_expire_remote+0xfa/0x160
     ? __pfx_timer_expire_remote+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     tmigr_handle_remote_up+0x4ba/0x9d0
     ? __pfx_tmigr_handle_remote_up+0x10/0x10
     ? tmigr_handle_remote+0x21a/0x340
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? __pfx_tmigr_handle_remote_up+0x10/0x10
     __walk_groups_from+0x5a/0x160
     tmigr_handle_remote+0x24f/0x340
     ? __pfx_tmigr_handle_remote+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     run_timer_softirq+0x222/0x270
     ? __pfx_run_timer_softirq+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xb8/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     handle_softirqs+0x1fa/0x8d0
     ? __pfx_handle_softirqs+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_spin_unlock+0x23/0x40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __hrtimer_rearm_deferred+0x1fb/0x5d0
     __irq_exit_rcu+0x113/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     </IRQ>
     <TASK>
     asm_sysvec_apic_timer_interrupt+0x1a/0x20
     ? ct_kernel_exit.constprop.0+0xc5/0xf0
     ? do_idle+0x3ae/0x650
     default_idle+0x9/0x10
     default_idle_call+0x6c/0xb0
     do_idle+0x3ae/0x650
     ? cpuhp_online_idle+0x9c/0xb0
     ? __pfx_do_idle+0x10/0x10
     ? __entry_text_end+0x1020f6/0x1020f9
     ? lockdep_hardirqs_on_prepare+0xeb/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     cpu_startup_entry+0x54/0x60
     start_secondary+0x223/0x2d0
     ? __pfx_start_secondary+0x10/0x10
     common_startup_64+0x13e/0x158
     </TASK>

    Allocated by task 523:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x28d/0x610
     ocfs2_local_read_info+0x181/0x1580
     dquot_load_quota_sb+0x69e/0x11c0
     dquot_load_quota_inode+0x227/0x3e0
     ocfs2_enable_quotas+0x27c/0x520
     ocfs2_reconfigure+0x964/0xd00
     reconfigure_super+0x3ca/0xa70
     path_mount+0x141e/0x1e80
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 523:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x308/0x580
     ocfs2_local_free_info+0x47b/0x800
     dquot_disable+0x5d9/0x17a0
     dquot_load_quota_sb+0xd3c/0x11c0
     dquot_load_quota_inode+0x227/0x3e0
     ocfs2_enable_quotas+0x27c/0x520
     ocfs2_reconfigure+0x964/0xd00
     reconfigure_super+0x3ca/0xa70
     path_mount+0x141e/0x1e80
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888111b0a800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 720 bytes inside of
     freed 1024-byte region [ffff888111b0a800, ffff888111b0ac00)

Host details, register and page dumps omitted.

Fixes: 1a6152d36dee ("quota: propagate error from __dquot_initialize")
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 76e7dd5aecc8..a2ce25a33607 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -840,6 +840,9 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	int mark_clean = 1, len;
 	int status = 0;
 
+	/* Quota-core error paths can bypass ocfs2_disable_quotas(). */
+	cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+
 	iput(oinfo->dqi_gqinode);
 	ocfs2_simple_drop_lockres(OCFS2_SB(sb), &oinfo->dqi_gqlock);
 	ocfs2_lock_res_free(&oinfo->dqi_gqlock);
