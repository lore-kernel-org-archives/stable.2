Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94051C32B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553927; cv=none; b=gphqh6oq2ybB/AMdhgVTy7tvj5RcWzoXwRF4NbvWL1oSYqW+U7oOHG/r174xdyGLR4a3giLCtBZz0iSFNHd9knz6OM50PMo17hWw2BBiZUd8UkR+3bxzUpm9hqaEDba9cy528APQFyNmRJ2M4GU+w4bygf/LwHanpI+v1c6cpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553927; c=relaxed/simple;
	bh=AwSWzI+SmWtNI+RRezAqDa2VOE9A1x0Skj+m4PXmaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWSE6ErR4jACM+YHx8JHsguoJycXqyLqc8U1e5u4+jpGyzyXBEdTSF5fXpAAVBTq18eBNwFKcsVc5is+FW22oxToDJqBOlRz9jmodBfURhF+DEJhzf/F9FV+a+8QxrlGbBI6Ltn5eYppSxesrp6gMBzwqABKhrgAl0eziw6I43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxCP1Uwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxCP1Uwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3741F00A3D;
	Fri,  4 Sep 2026 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553914;
	bh=sfMMRFAOyPzbIKOC6FvZ65lwsHgHAYUWDgKsIvdEBAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxCP1Uwk1MQjFpcN8XoYLMHYhmBxm5zOCp/zn9H+zSDRsuRXDnH43VjZSavFe59yx
	 S1YpBLC4kaVvJIeLfKm6YZhoboZF/coadEBsXow7I8UslMunw8EZ/uTikFLWh7BZtL
	 zh6U5AQeXN6/PMBUatbNQFcM9avs3uYLVNudHYAfUNmCUGv+81kRYNVDDEXFb/mgHB
	 vYNNiUouIf+srAxU/poow4t/u2fctW5CMC1sC2CB3UA+jrIPb97v8bKibFccICi5vg
	 +gS0E4SWCP498JNqNdJjMJX2efjcevnOobiWyNRloEq5s2eDaabMEitRS8aWEln6b8
	 yha2bBggx5XeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: Pass 'cred' instead of 'rqstp' to some functions.
Date: Fri,  4 Sep 2026 16:31:51 -0400
Message-ID: <20260904203152.1546362-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-resolute-antennae-cd2d@gregkh>
References: <2026090339-resolute-antennae-cd2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 9fd45c16f3e3b95b458e049c77f4d7dfef673a52 ]

nfsd_permission(), exp_rdonly(), nfsd_setuser(), and nfsexp_flags()
only ever need the cred out of rqstp, so pass it explicitly instead of
the whole rqstp.

This makes the interfaces cleaner.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: b778e0e0a167 ("NFSD: check truncate permission under inode lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/auth.c      | 14 +++++++-------
 fs/nfsd/auth.h      |  2 +-
 fs/nfsd/export.h    |  3 ++-
 fs/nfsd/nfs4state.c |  3 ++-
 fs/nfsd/nfsfh.c     |  6 +++---
 fs/nfsd/nfsproc.c   |  9 +++++----
 fs/nfsd/vfs.c       | 21 ++++++++++++---------
 fs/nfsd/vfs.h       |  4 ++--
 8 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index e6beaaf4f1700..93e33d1ee8917 100644
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
 
 	/* discard any old override before preparing the new set */
 	revert_creds(get_cred(current_real_cred()));
@@ -32,10 +32,10 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
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
index 4a48b2ad56067..3174fc05bf02a 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -99,7 +99,8 @@ struct svc_expkey {
 #define EX_NOHIDE(exp)		((exp)->ex_flags & NFSEXP_NOHIDE)
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
-int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
+struct svc_cred;
+int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
 __be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
 __be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..586f2677c294c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6605,7 +6605,8 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 
 	nf = nfs4_find_file(s, flags);
 	if (nf) {
-		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
+		status = nfsd_permission(&rqstp->rq_cred,
+					 fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
 		if (status) {
 			nfsd_file_put(nf);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 283c1a60c8460..e41c1efc46997 100644
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
@@ -402,7 +402,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(rqstp, exp, dentry, access);
+	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 36370b957b633..97aab34593ef0 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -331,10 +331,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
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
index 5dc798e89e97b..200fe34a104c7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -423,8 +423,9 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -809,7 +810,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 
 			sresult |= map->access;
 
-			err2 = nfsd_permission(rqstp, export, dentry, map->how);
+			err2 = nfsd_permission(&rqstp->rq_cred, export,
+					       dentry, map->how);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
@@ -1453,7 +1455,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
+	err = nfsd_permission(&rqstp->rq_cred, fhp->fh_export, dentry,
+			      NFSD_MAY_CREATE);
 	if (err)
 		goto out;
 
@@ -2180,9 +2183,9 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 	return err;
 }
 
-static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
+static int exp_rdonly(struct svc_cred *cred, struct svc_export *exp)
 {
-	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
+	return nfsexp_flags(cred, exp) & NFSEXP_READONLY;
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -2426,8 +2429,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
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
@@ -2458,7 +2461,7 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 	 */
 	if (!(acc & NFSD_MAY_LOCAL_ACCESS))
 		if (acc & (NFSD_MAY_WRITE | NFSD_MAY_SATTR | NFSD_MAY_TRUNC)) {
-			if (exp_rdonly(rqstp, exp) ||
+			if (exp_rdonly(cred, exp) ||
 			    __mnt_is_readonly(exp->ex_path.mnt))
 				return nfserr_rofs;
 			if (/* (acc & NFSD_MAY_WRITE) && */ IS_IMMUTABLE(inode))
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index bf695d5cc04e4..6c41770efe33d 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -153,8 +153,8 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
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

