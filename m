Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86184734D4
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828144; cv=none; b=o78aTPwDGy4ev54PleyQsUIeL7tvrxVRbQ6RUPDWHX8/N79Oir8hvcaxrgMw1vZYH/aw+xe8TMevT10wldw1DRz+wj6mC/Ctbj8A2GkjmWo/80hMLXUT2WxJQ6h9yZXpzBB+wK1qfGCELBfEVkrk71KiU3bkaPCsF3W33PDbnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828144; c=relaxed/simple;
	bh=6/cylRi+gqTq29NSDTmZvSPJ9dX0zPmc2LEoIUDbijY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+J6F/p0y7d/lh07A7FciRxLgBqfvoeYYAM8Ym+e4t+GdAY8gvpDHhn2jl7fKk91QkB0iW7/ILbRkBAY3kWryoAAvLrjTeoF27+748W7VN6jJ55u4ieGv5kfIxdksBdobvRR0qiFDS+lW6s3LzYS4MFKn0isSNCbRa9A8JiMy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpPdQo8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpPdQo8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0F1F00A3F;
	Thu, 23 Jul 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828142;
	bh=SB6dEc2Vx2xA84V7XexYi5e6ojYok7GpazQoJ9mUA4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpPdQo8w3TVadFHMtfOtZDrlpDOFXPmgy68UrhkWTQt/gGGIED7fXzumgIPgNbmAC
	 Dz66unwYCGprZT/zLxZd1oTWtjOUC8wHBdOn9L4ZR/rE27a62GIqLEhaD6iDUPWnuT
	 wESawwCKrDQwj529szU1IX8lf7Z6E+12T9pmp2m4ZjcSPNXw5U84fkxze5sd9yyj2k
	 Zqy4XIt/JG2IlaCS+TkeGMINsy5eFPV7ewqG5M8rFa9F+49bdSUYrsCkLXQcbcloPE
	 C5oNJIYK+qZ6k1/n2jkEbU75nTQ8Vwqv0uhiVZkhMX4NCv6ZpjjA6p+k8+lGi3l8LH
	 kgUW67ZcDCh7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/3] SUNRPC: Return an error from xdr_buf_to_bvec() on overflow
Date: Thu, 23 Jul 2026 13:35:38 -0400
Message-ID: <20260723173538.3416792-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173538.3416792-1-sashal@kernel.org>
References: <2026072057-glucose-profile-c2be@gregkh>
 <20260723173538.3416792-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 18c1cc69886192e33536498289d26dba6894e3d5 ]

xdr_buf_to_bvec() returns a slot count even when the caller's bvec
budget is exhausted partway through the xdr_buf. Callers feed that
count into iov_iter_bvec() and continue as if the conversion had
succeeded, silently sending or writing fewer bytes than the data
length declares. For an NFS WRITE the server reports the truncated
transfer to the client as full success.

The overflow represents an internal invariant violation: a higher
layer reserved a bvec budget too small for the xdr_buf it then
asked the encoder to convert. That is a server-side fault, not a
media I/O failure and not a malformed client argument.

Change xdr_buf_to_bvec() to return a signed int and have the
overflow label return -ESERVERFAULT. Update the three callers to
detect the negative return and fail the request: nfsd_vfs_write()
folds the error into host_err, which nfserrno() translates to
nfserr_serverfault for the WRITE reply; svc_udp_sendto() and
svc_tcp_sendmsg() propagate the error out of the send path.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 2eb2b9358181 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c              |  6 +++++-
 include/linux/sunrpc/xdr.h |  4 ++--
 net/sunrpc/svcsock.c       | 14 ++++++++++++--
 net/sunrpc/xdr.c           | 11 ++++++-----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2c557a99896165..10c2ded3469a63 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1439,7 +1439,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
-	unsigned int		nvecs;
+	int			nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1479,6 +1479,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	if (nvecs < 0) {
+		host_err = nvecs;
+		goto out_nfserr;
+	}
 
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f82446993fde6b..633af1b83ff817 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -138,8 +138,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const u32);
 size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
 int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
-unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
-			     const struct xdr_buf *xdr);
+int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+		    const struct xdr_buf *xdr);
 int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
 		  unsigned int len, struct scatterlist *sg, unsigned int nsg);
 int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7be3de1a1aed91..c434b6a6637d9b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -732,7 +732,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		.msg_flags	= MSG_SPLICE_PAGES,
 		.msg_controllen	= sizeof(buffer),
 	};
-	unsigned int count;
+	int count;
 	int err;
 
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
@@ -746,6 +746,10 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		goto out_notconn;
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
+	if (count < 0) {
+		err = count;
+		goto out_trace;
+	}
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      count, rqstp->rq_res.len);
@@ -757,6 +761,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
 
+out_trace:
 	trace_svcsock_udp_send(xprt, err);
 
 	mutex_unlock(&xprt->xpt_mutex);
@@ -1237,7 +1242,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	struct msghdr msg = {
 		.msg_flags	= MSG_SPLICE_PAGES,
 	};
-	unsigned int count;
+	int count;
 	void *buf;
 	int ret;
 
@@ -1253,10 +1258,15 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
 				&rqstp->rq_res);
+	if (count < 0) {
+		ret = count;
+		goto out;
+	}
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
+out:
 	page_frag_free(buf);
 	return ret;
 }
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 2f28e41f7486c8..1119b796abd418 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -139,13 +139,14 @@ xdr_free_bvec(struct xdr_buf *buf)
 /**
  * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
  * @bvec: bio_vec array to populate
- * @bvec_size: element count of @bio_vec
+ * @bvec_size: element count of @bvec
  * @xdr: xdr_buf to be copied
  *
- * Returns the number of entries consumed in @bvec.
+ * Returns the number of entries consumed in @bvec on success, or
+ * -ESERVERFAULT when @xdr does not fit within @bvec_size entries.
  */
-unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
-			     const struct xdr_buf *xdr)
+int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+		    const struct xdr_buf *xdr)
 {
 	const struct kvec *head = xdr->head;
 	const struct kvec *tail = xdr->tail;
@@ -187,7 +188,7 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 
 bvec_overflow:
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
-	return count;
+	return -ESERVERFAULT;
 }
 EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 
-- 
2.53.0

