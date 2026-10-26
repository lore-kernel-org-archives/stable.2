Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026919;
	b=r7+QZ2lLrWm5wDRT9CO5RJE96AB+og0thVukwGeGC2q6PSCIEoVl1Uy/08tN+8EQJ0zH
	 YNhhAorZrg375aEbH2q8jCspxoCpVcbzZwi/LaudQgUrxor2AXm6+ONABYPZyR5LX2RCH
	 Hq0FYPfMhyoA7u84y+e2sUx+dfdUWN4UWlSxRrZRH1zEHLUl7Ao6XHFV177DPXtJushto
	 rijBoHwuPwLjCMKZU91swWF9pYV9FKYM7jZekSIJrAfcxifnFj246dBkzYjzWpDBmnq2n
	 cQzXW+hMaqj3LN819INW1YWiMVgOgLqCjY7J33n8GvzgFQJzCtltGE/Xykhzz3RWtFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FKglKiC8IbMZIVJCxsEwPR2kCXlX7Bw1azpbHhEs958=;
	b=nnGyf/L0blirm+82mHrDqWq+3TQ3ipRafS30Md6rZDS+ykWKvi0R9QRxjH7mVgdDv5pC
	 YXZegTiwiTKx4e+AFurRcrdfsq/F8w7NPxoZRznNT9exxYwLTPz3Kb0VDcaJ/M1w47dHc
	 WkkvEvSZLl/9kLb5tiycjjs+ZyiXDaWdUTrKQwOK3ZXhLGnoCtj8gIOP5V/gX/gk0HRft
	 zU5JZ5oW+/fzD5dOg6yuC5dstBm6d6WzGWzz07rmO80Z9dm0qgOcdmg9Of+o7E0131MiJ
	 rbC1+yXrUhj7i2JKljU9Tf6US83ghAzXMOleiJQ+KYzGwGYa3JoA2wmNzNTdVA//zgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GB3tzbFi;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67A606A32C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D67A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GB3tzbFi
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea0efd636dso25088575ad.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026918; x=1793631718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKglKiC8IbMZIVJCxsEwPR2kCXlX7Bw1azpbHhEs958=;
        b=GB3tzbFijwvnbZ5k1cOUDGMX8soebDi9zgxxpFCPa5bcbQTqUGz6Cv1vacFc819zeD
         NaNcTBFmcBmL2AkVd/A1czH6u0WxkrzqQ36MjyfB4i7nwydmynEiRaryN4Jv7WOv4Az5
         Z04IaEjC+VBHJPFpkZDT65YkdkOQaY5JYwixPKY2kEfyw055BUJZOQzdO0VX70J6TgjK
         kSv4cZHoKp92nkBonNTux54vNW90PRB8JkV4+McMUFQgpmF7sruGRfy7QclZ6HtFgYuB
         eY+GOWKIqiCFLo9WfL3drlzbCIS2PJsHx/+cdFx4iJrKfqEZqgHESfuIteAWod6aRiqm
         mD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026918; x=1793631718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKglKiC8IbMZIVJCxsEwPR2kCXlX7Bw1azpbHhEs958=;
        b=UCi74/93UBY86d++j8xlzo01lnJHKDWYi7f9hnYe7Nb3X6mI43yVAq7hYEU6D45Wzf
         UtFLc/U/80YhM+mW0FSabLFdu7pIzPK9IRSgwTVbASOi4L2d0paY6VIuU+cD/CN7jTkF
         e5sC95cAln2aetBj6bjLIpyfI6IQipDGBE1/JKhD4S06ZVRdifuwikOz8MaXY2xeCM5s
         3nSY6NvIsPxhxv3wTZOMb2QUWhKsclfQyymCxkKZJnaDD+5JyUc1GPLEb84RQiUOg5HW
         PzNCNlblN1OI0MdBdjXoVqxN+N7OzLVDlLyjEDSk5dr03m0gPEK6iSob+LbVxKXZFfKj
         GyWg==
X-Forwarded-Encrypted: i=1; AKwUvBx7cjgzcLlhYDlFuULg6WN6+vAAjCk3XbA12POM/r0fR3RZMsJxrgS8KdmcBejGJjpBuUrs1e8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDo0ZABlEKAMqkPILFwELxFgZIAQrPawSNF3kTLVk1VneCMT3o
	NhJDmugul8ViGjpw905n5XIRM7+xOKCtuVsnkOIGBUmurkqVZrNaUJ0O
