Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323000;
	b=pYkcx157tQV5QRgb4GCw27TJU441NObLYQkyyztEqBzMIcGF8QcPl5prVqb3e308KfKl
	 KkFAn98/RT5j72MM32Lz/Xlr+eWQ4M7dJbWVR/MbUBQ6OvayILRUwsH4hzwD8X8zNug31
	 GIv3cIvbOjXLMLhZsYtBO57QfzDWEB7aDYyfft1/fnk4nN1qCUOqVwLnCPARoMpRC3k9J
	 rYC7wFC9By0yi+ewoGxZY/09AotS2lWi0xZ6pHMPMTsvJQVC5jiAcjSopKpTW4lQ8WrBC
	 Hfb6c5NzKpsP7jY9g2nfUr/y8gkPX+NoKEVAES/fLtHEIKTxt2I9c4ifeqLzB7/AIqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=QJvVyV94Cv8OIUbiM+u2kGZe6Vw+3fdgWvqCgG/0qUs=;
	b=hKB3jzVsov+f1xICneX+vGeULhkit+Sofh4ZW0NN1V04ODV9L8g7//EDO4EZRWNF+6mi
	 H1QmDRSzqyCetAIBanDldd4a3k+NG/RAQ2tLWZLyLU+12Wf9ycZq5Wr9AJ2s1YPlqTSge
	 k6OQ0MZk0Ied8cOpPXj2u0GfVcNqxmqnfTgAUDGB/ZRJ+FeTSb3lDGS937hbJWL6EPk48
	 iDX54xISNQIkXH+SxBwhpayTsSlXWEQpwYCTTiF5XbjkApbM2jYtNWG0R0/M15hQgHow2
	 UWihtM3erdM5DKXgBxcyYgWa/ffmEE5R66tVd2Qho7yWx9miRCplI0ImXQDnsEZbFhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5NTgfbxf;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253860A2603;
	Tue, 10 Nov 2026 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D253860A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5NTgfbxf
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zL1r0cz4x6DD;
	Tue, 10 Nov 2026 23:03:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322990;
	bh=piI42uDP8SRa2CG5qbL2WUZAnmWJlreP3bqJtI3YcSs=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=5NTgfbxftbLMd9Aj53xQAjJ85GU74Li0as3fTbM29q1iJ9I+AFTEj9l/i/KKeQOwx
	 VEmOXJ/UEICfPxsjVH+mBdsnmVnRbUc13sEda5XUth8PHMB5sAGEajLj498LXE49Ei
	 bzNlOlBzANYqj6y1D5v6zcSoZOaX/UKaWquHkIv7w41KAzF/IASiY632c3j+4x+70a
	 udBoBIxXoQHRRO7LrPJWKo7mAyJSQ9FtVLaCpV5bohXFIh58iQ4LONodVtO2OScGYe
	 vXJg5XmY7YJmOQxF3N1YfK+WAHEWRLQTzKzInURk+D2J0g/Id8xlZw8Rnh4uVZeJo2
	 EgyNMSP55S1IQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AAF396F030665;
	Tue, 10 Nov 2026 23:03:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:10 +0800 (CST)
X-Zmail-TransId: 2afb6af3322effc-0763b
X-Mailer: Zmail v1.0
Message-ID: <20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:10 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvNl0gbnZtZXQtdGNwOiBvbmx5IHdhaXQgZm9yIGluLWNhcHN1bGUgZGF0YSBmb3IgaW5saW5lIFNHTHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF396F030665
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3322E.000/4jP8zL1r0cz4x6DD

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet-tcp decides whether to wait for in-capsule data using only the
write direction and SGL length.  A write using a transport SGL can fit
within inline_data_size without carrying any in-capsule data.  The
response path then withholds its R2T, leaving the command stuck.

If request initialization fails, the same length-only test both
withholds the error response and attempts to drain inline data that
will never arrive.  This can also consume the following PDU as data
or a digest.

Require an offset data-block SGL in both checks.  Share a helper that
only uses command and port fields, as the completion callback can run
before nvmet_req_init() has finished.

Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with nvmet-tcp over
loopback.  The standard nvme-tcp host driver only sends in-capsule data
with an inline SGL, so it can never produce the triggering combination;
the test instead drives a minimal user-space NVMe/TCP host that crafts
the ICReq/Connect/command PDUs itself.

It sends a valid 4 KiB write with a transport SGL (type 0x5A) on an
enabled controller and I/O queue:

  unpatched                            patched
  no R2T, write hangs                  R2T received, H2CData sent,
                                       write completes (status 0x0000)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8092ce4914b6..a8a435aaa163 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -269,6 +269,23 @@ static inline bool nvmet_tcp_has_inline_data(struct nvmet_tcp_cmd *cmd)
 		!cmd->rbytes_done;
 }
 
+/*
+ * Check whether the SGL of @cmd carries in-capsule data that the host
+ * will send right after the command PDU.  Only the offset form of the
+ * data block descriptor is in-capsule; a regular transport SGL is
+ * fetched through an R2T instead.
+ */
+static inline bool nvmet_tcp_sgl_is_inline(struct nvmet_tcp_cmd *cmd)
+{
+	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
+	u32 len = le32_to_cpu(sgl->length);
+
+	return sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
+			     NVME_SGL_FMT_OFFSET) &&
+		nvme_is_write(cmd->req.cmd) && len &&
+		len <= cmd->req.port->inline_data_size;
+}
+
 static inline struct nvmet_tcp_cmd *
 nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
 {
@@ -625,25 +642,19 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 	enum nvmet_tcp_recv_state queue_state;
 	struct nvmet_tcp_cmd *queue_cmd;
-	struct nvme_sgl_desc *sgl;
-	u32 len;
 
 	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
 	queue_state = smp_load_acquire(&queue->rcv_state);
 	queue_cmd = READ_ONCE(queue->cmd);
 
 	if (unlikely(cmd == queue_cmd)) {
-		sgl = &cmd->req.cmd->common.dptr.sgl;
-		len = le32_to_cpu(sgl->length);
-
 		/*
-		 * Wait for inline data before processing the response.
-		 * Avoid using helpers, this might happen before
-		 * nvmet_req_init is completed.
+		 * Wait for in-capsule data before processing the response.
+		 * This can happen before nvmet_req_init() has completed, so
+		 * only look at the SGL descriptor itself.
 		 */
 		if (queue_state == NVMET_TCP_RECV_PDU &&
-		    len && len <= cmd->req.port->inline_data_size &&
-		    nvme_is_write(cmd->req.cmd))
+		    nvmet_tcp_sgl_is_inline(cmd))
 			return;
 	}
 
@@ -981,7 +992,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
-	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
 	int ret;
 
 	/*
@@ -991,8 +1001,7 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	 * otherwise we will need to prepare a buffer and receive the
 	 * stale data before continuing forward.
 	 */
-	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
-	    data_len > cmd->req.port->inline_data_size) {
+	if (!nvmet_tcp_sgl_is_inline(cmd)) {
 		nvmet_prepare_receive_pdu(queue);
 		return 0;
 	}
