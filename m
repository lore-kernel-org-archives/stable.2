Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610830;
	b=KWMwdvOk1Lb3WV/nCezbXoDUNOPHhKYJR2V52KyZdcOzbno8aIY21z6uN80O/TYjINRS
	 pOvySn/OtcNv+makz1BJHKWvTVTcqV/7kP+DjYxvGb0RCAQh//zqpCZ3s9954npQ7Gkyf
	 nNuqARPfRst2G2Lpfyvzqo+4tHeq27WBuluOyfcgfMeD1QWK0W5HNOAfh2DPcu2A/Z9dZ
	 8gtMeVsd2EkdH+wv4qRsyvSgKPhIKSBAUQST2FqTMIz5EUYpghvd3Niwxwpa72Xf48l2j
	 NDLynCwzCbpUhDdGfQgSsO/e/suLtAdkc16OFtAIxQe/vcuNdlZPEDpVLRQFmAAxwHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
	b=cwzOeWokTJ3I82HkGET7rEFs1f9AVvokAyg4C2evm1L8r1qdnADUyUD4sMN784Fhqeod
	 RmAlUXtgPlEJhNChDfb2/AGaja4MODKSxsUUZce6bj02MxXjZmkgvz8xbo3SofW67UBPm
	 f89ndMD6p3HmssvDUwm3Uftotc31jrTO7nDNqNKBC1tgJpJmL9fTlDLmDm+3HAfkmrEfE
	 J1ZiWWwg/XBKZK6xS4oNGokDZa0QotUCFDJIQsMZUYVDsB1u1XFQlIWFTF836Coy6v3w6
	 izqrfSdiuiMzeR+/bpv4lIqfKlSJ+4vN+xnxK/SrWAeP5DKRvmhsYiiSEM7yUWBd/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2ZwaqCM;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940C606A329
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8940C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2ZwaqCM
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb5f49a61bso2339815e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610828; x=1795215628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
        b=t2ZwaqCMllU+1+/NOjW17LZT/w3ub7sKoiDH41UTjJFhAptpinU7vdAZCEuF3R/3LE
         CrfSM5a9jBXQ8coju9TypFqqXzp0TpCUrcZ85WexHznw2X023GyEsLKvqfr9/1rteP8U
         LVyHanl6WyXSPt3EmKvZFk+HGddI8OKErjP4/ogYMl2xYvXJ/oVP2ie1pbA3CgIZznr2
         p0RE/7YOa+U+2RQbTV4f5d2NfZrGJA/OQw8DkYP6TW8cnKGlBDTJYs++7jEFWgIrqTtr
         b7woz8dDhzdFnsGEX0d7sJHkBd2p1cKmp9DGzaAO5i7HW4/B97QWo0P/VcVC0c5pIQXx
         mhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610828; x=1795215628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
        b=l4Jtz/BLKlA6o11kzdhfiF5JeOK43RXTvMOqNkEmkEX8DRxyp0V09EL6srq6ztabtr
         50ze375n+hdoQr9914W/o6S7CfXnN0EWOI2HxOAbfApRWSbVDkNQlJOMvRz4gRVuZbpY
         cLcQPhzPMnUEe8FzNKlyAQL/zo7GjrFVDg+gWovTJgSWfgUIlmb8C3ursuo/CtB/AZLM
         sc0TuyTtnVcxZ60o9vX7J/NUCgzc3Per9uicLC9x9Qh9u/wGKtB5ddv3u9rR5yU4ipG5
         sONuwjkX40YunCXcM+CbmghroVl5iZi8+btpsL65LoG02WABAEMNcIm9PqEWRBwGGMo6
         Svng==
X-Forwarded-Encrypted: i=1; AL+hErH7krX/SQnD6eE6+M3haBsBECWX9sOdgsvjGgkqGq00bCPnCWbgcsPtM9meGXbDer60HI7h35I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lSNM3W6eizJhXSQJ5IkoWMMxC1+NRnVZGovLc+7c3hEeZkT4F
	wGjh6xvBy3RLRAymYkxEzXl0fOZWAWjpTtUzF7cwfPFd04xWbGWsktD1
X-Gm-Gg: AYBFou0FKG2ZXZj1sLLolAivRiSFongr6kE0E8ml+Bq+nzH0MbV237+IuqxI1haA6WE
	WBeM5LVDKXrLQIJ8YvGk/Jh5fANwJ6H4GKCNUkNuCC6ZxrStqPhgsWZGIjfiueSsKa+JVC+h7El
	fd+tMYln6PcOAtc5TZ6rOi8H0boAWP8Rze26zMgo4rj/Pbl1bjv6WYiHCzq5pmGKHYK0xUEOx1i
	4nAQkQDzir1Af7g9pLDiGvtRi47EAPD/+DHvjn/+BleWHX79gWTLT9tUIWWlGbsuxTfN2TciFnG
	u/6sBQITXxEctcKrsjiDWqo9Us72Z6iejbzEXWveA1mha0zsr+2Zk5hUDPybvDqCaOyWZKi2JnR
	QQmcOJJaahMnMtV1jgE+xPsMbW2dkQpapilxrK9t00I3yPjv4GtMrAw+gsybld+DRbVepLWdi29
	b9byUGhK9qffMm+ZZbIqtoOz4QVxtk7JtXiSEEKLQQgXUDZq78U2WA648UJMQssl7CSrQ+RO1hu
	6nKSWtFMSqqdYgUgKpC9HXW9FNtd/VK86sLzQ15HWg1jSwexCRkPBmgU3UaEMNZHS0ck2gOxSOb
	Xjaur3oip6xt+BTpWUAt+2DyWN/2gm3sohK954LDc/0B/AEF8Bsy
X-Received: by 2002:a05:600c:628c:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb55a6b67fmr89886695e9.14.1794610827678;
        Fri, 13 Nov 2026 15:00:27 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm8617592f8f.11.2026.11.13.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:00:26 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] spi: atmel: keep DMA chunks to whole 16 bit words
Date: Sat, 14 Nov 2026 00:00:14 +0100
Message-ID: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The PDC path cuts a long transfer into chunks of max_dma_len bytes, that
is SPI_MAX_DMA_XFER: 65535, an odd size. With more than 8 bits per word,
a chunk takes 65535 bytes off the remaining length, but programs the PDC
counters with 65535 / 2 = 32767 words, that is 65534 bytes. One byte is
lost at each chunk, and the next chunk starts in the middle of a word.

The SPI core also cuts the DMA scatterlists into segments of max_dma_len
bytes, so a segment can end in the middle of a word too.

The chunks were PAGE_SIZE, an even size, before SPI_MAX_DMA_XFER. Make
it 65534: it is even, and still within the limits of the PDC and of the
DMA controller.

Fixes: 7910d9af000a ("spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - New patch: make SPI_MAX_DMA_XFER even, so that the transfers and
    DMA chunks cut at that size keep whole 16 bit words [Mark Brown]

 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621a..c762e28407d8 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -288,7 +288,7 @@ struct atmel_spi_device {
 	u32			csr;
 };
 
-#define SPI_MAX_DMA_XFER	65535 /* true for both PDC and DMA */
+#define SPI_MAX_DMA_XFER	65534 /* even, within the PDC and DMA limits */
 #define INVALID_DMA_ADDRESS	0xffffffff
 
 /*
-- 
2.53.0

