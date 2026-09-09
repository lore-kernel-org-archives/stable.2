Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC953359E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951001; cv=none; b=EkIH8oKrYmHclImvos92KVP0A83uYzYbL0bSaj5x+sST+BryjQKGhgK4prXHAiHXa2dDni4WFPKn91GD7M8muJghkNVkV9Ole+ACV/Kd457q7seyb59/JlbB8G2M8/Eix75cPqImBKPsuAm/rJxTIKXGHdKMnc8Jdd1DS5UU09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951001; c=relaxed/simple;
	bh=fDhDdMCMLPrR//sPpoCOwH35D7v3h3lxuyyRn6BEong=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKFl14NsZRPF8fSnTVTl9lyW3/JNiNvNPcm2xsIbRTJ7fp3a/sXCadFdUFQHBFAVnWw6DxwsBE4wnT+/gw8S8u77ZIBOstNpJ4D1AZlzZZ68k4Cb/8qpWze+145PsJzHaLo96pWoteRenwHZDjCiXmD+ThmbiPtXskiY2XcVn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJKWVX1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJKWVX1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992901F00A3D;
	Wed,  9 Sep 2026 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950999;
	bh=iXJhIYYItEIhwATRH/oqWDKIJWlNu39yrHX5aoYadPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJKWVX1ZWjdvU/zIEt5sqZ6KJOKbxchJQ27P1VxOKMt+A47N/D0Uixtq6X8VShe0Z
	 Nq/yapGwWZ5riajlbRGOKT49fpJX8TLtBEV7/t/4K/BPwDRacT9TDjjlqOGjiIIvd+
	 ZwRyOlB94hxxeaK7/HH1zpQxVRYFcxClEOJVzdYu+6aDe6C1/CI4KYCMs3TC0dLGj6
	 TcC+cbhrEFLXNsofesy0VxBCfWEk7PtAqhQbrh6Nmy/no834JRMg1ZmVLyOjO7BeAp
	 7BzNMld9k8KGL1GNkQFfATki/w2T8iZKbv7gZeCU8v4nwg6LM5RQrxscgLBMzmxDn7
	 WCD4UR6INP7Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] nvme-tcp: Do not reset transport on data digest errors
Date: Wed,  9 Sep 2026 06:49:56 -0400
Message-ID: <20260909104957.1579361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-lying-divisive-d066@gregkh>
References: <2026090316-lying-divisive-d066@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 1ba2e507f55c5b0cbde8c0fbfe0d9e39612a3e52 ]

The spec says

  7.4.6.1 Digest Error handling

  When a host detects a data digest error in a C2HData PDU, that host
  shall continue processing C2HData PDUs associated with the command and
  when the command processing has completed, if a successful status was
  returned by the controller, the host shall fail the command with a
  non-fatal transport error.

Currently the transport is reseted when a data digest error is
detected. Instead, when a digest error is detected, mark the final
status as NVME_SC_DATA_XFER_ERROR and let the upper layer handle
the error.

In order to keep track of the final result maintain a status field in
nvme_tcp_request object and use it to overwrite the completion queue
status (which might be successful even though a digest error has been
detected) when completing the request.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 7fa3f73f6c8d ("nvme-tcp: reject a read that transferred too few bytes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7d9ebd4f7947b..7e25bfa001c59 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -83,6 +83,7 @@ struct nvme_tcp_request {
 	u32			pdu_len;
 	u32			pdu_sent;
 	u16			ttag;
+	__le16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
 	__le32			ddgst;
@@ -524,6 +525,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
@@ -535,7 +537,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	req = blk_mq_rq_to_pdu(rq);
+	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
+		req->status = cqe->status;
+
+	if (!nvme_try_complete_req(rq, req->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -797,7 +803,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq,
+						le16_to_cpu(req->status));
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -827,18 +834,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		return 0;
 
 	if (queue->recv_ddgst != queue->exp_ddgst) {
+		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
+
 		dev_err(queue->ctrl->ctrl.device,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
 			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
 					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
 		queue->nr_cqe++;
 	}
 
@@ -2370,6 +2383,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 
 	req->state = NVME_TCP_SEND_CMD_PDU;
+	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
 	req->data_sent = 0;
 	req->pdu_len = 0;
-- 
2.53.0

