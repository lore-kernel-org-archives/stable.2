Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42534539768
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075090; cv=none; b=R/+ZDcxwg1pZcOdtbWhwXBw1vG6MB3j1a12AWkvjJPTP/tmXtoTJMTiFvaU6YTStFI3PVKyg2tOMtiKMJJ5lCY5CW7EeRWSO93g6TYo1HWYkZgN+LRxAV/e72VQeoBoHwwxg6jM7A20ev/nBOjE8EV8ajzG8ZVVchnisejve1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075090; c=relaxed/simple;
	bh=32aH47hFfn2ebKqOTTpsa69UUAxOhhzVtCQmPzpOxZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If2opD9zxN4ybxOx2xwaEETyw0JdpvB3723Li05aTlzvaXH8izXFXkzr2frsIJKdI5aCMc1xzDSLAZpfYpqsQHqXtMOn9y+GE6obsFYmM+TINzfxlOEqQkLPoFssDwt8XtUW/Ko+TCez5JthN3pbpl846qgBWrJsOT9AW0s1cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xlo12TR1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlo12TR1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so27651085e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075087; x=1790679887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGEvhAqnvDEHHdRehvO7izpAHuYtg43TWezkfW2SqzE=;
        b=Xlo12TR1FQwL6WS/+HKsKoPG+fmRSUJIonx7WgU+nSSSxZ9rxFxkbRxXmKIxyKOlDn
         EQdrw9/aiRDh7L+M57ZqdtkQZT5qmPOH6DUOjIwhkoTrlHLrcf0TaOijltIntub4dO+5
         VCz0Mj3YKNxxAUoDVvRGhA2ONTsbyvDHR98uRNYDdrTk4z40pbui1MX5XzSiZTKHvDOX
         jiKlaC9L5CnU3coFFEEHSgKtAuIncaLOQ95QUY+V4fRsS23zvlkd9F3sUmQbm3fj5FTj
         /KEjQIF0CBXCfMVxGQ2cPb5zWW2dvD6tmIFIYpUvkbv4baY4BuJ3MpXznu5GoZ8ixkYk
         Eiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075087; x=1790679887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGEvhAqnvDEHHdRehvO7izpAHuYtg43TWezkfW2SqzE=;
        b=BInX0hMMjnumyWIR48GVgpiktZKdaHB80RhKSSFqSiiMXLTmhPqf03tGCLHoOcGAmg
         3ovVsFXpuv5pie0QyC0i5Et2l+A4lcH2yEDzzg3YpW+YL5acqVFRv0834oxCSJFWxhtp
         yppNU4kOjjnsyziIyIxWDxnbNrI7/q0JUvghX/eTtux6O3LwKtuIoRKzv5zAtU+oky6v
         fMSwbQWHzvOBv9ZS0EpMkkndw7Gjmcctx0dH0lKyqtUCqsEfSbnLNey3vnsMNN7iCJcw
         hqyWmRVm+e4wYflKI1TETYxGFxgCalVTSrzNMyrBSge0JiIMiI/hkyJ/WEaqnmnuZ9Xt
         QZ3w==
X-Forwarded-Encrypted: i=1; AKwUvBxOC5ozLi1sdSWTSHet0zqVjE2lFIQ0JhtlzvVhNuE7cpu508/7t0vvU3OYmtLwOM7aZw9jxRE=@vger.kernel.org
X-Gm-Message-State: AFuF++mIyrqsHG+Hc4NmZln0baQVg0+jGzNW2Ylc2NlrXHlUlpIR6IXX
	MqJTDLgHRAPU+xN/bFzquECr5jUUExhTQPaIE4VaoyJ3XftXzxlEhzXy
X-Gm-Gg: AYBFou2P4J/7pSgA0CLeQZlEk8P77GIoP5+UyrdnB8OryVAmIW5KHl7tvqS6x6JSBtc
	8h4oPqy+QjLpQKvmLB5gFCOOYggONxRfgBgO8urmx4vx1i5sOkJf2UYsATDpV1Q9PyX5odVB4ZU
	v+J5kgJqpVw7yObL6o81+sQIxW3LtF7kRAfG6lgEbYrYBbIAUxikhsDdwe5aniQBTvj6ytiS6BY
	d4abNRXis16vHe2P1ZRCaHXi1wEEgXv3GO4lveo6f+ELEjOkRFKTtjb4V7lUrHInKrkhJo4o3Pt
	f2FZYW4wDHSCHULPHLS+GpXV4ijqtUmk4RGoAS6UfIF3ZTqZ9ZfuR1a4wVn7nvdH8pwg+mzD3pe
	Kbuf+PlQ4xSjD4EnJ4w/DRtUXdLUrtJkJ9nj55e5BgB241oV01qjznF/JRB0y4edcqyuNGijUOA
	tLS6ZUsVVmmREL9hDJBe495P7HPbHk/b5zFkCoeQyU9FbdpmfD2xy9v9FhjTASayBQTmUGMat12
	ll+8qlaebI=
X-Received: by 2002:a05:600c:81c5:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49fc5737cd1mr170147875e9.17.1790075087310;
        Tue, 22 Sep 2026 04:04:47 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:47 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 20/26] xfs: don't let memory failures leak blocks and kill repairs
Date: Tue, 22 Sep 2026 13:02:15 +0200
Message-ID: <20260922110221.1431-20-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM complains that a memory allocation failure in
xrep_newbt_add_blocks results in online repair leaking blocks that were
previously allocated to write a new btree, but the problem is worse than
that -- a limitation of the codebase is that the callers cannot undo the
transaction /and/ return the error -- either you undo all changes and
commit the transaction, or you error out and the filesystem goes down.

However, the new btree space reservation object isn't that big (~48
bytes).  Let's just do a NOFAIL allocation and the problem goes away.

Cc: stable@vger.kernel.org # v6.8
Fixes: be408417630427 ("xfs: implement block reservation accounting for btrees we're staging")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/newbt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index c82f4631fd9c..584076b2a6ee 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -193,9 +193,11 @@ xrep_newbt_add_blocks(
 	struct xrep_newbt_resv		*resv;
 	int				error;
 
-	resv = kmalloc_obj(struct xrep_newbt_resv, XCHK_GFP_FLAGS);
-	if (!resv)
-		return -ENOMEM;
+	/*
+	 * We have no way to clean up the allocated space *and* return an
+	 * ENOMEM if we fail to allocate this control structure.
+	 */
+	resv = kmalloc_obj(struct xrep_newbt_resv, GFP_KERNEL | __GFP_NOFAIL);
 
 	INIT_LIST_HEAD(&resv->list);
 	resv->agbno = XFS_FSB_TO_AGBNO(mp, args->fsbno);
-- 
2.55.0

