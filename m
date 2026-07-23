Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2A3DB629
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836753; cv=none; b=WLtsU6OZZAKCPBqzUF8ah9wW9/iwBdwn1TtEkSY9hHx9Z+BCWusemD4K3QWQo57xsuJp+KAWkszqBNZcPmPxYXaQub15/1uEDDcqjQKS09nA+lfj9oXj2HcU/pXW317kuIFHVTpj+x/DBlbR1RzXZwEYWIs8MkWJ+PMBit2QXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836753; c=relaxed/simple;
	bh=/mcp0H+lCx4PbA9Cc5hAhrvuseFuz9FIS3/0f34yBkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O246dUnMupHm72dURfUdHSIiA0E0SzxehFtWwgYkpc+4EZ4uf0pd8yXi8WF77AMS/X6kO2clXty0vDDFc3E7uxX0tc1/d1J1i+ZSPvphfAiwrExQaJaZqf0m/vCZzf6/qbUoPAb8m7TxVt37WRQk1ZVvsbDcC+bmZfGKakW2idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1qR6qPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1qR6qPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0361F000E9;
	Thu, 23 Jul 2026 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836746;
	bh=TqB3pxz18JyIFJnUfof2nwlbOEpQ+Da3BBOEZqUog5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1qR6qPukiUInPMpnbnAX1RPhXVmY2PBPz8gsC8nemWn5VJ80rgprqHLZd9sqr38m
	 z4wyF+/4iN3jevyXf2E7bo6d+qx7dElgjjwiQca0C5cJKRNEs42WYlSIB8dHNS5YGP
	 h51KmIZMCGG2OMZENTxj2XwEzF1368dDTx3/wYL0SRSDXkT/OTi+i4WGVdhz+A6jJK
	 vjRD+rZuiGaM/5kAxfGeqxbgzJjjajES9n9ifWZh6Nk1gRnmoHx1H04ixyicf1hkCO
	 W3BLPDtYIgH9kcMbu7OOA0gHCLfvD6cYPXU1ReEAwtkrdB5kz1DctS0d06fX6sfqoa
	 oYrLgW/SSddLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] NFSD: pass nfsd_file to nfsd_iter_read()
Date: Thu, 23 Jul 2026 15:58:59 -0400
Message-ID: <20260723195904.3685200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-antibody-haunt-1c24@gregkh>
References: <2026072058-antibody-haunt-1c24@gregkh>
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
index 9c8767cab51d54..72e2cd62660db4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4384,7 +4384,7 @@ static __be32 nfsd4_encode_splice_read(
 
 static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
-				 struct file *file, unsigned long maxcount)
+				 unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
 	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
@@ -4395,7 +4395,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
+	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
@@ -4444,7 +4444,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
 		return nfserr;
@@ -5311,7 +5311,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 67d09fcee66923..17ba93751a948c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1067,7 +1067,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
  * @fhp: file handle of file to be read
- * @file: opened struct file of file to be read
+ * @nf: opened struct nfsd_file of file to be read
  * @offset: starting byte offset
  * @count: IN: requested number of bytes; OUT: number of bytes read
  * @base: offset in first page of read buffer
@@ -1080,9 +1080,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1283,7 +1284,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
-		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
+		err = nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
 
 	nfsd_file_put(nf);
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 0380fc2a63fb09..885410f71ea1e7 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -122,7 +122,7 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				unsigned long *count,
 				u32 *eof);
 __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct file *file, loff_t offset,
+				struct nfsd_file *nf, loff_t offset,
 				unsigned long *count, unsigned int base,
 				u32 *eof);
 bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
-- 
2.53.0

