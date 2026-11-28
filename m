Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795875627;
	b=FqpDFrZyK0GwQx+3SjjZKna4DgN8ITxFaIjBYoa/T5WwLkwAM6+w11CEOxgmmjeuRJ8Z
	 2NXUJ54LOAxokKuth42Ug/3Km+QdDoLFVFaMqa00GgQOgkuojAUr8ftgVENbBgkLxfj2j
	 MdulB1BMCNuwv/yx7SqtMuU+Wfuk9AukxVQy4auwsdJe7kOh+bdEmhqs/+lDT1IV4oj3V
	 p5CMx8Igqd8anaFeEsb4BRnCM6gnW6xEN60mkgNhrF6HNybtvkW27u9RjTnsOI1rJssUl
	 cX7ahQNfzQnF4ENF1EkKPLGygPCKx4U2HdgA5eHnNQFnfb6aduSBj3ZD6pMDDZ0igiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875627;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=pawt8oGq6umaf6NmqEM5/lZJgIRl7sY1HdmBuiFOy9M=;
	b=SDC2rbTfCRjvHOi9K4i/Y8Gwy3Xg6eaW9CfvwHFOH5JMbqGmn9Sg+IqUK1LMOK8brml/
	 N9ek4y5+DUeoQwBfk0qRk0dy3q+N/cq88/pkK0g3LV75A7+LTpKetL2ZT8CM8lR+qrQK4
	 0osXGtfNsegCelvrlQJB6W1cxIt0bL3akBAPUR6Ccbz6pXLPYtscVLaCNEgJNM0g5f62N
	 hIu3dfJyPHbxdnrSrzrN4HO67nDvB7DZYLh0TSDlld/iMeFovy7eU6r4EUczuwdTFfHIK
	 ZivcQQHswuP4hAn5w+uF6BKZtjR6bFgRxgzEB9TAL1a1p4x4+vDRPiW/w6qms6GbzLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHc9ywVD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E197606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHc9ywVD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795875627;
	b=oKGZzBCLguwQpGObzLUStMdiF2s2pPjpoC/48+0tDzsgbq3ZReX5jZq1KKAxdJejD74W
	 C2DSaCtN7eNK87c4PpZqXc54ODLdlSQyHdVKr7zuSUMmbqtVRe9hmy2lsY5/KJIjYXXh2
	 iVms4zCY/lSxG9KuDH06gPUK62JSdE7p84KYaZK+LR9I9oCr9uIyhXzHGnGeqtsBheh37
	 cBxE8B4+APvDdnW+1jxue+lD6xpJnVprx9/E/BpTBJKyd5+ufzCBqLw2KOHOKgaRlZQW3
	 hzYIEOipTIzUh8Ww2/px6BggC/MxYO6LclZGDGYkwLWeeB06AYJCJFYcfavWipf8/Tg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795875627;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=pawt8oGq6umaf6NmqEM5/lZJgIRl7sY1HdmBuiFOy9M=;
	b=smu3ef2Oa/hsmtI1Ac8x50Ux1+aCt2yj0g9h0NCNOz6oJFzenCi8vb5sJ0m6k72VjLPs
	 /CTlBCGDm7GBoZ7vvrW0spTGAxrunj7cVN6yEVvVF79KcU9UuZtXF2pT2fOjNixC+LM3V
	 dN10WaMdaIne1REmUN6vbB2MVYg4KUHzs/bq9Yt5EYkjpe5ybmbyKqrWg4iefEGjTclEY
	 lzqpQMnFFobnT/EdvqENnoGMosfCRVm3eZcU7FcHTWozhB054joDewgANuGj04+8zw30v
	 d1TO2vEVhULR0VfbXLHh9sNrg71FBZx1jIDGR0lWmbAT/Gfw/fOKEgjabD6lc1IchrQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE1CF1F00893;
	Sat, 28 Nov 2026 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875627;
	bh=pawt8oGq6umaf6NmqEM5/lZJgIRl7sY1HdmBuiFOy9M=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VHc9ywVDN++YkBP/lQVuGZ78Re5OnHo4lP7DAHK2rLeWG69Ud8CPydv5l/n70C25c
	 SYI7F5DH8RRpTQbQgoSyM9Ya9d/eOBsfjEpW6xAtP5NyZY1ccZsTQofjimElg3oSqk
	 o08kloq9gF/SyLj3DS9sge09mh37w7u8VTSuHYkgvbGKHlIs8KdnhgQDoMOhedYSjo
	 q04flNanap+fWKl+Ot9+tv1Y+rniwDyVeMbSm81M+BJZ/wCPpHbM55NHwb8lUdRSCa
	 XDZqGpL9vhxUIxZ4bSmVjH8JPxAFcNNPwC9nBQdkm4t11iYF2qoxjYalx1RXz5gxko
	 DIX450IRL1goQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 76A684E0F4;
	Sat, 28 Nov 2026 14:20:26 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Sat, 28 Nov 2026 14:17:55 +0000
Subject: [PATCH 6.1.y] nvme-tcp: sanitize request list handling
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-nvme-r2t-61-v1-1-2c1875964e5c@certik.com>
X-B4-Tracking: v=1; b=H4sIAJLiCmsC/02NzQ7CIBCEX6XZs1uFRjS+ivHAz9ZiFBoWG5um7
 17Qi8f5MvPNAkzJE8OlWSDR5NnHUILYNWAHHe6E3pUM8iCVEPKMYXoRJplRCbTKud4dO3myHZT
 FmKj3n6/tCqoV7Qy3H+a3eZDN1VSLRjOhSTrYoSKm4HKMT6x8//cA67oBfgNda6IAAAA=
X-Change-ID: 20261128-nvme-r2t-61-c6ddfd5327c3
To: stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795875474; l=2848;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=yxyohbLELQu0GqhP3UK8ZEJTUCvWETlmMB05ClrCXEs=;
 b=bsPmz2p7CTmGGgLW7ptdKV62lGGGqAWVum9OVA+6XTBN47Fgh1ij0ARibbNbJ3lO/F2VngpLt
 5jZWI3zKvjfDs+Bb1A/U1UPXN6oBa3XZLY0v4XeXA/2Juf3fWOJ/uA+
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Hannes Reinecke <hare@kernel.org>

commit 0bf04c874fcb1ae46a863034296e4b33d8fbd66c upstream.

Validate the request in nvme_tcp_handle_r2t() to ensure it's not part of
any list, otherwise a malicious R2T PDU might inject a loop in request
list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[ adapted to 6.1.y: open-code absent llist node helpers ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This one went into 6.6.y and 6.12.y but never made it to 6.1.y,
since 6.1 doesn't have init_llist_node() or llist_on_list(). The
backport open-codes them as node->next = node and node->next != node,
which is all the helpers do, at the same four sites as upstream.

Tested on 6.1.193: W=1 build of drivers/nvme/host/tcp.o, base vs
patched, no new warnings. Both kernels booted under KVM with nvme-tcp
built in. Build and boot only - I didn't send a malicious R2T, so the
new check itself wasn't exercised.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/nvme/host/tcp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d434c24e035d..b9abd25d9bff 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -386,7 +386,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	req->lentry.next = &req->lentry;
 	return req;
 }
 
@@ -494,6 +495,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	req->lentry.next = &req->lentry;
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -740,6 +743,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (req->lentry.next != &req->lentry ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -2376,6 +2387,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	ctrl->async_req.lentry.next = &ctrl->async_req.lentry;
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }

---
base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
change-id: 20261128-nvme-r2t-61-c6ddfd5327c3

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


