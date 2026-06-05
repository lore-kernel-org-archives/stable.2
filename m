Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AD358D37
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679065; cv=none; b=pKHIG/j0ei9bgbTxJlLgFj2nSCWlsUv+kxlBIpTnSCwUMm/x2EDEZRUDeuam3uW5zf8dQz38LVR4pBAX+E4w1t5EdCaoomzZFA+IxQR7x8JzRWFSjMemkoD+TafGEpBwo3mRZDkpCn3BMPNNjLtl60F6KGUyz24XEiGoKYquXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679065; c=relaxed/simple;
	bh=qlOqJCumkmHJfJLiXXOXhCO/dxGSCrwCfvho3e9vArQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDu9zBn/QjDIeuMc9iPDyIl/NDv/dGjAQYyaRQVWAyQ4S4/3ukqEac8UymkJLy4QIW3N/vZOGH2YL2R/0rVQrTTl3vBaHGroE7EZGE1sf24Sf7LuYObHkCZsTo3cF3BHtX1bUXAWd0Qdv3hry9w+z3dcvnEfd2/ghJ90dWpPA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+c8TiKF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+c8TiKF"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39666ac91a2so32709801fa.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679062; x=1781283862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB08X2I3fy3wrkRM6VsdXZolE8SRqefSruMLGUvZ7UY=;
        b=K+c8TiKFsFhtazVJVRNzywEeWp31xZHpogsefp63IVsiZNG0J3VMXaj5HLrErarTpK
         melF8isolHsoW2o7ypPKwXLnVbfSbnuSWnwLOdeWc6p9ZY7MZK+pbfLm3maUTHG4zyl5
         geyZjjPNhZdmbNDDXsnkSFDg5aTBbpiI+dm2S9UtFj8QNkQA00bd08+4S257XstnlFCj
         RxbP4IdFiNJnU9T0SKkrt9SC+yXfCnUS7E7FDdvU4miqCzQai0qXN9nKqRp5zsJUjQ45
         sDoZKGc4xMMBLLxtDZFv1HKtpnUaYCKa3iyUPdNz3I9LgvE1W/Ai9lZHh6232m9jklWb
         4MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679062; x=1781283862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EB08X2I3fy3wrkRM6VsdXZolE8SRqefSruMLGUvZ7UY=;
        b=cKslB64ipY9MTkI6xIrBYBVaeAfv6IC6C54PZzHyE9l7qQtiCFq+z9eIXyWbY4Y9AM
         GZvLQlGs/XlgK3d3Tv9lLnrC3LsLFOsy7Kxb/nPvWZsFN2Uv9nrnp+D7uLCEXg7cFJXM
         ci93sR/3sLEp0rviJ0K56VflGdIIYYmsSVXgCSsipqrX/MFHDHWPXzJ/flWBuhEDLuvz
         xivIXa8Gham5qfAe79BODqCi50uw5td6LvxuMEu0CufAFOeiIL3U37U2KL+T53gjKcoZ
         6PRDhLXfI8sIBp8PlTHVZZURkUo8gm1wvbSrDcXusTNuaqJjTbuf7caXsRpI1BFihuq4
         jiIA==
X-Gm-Message-State: AOJu0YylbZI8WGP4KiarfNsjeqsv97QxfC6UzRqM6fya442EWrT+Wb4r
	W5C3Q4jQhKmbgT8BU5mkpNygeF2u1uHHrlqYwJsXwTzKJXFpOBrwKeqZwe3vdqCoNlU=
X-Gm-Gg: Acq92OHBeQeV7YXl3TO0kCkUxhNnAYacevOSE/EoakSDdBQ7zSJGEorSAeWZgZc/YdL
	ZaYTgHOjHwf6Yxrdl5Pko20tlx3xX32NPPEtghy/ogvRGGoZfH0+AP6YJo21eLJotPby8Pn0kqE
	+YhPxje9lzBt7tBx7vLdo7cEXYEKCDpjqddx3/OSMc1Dr/J70/YwCjTcepndJ9EPGQAhyFlE8wh
	cc/YS4BDKhm2obGm46sjGMHONzFn+Ml7OAxNZ8+/obaqhEDCTdbIBpZuRA+Q5nOkl4PVTYUdXKW
	JDYuTUZLkYUUJvj0LTD7HGi0hx+QufTWWNQraIN+442sI9GsYECGQQCelNOcPrcyFp92icYVKn1
	A3emtV/SOplRxwgnfxqxxelLfRu9p+qznWP6eEYiwgkkqsDj6dZ1uU7NZbt+3AAnQz1BNFrjFE1
	YGEZ1EzocOj28I+dPUgchtY+STmPaUm3Aw8+SQ8Gy5Vy6n6mEHtRV63kEg+cglnXsDgtGpLYQ9K
	BA2WgA=
X-Received: by 2002:a2e:a58a:0:b0:394:8fc:8c3d with SMTP id 38308e7fff4ca-396d2892d2fmr10213551fa.4.1780679062303;
        Fri, 05 Jun 2026 10:04:22 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07b66asm26931161fa.11.2026.06.05.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:04:20 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 1/3] Revert "RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task""
Date: Fri,  5 Jun 2026 20:03:27 +0300
Message-ID: <20260605170349.1524-2-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
References: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3236221bb8e4de8e3d0c8385f634064fb26b8e38.

The reverted commit is an incomplete backport of upstream
commit b2b1ddc45745. It added guards for req.task and comp.task
cleanup, but missed resp.task cleanup and left it before the RC timer
cleanup, unlike the upstream fix. Revert it first so the correct
backport can be applied cleanly in the following patch.

Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 709c63e9773c..05e4a270084f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -788,11 +788,8 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	if (qp->req.task.func)
-		rxe_cleanup_task(&qp->req.task);
-
-	if (qp->comp.task.func)
-		rxe_cleanup_task(&qp->comp.task);
+	rxe_cleanup_task(&qp->req.task);
+	rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.43.0

