Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECA350298
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083511; cv=none; b=Zeks7jCZwTxjH074tU/1gTSXijTHvtmstEvwq+HIYSXBljX+Tjupqt7e+3xrd7XTzS5xO5U4pB1VvuJFD51FbKH6dDqJxH497Zwf4zwCTghyoT79mqh7BoAxIuHElW+Ixt8BGCllPYcrATWR55WWSqwww3/vru5SJeuDqjYdSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083511; c=relaxed/simple;
	bh=ePhtOs88Q43lRENY8bKysVGSJOFLH6Ix3l4qabz8mKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M3DiRojZaW351aHY7Ozk0ajMXd4GHE9RYVJGfCtaSoLYa/RhzScLeTKlGWFU1XWJEyRM645EObKtFZFhiGUPZjncQcw2YRXFetbYwDgqMmnUP4PAgM5oqp+ZKx/kUCYHfMbfVNqzK612De2zycmHBRrVLwZ4lYHtcpwFRbiY2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUPbZ9t7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUPbZ9t7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so315880a91.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083494; x=1792688294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvowUguha7kXmliduc5jiTqRimm07Y+qQJIE46iFsU0=;
        b=pUPbZ9t7C88Sy5tbXV2FlVm5sitXqfYQj7an9mX4IEVwPzVeCsfsC/dBJWTk4l/Qy8
         Q1nMiggnASOZ4E0Yc+1hfVswy+jE4P1YVlZzvK9oqWpIr6B6x/N435FApgScVG7jq3X4
         IRYZ22Vgbsh8oYtMcC9KHtXjwpzvoUDV5mC3C/5Q8Pn1Mdyf6fY97RvXB3HoTmQCdmLa
         Nlyi2nkJL0OfujHM2jEtd9xeKMeQ7+Mx15vW2Kuw/X9smB0Ymc+an3Tcjp4RqBQsUt/Q
         0au3WfD5fsuDoFzvU66BHVjyZqcDnKxRwpnCKEPMtV1YYAvgKqAqOXnPJbYPjqR4vZVA
         u18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083494; x=1792688294;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tvowUguha7kXmliduc5jiTqRimm07Y+qQJIE46iFsU0=;
        b=Imm+ckIHetuPXPeUt8ySVMvvCWKijrhAUyKzUa5dfTbQpLZ9LWeRl5I6/iWZRXQt5r
         e0u5KsSa5dQ70G93XhpbikSpuCIL/bA5PPqJmi/PdZ23wV+mN0H5ij2W36Y0KJQ/sbQF
         yMwyPHDlhMP1bXG6GojXi14YiKba1UpVw5kVAR0ypVzkPzYcrtVelo3I2bFmc0jGPyG6
         cNzpc9zJwRcOHJ8PSHv6jOsOogQ4sdGiIfTwXHoD9SFJAPTfzPJ26HR5jI4S1nqU+Ffy
         P9u/xqfCsmIDT9kp6+h/EJ4dHyQZXAgzh/ied9UYkhgqP0yLQJmyMUbMwcy5NdCScIVU
         fFYg==
X-Forwarded-Encrypted: i=1; AKwUvByWB+1c3aLUKlh1drBlMirEbv7UeJfAyubQgXMoxzkzqB1cS/clbB5ApU2RIMC5EmM3oWkNQwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+vwEWuHbByUoZTBuhaBgDMkCV2iq4Whyv9rWYyo/m9HueyDs8
	V9yX4UAwbYu88UMEn58AkLkZZVQf108GUr/p9sQpGZ8BxnkEplKfsoxz
