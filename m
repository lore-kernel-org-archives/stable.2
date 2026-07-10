Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CC407569
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723754; cv=none; b=Cc4PE6zR/IY7kzSTFrNLa7e7jSfI292F89t7Fu/G9ByK7OiPCPpbNtesBQp6XJ2d4oYYAyS/YPnemX/hkjQLvjgwAoYgBKcr6u0COIEbS/8MZoIHOlxeJgoLaCHgOWVqOGpJP0afPJxbhcimUbHltmgPwZyYJQKwW8Qxgh/5HXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723754; c=relaxed/simple;
	bh=RoTrQNAhjijjxjz8QLC9hr+IRo+isuz0jRyjUBA43DQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcHlmO4gZJYxun+9VfcFzAFt+LqSbaUd7DaCLRuQZhtMfZfi9g6ov5otO+Q+lOln5WhBk+TOFSrzWee0YbxdkRUyfD4+nMcI0d3ffc94SkLf6o3Nxy3kcryvNW9Ngm2AZ5q/+mNDZqjA9HuVa8/3Xw/RW257DzGEYi1XH0ncUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W6bM1rRL; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W6bM1rRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783723753; x=1815259753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IwI4uz+WfRpjV0aFIUyhlHeYWbfOGsS9Lftxs9VMhxU=;
  b=W6bM1rRLkRBqFNFSWSrVXGOZrkjlGs5XxKTYzbcrq3AVVn8nLJ2Oo8EJ
   w7hihnOx80gVax6bi25dQjPXhy6UQiUiF9MlTONqgpwlD3puvnctaajnD
   89MyFWMGPDVaKgzJp+thFWRz8slOXCKzu0bN638SaHJ7MDBzjU3SZxcAR
   jzTW/NPhkSYjdUqBN8GUEfIP7+/SbVtYnuAtNbRXQk9juX0FXgQ/ys14v
   S4ht6WovCt0xEX+RX1XftRBe7kaFWaN+yssCN/NdgNeisVj0luQ1EYuX0
   GisLpmgEXTvbn0DEwFH+79woSHDBR5igvN3cctJ3nWugJ/NyuGbU3jfcL
   w==;
X-CSE-ConnectionGUID: r5GXHeQrTCicy6j1+c1kBg==
X-CSE-MsgGUID: vJVZru1gRCiLz5YjMCqyZw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23486973"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 22:49:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:2616]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525] with esmtp (Farcaster)
 id 91575453-a2e4-4f77-8070-3c7c87c9bfb3; Fri, 10 Jul 2026 22:49:12 +0000 (UTC)
X-Farcaster-Flow-ID: 91575453-a2e4-4f77-8070-3c7c87c9bfb3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 22:49:12 +0000
Received: from dev-dsk-mkbund-2b-ce767ba1.us-west-2.amazon.com (10.169.40.81)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 22:49:12 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Edward Adam Davis <eadavis@qq.com>,
	<syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com>, Chen Ridong
	<chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.12.y] sched/psi: fix race between file release and pressure write
Date: Fri, 10 Jul 2026 22:48:45 +0000
Message-ID: <20260710224845.3892042-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit a5b98009f16d8a5fb4a8ff9a193f5735515c38fa ]

A potential race condition exists between pressure write and cgroup file
release regarding the priv member of struct kernfs_open_file, which
triggers the uaf reported in [1].

Consider the following scenario involving execution on two separate CPUs:

   CPU0					CPU1
   ====					====
					vfs_rmdir()
					kernfs_iop_rmdir()
					cgroup_rmdir()
					cgroup_kn_lock_live()
					cgroup_destroy_locked()
					cgroup_addrm_files()
					cgroup_rm_file()
					kernfs_remove_by_name()
					kernfs_remove_by_name_ns()
 vfs_write()				__kernfs_remove()
 new_sync_write()			kernfs_drain()
 kernfs_fop_write_iter()		kernfs_drain_open_files()
 cgroup_file_write()			kernfs_release_file()
 pressure_write()			cgroup_file_release()
 ctx = of->priv;
					kfree(ctx);
 					of->priv = NULL;
					cgroup_kn_unlock()
 cgroup_kn_lock_live()
 cgroup_get(cgrp)
 cgroup_kn_unlock()
 if (ctx->psi.trigger)  // here, trigger uaf for ctx, that is of->priv

