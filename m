Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304F4A8A00
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441444; cv=none; b=ozy2hhlzWnK8iItdsjEPFR+eHyqQD9Ed2Q7bx/v5eW51YBaujGHbApo5CHGz5T9alJR25tKCghkxWoPlVJMZ+l3UzX184xPlQ7U8icjyRvJUAA7dRY7/UcNJb7fdc4eO+JZYjDBCwlxLsY+xgj1LOWoC18gYgK9rSYCT4Q1l7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441444; c=relaxed/simple;
	bh=yVjwx976lCQpCrsvAfGv4GHcAeCFTc31okl4Yzhshl0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VbAPwPxklBVWq2DlFxXpbHTOw0Ewx8c63aG03PhdsfJF1zjvxXPwc8gRQFjMZfv5fqSYvrD2nwKyxGtOOiiN+lOHxQv7eHK79uhmhWtlWXYvpS014jUQfjVhnPCyvClF2HcNk6PDqVdo3zUfa6SCKBdA90vm1v/mxyJp0eQqFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0W0ubmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0W0ubmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8351F00A3E;
	Thu,  3 Sep 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441429;
	bh=5MLnprFgNAyfKI32vioDIio3K6V8UK+5cJ/5GwVCL2o=;
	h=Subject:To:Cc:From:Date;
	b=v0W0ubmgY0eZy4e6FoFr4VT7SYAZ0tGsdUkrlYDqIFz2T09EjZVDjMpK/5f6k7XXP
	 OcAF59TZcexb1WJ05cmCPjPRsP909zYs28n6sQpMhc47FiPiLehgiMFf5B/6IlOXN8
	 /QPBXyJ5oTUJ6GbZxh8arjdR/b3C9w2unAUpvwMg=
Subject: FAILED: patch "[PATCH] lockd, nfsd: RCU-protect nlmsvc_ops dispatch" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:06:03 +0200
Message-ID: <2026090303-limpness-basis-79a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 641e5e20852359b8c31149be4598884e30652f60
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090303-limpness-basis-79a4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 641e5e20852359b8c31149be4598884e30652f60 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:59 -0400
Subject: [PATCH] lockd, nfsd: RCU-protect nlmsvc_ops dispatch

nlmsvc_ops is published by nfsd_lockd_init() and cleared by
nfsd_lockd_shutdown() with plain stores, while lockd dereferences
it unguarded from dispatch sites in fs/lockd/svcsubs.c. The pointer
targets nfsd's .rodata and the fopen/fclose callbacks live in nfsd's
.text, so a stale load after rmmod nfsd results in either a NULL
deref or a module-text use-after-free.

Declare nlmsvc_ops as __rcu, publish via rcu_assign_pointer(), clear
via RCU_INIT_POINTER() + synchronize_rcu(). Add a struct module
*owner field to nlmsvc_binding and pin the module across indirect
calls with try_module_get/module_put. When the binding is torn down,
fall back to fput() to avoid leaking struct file references.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-16-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 490551369ef2..ee90e743064a 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -47,7 +47,7 @@
 
 static struct svc_program	nlmsvc_program;
 
-const struct nlmsvc_binding	*nlmsvc_ops;
+const struct nlmsvc_binding __rcu *nlmsvc_ops;
 EXPORT_SYMBOL_GPL(nlmsvc_ops);
 
 static DEFINE_MUTEX(nlmsvc_mutex);
@@ -142,7 +142,7 @@ lockd(void *vrqstp)
 		nlmsvc_retry_blocked(rqstp);
 		svc_recv(rqstp, 0);
 	}
-	if (nlmsvc_ops)
+	if (rcu_access_pointer(nlmsvc_ops))
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
 	cancel_delayed_work_sync(&ln->grace_period_end);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 78e675470c4b..080dffce9d8e 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -128,7 +128,7 @@ nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
 	struct nlm_host *host;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return NULL;
 	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
 	if (!host)
@@ -894,7 +894,7 @@ static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm4_res_wrapper *argp = rqstp->rq_argp;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return rpc_success;
 
 	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 386a881b520f..d410b8c69893 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -133,7 +133,7 @@ nlm3svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
 	struct nlm_host *host;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return NULL;
 	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
 	if (!host)
