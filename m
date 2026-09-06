Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E43C8731
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701321; cv=none; b=LdqkC2MpVQ9PrIwVeqiWgmP7qABIrVMb477maMWBndGn7iWysaulaMhAs0fXo/He/PIuPFccsdZDRylMZN1TCu6CP+ZHWDaQkURqaWrm/hQFdtnnCemgi759Q3gMvBez1j8Zvpu6S0sd+eVq+aTDk5oFyhImTfXnPTkjxIXpZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701321; c=relaxed/simple;
	bh=XpupQSlLywN7zwphJKvGu0x3TgJi8m3sd1rLC6T9ark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1Wp/IenjI5tNk3dvm7vlLzSZEPjZHoxwgWEMp+It+JWGUM2y7sxR6Y5OcFMJIZI0hUTwP42xuH/iVvx6S9v0qUAOywsucytiLuGQoR+wGbdalJCfsTyLdlFDgr+F+rUQZ6O0c83700E43R9d4UOCUu2LhvovrWq2zciFwstZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwiV/9yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwiV/9yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A81F00A3A;
	Sun,  6 Sep 2026 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701317;
	bh=f8HjLRtlj3XPwpLxbDfxciqpwZ8TY7+UgNH/CsoD7Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwiV/9yhiXtUX+PZoUHQmdCXRFVABMMm8M4R8HKrKbflQeSokevG+Fk7orXYyxAPb
	 TVQM51wNxpaR/9feRPd2TGHxefT8+780ZEZjHBTndksjuYho2IrK7IECEmXwImKPxx
	 wJxO3ZDH3yrDaXOceIQ7seYtYBk01hyHumgspFG7QvlGcU583LrxTpVzZcQw9BcnDp
	 Mek1mvtHp/J2Zxdu0H0jtC2CnDOYVqbKS0DJXCL8Kgz1w1by3MuAJDFitp0C59jlhU
	 eLcNVowplRo8TdqjdqNqgz+unchQsUHKNG6AW6/qYGYaOVuJn32xSV0eP649NVLPgp
	 TKCFIINWGBE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] nfsd: Move error code mapping to per-version proc code.
Date: Sun,  6 Sep 2026 09:28:32 -0400
Message-ID: <20260906132835.874565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-suave-unlucky-a08a@gregkh>
References: <2026090307-suave-unlucky-a08a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 1459ad57673b8019fbfcfddc345c99630d29e716 ]

There is code scattered around nfsd which chooses an error status based
on the particular version of nfs being used.  It is cleaner to have the
version specific choices in version specific code.

With this patch common code returns the most specific error code
possible and the version specific code maps that if necessary.

Both v2 (nfsproc.c) and v3 (nfs3proc.c) now have a "map_status()"
function which is called to map the resp->status before each non-trivial
nfsd_proc_* or nfsd3_proc_* function returns.

NFS4ERR_SYMLINK and NFS4ERR_WRONG_TYPE introduce extra complications and
are left for a later patch.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: eb0eca772066 ("nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/export.c    |  2 +-
 fs/nfsd/nfs3proc.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs3xdr.c   |  5 +----
 fs/nfsd/nfs4proc.c  |  3 +--
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfsfh.c     | 10 +++-------
 fs/nfsd/nfsproc.c   | 39 ++++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.c       | 33 +++++++++++++++++----------------
 fs/nfsd/vfs.h       |  2 +-
 fs/nfsd/xdr3.h      |  2 +-
 10 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index a9d794cfd10e0..7472c66712354 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1076,7 +1076,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
-	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+	return nfserr_wrongsec;
 }
 
 /*
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d01b29aba6623..3abb2923192ad 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -28,6 +28,22 @@ static int	nfs3_ftypes[] = {
 	S_IFIFO,		/* NF3FIFO */
 };
 
+static __be32 nfsd3_map_status(__be32 status)
+{
+	switch (status) {
+	case nfs_ok:
+		break;
+	case nfserr_nofilehandle:
+		status = nfserr_badhandle;
+		break;
+	case nfserr_wrongsec:
+	case nfserr_file_open:
+		status = nfserr_acces;
+		break;
+	}
+	return status;
+}
+
 /*
  * NULL call.
  */
@@ -57,6 +73,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -71,13 +88,16 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &argp->attrs,
 	};
+	const struct timespec64 *guardtime = NULL;
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
-				    argp->check_guard, argp->guardtime);
+	if (argp->check_guard)
+		guardtime = &argp->guardtime;
+	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -101,6 +121,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
 				   &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -120,6 +141,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
 	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -140,6 +162,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 	resp->pages = rqstp->rq_next_page++;
 	resp->status = nfsd_readlink(rqstp, &resp->fh,
 				     page_address(*resp->pages), &resp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -188,6 +211,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
 				 rqstp->rq_vec, v, &resp->count, &resp->eof);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -221,6 +245,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				  rqstp->rq_vec, nvecs, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -245,6 +270,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	/* Validation hooks belong here, before name checks and object creation. */
