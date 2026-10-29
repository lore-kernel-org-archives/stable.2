Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257016;
	b=CPXdJs01GXe+DGrBRV0H85ZhhIqMwpM3JvM5GyJBtEtJzsGrak+eX5GAty3XHjptgRu1
	 lWbpDMOgzWnGtec1ISf+U+I4jb+ehV2qfgbCMM75Kdtcpq1uUH6ZIuR0t20AohXKZzE+k
	 cdIsiX1O6fTCG1vqKoZwc3TxzZJC8qZGMd37YFokrFDVhlannXesZo4IW+sg2lF2C0EXd
	 Ft4j3pJWJ5rybLWYBHpOsngLZlEq8TGJNCnHLOZYS+pZn1UuNLtzgHVQ+5yQerN8q9mZs
	 f1suzzcanuhG9/Gxr3OuulfV14SJnZL6kwPxSoMmc8hwkapOnUqMYDIkUxdjp4qqCZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hR7bpGoqOkAzxkh6GFImhYK3YN9EXwKZesSLQ0u1G5Q=;
	b=5oLPn9VE6uBocpANOMor88JF3P7nYKQU1ouyIW1wt+dZtF7W69MBZWm3xsw4+BH8sCP5
	 UW1LP9lezSVMy0jTMGvo+7aA+qSiMZCAeMwrieciC1rj97aXHTNz3UYnNa7h9NLZMooya
	 690DsIxNwyPZjHGNzOMjJ6GB+rPG78PlCUBKTbmmZshgxDse/1V6HOOooOhh3fkzcND0r
	 afkzNMvjjir0uZgVxmtK8l4Yzuybd3Z5pAViClqVbKfbTqvIT9W7mw2LzZhsMcFfGvgH3
	 vEGT8CqmxwM0tuQxGIP5vk80AItM3NzjNzVLDjuF1PsJGbqQXkWOSUj1uLUs3RA0MCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wlWD/KuY";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82603606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82603606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlWD/KuY
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so915092a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257016; x=1793861816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hR7bpGoqOkAzxkh6GFImhYK3YN9EXwKZesSLQ0u1G5Q=;
        b=wlWD/KuYzEe1qRVJ6X8gKza+f2o35+OvRqfg1B3DH75PRi+xvIbZa2avjVx9qDpcLr
         M7hdf0YD1zdGRpkFLZkg867Z8RHLdqTbYCrF2v/pA8oy6DHBpWqRh3ac1r2j8UmrvfGB
         2NiwpUzq5Wl3GRBTsBaGjf1fiYoY2L7+1Y+t2jeF8Tk+c+N3kzqtiIeZl1Z2LL+z+1N/
         +LDBXsZrx8Jd+wsP3FpuOvo+P35VU7aqn6lwfftS3yYUT+A5TrAbyyUnWfu5RsF7KHJp
         QaDPCSzh/gnAjck/+ainqxA36Qrxv07/PM00DZNEumSZrttyFx9OND0UnFr8l91tRMjE
         8S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257016; x=1793861816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hR7bpGoqOkAzxkh6GFImhYK3YN9EXwKZesSLQ0u1G5Q=;
        b=ed052Jj5KY98wY3cji3xvrWah+aDwxGZajVo48TSZ4BYgRF70IzYGSs25VG1/+R+3w
         snPB886FaxcZFNqw1nhjz5Fk88rxHaB2msHu8x+WO8CPorgBzL0VD1uvo/BT/xpUAGNO
         yyxPfgI+E959kQBzYeXDMVesp4jlHq486LqOf/3DbLI1IS6TqS/7JVmU6okrWtZHNn4m
         UxILtgu8abWGBfe4sIsaohA1U5kC+mCCLyzt94hCq63DVTfQjSe5AuS/xygfoLmwR8mu
         BZz2QGb17tkk+7NyoBGSXdRl/+AchKhxAX+50NKjBAAv4LsHONw5/XE6ZbNsg/5pUrVz
         pwGA==
X-Forwarded-Encrypted: i=1; AKwUvByIPABIql7fXyRMQB3m5yv+FFYos/eY10S1S1T6q2k4VU2D+xylH2snU5+JFtPD/KE29wMqa0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAOHakknDtmgO+wBvNwUq50gX8CRna55hXEcXPZhqlBWJFg9OK
	GHFd5RxfbGxsugEISd9OQBE04Ug9lDsW8asLTKZmoa4Bk5Zs3FJ2UBa/