@@ -924,7 +924,7 @@ static __be32 nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm_res_wrapper *argp = rqstp->rq_argp;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return rpc_success;
 
 	if (nlm_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index d7ada90dc048..e44eb20d3453 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -90,22 +90,35 @@ int lock_to_openmode(struct file_lock *lock)
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
+	const struct nlmsvc_binding *ops;
 	__be32 nlmerr = nlm__int__failed;
 	__be32 deferred = 0;
 	int error;
 	int m;
 
+	rcu_read_lock();
+	ops = rcu_dereference(nlmsvc_ops);
+	if (!ops || !try_module_get(ops->owner)) {
+		rcu_read_unlock();
+		return nlm__int__failed;
+	}
+	rcu_read_unlock();
+
 	for (m = O_RDONLY; m <= O_WRONLY; m++) {
 		struct file **fp = &file->f_file[m];
 
 		if (mode != O_RDWR && mode != m)
 			continue;
-		if (*fp)
+		if (*fp) {
+			module_put(ops->owner);
 			return nlm_granted;
+		}
 
-		error = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
-		if (!error)
+		error = ops->fopen(rqstp, &file->f_handle, fp, m);
+		if (!error) {
+			module_put(ops->owner);
 			return nlm_granted;
+		}
 
 		dprintk("lockd: open failed (errno %d)\n", error);
 		switch (error) {
@@ -122,6 +135,7 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 		}
 	}
 
+	module_put(ops->owner);
 	return deferred ? deferred : nlmerr;
 }
 
@@ -185,6 +199,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	goto out_unlock;
 }
 
+/*
+ * Release the struct file references held by a nlm_file.
+ */
+static void nlm_release_files(struct nlm_file *file)
+{
+	const struct nlmsvc_binding *ops;
+	bool have_ops;
+
+	rcu_read_lock();
+	ops = rcu_dereference(nlmsvc_ops);
+	have_ops = ops && try_module_get(ops->owner);
+	rcu_read_unlock();
+
+	if (have_ops) {
+		if (file->f_file[O_RDONLY])
+			ops->fclose(file->f_file[O_RDONLY]);
+		if (file->f_file[O_WRONLY])
+			ops->fclose(file->f_file[O_WRONLY]);
+		module_put(ops->owner);
+	} else {
+		if (file->f_file[O_RDONLY])
+			fput(file->f_file[O_RDONLY]);
+		if (file->f_file[O_WRONLY])
+			fput(file->f_file[O_WRONLY]);
+	}
+}
+
 /*
  * Delete a file after having released all locks, blocks and shares
  */
@@ -194,10 +235,7 @@ nlm_delete_file(struct nlm_file *file)
 	nlm_debug_print_file("closing file", file);
 	if (!hlist_unhashed(&file->f_list)) {
 		hlist_del(&file->f_list);
-		if (file->f_file[O_RDONLY])
-			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
-		if (file->f_file[O_WRONLY])
-			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
+		nlm_release_files(file);
 		kfree(file);
 	} else {
 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 6fe1325815e0..72a5b499839d 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -92,6 +92,7 @@ nlm_fclose(struct file *filp)
 }
 
 static const struct nlmsvc_binding nfsd_nlm_ops = {
+	.owner		= THIS_MODULE,
 	.fopen		= nlm_fopen,		/* open file for locking */
 	.fclose		= nlm_fclose,		/* close file */
 };
@@ -100,11 +101,12 @@ void
 nfsd_lockd_init(void)
 {
 	dprintk("nfsd: initializing lockd\n");
-	nlmsvc_ops = &nfsd_nlm_ops;
+	rcu_assign_pointer(nlmsvc_ops, &nfsd_nlm_ops);
 }
 
 void
 nfsd_lockd_shutdown(void)
 {
-	nlmsvc_ops = NULL;
+	RCU_INIT_POINTER(nlmsvc_ops, NULL);
+	synchronize_rcu();
 }
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index b614e0deea72..db8207d4059f 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -16,17 +16,23 @@ struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
 struct super_block;
+struct module;
 
-/*
- * This is the set of functions for lockd->nfsd communication
+/**
+ * struct nlmsvc_binding - lockd -> nfsd callback table
+ * @owner:  module that provides this binding.
+ * @fopen:  open a file by NFS file handle on behalf of an NLM request.
+ * @fclose: close a file that was previously opened via @fopen.
+ *          Implementations MUST be semantically equivalent to fput().
  */
 struct nlmsvc_binding {
+	struct module	*owner;
 	int		(*fopen)(struct svc_rqst *rqstp, struct nfs_fh *f,
 				 struct file **filp, int flags);
 	void		(*fclose)(struct file *filp);
 };
 
-extern const struct nlmsvc_binding *nlmsvc_ops;
+extern const struct nlmsvc_binding __rcu *nlmsvc_ops;
 
 /*
  * Similar to nfs_client_initdata, but without the NFS-specific

