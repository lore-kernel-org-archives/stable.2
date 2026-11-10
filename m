Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323007;
	b=1lsLVUvRp1YJpo902oiglmjG3qI6BHqU+xiiMvoNBGL49/bOfNTuLCDh4XZDvQB+8mLm
	 BFE9l8o2bGNJor+bp1DhQ4Ir39g+l7p2i2eAZtgqIaSTc3WRw+i/Bukb9xK2MYGv9mslK
	 S+mRzjlfwkPQiULhDs2CpqL8vUgT1u4vIJIma5gbe2p3pbcBGf4RG7vQMBGhNlRdGbJXu
	 6+I1tnV7tL+0Ql5vX58loRrw0kX1kS/Hh/4gCsTm6Tr12N3UiZ/TZEd1TgTEAMt2su2RT
	 luWNqYvUM/Ci5lqMSr7JC3/FPqvV/a7eAiEReC/jM5xAufO+f5XbXA24Z3mwQvhVaUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=8IfQhFatm69/QzUFwynlM3k1WKbnUbQP37INwDNgvZQ=;
	b=iNPt9PGLK8oaes1Rzc32MULKLDEhxarSLzZ8oOtglpCURzW/w24gwPcynU5V0Kk9WOX2
	 ezMU53WK1pSq8ocOpW3tQGcHc0XC+ma5A/B+qt9tBeHyUmIak8Yw1BOrJRPxZjo2Tsp4i
	 wCpihitMnqi8/XRni77K/Z12mVeaI/fyr+JIehd56sjRIFSuii7fDQYplkK7pNqKHJ/vB
	 OZ+mnb5A3bNwlVti6yGUypqEpe7wSkfS4iWFfyjQlf/gUx4hsp+Nj62jJZ/BoIxLK4sqn
	 uAGl6htNxqtM2qdyKMNZxCBBwbbGi5sIstn7lRFlhfXYbfeZR9tfTR8XojBfQfIvzaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FJNalWXa;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C3606A338;
	Tue, 10 Nov 2026 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937C3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FJNalWXa
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zW1PKtz4xPS3;
	Tue, 10 Nov 2026 23:03:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322999;
	bh=IBidnU3G++uWwfv2iMzuGg55NnOYFg7OCGfTXFLXIjY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=FJNalWXaS5WB708ZczLwpF4u2QcRYHnKAjt+JHENSuf7TdbOmKU+wyZDarmXkw54Q
	 oOmWZHK2mh0DSpZqE8Xf75W+GmTYJBglQ+aJZytRN1y+s2TUoJLqBzK0z3A6KNZ1ZF
	 oR2Ei/Zm9sIfY0I7lreVzFk0HmSXOxVEDoG6nm/foJjrVleYy6pLGZkzJY2BT3T4kw
	 SCl4YDsvfOoyyuBW8EZiyVlGC8NfYKb1/cIRlY2I3zd1cJxtWmjKv0dsLDp858ucrn
	 0murj3y+j3konWnqR/DD1S0PAYJL57t5j57T5kcNpVSEhmMc867GtI4e2o24f238gc
	 2SeqOA3/ePzpw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAF3DJO011153;
	Tue, 10 Nov 2026 23:03:13 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:16 +0800 (CST)
X-Zmail-TransId: 2afc6af332343da-01a1e
X-Mailer: Zmail v1.0
Message-ID: <20261110230316687z-VG9wgpFwmzFNKVnMGKY@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:16 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDYvNl0gbnZtZXQ6IHJvbGwgYmFjayBxdWV1ZSBiaW5kaW5ncyBvbiBjb25uZWN0aW9uIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAF3DJO011153
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33237.000/4jP8zW1PKtz4xPS3

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_install_queue() publishes the SQ controller pointer before
claiming the CQ. If the CQ is already connected, it leaves the SQ
pointer and the controller reference taken for it behind on failure.

An install_queue() callback failure also leaves the CQ bound after
clearing the SQ pointer. The reference taken in nvmet_install_queue()
is in addition to the one the caller already holds: the caller's put
releases the reference acquired before the call, while this one belongs
to the CQ binding. It is not released on this path, so the controller
stays alive and a Connect retry on the same queue keeps finding the
stale binding.

Clear the tentative SQ binding and release the extra reference on a CQ
conflict. On a transport installation failure, destroy the CQ binding
as well, so its controller table entry and reference are released.

Link: https://lore.kernel.org/all/20261106015842.3534898-6-kanie@linux.alibaba.com/
Fixes: bb78836b3a7c ("nvmet: fabrics: add CQ init and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fc626c2fd2c9..6f0fc695e649 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -216,6 +216,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (old) {
 		pr_warn("queue already connected!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
+		req->sq->ctrl = NULL;
+		nvmet_ctrl_put(ctrl);
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 
@@ -242,6 +244,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 err:
 	req->sq->ctrl = NULL;
+	nvmet_cq_destroy(req->cq);
 	return ret;
 }
 
-- 
2.27.0
