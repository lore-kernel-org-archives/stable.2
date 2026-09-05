Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FD36405A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644621; cv=none; b=bAcZpU1t4/IKCBtuYvQuwXRni1BLXiW9fHObklUzaQ2FoTcOjIZj17yw0wpkof43Fobi1Ulxv8mRjquu3++6kBGop+NZQ2lCOLuGxwMz6su0A/bixp1wiJPeX/xlc0wo6Cy0qR4GYkl5k8yOiEz5Nyi+TITh83+PZyxHiY761nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644621; c=relaxed/simple;
	bh=iiaVEEeyfZbSSxoKtSS746t0Ep+G3T3cQ+CzURvDQvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBMz03ksWLF81CK5bLrz9FV6NiqxasGBRL3KVh35mXou69ZnJZjdAxX3FGZa1j6NFJPxnxZfQs8jf2MtyS91svcnBHQBtWJ06xMVFCo/9Ig71t6gMsf9sRNWoPnw0UpT1iVgpfiACXk0U9Sw1v1lvTBRP+ZYf3QImNhJ0u5c13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekeU0mLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekeU0mLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90CC1F00A3A;
	Sat,  5 Sep 2026 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644619;
	bh=Dmksr7C2fesqNG43BFv1Yp5puuDDN8yAzm5PCjggWxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekeU0mLqGq7SvOhJkJomYTmRCJP3EJI9mNvllPsDiF8wJxP1IaDMI2NRsWvZhYmlm
	 6gGb/mlJtPnl7LVtLpLgo7TGEMjE9bTwLqGHi1CG+YyQrTJyulCD7vEW282k/KbU8U
	 Cey/ga3lWR/U+5OKiGITH4qa/mPRmlsFl8aZiGCTGGk5ux/4y69c0xXm86gHHoAwIc
	 QesMmLYmipv3q/WBF3pf94HCU+11QbzIICTuSGnP0YF83yNpcuvaLh3lHLrmurJUWW
	 LGrvSEXfQlstbj90CvbUsLW409Lt7FmCBain5tD3TBy5MtECUylNmqweFBlP9jZ//n
	 gI6/laoNCr+kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] nfsd: Move error code mapping to per-version proc code.
Date: Sat,  5 Sep 2026 17:43:34 -0400
Message-ID: <20260905214337.701562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-viewpoint-outshoot-49ba@gregkh>
References: <2026090305-viewpoint-outshoot-49ba@gregkh>
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
 fs/nfsd/export.c   |  8 ++++----
 fs/nfsd/nfs3proc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.c    | 10 +++-------
 fs/nfsd/nfsproc.c  | 33 +++++++++++++++++++++++++++++++++
 fs/nfsd/trace.h    | 27 +++++++++++++++++++++++++++
 fs/nfsd/vfs.c      | 14 +++++---------
 6 files changed, 112 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 782b58abb1303..cf867454ece52 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1084,7 +1084,7 @@ static struct svc_export *exp_find(struct cache_detail *cd,
  *
  * Return values:
  *   %nfs_ok if access is granted, or
- *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ *   %nfserr_wrongsec if access is denied
  */
 __be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
@@ -1105,7 +1105,7 @@ __be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 			return nfs_ok;
 	}
 
-	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+	return nfserr_wrongsec;
 }
 
 /**
@@ -1121,7 +1121,7 @@ __be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
  *
  * Return values:
  *   %nfs_ok if access is granted, or
- *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ *   %nfserr_wrongsec if access is denied
  */
 __be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp)
 {
@@ -1151,7 +1151,7 @@ __be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
-	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+	return nfserr_wrongsec;
 }
 
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index f4ccbb1f49ba7..f4d659e3ad596 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -14,6 +14,7 @@
 #include "xdr3.h"
 #include "vfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -28,6 +29,22 @@ static int	nfs3_ftypes[] = {
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
@@ -57,6 +74,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -80,6 +98,7 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	if (argp->check_guard)
 		guardtime = &argp->guardtime;
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -103,6 +122,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
 				   &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -122,6 +142,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
 	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -142,6 +163,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 	resp->pages = rqstp->rq_next_page++;
 	resp->status = nfsd_readlink(rqstp, &resp->fh,
 				     page_address(*resp->pages), &resp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -178,6 +200,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
 				 &resp->count, &resp->eof);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -211,6 +234,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				  rqstp->rq_vec, nvecs, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -235,6 +259,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
+
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -358,6 +384,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
 
 	resp->status = nfsd3_create_file(rqstp, dirfhp, newfhp, argp);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -383,6 +410,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -423,6 +451,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 				    argp->flen, argp->tname, &attrs, &resp->fh);
 	kfree(argp->tname);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -464,6 +493,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -485,6 +515,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -505,6 +536,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -527,6 +559,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
 				   &resp->tfh, argp->tname, argp->tlen);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -547,6 +580,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
 				 &resp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -599,6 +633,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	/* Recycle only pages that were part of the reply */
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -643,6 +678,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -660,6 +696,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -703,6 +740,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -745,6 +783,7 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -772,6 +811,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				   argp->count, resp->verf);
 	nfsd_file_put(nf);
 out:
+	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 283c1a60c8460..1601b47a00f2d 100644
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
index 36370b957b633..0ae3a4576e0e6 100644
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
 
@@ -109,6 +128,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 
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
 
@@ -200,6 +222,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -235,6 +258,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -403,6 +427,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -419,6 +444,7 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -437,6 +463,7 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -457,6 +484,7 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 				 &argp->ffh);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -495,6 +523,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	fh_put(&argp->ffh);
 	fh_put(&newfh);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -528,6 +557,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -545,6 +575,7 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -590,6 +621,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -607,6 +639,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
+	resp->status = nfsd_map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d7ed49eef5911..fdb6cfad08793 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -228,6 +228,33 @@ TRACE_EVENT(nfsd_fh_verify,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_create,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		umode_t type,
+		const char *name,
+		unsigned int len
+	),
+	TP_ARGS(rqstp, fhp, type, name, len),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(umode_t, type)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->type = type;
+		__assign_str_len(name, name, len);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
+		__entry->xid, __entry->fh_hash,
+		show_fs_file_type(__entry->type), __get_str(name)
+	)
+);
+
 TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5dc798e89e97b..8a351b9ced324 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1538,6 +1538,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, type, fname, flen);
+
 	if (isdotent(fname, flen))
 		return nfserr_exist;
 
@@ -1745,10 +1747,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
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
@@ -1814,7 +1813,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
-	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	err = nfserr_xdev;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
 		goto out;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
@@ -1993,10 +1992,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		/* name is mounted-on. There is no perfect
 		 * error status.
 		 */
-		if (nfsd_v4client(rqstp))
-			err = nfserr_file_open;
-		else
-			err = nfserr_acces;
+		err = nfserr_file_open;
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-- 
2.53.0

