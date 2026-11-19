Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095752;
	b=OE1ABzn30pzxCf7d1l+HdbtATL/DCaVFqqofdi0K+d8oWNmuUAD7pAxrvkk9EjmqWzTG
	 3/EKy4Sw10TObDenjILIu9w3IYu7hV/KPDvjabkE0dT4w8aaKnmofgVyyYJMvZzEnf5Sx
	 hN8NEUrisvyapWZN9PeGam+hi+4Q9VmoAOHR62F5VY6cyok5+RB4Cgl0BQwPeqtAcx4uI
	 mrsId2rVmsam++buwGQB2sV8GP+qTE4oHTrWoskXywNK8J8i4S7eG4Kqufj19blAwkThD
	 WlcNuG6oVbDWu0RkHuVryhnARmMzriwvfItIYnCIC3G7fEZsTKOYcK6JtjYIIeKRFZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
	b=IoLz/DTvPE7ZiAljR+OEJnb2ll4mpmGPUhru5fKa14VC/3IMFGBiCMZCqPDtIl5Pt6oh
	 zysQX/MsqIOlRtVmYELYqaosD9dW6903pLfla8wJXSB9WL4lL+1x83/NomNrHVTiEsfWx
	 aYgU45KOGYljadSoXipfFLHH3AKvlaBX4dIkzShjPQzl9dBzURi5HpuAK93ds7V1xhpNy
	 vTBM4DRDekkEqzzzDBHPF6k5ntowYlc+vixr1rMCMk0sujGn/mnqz5qWGaZqnanAfBiAD
	 x7JEsU2jW+PbiaxSv2ejiF/uIL9agAslvEaE1xbcGHpoxQyfRqlW5WOtxFzNP1nBvww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRD6SJD4;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AF60A2615
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 443AF60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRD6SJD4
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1331828f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095749; x=1795700549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
        b=HRD6SJD49lvTZD9jHqV0rBo+BagdKvdzhEasCkmjov7nEjjErn6+SmaWiJ5i2F4bzy
         pdPNCYDgoKy1NhQ9BrmaSve1wFG24v6YFm5GZxABU2D3rsdxPzH86hRpu1w1+J2j6k1g
         7aoJ0Y/3Ij2XUOozXzRIjjJMUI0USHNrcF+ehKHFZQBB95NN4IKX0Rsk8C5IBwxxpsJn
         Vu9hT8C/J4w4RYkfGo1bYt29EiV7VebufUE5zPnfVRmYS9vb89uzcDWf1TwpFJmmdc9s
         rkkBX7dWgM6qyVJCX8ZarQYPo4mKHckymSzubGXT+hmU6VA7oJGY6fjtP7SKX7wRO63D
         93gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095749; x=1795700549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
        b=S2O1KAux9tR+tHSTvySZzMPFBdOc3J4C8L+HHYPxhT38xb3JyDyLzvc9qy7iB8QnaZ
         xA91/HMtWOsEOhVp/bcZG82+pz44ehGT0tY+D4Im0bT3C+067OTrzWFovk3PPOKWLStp
         YBLFRaGgW4L/HYL5SwUlo9EqwWPE4pF9A4RFT2HobgsM5h4/dhnSK/BhPYQrmRGQuM2W
         nUzwu0YQYWKp0Zntk5ucxXyqJI4V7o2GdpvA3KgvRkwIQSDnmXRaaxXiQmeERYiH6fpb
         dNAswg6eHpdqRt20BGOaIh1Rnskp3xEgh53IyU0rfNnt16d8Thj+Y7M4u4e3FQMPavao
         bKHg==
X-Forwarded-Encrypted: i=1; AL+hErFabTqHbMKoyDH8Z1rwh70Yoe13+bLKgQx1g1j1TFKG2b/V2f4LjQuluZZ9zorEk4W+oBKUg6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rm+ZFqhF2GZcRkglGAo09EhTwdWeVtLQN54L4xGrdK5q9HcTD
	xgrUdgxJB+n7IY4tw/RBVo2XmkiaSlfNbQNEM4JW7SHjrU+3NszPILW6
X-Gm-Gg: AZFdTZczEvEMp7UP1gA68we7dl1Rp2WjVpXHA6bzkQWa359mV9Z2YOGu8q3CcAx9SeB
	rIjerohcRw4cUntntrouEQu2fvmPJIKtGPfPvTZdYuQomF1lo8B0eulFG7ivYqdbOt4rM3fbmq2
	1uU+kW8da+P5FcXv0f/r5EbhaakzGeHeTr7qBdRDOARPtvk0JzBSLwdXuS98f9hPyBpW/RfbwJS
	2XR2bzjlaKi6EPWMhih3XHecsIo0Qjzm/LVb00SjpyPVYmvPzADJu9G/NmP4MtT2F9Ivh4CAvOE
	jjxRBvZ6Ow/Eqpx9hFXzlwgNyvll5ixN9pInzoUsFCfXKbNgzdube+qqYxnWL5Upz8wpc/NCbRs
	2YVqd7jt/Nj+MsQhO99b2CznShldWrb/TA3vdcbBIMQX+DeC52fWdefNNzMsTuyVcJzUan5Lzim
	D8nePRc0onlBRCl2CgpxYSyv6VpSFV5s6IOhX0Rn2G6M5yZr8Mrf4ckFKHnbKFcI+II5HhxVajt
	G1wG46JZO5Tm/g1/kNmIzaSO3031ls1Dj2ETkNsaFv6t3SZS6t0T9/M1r7R2vd0OfD6vexM1A54
	b3hek0KIJJIL5AzqA5sR1BbsEcmkyYhG+DI=
X-Received: by 2002:a05:6000:4815:b0:4a6:bc53:247f with SMTP id ffacd0b85a97d-4a6bc6269c3mr11252717f8f.48.1795095748613;
        Thu, 19 Nov 2026 05:42:28 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9437971f8f.42.2026.11.19.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:28 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2 1/3] i2c: imx: do not carry the interrupt status over to the next transfer
Date: Thu, 19 Nov 2026 14:42:23 +0100
Message-ID: <20261119134225.265242-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119134225.265242-1-mehmet.fide@gmail.com>
References: <20261119134225.265242-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

In DMA mode the interrupt handler stores I2SR in i2c_imx->i2csr and only
i2c_imx_trx_complete() clears it. A DMA transfer that fails returns
without doing so, for example a DMA write whose address is not
acknowledged.

The stale status stays until the next DMA read. There
i2c_imx_prepare_read() calls i2c_imx_trx_complete(), which finds IIF set
and returns before the address byte has been sent, so the read returns
0xff for every byte without an error:

  i2ctransfer -a -y 0 w20@0x03 0x00-     # unused address, -ETIMEDOUT
  i2ctransfer -y 0 w1@0x54 0x00 r32      # 32 times 0xff
  i2ctransfer -y 0 w1@0x54 0x00 r32      # correct data

Clear the status when a transfer starts.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 89f2b764bbc4..f20727ffb5ce 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1657,6 +1657,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	if (result)
 		return result;
 
+	i2c_imx->i2csr = 0;
+
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
 	if (result) {
-- 
2.56.0

