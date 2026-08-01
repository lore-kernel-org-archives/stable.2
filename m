Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31231314D05
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572322; cv=none; b=Xn3DwA7/VgYBxL6ozBEaw6pmRgwDGN+IFjkKFiNh8oyOqe2jLOfjemRpaQv9u8gCIArxCbo6/fFSmte8kHDwNPItSx8d96q3ETPo/EsBOCgD4wQBQpNnMInJ4bpuueb54ccpzVlPZgbYdW4QVSW4NnXxtPTOiVymgvhGbbTQ0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572322; c=relaxed/simple;
	bh=Jx5ngztfjkk1frVO0SfO5FKtgzZOYaWLyPYUFDjIz9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA71EcS6Xnj9A8/6Tq90I1RaPO2rnPyaoUDb+RTP3brsC4Tsm8myv1+zRHBcPIgmqo0k+pOlNZ+dDq7RyNL5ImIsglCkalnksX/7G09d8E91s/XMAM6CBNRV6eShQKvseh2DqvfUxe98kZWE959wLu251qIyYhxrPNBf1rsImPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=FQCLlntO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="FQCLlntO"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848761b5897so1307618b3a.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785572319; x=1786177119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1eprebx+Ei9fy9zASKq2n4ZSux+Wxq0L1cBEFaU7cY=;
        b=FQCLlntOUi5JB7QtDvwZE6YgNuOvmR4BUj37IROxIB6rd1Zx+FHJNqO4N/scUUaCpH
         xGT0l6Z/dyneppRQ8CtNH898ueH3W2wjQgol58mbWUXY6ibTw+i/P0n9ooN/sgLlLzX/
         UUz2CMT2ag4UhpXXIdyBTlnnrn1vBJUxZlVW67VQNRyNx0HLTji1t3io2hpxVzbDPZ0p
         GhelZGatBVc0zHaK1DEWt2PWErSfc95zN8irA4j1wfm/euF8MIOvv9BiTHZl6DIZ/dO5
         OBVEL0iDmCduVtjfZEmwEedRoo4SjMf7/e6AovVEVKZbvogxZ0g1kqg60yCagfWFAH7b
         +WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572319; x=1786177119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1eprebx+Ei9fy9zASKq2n4ZSux+Wxq0L1cBEFaU7cY=;
        b=C74HQ+k4e3QWL1pDstXqB+7VvarE8FU4bOejShVZZhXKhhkA1S6T5vxMhd/aDVu7U/
         13Amt+ebpEiNwyhc8fVEb6KSPr03I+E2zyA/XmqDRJAGG9yn4EM5NE1sIAaLP8vESu9c
         zo2dcxE9K7rg80qJoU8RJo++T/s87hy/IpY3FYrjdNM8xnsglUCQBHIvoZODd5zKXT0H
         cJRgkhho8Z7xfsKY1a7RseVHBCcnpub3bJMtZ6kst7uhZMCMVFLV+YjkCNPwTdlX/wxe
         T6lZMEy04RmxZGTTR6wHlmTZQcSbtuKqecsPUyZWfw+S55iZRjf7X2QKkFcmFZX3NHLa
         O5GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkCrmDFCMcfraB1QAloFcjgiE0wXVjZMvAj3u+VfDtv9AkgZpgt35X+SSW46zuX70CtpruHjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliIhm5HO6iHVPGTn1r90wrWGNv3JJpUssbKIwU/EBitwNfKoo
	wCSx8bdEUlQ7ZZgSFfuoZCxLCRSeObKoGFN1e8FQBK75ieRUtcqPtnrAx858a5lWysdpyrCi+aa
	8Y7b2
