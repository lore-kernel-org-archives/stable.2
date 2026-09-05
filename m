Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483730D3E0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573003; cv=none; b=Z+koKfMMT2ikGlF4cxBut7EY9PC1N0CzFjX8GjVrA8KfBupWy0Rl+DOapdXOP1upkDBAGvVOlNXvJlcGChuVO493V7GoI9CJSLo3JJHUxgNt6qsdH42OdvHB3W5OLeAfj3Weux4jyzi6MNW0BdbbSCYRBrsMoJhUPQtc8T8KNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573003; c=relaxed/simple;
	bh=n5qsaUfCrlrfN2Wa9hiL+KJTBfgq8aUjouBHWGCX1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCtvov2LTbD2T/LbkHqY1UGnNDZwe5+auZ9Ihm4bk6Pw47CedzXcDal0+XCa8+K6/XvXms5azfPC/ehPXoXs5ZgM4RD+R6kCEBKC2SaZU9BQO+b7UX8S4/CtebSvVWFaoSRAeoY0g6xiwCKHmVDG8sSfn4mCdtwnndSBJaqIL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogveFpTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogveFpTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0061F00A3D;
	Sat,  5 Sep 2026 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573001;
	bh=H8A1KOUs2hPL+HM4W0GrMNCk+y9rHhcASCn2zAynJ84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogveFpTjCqrhiO1laiaUQTdCQegnza5QT1LBxxYeuiCvEdwls8S5g3SBfe6efmUX7
	 pNAx9pY0XvAUF6RuKjwv7KxLsClT/Mq12Q/uxU+lVc1KhOHrh5f/wDP28jKLdhNfYj
	 BXri7UT9qPx+HPIdEGHm31ik/TjU1y31C8rWTG12pKyJCk5KmRiWmbB1x+A+nAL/sD
	 CmdpOh04hKwoQyE5nk0GBdQ51XoYVPsoeUfUNtsql07QilqvN+HVTEawSEkJ5yD5pR
	 nF6V0vqt77pWkPCLmPThyWy/ceQgLG2RBkghnWxoex3WQMiblJBHOAne5Y4E0ao+Eq
	 SKLP2hzHyOvFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] nfsd: handle failure to collect pre/post-op attrs more sanely
Date: Fri,  4 Sep 2026 21:49:57 -0400
Message-ID: <20260905014958.1806867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090340-darkness-disposal-745f@gregkh>
References: <2026090340-darkness-disposal-745f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit a332018a91c419a9a475c41d827544c771986876 ]

Collecting pre_op_attrs can fail, in which case it's probably best to
fail the whole operation.

