Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC7432E79;
	Wed, 12 Aug 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533972; cv=none; b=hHy2P29GsoQ4w+sZ0ySrdLmv6E1y7Y0nI6GEk+XHe0KBfL+eMvANUKyx5fAexXoLUJ6sHEYN3CW5+zRuFtFhXkyrCiQs2/+gub59b4AwLiqC3TKzg9UUsITKEgnPLx+WVAB1jKg6FOxM54UpESOrSHEB+jCbml07xT0UyRMbP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533972; c=relaxed/simple;
	bh=uv53WcbsKOrF8iJgaBGwXGm83/Vu6iXz+wFFg4B7/LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yy0e1HZE/6nFw3v9+W0aBuf4LukH6cj6qaiZEGzEeixZtO61S8LNx9D2ZrQPmcS7Jn0j/RQGl1ZEpgc7hvB6jolQLGl7M17caLX/Ve0OyWcVJkJECnsQVa8TjR8Ae8D+TeaZizLpjPmyFTPeJkh0mBAICgJWlpKIlAjiFMzTSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=TQvFICDp; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="TQvFICDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786533969; x=1818069969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8teenXvLCG/sKD2r+AHFcPrM5x4zCwPCSlktQfeX2w=;
  b=TQvFICDpVJwEjXtNm1AAWAVhrZ8gihUwLTGqiNhte/9HVxAiMunJ8w31
   nWCzHx7MvOH7cF2Cp8Krjez/i9cuZrig74D+/geVn+3ST4nm/9kYJgv3t
   b0INel199plVRapYNqz1pJpxGaKpNGMiDYsT6Zx0f+D6sgF8bKAPczppB
   Tk6zUkZ59r9u95UFWKdxOFrflZ2UzNV+Naez6zQYSqn9jks/fpE0gShdP
   Lj5YfmjwW9o2yUpMCP+RNXyBIUcP4cyFg8Jio1yoc3Em+1G6fVNKPdyWb
   6bF/Ol1/mIuckbhL7h5C8JeTZZqHjSNPGMcvtALYnas/gyX2psjn37cS3
   w==;
X-CSE-ConnectionGUID: h3xScEA6QDKGk8RHoafJOQ==
X-CSE-MsgGUID: FrICRSFMQsWr0sKg1kGgdQ==
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="25566010"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 11:26:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17434]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.40:2525] with esmtp (Farcaster)
 id 689117cb-055d-4586-9de3-8ed0ce470974; Wed, 12 Aug 2026 11:26:07 +0000 (UTC)
X-Farcaster-Flow-ID: 689117cb-055d-4586-9de3-8ed0ce470974
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 12 Aug 2026 11:26:07 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Wed, 12 Aug 2026
 11:26:06 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "Jens
 Axboe" <axboe@kernel.dk>, Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.18.y 2/2] blk-mq: reinsert cached request to the list
Date: Wed, 12 Aug 2026 11:25:45 +0000
Message-ID: <20260812112545.2630000-2-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112545.2630000-1-simonlie@amazon.de>
References: <20260812112545.2630000-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
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
index 711d295d36db9..56158b70d0c72 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3224,7 +3224,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_add_head(&plug->cached_rqs, rq);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.50.1

