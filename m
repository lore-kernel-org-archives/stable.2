Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677296;
	b=CECTBAlfmgc/TaVmr0zmviHtHUFHC9B0b2isK8sJsuWz6MB9gihByICmO8D+UnXEzONL
	 Zi86qPHOffhNwNH9N5t1SjQguSsLnN6+xTs/RpZRw8UBi8OR9zN5lcnub/7UE3PLNYtF/
	 lz3aQ7xRXF1k6KE4FiRQl04iNJqHiR2VVZxg71v8PLVX+SkjEnlfIaTG85iQEojYt0+9V
	 IPPkjN8/vDmD2IKaE+IIKEAU4mAka2/Gz//ngoC8Vct/gY0Bx8zkESaOGgqeAwJuN5sOV
	 qssovUmzJgrnCONor/tlo+O/+Ys4mycvFtjfZC4VrL1hheUOKxLVZ5tuyTW5kgiJk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677296;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=/zJvyhXVmWQ8n6ulJrzTmjWsDytDY/8DsGllw13TDE8=;
	b=2CByWQlm7wK2NnzhPm5J3mg9ESkGURqbVBr5LaprX3YjZqsCI4GvZmQX4bJAdLYpyHpB
	 euy6jpZWFmIoPszOmxjUIdYJJH6WCglbu1uscoZOrEAlDjVoCNUmJSGWONSlQpWgFAWqQ
	 NRllroaMcvU4E7BpNifU5R4vd1HoAiVz3lEX5fsRL4d5uKpvcu5/Y8V+a6moi8XEkoHX3
	 MWtxIYCTgAdEPY7hPigGDczHm2RJIGn/H/VcswzyoS8RJtgm7RwQc/lNCHwaCaEANjcSw
	 5tkae1TfI8sFRU90NDJDwqKSkN7h1H8AKuRqP59HtHnzTWd03zMvD9wPxqcL7yd82mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Z2KfI1FV;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF444606A33B;
	Sat, 14 Nov 2026 17:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF444606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Z2KfI1FV
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0t2Pk1z8XrrM;
	Sun, 15 Nov 2026 01:28:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677294;
	bh=g2Pv6nwAGtwV6QX8+pn88NBhcXvjxGhcFYlL9Fzu+Io=;
	h=Date:From:To:Cc:Subject;
	b=Z2KfI1FVzaXNz+uvodFMcTb0jg19SG14R/i4Hzol3FnybUFkK2pDiijjhD8wLGOHF
	 CRdOZ3cH2I2U7jdqLKqBgHD4wriLUD6/PL6DPAp+P1WgoEYqjoAsLLkubIFBmBQu2a
	 fEvr3vY81IHj+Ij0Ku7RsOQrXHHamdksF5VZPcu9W2ZXapYatQiv0xKIhyosrJOpm+
	 SqLSUl5aISWsRkk0Lp2VpT4JMvYV1cmZ0CprZKKRNFp0nX+6JjJm5lcS6MVq3cVQ9+
	 R6Wcl5GD0p5Os+kb4jrY8wjz8gDWP+6UmZNWEg826w3e62zO1TCxrKholdDcQW3x78
	 mkgi9mFDLK2kw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AEHS5kp016868;
	Sun, 15 Nov 2026 01:28:05 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:28:09 +0800 (CST)
X-Zmail-TransId: 2afa6af89a29b80-55b2b
X-Mailer: Zmail v1.0
Message-ID: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
Date: Sun, 15 Nov 2026 01:28:09 +0800 (CST)
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
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lLWZjOiBpbml0aWFsaXplIEkvTyBxdWV1ZXMgYWRkZWQgZHVyaW5nIHJlY29ubmVjdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEHS5kp016868
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A2E.000/4jRh0t2Pk1z8XrrM

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_fc_alloc_ctrl() initializes only the admin queue and leaves the
other nvme_fc_queue entries zeroed.  The initial connect path calls
nvme_fc_init_io_queues() before creating the tag set, but reconnects go
through nvme_fc_recreate_io_queues(), which does not initialize the
queues it adds when the controller grants more I/O queues than the
previous connection.

blk_mq_update_nr_hw_queues() then publishes the new hardware contexts
while the corresponding queue entries still have qnum == 0 and
ctrl == NULL.  nvme_fc_connect_io_queues() builds Create Connection
commands from qnum, so the new queues are connected with queue ID 0
(the admin queue), and __nvme_fc_init_request() also classifies their
requests as admin commands.  Worse, nvme_fc_queue_rq() dereferences
queue->ctrl, so any request dispatched to a new hardware context before
the queue is initialized crashes.  This includes the connect requests
themselves, since connect_q belongs to the same tag set.

Initialize the newly added queues before growing the tag set, matching
what the initial connect path does.  Existing queues are left alone so
their connection state is preserved, as required by
nvme_fc_recreate_io_queues().

Fixes: 3e493c00cedb ("nvme-fc: fix nulling of queue data on reconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 with nvmet-fcloop in a single QEMU/TCG
guest (2 vCPUs); no FC or network hardware is involved.

The controller is created with one I/O queue (attr_qid_max=1), then
attr_qid_max=2 deletes it and forces a reconnect that grants two
queues, so nvme_fc_recreate_io_queues() grows the tag set from 1 to 2:

  unpatched                              patched
  nvme0: reconnect: revising io queue    same
    count from 1 to 2
  Oops: 0000 [#1] SMP NOPTI              no oops, 6/6 cycles
  Workqueue: nvme-wq
    nvme_fc_connect_ctrl_work
  RIP: nvme_fc_queue_rq+0x21/0x190       queue_count=3
  CR2: 0000000000000020                  I/O from cpu1, ret=0
  Kernel panic - not syncing

The NULL dereference is the Create Connection for the new queue: it
goes through ctrl->connect_q, which shares the tag set, and is
dispatched to the new hctx whose queue->ctrl is still NULL.  CR2 is
0x20, the offset nvme_check_ready() reads.  The target also warns about
a duplicate queue id on the same reconnect, because the new queue is
connected with queue ID 0 instead of 2.

 drivers/nvme/host/fc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..f3603c793ede 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2932,7 +2932,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	u32 prior_ioq_cnt = ctrl->ctrl.queue_count - 1;
 	unsigned int nr_io_queues;
-	int ret;
+	int ret, i;
 
 	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
@@ -2959,6 +2959,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
+		for (i = prior_ioq_cnt + 1; i <= nr_io_queues; i++)
+			nvme_fc_init_queue(ctrl, i);
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 	}
 
-- 
2.43.0