Change fh_fill_pre_attrs and fh_fill_both_attrs to return __be32, and
have the callers check the return code and abort the operation if it's
not nfs_ok.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: b778e0e0a167 ("NFSD: check truncate permission under inode lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/auth.c      | 15 ++++----
 fs/nfsd/auth.h      |  2 +-
 fs/nfsd/export.h    |  3 +-
 fs/nfsd/nfs3proc.c  |  4 +-
 fs/nfsd/nfs4proc.c  | 14 ++++---
 fs/nfsd/nfs4state.c |  5 ++-
 fs/nfsd/nfsfh.c     | 45 +++++++++++-----------
 fs/nfsd/nfsfh.h     |  6 +--
 fs/nfsd/nfsproc.c   |  9 +++--
 fs/nfsd/vfs.c       | 94 ++++++++++++++++++++++++++-------------------
 fs/nfsd/vfs.h       |  4 +-
 11 files changed, 112 insertions(+), 89 deletions(-)

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
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 19cf583096d9c..b54b8ef842d71 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -319,7 +319,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	fh_fill_pre_attrs(fhp);
+	status = fh_fill_pre_attrs(fhp);
+	if (status != nfs_ok)
+		goto out;
 	host_err = vfs_create(inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a4c7cab1679bd..96abcf7111950 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -298,12 +298,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_positive(child)) {
-		status = nfs_ok;
-
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
 		 */
-		fh_fill_both_attrs(fhp);
+		status = fh_fill_both_attrs(fhp);
+		if (status != nfs_ok)
+			goto out;
 
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
@@ -346,7 +346,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	fh_fill_pre_attrs(fhp);
+	status = fh_fill_pre_attrs(fhp);
+	if (status != nfs_ok)
+		goto out;
 	status = nfsd4_vfs_create(fhp, child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -425,11 +427,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
-		if (!status)
+		if (status == nfs_ok)
 			/* NFSv4 protocol requires change attributes even though
 			 * no change happened.
 			 */
-			fh_fill_both_attrs(current_fh);
+			status = fh_fill_both_attrs(current_fh);
 	}
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c61e1a4ab620c..af5b61e19b74d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6566,8 +6566,9 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 
 	nf = nfs4_find_file(s, flags);
 	if (nf) {
-		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
-				acc | NFSD_MAY_OWNER_OVERRIDE);
+		status = nfsd_permission(&rqstp->rq_cred,
+					 fhp->fh_export, fhp->fh_dentry,
+					 acc | NFSD_MAY_OWNER_OVERRIDE);
 		if (status) {
 			nfsd_file_put(nf);
 			goto out;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 44e9a9dd28688..bb3a27f3af3db 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -101,7 +101,7 @@ static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(rqstp, exp);
+	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
 
 	/* Check if the request originated from a secure port. */
 	if (!nfsd_originating_port_ok(rqstp, flags)) {
@@ -112,7 +112,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(rqstp, exp));
+	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
@@ -390,7 +390,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(rqstp, exp, dentry, access);
+	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
 
 	if (error) {
 		dprintk("fh_verify: %pd2 permission failure, "
@@ -616,7 +616,7 @@ fh_update(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_pre_attrs(struct svc_fh *fhp)
+__be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode;
@@ -624,16 +624,12 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
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
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
@@ -641,6 +637,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
+	return nfs_ok;
 }
 
 /**
@@ -648,27 +645,27 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_post_attrs(struct svc_fh *fhp)
+__be32 fh_fill_post_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_no_wcc)
-		return;
+		return nfs_ok;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	if (err) {
-		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
+	if (err)
+		return err;
+
+	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+	return nfs_ok;
 }
 
 /**
@@ -678,16 +675,20 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
  * This is used when the directory wasn't changed, but wcc attributes
  * are needed anyway.
  */
-void fh_fill_both_attrs(struct svc_fh *fhp)
+__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp)
 {
-	fh_fill_post_attrs(fhp);
-	if (!fhp->fh_post_saved)
-		return;
+	__be32 err;
+
+	err = fh_fill_post_attrs(fhp);
+	if (err)
+		return err;
+
 	fhp->fh_pre_change = fhp->fh_post_change;
 	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
 	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
 	fhp->fh_pre_size = fhp->fh_post_attr.size;
 	fhp->fh_pre_saved = true;
+	return nfs_ok;
 }
 
 /*
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 40aee06ebd952..f4528320490cf 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -314,7 +314,7 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 		return time_to_chattr(&stat->ctime);
 }
 
-extern void fh_fill_pre_attrs(struct svc_fh *fhp);
-extern void fh_fill_post_attrs(struct svc_fh *fhp);
-extern void fh_fill_both_attrs(struct svc_fh *fhp);
+__be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
+__be32 fh_fill_post_attrs(struct svc_fh *fhp);
+__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 96426dea7d412..e5fb29e87ce3b 100644
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
index c8eebd03784a2..064074dbb64b5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -394,30 +394,17 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		struct iattr *iap)
 {
 	struct inode *inode = d_inode(fhp->fh_dentry);
-	int host_err;
 
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
-
-	host_err = get_write_access(inode);
-	if (host_err)
-		goto out_nfserrno;
-
-	host_err = locks_verify_truncate(inode, NULL, iap->ia_size);
-	if (host_err)
-		goto out_put_write_access;
-	return 0;
-
-out_put_write_access:
-	put_write_access(inode);
-out_nfserrno:
-	return nfserrno(host_err);
+	return nfserrno(get_write_access(inode));
 }
 
 static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
@@ -530,6 +517,11 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (check_guard && guardtime != inode->i_ctime.tv_sec)
 		return nfserr_notsync;
+	if (size_change) {
+		host_err = locks_verify_truncate(inode, NULL, iap->ia_size);
+		if (host_err)
+			return nfserrno(host_err);
+	}
 
 	/*
 	 * The size case is special, it changes the file in addition to the
@@ -545,7 +537,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
-	fh_fill_pre_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err)
+		goto out_unlock;
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -572,6 +566,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
 	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
@@ -787,7 +782,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 
 			sresult |= map->access;
 
-			err2 = nfsd_permission(rqstp, export, dentry, map->how);
+			err2 = nfsd_permission(&rqstp->rq_cred, export,
+					       dentry, map->how);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
@@ -1395,7 +1391,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
+	err = nfsd_permission(&rqstp->rq_cred, fhp->fh_export, dentry,
+			      NFSD_MAY_CREATE);
 	if (err)
 		goto out;
 
@@ -1506,7 +1503,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		goto out_unlock;
-	fh_fill_pre_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
 	fh_fill_post_attrs(fhp);
 out_unlock:
@@ -1601,13 +1600,16 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
-	fh_fill_pre_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 	host_err = vfs_symlink(d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(dentry->d_inode);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
@@ -1669,7 +1671,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
-	fh_fill_pre_attrs(ffhp);
+	err = fh_fill_pre_attrs(ffhp);
+	if (err != nfs_ok)
+		goto out_dput;
 	host_err = vfs_link(dold, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
 	inode_unlock(dirp);
@@ -1761,8 +1765,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	}
 
 	trap = lock_rename(tdentry, fdentry);
-	fh_fill_pre_attrs(ffhp);
-	fh_fill_pre_attrs(tfhp);
+	err = fh_fill_pre_attrs(ffhp);
+	if (err != nfs_ok)
+		goto out_unlock;
+	err = fh_fill_pre_attrs(tfhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 
 	odentry = lookup_one_len(fname, fdentry, flen);
 	host_err = PTR_ERR(odentry);
@@ -1821,6 +1829,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
+out_unlock:
 	unlock_rename(tdentry, fdentry);
 	fh_drop_write(ffhp);
 
@@ -1880,12 +1889,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		goto out_unlock;
 	}
 	rinode = d_inode(rdentry);
-	ihold(rinode);
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 
+	ihold(rinode);
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
-	fh_fill_pre_attrs(fhp);
 	if (type != S_IFDIR) {
 		int retries;
 
@@ -2106,9 +2117,9 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 	return err;
 }
 
-static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
+static int exp_rdonly(struct svc_cred *cred, struct svc_export *exp)
 {
-	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
+	return nfsexp_flags(cred, exp) & NFSEXP_READONLY;
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -2308,15 +2319,17 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 		return nfserrno(ret);
 
 	inode_lock(fhp->fh_dentry->d_inode);
-	fh_fill_pre_attrs(fhp);
-
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 	ret = __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
-
+	err = nfsd_xattr_errno(ret);
 	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
-	return nfsd_xattr_errno(ret);
+	return err;
 }
 
 __be32
@@ -2334,15 +2347,18 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	if (ret)
 		return nfserrno(ret);
 	inode_lock(fhp->fh_dentry->d_inode);
-	fh_fill_pre_attrs(fhp);
-
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 	ret = __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, flags,
 				    NULL);
 	fh_fill_post_attrs(fhp);
+	err = nfsd_xattr_errno(ret);
+out_unlock:
 	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
-	return nfsd_xattr_errno(ret);
+	return err;
 }
 #endif
 
@@ -2350,8 +2366,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
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
@@ -2382,7 +2398,7 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
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

