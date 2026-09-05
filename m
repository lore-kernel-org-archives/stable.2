Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C02D592D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578914; cv=none; b=H6O+QH+IbMeWcucSV9Sl5VPcqV8CgNnMjGEums0gtp3slJGWRE+tvu1ykdWmHBMO03nrRF2NLZ+6YHaSmB2TYO4240hRHgOJUEq/c4okNdKWvvHFpFgrrXZpOqrtb272ykkBRjkAfrT6TQZk9FrCDpugre/MOM1V7Qnp7ltGzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578914; c=relaxed/simple;
	bh=X+IEnHoIh0oXWpT4SrnBKxTO5g0FX1jl9qvpXirYO8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx8aLTfASPN7niakgw7PqRtQ8K9xf55j2Vja6YsgyVTGDOpNHPsmyYArZ0dcWJPpUHirJngCRv6ScWKFU5kIgGKfcH0trYwi2YqX7KR5cp92d2thmzkioPC6lBGpDgmtN0Zw9ZZNSHg8sMrJL2J5IZC802deYpn4oBYVeBqHGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXIGD5ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXIGD5ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74E31F00A3D;
	Sat,  5 Sep 2026 03:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578913;
	bh=iQVtdJlvi2EbEw+D7ON1SWJBs9T1PMok+fPefJfqxog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXIGD5zepDkF3YTH5WM24LWSIVIQVwuAF8pHqIwO/lGOXv5OdVHRh2AlNtNaLP3Ct
	 tGzUvUjOIaTVqANsVGGmp8bcgM4KwLhgsiUYtQj/fQ9LPRzWKz5LGOdyQcwQG0VGhG
	 jQSgaGd8N0bj5O7nEtmAm9roqzRWIE0rKkvFixgtmF2cE2swfhJSprwGGi+ieLcbWb
	 8iTnp+2BgXV9xIzLskqzNgPKcQUfqqmkO4AsyQx9EOY258tbj+t6pgSC6+CSXSb4OU
	 7dDGp0BS5ciFZODfi8mO/6BE3L/0tb/iMdXF1+V2Ng8eUOpSm+GOsvMMErs51SqMqB
	 soKofpd4RPn2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] NFSD: Clean up nfsd4_encode_stateid()
Date: Fri,  4 Sep 2026 23:28:25 -0400
Message-ID: <20260905032830.1915148-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032830.1915148-1-sashal@kernel.org>
References: <2026090305-dowry-plaster-fff3@gregkh>
 <20260905032830.1915148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 40bb2baaa8edecfc21a3c176e4af1a3445157677 ]

Update the encoder function name to match the type name, as is the
convention with other such encoder utility functions, and with
nfsd4_decode_stateid4().

Make the @stateid argument a const so that callers of
nfsd4_encode_stateid4() in the future can be passed const pointers
to structures.

Since the compiler is allowed to add padding to structs, use the
wire (spec-defined) size when reserving buffer space.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: ca94ba361720 ("nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52fe95d02fc47..f45e46bec8c69 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3713,18 +3713,18 @@ nfsd4_encode_clientid4(struct xdr_stream *xdr, const clientid_t *clientid)
 	return nfs_ok;
 }
 
+/* This is a frequently-encoded item; open-coded for speed */
 static __be32
-nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
+nfsd4_encode_stateid4(struct xdr_stream *xdr, const stateid_t *sid)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, sizeof(stateid_t));
+	p = xdr_reserve_space(xdr, NFS4_STATEID_SIZE);
 	if (!p)
 		return nfserr_resource;
 	*p++ = cpu_to_be32(sid->si_generation);
-	p = xdr_encode_opaque_fixed(p, &sid->si_opaque,
-					sizeof(stateid_opaque_t));
-	return 0;
+	memcpy(p, &sid->si_opaque, sizeof(sid->si_opaque));
+	return nfs_ok;
 }
 
 static __be32
@@ -3768,7 +3768,8 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_close *close = &u->close;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &close->cl_stateid);
 }
 
 
@@ -3872,7 +3873,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
-		nfserr = nfsd4_encode_stateid(xdr, &lock->lk_resp_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &lock->lk_resp_stateid);
 	else if (nfserr == nfserr_denied)
 		nfserr = nfsd4_encode_lock_denied(xdr, &lock->lk_denied);
 
@@ -3898,7 +3899,8 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_locku *locku = &u->locku;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
+	/* lock_stateid */
+	return nfsd4_encode_stateid4(xdr, &locku->lu_stateid);
 }
 
 
@@ -3921,7 +3923,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
-	nfserr = nfsd4_encode_stateid(xdr, &open->op_stateid);
+	nfserr = nfsd4_encode_stateid4(xdr, &open->op_stateid);
 	if (nfserr)
 		return nfserr;
 	nfserr = nfsd4_encode_change_info4(xdr, &open->op_cinfo);
@@ -3944,7 +3946,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	case NFS4_OPEN_DELEGATE_NONE:
 		break;
 	case NFS4_OPEN_DELEGATE_READ:
-		nfserr = nfsd4_encode_stateid(xdr, &open->op_delegate_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
 		if (nfserr)
 			return nfserr;
 		p = xdr_reserve_space(xdr, 20);
@@ -3961,7 +3963,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		*p++ = cpu_to_be32(0);   /* XXX: is NULL principal ok? */
 		break;
 	case NFS4_OPEN_DELEGATE_WRITE:
-		nfserr = nfsd4_encode_stateid(xdr, &open->op_delegate_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
 		if (nfserr)
 			return nfserr;
 
@@ -4019,7 +4021,8 @@ nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_open_confirm *oc = &u->open_confirm;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &oc->oc_resp_stateid);
 }
 
 static __be32
@@ -4029,7 +4032,8 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_open_downgrade *od = &u->open_downgrade;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &od->od_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &od->od_stateid);
 }
 
 /*
@@ -4773,7 +4777,7 @@ nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr_resource;
 	*p++ = cpu_to_be32(lrp->lrs_present);
 	if (lrp->lrs_present)
-		return nfsd4_encode_stateid(xdr, &lrp->lr_sid);
+		return nfsd4_encode_stateid4(xdr, &lrp->lr_sid);
 	return 0;
 }
 #endif /* CONFIG_NFSD_PNFS */
@@ -4792,7 +4796,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 	else {
 		__be32 nfserr;
 		*p++ = cpu_to_be32(1);
-		nfserr = nfsd4_encode_stateid(resp->xdr, &write->cb_stateid);
+		nfserr = nfsd4_encode_stateid4(resp->xdr, &write->cb_stateid);
 		if (nfserr)
 			return nfserr;
 	}
@@ -4976,7 +4980,7 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 	*p++ = cpu_to_be32(cn->cpn_nsec);
 
 	/* cnr_stateid */
-	nfserr = nfsd4_encode_stateid(xdr, &cn->cpn_cnr_stateid);
+	nfserr = nfsd4_encode_stateid4(xdr, &cn->cpn_cnr_stateid);
 	if (nfserr)
 		return nfserr;
 
-- 
2.53.0

