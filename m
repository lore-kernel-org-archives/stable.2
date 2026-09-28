Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C94EB87C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615919; cv=none; b=MO6L4GcAF/6dgjwYLpwpS0mxhL62a/fH08BuAV+2VN/aNKIF8Yf7gfxSeuqVVrmHZepQuPmzJq13qQQINtgb51LxbPIHqMEJf+/tWn3CJRiyQdV++r6WlLejBwi+yV09ONGIArHTpLlS7zu83tv+NPLhQ3i/fmt1DyLAyS4bUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615919; c=relaxed/simple;
	bh=tpRDS3QWQEz+EWPX/708eI/ejVeubEVNFCMjuV09I4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj7QXWHtDPpJfPREaZOFf61/DY6mejtKhfUBEUuhXWXOdIN8A4tmYxq0dBKBULYVtWDNbd3/9t8ZvTgCK7qeCwPCb3mPzozZusGEXIJZjl293UUOnqZE5TRGrFLCTEEDk1BFLVxox4+R4kHQWcYAvhb8kjFSGnIy7zhvl3ZkK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3nJ6bH/; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3nJ6bH/"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso9272a91.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615915; x=1791220715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2fwOkBrxfItcV7iU7YqqxJNyvpWradYv+am29lYRQI=;
        b=i3nJ6bH/6+SXD9eV+cHZybSoCH83UG6N5pbyqKj15RgHVyAjaBXzjiXSFWvJXRTPw+
         tR/iNHNfb4iCuRF0U645/YSfuN7xu44FI3J3GVVRSsxPGwHXcLYxPsCur+tOl5rU/GBE
         0IL8TtHu0XCN5lyAtCHalplWz4/PcrWo1RPU4maHVpOkWGCRHZci1buVHIQZPusLutmV
         /u32w7fiIYsuyBA7G2QKYmvmWNnnh8vE0SiX0+TJERP/HFICLOgGzEF7eTp7Ch5nJKKq
         tQBBvSNnEA70/Y3vT8Xu2OmMhgbMIyux6zwjUM0HRgnKXWVfU1keQ51C/cuT7ULb/lqV
         1BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615915; x=1791220715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r2fwOkBrxfItcV7iU7YqqxJNyvpWradYv+am29lYRQI=;
        b=K7pUC5dlu1NVLrxdI0VUODOisOpWyV3sSNPeeihbGrxQ4/Ao6HXYfKjv/dGKA42ICG
         NHnBWwEOxuhxNMPH/CAHWi24PVaMbpGuvDpzVi47JK2HfuBagCtfgPkl8wpH6OaMXXRa
         wBJXsEzX+Xn87r5mVu37kdY5N0bVv73tog12lBUMllOV4tGhuMmBrjqlwXbNvr1lerDI
         8o+5DTxhfYKRVvPl2+oecuai8cG3xqmu9wrAx2POOHHBefS0CM6bC0cEBolFGDog8OUl
         56g3oXJ38DNvhzcCTDZpL7vr0GCLrbVN3syPxT+JKJlueQfhS+K7YluRTak8zaLsWQSz
         k9CA==
X-Forwarded-Encrypted: i=1; AKwUvByjDgc+BxE5ejtXFyUX0jMhYl/1GWZOZ2lLR5CZdhEQ+KlI70C2ZugfoEF6L1orjQ5JVYkpCrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMMZd2viYKsmgm0/6cQAkHncRVA5dpAqB+ILJKtR4Tessh4WIt
	GWufur83o6YixDmwnwkvcf16JMe9UxB3oeVzOJH9MIIJk78ahZoRH69L
X-Gm-Gg: AYBFou0Lv/dd4TwDzLq9YR0t8v7ZtCAWCnDTxIT+1AagDGyKYpvZrZaASwr1FhEXZ+J
	LOjTidXR+G4pk4IZ+Y8yYqC/U1FyCy7NTORKL8XBMCtauHSR8P7hcyFCyESZGVhCDPAQPNwTrS5
	hfNuBmdd9mFXnSPXuJ9dR0nkY6Iys2Lwty37D3+O83DNC4dEY5+I/V3wQiDVcJeMprlMIkSb+NF
	0fFANdJ5kvUZijryPI8ov9P9rVQ741H7s0aNIQDvS5glzWiPKJlC9DEQF5MDBAFnvzsVt2b74EI
	+RcmE3vVUdp7CJKJXrRstN4jCP+KdqJAvKtSmRbnRwUQx5x62BA2BRwO6z+gGjBkBjCEOy9QqVh
	U38DGMcqmQ3YiP5pvPdcPpDa3gFg4b2yvkVz3c0SfajoRigmlaB01r3qo3bA03TKQK48N+wpEwz
	KzZH7yHF0+hrWVBtxnbTJPCBNf4mwbqOOJjpIMEQG+h78Js/+hmMb7oTdYczZuOHlrDEtlYwAFQ
	juNrIybj9LSKvMhKZ8+4F9g
X-Received: by 2002:a17:90b:1c89:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3a0ace4d752mr7661768a91.23.1790615914640;
        Mon, 28 Sep 2026 10:18:34 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986bb8f6sm189139a91.0.2026.09.28.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:18:34 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] RDMA/rxe: Do not force cleanup on pool timeout
Date: Tue, 29 Sep 2026 01:17:56 +0800
Message-ID: <20260928171756.3254016-5-cccccccccccc777777@gmail.com>
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

The sleepable pool cleanup path waits up to 50 seconds for the last
reference and then continues cleanup anyway. If a reference is still
held, that turns a lifetime bug into a use-after-free.

Wait for completion instead. A stuck object is easier to diagnose than
a stale pointer; the existing non-sleepable path is unchanged.

Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")

Cc: stable@vger.kernel.org
Signed-off-by: Dongliang Qin <cccccccccccc777777@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d9cb682fd71f8..d5ff5d453f5f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -178,7 +178,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 {
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
-	int ret, err = 0;
+	int err = 0;
 	void *xa_ret;
 
 	if (sleepable)
@@ -201,17 +201,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	 * return to rdma-core
 	 */
 	if (sleepable) {
-		if (!completion_done(&elem->complete)) {
-			ret = wait_for_completion_timeout(&elem->complete,
-					msecs_to_jiffies(50000));
-
-			/* Shouldn't happen. There are still references to
-			 * the object but, rather than deadlock, free the
-			 * object or pass back to rdma-core.
-			 */
-			if (WARN_ON(!ret))
-				err = -ETIMEDOUT;
-		}
+		wait_for_completion(&elem->complete);
 	} else {
 		unsigned long until = jiffies + RXE_POOL_TIMEOUT;
 
-- 
2.43.0

