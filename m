Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467843;
	b=Gc9pPD5/TQ1CnFhCOhOwtJvc09+LzSa67su0evhphhPe+Cb77x6E4Rh0OkC7lHbzncLT
	 geeGQIYTT/PbgKhEdSSj6dE6gvetqYD5hOGRrMDbOjB59P25qF637WGG9kBRmbYnD5lY3
	 rvkEPsdTggnhrTkaLcddkbd01SrGC48w88lsGZgia2z34SVQEiG5y0LV61KRt0E2wHom3
	 yzof+yabzLYGdq//qxumdz+xiZtEqil+1JvznpuKXOT4VoEDM23nYPRHb8RLbH5AkzW89
	 w7CnELyAH1DWhm/XlKm/DPSSPzzcrkmt61KYAAlis5FOdzxUnFuhfO8DMsRs6j1T9Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7G78s70fxYPpMVHiegw9OWYXdiOyfEaNVnOA7iPMn0o=;
	b=W35fZ9/CupsHnTlU1LkiSapPRhluqs64Y0rKqHuHKvi+Qi+YclhXb+txSOxjP6CyVWX9
	 sNN42+kpmsJgH+IGfWOYtIGzlJSA53nZaDoDEmfkVmFm6v5Wlu3y34x0UinboUgC6ilbr
	 IxQvGKfAY2tml02B3vbLdVZHpekruWD4RZcQS+7MLnwZH3ANp8YDIKnJSHuNwh3jZlcYq
	 ntlymc6X6V8HFVSbANzzlwsUWornctXDPP8geVyqhsO/FKz7SW+OjaLFZcOknb/AL2hax
	 GQeGlc+wnwG65cPBsGIPSaBOCK9wrJiOyQ9bdQxmB9MT9x0oE8yymXvshYglpvRCVkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxdxLcwE;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A04606A322
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A04606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxdxLcwE
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9eb579c0eso9837725ad.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467842; x=1793072642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G78s70fxYPpMVHiegw9OWYXdiOyfEaNVnOA7iPMn0o=;
        b=QxdxLcwEeWMvjduRGpzcP6a3D/tOlaVDvcweoSssiqKrpCwgaZ7Dry4gd8p9KSOeB8
         FjN/ePsBGdYXg49LW+flhw9xi0EZGOZ/22o0AXu9xbbN69FqBR/ffZPKzGPlK00BWnx2
         UsnsPW3taPnE+uh6yK8YOR1rToF4SkYbwh2aHr3G4D9c8gwxtCqgbA0hJPfLetjaT+Nt
         MaP7TgfEzNzyRQcs+WX5sb04Da7afaMJiAw7cvf5H+M01kayh4uUCIlZk/G2+1xLapwY
         Oc920uxI5lRaCspUJTxYm6lBpYWWjlbf2gxToRxATZIGRgApgXzXCv2EdmYMiMMmct0p
         HpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467842; x=1793072642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7G78s70fxYPpMVHiegw9OWYXdiOyfEaNVnOA7iPMn0o=;
        b=yHWF7ko8yhyn8RlKM6MH6Kut6jIEJKLKfvnM7CtLKegoXFJRt+g8gRr+SR+ca9GUaH
         MsKhVwLVPO3wAHXB+TnM867w1yNOWzg5rn6yqj5/2qYhkq90QvwI3P9L2lqS/rqBevXH
         9h1KcaMQ3QG+Arb2kaM+X5NpO9WXF+1dXg6FvhEHcVwyrdkhV9fcWB9DRHlchB4sWINC
         9/sF5CdjQ5vtsIX0Jle2PDrNipOO8CUCiLyWc2UsldlMS7nvZfgGoiw/3iUVhm5dKMHV
         amvJSj49687nBFOp/ZMJw65ybeJge+AnY4PY6NMnDO6zNFWvpg/OndnZKZS+nZurzVgD
         KoEg==
X-Forwarded-Encrypted: i=1; AKwUvBw5M6dAkcToge3wL0IH0IGsUDhDXWvnPWpVi5F53Y30BMBLrYGm3VtrId3dgB98yiHxtqd6Grg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhwHdD6h2DTBHiBwnZE0/mWA7luPg6Qw69XEB1h0ZI1AhORlk0
	Vw2B0aL0L/QNCMRYYIuKnaPEGe/PeosGLw096+AqCOo3EIY5y843yXgt
