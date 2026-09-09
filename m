Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C635DA77
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950072; cv=none; b=Os3Jt04/j7CoqSNikcf0BKLGmfdz3Vbui3p3LB9mILTXXnfVcqp29ro7FbQwZ5GITMladeOqgSAtaIxuv+5n8LMWjIQtoc9mrXSl8OMo0HJylUU5ort535js5Jj3ZlPLvlHMsMUYZlyqYb8oqNdF2CYLyzWzNX1XINkr+xkkE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950072; c=relaxed/simple;
	bh=v86Mc4Euwfy33h7aZFu56ghH6Dm4VJwsvnI4N9X0+q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJtssP8ZwO1A+oovoWHDIyeWmVn2qmCy+PFwhOqRbOurSGXhoWaFsgajtxfRh1QxPSEDfNG5wtw5M5ePN7wqM4qip/Pu9rUDT54PUnsF1pLLR/5dEsc4wkzZ7pAA9b3w5wCAIFKl5qNIOGHqnOeOq/j3cK8D2ZP7RreoOQUQM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEulQ3fn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEulQ3fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EB61F00A3F;
	Wed,  9 Sep 2026 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950070;
	bh=FEKI9/EpRu8m4XK5M8KEIavxaOPlTlpHv/iM6uft8Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEulQ3fnt8BoFTWHLWdzszmzAssoIYvumdYXyRK5D9GPufEOLhMFzjOWFQz1mtC/k
	 ojlH4PG/JpDwGSALEfSh4FVyt2fdJmN2XrpxRdAFEXXoHerSN6WJN3pa9usZ3kNsHr
	 6OLV59XEF/psmxmI1pHKLgFWIYRMdzz5ULe39sEL8qdFL9+fXXMqejYL9ujUB/0SRl
	 5fEYxe1pWPHTVTmWwXmrmHtEdMVmYK6RfFDz3be+W3WtSnceiusF6bTGaaaM4Kjo7t
	 4Gx1G22u96ivLMrNlyUUO+wr/uH/21Or9/X/CVezVb3TTrhNHU+mvKNw9YHsZtfEFk
	 prACg85L9Ld8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] nvme-tcp: fix host memory disclosure on R2T for a read command
Date: Wed,  9 Sep 2026 06:34:27 -0400
Message-ID: <20260909103427.1544212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909103427.1544212-1-sashal@kernel.org>
References: <2026090303-snowshoe-motivator-818f@gregkh>
 <20260909103427.1544212-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

[ Upstream commit 6efbc52237facda35d2d874fe1765bb4839275d8 ]

nvme_tcp_handle_r2t() does not check the direction of the request the
R2T refers to. A malicious controller can send an R2T for a READ and
the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
H2CData header and nvme_tcp_try_send_data() sends the request's data
buffer. That buffer is the READ destination, so its contents go to the
controller.

The command then completes normally and nothing is logged.

Against a test controller that answers every READ with an R2T, a 4096
byte buffered read returned all 4096 bytes, split over two R2Ts. The
pages contained stale kernel data, including an array of struct page
pointers.

Reject an R2T for a request that is not a write.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cedccf41011fa..066b98052030f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -654,6 +654,13 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
-- 
2.53.0

