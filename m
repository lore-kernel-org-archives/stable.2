Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322998;
	b=hOKc8OT3EYr8LOD6ZZb7V3OuxYyITFKIvnHyzdcu9MrIDfYSXC+CFNu5lT/IZlO27SyF
	 y4STg6WFWrgmQJBnNurniPjI5Dy7Q1wh5UvM8kwS78wWHVXf9m9vHma6P5LSd8CXR0TZf
	 oOwuiEJ10wGf0Y84ppT4mI3cjE4Kp5C4cu+lqlDIXao/PNddQBkG2OztQ0HqkeLzy73r7
	 sV5u9G5pF0NGlBMpy3n2ITHTR+ANuKNZRjpg01VMxpvvc/TUd0biUsA43QUIACWsDxyS/
	 LFMT6RmEWT+E+GA8lUMdkwj7ZIVg1igRBIcsDnGOlqGdnObJSB+q5zRyalWDfJ8xixA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322998;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=e4ojIjypxpGFfHLcr9bc7NYtjzNqTM2+V21XA6rWCBM=;
	b=YfANcW/eT87MsEkCJ1RGQ1VCyGpq0VomxV6cFMSZvbrmwjPay/m0V/xBFdebreNVreFJ
	 hJhQHZUcfu0hE5nmnimKLEgEzZVam0MZz0POh10RlbPXr3j9yPXsgT6WYjqwi/+Rj1jJj
	 Gh/rVJSsXtMsQuHBzBBzK++JZ5sUmzcPK8EsuA1+H/ksi15z1MGatG+ptMad2rXHcozx/
	 XdiHvotTCg1kYh3bVWtKJQgC6jC85OM0UzBp122rWGJS7U4r02+1CeH6oB58JFSUQ1lkN
	 mPmCd3Xm9NbD1MSN0RClfFneNaIEc5FBjnIUDPJ6kO5saEdxiMrLVi5M4lNYD1hEnxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=WPY4PaN9;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E460A2605;
	Tue, 10 Nov 2026 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D25E460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=WPY4PaN9
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zL2Bkwz4xNty;
	Tue, 10 Nov 2026 23:03:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322990;
	bh=esywIpnBzUeJpgm9FcNnCUHVepzzgXDRhZGqSs8qLD0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=WPY4PaN9suiNoURjzOXv7BZPw1xatWi5LQHXqd7pTMmANdwLx/fOpI7SNXLALo3jx
	 J/xDNuzuaV4tJAcOPNSymEG7J4JVlYfgiv0GuK5jcxRVyPghrFJWSlhjKpQIRNk1SZ
	 X0HEu92QoTl9Cw/jCtZ9L+l6kocI86fnXIkkKnluh05iuX26/G2Ccs3AxoIsehfdJv
	 XxPd4uSbDzlhnQGsEeqfhtT3nM9lKf2uTkrt4D2fikCkUQFKr6LQ7130Kr1jNxlIwe
	 b8F7a4zJA2mw4g16TRZvBqWyzXN4PhVuT4yN5yyE3yRmbOoqS1E3qkdvcyaPSPXkPq
	 7rTnDumAkgyvw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAF38pd011120;
	Tue, 10 Nov 2026 23:03:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:12 +0800 (CST)
X-Zmail-TransId: 2afc6af3323029a-018de
X-Mailer: Zmail v1.0
Message-ID: <202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:12 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNl0gbnZtZS10Y3A6IHJlcXVpcmUgdGhlIFIyVCBvZmZzZXQgdG8gbWF0Y2ggdGhlIGRhdGEgc2VudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAF38pd011120
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3322E.001/4jP8zL2Bkwz4xNty

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_tcp_handle_r2t() rejects offsets below data_sent but accepts
larger offsets.  The send iterator still points at data_sent, so the
next H2CData PDU carries bytes from that position while advertising the
larger offset.  A target that accepts the PDU can place the data at the
wrong position; the Linux target rejects it and fails the connection.

Require the R2T offset to equal data_sent, rejecting the invalid request
before transmitting data with a mismatched offset.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the nvmet-tcp
target on 127.0.0.1; no extra hardware is needed.

A test-only hook in the nvmet-tcp target shifts the R2T offset by one
4 KiB block.  The 4 KiB write to a loopback namespace is then answered
with an R2T at offset 4096 although the host has sent 0 bytes, so the
host either transmits an H2CData PDU with the wrong offset (unpatched)
or rejects the R2T (patched):

  unpatched                            patched
  nvmet_tcp: ttag 2 unexpected data    nvme nvme0: req 99 unexpected
  offset 4096 (expected 0)             r2t offset 4096 (expected 0)

In the unpatched case the target detects the mismatched H2CData offset
and rejects it.  This test demonstrates transmission of an incorrect
offset, not a successful corrupted write.  With the patch the host
rejects the R2T before transmitting H2CData.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bc46e5f3eaa7..2672aeae086a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -846,7 +846,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(r2t_offset < req->data_sent)) {
+	if (unlikely(r2t_offset != req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
 			rq->tag, r2t_offset, req->data_sent);