X-Gm-Gg: AYBFou0mqdst49g5HC8ZsK6EDhdJyXYcQpbUadF8rRTCkDQjgA4kfaLwy+NIoqth0Hl
	roDbtbztMY/FzmJ3RpoBG+LvjfiVXl3jUly8/l8GAs6cX5b59asi50XCitVh1ktg1zJLv52yTU0
	RVVEogfKQTTcsAhbDHlq3vwd1XxI57SbG1+9p7heoSwzPV5/KJJdyeZ241PJt8LXu4Be1Pz6VeG
	x7XQzV6nqbD/OqBz+Vl3XoOH+0iyGnc0YpUxug0R6aXTE+v/roUKcj3LYCzSqiDJ4saxgunGojr
	XfiOPChJAnU66DKdicQiO2HZr7sudb0Ehb/R5qk5rcQ6VcOsCv4qzu/NW/wH3boGIRKBjlveAmI
	CoT/JqnX6bbRohJuYGXRVGJSZxTotcofwiCf3RSrdlcwasxyZzjAU4tr0/vz8MV9jyGBGKbPj4O
	60ZJzPoThKHKjmpSsZtuJtfww7CMIbdswK8dArTtCNMxnyrfBRmLJW63iN3fjQN2yr24BYDsWD0
	/mYN1sTjufy3nk4gWB9tQ7USsWl+lX+2g2onW3nInGJSJzAlc0SARVILwt8TtuCTjWYKQBoi4Di
	klUb9oVd0E+zQqsyX/ZM1HM2
X-Received: by 2002:a17:90b:4b89:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae581e1959mr3583427a91.47.1793257015651;
        Wed, 28 Oct 2026 23:56:55 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83a4f1sm2954509a91.12.2026.10.28.23.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:56:55 -0700 (PDT)
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
Subject: [PATCH v2] ocfs2: advance locking_state through the live cursor
Date: Thu, 29 Oct 2026 14:56:48 +0800
Message-Id: <pm-ocfs2-objects-candidate-0053-v7-ec41d4bbd38bb4d795a8@gmail.com>
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

locking_state copies each lock resource under ocfs2_dlm_tracking_lock
so its containing inode or quota object can be freed during the dump.
The copied l_debug_list pointers do not have that lifetime protection.
Yet ocfs2_dlm_seq_next() follows them to find the next record.

Remounting read-only can free a quota-info object while a debugfs read
is between the snapshot and the next iterator callback:

  locking_state reader                Quota suspension
  --------------------                ----------------
  snapshot current lock resource
    copy l_debug_list.next
                                      remove next resource from live list
                                      free quota-info object
  seq_next(): follow copied link
    read freed lock resource

Advance through the live dummy cursor instead. List removal updates its
links under the tracking lock. Position it after the resource being
copied before releasing the lock, and never walk the snapshot's links.
Reuse the per-open snapshot for a nonzero seq_start() position, including
read continuation and buffer retries. Rewind the live cursor only when
seq_file starts at index zero; seq_lseek() traverses from there through
seq_next(). Clear the snapshot's l_ops marker at end of list so later
reads remain at EOF. This avoids replaying the list prefix under the
tracking lock on each read, without adding a new cursor or position field.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in ocfs2_dlm_next_res.isra.0+0x1b1/0x1d0
    Read of size 8 at addr ffff888117ea9838 by task python3/489
    
    CPU: 3 UID: 0 PID: 489 Comm: python3 Not tainted 7.3.0-rc4-next-20260921-pmb-bt-functional-v1+ #1 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? ocfs2_dlm_next_res.isra.0+0x1b1/0x1d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? ocfs2_dlm_next_res.isra.0+0x1b1/0x1d0
     kasan_report+0xe0/0x110
     ? ocfs2_dlm_next_res.isra.0+0x1b1/0x1d0
     ocfs2_dlm_next_res.isra.0+0x1b1/0x1d0
     ? __pfx_ocfs2_dlm_next_res.isra.0+0x10/0x10
     ? __pfx_do_raw_spin_lock+0x10/0x10
     ocfs2_dlm_seq_next+0xb8/0x4c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     seq_read_iter+0x92f/0x1110
     ? srso_alias_return_thunk+0x5/0xfbef5
     seq_read+0x362/0x5a0
     ? __pfx_seq_read+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_file_permission+0x11d/0x540
     full_proxy_read+0x11f/0x180
     ? __pfx_full_proxy_read+0x10/0x10
     vfs_read+0x1a0/0xc20
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? kmem_cache_free+0x242/0x580
     ? __pfx_vfs_read+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? putname+0x93/0xe0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_sys_openat2+0x12a/0x1b0
     ? __pfx_do_sys_openat2+0x10/0x10
     ksys_read+0x111/0x200
     ? __pfx_ksys_read+0x10/0x10
     ? irqentry_exit+0xbe/0x820
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on_prepare+0x11d/0x150
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f0266dbb687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffccf76fc40 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
    RAX: ffffffffffffffda RBX: 00007f0266d27780 RCX: 00007f0266dbb687
    RDX: 0000000000000001 RSI: 00007f0266a53200 RDI: 0000000000000004
    RBP: 00007f0266d27700 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
    R13: 00007f0266a53200 R14: 0000000000000004 R15: 00007f0266b651e0
     </TASK>
    
    Allocated by task 547:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x28d/0x610
     ocfs2_local_read_info+0x181/0x1580
     dquot_load_quota_sb+0x68b/0x1000
     dquot_load_quota_inode+0x227/0x3e0
     ocfs2_enable_quotas+0x27c/0x520
     ocfs2_fill_super+0x21f9/0x38f0
     get_tree_bdev_flags+0x35d/0x5f0
     vfs_get_tree+0x93/0x320
     fc_mount+0x1d/0x200
     path_mount+0x592/0x1e00
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Freed by task 577:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x308/0x580
     ocfs2_local_free_info+0x47b/0x800
     dquot_disable+0x5d9/0x17a0
     ocfs2_susp_quotas.isra.0+0x22c/0x2b0
     ocfs2_reconfigure+0x284/0xd00
     reconfigure_super+0x3ca/0xa70
     path_mount+0x16ae/0x1e00
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    The buggy address belongs to the object at ffff888117ea9800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 56 bytes inside of
     freed 1024-byte region [ffff888117ea9800, ffff888117ea9c00)
    
    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117ea8
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000040 ffff888100042dc0 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
    head: 0200000000000040 ffff888100042dc0 dead000000000100 dead000000000122
    head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
    head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
    head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff888117ea9700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff888117ea9780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    >ffff888117ea9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
     ffff888117ea9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888117ea9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v2:
