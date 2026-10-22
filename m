Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660133;
	b=bRWckD0MLJqgnHMn8Y9099UICYPeAr7kz0Q3DmOrkGIbZbMsNtPtL004hATfNShf4YXG
	 BDdpvH/8Sr6r9pcdNycu5Fr63FZWKNn3WOfNruiJB8M5IskP+MsTKR2k4wy3UX/eZ5/0R
	 sZj6z6UUzDG0R2VPXK1shGTExDZZHmW/GkLeqmPJ9+TfaQ/d/fE5SLreIx9418ldppLjl
	 UIavhGPs71rWKnLmyPc7HMLRKG4PgIQQwlw/x9spIcfXDxSW8sq1ANwr8L1ITa7OnkdLf
	 RqUp6nCkI74ZE2Djeo+bC61N5KdMvEN6RIEaU1uGh89cm7kZO2eQuACQTPiYGf0iZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z1KCiZXaYqBijXtyLiF7iqAfRTB1Jk4N5AT6pA0XCE0=;
	b=hPfmeqDire86ycgBoWttg8D9mlEc+4sl6zUbXJsJ1o7Qlp9Bl4Xu4IkaLpWLmxbU6vB3
	 ckrLnaYFJ89lY4gWW/gp6mVxJ5NtRYmHDa5r+SqiCiODGbBk7u+Pcre8hT4nYpnjql5/I
	 2gWiO5VCDn899OFwNgh3Xx0TMmz3ADioIra0gro2IAxQh1mpzucjyZktr1RHgonJRIQCj
	 8tUGDJ/SSavRGIDRbFyd37dIsqUBUTuvmyrAMpfrrawqqmKW+eOBPvp2G9tmdIiaU/Zb6
	 kkesI2IgO9E///u6WL8w4tu7gQ/VqqgMmK2CSophiSi0A6XMg1UieY4M5Am73ps+Bqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DGDiiUox;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008E606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5008E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DGDiiUox
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so561297a12.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660133; x=1793264933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1KCiZXaYqBijXtyLiF7iqAfRTB1Jk4N5AT6pA0XCE0=;
        b=DGDiiUox8g5DWm4NM2MUWCnUYBeWFLrx5WYD7PER66ZKxapFQPoch5z5zk9jN1/z22
         Uz+IJKfTQjv1qrK4d/C5gzY/n0FRhvZmLxSgK6Eeq/ev0p7amf2VOXjb/I4PEVUEuK0X
         hOD3xVCrd8TNvqeDtu95vVzWLPRvcdcQ0XwXhNIbyZXhTglXcM9R9M8pn+1RqwsEJI3t
         ZTLm3H2CWRnnO/I0vghS0wjSFZHeq81EfoomaAoMlIgh4Z9vfawRoIUAaC60UDHxyBsX
         qD4FWISRS2It3TeA/uhZB6I91Ca6XRy5iASgcCiR2fKB8tE/ahMNPnWSl4vc5Hu0C3Wb
         IIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660133; x=1793264933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1KCiZXaYqBijXtyLiF7iqAfRTB1Jk4N5AT6pA0XCE0=;
        b=OcSWCGtDmIOFmWRV8YtiAZDs2FfBSCJCuQXrFlGzYhMTqHK2D8YsnbXIs1v1JkRByu
         OEZa5d6IqjAZBNA9sBoY0JcWvu4czkv2DT5MhDq8X5hb6cx3ISAmv9IOCCQWfq/z0DY5
         4Y8sAcbMAwzJWOmEVTWDEVejEpw6Mc870cwhMLsMJnBIQoBfsPnNwS8d2G1EmWWl2N46
         V/5KZw5I9XfkiWvHgyDI5BYk5w5yJhCtg4H9TLaYzPPbWYsLaoj+nuI4ts22HTdWfmqF
         /sGn0UYDensc4S5rmJJrApwifabT2+zt1zo96ExUYK9WCvctBcVeHPkwbBvsSLjxtc3R
         ikXg==
X-Forwarded-Encrypted: i=1; AKwUvBzAPSy1MswQlFmo8RJmQAS3hGTcP6lOa46PF0Kp2q2P2rfLutJNjicvvVKLYarL+YcUAIaENl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4BsKNvk1efifFFfswKLxzUDZb9Ne2NAzzj5g7QCbGgPvMTdjh
	//glqz22IAetjql4yVLRqryh5gkqgPMmOvHC/Jk5UWoC47qlPhQbu3/p
