Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B300530DF3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950718; cv=none; b=E3YZobOHXGGl1YvCz6+FxC37wmpQzZH7Fcx9u4l3SQ1yEKvLd/D97IrOn+GV0MDSlIffJAIUAuZPQCmguRTwBfBefg8/VGpl6YVGGyj+JKZuUaGpsK6sP10zYQQdOmg4dLkzrUfreQx6Zt1w1Kr9kNL8j2xsV61yt6rh4hLcMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950718; c=relaxed/simple;
	bh=m+75uo7h9xTjQl10/pog+MjP5sUWYugqoPoiIQ4Xgqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfPdP1IsA5KnoUmXzckKUOcEBLwAJl6r83TZPLLeS6JQTg1RHb2iEOt7rgbqu/hemhEPe+VCDPJtJ/pd6hf7A/DL+e6Oi9QMwyV6fLgNYo1oIXuu1ALEwmew9fl1McIYZE9qxeucHz652Bh92R/LxCnOCJ63njzwSvpnOn5VPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPiEByIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPiEByIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C661F00A3A;
	Wed,  9 Sep 2026 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950716;
	bh=a+dO0xnnHMPFNi1zGrQlkJ8dZiPhkekpwYOUA5Y0YZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPiEByIFU5GK4E+kg2w2zT1lAJvDPNn1xsdGS+W1txxrT0/9CNBCl3UA2I44X8FWc
	 Kwf7MC2CIFZkRfbiYcZZWDjQXn9nWNh1GgvxKIzR51aTp1W7KeHS9w1eRJ+ah4xsbe
	 D+pVfNM1MjP4dkM0yDWK7Y2eS+c/VJEEnMoUUJotKWU6IwE2agBB/epVikG7MIxIuL
	 Yr7fvxsFtlRtx29V8KPuCovv6mK40i76youBYz6urbfIE+weWJGEf1mx2Lfh70MfXX
	 bmSzEunTIDUVI2anGqgwKp7qBV0APls/as+ItvuMRjIbTETwZ/TMdXxe2V83qq8swY
	 bEuzLWRgnSLqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Varun Prakash <varun@chelsio.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
Date: Wed,  9 Sep 2026 06:45:12 -0400
Message-ID: <20260909104513.1560898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-lazily-cauterize-57c7@gregkh>
References: <2026090304-lazily-cauterize-57c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 1d3ef9c3a39e04be31155c27ebf80342350c3abf ]

If maxh2cdata < r2t_length then driver will form multiple
H2CData PDUs, validate R2T PDU in nvme_tcp_handle_r2t() to
reuse nvme_tcp_setup_h2c_data_pdu().

Also set req->state to NVME_TCP_SEND_H2C_PDU in
nvme_tcp_setup_h2c_data_pdu().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 6efbc52237fa ("nvme-tcp: fix host memory disclosure on R2T for a read command")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 55 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7d9ebd4f7947b..01d42b854be2d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -598,7 +598,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	return ret;
 }
 
-static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
+static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 		struct nvme_tcp_r2t_pdu *pdu)
 {
 	struct nvme_tcp_data_pdu *data = req->pdu;
@@ -607,32 +607,11 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
+	req->state = NVME_TCP_SEND_H2C_PDU;
+	req->offset = 0;
 	req->pdu_len = le32_to_cpu(pdu->r2t_length);
 	req->pdu_sent = 0;
 
-	if (unlikely(!req->pdu_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len is %u, probably a bug...\n",
-			rq->tag, req->pdu_len);
-		return -EPROTO;
-	}
-
-	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
-			req->data_sent);
-		return -EPROTO;
-	}
-
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset),
-			req->data_sent);
-		return -EPROTO;
-	}
-
 	memset(data, 0, sizeof(*data));
 	data->hdr.type = nvme_tcp_h2c_data;
 	data->hdr.flags = NVME_TCP_F_DATA_LAST;
@@ -648,7 +627,6 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->command_id = nvme_cid(rq);
 	data->data_offset = pdu->r2t_offset;
 	data->data_length = cpu_to_le32(req->pdu_len);
-	return 0;
 }
 
 static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
@@ -656,7 +634,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 {
 	struct nvme_tcp_request *req;
 	struct request *rq;
-	int ret;
+	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -667,13 +645,28 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
-	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
-	if (unlikely(ret))
-		return ret;
+	if (unlikely(!r2t_length)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len is %u, probably a bug...\n",
+			rq->tag, r2t_length);
+		return -EPROTO;
+	}
 
-	req->state = NVME_TCP_SEND_H2C_PDU;
-	req->offset = 0;
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, r2t_length, req->data_len, req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
+		return -EPROTO;
+	}
 
+	nvme_tcp_setup_h2c_data_pdu(req, pdu);
 	nvme_tcp_queue_request(req, false, true);
 
 	return 0;
-- 
2.53.0