X-Gm-Gg: AR+sD13gGk1pd4NBgJdBikWakLwjoNEVr/Hr9dltaSQaIlQTMqCSwWZRPhCOLb7jBgi
	GwLLn01P9AOoBigAcgAGR0/tSOm0SCQ41LjTGsRq6VdoTi8902DutqMUh7QYm0aftEje64GdaqH
	e/vC74cXNl/kWa2PVRB5dK9PlzyvB8fZLV5i1Ag6jMInQbvQtZcqs7ANy8U+JjUBtP2hMbq1H5W
	Pl6b89jKMMwwHp3MpR8m+FlM7aV1MgfaZlMMX3u4h733O3xgfopJbBAhZSW0doX564YlV7opLBS
	Z+mFgwKs59IVGnFBPy7qz1ZNnhgtyAMxsgFKgRbVKBaxm23OlvvnzJ6Zi1tpQknrBpS1Af7cFnd
	ZXa0CyL5U54DZmqovtMEp8cgJb6Muhb5NDcbBC7/ULjQM7eIWFfjQ+nkXaZCQy5aSinyCiXq8bO
	9bHC5rQwzsOJ5zuw1jPUO+IcuPgewHUD6VyX9+Rfa/325uphS+mpB4uWcWcJ1uIeGwm7iFHXxNX
	pXl33UO+R4=
X-Received: by 2002:a05:6a00:9296:b0:847:82dc:452d with SMTP id d2e1a72fcca58-84ee47d8cf6mr2245492b3a.29.1785572319549;
        Sat, 01 Aug 2026 01:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9a40sm1433003a12.25.2026.08.01.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:18:39 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] nvme-tcp: reject a read that transferred too few bytes
Date: Sat,  1 Aug 2026 17:18:17 +0900
Message-ID: <20260801081818.1884199-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
References: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_tcp_recv_data() completes a request once the current C2HData PDU
has been consumed. Nothing compares the total bytes received against
the length the command asked for: struct nvme_tcp_request has no
receive-side counter, queue->data_remaining is per queue, and
blk_mq_end_request() completes for blk_rq_bytes(rq) unconditionally
with no residual concept anywhere above.

A controller can therefore answer a 4096-byte read with 512 bytes and
have it reported as a complete read; user space then gets 4096 bytes of
which 3584 are whatever was already in the page. I reproduced that with
a test target.

Count the bytes received and refuse to complete a successful read whose
count does not match, at the two NVME_TCP_F_DATA_SUCCESS paths and in
nvme_tcp_process_nvme_cqe(). The success test shifts req->status right
by one, because the driver keeps the wire value there and shifts it on
completion, so the check must see what the completion path will see.
Only REQ_OP_READ is checked, because there the length comes from the
sectors the request covers; a passthrough command is built by its
submitter, which picks both command and buffer, so the kernel has
nothing to compare against.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2 -> v3: the success test now uses req->status >> 1, the same expression
nvme_try_complete_req() uses, so a CQE phase tag cannot evade it.

 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..c4fe06d424d1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -80,6 +80,7 @@ struct nvme_tcp_request {
 
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
+	u32			data_recvd;
 
 	/* send state */
 	size_t			offset;
@@ -612,6 +613,29 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+/*
+ * NVMe has no short read: a read that completes successfully must
+ * have transferred everything it asked for.
+ */
+static bool nvme_tcp_data_in_short(struct nvme_tcp_queue *queue,
+				   struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (le16_to_cpu(req->status) >> 1)
+		return false;
+	if (req_op(rq) != REQ_OP_READ || !req->data_len)
+		return false;
+	if (likely(req->data_recvd == req->data_len))
+		return false;
+
+	dev_err(queue->ctrl->ctrl.device,
+		"queue %d tag %#x short data-in: got %u of %u\n",
+		nvme_tcp_queue_id(queue), rq->tag,
+		req->data_recvd, req->data_len);
+	return true;
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -631,6 +655,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
+	if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+		return -EPROTO;
+
 	if (!nvme_try_complete_req(rq, req->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
@@ -953,6 +980,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		*len -= recv_len;
 		*offset += recv_len;
 		queue->data_remaining -= recv_len;
+		req->data_recvd += recv_len;
 	}
 
 	if (!queue->data_remaining) {
@@ -961,6 +989,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+				if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+					return -EPROTO;
 				nvme_tcp_end_request(rq,
 						le16_to_cpu(req->status));
 				queue->nr_cqe++;
@@ -1009,6 +1039,9 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+		if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+			return -EPROTO;
+
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
 		queue->nr_cqe++;
 	}
@@ -2736,6 +2769,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
 	req->data_sent = 0;
+	req->data_recvd = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
-- 
2.43.0

