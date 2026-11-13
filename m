Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592977;
	b=FWc4CGxquVLmnf0lMU9CKkambDwgL93hx4mdhizBDKybje+0aYCR9GrqujLHws+kuOXs
	 Q3sukSdQNBi0fOQIPYfZw96Ls4lIZJV0LcnZ2QQ+2o6MyoMh1ByWKTmWIkGySmvc9NxnO
	 6oXFw+AEwj5bABnbFVJ47A3o/ldu6jeg/m3kcMBN2GoV+TJpSBE9ao4F6rXhb6XrktXzw
	 9IEXsJC1CnuUJWtlvT8GMXYrY4zclYj5CQ7nKDeIqX+Bn9ckmqRSKWBWfysIez2LbhcY+
	 3PtSH8CMUVRciSa8M6qSLnDHdiwdRkL2MmaFtbQn4HN7dF3/h9yfXemzBiXbFySTUeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Qz4lwjhN+zy9UnJUi+NL0/dL5i5uur8jmQ6VApJh9bA=;
	b=iq7kWGMPkBlcyF2fORssFx8ujZdBpOJRZVhwwQv4iqIYsJO4L+LBtNnyZmPwodkQHlfy
	 V+Hju3aJkOvzxrNtM4DbH3eZtWRIJvtBq9t/8paAfJz92GBL2NnnTi6HTeopyeke0mm++
	 u+VfGIuoMvdO32kBGy+0iCET5yMG/7weUmEP/t+9WUZ0K6C29Ml9I7XApy+tjnEn4TQkG
	 esQ8KkyCwbjzyVAJkP4U1cSHlxqg2GWoeJUhLsrymuROT5QcFvRhr9NDTAkf0n8bV2RbP
	 H9yvxMlR30TWd0Tc4kCybyrQDBZRdmoQc6PC3g8OT8PbrJBf4H3IaSZPnkIyT4JCzQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gZmUFcaR;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B7606B34C;
	Fri, 13 Nov 2026 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 678B7606B34C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gZmUFcaR
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4qL4Mt2z51Sm6;
	Sat, 14 Nov 2026 02:02:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592974;
	bh=UNN0dxgDClL2hwhFYfXAElfpVz8W23wJyKVhsYOTWPE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=gZmUFcaR+po4DKC2TPjJJ+kTPFPt3BHZ/6NUd7FzsvF2qmdOJU6q5+nhjO+enmTYl
	 IGZ6IJszvWf7HSVbKLZiRHOoe4yCBdK0QQjkFYdV17HMGiapjh8ND1KjBmKDavdlcx
	 gwFqC7Wvr2D9hgfX5fWUzcJ68eb4DFJ+hWNp4DDThO1bXKEGEWjMTI412LcZcEnJAV
	 9ljmjXSBuQqyl1TyOj46SXVbP268t14d8GM2kh0NKSerNrWAXmJs7MIst/AUAoutca
	 kGypSiMLIIK/2tj/indXLDdfllwfxezDd0J9/bfXmQEVaDxiBpRatUQRMuF+jvZZzi
	 0k0QiuCHK9S6Q==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADI2k4G099800;
	Sat, 14 Nov 2026 02:02:46 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:50 +0800 (CST)
X-Zmail-TransId: 2af96af750cacee-15c34
X-Mailer: Zmail v1.0
Message-ID: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:50 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNl0gbnZtZS10Y3A6IHJlcXVpcmUgdGhlIFIyVCBvZmZzZXQgdG8gbWF0Y2ggdGhlIGRhdGEgc2VudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI2k4G099800
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:02:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CE.000/4jR4qL4Mt2z51Sm6

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn/

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

 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bc46e5f3eaa79ed402cd238caa7300ff7a7bb156..2672aeae086a9a1605d9c64dc73ab837beca05a3 100644
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
-- 
2.27.0
