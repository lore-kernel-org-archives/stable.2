Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622700;
	b=EuFdN1m5WAqkzRIzaM+UmvzPlQi4gfydgA/mvIY3po1mrauXkobWLXOXhGSZf3yRoJE0
	 5TD/KKDXMI5UMsWdskwhiYodxgxftro9O/A2aHfGwO5mU3rRSx6ztcgcwTvWx7AASXYY2
	 RT5VMUzO5muXU0Z3svK8U3ef8HGNDDOFHSxhJj8fgptKFxVFl+04P6qTBY2Y/fmaDF+Vz
	 Og1PVCO4WCHjVCLISplB/h80UgG4h+LNXgJ3WtNZCKWp5cdo/mrZk3gMBNvDwYNhtNgf8
	 Wj4QYhUM63OSA6h/R4s4ssmWYXmqI5gQQ+KqHEI0bk3kvSuBVcXLb0u/hRhAkWSF7SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=;
	b=gYEyCLohLVfreS2lac0d6gNFxldU1Mtf754AAS2irDIc8aB3+V/WYEbLTPAd0Oz7Peqy
	 OWwaX3+eXjsDUixb2m0x3fzjiY0Y8kPtHTWsIBW3GRr1s0+aKkmvNfAIsbjC2/tzi2dnp
	 IpgH6Z7fOsTs9o6nELhCUWb41IZthwhB0BS4Hi7zgD8CkV7LNC7T/tVY23q95EeQcYlo/
	 GPPBOIKB6TcIGz9qpkAcQXrIiBXMsiXF2w1Tu4fxRBJoIUjAJ7YlAYSUZiK/Y8sE7KVHf
	 iFelBonPONW8hb0MiXK8EZA4nCqIaA1Mk7sMkuKkD0jjn9swXOcjMiMdInP8XytnBEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUqAu831;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D38606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUqAu831
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso3563631a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795622699; x=1796227499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=;
        b=DUqAu831pb6Qr70E3uaM1vedpSKLdpASgOs6rW8PTmrIqleki1ZQA9n5vRE8N/3fZF
         h3bdEVGZW+0TkQGbtUr0pkSb78zk+ahPBDNSOGZ+7dCWDLfvZCC2t0Y8DWlqA9vbCeiF
         /1FDeLanhOuL/1U5Roqdwx/vAMNQ298MTxTTJk6q9LA0DB5tAtORBuVewiEuAc05I23+
         WxFVBpPwWyXGKvhLqWIgEMnSsQ7xv5TXLr+8PRhDqusWGu6K/FtP/dyU3AD2ob5mDqsS
         zQnjIV2DSUk12hI3isJAw9+43VlKqB5JN+eg8Eu5XuaCStNB/5lj78KsEAzrQFiaYaKn
         Z5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622699; x=1796227499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nADcz2AeLIYYluSwXvBJ+Ioe3kCEZg2q9tDv5ALaqXA=;
        b=0zhcJX6RakLmbOLLYLnxgeJUPYYmOSU4UTgLcXn07RoR600cO7+Hlsf2IiREh56XYy
         i+43j/7Nh0HdK/2rP2yWt2TyfKK/cm91HGkZwVFqZX2yh4erPCobcRy/DKYaW1aQ92RF
         6oGaVdCQKNEHuYWv31XbLfS3nEBYfSolGO2K6FE0vKJ5qTZ3YL9u1NFvIrjc2alfUDo5
         27R+ID4Bd4yoOxWeX1OasZ9gjCcnyrcNAwxoPHKmA3QJBMB35cphj/N6Zu6nbQ9wEm/P
         TCEi1DVzdJtIt0gGcsq6wYtVNmc/dvnwRW/F8Qwkm/MXkFNG7oy7eR/U7cHCQEh3Wmdv
         SuwQ==
X-Forwarded-Encrypted: i=1; AL+hErEayALZODYYCHHiFnIKODHhCdWydHkm/1mnc8jgN/dbwgfNUyPoI0eCUHTuOpfONHdGU3AoRxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jf6xS12wPlHiPuW6a1egRacPXXNISeLidYKw2aDVEM+joj1s6
	ddO4yio0S2Qpc5w3at3KE/G+sN4I4iQO7N2ism9a9yL3dHHMDwCJ2U11
X-Gm-Gg: AZFdTZcKpJ/q64dCuTaxA1wJSdP9HbVlgoKolrn6e6VBaaLGpL1f51iFDOmFDqG2JVj
	y0DVUoOEo7toEgrTpd2MKzEP4SFCrPQmYPOjE8LjKynDJDg2xnGA76dBvQ8yEAPgVEbPvfWL5kn
	R29PNzIk6T37uz9odSkL9F/vVVP8iHGvYb8lHu88QKmRIdxMK+maN5+H6vIY4QSG1G19h39Mupy
	9ie4YOJyCKwn0gyldwKYOuPoOal3NrZsZrWyU1pzj1yfZpNsNyF0zDmBjA1BIehkQFFGH3Z/Y8i
	u4qCNb1XFRWCjJJwZN15gO8+TNbxM9FOcSamWvm7dsxrQnYIKEaA29mrqM0ECUP9fF86E+zcwQP
	7cCmaA2MlptUZSsx82P4cOXcXzuFbVViUzoKLLg30iDspBkpPbINi5rI3AFQpMbwGxr6XEU/l6m
	ERxzQzoX8acLBXQlmewrCnGXOKh2STho7j/5iCgCu85RAJ0GPzSocPBTgnClJPrTQfbqB5Zsiha
	RymCrrTqDbxzqhfSvUrnTO0qIuJov8DFuuR7qYeFes87X2JQqGcWSpVYcozfXp38AyBDVE/btNY
	9LDLG3Ei+YXAzFf9vEknFfJOfYU3Egv5+YoqiAtVnHHqapj87kMjH5H7f2FcqHXt2QpxTZtkwOi
	AVaRpjm/Ho/620TzFQSCgFIo=
