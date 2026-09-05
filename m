Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15E3016E7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573030; cv=none; b=Uqkh1E2KJrZiIQtVhUnatE0MAyrdVs0T116fRTaXboZAXEDmwDyRtztnPEl7vwnmdQZ9c+X+ANllCrhnaAosrw86OFFYw+Mmabj37XvUlopxYOjDeSxuEgYiSO1DekWp+H9u1IciIDOHF8Ntvd9H3ANRiWSSaSxrvlwqWgykVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573030; c=relaxed/simple;
	bh=Y7QlnzYiiMll+yUXt/RNqa8nuY/WF3fEAVRo6s+IdSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyuBkKj7eot8dcz2KJJp+gBkI+fxlBgTYUfLiUKOUcxRxtJt3y849M5SrppbLzEhul7DGzby7LcsrfhLHYH7eAgFs8jVu0jTb7dfVko3r9lkv0LW49p9dbC6d8G+1UK1RDDDP1y6Ljt8NzyfgM7Z2Nq07Xuu9lzFMFbr8MozZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No/7CTEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No/7CTEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC4F1F00A3D;
	Sat,  5 Sep 2026 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573029;
	bh=UFgP+essBHoD2sK5+cZv1OXN/AorQpfC9egBWto4RI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=No/7CTEMVLWQq3qT3x8swNp1k+uw5rKwJqfTHjsuFyF7TjfSDQ8oN6fg6lo7k4nGr
	 MKwNRLXAA4ZzQf9dql/rtkRwnick3RBSiHlT3qWS9t66zJphzt0xbqo9CmtVv7H1vP
	 VViTxYuYVRzSSyIs5x6BlX9iS2F4hmyuayK8qztGa7uMc0HupaqrFIx1IXXl+QWq5a
	 re28QGk7SeMn37AzWC4nuvy643VIdSQHKDS7/3vy7j+cCNDrQviA4qBzZM5dF5lOuI
	 85MHh9vM8hc9jHZTAf4MEAG4eT+fEBe8GKQ1aFY1OK0+CjQd0LhbkPSDrBfMFQrEjW
	 T6bXbsW7anMfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Date: Fri,  4 Sep 2026 21:50:27 -0400
Message-ID: <20260905015027.1808554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-limpness-basis-79a4@gregkh>
References: <2026090303-limpness-basis-79a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ adapted nlmsvc_ops protection to 6.12’s __be32 fopen API and existing nlm_close_files() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c             |  4 +--
 fs/lockd/svc4proc.c        |  4 +--
 fs/lockd/svcproc.c         |  4 +--
 fs/lockd/svcsubs.c         | 56 ++++++++++++++++++++++++++++----------
 fs/nfsd/lockd.c            |  6 ++--
 include/linux/lockd/bind.h | 12 ++++++--
 6 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 4ec22c2f2ea3c..87f20d1edb2c2 100644
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
 		svc_recv(rqstp);
 	}
-	if (nlmsvc_ops)
+	if (rcu_access_pointer(nlmsvc_ops))
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
 	cancel_delayed_work_sync(&ln->grace_period_end);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 3f633bb24623a..ea3b689f8b93a 100644
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
index 8cda2aba82d25..44da63392a09d 100644
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
index 1a97f69397c00..396436eac8e22 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -86,12 +86,24 @@ int lock_to_openmode(struct file_lock *lock)
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
+	module_put(ops->owner);
 	if (nfserr)
 		dprintk("lockd: open failed (error %d)\n", nfserr);
 	return nfserr;
@@ -159,6 +171,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	goto out_unlock;
 }
 
+/*
+ * Release the struct file references held by a nlm_file.
+ */
+static void nlm_close_files(struct nlm_file *file)
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
@@ -168,10 +207,7 @@ nlm_delete_file(struct nlm_file *file)
 	nlm_debug_print_file("closing file", file);
 	if (!hlist_unhashed(&file->f_list)) {
 		hlist_del(&file->f_list);
-		if (file->f_file[O_RDONLY])
-			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
-		if (file->f_file[O_WRONLY])
-			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
+		nlm_close_files(file);
 		kfree(file);
 	} else {
 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
@@ -286,14 +322,6 @@ nlm_file_inuse(struct nlm_file *file)
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
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 6b042218668b8..e933788e7a350 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -88,6 +88,7 @@ nlm_fclose(struct file *filp)
 }
 
 static const struct nlmsvc_binding nfsd_nlm_ops = {
+	.owner		= THIS_MODULE,
 	.fopen		= nlm_fopen,		/* open file for locking */
 	.fclose		= nlm_fclose,		/* close file */
 };
@@ -96,11 +97,12 @@ void
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
index c53c81242e727..e25943e485c5c 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -21,11 +21,17 @@
 struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
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
@@ -33,7 +39,7 @@ struct nlmsvc_binding {
 	void			(*fclose)(struct file *);
 };
 
-extern const struct nlmsvc_binding *nlmsvc_ops;
+extern const struct nlmsvc_binding __rcu *nlmsvc_ops;
 
 /*
  * Similar to nfs_client_initdata, but without the NFS-specific
-- 
2.53.0

