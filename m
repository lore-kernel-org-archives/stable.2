Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB074908C5
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856319; cv=none; b=VKE4jamVH6F1GI6mVoqCsZ79zDNN/g3rWDeSznL6mwbBBDaNKtcze0RsnelrvHE81z0wXcsLNTF5mNdSDbDvgKduoSqhu8I4DMmhQQHHXleyqy5WzQhm+T+zXxNGMiUieXZxz5kom0dO+iyIF4yFWiOALTHzC0mdjYaC7AB7Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856319; c=relaxed/simple;
	bh=kGI4qjJp55c14E6tqruS0mnu2fs1HrkzVqBFQ3LSpgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCB5y3Yty+OA/o51o9JJ5yh04wxyEVnEFqU7wh2dPQzmOflb64iqtomZvrM3DRZSiK0SeI1fauyuXk7aAiqYV4g2GZPzhj+ankKqF+C47PAr1SvNG9GYHeUgyD7Y940dZOx6OLoIEqw+pt2YyAsTpWyZl9dIKgUOyjOfnefwa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLSw0DKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLSw0DKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01D1F000E9;
	Fri, 24 Jul 2026 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856317;
	bh=7FKxOowgMytisF1st/1OXFO/nLm3LKXIQ7LEF4yz64g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLSw0DKqPLouxK1p8MYNRSfdJ0Hha0PYplXtf1PqL8fz4/vAkfDLok16EgrRuTN0U
	 JBPXlg0x/bSeBY1PYre5yQu0P0NmMgN7Xdp0CTvXhJpvywV15/9O4NWp+2WQl73SZ6
	 2ZMebQwviv3JzxOzSppUj3Xn7/HtuLWX573rnajiTDri+XE+hT9frctyR6YLv8nW2u
	 cFygNP6OcYdeczp5EyxjGXezVPJDRN2Nj5PQOWzuzdLAQTaQFc0VpwIpTSX+3iY+TG
	 IYI398Cink7Lez2uMMFEBph0w2Mo+BGapSXMs8ald5u3snyIHEEWexgaPF7Aq0mmyE
	 z9f0Z7eEVLwCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] NFSD: pass nfsd_file to nfsd_iter_read()
Date: Thu, 23 Jul 2026 21:25:11 -0400
Message-ID: <20260724012515.3833219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-disparate-ventricle-c83c@gregkh>
References: <2026072058-disparate-ventricle-c83c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit 803bc849f0039291f546ba0e2237faebeb5c073e ]

Prepare for nfsd_iter_read() to use the DIO alignment stored in
nfsd_file by passing the nfsd_file to nfsd_iter_read() rather than
just the file which is associaed with the nfsd_file.

This means nfsd4_encode_readv() now also needs the nfsd_file rather
than the file.  Instead of changing the file arg to be the nfsd_file,
we discard the file arg as the nfsd_file (and indeed the file) is
already available via the "read" argument.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 18c1cc698861 ("SUNRPC: Return an error from xdr_buf_to_bvec() on overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 8 ++++----
 fs/nfsd/vfs.c     | 7 ++++---
 fs/nfsd/vfs.h     | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e3b128cc24138a..52fe95d02fc47a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4096,7 +4096,7 @@ static __be32 nfsd4_encode_splice_read(
 
 static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
-				 struct file *file, unsigned long maxcount)
+				 unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
 	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
@@ -4107,7 +4107,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
+	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
@@ -4155,7 +4155,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
 		return nfserr;
@@ -4906,7 +4906,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ae1f43eb515a81..cb380402631fd7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1044,7 +1044,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
  * @fhp: file handle of file to be read
- * @file: opened struct file of file to be read
+ * @nf: opened struct nfsd_file of file to be read
  * @offset: starting byte offset
  * @count: IN: requested number of bytes; OUT: number of bytes read
  * @base: offset in first page of read buffer
@@ -1057,9 +1057,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned.
  */
 __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		      struct file *file, loff_t offset, unsigned long *count,
+		      struct nfsd_file *nf, loff_t offset, unsigned long *count,
 		      unsigned int base, u32 *eof)
 {
+	struct file *file = nf->nf_file;
 	unsigned long v, total;
 	struct iov_iter iter;
 	loff_t ppos = offset;
@@ -1241,7 +1242,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
-		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
+		err = nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
 
 	nfsd_file_put(nf);
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 6f059c5ac22b78..bf695d5cc04e45 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -120,7 +120,7 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				unsigned long *count,
 				u32 *eof);
 __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct file *file, loff_t offset,
+				struct nfsd_file *nf, loff_t offset,
 				unsigned long *count, unsigned int base,
 				u32 *eof);
 __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-- 
2.53.0

