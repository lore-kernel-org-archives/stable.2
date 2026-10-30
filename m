Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379289;
	b=f0tVkFREDfHiQXxAEOcw5Yf3f1Sw0OH7NJVThBlRN3NNBKQLePPK64PBF/n9An1YRdMt
	 MEYv/q/jS/6OkOozSTXBvpnlKHQlTbCnjG5UfUsHt8NVTlyEplK/oipqT+AwcBuTxAlf9
	 wdxEpWmtKmb8A70iYB+T6p2eTIFFHFWbeGuiBqbQVVNvqyQ/dvL7auiC2KKGcqdZ8O9im
	 +Bban8u89JLgPDOpFEpYDC3I5rjhHF8thyqr0Qrs5QZDcUl0w84VIZWSBf1cO2LqRcCTp
	 q2D+9KXJjJ7EfiuF7XYGCt2J6qt6VBJMjZt7U+P1YhkYrJxhBpf8oO4+JwTrR7Rt1fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379289;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=5WYmI41jGKmU+EPTuiD4Bw81iGR/uGmO2ZB/q9TxT5c=;
	b=zLI4llHrlDSquC1dJ8UC0jBuatNxtsF1X+kxrM3q0n/vynNU2n8Mr28oSJ7wsVak7SsW
	 LFZyhP9LpbEdc90i8525mzRrQ59IJNDxBE07ymI7GqAydqINzbiVHskObyo6TfEYvKlpk
	 Zd5UV3phwWBk6qGDIvRQ+IgUI51rhY/aa8UZt9P1zFPpvdB42jdWxarnoqU+6sUgmmVtp
	 kNEaBuJSCpd6nkouKTPRHJYEYcJpYJKaggpYI8tpo7GSUjLk8g1Akd7CcoVoWfnIoQvZq
	 kxGrFicdAPkn2kMdQmkJZpPCKwghFsSCeE1nQM4c6u86jyb7jxdraJw40tUHUg6skRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=crJIttWt;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C3606A31F;
	Fri, 30 Oct 2026 16:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54C3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=crJIttWt
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f123;
	Sat, 31 Oct 2026 00:54:44 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Andy Walls <awalls@md.metrocast.net>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] media: cx18: Fix potential double free on ALSA initialization failure
Date: Sat, 31 Oct 2026 00:54:40 +0800
Message-ID: <4d2f79a4ef95eaaf9d4035a864153310254c5781.1793377439.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793377439.media.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377439.media.git.liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa18dbc369b03a1kunm4d3d9b7e52a3c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxpLVkMZHU0aTR0aTkpLH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=crJIttWt8Py+5azu9dF7kROzT+3/uQBNIIHtsk82+CV/+KAsEA2xM6PItdxFPuxlVHyq906J5AGMHFLxEt8g0Ev8FIZ0+GfosVVLyEJXd8k4TsnQdYNLfSHCJ0DrVLrYevKMjZdnRe0+4Ij2KUNX5qthHWV0Fq8YWLgl0evwXLk=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=5WYmI41jGKmU+EPTuiD4Bw81iGR/uGmO2ZB/q9TxT5c=;
	h=date:mime-version:subject:message-id:from;

After snd_cx18_card_create() succeeds, the card's private_free callback
owns cxsc. snd_card_free() already invokes that callback on subsequent
initialization failures, so the explicit kfree() frees cxsc twice.

Remove the redundant free.

This issue was found by our static analysis tool under development.

Fixes: 2c87d9db46d1 ("[media] drivers/media/video: fix memory leak of snd_cx18_init()")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 allmodconfig.
No runtime or fault-injection testing was performed.

 drivers/media/pci/cx18/cx18-alsa-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-alsa-main.c b/drivers/media/pci/cx18/cx18-alsa-main.c
index b77f5375f3ff..7fe538621d4e 100644
--- a/drivers/media/pci/cx18/cx18-alsa-main.c
+++ b/drivers/media/pci/cx18/cx18-alsa-main.c
@@ -171,7 +171,6 @@ static int snd_cx18_init(struct v4l2_device *v4l2_dev)
 err_exit_free:
 	if (sc != NULL)
 		snd_card_free(sc);
-	kfree(cxsc);
 err_exit:
 	return ret;
 }
