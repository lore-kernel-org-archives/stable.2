Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41648449B01;
	Wed, 12 Aug 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542888; cv=none; b=OmF5LGr1RqyJlvKQpzj8AFyZaPGiR28s7ZfE8VD510bFqEKETIcJacwIJlnSNkfAG0LAD8LWkQ5FdTYeMXkfEv0uKOFb6+ElVt34QCxSRM5DSSJF9OD4fX9zXiQVblq25J+6pLv9MgQoDwLfKiIh2RuaqCBsRThP/74l67QV8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542888; c=relaxed/simple;
	bh=iowpejRHtSrfdIQsJ1szGel4Wab20LgH26SlaKTKCMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RI8Tq2yUiKjVti+ViHb1Qc2vkVhbBhIywjl0T6U6iwxQkCqHJW4OB6VfU9MjqY9sLIx2dRmvTMF1GloFMJ8BXgWoOIflyavn6QGnEEqVo6ZyGmsmATjbnTxhwfBTgLS2n82sF9ZINLgqukJDenWRfnTjdRZjearjiFdCB8YU+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=oEjVuQsv; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="oEjVuQsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786542884; x=1818078884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WPN8Dw9AB8LQ+Cq5SIEEU0MVZZqjnFNzR0F/OunlqTw=;
  b=oEjVuQsvGa7TAft3ODdAcuO8IwBeZPN9wyoi9TTr+VwW65RND39LOuwX
   pYITfLXFdSh+9SQeaKs3lmOpgtcJBGf78hNoSfsyhL1w3ekeYn7qPGy5b
   j3l5QKbWOXCKPx20U4CZXhAIjlNH2kCJuM/pCNcE8JoNHCFBJkR9zzs3D
   pkPrfmmn+eJ6XhC09zZA/02QaV98ukuXyj5jo6Fpm3cLnVtJV1LF68SPh
   ypEHWMJ6G0G5pMzuKHjqLKv2vgoh3+EkQhoLU+LXJjBbfWEM7sUUoad7w
   MRY16rgk0HtikPsOGYmAtgbLafzAvZt3yPyqFYF7AIFO2oow7W3KH2zyk
   w==;
X-CSE-ConnectionGUID: +mY2SUxLRaCIZJ4kwjlsCA==
X-CSE-MsgGUID: 2cl7kr7XSuCDKcqLy7jj3A==
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="25539396"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:54:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:6417]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.160:2525] with esmtp (Farcaster)
 id 1bca6db3-1c6a-4f62-b94e-9e60b8d7af0d; Wed, 12 Aug 2026 13:54:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1bca6db3-1c6a-4f62-b94e-9e60b8d7af0d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 12 Aug 2026 13:54:38 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Wed, 12 Aug 2026
 13:54:36 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "Jens
 Axboe" <axboe@kernel.dk>, Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.12.y 3/3] blk-mq: reinsert cached request to the list
Date: Wed, 12 Aug 2026 13:54:12 +0000
Message-ID: <20260812135412.2715611-3-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812135412.2715611-1-simonlie@amazon.de>
References: <20260812135412.2715611-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b051bb6bf0a231117036aa607cadf55be8e63910 ]

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://patch.msgid.link/20260526153531.2365935-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fd21976375ed4..6af42682af7d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3154,7 +3154,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_add_head(&plug->cached_rqs, rq);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.50.1

