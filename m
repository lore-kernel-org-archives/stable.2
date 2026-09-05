Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E227FD49
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578914; cv=none; b=NCRuSYJiMWXXUbXoPPGhPUpkpGU/d433SuGXxdt6TwE7Kxx4S+L+LmaD8s+tqmfKzv/rHrbM9mX1QhcNwWNb/K1UV0qruncDdfhf9ALXgzZPReLyx+fIjkNa+HFJBZqHFyE1ixHkfEfp7hHOab4pSD/63JO0U+6Ueqx46Y3XVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578914; c=relaxed/simple;
	bh=OymOp4ZJK4wXSI2/03E0VSNbbYIF/veV89UZorGbNRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDC/UHPczqGuWa2Md2EeQenHuLDzMdve6U3KE7ZsoMfZIOe2J/EGxxHo7G7P4RZDFMAWjZuea1lAF4XoxtZT+iO/msWZCSPgK5K744yyZ6121al/jcSk8Tt3H6CQwEwz3ItmjVgQUwUXIeLiqNH/N5wGAzvEuWcKquwoJxNFuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFTslS4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFTslS4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95701F00A3E;
	Sat,  5 Sep 2026 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578912;
	bh=Ac3EExgE9xQVibSiZO3HcjpAvMXJ8n6gonjaBwAGVqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFTslS4Hxa3ByQMho+XQz2S2v1rqVP/NMAOgDIVhpP7LSp6Z2G7maPRkgTYzkO8Kj
	 MJJxA1NQ7SliHH15cFBlazV+PPGn9bUACOPg0lgEsfxmUZr/yYT2SNXeuzJosCG5RD
	 7cz/oRK/ZviLmBBf8IRqjqadumVpOEVLu51WHVt4W/t6/fO74KgIGSujxsA6Gnp1kf
	 ZAS7jYYxN9tgREhxHtrPtbHF1v4Htiu3lEZVwyPap+W+ft3d59EZRF4W+CEPycKudW
	 yCuE3EVlO2776Lh4B0Ng8ks0MIpPL/5kZwUCtPg0I8xmXrAEVnoSteGthwXrbo3xaN
	 x0rUvlgvmEVGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] NFSD: Add simple u32, u64, and bool encoders
Date: Fri,  4 Sep 2026 23:28:24 -0400
Message-ID: <20260905032830.1915148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-dowry-plaster-fff3@gregkh>
References: <2026090305-dowry-plaster-fff3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6cc58291408bea96787d06ca3f5074fdfb3152ca ]

The generic XDR encoders return a length or a negative errno. NFSv4
encoders want to know simply whether the encode ran out of stream
buffer space. The return values for server-side encoding are either
nfs_ok or nfserr_resource.

So far I've found it adds a lot of duplicate code to try to use the
generic XDR encoder utilities when encoding the simple data types in
the NFSv4 operation encoders.

Add a set of NFSv4-specific utilities that handle the basic XDR data
types. These are added in xdr4.h so they might eventually be used by
the callback server and pNFS driver encoders too.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: ca94ba361720 ("nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/xdr4.h | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a83a52b0f5181..c2bc10051b228 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -50,6 +50,117 @@
 #define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
 #define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
 
+/**
+ * nfsd4_encode_bool - Encode an XDR bool type result
+ * @xdr: target XDR stream
+ * @val: boolean value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_bool(struct xdr_stream *xdr, bool val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p = val ? xdr_one : xdr_zero;
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_uint32_t - Encode an XDR uint32_t type result
+ * @xdr: target XDR stream
+ * @val: integer value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p = cpu_to_be32(val);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_uint64_t - Encode an XDR uint64_t type result
+ * @xdr: target XDR stream
+ * @val: integer value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_uint64_t(struct xdr_stream *xdr, u64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	put_unaligned_be64(val, p);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_opaque_fixed - Encode a fixed-length XDR opaque type result
+ * @xdr: target XDR stream
+ * @data: pointer to data
+ * @size: length of data in bytes
+ *
+ * Return values:
+ *    %nfs_ok: @data encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_opaque_fixed(struct xdr_stream *xdr, const void *data,
+			  size_t size)
+{
+	__be32 *p = xdr_reserve_space(xdr, xdr_align_size(size));
+	size_t pad = xdr_pad_size(size);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	memcpy(p, data, size);
+	if (pad)
+		memset((char *)p + size, 0, pad);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_opaque - Encode a variable-length XDR opaque type result
+ * @xdr: target XDR stream
+ * @data: pointer to data
+ * @size: length of data in bytes
+ *
+ * Return values:
+ *    %nfs_ok: @data encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_opaque(struct xdr_stream *xdr, const void *data, size_t size)
+{
+	size_t pad = xdr_pad_size(size);
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(size));
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p++ = cpu_to_be32(size);
+	memcpy(p, data, size);
+	if (pad)
+		memset((char *)p + size, 0, pad);
+	return nfs_ok;
+}
+
 struct nfsd4_compound_state {
 	struct svc_fh		current_fh;
 	struct svc_fh		save_fh;
-- 
2.53.0