X-Gm-Gg: AYBFou3jLGR6m9OZf6Mc7xeK92jAIAyKJFjDZUpNZxIHH2Y3COjCI67Lz+hVUcbytu+
	1x5i6Q+R4tgA3TxWnvsg48Y6xzxx3F2cnOHOuR7m+zhALuiuJi0uid7ltIUbvwohpoPVVEPpNjG
	vrLzVRkVZ3VVqRzzioRlF/M1xoEH5r5byk86n50Fpf+e/MK0TFOYBKNz2vXRlUMtrKIifXfeUAy
	ILGx/W6kUmBXW0KyBc86jFDZ6+/ZbFqKu05KuPDrbJuVL79zgTK/0GZMhkaXN3BxWrTnIF6VNlB
	x8om8Z1AVbtLIIqpPnS29Epqcfxv3N9shoAVIcIAXR7EVoDIEKjSt2MW89nLBy0Ash+rt39mH93
	I/04oQXbYsGG68AisQzKpLsEskC61qU8N6qWzZymXl9Lby33Cz+LxarNp0pKn7/5hrPxfQG/OJa
	QR9SAQAjklkOxiyECBjDI8peYMUHaqZfo8uXla9idvGRbr+nhghH+5dYDlPDMXopzA2wCZYi1gA
	Ugs/Htny+c5u2PJ0ELmhqO1NoZ5Zn0zgD1q/H15H1p/qVPgShPAM0sC/NXY3ispLGqVBBNl
X-Received: by 2002:a17:90b:c0b:b0:3ad:8ecc:5907 with SMTP id 98e67ed59e1d1-3ad8ecc5cf2mr2334684a91.56.1792660132383;
        Thu, 22 Oct 2026 02:08:52 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490c096sm3325111a91.7.2026.10.22.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:08:52 -0700 (PDT)
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
Subject: [PATCH v4 1/2] ocfs2: snapshot dentry names in file and setattr traces
Date: Thu, 22 Oct 2026 17:08:41 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
References: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
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

The open, fsync, read, write and splice-read trace calls pass the live
dentry name and length to the shared ocfs2__file_ops event class.
ocfs2_setattr() passes the same unprotected arguments to its own event.
Both events size and copy a __string field separately. A reference to
the dentry does not pin the external storage backing an individual name.

With an event enabled, a caller can be preempted after loading the name
pointer. A long-to-short rename can then replace the name and reclaim its
old external allocation before the trace callback sizes or copies it,
provided no other snapshot retains that allocation.

The setattr inode lock does not exclude every rename: a same-directory
rename of a source directory need not take that directory's inode lock.
It can therefore change the dentry name while setattr records its event.
Inline names and separately loaded lengths can also change during trace
record sizing and copying.

Take a dentry name snapshot around each of these six trace calls and
pass both the string and length from the snapshot. Check event enablement
before taking a snapshot. Keep the event classes and formats unchanged.

Also remove the redundant NULL-inode check in the read callback.
file_inode() returns the open file's inode, which is already used by the
trace call above the check.

The historical report below is from the read path.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0
    Read of size 1 at addr ffff88810a5b2b18 by task python3/496

    [CPU and host details omitted.]
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? strlen+0x85/0xa0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? strlen+0x85/0xa0
     kasan_report+0xe0/0x110
     ? strlen+0x85/0xa0
     strlen+0x85/0xa0
     trace_event_raw_event_ocfs2__file_ops+0xf0/0x480
     ? __pfx_trace_event_raw_event_ocfs2__file_ops+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xe7/0x1c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ocfs2_file_read_iter+0x6cd/0xb30
     ? __pfx_ocfs2_file_read_iter+0x10/0x10
     ? selinux_file_permission+0x11d/0x540
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? security_file_permission+0x26/0x80
     vfs_read+0x7d2/0xc20
     ? __pfx_vfs_read+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_do_sys_openat2+0x10/0x10
     ksys_read+0x111/0x200
     ? __pfx_ksys_read+0x10/0x10
     ? irqentry_exit+0xbe/0x820
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on_prepare+0x11d/0x150
     ? srso_alias_return_thunk+0x5/0xfbef5
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [User register dump omitted.]
     </TASK>

    Allocated by task 489:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_noprof+0x2de/0x780
     __d_alloc+0x5fc/0x8c0
     d_alloc_parallel+0x106/0x11d0
     lookup_open+0x3ff/0x13e0
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
     __rcu_free_sheaf_prepare+0x65/0x2a0
     rcu_free_sheaf_nobarn+0x1d/0x50
     rcu_core+0x6be/0x1ed0
     handle_softirqs+0x1fa/0x8d0
     __irq_exit_rcu+0x113/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    The buggy address belongs to the object at ffff88810a5b2b00
     which belongs to the cache kmalloc-rcl-192 of size 192
    The buggy address is located 24 bytes inside of
     freed 192-byte region [ffff88810a5b2b00, ffff88810a5b2bc0)

    [Page and shadow-memory dumps omitted.]

Fixes: 468eedde23d6 ("ocfs2: Remove mlog(0) from fs/ocfs2/file.c")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/file.c | 100 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 36 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d6e977ba6565..c6e7606ff9e1 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -85,10 +85,17 @@ static int ocfs2_file_open(struct inode *inode, struct file *file)
 	int mode = file->f_flags;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
