Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932157;
	b=TVGmT9AAblNrrTGdT1eixfuQt6SZ1fT8gdhYb4fQnHM2Uf6PvP6RrD3iBxgn7nUETcue
	 vNw+AnFxYaToEtheigRAQSZpE7iOzPFD92Um7Xprjt+Y5RYoUp6ESJk62W/xOsNANPJzz
	 d9Cl1EkcijKhzmpp/qFlxAfYOiwTaVCpaf2Qsmk+EpK13ASPO49CR0EsOZ2pz/ASI+AHT
	 z5KDQT9vJ+tHKrbh0bLKYhpo64SxGljgfBWCY3H/7qlNbD0UyNwhkhC5r1ePlrBJxAXkd
	 IFvQ0VCJj62Qh5cZ1cPIwsGfY8EMeynfKxIxrQcwXpTgvC6QdMeMKJtcpbJmnEGo44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kveIM8lQvTNdeiSt3SNWX7T3TfZ4grEp56MCYRBnVM8=;
	b=aojf/qg2iMa6dIIUKIR25r5P6IpeYZpZycJRNWE2G54sO0MaA/RG2awSoXa7WlFRMR1c
	 ALhOhsOObtfaEAT4qKTHrKQxX4pDzrT/qr2EQZ4wPu9cV3ZwzzylRKs7ZzgKOlyfz3cFp
	 7W7diUZQPkT1bSnEqa/AsxOvXlC9LQ9+lCM2/YxDmS6vf/6bN8mQrxEPodPW8u7hrOZrt
	 i0Ib/m7mOLpe6/NK+9rxCIej1gSNCmGFyYJQmSKNcplnQ7Tm4c6WAmJwRJuhDxBZ29ifn
	 ZZ+ydPB+iX+54bD9Ih4NS7qw+uqECLkBYexANkSFbfnafCT/XyfW9P1u2DjyXX0nGSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hh3fp4fx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E3606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hh3fp4fx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6947C1F0089F;
	Fri,  6 Nov 2026 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932156;
	bh=kveIM8lQvTNdeiSt3SNWX7T3TfZ4grEp56MCYRBnVM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hh3fp4fxnyamyMrYTMtz4VKfhPgjtTmGeTJbtBjBOhvPf4oOiBMtT6mKlD9S9+7qv
	 HTD/alIKw2wIFWRs2NtA1tDr848lvTlOTN+0TLLD41s8pdWjAA1ihHk6lsxoDYZVFY
	 NC2MxGIm/Ve4g+0kRjaqVCUw8l9H1MgbB9gcEsNuOryxOQyTv7A1S/H2AHFulbuhN/
	 tkAgOU1pTG1rmcTSFzGFLZt7vzEdN1R/lbhzn0rAe9RSVFjlYYrybQuc51P1fbbJJn
	 RpYmApDv5+1GLcqmTuxLtlI6tWrb4Ypl7QBJ6JIVGgSh3M2hLRDfRVPQWYBaFaQ9dF
	 BTIn9HFGB747A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] NFSD: Replace nfsd_write()'s "stable" argument with "iocb_flags"
Date: Thu,  5 Nov 2026 21:29:12 -0500
Message-ID: <20261106022850.3722633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-anatomist-emptier-0eda@gregkh>
References: <2026110437-anatomist-emptier-0eda@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 7f7dde9a45dfd9b3c9f35cb24aff9e45669071cc ]

The current nfsd_write() API is not NFS version-agnostic, as it
relies on callers to pass an NFSv3 stable_how value to determine
the persistence of the requested WRITE. NFSv2 does not use a
stable-how value on the wire, and NFSv4 has its own stable_how4
(though stable_how and stable_how4 happen to share the same
numeric values).

To remove the dependence on NFSv3-specific XDR values from NFSD's
generic VFS APIs, replace nfsd_write()'s stable argument with an
argument that passes a set of IOCB flags instead of an XDR-defined
value.

The NFSv4 WRITE and COPY paths had been borrowing the NFSv3
stable_how constants for their own on-the-wire stable values,
relying on the numeric coincidence noted above. Convert those
sites to the stable_how4 enumerators so the v4 code expresses
its own protocol's values directly, with no change in behavior.

While here, bound-check the decoded NFSv3 WRITE stable value, as
the NFSv4 WRITE decoder already does, and make the nfsd3_writeargs
stable field unsigned to suit.

The larger benefit is one less NFSv4 dependency on nfs3.h.

Link: https://patch.msgid.link/20260723182043.990391-3-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: ccfc4db5ab74 ("NFSD: map fh_verify() status codes for NFS_ACLv2 replies")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c   | 17 ++++++++++++++++-
 fs/nfsd/nfs3xdr.c    |  2 ++
 fs/nfsd/nfs4proc.c   | 18 ++++++++++++++++--
 fs/nfsd/nfs4xdr.c    |  2 +-
 fs/nfsd/nfsproc.c    |  2 +-
 fs/nfsd/vfs.c        | 30 ++++++++++--------------------
 fs/nfsd/vfs.h        |  6 ++++--
 fs/nfsd/xdr3.h       |  2 +-
 include/linux/nfs4.h |  6 ++++++
 9 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index fbf573c317193..b71c869aaea7c 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -48,6 +48,20 @@ static bool nfsd3_time_in_range(const struct iattr *iap)
 	return true;
 }
 
