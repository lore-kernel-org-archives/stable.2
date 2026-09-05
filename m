Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A037AA9F
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578915; cv=none; b=rUc/SxKCckPzCDnwfoOW9UGWPok43o23VaogpkBz87nxeAKmi6Nr0Dm0+qhlMRNDfnOijuRqAy0YQ/W9agFwPoYq7rEcKXZ/GIjWOX5Dc+AL372ZxIx/bTufhBmFvmoa3KaJvAZ8mVrzSuLnkRe8mfuL4CnOvi8gdc8V8uX4iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578915; c=relaxed/simple;
	bh=+G/8OW21oDn0JcikLUkZ2Z5eVjmbaWLd4wPolw/gn1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXmyR6hKKYHH04B6zZV/5OXGcuRXMzF2ZHB/OgZqNMTeo1q6pOFvfTNoqZZTMTSFDoFN0UnlR/0rO2YGL6kLrc7BPeor4JIZxpo0yNzfB2iwShb1EmxP1GQT0jdm2cTNsyr3oLGcegaDMJ2Zr68mITyIRzwEwJtBwnoppp3mfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD/iiM3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD/iiM3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958131F00A3F;
	Sat,  5 Sep 2026 03:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578914;
	bh=7GQrEdlWLyaL/Io9461jJhLOcv6jbtVNqV1x+rC2j40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aD/iiM3COretgt1wlN58eIiLsgzR2Z7PNT1RfhQppVjg+HjMrO9JxukbK2cikgUtl
	 M0gp2j2usW1GvcjsWbm1eNB+QwgU0VZplHSkueFsQGte01uFzmkzbCu/UYj8wyivt9
	 qlDqc9aJZAsFjg03zKfu8/uYQX9iWNT7Vol74lYo/D7oTnubTQmD7suJmxZFGckFAa
	 2sLNIDShI+T5rZiBc9XNI53rFjVXiDhIK16xN8NxMTfx+BvD+GXNyOtKppYp65wPR3
	 tPxRDXcazZot1A9MXKGvJeqHzQt7p7c86n3z8Nk0BEmSChX8lvW9q2dlW+TpfG4Azb
	 1BdkTdSyUXtsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] NFSD: Clean up nfsd4_encode_layoutreturn()
Date: Fri,  4 Sep 2026 23:28:26 -0400
Message-ID: <20260905032830.1915148-3-sashal@kernel.org>
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

[ Upstream commit 85dbc978b33be6f5e2e06e34b5219d730d5f9aa4 ]

Adopt the use of conventional XDR utility functions. Restructure
the encoder to better align with the XDR definition of the result.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: ca94ba361720 ("nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c |  6 +++---
 fs/nfsd/nfs4xdr.c     | 12 ++++++------
 fs/nfsd/xdr4.h        |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 84bb200e24ade..cf4149567d5c8 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -512,11 +512,11 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 	if (!list_empty(&ls->ls_layouts)) {
 		if (found)
 			nfs4_inc_and_copy_stateid(&lrp->lr_sid, &ls->ls_stid);
-		lrp->lrs_present = 1;
+		lrp->lrs_present = true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
 		nfs4_unhash_stid(&ls->ls_stid);
-		lrp->lrs_present = 0;
+		lrp->lrs_present = false;
 	}
 	spin_unlock(&ls->ls_lock);
 
@@ -536,7 +536,7 @@ nfsd4_return_client_layouts(struct svc_rqst *rqstp,
 	struct nfs4_layout *lp, *t;
 	LIST_HEAD(reaplist);
 
-	lrp->lrs_present = 0;
+	lrp->lrs_present = false;
 
 	spin_lock(&clp->cl_lock);
 	list_for_each_entry_safe(ls, n, &clp->cl_lo_states, ls_perclnt) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f45e46bec8c69..b3b2fa9b1f0bb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4770,15 +4770,15 @@ nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_layoutreturn *lrp = &u->layoutreturn;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(lrp->lrs_present);
+	/* lrs_present */
+	nfserr = nfsd4_encode_bool(xdr, lrp->lrs_present);
+	if (nfserr != nfs_ok)
+		return nfserr;
 	if (lrp->lrs_present)
+		/* lrs_stateid */
 		return nfsd4_encode_stateid4(xdr, &lrp->lr_sid);
-	return 0;
+	return nfs_ok;
 }
 #endif /* CONFIG_NFSD_PNFS */
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c2bc10051b228..74ba476002b5d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -653,7 +653,7 @@ struct nfsd4_layoutreturn {
 	u32			lrf_body_len;	/* request */
 	void			*lrf_body;	/* request */
 	stateid_t		lr_sid;		/* request/response */
-	u32			lrs_present;	/* response */
+	bool			lrs_present;	/* response */
 };
 
 struct nfsd4_fallocate {
-- 
2.53.0