X-Gm-Gg: AYBFou3g5s+xGpHwvLJwM66zDsK17MSp9peYbHIoVh9zveCNy72lz5ZI8pLHh4eHt4c
	tadwpLxTleJEFZgF9NARjyX/o+AN68Sea/tCvdbEZnminWV3FrsjYjgMA5fFvVTfNJNC6IL2Hr5
	w2RQE4hnNTjBLiWaC6zZkxpPehuHGHQHPePui7y+M9Cp52ULJ1u5IppS9ZVJIC0OI1JY9YoBHIl
	v/5sZnexK+8QeGu/EhAy6hAP6UzsZvGZP/cpF+TOCf4sWcCoOCzHCblTUrqlrbeVsFS0LGnsMi9
	mKFrNE9f+lmiVkgUr2hD2cXt1EKmFYTdy/zKclV9J62KLBg7P+H9oYEo9tVIXSLcXqhpohV+5Ph
	k01cM8c/larHamPBJmxF2TeyGgS7jbvYxiZJEHzJzIP971/UlmY71d6mr6kZxwX1rbl/vt6sJun
	5NWEiTv1VX+fX4AbgyvFqz673BXgADo9elp/xiKwGs1VI9rv5CL3R61IoFxCg3gXGRDA==
X-Received: by 2002:a17:902:f693:b0:2e9:5b20:1c2b with SMTP id d9443c01a7336-2e9a682f478mr79240345ad.5.1792467842240;
        Mon, 19 Oct 2026 20:44:02 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14caa857sm8143885ad.12.2026.10.19.20.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:44:01 -0700 (PDT)
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
Subject: [PATCH v3 1/2] ocfs2: snapshot dentry names in file-operation traces
Date: Tue, 20 Oct 2026 11:43:51 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
References: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
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
dentry name and length to the shared ocfs2__file_ops event class. A
file reference pins the dentry, but not the external allocation backing
an individual name. The event needs those bytes when sizing its
__string field and when copying the string into the trace record.

With the relevant event enabled, a caller can be preempted after
evaluating its name argument. A concurrent long-to-short rename of
the same dentry can replace and reclaim the external name before
the trace callback uses it, provided no other snapshot retains it:

  File-operation caller                Renamer
  ---------------------                -------
  load d_name.name
  <preempted>
                                       vfs_rename()
                                         ocfs2_rename()
                                           ocfs2_dentry_move()
                                             d_move()/copy_name()
                                       release rename name snapshot
                                       RCU reclamation completes
  trace callback sizes/copies
    through the old name pointer

The pointer argument is evaluated before the trace wrapper protects
probe execution, so that protection does not cover the old name
across this window. Inline names and separately read lengths can also
change while the event is being recorded.

Take a dentry name snapshot around each of these five trace calls and
pass both the string and its length from the snapshot. Inline names
are copied and external names stay referenced until the trace call
finishes. Check each event-enabled flag before taking a snapshot so
disabled tracing does not incur snapshot work. The trace event class
and its format stay unchanged.

The report below is from the read path; the other four call sites
have the same unprotected name argument.

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
 fs/ocfs2/file.c | 79 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d6e977ba6565..3c4637b32c09 100644
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
@@ -2392,11 +2405,17 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
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
@@ -2542,11 +2561,17 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	int direct_io = iocb->ki_flags & IOCB_DIRECT ? 1 : 0;
 	int nowait = iocb->ki_flags & IOCB_NOWAIT ? 1 : 0;
 
-	trace_ocfs2_file_read_iter(inode, filp, filp->f_path.dentry,
-			(unsigned long long)OCFS2_I(inode)->ip_blkno,
-			filp->f_path.dentry->d_name.len,
-			filp->f_path.dentry->d_name.name,
-			to->nr_segs);	/* GRRRRR */
+	if (trace_ocfs2_file_read_iter_enabled()) {
+		struct dentry *dentry = filp->f_path.dentry;
+		struct name_snapshot name;
+
+		take_dentry_name_snapshot(&name, dentry);
+		trace_ocfs2_file_read_iter(inode, filp, dentry,
+					   OCFS2_I(inode)->ip_blkno,
+					   name.name.len, name.name.name,
+					   to->nr_segs);
+		release_dentry_name_snapshot(&name);
+	}
 
 
 	if (!inode) {
@@ -2624,11 +2649,17 @@ static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
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