X-Gm-Gg: AYBFou0Jve5tCO0muKPBhXm11ITp7L0HDulM5vHahv8gE1+Dyqmkl0EnRgR1aBYGlLF
	YGpysMOIlY+tbLU2xQgPXM7ecryr/vlysU/3Nu9bfa6X3usGd8qp0zNuY8uGrJ5LRXT81bam+r9
	usDq1i52Qt1E9I70d2TnbXSMZVCoKnHE0CJtYUa0nAEBnkwQQUFA5bU8B6KXYV+8732nntf+Jv6
	nT1/GdhKRVpY6DMhh7V4Ld4f7tNpeUXkumtrcFAlq944xAQjEmMjM3Uz/WUTnMrZTdt7STd1W68
	ZtlJLDv386euUGfZAe0B9ka9Al7JUkI/e8ZYtNJAsksr3MClGJDDpAP3kn3j54RgEZA63EPx6mR
	FxDFPdeLP49XfAJzsFJuNhMz4U5q0REs4ZXkrTqXXA4Sy419LgvU1cVmPxUF4/+12mdTHdgQZrM
	guDU6hZM0drs/OhAhRvIJHqimH6Nn5ML8xoV1xSYfVMyPOoVIp7MFqrktotR9wn5nWddfttU7m+
	fipSfenPTj10f1f1R7zVsU9dXcZmR/IihjMATgE4x6ZkRw2tM8=
X-Received: by 2002:a17:902:da8e:b0:2ea:19a1:cd3e with SMTP id d9443c01a7336-2ea9c83381dmr62792325ad.33.1793026918029;
        Mon, 26 Oct 2026 08:01:58 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b11f48dsm18761515ad.17.2026.10.26.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:01:57 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: stop recovery before shutting down local allocators
Date: Mon, 26 Oct 2026 23:01:52 +0800
Message-Id: <pm-ocfs2-objects-candidate-0019-v6-7241e0b915991218f315@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recovery completion needs the local allocators until it has finished
reclaiming a failed node's allocation window and truncate log. During
unmount, quota recovery is stopped first, but that leaves recovery_state
at OCFS2_REC_QUOTA_DISABLED. New non-quota recovery can still start.

ocfs2_truncate_log_shutdown() drains existing completion work and releases
osb_tl_bh before ocfs2_recovery_exit() closes that publication path:

  Unmount                             Recovery
  -------                             --------
  stop quota recovery; disable quotas
  truncate_log_shutdown()
    flush existing completion work
                                      recover another failed node
                                        queue completion
    flush local log; release buffer
                                      complete_truncate_log_recovery()
                                        use released osb_tl_bh
  recovery_exit(): disable and drain

An extra buffer reference alone would still let completion append new
records after the final truncate-log flush.

