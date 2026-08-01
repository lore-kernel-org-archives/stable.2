Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838B3644DB
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564167; cv=none; b=fDqs8mo7MFs1spoKaXVP8sWTmfVftup9vJPmVsIHaxQLmoIRxpkoDhQ9uAf5kcf6osmh9EcdqzXSN8VAAKlxj1LrkH0J4+dgCWYwfWFSApWjgtuqvcpqnhTDsIHijNcvaqXEV1MIJ0QAGBvkJNMtwh2PUhqTtMBNtAS3cDUfp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564167; c=relaxed/simple;
	bh=kboCeEk3P8qTdtkY6pM4vU9Wh3/RBMOT82Ve6CeNWkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+NVDqxcsPpFwFHx3bq+TIxcJbD2kFqEKn1crjwRaVT9l+4MY2cGLu3jKBmB2wugrXQapfmczczxZYReG4rdaM0taQV92iY9xC+xKqUJtCwZ9p/ealJSFte44hpN/UDtIeOZAIqZ10s0S1TNPeDE7zb1NlK6uPBihI78/RKqnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kMOUD7h5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kMOUD7h5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1895099a91.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785564165; x=1786168965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ar0TU0A76j4CC+o54wdVQpftKVR0bXPf2ahLSopc8SM=;
        b=kMOUD7h5z719d6djKqkcxZn0C88exEwD1EQHwjGUNtX6asAv0M40V1InCj0s1yqLnZ
         t71g5B+Dj3c1mLodU6eMNvjY7SDv2N2wgWMtFVIv8ZbxnOZ/dtjIb+4Ttyz159b2XFKo
         fW6ol8k86io1QXJtXlq0yHaDL5QMSl8xkX5iLiH6cdI6hDummlQ/CILjDNtimFeG+br+
         wL890lm2ouDq9zkeSyvgRzfSBtsMhSWbA4gyuC03plqzG+l4iL2i2dsm+EX6/Q9+lL0q
         ScBisE56BX4N7AkhAx0jPhBp4UiAVty3Jv97zOP7kupuYh7curSk7GVPydTyIvnTNUpR
         nzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564165; x=1786168965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ar0TU0A76j4CC+o54wdVQpftKVR0bXPf2ahLSopc8SM=;
        b=GWXSwDjPAlG42Plq1Dc0JBKMeJQmFhS9v2QiaDv10WLv4dxqlCExX9vnZOxMOb1lka
         qO9EJ0ZfH7U3EvLEYCFxlRn2dx9EShxBIV0k9E3UM27ujL59f5kdo5gdzA6PMCcEBIIM
         bUZIyNgEPohhLPjMy+mJMQhSrIrI/Rm3E80X2nj6e8w5FeLbP0UC2AzvKY5Uodgho27X
         J0b+WKvemTK6zzKLqbjBRUAQh+3GRl7vKsIORm2aGXmVCsOCumrSXDDspd0t7r9HR6ov
         Y1C0iDcILkpuY48EmwkvyrHgo0Hj6H4hRw1o5fr9yEKyqfbesbUbq/BCD5PdTmOYGFH5
         a63w==
X-Forwarded-Encrypted: i=1; AHgh+RrCu7c/LAx0Vw3LDPkQjIqh0oATQ4rRU9cN+A7grMNgLcC8HBfU1ya9oBUyjn+ymd8NxZujrAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpgQhIuQvN4NowNAfiFXU8JUxNdS9W87zMVQ8koxIEhwaSH0C
	8btlV6PU/OFcqAtdZYFIwUKHbYZgWPn7stuO405JYF4VN6/nK0rX7NR0q0s0rsdyryu4x+azinJ
	RfpHwhDM=
X-Gm-Gg: AR+sD11ZsvRi/177d3sC9xfXq7h5cqazYkQiz4hpvYBe3dZ2SHVR89D5Ez3oF0RvA99
	Zzh29Uj2aXswqMi53XeZxhbJvXq7zQ7h7mPbW3DPMEEliJLModlmhjx2n1/silnEydAuUDWxqra
	M6ejBftez8F7dFpBPmh7agFSbxqyZphF19CHLBElygPtLTeb180WLp7uLbYo4a7gYHRO9pjwB1l
	PmgYr1FWZpvXAuqG+tUK3wiCkuofxZr+uMXbV0DuhrjSXYkpbXZLmqaVc0zPi9FGO1U584LFbsC
	KgsytRgj16BUZicTkBhMAwXN2HspxzbCly3XMWch/BFULjztSi3zRf312TXMihFPfAtpxOfMLlK
	sfODw3G376Z2ghRy6D0Jna20kAlYUDXfgt9sHKsvontsJBzi7w1tUiHr0d311txwlgMlnO5GKM3
	Yg3BI25jMa9gmpybMyzRVSAVcg0RIvP521vCh7rSlfbG96847ZSvA65zfGyN244sQBSZE6Gs3IW
	i+ynWRmbkU=
X-Received: by 2002:a17:90b:1d52:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38fbc40e3a0mr2124348a91.1.1785564164843;
        Fri, 31 Jul 2026 23:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm1598856a91.11.2026.07.31.23.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:44 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] nvme-tcp: reject a read that transferred too few bytes
Date: Sat,  1 Aug 2026 15:02:00 +0900
Message-ID: <20260801060201.1879499-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
References: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_tcp_recv_data() completes a request once the current C2HData PDU
has been consumed. Nothing compares the total bytes received against
the length the command asked for -- struct nvme_tcp_request has no
receive-side counter, and queue->data_remaining is per queue, not per
command. The layers above do not catch it either, since
blk_mq_end_request() completes for blk_rq_bytes(rq) unconditionally and
nothing here has a residual concept.

A controller can therefore answer a 4096-byte read with 512 bytes and
have it reported as a complete read; user space then gets 4096 bytes of
which 3584 are whatever was already in the page. I reproduced that with
a test target.

Count the bytes received and refuse to complete a successful read whose
count does not match, at the two NVME_TCP_F_DATA_SUCCESS paths and in
nvme_tcp_process_nvme_cqe(). Only REQ_OP_READ is checked, because there
the length comes from the sectors the request covers; a passthrough
command is built by its submitter, which picks both the command and the
buffer, so the kernel has nothing to compare against.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v1 -> v2: an automated review pointed out that the check also applied to
passthrough commands, where the kernel does not know the command's real
transfer length; restricted to REQ_OP_READ.  Patch 2/2 is unchanged.

 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..4b72f555495d 100644
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
+	if (req->status != cpu_to_le16(NVME_SC_SUCCESS))
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