+
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -366,6 +393,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
 
 	resp->status = nfsd3_create_file(rqstp, dirfhp, newfhp, argp);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -391,6 +419,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -431,6 +460,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 				    argp->flen, argp->tname, &attrs, &resp->fh);
 	kfree(argp->tname);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -472,6 +502,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -493,6 +524,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -513,6 +545,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -535,6 +568,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
 				   &resp->tfh, argp->tname, argp->tlen);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -555,6 +589,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
 				 &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -607,6 +642,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	/* Recycle only pages that were part of the reply */
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -651,6 +687,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -668,6 +705,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -711,6 +749,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -753,6 +792,7 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -780,6 +820,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				   argp->count, resp->verf);
 	nfsd_file_put(nf);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 3308dd671ef0b..81a64d7349bef 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -295,17 +295,14 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 static bool
 svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
 {
-	__be32 *p;
 	u32 check;
 
 	if (xdr_stream_decode_bool(xdr, &check) < 0)
 		return false;
 	if (check) {
-		p = xdr_inline_decode(xdr, XDR_UNIT * 2);
-		if (!p)
+		if (!svcxdr_decode_nfstime3(xdr, &args->guardtime))
 			return false;
 		args->check_guard = 1;
-		args->guardtime = be32_to_cpup(p);
 	} else
 		args->check_guard = 0;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7a85817fa5bfe..0b23dcc8c293a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1127,8 +1127,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	save_no_wcc = cstate->current_fh.fh_no_wcc;
 	cstate->current_fh.fh_no_wcc = true;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
-				0, (time64_t)0);
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
 	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e6c0b1520973e..98673b69c61b5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5229,7 +5229,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
+	return nfsd_setattr(rqstp, fh, &attrs, NULL);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index e73e9d44f1b0c..29541424f01bc 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -162,10 +162,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	int len;
 	__be32 error;
 
-	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
-		error = nfserr_badhandle;
-	if (rqstp->rq_vers == 4 && fh->fh_size == 0)
+	error = nfserr_badhandle;
+	if (fh->fh_size == 0)
 		return nfserr_nofilehandle;
 
 	if (fh->fh_version != 1)
@@ -237,9 +235,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
-		error = nfserr_badhandle;
+	error = nfserr_badhandle;
 
 	fileid_type = fh->fh_fileid_type;
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9744443c39652..5a6cfcb65de69 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -13,6 +13,24 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+static __be32 nfsd_map_status(__be32 status)
+{
+	switch (status) {
+	case nfs_ok:
+		break;
+	case nfserr_nofilehandle:
+	case nfserr_badhandle:
+		status = nfserr_stale;
+		break;
+	case nfserr_wrongsec:
+	case nfserr_xdev:
+	case nfserr_file_open:
+		status = nfserr_acces;
+		break;
+	}
+	return status;
+}
+
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
 {
@@ -38,6 +56,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -103,12 +122,13 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	resp->status = nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
+	resp->status = nfsd_setattr(rqstp, fhp, &attrs, NULL);
 	if (resp->status != nfs_ok)
 		goto out;
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -143,6 +163,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -164,6 +185,7 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 				     page_address(resp->page), &resp->len);
 
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -212,6 +234,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -247,6 +270,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -402,8 +426,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			resp->status = nfsd_setattr(rqstp, newfhp, &attrs, 0,
-						    (time64_t)0);
+			resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
+						    NULL);
 	}
 
 out_unlock:
@@ -415,6 +439,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -431,6 +456,7 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -449,6 +475,7 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -469,6 +496,7 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 				 &argp->ffh);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -507,6 +535,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	fh_put(&argp->ffh);
 	fh_put(&newfh);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -540,6 +569,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -557,6 +587,7 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -602,6 +633,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -619,6 +651,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7b0bc4507ad04..6c51757f14401 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -454,7 +454,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  * @rqstp: controlling RPC transaction
  * @fhp: filehandle of target
  * @attr: attributes to set
- * @check_guard: set to 1 if guardtime is a valid timestamp
  * @guardtime: do not act if ctime.tv_sec does not match this timestamp
  *
  * This call may adjust the contents of @attr (in particular, this
@@ -466,8 +465,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  */
 __be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-	     struct nfsd_attrs *attr,
-	     int check_guard, time64_t guardtime)
+	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
@@ -516,9 +514,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode->i_ctime.tv_sec)
-		return nfserr_notsync;
-
 	/*
 	 * The size case is special, it changes the file in addition to the
 	 * attributes, and file systems don't expect it to be mixed with
@@ -534,6 +529,17 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock(inode);
 	fh_fill_pre_attrs(fhp);
+
+	if (guardtime) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+
+		if ((u32)guardtime->tv_sec != (u32)ctime.tv_sec ||
+		    guardtime->tv_nsec != ctime.tv_nsec) {
+			err = nfserr_notsync;
+			goto out_fill_attrs;
+		}
+	}
+
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -561,6 +567,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
 						inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+out_fill_attrs:
 	fh_fill_post_attrs(fhp);
 	inode_unlock(inode);
 	if (size_change)
@@ -1327,7 +1334,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * if the attributes have not changed.
 	 */
 	if (iap->ia_valid || attrs->na_pacl || attrs->na_dpacl)
-		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
+		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
 
@@ -1663,10 +1670,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		if (!err)
 			err = nfserrno(commit_metadata(tfhp));
 	} else {
-		if (host_err == -EXDEV && rqstp->rq_vers == 2)
-			err = nfserr_acces;
-		else
-			err = nfserrno(host_err);
+		err = nfserrno(host_err);
 	}
 	dput(dnew);
 out_drop_write:
@@ -1732,7 +1736,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
-	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	err = nfserr_xdev;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
 		goto out;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
@@ -1904,10 +1908,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		/* name is mounted-on. There is no perfect
 		 * error status.
 		 */
-		if (nfsd_v4client(rqstp))
-			err = nfserr_file_open;
-		else
-			err = nfserr_acces;
+		err = nfserr_file_open;
 	} else {
 		err = nfserrno(host_err);
 	}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index dbdfef7ae85bb..eea997d81961c 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -69,7 +69,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct nfsd_attrs *, int, time64_t);
+			     struct nfsd_attrs *, const struct timespec64 *);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 03fe4e21306cb..522067b7fd755 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
 	struct svc_fh		fh;
 	struct iattr		attrs;
 	int			check_guard;
-	time64_t		guardtime;
+	struct timespec64	guardtime;
 };
 
 struct nfsd3_diropargs {
-- 
2.53.0

