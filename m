Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40D3B841C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555002; cv=none; b=LSOrBjG0UHrGKf++ctGkvrJqVuIrnWCu+ExidvK8GsXC7N8Ki05QTvRZy+bpKN+0uooBaKya+sNLVXGSQL1TDxMKs9ryCd1YLJwaRs3YmbuQU5Zh2akBeoolJB3D7tp9zriniDUiTu4JX84AFmJCzObUWkBgBoeMExaG/aIYkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555002; c=relaxed/simple;
	bh=nRGEcnxuj+h4w2vwX3/Pgk4rJIpRHCwaU5qgxIZ0aY0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jwntksan/4J++uR6vGblZwjFDsFmbqwnXsYdZWEwu9Draz3Y0+wHCZzV77NZsYo3C5747GxPweqIX+sEaVdgE9wE8uirT2cU0LUMh68XoBaBLPVlFHSGoLSXyA71/6RpcCPNkAY3aIHhQu9B2OI5W8q+4q8P+i3eU3VskxPRu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNKsa8Ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNKsa8Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCE11F00A3A;
	Mon, 20 Jul 2026 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784554997;
	bh=Inyd3X41bGw+fnbyyVCeGc+dBcf0PL5JofMwwd5Uu1U=;
	h=Subject:To:Cc:From:Date;
	b=qNKsa8Ijx4sdfUXYBAxDGPHZ0DnqJXD+IWkwhakcPBQaAWyZ783wNFZv+bIakSAKt
	 AxMTtqUosH1Jj6uVZnkokZGmiVBU+tOctNv56XJ629W5KPOA+fT74NKUfqhQ5JWtpf
	 BE2+EwhdHuC0sNrg0PbUGRiu7cgzvT+r8xv/qBmI=
Subject: FAILED: patch "[PATCH] SUNRPC: Return an error from xdr_buf_to_bvec() on overflow" failed to apply to 6.6-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,clm@meta.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 15:42:58 +0200
Message-ID: <2026072058-disparate-ventricle-c83c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 18c1cc69886192e33536498289d26dba6894e3d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072058-disparate-ventricle-c83c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18c1cc69886192e33536498289d26dba6894e3d5 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 19 May 2026 09:34:22 -0400
Subject: [PATCH] SUNRPC: Return an error from xdr_buf_to_bvec() on overflow

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

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ba97e287c007..cba473969429 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1440,7 +1440,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
-	unsigned int		nvecs;
+	int			nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1480,6 +1480,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	if (nvecs < 0) {
+		host_err = nvecs;
+		goto out_nfserr;
+	}
 
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 31971b01d962..b102b4f21e6b 100644
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
index 7be3de1a1aed..c434b6a6637d 100644
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
index 8f52782d8a37..fa6a30b5f046 100644
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
 

