Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A736F8E5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615905; cv=none; b=tb5bHqUw7YYUblx+MIJaX+PpGI5rKPzxaha8c9qLWNI7E4knc4Hzl/jjc2fvuVX4IMHOf+kFOGrFoIF3fbq+js4vGjLmcUHhNTMmGW/GaKdOiiQZsDsJnVONFBTTdhBsUiCr5pa7Qa3cy80LoNBzfLBJOkKZvipSqr2UJAUO64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615905; c=relaxed/simple;
	bh=JwhXKdW0sWNXMzo/xRevUNZiBfrNWMBNq7DnMBaw60s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X92R9RYyB+fP6nmTtfNTpnBG7vTKfWdVZRCjrZx5BUgCgp1PDdNzEBYEzgpev7E0A5pPKHSXi3xIj1RfVFZTW7lgA4JplZCovNx2fENLPWm5Bqf7IEbFQfI5Px3d6zyPC2fveRJ7xb9XxNU1UBjnepKKS7s+VCcUIDYnlG7cbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp2OJ3xb; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp2OJ3xb"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso1950230a12.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615902; x=1791220702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0yuxDWmpoKKj7QiZdGLRK22y9dwu371MYeCVysLizY=;
        b=gp2OJ3xb8ZaIybKHfqornYEs8BhrBdbwtT3yrZkBNT9rbKDsaMGiP/itix7Bn3LndY
         JbA3gIrhRu4A/Gird2ZiR92016c4tfCVpaWT7bjAPhYlbHk6d3J663V2wAdYw8Ej9u0t
         WkDXBhpSXmTzzmxNTq5q3gM9itLp9Mj6owIcWGpQ1dq952bqa3WmRxFTxsMJixtjhYvA
         p5/RTEgD7kA4TotYkZWOfL/HE3WV9MaI2JNyTq4u8eIAcb+tnAcYbB6aw3IyOGcearG9
         QLKclfyfJynQw2qHueIzKiXls9z1rkH5yMXgr6c8dGuQrtiLl3wkL4TIh8XXvRAoRw3Z
         Buag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615902; x=1791220702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0yuxDWmpoKKj7QiZdGLRK22y9dwu371MYeCVysLizY=;
        b=KvJ4oXwVrN7TGyp0IMVVd2hnEC2qrINYgHELPfK4GJw7e9GBbFQo3y9/3TwpZhUbZx
         pIbEx6f6FsO4hSbmAeV1ycoGm6Yqlgb/aWU4cQf7q2zvqR3pPnSU104bftsKCb4GcdTc
         nh/C5xV8V7hsgXCnYIAiyI9S6vKXG3hleM+P91OjVze12UjcQuN4szpm9mvDPqyOf/yd
         ZgqG7zZsn1SSlfIKSOz4OEHzLyVS5ajfb1sy08hgWgxgOkf1bPdl8do7BokzRKM/Oo5c
         c+58xTyFoRKpmKhUXy/fv0ATRpjSl3JVmB/CgzKJZqZ5iTYbI/qzhXqaFdZUSX8xhP9U
         VsxQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1pp/PdJ+HmLyIgcORJ8mANqasH0S5GEFCKggpCEo8agoEzwtbCRYQGR/XWvsZVJ5Ixb7o6YA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg/5qWnQVswC4OvP4TLw9hR8Hbb0uixSMC6LDa0iDF296yfNk6
	UxbSNx/RxMJXKquUZx1a5oI+QRGrf5MclPllSVeriZzfhkw/WaU7hqSi
X-Gm-Gg: AYBFou3SxejdHCJBvYZUtasNtkPQ+J1ZPUB8TMDITdjLhJhyyFKYCj4vDVfIcmf/JW4
	iQRgkXbd/H9B7fSXknYGn/6EK1sAbRLwp4lQcBtgyZfHgUvD9N72pyfYey4l6SInNL09FmwmYfj
	OlgmIixScKLRui8t8WDs+B0jCc01+UotE7XxctWAZbIAPapHzgBS6x4MlMOTR3/Al2ztZ+o2g8S
	NSVGHqP9KvTkiNWfrt0nYAcdYoi1AFhxQuWOfTfdsg+8i7eCWiR4+Ntdt39o2Rcn7VV7Azjshjz
	kB3shPTH7MGaPG1XVPlooRnN+8rDr27lcR6NCChlSveWO4M6is7lL+ZGCFj+/n+axsO6fbi9/nA
	xkRyMwNcDpuK3dNXwgNey/Wwetv/LfNlbd4NdHcTG00Eq6fHmr9vr5wFmPvZRTBuKAfzUIDV6ma
	eeDCY5dLz3NJKsoBE7eaYBwo5teZ8v5Lb4bFisTsdEA1GcGq78OPG/JM1gg03yTAD09glslZg2k
	jmDsPIJ5uVUM/MIgE2Wb7HyaA8a1cSWC7A=
