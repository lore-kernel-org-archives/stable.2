Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D54E80C1
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610842; cv=none; b=r0xJTBWaVi4kn2HQtSdLaltjsFJ87gG++sbTVighJ2zXaEykrhH6ZGgOi9tQYzt8hQMXGHJzM9A9ROjMUvEsNU2gQyaeUpmrEAodXJ9Q2eHmKbMNachg0X7s43OB9o6EdthNyR5qzZ8wMkdlZdPfpuY30Cu9xDUknO0HGwM8lzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610842; c=relaxed/simple;
	bh=JwhXKdW0sWNXMzo/xRevUNZiBfrNWMBNq7DnMBaw60s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCosJ6kDbOdtyy7QOTkUbIny5QPXWvvEZTxLM4up7iu2rgqGMyEr7OrqWBPo7xCWHMzz62J71sxQkX8paec1aNIG34MHAeHKfJtaPBaABVlelu2OgwyAmJmkfokHYWoavIb7nGVg5AXRwDnqq0KKMX9cRlkKNpV4KXdJmrUlSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZF+3x63; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZF+3x63"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1391015a91.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610840; x=1791215640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0yuxDWmpoKKj7QiZdGLRK22y9dwu371MYeCVysLizY=;
        b=VZF+3x63h+B6yqB3EMiF0r0b91sDrUYgnNE2YTnEjGQ382O+2UEoTfvikyvs3jdVly
         u/SyImr8dKrKwFjTERtTN+rU70WnUCsvv/RhISDPFu8jV2P31JyMTjspI/Xtzn5JKhnm
         vqiL11jxP9UVUBR6YeLVeI2+XmzA3pyMkxdyImf+Sp4h5ZCESjJZnGf43mLSiwKIGmR2
         RG84lLCS/sn8WlUcRpyrx3qayKomCNcOBQhfnFi/2hpica4kEQYH1WmlvWZ09H9iuJbk
         whtlmQjB3UOGQ6rvcOeuhtLNiP7Wco7JtCg2hr7DhqWz8Dj3AFNYUTNlEN1fkhmy3PtT
         u7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610840; x=1791215640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0yuxDWmpoKKj7QiZdGLRK22y9dwu371MYeCVysLizY=;
        b=pIn8GOGhhTwXvEvG2+5nYThC6/ddLJDxUL4jZiz2yjwq1F7fFZn4JGr7zzHJUzbRJe
         OgLoAVNtiabgEdbuCOTUAsivUVoVoGqbKuE9bHAwDgdqpA/h3MdBa8ihGXf2+XmVT6HR
         UihmCgK0NU6JYi1eRwwxZuQoVg8hi00J78zjD8EIfV0/dxjW2UZKDAS/zGG+BTnCPfYv
         pVL6+0EVJAR4znCL7XdlMmtnUcsq1ZbRMsvNbKk5JkSY8V22WnY8F9F2rrPJkoBDTiJs
         xDeVjAGrXgve7hNWYEnd2d9sIpkuvKC1IoGcwJeFrHDVFym1AfwiCcG+3SaSJf4rjIKF
         aokA==
X-Forwarded-Encrypted: i=1; AKwUvBwVKv5C1t7qlSiLu1XuU4Qx5QGd6hnshpvlPgYdt9E8lSlNHzRwON/VSOd+QJg4qLBkwh3SvCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtAxOd54wIlcyvDiP2vGV7scSW7hHb/sg8vzgpQ1MPU0YMeFgW
	RQ4Cdpqujy+icigup99PcLXXP+eLOwaAkVLbkenq5bdVNNAUVj/3i7BYOhwJjkM+
X-Gm-Gg: AYBFou0H/FvwkYW65OzF5aKDMB/Gcxi9aCf+0bXMyhRwFtEzVwRNhkEnjFPOfoe7q3v
	esueEUTDLpiJio0HFB7z2yFTYJfVnjZK+OFXHwLe5vh2u8fdPAJ85BjWd3eGxzCApY5nhZntffU
	Rny4XQNOCvGPK0bueFVfQHMoymgbBgs8/l/zz/eQYrI9YD+za7AelCRrjZh57QcaXY+cC8DIoVK
	bFAllewRCpYfyooJ0fl7kXlJBexkXvd1dyXv3lA2JZ2Uzf03/v09k+pyQ/B8HCpgOuP6JZHnOXc
	28iMyift4PuKilKAtPBAG65bgJOCyxorZxTzIZAM/pRHido8bIVMVviLBABDvY7J6QKTV0tws8F
	ciL1EWClJidwi41f7L1oonplBB4dBbpRd+XYzUzQEkoa8irlVxxNcdeWSwXQjRW0G9rwDWYPG/J
	Rll768apkwD2z/wJJb0/egnpD4fu6Kr4D+K7x7mS+B1l8bamSjB1o4uB0dVsA8/VyUPFtmoDfWl
	R3dC1oiALrxdJKvFQ3jEszz
X-Received: by 2002:a17:90b:3886:b0:3a2:b20f:21a9 with SMTP id 98e67ed59e1d1-3a2b20f2a8dmr3520938a91.30.1790610840532;
        Mon, 28 Sep 2026 08:54:00 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1905sm44269a91.13.2026.09.28.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:53:59 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] RDMA/rxe: Take MR reference under MW lock
Date: Mon, 28 Sep 2026 23:53:48 +0800
Message-ID: <20260928155351.3222978-2-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928155351.3222978-1-cccccccccccc777777@gmail.com>
References: <20260928155351.3222978-1-cccccccccccc777777@gmail.com>
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
