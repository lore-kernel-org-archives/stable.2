Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592984;
	b=lIAYZDhuzogB04iwSQtAJNI6VKyAw42joQjJzQserPKid54hq1S45j0nMz9dhpf52JCK
	 8dTPIbrOPDGw6rfnm4H7yz9vSjCUWhAuKglGSSicOVlEOUAjhsTEVyoTOfhRI39YGp8Br
	 8FRYAgUmfqnefseck3ZFWXpEEF3B0lvce7k5YlesFCTxktLJZQOdhkXdTk8QZEvs9q4hT
	 uy0SzBbFFEjd4U2RZpD1AtriLcP7It+6GCEHy0+PcwKXEcNDM7JeVxs4Q2QDIxd+RLWKK
	 qBC6gpMELRuKvPp56thRMsdYO+4kUJcv0+aUnl+TuwctTke76RGKXJlm9+7hxlb0w7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592984;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=98ex+Pn2nBtI8mxDvjHYBDQsrjNC9orlyIfrJ1lLZwM=;
	b=cyngKHQIa7WfyRmBuPMYKltcV0PZbqQTyszrnP9KR/3ceI0QnsSmUSfYNPwO2KnceF2j
	 Jf0uB6cL0cxJAHJb74ovajB8vJxZ17kIBF7Ui+0u84VdfxPRCdPGMeT8DJIVJJ5OVJVpZ
	 1zTYlQkC7WLLKBfC76AYGmV9FSjl9i7GgcPskNyh7Ji0XHxbil2PJvPuMUwOjkLevM6bK
	 9W13fXiP/iqeDhWSE45YfNx9EYgkmNWSN5mBG1+QQYfzoCD7ahJ6n1xxHn75E5VnyZVoZ
	 5J7LGeZcH13YZaskI5NwuTh4bFIqdzYtybXSXCRe3i97KpExza90WOGALRncRO7LMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uVepKS4x;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558E606D4B7;
	Fri, 13 Nov 2026 18:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8558E606D4B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uVepKS4x
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qV0XmPz5BNS0;
	Sat, 14 Nov 2026 02:03:02 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592982;
	bh=Wa+PLqTTMCOV+xu/ec1ktJKOPJdj2fOT1wVmnMmRve0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=uVepKS4xIsG1HyI69BVxuCj8OPGNuTaGG0gI3kOol8NRVHWKHa8CWksx0pIhUMXBy
	 MPP6aNfVRYDbYUNQcJU5Zn4CNFJOu2jfn8rxmHJomYnsmx2kKp4vzB0yzWvJaNrOtz
	 UGENEHaARPkzmj5Gsd5dLkRUfiy5fghqOCak23aGUhDLOYU6TEMnuRMy5WujR1FRmK
	 cSM78LtmYo1VF4U5y0jWvUjRQRQgG6zXz4Fi1wZzNSS3uFwkWhMOWO9QN8wlF9ZMJw
	 QdaxqoEYvQ2XyON6P+dyQQTHdB6JOAJI2Ud6bp9ZTagvbyMx7tSmQ05LQFU1G40iqF
	 /Q/6Lj+fHHUTg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6ADI2sVg073617;
	Sat, 14 Nov 2026 02:02:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:58 +0800 (CST)
X-Zmail-TransId: 2af96af750d2ec5-15e0b
X-Mailer: Zmail v1.0
Message-ID: <20261114020258146m8zL_TJCcRbcnVKxGbNGw@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:58 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDYvNl0gbnZtZXQ6IHJvbGwgYmFjayBxdWV1ZSBiaW5kaW5ncyBvbiBjb25uZWN0aW9uIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADI2sVg073617
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:03:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750D6.000/4jR4qV0XmPz5BNS0

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261110230316687z-VG9wgpFwmzFNKVnMGKY@zte.com.cn/

 drivers/nvme/target/fabrics-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fc626c2fd2c924342b550764f686010103e5ec84..6f0fc695e6499247340d3f17929608e4f03c00f2 100644
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