-	trace_ocfs2_file_open(inode, file, file->f_path.dentry,
-			      (unsigned long long)oi->ip_blkno,
-			      file->f_path.dentry->d_name.len,
-			      file->f_path.dentry->d_name.name, mode);
+	if (trace_ocfs2_file_open_enabled()) {
+		struct dentry *dentry = file->f_path.dentry;
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_file_open(inode, file, dentry,
+				      oi->ip_blkno,
+				      name.name.len, name.name.name,
+				      mode);
+		release_dentry_name_snapshot(&name);
+	}
 
 	if (file->f_mode & FMODE_WRITE) {
 		status = dquot_initialize(inode);
@@ -174,11 +181,17 @@ static int ocfs2_sync_file(struct file *file, loff_t start, loff_t end,
 	tid_t commit_tid;
 	bool needs_barrier = false;
 
-	trace_ocfs2_sync_file(inode, file, file->f_path.dentry,
-			      oi->ip_blkno,
-			      file->f_path.dentry->d_name.len,
-			      file->f_path.dentry->d_name.name,
-			      (unsigned long long)datasync);
+	if (trace_ocfs2_sync_file_enabled()) {
+		struct dentry *dentry = file->f_path.dentry;
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_sync_file(inode, file, dentry,
+				      oi->ip_blkno,
+				      name.name.len, name.name.name,
+				      (unsigned long long)datasync);
+		release_dentry_name_snapshot(&name);
+	}
 
 	if (unlikely(ocfs2_emergency_state(osb)))
 		return -EROFS;
@@ -1132,15 +1145,19 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int had_lock;
 	struct ocfs2_lock_holder oh;
 
-	trace_ocfs2_setattr(inode, dentry,
-			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
-			    dentry->d_name.len, dentry->d_name.name,
-			    attr->ia_valid,
-				attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
-				attr->ia_valid & ATTR_UID ?
+	if (trace_ocfs2_setattr_enabled()) {
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_setattr(inode, dentry, OCFS2_I(inode)->ip_blkno,
+				    name.name.len, name.name.name, attr->ia_valid,
+				    attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
+				    attr->ia_valid & ATTR_UID ?
 					from_kuid(&init_user_ns, attr->ia_uid) : 0,
-				attr->ia_valid & ATTR_GID ?
+				    attr->ia_valid & ATTR_GID ?
 					from_kgid(&init_user_ns, attr->ia_gid) : 0);
+		release_dentry_name_snapshot(&name);
+	}
 
 	status = ocfs2_emergency_state(osb);
 	if (unlikely(status)) {
@@ -2392,11 +2409,17 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 	int direct_io = iocb->ki_flags & IOCB_DIRECT ? 1 : 0;
 	int nowait = iocb->ki_flags & IOCB_NOWAIT ? 1 : 0;
 
-	trace_ocfs2_file_write_iter(inode, file, file->f_path.dentry,
-		(unsigned long long)OCFS2_I(inode)->ip_blkno,
-		file->f_path.dentry->d_name.len,
-		file->f_path.dentry->d_name.name,
-		(unsigned int)from->nr_segs);	/* GRRRRR */
+	if (trace_ocfs2_file_write_iter_enabled()) {
+		struct dentry *dentry = file->f_path.dentry;
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_file_write_iter(inode, file, dentry,
+					    OCFS2_I(inode)->ip_blkno,
+					    name.name.len, name.name.name,
+					    (unsigned int)from->nr_segs);
+		release_dentry_name_snapshot(&name);
+	}
 
 	if (!direct_io && nowait)
 		return -EOPNOTSUPP;
@@ -2542,17 +2565,16 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	int direct_io = iocb->ki_flags & IOCB_DIRECT ? 1 : 0;
 	int nowait = iocb->ki_flags & IOCB_NOWAIT ? 1 : 0;
 
-	trace_ocfs2_file_read_iter(inode, filp, filp->f_path.dentry,
-			(unsigned long long)OCFS2_I(inode)->ip_blkno,
-			filp->f_path.dentry->d_name.len,
-			filp->f_path.dentry->d_name.name,
-			to->nr_segs);	/* GRRRRR */
-
+	if (trace_ocfs2_file_read_iter_enabled()) {
+		struct dentry *dentry = filp->f_path.dentry;
+		struct name_snapshot name;
 
-	if (!inode) {
-		ret = -EINVAL;
-		mlog_errno(ret);
-		goto bail;
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_file_read_iter(inode, filp, dentry,
+					   OCFS2_I(inode)->ip_blkno,
+					   name.name.len, name.name.name,
+					   to->nr_segs);
+		release_dentry_name_snapshot(&name);
 	}
 
 	if (!direct_io && nowait)
@@ -2624,11 +2646,17 @@ static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
 	ssize_t ret = 0;
 	int lock_level = 0;
 
-	trace_ocfs2_file_splice_read(inode, in, in->f_path.dentry,
-				     (unsigned long long)OCFS2_I(inode)->ip_blkno,
-				     in->f_path.dentry->d_name.len,
-				     in->f_path.dentry->d_name.name,
-				     flags);
+	if (trace_ocfs2_file_splice_read_enabled()) {
+		struct dentry *dentry = in->f_path.dentry;
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_file_splice_read(inode, in, dentry,
+					     OCFS2_I(inode)->ip_blkno,
+					     name.name.len, name.name.name,
+					     flags);
+		release_dentry_name_snapshot(&name);
+	}
 
 	/*
 	 * We're fine letting folks race truncates and extending writes with

