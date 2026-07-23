Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845837F001
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836750; cv=none; b=iRDUxioR3cMPxFqoGEAQhUthRIJIOSKEU1CIR7wbUboyG2gDeh8YPhlj6VGLAsTYwCAPwhvpzUn2m1RRR1SY+rC1DHSM/8l9oDrAe8UvZbK8yGGZgB7+2z1Bcn6fphQ3HkolxayUAdduEu5DSdKmrodnFWf+gEZ6Vycj0jAQkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836750; c=relaxed/simple;
	bh=jiyDll+J6hGTVapuG0v3F1dWIomyj2Bf+m8rtRGDr3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdrHwIlDNOeip8vWISMspNNTxIH2q2uu98LigluLZL2bgdM+RLPRvPEnmgr48D+3aQPuAUV7pU3QDMNAfnAYPE5zCuowxgJBEVpyg4/A5qh9FlCYtVwYW64OjnKv2iRPW0pyCvYpx3gAbSsF5HQmwyMod6HqxN2n5ypmKKCUmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhgPME/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhgPME/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793741F00A3D;
	Thu, 23 Jul 2026 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836748;
	bh=7XTjTFIwsvMpmuyx2YqSf6NDHug/BK2H8OK/eLgrDC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhgPME/MwdS+sIGaE6QCZ4m0mPur81Zqs+2Wu1n8vnvAVUGqtEqpfTWAnUn0Ld2nh
	 8ekV4QA2NAtQQiXjlxFsQpLKGkJG78m+4IQQDahM5XH7nr+1bQlSPguIvFYzXMpgUq
	 cE7tlhiPnzuYFhPZxSXxITCyMcQuwPCMsA75rt2kgcHKY/UYS8tSWDhunMS0Y2FvOV
	 hjCtqkH9SqmtSpFOPLbTgJtqi1f/e8QEQMrgbk16U8wB9m9bmXtoFbDvgkLaaovnle
	 a/noBYYvcUkZK/AvwZYUMH+/NdWQtMY1Gg85qcDrf2FR6LpgKP+pmmxHiApARReJWn
	 sqtNtZ1t4VUsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] SUNRPC: Add helpers to convert xdr_buf byte ranges to scatterlists
Date: Thu, 23 Jul 2026 15:59:01 -0400
Message-ID: <20260723195904.3685200-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195904.3685200-1-sashal@kernel.org>
References: <2026072058-antibody-haunt-1c24@gregkh>
 <20260723195904.3685200-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e9be933959b581effd426f93b86654f5fbf0c574 ]

The crypto/krb5 library accepts data in scatterlist form, but
the GSS-API layer presents RPC payloads as struct xdr_buf.
Bridge that gap with a pair of helper functions:

  xdr_buf_to_sg()        - populate a caller-supplied scatterlist
                           array from a byte range
  xdr_buf_to_sg_alloc()  - populate a caller-supplied inline
                           scatterlist, chaining to a heap-
                           allocated overflow for large payloads

The inline array (typically stack-allocated at eight entries)
covers the common case of small RPCs with no heap allocation
on the encrypt/decrypt path. Only buffers spanning many pages
incur a kmalloc for the chained extension.

The segment-walking logic follows the same head, page array,
tail traversal as xdr_process_buf(), but populates a
scatterlist directly rather than invoking a per-segment
callback. sg_next() traversal makes the walker safe for
chained scatterlists. Once subsequent patches reroute all
per-message crypto operations through crypto/krb5,
xdr_process_buf() loses its last callers and is removed.

Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 18c1cc698861 ("SUNRPC: Return an error from xdr_buf_to_bvec() on overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/xdr.h |  15 +++
 net/sunrpc/xdr.c           | 199 +++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 5f775e104f9ab0..3b68e1bfe030cf 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -141,6 +141,21 @@ int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
 unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 			     const struct xdr_buf *xdr);
+int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
+		  unsigned int len, struct scatterlist *sg, unsigned int nsg);
+int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
+			unsigned int len, struct scatterlist *sg_head,
+			unsigned int sg_head_nents,
+			struct scatterlist **sg_overflow, gfp_t gfp);
+
+/*
+ * Inline scatterlist entries for xdr_buf_to_sg_alloc().  Sized to cover the
+ * head kvec, tail kvec, and a few page fragments without any heap allocation.
+ */
+enum {
+	XDR_BUF_TO_SG_NENTS	= 8,
+};
+
 
 static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int len)
 {
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 62e07c330a66ff..4d8287337e69da 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -214,6 +214,205 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 	return count - 1;
 }
 