The cgroup_rmdir() is protected by the cgroup_mutex, it also safeguards
the memory deallocation of of->priv performed within cgroup_file_release().
However, the operations involving of->priv executed within pressure_write()
are not entirely covered by the protection of cgroup_mutex. Consequently,
if the code in pressure_write(), specifically the section handling the
ctx variable executes after cgroup_file_release() has completed, a uaf
vulnerability involving of->priv is triggered.

Therefore, the issue can be resolved by extending the scope of the
cgroup_mutex lock within pressure_write() to encompass all code paths
involving of->priv, thereby properly synchronizing the race condition
occurring between cgroup_file_release() and pressure_write().

And, if an live kn lock can be successfully acquired while executing
the pressure write operation, it indicates that the cgroup deletion
process has not yet reached its final stage; consequently, the priv
pointer within open_file cannot be NULL. Therefore, the operation to
retrieve the ctx value must be moved to a point *after* the live kn
lock has been successfully acquired.

In another situation, specifically after entering cgroup_kn_lock_live()
but before acquiring cgroup_mutex, there exists a different class of
race condition:

CPU0: write memory.pressure               CPU1: write cgroup.pressure=0
===========================		  =============================

kernfs_fop_write_iter()
 kernfs_get_active_of(of)
 pressure_write()
   cgroup_kn_lock_live(memory.pressure)
     cgroup_tryget(cgrp)
     kernfs_break_active_protection(kn)
     ... blocks on cgroup_mutex

                                     	  cgroup_pressure_write()
                                     	  cgroup_kn_lock_live(cgroup.pressure)
                                     	  cgroup_file_show(memory.pressure, false)
                                     	    kernfs_show(false)
                                     	      kernfs_drain_open_files()
                                     	        cgroup_file_release(of)
                                     	          kfree(ctx)
                                     	            of->priv = NULL
                                     	  cgroup_kn_unlock()

   ... acquires cgroup_mutex
   ctx = of->priv;        // may now be NULL
   if (ctx->psi.trigger)  // NULL dereference

Consequently, there is a possibility that of->priv is NULL, the pressure
write needs to check for this.

Now that the scope of the cgroup_mutex has been expanded, the original
explicit cgroup_get/put operations are no longer necessary, this is
because acquiring/releasing the live kn lock inherently executes a
cgroup get/put operation.

[1]
BUG: KASAN: slab-use-after-free in pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
Call Trace:
 pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
 cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4311
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352

Allocated by task 9352:
 cgroup_file_open+0x90/0x3a0 kernel/cgroup/cgroup.c:4256
 kernfs_fop_open+0x9eb/0xcb0 fs/kernfs/file.c:724
 do_dentry_open+0x83d/0x13e0 fs/open.c:949

Freed by task 9353:
 cgroup_file_release+0xd6/0x100 kernel/cgroup/cgroup.c:4283
 kernfs_release_file fs/kernfs/file.c:764 [inline]
 kernfs_drain_open_files+0x392/0x720 fs/kernfs/file.c:834
 kernfs_drain+0x470/0x600 fs/kernfs/dir.c:525

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=33e571025d88efd1312c
Tested-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3876,33 +3876,41 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, enum psi_res res)
 {
-	struct cgroup_file_ctx *ctx = of->priv;
+	struct cgroup_file_ctx *ctx;
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
+	ssize_t ret = 0;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
 
-	cgroup_get(cgrp);
-	cgroup_kn_unlock(of->kn);
+	ctx = of->priv;
+	if (!ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
 	/* Allow only one trigger per file descriptor */
 	if (ctx->psi.trigger) {
-		cgroup_put(cgrp);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock;
 	}
 
 	psi = cgroup_psi(cgrp);
 	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
-		cgroup_put(cgrp);
-		return PTR_ERR(new);
+		ret = PTR_ERR(new);
+		goto out_unlock;
 	}
 
 	smp_store_release(&ctx->psi.trigger, new);
-	cgroup_put(cgrp);
+
+out_unlock:
+	cgroup_kn_unlock(of->kn);
+	if (ret)
+		return ret;
 
 	return nbytes;
 }
