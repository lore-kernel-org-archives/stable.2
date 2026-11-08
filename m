Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158042;
	b=Y5kgV/BGAj47iiM2CXV0AzLepPPe38KMED9IgXK0EL4+/jQVYG+c7ShFw8oYMbDdQZXS
	 MMO0ePkv8Mjkmg7n19amRv6xkuT32fD5INMWuQC4m/mMXdW7QjCRm81DPkVJmvmP8nFIt
	 XDGHUfyVUBI+vgZ1++d5mpmckEaNRHLPnJz1usouSVFo6zhp5aiXB0UbHoY7aCcJBRjQg
	 CknPTn0tdraHFty1KYtRc5E0tEUNlyDHmjFoDp4vHovMGd8kOoLuwX4agHJ0PaPG7vFC/
	 PbG+bck+B0smNe5wP8r7R5Hwpsf1p/cyNuz9iZ4Gyg9k2bhwb2fm1vn1IYzapX2tIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7A3DPF2MV5yooQhC2ets6IaNx1JEFDOIZBgDBHvC/CA=;
	b=Ldzemj8/Rdhzup+DJfsQ9PbnyVjP94XTxPMjFSQP55yyfHNlk1QwL7dZ5ED3r0zUh+lA
	 sJl2mjpN7DETpkUXSmQR14cJu5mpdPOcfrkBXbLSrL4TRaRbWV4wF2VU62Dr/E99HELv0
	 233EUHWw7hfQQ+7vQEiy8gUAazWzEijk0OBudLH1Xbyai+eUWUurCgEUmM4qyp9E+l77I
	 gAAqMyorF9SkkMEeaJFC3IapY4Jn+d0Ey2lcKBjHRlV5ryGSLaSvuQGHhVdJt8R1kGrtb
	 bllnv4W93rTGu9OyUUfuVSvRUqVsV1pFDf0zjkIXPK+uhjm8LsfbQun7ATNjAGJPA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ina0o5wt;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3090606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3090606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ina0o5wt
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36e06480786so130528eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158041; x=1794762841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7A3DPF2MV5yooQhC2ets6IaNx1JEFDOIZBgDBHvC/CA=;
        b=ina0o5wtUHRVIk6qynyDWoufS8G/6ga/9SCmASz+euoyjuOH9eFx1yzf/prw4PZsHA
         bHjz7cuBvhwOpF5p9T5f7b4oFdE9PerI+tBxPMw8QJEbfo6w1dgEarpz6l51HRXEahrn
         Y7bZwf4s7tpkux3Xh/nI15oDhkU8HEPSFVYGY8lJ/xzycYrhMC5NtF2T7EI3xqPWn7dQ
         GDFPv50NylPVFTaUWDnKR0tGRHlgOZ9YLSUOBVoo8axF8baWQQ1drF/vgqVh1HeR2B/N
         2yUr6NaiFdS4EOZhl1nIwh6Wbfl1+4lKPeLqr7Y8Se+BdfC9rE5fBNK4x1CD4OjnNlDp
         pCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158041; x=1794762841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7A3DPF2MV5yooQhC2ets6IaNx1JEFDOIZBgDBHvC/CA=;
        b=xIdA2EJQdHNKu1FNhDw9viZlmujHQJNzcnJkjJCuJSdAJzJcoGg/VSr4B0n6QWhjcO
         SgmrrsGWytNaY/k+m3QstPXwkbjDivK7jXAZaHKAbf8gBGL88+x/ZfeT23e/av6y86AZ
         tNPnTukh42WTCxIrcef19tyBKyvCr5vAN+xtIp35cdqh9f3ug3V3McqLr3KVHIXnbZZ0
         Mi00i/RLmN10+zCwUEzw78kr2Xx0iGL/qCEhq/Qjv5zKtinSxv5tf6CM1cvFdNak45na
         +o1rbH84eqh0qr+ogPOLPPQXOIvHkQw+BkTk3jA33eFQgognknyxAva0ylqGDLEcd9f3
         1ktw==
X-Gm-Message-State: APuU4Z/WJC9bX13x+cYWC/Q7w8P9eov65mkIygp9xtPo+lrMs1aOvpD/
	lTHz02kcdYk2FuuAMEAA0wMDNNiOHuKO3235Ssty3NakosQ9yGK/fnicFRG3a9gsCr5XNQ==
