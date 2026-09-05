Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC9533D6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566683; cv=none; b=S5ZMOkj3k4I6yCW41vNbYUe15MwS5HufpM2ZwbCU28IaKHO9bcFgxY2w8HXMtSRXF2aAwH1bhUzGw5i8DPry/uvvmTzhRcKYpHGw4y2cQNa39qf0smXD+xYc7yrOFLlbMVvnhIwmVJkuDu2Py21wSyFNb0zHZgSXyfJd2RLAYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566683; c=relaxed/simple;
	bh=FmHhRrHkDyGeWXrk0AMKjYnNdxq9Elffjz7M2QqIcwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhogO61Ws85MBK0qCNHeow/TQpX/xIePf7zXS5NaLbRBJrYdxzg7ZdHcq8qqpEpYBSEnVxTq1a1guGoQCp1YPEbG66qfPXRqsI2kjgs/1XTcE9t89Of0rBotjZWRzAGg/pjHy9e2N9Z5x+Q/p811EpHBsRfUUCD1eUokntbcPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCTB76tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCTB76tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6500B1F00A3D;
	Sat,  5 Sep 2026 00:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566682;
	bh=5SfL2/xtQB0COtRhJVNqR+cVv1s8cv9rLyzLxVmVSI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCTB76tbp6itvr0qU8daU3RCkTTp0cMmlCmCgqbcSoiCyoI6bLPJZ65Mq4G2UsnCD
	 qHcr3WrTWPVToNAErFDo+LPaDKgk1dQ6NO5T+nxSVdTv4gFs71TQhaJVwAZG9GYCEp
	 vcSHhYx82T4/yAQ1dabPq0t9RPuySEmffuMUGJV2Ffi17psJhNc6MMd0kbRW59kJQx
	 TGkHoqWQFTVwNrNkVTYzTUQn1XaObkD+/3paJ6KUvxt3ThudsBJHvuhBCkl7OOvF7S
	 puRXBTdfSKmLPPxCZq59lsDf3dTce1D+UI2bpfgr2qApO6lJx3PgOitsNdy/ZEjtgG
	 gk/t1zfEO+4zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Date: Fri,  4 Sep 2026 20:04:38 -0400
Message-ID: <20260905000439.1655974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-broker-open-f2ec@gregkh>
References: <2026090339-broker-open-f2ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 518f375c15af724cd89a4ec888dea942bb27f77f ]

nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
info. In the event that fh_getattr fails, it resorts to scraping cached
values out of the inode directly.

Since these attributes are optional, we can just skip providing them
altogether when this happens.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Neil Brown <neilb@suse.de>
Stable-dep-of: b778e0e0a167 ("NFSD: check truncate permission under inode lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/auth.c      | 15 +++++++--------
 fs/nfsd/auth.h      |  2 +-
 fs/nfsd/export.h    |  3 ++-
 fs/nfsd/nfs4state.c |  3 ++-
 fs/nfsd/nfsfh.c     | 29 +++++++++++++----------------
 fs/nfsd/nfsfh.h     |  2 +-
 fs/nfsd/nfsproc.c   |  9 +++++----
 fs/nfsd/vfs.c       | 27 +++++++++++++++++----------
 fs/nfsd/vfs.h       |  4 ++--
 9 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index fdf2aad734709..bcf207bc24f96 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -5,26 +5,26 @@
 #include "nfsd.h"
 #include "auth.h"
 
-int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp)
+int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp)
 {
 	struct exp_flavor_info *f;
 	struct exp_flavor_info *end = exp->ex_flavors + exp->ex_nflavors;
 
 	for (f = exp->ex_flavors; f < end; f++) {
-		if (f->pseudoflavor == rqstp->rq_cred.cr_flavor)
+		if (f->pseudoflavor == cred->cr_flavor)
 			return f->flags;
 	}
 	return exp->ex_flags;
 
 }
 