X-Received: by 2002:a17:90b:4b86:b0:3a0:ea9b:1e38 with SMTP id 98e67ed59e1d1-3a0ea9b31d0mr5772920a91.27.1790615902256;
        Mon, 28 Sep 2026 10:18:22 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986bb8f6sm189139a91.0.2026.09.28.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:18:18 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] RDMA/rxe: Take MR reference under MW lock
Date: Tue, 29 Sep 2026 01:17:53 +0800
Message-ID: <20260928171756.3254016-2-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928171756.3254016-1-cccccccccccc777777@gmail.com>
References: <20260928171756.3254016-1-cccccccccccc777777@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The responder validates an MW, drops it, then reads mw->mr and takes
the MR reference. A bind or invalidate can swap the MR in this window,
so the responder may acquire a zero reference or use an MR that has
already been freed.

Move the MW lookup, validation, and MR reference acquisition into
rxe_mw_get_mr(), and perform all of them while holding mw->lock.

Fixes: cdd0b85675ae ("RDMA/rxe: Implement memory access through MWs")

Cc: stable@vger.kernel.org
Signed-off-by: Dongliang Qin <cccccccccccc777777@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  3 ++-
 drivers/infiniband/sw/rxe/rxe_mw.c   | 34 +++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c | 38 +++-------------------------
 3 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 64d636bf80fd2..2cbec92566f70 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -86,7 +86,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
+struct rxe_mr *rxe_mw_get_mr(struct rxe_qp *qp, int access, u32 rkey,
+			     u64 *offset);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index bddb7a2578313..04f795adacf53 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -291,26 +291,38 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
+struct rxe_mr *rxe_mw_get_mr(struct rxe_qp *qp, int access, u32 rkey,
+			     u64 *offset)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
+	struct rxe_mr *mr = NULL;
 	struct rxe_mw *mw;
-	int index = rkey >> 8;
 
-	mw = rxe_pool_get_index(&rxe->mw_pool, index);
+	mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
 	if (!mw)
 		return NULL;
 
-	if (unlikely((mw->rkey != rkey) || rxe_mw_pd(mw) != pd ||
-		     (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
-		     (mw->length == 0) || ((access & mw->access) != access) ||
-		     mw->state != RXE_MW_STATE_VALID)) {
-		rxe_put(mw);
-		return NULL;
+	spin_lock_bh(&mw->lock);
+
+	if (mw->rkey == rkey && rxe_mw_pd(mw) == to_rpd(qp->ibqp.pd) &&
+	    (mw->ibmw.type != IB_MW_TYPE_2 || mw->qp == qp) &&
+	    mw->length != 0 && mw->state == RXE_MW_STATE_VALID &&
+	    (access & mw->access) == access) {
+		mr = mw->mr;
+		if (mr && mr->state == RXE_MR_STATE_VALID && rxe_get(mr)) {
+			if (offset)
+				*offset = (mw->access & IB_ZERO_BASED) ?
+					mw->addr : 0;
+		} else {
+			mr = NULL;
+		}
 	}
 
-	return mw;
+	spin_unlock_bh(&mw->lock);
+
+	rxe_put(mw);
+
+	return mr;
 }
 
 void rxe_mw_cleanup(struct rxe_pool_elem *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 02b16e2b49b8f..f5a957026fe87 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -468,7 +468,6 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
 	struct rxe_mr *mr = NULL;
-	struct rxe_mw *mw = NULL;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -520,26 +519,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	pktlen	= payload_size(pkt);
 
 	if (rkey_is_mw(rkey)) {
-		mw = rxe_lookup_mw(qp, access, rkey);
-		if (!mw) {
-			rxe_dbg_qp(qp, "no MW matches rkey %#x\n", rkey);
-			state = get_rkey_violation_state(pkt);
-			goto err;
-		}
-
-		mr = mw->mr;
+		mr = rxe_mw_get_mr(qp, access, rkey, &qp->resp.offset);
 		if (!mr) {
-			rxe_dbg_qp(qp, "MW doesn't have an MR\n");
+			rxe_dbg_qp(qp, "no MW/MR matches rkey %#x\n", rkey);
 			state = get_rkey_violation_state(pkt);
 			goto err;
 		}
-
-		if (mw->access & IB_ZERO_BASED)
-			qp->resp.offset = mw->addr;
-
-		rxe_get(mr);
-		rxe_put(mw);
-		mw = NULL;
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
@@ -605,8 +590,6 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	qp->resp.mr = NULL;
 	if (mr)
 		rxe_put(mr);
-	if (mw)
-		rxe_put(mw);
 
 	return state;
 }
@@ -894,24 +877,9 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
-	struct rxe_mw *mw;
 
 	if (rkey_is_mw(rkey)) {
-		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
-		if (!mw)
-			return NULL;
-
-		mr = mw->mr;
-		if (mw->rkey != rkey || mw->state != RXE_MW_STATE_VALID ||
-		    !mr || mr->state != RXE_MR_STATE_VALID) {
-			rxe_put(mw);
-			return NULL;
-		}
-
-		rxe_get(mr);
-		rxe_put(mw);
-
-		return mr;
+		return rxe_mw_get_mr(qp, IB_ACCESS_REMOTE_READ, rkey, NULL);
 	}
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-- 
2.43.0

