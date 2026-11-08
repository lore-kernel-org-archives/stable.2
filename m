Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104239;
	b=kXdg+WkTDv1bMCV52BtXIwLqIxMDf2lQdasiRUCoNmK287mrRVlvzb5N1dGRzvuFmNhS
	 P8LkLX9r7qHcubxhUFK6jq41n/w4xeNRnJeGTZqgUUsZQKc0e6EPp8UHdNag3ytY5q5he
	 P2lLUNqRqjbQyeQOWtjzXiEyL2NJTK4YkzIFA7l2aRCuZvKJMReXc/jZg2XhOJKOHffkK
	 AtH2bcrEEb0XivvuFFT6j/j0NAnXdzuz2AE7iLuA3/IgQ1Zjd2kx53J2xuY4xGmr3ulVz
	 QyHuIiLB3Yso0iGBf7SgEHpxp6LVJDr6QonPZABUS9tJ2S9e6WsVcgMrpz/qyR3uNwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
	b=dc4sftRpjcuYyt828AgPjVvI3uV50aUa1zjOEN9q8rAeiLs9QBZCmMWiCr+GHklPtgRo
	 95rbPsJJOVyZ0hOPwxTRNXDcOsB9NBDGXgJrGrKh8Hju/Aqg+8tjgP+rHyEN7Qi25pZ14
	 pQKs8XdnK754lJzPUJ7JkIYzJYZ8fk5e9vB1HB7mjmqcEMNiCdCS+1UrXYdwhGNQmA6vd
	 rPIFNbiS59fB43EioKWe3/CO6xFwNKnBEu3nC+jGluAJlbnvCD8ewz8YuBlIzOerYDVI7
	 wUOPsB/xS9qfZ/jgShGWgULLox/KpDIZFdMxTcklXEHGFrzphFcT4vwfdylJX718/LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=CFq4yys0;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E1606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=CFq4yys0
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36dbde64409so224899eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 18:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794104238; x=1794709038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
        b=CFq4yys04rojLDgPge0o8rjiFjXQOFgPRQ9pr6pFRrWsX6+FfW8kA8IIblSwPQkbqg
         +v8M4ot9j2w8oZLNHle8dL26KbRz1LoeEUq+JOp9WGmR8f14WFW2WvEfpPUp7jA6hpx3
         ZW5UyA9c0SifGDFW7WR3wLUO/otGa3MFV7QjAZLnYSRgErOGMUaOqcgfMfLUH4l25rdi
         DAuKoQZvCgOqioC+DGAav8ce0xgNoUTMjwkOotd82B5uhigVFhCxykRglPU6BGfGzTI7
         mWabeiUDDysy49OJv0HAOf0704lxLdEz2Fi8o+agHTkDAART2J+Rzj5wUMEG4qTvXd4q
         Ixjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104238; x=1794709038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
        b=IKmmmJwa+h/TBQ33AkOewIiOg63EYqHkQNMz4Vtbn2zi0ncuOcXxJrHDg/7rfA+JOv
         mDMNmXh9WKHkfR28tQXQzPrWg/9aNvriyr85+FCnMaCC66bu9y5AQLUvAI+jV7lXWmbR
         16IoMguoIEN0qNjC3LGdNks8nLvZ/IBdcciWhwOJiANKMM06y2pMsg5Qz15SukpQbTmo
         ieOiAK2zhf7MvwqHfpUQCpUmsC9a9GtRBIBLXh9dk0pxkYBUBSUmjlOStqU1XFw7ngge
         cHl4TZn3YMshWD+qFuqp5TcQkACK26/v57idPZMAGphCDenIvQDbnOK6Xw6cqGdMQ4KK
         eL0Q==
X-Gm-Message-State: APuU4Z91bfMD4TmRehIB3vo6Z0y1bZwdzwn0vcEmVObrYG3ykA9mQ6Pd
	bfgHbzON+T08V/EbX833K8F4PGBEh3j1aWDKj4QvV6pCzN0UBIp+dQxAnnslI1AUuA==
X-Gm-Gg: AYBFou2rZ/T3fgqXnL0WsADY352IGtpN5txkZaF0Z9IssDBGnPNLLKC4gwTI6taXKNU
	QRKMrzybcqdsMZFwSoPvadZD+nqTJ9Lif6z2/YlP7XkqD2WidaS4LIrwg6V+Sqx5PoxuU4bJMUs
	HwrGDil9RmH88AYYts3GtvQB5Z/4xYAFj9YnuEpBMBrOe6jSgFjt38Sdn07AJo0vFp0iHbCzD1B
	tipvt9gE54Qc5x+xoKOtVKOvQfoRLHjEerXpG1xkZknaXtqqag0XBs+yP8JpWjRpyGgk3iwEqt0
	CxWu7yyGEqJd8uTn7ca22Yq8pnJ7zUhXmCpGjyoZZxl2L9woSzHvGMuMYCH9OC7V0+ZFhxkZIgS
	i8lLqBJou6jsQLF9irZZib22tJYUI0yKqr0+WDAL7g5oOhxY1MtGoePrHeS8V4emGmxZYN9OQKJ
	baB+fXilSvIv+Kg6fwJhQfyK6zcpBv29rhdVoU9nGhjAx7SC8EdElzoIGq3XdSX1hPm1sj+KQ6c
	ZEWjVwgMw/BcsfaUU+qzn5dPA6yBXQTKghUiqUxECUOvnGV5G4Lvdh1SAauFSnv3pgwjC0O60d7
	Wq9a9INaBb9PdsKgi7Ky635D6xT9jXUrfj6FSuuNUAXjkOIZRiIN/iddu24ntFOuj89Brtkx7ln
	5ETh+L3veUg==
X-Received: by 2002:a05:7301:1510:b0:36d:5102:9974 with SMTP id 5a478bee46e88-372541c746fmr1130438eec.2.1794104237633;
        Sat, 07 Nov 2026 18:17:17 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561852csm1590519eec.9.2026.11.07.18.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:17:17 -0800 (PST)
From: Matthew Parker <mparker@arista.com>
To: mparker@arista.com
Cc: stable@vger.kernel.org,
	Adam Calabrigo <adamc@arista.com>
Subject: [PATCH] mtd: spi-nor: gigadevice: Add support for GigaDevice GD25B512
Date: Sun,  8 Nov 2026 02:17:14 +0000
Message-ID: <20261108021714.897991-1-mparker@arista.com>
X-Mailer: git-send-email 2.51.0
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

Add support for the GigaDevice GD25B512 512Mbit (64 MiB) SPI NOR flash.

The chip exposes valid JESD216B SFDP tables including 4-byte address
instruction tables, from which geometry and opcodes are discovered.
Stateless 4-byte opcodes and status register locking are enabled. Read,
write, and erase functionality across the full memory array have been
tested on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 6a2e6ebda148..de96cefde516 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -64,6 +64,10 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1a),
+		.flags = SPI_NOR_HAS_LOCK,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x16),
 		.name = "gd25lq32",
-- 
2.51.0