+/**
+ * xdr_buf_to_sg - Populate a scatterlist from an xdr_buf range
+ * @buf: xdr_buf to map
+ * @offset: starting byte offset within @buf
+ * @len: number of bytes to cover
+ * @sg: scatterlist array initialized with sg_init_table()
+ * @nsg: number of entries available in @sg
+ *
+ * @sg is traversed with sg_next(), so callers may pass a list
+ * assembled with sg_chain().
+ *
+ * Return: on success, the number of scatterlist entries used; the
+ * last used entry is marked with sg_mark_end().  On failure, a
+ * negative errno.
+ */
+int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
+		  unsigned int len, struct scatterlist *sg, unsigned int nsg)
+{
+	unsigned int page_len, thislen, page_offset;
+	struct scatterlist *cur = sg, *prev = NULL;
+	int nents = 0;
+	int i;
+
+	if (len == 0)
+		return 0;
+
+	if (offset >= buf->head[0].iov_len) {
+		offset -= buf->head[0].iov_len;
+	} else {
+		thislen = min_t(unsigned int,
+				buf->head[0].iov_len - offset, len);
+		if (nents >= nsg)
+			return -ENOSPC;
+		sg_set_buf(cur, buf->head[0].iov_base + offset,
+			   thislen);
+		prev = cur;
+		cur = sg_next(cur);
+		nents++;
+		len -= thislen;
+		offset = 0;
+	}
+	if (len == 0)
+		goto done;
+
+	if (offset >= buf->page_len) {
+		offset -= buf->page_len;
+	} else {
+		page_len = min(buf->page_len - offset, len);
+		len -= page_len;
+		page_offset = (offset + buf->page_base) & (PAGE_SIZE - 1);
+		i = (offset + buf->page_base) >> PAGE_SHIFT;
+		thislen = PAGE_SIZE - page_offset;
+		do {
+			if (thislen > page_len)
+				thislen = page_len;
+			if (nents >= nsg)
+				return -ENOSPC;
+			sg_set_page(cur, buf->pages[i],
+				    thislen, page_offset);
+			prev = cur;
+			cur = sg_next(cur);
+			nents++;
+			page_len -= thislen;
+			i++;
+			page_offset = 0;
+			thislen = PAGE_SIZE;
+		} while (page_len != 0);
+		offset = 0;
+	}
+	if (len == 0)
+		goto done;
+
+	if (offset < buf->tail[0].iov_len) {
+		thislen = min_t(unsigned int,
+				buf->tail[0].iov_len - offset, len);
+		if (nents >= nsg)
+			return -ENOSPC;
+		sg_set_buf(cur, buf->tail[0].iov_base + offset,
+			   thislen);
+		prev = cur;
+		nents++;
+		len -= thislen;
+	}
+	if (len != 0)
+		return -EINVAL;
+
+done:
+	if (prev)
+		sg_mark_end(prev);
+	return nents;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_to_sg);
+
+/*
+ * Count the scatterlist entries needed to cover [offset, offset + len)
+ * within @buf.  Mirrors the walk in xdr_buf_to_sg() so the caller can
+ * size an allocation that matches the requested sub-range rather than
+ * the full xdr_buf.
+ */
+static unsigned int xdr_buf_sg_nents(const struct xdr_buf *buf,
+				     unsigned int offset, unsigned int len)
+{
+	unsigned int nsg = 0, thislen, page_offset;
+
+	if (len == 0)
+		return 0;
+
+	if (offset < buf->head[0].iov_len) {
+		thislen = min_t(unsigned int,
+				buf->head[0].iov_len - offset, len);
+		nsg++;
+		len -= thislen;
+		offset = 0;
+	} else {
+		offset -= buf->head[0].iov_len;
+	}
+	if (len == 0)
+		return nsg;
+
+	if (offset < buf->page_len) {
+		thislen = min(buf->page_len - offset, len);
+		page_offset = (offset + buf->page_base) & (PAGE_SIZE - 1);
+		nsg += DIV_ROUND_UP(page_offset + thislen, PAGE_SIZE);
+		len -= thislen;
+		offset = 0;
+	} else {
+		offset -= buf->page_len;
+	}
+	if (len == 0)
+		return nsg;
+
+	if (offset < buf->tail[0].iov_len)
+		nsg++;
+	return nsg;
+}
+
+/**
+ * xdr_buf_to_sg_alloc - Populate a scatterlist for an xdr_buf range
+ * @buf: xdr_buf to map
+ * @offset: starting byte offset within @buf
+ * @len: number of bytes to cover
+ * @sg_head: caller-provided scatterlist array (typically stack-allocated)
+ * @sg_head_nents: number of entries in @sg_head
+ * @sg_overflow: OUT: chained extension, or NULL when @sg_head sufficed
+ * @gfp: memory allocation flags for overflow
+ *
+ * Populates @sg_head directly when the xdr_buf fits.  When more
+ * entries are needed, an overflow scatterlist is allocated and
+ * chained from @sg_head so that the result is traversable with
+ * sg_next().
+ *
+ * Return: on success, the number of populated scatterlist entries
+ * (counting only data entries, not chain entries).  @sg_head is
+ * the head of the resulting list.  Caller must kfree @sg_overflow
+ * when done.  On failure, a negative errno.
+ */
+int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
+			unsigned int len, struct scatterlist *sg_head,
+			unsigned int sg_head_nents,
+			struct scatterlist **sg_overflow, gfp_t gfp)
+{
+	unsigned int nsg;
+	int ret;
+
+	*sg_overflow = NULL;
+	if (len == 0)
+		return 0;
+
+	nsg = xdr_buf_sg_nents(buf, offset, len);
+	if (nsg == 0)
+		return -EINVAL;
+
+	if (nsg <= sg_head_nents) {
+		sg_init_table(sg_head, nsg);
+	} else {
+		/* +1 replaces the slot sg_chain() consumes as the link. */
+		unsigned int overflow_nents = nsg - sg_head_nents + 1;
+		struct scatterlist *overflow;
+
+		overflow = kmalloc_array(overflow_nents, sizeof(*overflow),
+					 gfp);
+		if (!overflow)
+			return -ENOMEM;
+
+		sg_init_table(sg_head, sg_head_nents);
+		sg_init_table(overflow, overflow_nents);
+		sg_chain(sg_head, sg_head_nents, overflow);
+		*sg_overflow = overflow;
+	}
+
+	ret = xdr_buf_to_sg(buf, offset, len, sg_head, nsg);
+	if (ret < 0) {
+		kfree(*sg_overflow);
+		*sg_overflow = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_to_sg_alloc);
+
 /**
  * xdr_inline_pages - Prepare receive buffer for a large reply
  * @xdr: xdr_buf into which reply will be placed
-- 
2.53.0

