Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7147ECF0;
	Thu,  2 Jul 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995884; cv=none; b=RlAoP+YgzQFeO6sLV/Zd2ZCwspq7BeE/0NCFJaazvOX12cn86qzBWg5brc+1SahHsu8yFTOGgZBoj+MN1F7bJZrIZdSJKOCfT+CCxwIXfMEE2vQhPZWEPIsB7ZZXAtSa1RzpoVwc2JYTUxvKut9EjXTLUp6QZr0JXrM6uLRD73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995884; c=relaxed/simple;
	bh=fr4dDHRw85B1ssa1/vxY3hp9jcdR1I10WXYlcljDAIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0fdQjMPPvBGMfe3/ZC53sZE/J0Uql87dZrESZ4IUbAwy4l95amzqhORPLKUUfgHjoaP9aqKe1lnr67EeHxpCqfeskbNKlysOrV0RJdrNwWTSfKD6xej/+EV3Fjz+dKbZTGxIMgcMn0UB4g3R1yxnwdq7SrHjeE1Ozc0cxoB/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=shodn1SD; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="shodn1SD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782995878; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zVPsC72MacI+7uoqqa+knkUXaga+oDDWAOgXUhuF+3U=;
	b=shodn1SDfbx5Pt/vRFN+LVJS/e5jb0NOlMi6EfCUIUTF6w/sZhIWbvVTwKgY8Sk4kbbYtp6xQ197KtTBjA2g8bpG6rgkRv91J9uMfAY76rnHH4+6Gs1432v+vpEiD79cIY2SbLle0MWjDIJfjM3Cdvegl5nh3t+/4gTDFnSG6jw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6EoVO7_1782995877;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6EoVO7_1782995877 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:37:58 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Thu,  2 Jul 2026 20:37:57 +0800
Message-Id: <20260702123757.99897-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya Kulkarni <kch@nvidia.com>

commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.

nvmet_tcp_handle_icreq() updates queue->state after sending an
Initialization Connection Response (ICResp), but it does so without
serializing against target-side queue teardown.

If an NVMe/TCP host sends an Initialization Connection Request
(ICReq) and immediately closes the connection, target-side teardown
may start in softirq context before io_work drains the already
buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
reference under state_lock.

If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
allows a later socket state change to re-enter teardown and issue a
second kref_put() on an already released queue.

The ICResp send failure path has the same problem. If teardown has
already moved the queue to DISCONNECTING, a send error can still
overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
window for a second teardown path to drop the queue reference.

Fix this by serializing both post-send state transitions with
state_lock and bailing out if teardown has already started.

Use -ESHUTDOWN as an internal sentinel for that bail-out path rather
than propagating it as a transport error like -ECONNRESET. Keep
nvmet_tcp_socket_error() setting rcv_state to NVMET_TCP_RECV_ERR before
honoring that sentinel so receive-side parsing stays quiesced until the
existing release path completes.

Fixes: c46a6465bac2 ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Reported-by: Shivam Kumar <skumar47@syr.edu>
Tested-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ context diff adaptation: drop `queue->state = NVMET_TCP_Q_FAILED` since
 the enum introduced in 6.7, 675b453e0241 ("nvmet-tcp: enable TLS handshake
 upcall" ]
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 drivers/nvme/target/tcp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 29ed707e76e0..06cfcf085007 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -357,6 +357,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)

 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 {
+	/*
+	 * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
+	 * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
+	 * already been consumed and queue teardown has started.
+	 *
+	 * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
+	 * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
+	 * cancels it, the queue must not keep that old receive state.
+	 * Otherwise the next nvmet_tcp_io_work() run can reach
+	 * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
+	 *
+	 * That is why queue->rcv_state needs to be updated before we return.
+	 */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (queue->nvme_sq.ctrl)
 		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
@@ -900,10 +913,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-	if (ret < 0)
+	if (ret < 0) {
+		spin_lock_bh(&queue->state_lock);
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+			spin_unlock_bh(&queue->state_lock);
+			return -ESHUTDOWN;
+		}
+		spin_unlock_bh(&queue->state_lock);
 		return ret; /* queue removal will cleanup */
+	}

+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+		spin_unlock_bh(&queue->state_lock);
+		/* Tell nvmet_tcp_socket_error() teardown is in progress. */
+		return -ESHUTDOWN;
+	}
 	queue->state = NVMET_TCP_Q_LIVE;
+	spin_unlock_bh(&queue->state_lock);
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
 }
--
2.47.3