Split stopping and draining recovery from freeing its state. Stop all
recovery producers and drain completion work before shutting down either
local allocator. Keep recovery-state release at its existing later point,
so its lifetime relative to other teardown users stays unchanged. The
second stop at recovery_exit() is harmless once recovery is disabled.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in ocfs2_truncate_log_needs_flush+0x23d/0x360
    Read of size 8 at addr ffff8881093711e8 by task kworker/u16:3/53
    
    CPU: 0 UID: 0 PID: 53 Comm: kworker/u16:3 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: ocfs2_wq ocfs2_complete_recovery
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? ocfs2_truncate_log_needs_flush+0x23d/0x360
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? ocfs2_truncate_log_needs_flush+0x23d/0x360
     kasan_report+0xe0/0x110
     ? ocfs2_truncate_log_needs_flush+0x23d/0x360
     ocfs2_truncate_log_needs_flush+0x23d/0x360
     ? __pfx_ocfs2_truncate_log_needs_flush+0x10/0x10
     ? __pfx_down_write+0x10/0x10
     ocfs2_complete_truncate_log_recovery+0x315/0x780
     ? trace_hardirqs_on+0x18/0x160
     ? __pfx_ocfs2_complete_truncate_log_recovery+0x10/0x10
     ? ocfs2_complete_recovery+0x666/0x11b0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? kfree+0x308/0x580
     ocfs2_complete_recovery+0x676/0x11b0
     ? __pfx_ocfs2_complete_recovery+0x10/0x10
     ? reacquire_held_locks+0xdd/0x200
     ? process_one_work+0x7c8/0x1b40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_acquire+0x190/0x300
     ? __pfx_autoremove_wake_function+0x10/0x10
     ? process_one_work+0x834/0x1b40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x9a8/0x1b40
     ? __pfx_process_one_work+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x177/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
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
    
    Allocated by task 538:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_slab_alloc+0x89/0x90
     kmem_cache_alloc_noprof+0x20b/0x5c0
     alloc_buffer_head+0x26/0x120
     folio_alloc_buffers+0x122/0x1d0
     bdev_getblk+0x299/0x4f0
     ocfs2_read_blocks_sync+0x513/0xbc0
     ocfs2_iget+0x9cd/0x1a00
     ocfs2_get_system_file_inode+0x25e/0x7a0
     ocfs2_fill_super+0x1b05/0x3930
     get_tree_bdev_flags+0x35d/0x5f0
     vfs_get_tree+0x93/0x320
     fc_mount+0x1d/0x200
     path_mount+0x592/0x1e00
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Freed by task 553:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kmem_cache_free+0x242/0x580
     free_buffer_head+0x4b/0xc0
     try_to_free_buffers+0x1dc/0x330
     ocfs2_truncate_log_shutdown+0x789/0x1290
     ocfs2_dismount_volume+0x1da/0x940
     generic_shutdown_super+0x15f/0x490
     kill_block_super+0x40/0xa0
     deactivate_locked_super+0xae/0x120
     deactivate_super+0xa2/0xc0
     cleanup_mnt+0x217/0x450
     task_work_run+0x144/0x230
     exit_to_user_mode_loop+0x17d/0x570
     do_syscall_64+0x4d1/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    The buggy address belongs to the object at ffff8881093711c0
     which belongs to the cache buffer_head of size 160
    The buggy address is located 40 bytes inside of
     freed 160-byte region [ffff8881093711c0, ffff888109371260)
    
    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x109371
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff8881008883c0 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000120012 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff888109371080: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
     ffff888109371100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    >ffff888109371180: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                              ^
     ffff888109371200: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff888109371280: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
    ==================================================================

Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
 fs/ocfs2/journal.c | 11 ++++++++---
 fs/ocfs2/journal.h |  1 +
 fs/ocfs2/super.c   |  3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index a3938a03e93b..065076b1278d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -227,13 +227,18 @@ void ocfs2_recovery_disable_quota(struct ocfs2_super *osb)
 	ocfs2_recovery_disable(osb, OCFS2_REC_QUOTA_WANT_DISABLE);
 }
 
+/* Stop producers and drain completion work without freeing recovery state. */
+void ocfs2_recovery_stop(struct ocfs2_super *osb)
+{
+	ocfs2_recovery_disable(osb, OCFS2_REC_WANT_DISABLE);
+}
+
 void ocfs2_recovery_exit(struct ocfs2_super *osb)
 {
 	struct ocfs2_recovery_map *rm;
 
-	/* disable any new recovery threads and wait for any currently
-	 * running ones to exit. Do this before setting the vol_state. */
-	ocfs2_recovery_disable(osb, OCFS2_REC_WANT_DISABLE);
+	/* Disable producers and drain work before freeing recovery state. */
+	ocfs2_recovery_stop(osb);
 
 	/*
 	 * Now that recovery is shut down, and the osb is about to be
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 19fc920d26b1..4b52bf7b0938 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -147,6 +147,7 @@ void ocfs2_complete_recovery(struct work_struct *work);
 void ocfs2_wait_for_recovery(struct ocfs2_super *osb);
 
 int ocfs2_recovery_init(struct ocfs2_super *osb);
+void ocfs2_recovery_stop(struct ocfs2_super *osb);
 void ocfs2_recovery_exit(struct ocfs2_super *osb);
 void ocfs2_recovery_disable_quota(struct ocfs2_super *osb);
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0af2245ae303..3072b0386db8 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1831,6 +1831,9 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	/* Wait for worker to be done with the work structure in osb */
 	cancel_work_sync(&osb->dquot_drop_work);
 
+	/* Stop recovery producers before releasing their local allocators. */
+	ocfs2_recovery_stop(osb);
+
 	ocfs2_shutdown_local_alloc(osb);
 
 	ocfs2_truncate_log_shutdown(osb);
-- 
2.43.0

