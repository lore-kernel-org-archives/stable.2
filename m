Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D584431A37
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972330; cv=none; b=VkGXYsBeUvuyHhEtNY/AfxyJ2hP6r/QWEUtRPrMhOZ7Y5FyTHg7UvBp1uPhUjFx7erYVVqYWIPVBVE5Ytb2FrMZH159lwA0P52FFgfMWkSffrMw3SdQ03uY0d/92bgzDVHPqUz7OoLogiS3HRXMjrAMCzJmk+g15G//shbZpHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972330; c=relaxed/simple;
	bh=UZfpo+dXr8Pw4qyJ6Jtt0uo9zyIAQ2tVzSrfKl6ZIUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V8tu4NMy48O76i3cDvYbwy2Hw3le5O3/mrZJdJFs819kg8NgZRKLcaWxSVl5KQOgg2ZCJg7LMl7CR15OWvnI8LztXa+7mgEeMCNMvqfqcsxIX2w1ssob4GkZ2mfETxCEJ56lbRwv9Fz36UOCbOdAdTS2u/8vaf6EgSXxyJdOR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyNsSujS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyNsSujS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081C91F00AC4;
	Mon, 17 Aug 2026 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972326;
	bh=R5H+f05RArzpiO5OzGGE+F/QJta+GL/VUuN7DUH/ljs=;
	h=Subject:To:Cc:From:Date;
	b=yyNsSujSCCFGgM0vvY5+t8lm7z2VAOX/HIrjQ5qJbtRw0eR/pi+FhJ/7eryZZSUYv
	 JNVO5urpymj/4Jd8OH7xN6DYroP/TnWgwcBS45BxoooUy1D114RWCJ2XZwP5VKx4Tq
	 +4gtG0Suz7dbW1qvB+heXVVNbJvk47sK2ipRzBBM=
Subject: FAILED: patch "[PATCH] sched_ext: Take cgroup_lock() first in scx_cgroup_lock()" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 15:00:15 +0200
Message-ID: <2026081715-muscular-drizzly-bfad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5f8b69642d18e1f3e11996707842ac530444e959
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081715-muscular-drizzly-bfad@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f8b69642d18e1f3e11996707842ac530444e959 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 16 Jul 2026 10:44:02 -1000
Subject: [PATCH] sched_ext: Take cgroup_lock() first in scx_cgroup_lock()

scx_cgroup_lock() write-locks scx_cgroup_ops_rwsem and then takes
cgroup_lock(), which can deadlock through kernfs:

  scx enable/disable         cgroup rmdir           cpu.weight write
  ------------------         ------------           ----------------
                             cgroup_lock()
  percpu_down_write(rwsem)
  cgroup_lock()
                                                    kernfs_get_active()
                                                    percpu_down_read(rwsem)
                             kernfs_drain()

The enable path waits for the rmdir to release cgroup_mutex. The rmdir,
deactivating the cpu controller's files, waits in kernfs_drain() for the
write's active reference. The write, in scx_group_set_weight(), waits for
the rwsem behind the pending writer.

Take cgroup_lock() first. The set_* paths take no cgroup locks inside the
read side, so a pending write-lock then only waits for read sections that
always run to completion, and no dependency from the rwsem back to
cgroup_mutex remains.

Fixes: a5bd6ba30b33 ("sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations")
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 46f135bddd46..58898cd0727b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4580,20 +4580,25 @@ static struct cgroup *root_cgroup(void)
 	return &cgrp_dfl_root.cgrp;
 }
 
+/*
+ * cgroup_lock() must nest outside the rwsem write side: a writer waiting
+ * for cgroup_mutex deadlocks with cgroup teardown, which holds it while
+ * draining a set_* file write blocked on the rwsem behind the writer.
+ */
 static void scx_cgroup_lock(void)
 {
+	cgroup_lock();
 #ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_down_write(&scx_cgroup_ops_rwsem);
 #endif
-	cgroup_lock();
 }
 
 static void scx_cgroup_unlock(void)
 {
-	cgroup_unlock();
 #ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_up_write(&scx_cgroup_ops_rwsem);
 #endif
+	cgroup_unlock();
 }
 #else	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 static inline struct cgroup *root_cgroup(void) { return NULL; }