X-Gm-Gg: AYBFou0aY+smztcWFelynm+Mnp89XGM7ycDM49uE+niLKjqSqem3KTB7RAnoiGlxUOq
	ofifw2ZAA6DmaeJSTpOuWxgO33ty3w7O2g2EPoGS15gqJZaKhrjdfA/CsO/ApFmFlhitrb0KPjE
	oQCW+u/bCH8wo4GQKQg7+wCShEGaigpEgIMFxorZoJlJT+Oem4rap8aPsXuEbJhfTcshV+42eYN
	pmY+v75COhKyDsHUepKVj/4OMOc027F5vki+u2tzfzDfW9J7pYFPkO/KGdwyHXSGLX13tsRh0cu
	pfT1PEJGw0/NMiR8/kbizwNMObC6ocRY6GcBfWKKZkCKAzXPycKu0BShsuP9du4vQIe8UhR7I5p
	LLzVEDRPMIeighyMvQAlZYKcvJwDLL9SCtIIu1k1zT93/pWg/I0ve4kiS3wVa3Lf9M0Yc6Hv9Aq
	Js5pPMLfSOdzaQH0u5A3HXcOdAxoXLbSdKupROk4N/y/t3VYx1s7mGcn/4i/whV1O6Kw==
X-Received: by 2002:a17:90b:538c:b0:3ac:80dc:f406 with SMTP id 98e67ed59e1d1-3ac80dd0135mr4837406a91.50.1792083494365;
        Thu, 15 Oct 2026 09:58:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635c70393sm1558817a12.18.2026.10.15.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:58:12 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	boyu.mt@taobao.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: stabilize the dentry name while tracing reads
Date: Fri, 16 Oct 2026 00:58:06 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v3-d628f98bfcb6784a0bfb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An open file pins its dentry, but not the external allocation backing
an individual dentry name. ocfs2_file_read_iter() passes d_name.name to
its trace event without holding d_lock or a name snapshot. The event's
__string field needs those bytes for both strlen() sizing and the
subsequent copy.

With the read event enabled, a read of an open long-named file can be
preempted after evaluating the trace argument. A successful concurrent
long-to-short rename of the same dentry can then reclaim that name,
provided no other name snapshot retains it:

  Reader                              Renamer
  ocfs2_file_read_iter()
    load old d_name.name
    <preempted>
                                      vfs_rename()
                                        take_dentry_name_snapshot()
                                        ocfs2_rename()
                                          ocfs2_dentry_move()
                                            d_move()/copy_name()
                                        release_dentry_name_snapshot()
                                      kfree_rcu() reclamation completes
    trace callback calls strlen()
      through the old name pointer

The pointer load precedes the rename, and sizing follows reclamation,
so strlen() reads freed name storage. The tracepoint's SRCU section
protects its probes, and the event callback disables preemption only
after the caller has loaded the name pointer.

Hold d_lock from argument evaluation until the trace call returns,
following the name tracing in ocfs2_find_local_alias(). This prevents
rename from replacing the name while the event sizes and copies it.
Check whether the event is enabled before taking the lock to avoid
adding locking to reads when tracing is disabled.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d6e977ba6565..e2a42257f243 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2542,11 +2542,17 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	int direct_io = iocb->ki_flags & IOCB_DIRECT ? 1 : 0;
 	int nowait = iocb->ki_flags & IOCB_NOWAIT ? 1 : 0;
 
-	trace_ocfs2_file_read_iter(inode, filp, filp->f_path.dentry,
-			(unsigned long long)OCFS2_I(inode)->ip_blkno,
-			filp->f_path.dentry->d_name.len,
-			filp->f_path.dentry->d_name.name,
-			to->nr_segs);	/* GRRRRR */
+	if (trace_ocfs2_file_read_iter_enabled()) {
+		struct dentry *dentry = filp->f_path.dentry;
+
+		spin_lock(&dentry->d_lock);
+		trace_ocfs2_file_read_iter(inode, filp, dentry,
+					   OCFS2_I(inode)->ip_blkno,
+					   dentry->d_name.len,
+					   dentry->d_name.name,
+					   to->nr_segs); /* GRRRRR */
+		spin_unlock(&dentry->d_lock);
+	}
 
 
 	if (!inode) {
