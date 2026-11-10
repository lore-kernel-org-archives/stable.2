Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323004;
	b=nQBTYfzEAj0wT7TNWsFnjOeCH+mtvM24v7dDXZmH07gBbNHIc5iWfe0sQX1dU0I+BDD5
	 cOO2AH5+VitgzhzhUiOMva+bDEv6C8Kl44OwZzi+HnPBUU8kR2ErDKHQ82HVXV+K/jH1R
	 S44Ec/sHCtitvrQsRjTirXjuF5UZwMqn4GY1cfxEwb0NhB0DsDky8JTxWbAPITi5UVG1D
	 E0mkaZ1EWWQk4GRVBULyhcvtcdWAVJJoIa+u7TwxEVWXH8lcIDbma1uX74oKa29Qb+sS+
	 4a8Be4ZHagdUOFH1uGvIANSsWl+jhx7ktuFHkqoAa4PABODNOi3P8fpcHRzWnJRX0ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323004;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=sXxgGhcF0mTkYDF8HuHev/I0qLZckh9PHUK6grJLeg0=;
	b=J0rPOMmHpcoanphiSxU9j/jyKPhXJCpz6JWjb1LiviSi0Izsfld/AQbTcIJ0DcMnYfL9
	 TBm2NYY+9EEwnBKsRDcKvAY3QTMJP0al75ep7OJBt3LbwBv0QRDTeTubL4mjFrugNNUJ6
	 gyTCVHO7Q6bnL47gV1OESI+HirgzbLppMhP4sFpDOQb9EMp1tjhgVF1c7ek5QRwa6vEwZ
	 WqS05Iy9G3SzCFRHSGLa5uljKhLlilr9ocQGvi97eJWbf0+nyVKDYrafmtM2664ni1e1l
	 32f3s6E2MMVfvnnmnSi3hCd7cFd4i4UuCHIJMgTAHwk+MavBGyzurPmlYI6A3kfq7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=C2oy3SkJ;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EC60A380B;
	Tue, 10 Nov 2026 15:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 189EC60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=C2oy3SkJ
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zZ4xTfz8XrrX;
	Tue, 10 Nov 2026 23:03:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794323002;
	bh=/88cOaiDZMOr8DKkibMc9irzW48otaXY8hW0OxygJss=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=C2oy3SkJirJtL/VeI3Bl74p7zgL9ki0z3hEKoXKqamobDKNGEjGsTYBg9Fg3HaSi4
	 LGjBwn3SA13H5YlGpIct25UErCZ7I+OQ04cDGXvLEIq2Ar+/wClgxmZ0THwcrwnwlX
	 2P8xw+FgMn2MFMrFM+3I5S8VW+14Wp3goA86QZlFD0CphKcdHQrK8oEFwAN0hN9FuF
	 V3/z2+zd64SvLKam30rgDVyhCwLhz7+qwXXQ1PCR6fJUboEQTeNaoZPBqKULzl+Nvn
	 t751+U/ZLRUtqHVMNaLifnAI2yCcjrMfiQ2tTPzFXJPXd6S+0PyRRTT+irCiTooTwV
	 MWaELsN6fgaGg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AAF3AXW011142;
	Tue, 10 Nov 2026 23:03:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:13 +0800 (CST)
X-Zmail-TransId: 2afb6af332310c0-076fe
X-Mailer: Zmail v1.0
Message-ID: <20261110230313720JCGXeTg2zOideed82vWy9@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:13 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNl0gbnZtZXQtZmNsb29wOiBmcmVlIHRoZSBMUyByZXF1ZXN0IHdoZW4gZGVsaXZlcnkgZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAF3AXW011142
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3323A.002/4jP8zZ4xTfz8XrrX

From: Shao Mingyin <shao.mingyin@zte.com.cn>

fcloop_h2t_ls_req() allocates a fcloop_lsreq from lsreq_cache and hands
it to nvmet_fc_rcv_ls_req().  That function only takes ownership on
success and returns an error without invoking any completion callback
when the target port is shutting down, the LS payload is too large, or
the target has no free LS request slot.  The error is returned as-is, so
the fcloop_lsreq is leaked; every failed LS during a target port
teardown or an LS slot exhaustion loses one slab object.

The target-to-host direction already frees the request when
nvme_fc_rcv_ls_req() fails.  Do the same here.

Fixes: 772042dd38ee ("nvmet-fcloop: allocate/free fcloop_lsreq directly")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the fcloop
loopback transport (nvme-fc host + nvmet-fc/fcloop target); no real
FC HBA is required.

The -ESHUTDOWN error path is otherwise only hit in a sub-instruction
teardown race, so it is exercised with two TEST-ONLY changes (not part
of this patch): a debugfs knob that makes nvmet_fc_rcv_ls_req() return
-ESHUTDOWN, and SLAB_NO_MERGE on lsreq_cache so the 72-byte
fcloop_lsreq does not merge into a kmalloc cache.  A stock host sends
120 Create Association LS with ctrl_loss_tmo=0 (each failure deletes
the controller); the cache is shrunk afterwards, which only reclaims
empty slabs:

  unpatched                            patched
  lsreq_cache objects 0 -> 120         lsreq_cache objects stays 0
  slabs 0 -> 4                         slabs stay 0

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a6..a9cde536c33b 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -379,6 +379,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
 				  &tls_req->ls_rsp,
 				  lsreq->rqstaddr, lsreq->rqstlen);
+	if (ret)
+		kmem_cache_free(lsreq_cache, tls_req);
 
 	return ret;
 }
