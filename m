Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA884534AE;
	Wed, 12 Aug 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542878; cv=none; b=eIuGsSdGZ7ENppBzCWzaMgsjMOcbC7uB5DdYEc1f7UgerhUdDJYZQ8ZdUHh1R4RP5muYc8aZrK2nOJ4SxMtqxRbX5ItfxAVDMaOFBfjPErW5c/ulLDkK2Up/1sk/jJN+Q7ReXGiTN0a/jPNgpsyiavnO2kVxFw7A68QvEtrHKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542878; c=relaxed/simple;
	bh=QxgzlcKCMmo0NxCf6azHPZWuVgA6au7/5HDeL25HztE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDdPyMxybanWQv6J+u+G9+ejhGCx3Te8zuInmqIMuIIb8vXLPkWTBmlb6e8hAp6aAnVF1aQgiDSIrMNetoxG/iu6EFewhS5LoyhnlnXQCW/TM8CzYOJm/0qXLmp38rskNNXOuYtXEObe+hNj4lII9QCMU+Qdil8krYPMWnV/kJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pM06hver; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pM06hver"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786542876; x=1818078876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=33zHuSFMATgkWejd4XM5GNS+7lN5snoFMgXxuVgp9sg=;
  b=pM06hverwcxZ96h2noZOWgho5MxDFOBUxx8ZdarYBXsb5UlawJExdCB3
   l+vURLkyWW0Uc3bSoQRffgDm9EhdOPPAoP4e8uHEGMaOj/pTZ4FKzqtNg
   ehbNDdI/UM2irsd+lRPZKKFuRXE3sv2kuBgsqflLoEtiT8IDDe/TAdKZW
   QutEP8OeWX7clMhyYUqQ5e6egKXyghvVZakVff5gQ7oSvh8yef01kcuPB
   CTvoAlOxj5WxqXHDHOUjSp9AGBn9JHAWnEgZ8o9gcjwA/i3WWUWp9F1A6
   HMk6s9YdO8jS0Pfba8AOwIkKEiCWiEAyGYfcCk4q2mr7TIDsxH+e95nEc
   g==;
X-CSE-ConnectionGUID: jwtVZPazRhqMuqnUlkdAyA==
X-CSE-MsgGUID: LMsunwowSSWySW4mZsQzRw==
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="25805697"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:54:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:8940]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.40:2525] with esmtp (Farcaster)
 id 35e2b4c7-9251-4853-abd8-f675fd3073d0; Wed, 12 Aug 2026 13:54:32 +0000 (UTC)
X-Farcaster-Flow-ID: 35e2b4c7-9251-4853-abd8-f675fd3073d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 12 Aug 2026 13:54:32 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Wed, 12 Aug 2026
 13:54:30 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "Jens
 Axboe" <axboe@kernel.dk>, Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.12.y 1/3] block: Reorder the request allocation code in blk_mq_submit_bio()
Date: Wed, 12 Aug 2026 13:54:10 +0000
Message-ID: <20260812135412.2715611-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 44e41381591dc5b4ea67a9f170b4ec85c817586e ]

Help the CPU branch predictor in case of a cache hit by handling the cache
hit scenario first.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20241218212246.1073149-2-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5bfaa8e4b9cf6..c1dff0d9f9439 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3121,12 +3121,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 new_request:
-	if (!rq) {
+	if (rq) {
+		blk_mq_use_cached_rq(rq, plug, bio);
+	} else {
 		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
 			goto queue_exit;
-	} else {
-		blk_mq_use_cached_rq(rq, plug, bio);
 	}
 
 	trace_block_getrq(bio);

base-commit: 25c09b42358e73e1476e517b296edb6344f2e4bd
-- 
2.50.1