- Resume nonzero read positions from the existing snapshot instead of
  rescanning the list prefix under the tracking lock.
- Rewind only at index zero and let seq_lseek() traverse through next();
  clear the cached record at EOF.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0053-v5-76075d5da2df8108f813@gmail.com

 fs/ocfs2/dlmglue.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 88d946466083..99885d21e06b 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3102,9 +3102,17 @@ static void *ocfs2_dlm_seq_start(struct seq_file *m, loff_t *pos)
 {
 	struct ocfs2_dlm_seq_priv *priv = m->private;
 	struct ocfs2_lock_res *iter;
+	struct ocfs2_lock_res *dummy = &priv->p_iter_res;
+
+	/* Continue or retry the snapshot left by ->next(). */
+	if (*pos)
+		return priv->p_tmp_res.l_ops ? &priv->p_tmp_res : NULL;
 
+	/* Reads from zero and seek traversal start at the list head. */
 	spin_lock(&ocfs2_dlm_tracking_lock);
-	iter = ocfs2_dlm_next_res(&priv->p_iter_res, priv);
+	list_move(&dummy->l_debug_list,
+		  &priv->p_dlm_debug->d_lockres_tracking);
+	iter = ocfs2_dlm_next_res(dummy, priv);
 	if (iter) {
 		/* Since lockres' have the lifetime of their container
 		 * (which can be inodes, ocfs2_supers, etc) we want to
@@ -3113,8 +3121,11 @@ static void *ocfs2_dlm_seq_start(struct seq_file *m, loff_t *pos)
 		 * trust any pointers on the copy returned, but that's
 		 * ok as the information we want isn't typically held
 		 * in them. */
+		list_move(&dummy->l_debug_list, &iter->l_debug_list);
 		priv->p_tmp_res = *iter;
 		iter = &priv->p_tmp_res;
+	} else {
+		priv->p_tmp_res.l_ops = NULL;
 	}
 	spin_unlock(&ocfs2_dlm_tracking_lock);
 
@@ -3128,17 +3139,19 @@ static void ocfs2_dlm_seq_stop(struct seq_file *m, void *v)
 static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ocfs2_dlm_seq_priv *priv = m->private;
-	struct ocfs2_lock_res *iter = v;
+	struct ocfs2_lock_res *iter;
 	struct ocfs2_lock_res *dummy = &priv->p_iter_res;
 
 	(*pos)++;
 	spin_lock(&ocfs2_dlm_tracking_lock);
-	iter = ocfs2_dlm_next_res(iter, priv);
+	iter = ocfs2_dlm_next_res(dummy, priv);
 	list_del_init(&dummy->l_debug_list);
 	if (iter) {
 		list_add(&dummy->l_debug_list, &iter->l_debug_list);
 		priv->p_tmp_res = *iter;
 		iter = &priv->p_tmp_res;
+	} else {
+		priv->p_tmp_res.l_ops = NULL;
 	}
 	spin_unlock(&ocfs2_dlm_tracking_lock);
 
-- 
2.43.0

