Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41A3859DA
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615355; cv=none; b=TNRw/yS97IA2hUgFtN0/ZIV1/h3kO6LPxuBXbKnjQOrZOZk6nWIwNBqG5KJj/BPnOmX1wH0m6GQDMKclbEnhBYvVLG73JCYAAYzY3+yxpUolplKOcKCAm6pZooQ19/EepvNhj4XRKyblB2lK0TZXOeblM/PZjCsVg5xgJGJI/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615355; c=relaxed/simple;
	bh=VeNa2rWecu+wKeAZbe68Hc2zT5XiwNRQP0fHyGJjYKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKReZE4D6oIGoj0e08nz9AzoxPPumIRdF8qTM476CqOORfmP4qcRyqH+Ny/9qY1SwMy7tXOAtIlyqP66a8KkW0U0O1aUAiatHBXnYnt2AA72gTXQjx2hNYucg+ckl0/EIgoiPHU8i8gNknbp2MTgSt37ZFikmsHYwMBxNHqWNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBUe7O5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBUe7O5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21A61F00A3D;
	Sat,  5 Sep 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788615341;
	bh=qHwfc2OugyBIRnjvKRIZ6GXutaWyj61ekmq2D+VkHIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBUe7O5Y9RDWZ5gk48A4Kl6ZdYWTlWSwzZ7PTW+GLyXT6raw9ee8X29+eAR4Xkmuw
	 EOi842Myw6/KObM7V++KUi//4+3DHxrjJTLiKH9Nqy+rODiv80yUl29EhrZf7hki3X
	 oGyFVkfZEnT7zMPlX4you6N4ACW7nPFCe+hMr7YCtlxF6hbpOQcjX71GC+04aandOm
	 i1WzxlxqiHWLXerGR1gQBPz7ReMZSahhOwkbI7bAr4aZwLExAKuk5UxxNCbzM54Mf8
	 4eDVNbdimCbb3s/vFbhaL9TfQCzF8DiYk1oqk7kXUu/38VprScmQBNYK7d3dXjZxhB
	 TJgxKl/VYJKRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Date: Sat,  5 Sep 2026 09:35:39 -0400
Message-ID: <20260905133539.65623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-dubiously-secluding-9957@gregkh>
References: <2026090305-dubiously-secluding-9957@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 641e5e20852359b8c31149be4598884e30652f60 ]

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
[ adapted lockd callback lifetime handling to the older __be32 interface and dual file-close paths. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c             |  6 ++--
 fs/lockd/svc4proc.c        |  4 +--
 fs/lockd/svcproc.c         |  4 +--
 fs/lockd/svcsubs.c         | 59 ++++++++++++++++++++++++++++----------
 fs/nfsd/lockd.c            |  6 ++--
 include/linux/lockd/bind.h | 12 ++++++--
 6 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index c33f78513f00f..1905e7a6b9162 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -49,7 +49,7 @@
 
 static struct svc_program	nlmsvc_program;
 
-const struct nlmsvc_binding	*nlmsvc_ops;
+const struct nlmsvc_binding __rcu *nlmsvc_ops;
 EXPORT_SYMBOL_GPL(nlmsvc_ops);
 
 static DEFINE_MUTEX(nlmsvc_mutex);
@@ -113,7 +113,7 @@ static void set_grace_period(struct net *net)
 
 static void restart_grace(void)
 {
-	if (nlmsvc_ops) {
+	if (rcu_access_pointer(nlmsvc_ops)) {
 		struct net *net = &init_net;
 		struct lockd_net *ln = net_generic(net, lockd_net_id);
 
@@ -175,7 +175,7 @@ lockd(void *vrqstp)
 		svc_process(rqstp);
 	}
 	flush_signals(current);
-	if (nlmsvc_ops)
+	if (rcu_access_pointer(nlmsvc_ops))
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
 	cancel_delayed_work_sync(&ln->grace_period_end);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 28ba7b1460aa4..bb5653f4bf2e3 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -29,7 +29,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return nlm_lck_denied_nolocks;
 
 	if (lock->lock_start > OFFSET_MAX ||
@@ -487,7 +487,7 @@ nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm_res *argp = rqstp->rq_argp;
 
-        if (!nlmsvc_ops)
+        if (!rcu_access_pointer(nlmsvc_ops))
                 return rpc_success;
 
         dprintk("lockd: GRANTED_RES   called\n");
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 1a44597636441..bf1c22028cf04 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -59,7 +59,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return nlm_lck_denied_nolocks;
 
 	/* Obtain host handle */
@@ -521,7 +521,7 @@ nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm_res *argp = rqstp->rq_argp;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return rpc_success;
 
 	dprintk("lockd: GRANTED_RES   called\n");
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e64e0110f66b5..e007feeea059f 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/file.h>
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/in.h>
@@ -86,14 +87,26 @@ int lock_to_openmode(struct file_lock *lock)
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
+	const struct nlmsvc_binding *ops;
 	struct file **fp = &file->f_file[mode];
 	__be32	nfserr;
 
-	if (*fp)
+	rcu_read_lock();
+	ops = rcu_dereference(nlmsvc_ops);
+	if (!ops || !try_module_get(ops->owner)) {
+		rcu_read_unlock();
+		return nlm_lck_denied_nolocks;
+	}
+	rcu_read_unlock();
+
+	if (*fp) {
+		module_put(ops->owner);
 		return 0;
-	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
+	}
+	nfserr = ops->fopen(rqstp, &file->f_handle, fp, mode);
 	if (nfserr)
 		dprintk("lockd: open failed (error %d)\n", nfserr);
+	module_put(ops->owner);
 	return nfserr;
 }
 
@@ -159,6 +172,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
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
@@ -168,10 +208,7 @@ nlm_delete_file(struct nlm_file *file)
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
@@ -286,14 +323,6 @@ nlm_file_inuse(struct nlm_file *file)
 	return 0;
 }
 
-static void nlm_close_files(struct nlm_file *file)
-{
-	if (file->f_file[O_RDONLY])
-		nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
-	if (file->f_file[O_WRONLY])
-		nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
-}
-
 /*
  * Loop over all files in the file table.
  */
@@ -324,7 +353,7 @@ nlm_traverse_files(void *data, nlm_host_match_fn_t match,
 			if (list_empty(&file->f_blocks) && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
 				hlist_del(&file->f_list);
-				nlm_close_files(file);
+				nlm_release_files(file);
 				kfree(file);
 			}
 		}
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index b02886f38925f..35b2a0541dc44 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -79,6 +79,7 @@ nlm_fclose(struct file *filp)
 }
 
 static const struct nlmsvc_binding nfsd_nlm_ops = {
+	.owner		= THIS_MODULE,
 	.fopen		= nlm_fopen,		/* open file for locking */
 	.fclose		= nlm_fclose,		/* close file */
 };
@@ -87,11 +88,12 @@ void
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
index 3bc9f7410e213..2fef35577f019 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -20,11 +20,17 @@
 /* Dummy declarations */
 struct svc_rqst;
 struct rpc_task;
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
+	struct module		*owner;
 	__be32			(*fopen)(struct svc_rqst *,
 						struct nfs_fh *,
 						struct file **,
@@ -32,7 +38,7 @@ struct nlmsvc_binding {
 	void			(*fclose)(struct file *);
 };
 
-extern const struct nlmsvc_binding *nlmsvc_ops;
+extern const struct nlmsvc_binding __rcu *nlmsvc_ops;
 
 /*
  * Similar to nfs_client_initdata, but without the NFS-specific
-- 
2.53.0

