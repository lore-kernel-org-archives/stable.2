Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677282;
	b=Z22O8Ho/T/JX/ordU3uCnvtEz2jXIarunYqSkt52CbHoL7HY5r8KLkF+hoNXFLzRlmOx
	 7JGxhePr6nUQff5Zu0R/sl3hFz/XAA2u6WFq34Tvsuw9VNnLGEAZ1S9iXKpufe0mZTo6r
	 aaKsqRNdIFIa/q9dSsIgCwQbJXdcg40B6XwrXifjiir9Ng2+2Ec4Igsvc8T6HSmQH175b
	 rWOp1Cb8anisoJSdIgK15QpPyGoA/yLGR4OhRljgHrjhbjvcCllon3ClC/zCvLaeLP6Hk
	 4TNjZxLye/k0S31r/S/ftQh96fj0L6xwJthsaDI216e+cpCn1tFxNKQBi3zDUxjJXYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677282;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=EFB6pKr0axxbQJKX6PGyT2Y/es1tTUX6URN47Nk5Agg=;
	b=IKcIDJFP/hmxuIJuaCPoTnC+cQrdTmUwFUHj7O6CJBemd5CGxE2Y5MZ5oy50uV+vwJsE
	 RD0lHiSU05RDxFSPqiLE74L0R94rAZ49vzoUytdzK+gLUKlk/jCmF/3HVcJQEmqe9GhD8
	 JTg1hRH2VJJ7grsFFosxCjUsfn8UO7c8c+S/ePt9LpcXebSFjBtFOyPux6V4fGPIKubks
	 2Dvu+tI8xfxsewuyr0OgnuR8UfrSMIlB5rLCs1Hxy772AxSOdLWdb4KD46MLyirpGhjrD
	 u/or7u3ziYAUfstcurduNfG9W5IeYP2zt3XewLyaK724ge5X7fG55xPCg7RHGMaJezQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="s/E2t7Tq";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7C606A335;
	Sat, 14 Nov 2026 17:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F7C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=s/E2t7Tq
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0c12RNz4yjS5;
	Sun, 15 Nov 2026 01:28:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677280;
	bh=I1JG6le6Uef8Mt4c0Q+i/wiVYoqj4sIPEdX4T175tuY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=s/E2t7TqGkFshyW9bTVLC6is4aTXF/0bMqlDyKlEZcn1b8LYH1QarlIyWIv37TuMM
	 tTqLQM58d7DWv3PefspZ2rccCgdPakucxD/F3KCT+31q153n7dG8LRPMlnyS/oz9o1
	 Fq7eZe7SZqrTVSRBLjatFCVWoZzcXLuil6Iy27MGV3ly3wAC6OipOk2hMqd4oV7roT
	 JJHlF1U+hIDpAgPrJAJhpUDIoY8rsc95of1s3vCZ60ueLxN86iNm4jMZfLyrRbr63z
	 7iq6c3gWc3QjG75iALqrvlw64Uwm44J8Q2yS1gcuJBUhaicGZZth7cM/XqN0wTYABP
	 WvZEpiD5nad+g==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRrTL016767;
	Sun, 15 Nov 2026 01:27:53 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:55 +0800 (CST)
X-Zmail-TransId: 2af96af89a1bfaa-57f53
X-Mailer: Zmail v1.0
Message-ID: <20261115012755704MxVgLMp__EddTP_3H7nCd@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:55 +0800 (CST)
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
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gbnZtZXQ6IHZhbGlkYXRlIHRoZSBMQkEgZm9ybWF0IGNvdW50IG9mIGEgcGFzc3Rocm91Z2ggbmFtZXNwYWNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEHRrTL016767
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A20.000/4jRh0c12RNz4yjS5

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_passthru_override_id_ns() clears the metadata size of every LBA
format reported by the backing controller:

	for (i = 0; i < (id->nlbaf + 1); i++)
		if (id->lbaf[i].ms)
			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));

The Identify Namespace data comes from the backing controller and nlbaf
is a u8 in that structure, while the LBA format table has only 64
entries.  A broken or malicious backing controller can report nlbaf =
0xff, which makes the loop clear the vendor specific fields that follow
the LBA format table and return an inconsistent identify structure to
the host, e.g. a format count that does not match the table.

Reject such an identify data structure and return an internal error
instead of rewriting unrelated fields.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport.
A passthru subsystem is backed by a file-backed loop namespace, so the
host driver and the target run in the same guest.  A TEST-ONLY hook
makes the backing Identify Namespace report nlbaf = 0xff; only the
nvmet fix differs between the two runs.

Sending Identify Namespace (CNS = 0) to the passthru controller, the
unpatched loop runs (nlbaf + 1) = 256 times against the 64-entry LBA
format table and clears the 768 vendor bytes right after it:

  unpatched                            patched
  identify accepted (ret = 0)          identify rejected (ret = 6,
  nlbaf = 0xff                        NVME_SC_INTERNAL)
  vs[0..767] cleared to 0              no data returned
  vs[768] still 0xaa

 drivers/nvme/target/passthru.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 6b67880c7bb2..30c06bf0e5f1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -195,6 +195,11 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	if (status)
 		goto out_free;
 
+	if (id->nlbaf >= ARRAY_SIZE(id->lbaf)) {
+		status = NVME_SC_INTERNAL;
+		goto out_free;
+	}
+
 	for (i = 0; i < (id->nlbaf + 1); i++)
 		if (id->lbaf[i].ms)
 			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));
-- 
2.43.0
