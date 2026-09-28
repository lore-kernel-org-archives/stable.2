Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79C4E8DF5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610853; cv=none; b=WUfPEsv3mtrm2rPqOZcDE6BLZbFBpZEAQiwTxmM7ELf3O0rSkjxBO7F76MNPicm68mSyvgv/OkvqxPBya4ubQFtnjRef9bfr9l2ynqwsLMk74qm2nDkEF8mRp2KbWemGDii/NyNOS8NeFCmvU/913GN1YK4fnyb195AnRDJhDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610853; c=relaxed/simple;
	bh=tpRDS3QWQEz+EWPX/708eI/ejVeubEVNFCMjuV09I4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS0gZAeQSd488zu1/jLLyQW4hiNTnmBROuFKMBPQ/7Lzj1nG7x9mE8jUEMU0AbRgMk7V+8LPsCyknLYA8aPXDrtpZuTqqCfCney4/XPMzh1OcnRZF97bRxRuExEWD3Q59/ujcX2pPCtmBrDWhTMwYfUQs4/wWRdHWIkJ0FOl8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibllbsM+; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibllbsM+"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so935045a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610850; x=1791215650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2fwOkBrxfItcV7iU7YqqxJNyvpWradYv+am29lYRQI=;
        b=ibllbsM+vRpIIDgqD5yZhOk+MsIhbuZbpNTKeoahRODos+/uy1RBI63dP98D4Nm3X/
         TadlFDW93IHO2mkRnuyidyWmtmWaM7WD4dufV/toI2nQhZE/3TfzD83QVYC2/KKc0ORS
         tkt4w7C94QHZHfGl5lxplnu+PbC9jL3alRt/taqHF6EZ9gzGP+U29cfjc/PMi0fjasRv
         fvap/9TweqtF4GBMBN5qkUToPZ+7N5bODDcWKzS8BqodBk2vFy6ipMuJzP4ElGbNeoBa
         FEC8F2Q0e1rc0extEfFsu/EDPMjJY72XDFJisjysfwyjgphN2ryk6C8MipyHMJ6MT8SZ
         SUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610850; x=1791215650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r2fwOkBrxfItcV7iU7YqqxJNyvpWradYv+am29lYRQI=;
        b=XcAfZd7RM/udMZkfBFsNa4TBZhiNKmYDNTkWDreJU5+cC1MCYCN4swrJ/d9GimiWfY
         eA9RDRLDMIuVE4b0RsxFqmJPtuKJWRRi/D6/yzSJ+9eXDfP3NotYp5ny6tbSEBYFSoOS
         g4qCH4/+N5A+v0QK/HWRSFm5YMdG7aeV6LQOvHwbQ31ms0Mg5qOHs+oLfwH7xt2vuG/+
         u+YYk+sTETccBv+US1bqRP5nwxBMrODC0QBu0Es3N4nTKmof33Xe2VWzXcndSSXD7bgm
         KnmvinJ/GH39rgSRuu1BlKhZWXKQoCBjXxqCGx9BLQX1U1T78VdCu+l+Y0zuBCZj0w9Z
         I/rw==
X-Forwarded-Encrypted: i=1; AKwUvBwy5M3olbf73/Go4qsXGiYzZT7Xe3IUG3ZmpzDcV/3FStXhIBG87LG7SZvdr+nUhviSvsMUIa8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLylQqyw8kVRhCMxiaLn7XNNySC9KfV8A4tNim+nksAX7JmaF8R
	ck+FHd9N4Wtz5PLATnzCINfFtzFghMZwmqIrSZLlBuQLs9BWkrqzFAAz
X-Gm-Gg: AYBFou3lACeq2ohEy7Z8bSwuDOCGrBSajZtYYKHimdqpk2sETLgjJM6D/iAcgYKw7nj
	PloITIedumie56VQdKC9yj1IetwdAilEfk4Z0wG2h5dCOKB9WuYam+XHav7/3CVAHKKbezQTah7
	rgW7Lty/6o998XPVd29FYEq0kOjdomGrpRprNVoIXX3ZmNycJ8lH8mpKg9mUHL4OIwMlMmSvs0V
	vHS58TyJHbj/cWJGTljD+dlWa0yF9tYiXkHvvtWCcUNIinrWy7Px4SbTK95V/HRyQ0u7pIdjOQF
	HbJwilJEiN6zqAaHn50ApR4lBWkgz7efR6sDmNCaR/zcVqI9m4IqqOoWNQSzLl+lxiCRXp26i5u
	IwjE7AJgCcM32OoJpLu421IGO7+ezjoWOUhCv77f5s7Wzu1t8k5qsSNOL2Li94WcDHUarRSN54t
	AmI3Sc3ddMnixe1u3w06Gi/T383GDle5hriQqwguhExvqbMn5VxgpzdOwJjKKh4coMJUjx3ngg6
	WdJnCBI8O+Cef5y+H2PuNmm
X-Received: by 2002:a17:90b:1c83:b0:3a0:cde8:1dd6 with SMTP id 98e67ed59e1d1-3a0cde82a7amr4463595a91.6.1790610849810;
        Mon, 28 Sep 2026 08:54:09 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1905sm44269a91.13.2026.09.28.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:54:09 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] RDMA/rxe: Do not force cleanup on pool timeout
Date: Mon, 28 Sep 2026 23:53:51 +0800
Message-ID: <20260928155351.3222978-5-cccccccccccc777777@gmail.com>
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
