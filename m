Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555175;
	b=nxvGj1wVHMsYs8w1Cc61Ou88hjvGh1LruTTuMf8ftJKQwocTMKAXSufNhdF/As3eGfgU
	 KkJ/N2yeR/a7DopccNsRtomxYsZrQYjUB4ZsL7KGPd4e8vYP9IeYuXB+48pcZf8RJi8sN
	 Qi8ojKYqcCHX8mmY6nzpWl/X0mCPnPiE+U8GSnZiyUD2IysOaIvWWqdr2zO+P9JjkQUmg
	 ubH3B2VO1GTcl9OLAbXsFvgPJggjREZPu43XnPRbArDjQb0q7TT46QF/457qBoyuukpai
	 oxKhq89UJj/ukBP+gFqgXOLEANsH6xjZI7B4ix9j9tvKzvI1jfuBCvxMdgYu2fj9wvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
	b=nZ2OGOhID/hpW0Btp8oQVOrBRD/7SHYFwEgY9CshnSWC8xGaQzxszpA4azQFKXoLUClI
	 4dTwai5xjSu6OyTLbiwqXP2DjbrdZrJ5lQe7HZRBday2zwRYxl6Pi09i/LlT6jQl8uOnZ
	 eMkZ+9ABkgTAoMkMAlVzNTwgLKpu5YV6kisXlwudtpilteKPLEBgXs6dR/aNuyo3VQRmh
	 m+e451uOXK/KObaqS1R0cFlYWAou+lO6QDXBIauV5l4MP1mQKLP+IpjepK1X6J7YZRR1D
	 knbKDZPeSLsC42R6phaMWN6F6HvoMBFKVMmprchqmgGOIFn2tNaX4YC6jpZ+njZ2mSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hwj7pfUC;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3937606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3937606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hwj7pfUC
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4922523d1afso254357f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555173; x=1795159973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
        b=Hwj7pfUC1dvZhZwvhnfPkIfuostmed7pJJ3l3pdCgBHdzbxhSeTqW70YMzRljyUb9b
         fzoPJnqs+IrGvnb8Ba/sWT2eWDlWqDSPhv9ftqIpii+h7z9CLGRL+wibdC/ijP4/+djG
         jNiTk0s/LpOi7oPteseT+6wF0t9tk12nQ7N14jKypKAge1tabzgNnblOiKMJgG12wAyj
         MnHJ5EBajX80JKPusnBvGB5okYbM9yM2t5SMcml0GQhWTXZWgFepbTciKxDTtuLMzo/V
         n5JYdD0Jtkeh3YYXSvJ1eWeO8vbJLBV0QU5e4CxLHX+o8vFK7HIEojCA9QyLAd6/AqG6
         VCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555173; x=1795159973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
        b=1MBErxjEyN8P6RDDP/mnwJVMrsY6kJNoCISDh6QzvpUDVftsUB9Mgm/bylPYgc+zoS
         KucBbs8k1czqel18QAJAqapmsXTwlm34BgYddpFGLVqMg64fe3koYjuEbsHJiRwEj7tX
         FISc20EdkvjuOnKV3zzafDKaSZBvlgtEVmVUkuVZQ8lmTnkXi3+E66wslf4Uep7CRHHU
         nmyAzNtExE+nKyySVf5CuvVv+vdd0caCo6HB5jnOc9vt6+nW2IT5eQ6TunH4G2DLfFN9
         P7KpjS2JKcfVfHiX0P+VhchplFRJKT6E3U9ZP5jNlZOGr329NGCOhmCfUke/Cb07Kf6k
         J/JA==
X-Forwarded-Encrypted: i=1; AL+hErHYJspJrT3uJOSe8mHTv9CQZzYPk6C0BWUSwuNvBNCbNBSzEFB3rPBd73+NR7z/GTDpi44xi58=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k+49GhqoCYQBYoTFjDt9P5ACwnTrihthxeiohuz2VSH9qo8eM
	JFGRDbERB63c9wmSTvIdGzTIC46dKoiUWy2c5lTptmqhDkKaZ/aWUIew
X-Gm-Gg: AYBFou3Ut7iXVwIGkoO5qcBfvHLygBHbil1kjzIMaNLjimYsGhLTFpx1b1Q7/0sM5/c
	xcCuRSZ2uWW10ygWjGBizHUyDAvuXjF4m3Kzo3mvm9bs7+kYzvlK2t5Abbx9jVCKjJhP4wY1q/e
	VBpbR6p8SagmfY3b+tCwAB1N82oWMSRv2Vu5dFrhREbBIBtoywhi2d78dQ383hs9KAaQFfNwKkW
	cyaF6Uyms0lJcp7IRXAt5ogphmYL4iB25FH+hueZ2/uLZ7faBi29QkpIn8NJbiIogVBowKYhdf+
	+vuAhwM+PegD0bCJ5Nz0i5e25ott32JAOTjwmTtvtX0vUfl0VYGTBEx3C6rPiDelABJIlnKriPa
	c+7Nc2tTAiOnlqH+taxYrnENTx89K6ZHZB/CD/zcMjyUKxPw8pPF4ZYKk7rrQCKiPMJE7HhtCdE
	lD5qkabb4WwKS7Y15qkyK0KLRURL+QAxv6VDarTR3n6O+R3dpqNvzFo15M5r6LdgHLkoyZbnGPT
	mtEVglT+URLKDjjxspod9HB+nVhKNugADiFuq5rgrqyBezftJevv7/Z+kpdwB3FmBLNT4lWqBlh
	etXpYBXdQI7w/gg1FqKdoYbc6Axm35C7M54=
X-Received: by 2002:a05:6000:29d3:b0:48e:7e1f:8cee with SMTP id ffacd0b85a97d-49c73259d1fmr2428976f8f.12.1794555173288;
        Thu, 12 Nov 2026 23:32:53 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:52 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] i2c: imx: do not carry the interrupt status over to the next transfer
Date: Fri, 13 Nov 2026 08:32:49 +0100
Message-ID: <20261113073250.1037215-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: <20261113073250.1037215-1-mehmet.fide@gmail.com>
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
index ccf08cd63151..1987a0fd8132 100644
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