-int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
+int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 {
 	struct group_info *rqgi;
 	struct group_info *gi;
 	struct cred *new;
 	int i;
-	int flags = nfsexp_flags(rqstp, exp);
+	int flags = nfsexp_flags(cred, exp);
 
 	validate_process_creds();
 
@@ -34,10 +34,10 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 	if (!new)
 		return -ENOMEM;
 
-	new->fsuid = rqstp->rq_cred.cr_uid;
-	new->fsgid = rqstp->rq_cred.cr_gid;
+	new->fsuid = cred->cr_uid;
+	new->fsgid = cred->cr_gid;
 
-	rqgi = rqstp->rq_cred.cr_group_info;
+	rqgi = cred->cr_group_info;
 
 	if (flags & NFSEXP_ALLSQUASH) {
 		new->fsuid = exp->ex_anon_uid;
@@ -91,4 +91,3 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 	abort_creds(new);
 	return -ENOMEM;
 }
-
diff --git a/fs/nfsd/auth.h b/fs/nfsd/auth.h
index dbd66424f600b..8c5031bbbcee2 100644
--- a/fs/nfsd/auth.h
+++ b/fs/nfsd/auth.h
@@ -12,6 +12,6 @@
  * Set the current process's fsuid/fsgid etc to those of the NFS
  * client user
  */
-int nfsd_setuser(struct svc_rqst *, struct svc_export *);
+int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp);
 
 #endif /* LINUX_NFSD_AUTH_H */
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index f73e23bb24a1e..4965e294d1e1c 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -98,7 +98,8 @@ struct svc_expkey {
 #define EX_NOHIDE(exp)		((exp)->ex_flags & NFSEXP_NOHIDE)
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
-int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
+struct svc_cred;
+int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
 
 /*
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f390716ce3ffe..f101cef651476 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6560,7 +6560,8 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 
 	nf = nfs4_find_file(s, flags);
 	if (nf) {
-		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
+		status = nfsd_permission(&rqstp->rq_cred,
+					 fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
 		if (status) {
 			nfsd_file_put(nf);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index e73e9d44f1b0c..d6d5bb0a19a25 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -102,7 +102,7 @@ static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(rqstp, exp);
+	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
 
 	/* Check if the request originated from a secure port. */
 	if (!nfsd_originating_port_ok(rqstp, flags)) {
@@ -113,7 +113,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(rqstp, exp));
+	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
@@ -392,7 +392,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(rqstp, exp, dentry, access);
+	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
@@ -612,7 +612,7 @@ fh_update(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_pre_attrs(struct svc_fh *fhp)
+__be32 fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode;
@@ -620,16 +620,13 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
-		return;
+		return nfs_ok;
 
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
-	}
+	if (err)
+		return err;
+
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
@@ -637,6 +634,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
+	return nfs_ok;
 }
 
 /**
@@ -657,11 +655,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	if (err) {
-		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
+	if (err)
+		return;
+
+	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 40aee06ebd952..242e34bd9b631 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -314,7 +314,7 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 		return time_to_chattr(&stat->ctime);
 }
 
-extern void fh_fill_pre_attrs(struct svc_fh *fhp);
+extern __be32 fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 extern void fh_fill_both_attrs(struct svc_fh *fhp);
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9744443c39652..59b6a2e41a079 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -343,10 +343,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 					 *   echo thing > device-special-file-or-pipe
 					 * by doing a CREATE with type==0
 					 */
-					resp->status = nfsd_permission(rqstp,
-								 newfhp->fh_export,
-								 newfhp->fh_dentry,
-								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
+					resp->status = nfsd_permission(
+						&rqstp->rq_cred,
+						newfhp->fh_export,
+						newfhp->fh_dentry,
+						NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
 					if (resp->status && resp->status != nfserr_rofs)
 						goto out_unlock;
 				}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a69287613479b..54a6191e2cf84 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -419,8 +419,9 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (iap->ia_size < inode->i_size) {
 		__be32 err;
 
-		err = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
-				NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
+		err = nfsd_permission(&rqstp->rq_cred,
+				      fhp->fh_export, fhp->fh_dentry,
+				      NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
 		if (err)
 			return err;
 	}
@@ -552,7 +553,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
-	fh_fill_pre_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err)
+		goto out_unlock;
+
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -581,6 +585,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 						inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
 	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
@@ -796,7 +801,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 
 			sresult |= map->access;
 
-			err2 = nfsd_permission(rqstp, export, dentry, map->how);
+			err2 = nfsd_permission(&rqstp->rq_cred, export,
+					       dentry, map->how);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
@@ -1393,7 +1399,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
+	err = nfsd_permission(&rqstp->rq_cred, fhp->fh_export, dentry,
+			      NFSD_MAY_CREATE);
 	if (err)
 		goto out;
 
@@ -2107,9 +2114,9 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 	return err;
 }
 
-static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
+static int exp_rdonly(struct svc_cred *cred, struct svc_export *exp)
 {
-	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
+	return nfsexp_flags(cred, exp) & NFSEXP_READONLY;
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -2352,8 +2359,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
  * Check for a user's access permissions to this inode.
  */
 __be32
-nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
-					struct dentry *dentry, int acc)
+nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
+		struct dentry *dentry, int acc)
 {
 	struct inode	*inode = d_inode(dentry);
 	int		err;
@@ -2384,7 +2391,7 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 	 */
 	if (!(acc & NFSD_MAY_LOCAL_ACCESS))
 		if (acc & (NFSD_MAY_WRITE | NFSD_MAY_SATTR | NFSD_MAY_TRUNC)) {
-			if (exp_rdonly(rqstp, exp) ||
+			if (exp_rdonly(cred, exp) ||
 			    __mnt_is_readonly(exp->ex_path.mnt))
 				return nfserr_rofs;
 			if (/* (acc & NFSD_MAY_WRITE) && */ IS_IMMUTABLE(inode))
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index dbdfef7ae85bb..219b479dabc70 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -145,8 +145,8 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
 
-__be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
-				struct dentry *, int);
+__be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
+				struct dentry *dentry, int acc);
 
 static inline int fh_want_write(struct svc_fh *fh)
 {
-- 
2.53.0