X-Gm-Gg: AYBFou1nRK4dkm9FEtJ2gteSi+jMgRB9y+67HsjDQpq1Js/BWeSR7jfkBpE0yp50lTw
	Ms9VPdiOARvSzZisCNvVEnOMy3sNGOs6ZU84T++4lDGRRfgbAN7ckv2iFlW6VpRM79a2XLNZLjY
	SOjcmNBW6yZxXXuzpOmF/ZF/eVAIiWQi0uoQAdB75VBjW00acgLKE9LUgrg7N4PWTyABT/z9TKc
	ymSsXUJxGSOQLvDLZyL8xao0bfuSAf/cmDYeGX1HhlZZf/0inaH9KxyUUp8rMxihYIleZwgoSIl
	gAv8wiON+C6XLtK9OTW9ajgYwMeeUlpJh4mGc4iIENDB7AA6dV7osPp5RzSkgQzwdHUpTUnRd7T
	+AGzqY54Ojw7Xg6dFV61N44yU9xDTXh8/DyqFZDjkshqOyHF6h9Koc4p6vRT5SISxKrgDc6ydYV
	SZp9XLrR+Gtir+0rfE5AFYMF0rudb8pdI/Ckls+1eVhlyZpvrraJtoXhDiosb9UrXFEoaY/YxPR
	s/XtByGOcbT3gXXyVs3R1jTGeHzdKbkpqBF0SrmQL8e2tfXtjjzMrtaKJP8VhZEtw2aH8uHoVKC
	l1ns3kyx0XgT3s3pye/6Ob4hOw4OemsA2blKPQQ/rVg1669MHFH6dsG2ZEQRqhJUy7T0as0=
X-Received: by 2002:a05:7301:da8b:b0:36e:a321:5353 with SMTP id 5a478bee46e88-372543bbbf7mr4238178eec.2.1794158040615;
        Sun, 08 Nov 2026 09:14:00 -0800 (PST)
Received: from AERO17.taila7786d.ts.net ([45.95.212.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm9972395eec.19.2026.11.08.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:14:00 -0800 (PST)
From: Pufan Jin <cyan2254650260@gmail.com>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 5.10.y] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
Date: Mon,  9 Nov 2026 01:13:56 +0800
Message-ID: <20261108171356.66438-1-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107062802-failed-5.10-dc5ca34f5e8d@kernel.org>
References: <20261107062802-failed-5.10-dc5ca34f5e8d@kernel.org>
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

[ Upstream commit dc5ca34f5e8dc10c566ef39aa3b1a201a17ca734 ]

In zynq_qspi_exec_mem_op(), when transmitting address bytes, the driver
iterates over op->addr.nbytes and populates xqspi->txbuf[i]. However,
xqspi->txbuf is never re-assigned before populating the address, meaning
it still points to (u8 *)&op->cmd.opcode from the command phase.

This causes two severe issues:
1. Memory corruption: Writing into xqspi->txbuf writes past the opcode
   buffer on the stack (which was passed as const struct spi_mem_op *).
   If opcode is zero, xqspi->txbuf is uninitialized.
2. In zynq_qspi_supports_op(), operations with op->addr.nbytes > 3 are
   rejected. When paired with SPI NOR flashes larger than 16MB (such as
   Winbond W25Q256), spi_nor_spimem_check_read_pp_op() tests 4-byte address
   support, which fails and causes spi_nor_select_read() to drop all read
   capabilities, failing probe with -EINVAL (-22).

The Zynq-7000 QSPI controller hardware in manual I/O mode natively supports
transmitting 1 to 4 address bytes via its TXD FIFO registers
(ZYNQ_QSPI_TXD_00_00_OFFSET).

Fix this by introducing a local opaddr[4] buffer in zynq_qspi_exec_mem_op()
and explicitly setting xqspi->txbuf = opaddr before populating address
bytes. Also allow up to 4 address bytes in zynq_qspi_supports_op().

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
Link: https://patch.msgid.link/20261016130812.282624-1-cyan2254650260@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ resolved context conflict due to mem->spi->master in 5.10 ]
Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 28cb3e7f6..58a9134b2 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -231,7 +231,7 @@ static bool zynq_qspi_supports_op(struct spi_mem *mem,
 	/*
 	 * The number of address bytes should be equal to or less than 3 bytes.
 	 */
-	if (op->addr.nbytes > 3)
+	if (op->addr.nbytes > 4)
 		return false;
 
 	return true;
@@ -535,6 +535,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
+	u8 opaddr[4] __aligned(4);
 	int err = 0, i;
 	u8 *tmpbuf;
 
@@ -561,11 +562,12 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 
 	if (op->addr.nbytes) {
 		for (i = 0; i < op->addr.nbytes; i++) {
-			xqspi->txbuf[i] = op->addr.val >>
+			opaddr[i] = op->addr.val >>
 					(8 * (op->addr.nbytes - i - 1));
 		}
 
 		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = opaddr;
 		xqspi->rxbuf = NULL;
 		xqspi->tx_bytes = op->addr.nbytes;
 		xqspi->rx_bytes = op->addr.nbytes;
-- 
2.56.0
