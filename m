Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897133E9C08
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557690; cv=none; b=Zh6s4LeDkP8h9ZhMpFJ5WOrbL0kLHV21qj2pvDf6N4cYbcb/pPbuZv5vHollW2Kj/a6NRPAXh6FI6NhgS9b+UG88ZJFrAESazHqqoJTC7m3dshcbeVB/iec2pOcd0m3bEf34se28mse1erhDF2eOQnzfCLHIn+rTC8v7bTq3ha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557690; c=relaxed/simple;
	bh=PYsuzSGVo2uL3FwhAraWjfsYDWpM7uMaiauyFN3IE3k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kMEMsngNhomCuwEan4R0TF3yPu45Vj1AFCbgMuZ8d7/26fstHiwEGD9pKiESo9BQhtLrti4GeWhZ8J1iWYzP9iJmg+stNkB43uDdFH3Sm+zHDXs8DQH11o4QwR7sanqKYzIEYYpVvFDykQxbVCRHjNxQvAP6Z45st8brA+T6TF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ByAKslbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ByAKslbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98EF1F000E9;
	Mon, 20 Jul 2026 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557689;
	bh=Xb6oyVWsLY+U43M+D3avWERzlUqjT5HNRg/D4c/l2po=;
	h=Subject:To:Cc:From:Date;
	b=ByAKslbBeaK4EL5deCIoFft2P7g9uTdshoGNaJaBlLBLvvE6MxWlvA7Tb6Zz3Vc1o
	 75s4Sj+IJmMQHWjennRXxaJiyuPUnMka8avi2X2BoFBeTz04HvcmWAFj/ZXIxqcthP
	 kNgQtrQpVkDg5xg9/BSI5n6emUH7wRhXHu4bpLB0=
Subject: FAILED: patch "[PATCH] mips: sched: Fix CPUMASK_OFFSTACK memory corruption" failed to apply to 5.10-stable tree
To: atomlin@atomlin.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:28:00 +0200
Message-ID: <2026072000-riveter-snowsuit-903d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 98e37db4a34d3af3fb2f4648295c25b5e40b20e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-riveter-snowsuit-903d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98e37db4a34d3af3fb2f4648295c25b5e40b20e3 Mon Sep 17 00:00:00 2001
From: Aaron Tomlin <atomlin@atomlin.com>
Date: Tue, 26 May 2026 10:16:51 -0400
Subject: [PATCH] mips: sched: Fix CPUMASK_OFFSTACK memory corruption

This patch addresses a critical memory management flaw. When
CONFIG_CPUMASK_OFFSTACK is enabled, cpumask_var_t is a pointer.
Consequently, sizeof(new_mask) evaluates to the pointer size, causing
copy_from_user() to clobber the mask pointer. Furthermore, the old
logic performed copy_from_user() before allocating the mask.

Fix this by allocating new_mask first. To handle variable-sized user
masks correctly, use cpumask_size() to truncate overly large user masks
or pad undersized masks with zeros before copying the data directly into
the allocated buffer.

Fixes: 295cbf6d63165 ("[MIPS] Move FPU affinity code into separate file.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 10172fc4f627..4fead87d2f43 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -71,11 +71,16 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+	if (len < cpumask_size())
+		cpumask_clear(new_mask);
+	else if (len > cpumask_size())
+		len = cpumask_size();
+	if (copy_from_user(new_mask, user_mask_ptr, len)) {
+		retval = -EFAULT;
+		goto out_free_new_mask;
+	}
 
 	cpus_read_lock();
 	rcu_read_lock();
@@ -84,7 +89,8 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!p) {
 		rcu_read_unlock();
 		cpus_read_unlock();
-		return -ESRCH;
+		retval = -ESRCH;
+		goto out_free_new_mask;
 	}
 
 	/* Prevent p going away */
@@ -95,13 +101,9 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
 	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
-		goto out_free_new_mask;
+		goto out_free_cpus_allowed;
 	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
@@ -142,13 +144,13 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	}
 out_unlock:
 	free_cpumask_var(effective_mask);
-out_free_new_mask:
-	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
 out_put_task:
 	put_task_struct(p);
 	cpus_read_unlock();
+out_free_new_mask:
+	free_cpumask_var(new_mask);
 	return retval;
 }
 

