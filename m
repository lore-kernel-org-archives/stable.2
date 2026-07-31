Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184F42CB0A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508311; cv=none; b=G9bPT99kQTDB4/4ndV69QfafeJSEaP8PU++lFIhO8e9zKfogE/XyvtHiPvT8ILaPjWdzwlJHQuK5KhrLfQNIlIzrp25ddYK5bo8/s9bt3lPgxNQtttx/xO5YYPFcFHb68hevnY7QTLpSUW/pRQQXUxqhKW01SbjDi1KT6e0P8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508311; c=relaxed/simple;
	bh=S9m+Lb1RlO41EevrwMTzudvXAcHBCui5jx35i0QunMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIn9cPxTSOEDb26ztyzral3pc1PgovNwK7ir6HubHqUBVGwT6PSMc7ZieR4HpJDq79k1odz5XE1n+dKzjrPuw+mwMjC7ErC0SOR1E131BjXKYQLUsNn5MSQpEFPRm0+ozzHQ8wpw7/6ojeRwD16ROV5cOzsk7aWws8Hn1hvOiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=uXbaCCZo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="uXbaCCZo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso10202795ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785508308; x=1786113108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nqg0dSHeP45xd/EokPloz+X9pwqjo4SAbZQxj3uAduY=;
        b=uXbaCCZoAbCRfnIttcvDTpXVFQTgrlZj8rbeZGfUDOYQY+o4Yi10/n7CD+2eZAwPqB
         wmSdZeMouM7j532K82lSNeLQGglxUnP/5jVQnNBXqDUBDwkbty283zDtXq65NDicjmyU
         +3+uOYM4CSn5zuFq+wDbKHQUOpvqjJMTHKXxuQ+gOT8JKecHN1whkEuwa+vFmHvFI+BP
         Ol780d9Ev30N5U/gzl+/kkQyI8XqvUmN9E1fN3EcFTvrzEdGtYsUPkxYaDxvza+9omuo
         1fLdZOSo5Kta6TtUVvGqhBGFknwcSv9eNtFTc2Pta13z8KZ2SD06mUy9ye/TdPGIXcRY
         cTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508308; x=1786113108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nqg0dSHeP45xd/EokPloz+X9pwqjo4SAbZQxj3uAduY=;
        b=rgHr+zK+Q6QhfK6E7hJL5gPUvII5Xsan3Tu6dFu7nF9yX8XlXxkvH20RNQsAzjfA03
         T9LgXWYmLgrk7TLJIN95wPTftp7uL8m6EKRXJ+E95hNjbn77Qu1iI7cTAwvThZ+84A/h
         3I4MDcVBI/6DSqc52pogdUd7y7RpxhnFtOv8oR2TXXqzkw2zNRGrsr9wZhE+/0I/jvfk
         7qb0ZgBw5Ot2/sGfXc7sAkGyWAgaCEU2GLF1QMVXhIbkOQd9qrITdp/PIAWuuTAA3mzx
         hVseQpM2H8guwMVkqKB4D81F+NTvv6+CKNtcloglHVqdBdmkT2zc4IpWf048tc+VjPLt
         MA4w==
X-Forwarded-Encrypted: i=1; AHgh+RpNkm4ohjM6m54cs+zUEr8Mj1MKYyMmC7wSe0dLB4HEtSZzlR38RyNiuCAV9GEEAeJVXgKGU0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0r/QAH+dzIRNvVM+5SZvmYLm8l3wuKtKzscHrsukSC6cb2pvg
	r+u2ih+MUqIkgaPqjp+bw2YBTVPjJcUGab0Id8ld029HZ8kMlqw9qRVsQownLfXnics=
X-Gm-Gg: AR+sD13xfM4/9Dt9UGnGrM/OyWWSayGD9GH6xd3NfG0HAsTae2tmeEyISjGpKuE2ySO
	coIOCfBgGigQwpI5jU8M+DC1FMkEkZ1y7IzwLFHGTlVgkz3mvqTxaM2gVT7XgRXJLwXpYIzMaVM
	/TO1VGo8I0RZ3QqRJxJYUcUl+x1wv9oupyZmRrziD3rddtFeC5o3k0TaciM8scCsrS+Bwgb9qgm
	+eULmHBemi6yFCywWYm7uTGGP20XCmyw3/y42MFsYSwgHpWHCVmSdQ6V6Gwe5sdzh2UIoZXG836
	G8Gcuy18g0O6FbAyG1iZrGbQo5sdwJemLnDfg3Isbbo7IPP4laexNwhfXTRBBHXr+CCnR1tEfI6
	wrIKuuMhKfMOF9J+qmci40l1MG1u2yz9yp0WU/QAy1tHsNUr2DQ/KvQLhwayS04Hhb6y1IuY2rQ
	8j37K0A1Jo4+JF8EvJVFY7Y8G4mSV4DaYgvYjzU9yCkdV+mB94tM+VAWYGILB1eth8LZHs
X-Received: by 2002:a17:903:2283:b0:2cf:dc6f:cc42 with SMTP id d9443c01a7336-2d0524b39a0mr1900965ad.46.1785508308110;
        Fri, 31 Jul 2026 07:31:48 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm6203185ad.6.2026.07.31.07.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:31:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvme-tcp: reject a data-in command that transferred too few bytes
Date: Fri, 31 Jul 2026 23:31:15 +0900
Message-ID: <20260731143116.1870962-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
References: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_tcp_recv_data() seeds queue->data_remaining from the declared
length of the C2HData PDU it is currently processing, and completes the
request once that one PDU has been consumed. Nothing compares the total
number of bytes actually received against the length the command asked
for: there is no receive-side counter in struct nvme_tcp_request, and
queue->data_remaining is a per-queue field, so it cannot accumulate per
command.

Nothing above nvme-tcp catches it either. blk_mq_end_request() completes
the request for blk_rq_bytes(rq) unconditionally, and neither struct
request nor the nvme host code has a residual concept.

A controller can therefore answer a 4096-byte read with a single
C2HData carrying 512 bytes. The host copies 512 bytes, completes the
request as fully successful, and the block layer reports a complete
read. In the buffered path user space subsequently reads 4096 bytes of
which 3584 were never written by that read and are whatever was already
in the page.

Observed against a test target that answers a 4096-byte read with one
512-byte C2HData: pread() returns 4096, and the trailing 3584 bytes are
content the read never wrote. With this patch the same target instead
produces "short data-in: got 512 of 4096" and the request is not
completed.

Count the bytes actually received and refuse to complete a successful
data-in command whose count does not match the requested length. The
check is applied at all three sites that can complete such a command:
the two NVME_TCP_F_DATA_SUCCESS paths in nvme_tcp_recv_data() and
nvme_tcp_recv_ddgst(), and nvme_tcp_process_nvme_cqe() for a command
completed by a separate response capsule.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..e93f015fa785 100644
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
+ * NVMe has no short read: a data-in command that completes
+ * successfully must have transferred everything it asked for.
+ */
+static bool nvme_tcp_data_in_short(struct nvme_tcp_queue *queue,
+				   struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (req->status != cpu_to_le16(NVME_SC_SUCCESS))
+		return false;
+	if (rq_data_dir(rq) != READ || !req->data_len)
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