+static int nfsd3_iocb_flags(enum nfs3_stable_how how)
+{
+	switch (how) {
+	case NFS_FILE_SYNC:
+		/* persist data and timestamps */
+		return IOCB_DSYNC | IOCB_SYNC;
+	case NFS_DATA_SYNC:
+		/* persist data only */
+		return IOCB_DSYNC;
+	default:
+		return 0;
+	}
+}
+
 static __be32 nfsd3_map_status(__be32 status)
 {
 	switch (status) {
@@ -260,7 +274,8 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	resp->committed = argp->stable;
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  &argp->payload, &cnt,
-				  resp->committed, resp->verf);
+				  nfsd3_iocb_flags(resp->committed),
+				  resp->verf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef4971d71ac4b..067ae1c8aaa5a 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -556,6 +556,8 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
 		return false;
+	if (args->stable > NFS_FILE_SYNC)
+		return false;
 
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1bf4a84d6a19c..161208b972be2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -68,6 +68,20 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+static int nfsd4_iocb_flags(enum stable_how4 how)
+{
+	switch (how) {
+	case FILE_SYNC4:
+		/* persist data and timestamps */
+		return IOCB_DSYNC | IOCB_SYNC;
+	case DATA_SYNC4:
+		/* persist data only */
+		return IOCB_DSYNC;
+	default:
+		return 0;
+	}
+}
+
 static u32 nfsd_attrmask[] = {
 	NFSD_WRITEABLE_ATTRS_WORD0,
 	NFSD_WRITEABLE_ATTRS_WORD1,
@@ -1302,7 +1316,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, &write->wr_payload,
-				&cnt, write->wr_how_written,
+				&cnt, nfsd4_iocb_flags(write->wr_how_written),
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
@@ -1826,7 +1840,7 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 {
 	copy->cp_res.wr_stable_how =
 		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
-			NFS_FILE_SYNC : NFS_UNSTABLE;
+			FILE_SYNC4 : UNSTABLE4;
 	nfsd4_copy_set_sync(copy, sync);
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2fe4767dca5b5..7b243d9d71733 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1458,7 +1458,7 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &write->wr_stable_how) < 0)
 		return nfserr_bad_xdr;
-	if (write->wr_stable_how > NFS_FILE_SYNC)
+	if (write->wr_stable_how > FILE_SYNC4)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &write->wr_buflen) < 0)
 		return nfserr_bad_xdr;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c561d7014b49f..aab68a65ad563 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -280,7 +280,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
-				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
+				  &argp->payload, &cnt, IOCB_DSYNC, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 53b55ee4e00ee..a126da5c3e8e3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1185,7 +1185,7 @@ static int wait_for_concurrent_writes(struct file *file)
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @iocb_flags: VFS IOCB_* flags expressing the requested write stability
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1197,7 +1197,7 @@ __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	       struct nfsd_file *nf, loff_t offset,
 	       const struct xdr_buf *payload, unsigned long *cnt,
-	       int stable, __be32 *verf)
+	       int iocb_flags, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
@@ -1234,21 +1234,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	exp = fhp->fh_export;
 
 	if (!EX_ISSYNC(exp))
-		stable = NFS_UNSTABLE;
+		iocb_flags = 0;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
-	if (likely(!fhp->fh_use_wgather)) {
-		switch (stable) {
-		case NFS_FILE_SYNC:
-			/* persist data and timestamps */
-			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
-			break;
-		case NFS_DATA_SYNC:
-			/* persist data only */
-			kiocb.ki_flags |= IOCB_DSYNC;
-			break;
-		}
-	}
+	if (likely(!fhp->fh_use_wgather))
+		kiocb.ki_flags |= iocb_flags;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	if (nvecs < 0) {
@@ -1284,7 +1274,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_nfserr;
 	}
 
-	if (stable && fhp->fh_use_wgather) {
+	if (iocb_flags && fhp->fh_use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
 			commit_reset_write_verifier(nn, rqstp, host_err);
@@ -1375,7 +1365,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @iocb_flags: VFS IOCB_* flags expressing the requested write stability
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1385,8 +1375,8 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
-	   __be32 *verf)
+	   const struct xdr_buf *payload, unsigned long *cnt,
+	   int iocb_flags, __be32 *verf)
 {
 	struct nfsd_file *nf;
 	__be32 err;
@@ -1398,7 +1388,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 		goto out;
 
 	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
-			     stable, verf);
+			     iocb_flags, verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 1dd3ae3ceb3a8..2f589c4f0248c 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -131,11 +131,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				u32 *eof);
 __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, int iocb_flags,
+				__be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, int iocb_flags,
+				__be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 522067b7fd755..7b5e3e3bac006 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -38,7 +38,7 @@ struct nfsd3_writeargs {
 	svc_fh			fh;
 	__u64			offset;
 	__u32			count;
-	int			stable;
+	__u32			stable;
 	__u32			len;
 	struct xdr_buf		payload;
 };
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684a..7c5ab7ae7b532 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -390,6 +390,12 @@ enum why_no_delegation4 { /* new to v4.1 */
 	WND4_IS_DIR = 8,
 };
 
+enum stable_how4 {
+	UNSTABLE4	= 0,
+	DATA_SYNC4	= 1,
+	FILE_SYNC4	= 2,
+};
+
 enum lock_type4 {
 	NFS4_UNLOCK_LT = 0,
 	NFS4_READ_LT = 1,
-- 
2.53.0

