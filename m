Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=38.105.238.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217730;
	b=RMUhXkCqPEOqx6GX1nZT9/JegTcH7R6T7dNGCGyJhBD9UY3UskW97v7cFrjc+4xyi0EM
	 x1W5JxqBuNx9xbGL4Cnhk5IneHg2nSOuYCArtMPQxFRQB7AY4QxoM6Vrk11EqxdidUInn
	 9jkRv5FyPib+1cpvoP9hnWXBPKFVLn180bvWMHl/lgRZRLmnlgJcUMZpO/3KSSodjWeVS
	 hyG3xJSMoSeeovpu6RuyD103gzhcH2z7jsz1Ob/au9EXAmo483TfUSI5FqQHNGjJNQeOp
	 QJwwd3IuR/GALd7exaYeqo4f7dzoZN0DZyhWM4+4GPqFVbrrnSzyHDSSow/VRNxOu6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217730;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a9D/kK9gQlIjVthHwRyaiRqGMNCncfyL071uR14t4wU=;
	b=1ntQHcBpgJ4sBhLXM+R2eRP4kY84itMWOGqd8wLdly1RQ8xvH7S2kdW20IXXQcMJnkWY
	 0wwkD1gQLDUJ3ekvCyRz6DGXaIENDtIdgmYO012YK0FNJOPqtCLYCwCB6AsVp/bGBfWJa
	 DkZBCv+CDsQavSaCozyKLbTA2+Z/lSq55IzUmSimDAIUEg64NC/M7Pvhan2HTiAx/ICRi
	 78c7CE5/yikEvKFNMXbQBiGumPKJB0CFRmkpiaDRqPAqIfaTetj+fGPlmVYw7OWpai+Ve
	 J81BRDcmFS2TxGdY0G3oqMonrOklNr3CENhQkBuCUtrJskf7uIyCZ5DpAIQLGHnyWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hudson-trading.com;
	spf=pass smtp.mailfrom=hudson-trading.com;
	dkim=pass header.d=hudson-trading.com header.i=@hudson-trading.com header.a=rsa-sha256 header.s=postfix-20201111 header.b=bDkrRHWS;
	arc=none smtp.remote-ip=38.105.238.108
Received: from smtp.hudson-trading.com (unknown [38.105.238.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6029606A6A0
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6029606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hudson-trading.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hudson-trading.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hudson-trading.com header.i=@hudson-trading.com header.a=rsa-sha256 header.s=postfix-20201111 header.b=bDkrRHWS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hudson-trading.com; i=@hudson-trading.com; q=dns/txt;
 s=postfix-20201111; t=1795217713; h=from : to : cc : subject : date :
 message-id : mime-version : content-transfer-encoding : from;
 bh=a9D/kK9gQlIjVthHwRyaiRqGMNCncfyL071uR14t4wU=;
 b=bDkrRHWS3s6BioS0yCRuDxfDLUv20Qe10TRCKue/PiaK5oFNnpVEEl+tOkWAhi5wfhz9U
 nXzj+y3kSIVf5swLh/4jeXofaQ2M8pZJK4Gi69toJ6oAWhX7YDTfOOc4WDUL4eNJpG/hVQn
 fCjtvWYcRmdoJ1wJN7iLU6GD9YPRBckIvbnQXlg+ZHtzKvH9D3PTBihrChukBdWRSXa9Lb2
 0+BpPQ1PrjqRhOwZ8PHTvlOXwhOMco2yrvCtdMiSYmi1Ovk1vx2r4zLxEgO2azhQSSS7GtE
 F7Raif2PbuHFGeT0LahGTjjqkgYbmYzjvQsqTazoLM6hOKvZsqb3j0yF0Leg==
Received: from shauser-sthiell1.hudson-trading.com (shauser-sthiell1.hudson-trading.com [10.20.74.239])
	by smtp.hudson-trading.com (Postfix) with ESMTP id A800421E57C;
	Fri, 20 Nov 2026 18:35:13 -0500 (EST)
From: Stephane Thiell <sthiell@hudson-trading.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	sgogte@purestorage.com,
	Stephane Thiell <sthiell@hudson-trading.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: don't free I/O queues before cancelling requests
Date: Fri, 20 Nov 2026 18:35:08 -0500
Message-ID: <20261120233508.379363-1-sthiell@hudson-trading.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), the error path of nvme_rdma_setup_io_queues() frees the
queues of the batch. The caller cancels the outstanding requests only
afterwards.

This matters on a reconnect. Error recovery leaves the I/O queues
unquiesced, so a queue that went live can have requests in flight when
another queue of the same batch fails. The QP and the MR pools of the
live queue are then freed under those requests. When
nvme_cancel_tagset() completes them, each request with a registered MR
ends up in ib_mr_pool_put() on the freed QP.

Only stop the queues in the unwind, as nvme_rdma_start_io_queues() did
before that commit. The caller already calls nvme_rdma_free_io_queues()
after it has cancelled the requests.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Stephane Thiell <sthiell@hudson-trading.com>
---
Found by code review, not reproduced. Build-tested (W=1) on
v7.4-rc3-602-g5f22fb20497f only.

 drivers/nvme/host/rdma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 32189fdfc0f5..c45e45dec287 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -748,19 +748,13 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 	ret = READ_ONCE(err);
 	if (ret)
-		goto out_free_queues;
+		goto out_stop_queues;
 
 	return 0;
-out_free_queues:
-	for (i = 0; i < nr_queues; i++) {
-		struct nvme_rdma_queue *queue =
-			&ctrl->queues[first + i];
-
-		if (test_bit(NVME_RDMA_Q_LIVE, &queue->flags))
-			nvme_rdma_stop_queue(queue);
-		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
-			nvme_rdma_free_queue(queue);
-	}
+out_stop_queues:
+	/* don't free here: requests may still be outstanding */
+	for (i = 0; i < nr_queues; i++)
+		nvme_rdma_stop_queue(&ctrl->queues[first + i]);
 
 	return ret;
 }

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
-- 
2.39.1