X-Received: by 2002:a17:90b:55c4:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b41c92ce42mr16574121a91.28.1795622699105;
        Wed, 25 Nov 2026 08:04:59 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm3913712a12.26.2026.11.25.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:04:58 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	co+018500376d4b835e@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: reserve connect header digest and align PDUs
Date: Wed, 25 Nov 2026 08:04:20 -0800
Message-ID: <20261125160418.1518007-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

With CONFIG_NVME_TARGET and CONFIG_NVME_TARGET_TCP enabled and a listening
TCP target port configured by an administrator via configfs,
nvmet_tcp_alloc_queue() calls nvmet_tcp_alloc_cmd(queue, &queue->connect)
on accept before any socket read. At that point queue->hdr_digest is
false and nvmet_tcp_hdgst_len() returns 0, so the response, data, and
R2T PDU buffers on queue->connect are allocated at 24 bytes each.

When a remote peer enables NVME_TCP_HDR_DIGEST_ENABLE in ICReq,
nvmet_tcp_handle_icreq() sets queue->hdr_digest to true without resizing
queue->connect. Subsequent commands handled on queue->connect, including
Connect itself, then write 4 digest bytes past the 24-byte allocation in
nvmet_setup_response_pdu() or nvmet_setup_r2t_pdu(), and
nvmet_try_send_response() or nvmet_try_send_r2t() sends 28 bytes.
Because nvmet_tcp_alloc_cmd() carves PDUs from queue->pf_cache using
page_frag_alloc(), those 4 bytes overwrite the next fragment without
triggering KASAN. Replacing those allocations with kmalloc() exposes the
overflow:

  BUG: KASAN: slab-out-of-bounds in nvmet_setup_response_pdu (./include/linux/unaligned.h:38 drivers/nvme/target/tcp.c:341 drivers/nvme/target/tcp.c:604)
  Write of size 4 at addr ffff8880230f2818 by task kworker/1:0H/26
  Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
  Call Trace:
   kasan_report (mm/kasan/report.c:595)
   nvmet_setup_response_pdu (./include/linux/unaligned.h:38 drivers/nvme/target/tcp.c:341 drivers/nvme/target/tcp.c:604)
   nvmet_tcp_io_work (drivers/nvme/target/tcp.c:641 drivers/nvme/target/tcp.c:866 drivers/nvme/target/tcp.c:914 drivers/nvme/target/tcp.c:1519)
   process_one_work (kernel/workqueue.c:3495)
   worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
  Allocated by task 51:
   __kmalloc_noprof (./include/linux/kasan.h:267 mm/slub.c:5531 mm/slub.c:5556)
   nvmet_tcp_alloc_cmd (./include/linux/slab.h:995 drivers/nvme/target/tcp.c:1549)
   nvmet_tcp_accept_work (drivers/nvme/target/tcp.c:2023 drivers/nvme/target/tcp.c:2105)
  The buggy address is located 0 bytes to the right of
   allocated 24-byte region [ffff8880230f2800, ffff8880230f2818)

Reserve NVME_TCP_DIGEST_LENGTH for queue->connect and keep using
nvmet_tcp_hdgst_len(queue) for queue->cmds, which are allocated after
ICReq. Drop the unused digest space from c->cmd_pdu, which only receives
copied commands via memcpy() and never holds a header digest. Round
every page_frag_alloc() size up with ALIGN(..., 8) so 28-byte PDUs do
not misalign following rsp_pdu->cqe or cmd_pdu->cmd allocations that
contain 64-bit fields. Using page_frag_alloc() with aligned sizes avoids
page_frag_alloc_align(), whose fourth argument changed from align_mask
to align in v6.9 and which did not exist before v5.12.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: <co+018500376d4b835e@bugs.sh>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/target/tcp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8a2e0e056131..cfc0e462d81f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1532,30 +1532,35 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *c)
 {
-	u8 hdgst = nvmet_tcp_hdgst_len(queue);
+	u8 hdgst = (c == &queue->connect) ?
+		NVME_TCP_DIGEST_LENGTH : nvmet_tcp_hdgst_len(queue);
 
 	c->queue = queue;
 	c->req.port = queue->nport;
 
 	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->cmd_pdu), 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->cmd_pdu)
 		return -ENOMEM;
 	c->req.cmd = &c->cmd_pdu->cmd;
 
 	c->rsp_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->rsp_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->rsp_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->rsp_pdu)
 		goto out_free_cmd;
 	c->req.cqe = &c->rsp_pdu->cqe;
 
 	c->data_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->data_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->data_pdu)
 		goto out_free_rsp;
 
 	c->r2t_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->r2t_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			ALIGN(sizeof(*c->r2t_pdu) + hdgst, 8),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-- 
2.56.0

