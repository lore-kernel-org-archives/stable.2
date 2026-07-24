Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F3312815
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856322; cv=none; b=nQ/JIz2BrVotWb46glDcCBM6HADB+Z+8rYY1iq4AOoIaGA5NFV5oQxYKuuzqaYNo7GVLXxZmpvUV0aQ31nbOhlcHKKidtyzOy5La3dH10O+Fj3SxhD3v6qptxQCvpuUlRx4Tt/xt3sAz8kMGJ+FafJ5mYQ4Nwx/Z96EWyX02i50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856322; c=relaxed/simple;
	bh=LzD5TnSA+sKW2FMU4EMhm1Vocaa+tTo1YxxIjqcV03w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfGGksAbH13D3D2hpk43YmIc0n8Zg+qyQg0KZTcEmURYz4DKrJZkJKFP5FMIXFghT5CXMce6hA6zUa3e/ww3fAjyAXmNmV+a3t+GiwlL79tInqEo29J/EOy5MM1/6uy139s4yWehUk0xHTzIxXksEXsmIi1NIVgOzfmdnGsxcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9KKFzdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9KKFzdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6F11F00A3F;
	Fri, 24 Jul 2026 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856321;
	bh=0tyCF6Hddn0cS8t+++rtUM5Ut7OjANLCFbbc8zDczH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9KKFzddS0J+zSJpLrj83Mcpqy4OqXWJRKwA/CNvH2576dSp7kRcKDlkppJC18ZQo
	 sl27mr5gSKjJTv6I2C1k3p6H9t35V6DoZR/Om2Qora0wAgE/QjJ0tcFlrsopbD6eQk
	 k7gcbg10DVb5SUxvGrsO2UyknG47oXHdS2kB6Wv7Ik7LFz1f9Zq7DPJG6dthAm8fF9
	 50KQ2FvGXGY+kMCLCEjJfm9sqlogymuAzxp/R5IewA4qWBIbFmt8zcpJMuCZ3Li7bA
	 qTkdUz3xj6ibbsfAjLxsaLiGEI3NB6xiwFoBgrRsk7EH+OTMgz80/RGI475Gj+ZRpv
	 +Bh7Ltyk+7Fxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] SUNRPC: Return an error from xdr_buf_to_bvec() on overflow
Date: Thu, 23 Jul 2026 21:25:15 -0400
Message-ID: <20260724012515.3833219-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012515.3833219-1-sashal@kernel.org>
References: <2026072058-disparate-ventricle-c83c@gregkh>
 <20260724012515.3833219-1-sashal@kernel.org>
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
 include/linux/sunrpc/xdr.h |  4 ++--
 net/sunrpc/svcsock.c       | 14 ++++++++++++--
 net/sunrpc/xdr.c           | 11 ++++++-----
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index c8bf221b30adc8..a180482dc209b0 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -139,8 +139,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const u32);
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
index 5a90e3564ebdf1..bbc30bc6e95041 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -738,7 +738,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		.msg_flags	= MSG_SPLICE_PAGES,
 		.msg_controllen	= sizeof(buffer),
 	};
-	unsigned int count;
+	int count;
 	int err;
 
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
@@ -752,6 +752,10 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		goto out_notconn;
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
+	if (count < 0) {
+		err = count;
+		goto out_trace;
+	}
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      count, rqstp->rq_res.len);
@@ -763,6 +767,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
 
+out_trace:
 	trace_svcsock_udp_send(xprt, err);
 
 	mutex_unlock(&xprt->xpt_mutex);
@@ -1250,7 +1255,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	struct msghdr msg = {
 		.msg_flags	= MSG_SPLICE_PAGES,
 	};
-	unsigned int count;
+	int count;
 	void *buf;
 	int ret;
 
@@ -1268,10 +1273,15 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, RPCSVC_MAXPAGES,
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
 	if (ret < 0)
 		return ret;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 43101b82cc5243..94912fc0805111 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -167,13 +167,14 @@ xdr_free_bvec(struct xdr_buf *buf)
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
@@ -215,7 +216,7 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 
 bvec_overflow:
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
-	return count;
+	return -ESERVERFAULT;
 }
 
 /**
-- 
2.53.0

