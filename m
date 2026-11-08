Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158037;
	b=JJWyhrKfIJ9EV11VfPETk/of5RKXbe/ASXWWtE0K+uc8E8Qhh/ML95y7GdM5Ewd3Tcug
	 2SpdrJvWA36pppIUYsixNndN+jXOe+6uWI/K+hvfRLFGCn+K1qpria9MXGjs637jrZ/3T
	 pQMqR5VEDgcjN3Czziwp+UU9SnRXYms18ubjJi6ZFk56hp6qe5e8jfIxlcCMkl2+YdBsc
	 KHQEHFO/dGtNhQqo6A0lXs3PDYfJImFQbKcyMV2N3Tvcbi7NW5ZKyfGtgf4ev5cjMl+kc
	 nHbtnc9vguFoOwxO1YN/xyOotKrJTF9TuGeUWYYNAGAU7p7DOpDg4JxuL0hRMnE4pFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tWodGGBOa6Nexsb9o+HjIeugtsIUyJeJyZ/DhtmkQ2I=;
	b=Z1zXQUD4/4xLBgNShlifRNOFz9QApYTLeQCHzJJdC/agXWhVvke8bwoJuxg7QuFTZBR5
	 ISCj/LHS603iq6SRM3UDgK27Mm75EbafOg7EaUslOb/3EOI5PTwIcHzDWJE1wpUh31WKD
	 PDKsSKq6k7gOPmarqfB20+b3lweR7bbTLXqQIlHDTTX0mOaBen/UUxUs3O7Qhho1dDnQO
	 lfKu+zjXvHOAN3n01Wb/c+CaAOc3xU1bRSg6XMG/3X8PLzNRJV6PdIdWzD+xCHaO5g2Bh
	 LXikEBhVF2GtVuaZiNby4fBDkTkbF6Vw5QzT9mGsLLCFBgV/onljYO/Y6dbd7aCj1EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBF+o2xy;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E0606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB7E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBF+o2xy
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so222909eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158036; x=1794762836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWodGGBOa6Nexsb9o+HjIeugtsIUyJeJyZ/DhtmkQ2I=;
        b=nBF+o2xyIO4djMZGsgqj1mOTtLU5ZUMsQ/SwqYbkloL4a4URlllOuzcQvApOWHSdQP
         MNRTU+krd1258ZKFVTuA41AsZiMCRaj0sw96gd4UYmFnWFJurUXh5OgjAvY3VdvrxUSW
         KoUpXRxf1MEAbbmtoY1Oyz3KkCIjMMp1ECsWaUQjujCUWLvwtrr0T9o9eq1/xEm62NKK
         cxM/qMtBipxdW4kwNp5W6GgKnAOoYa1kBBP/Ao1C5Hxwfo01PsYlNilbK7YXWHgc3khK
         Bx3xWOv/8dHo65LAZG1v+AmR6tbdO6+KlE0RmCmfxbwdZ58NW4rCD8UL5okw3qTBCduy
         Dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158036; x=1794762836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWodGGBOa6Nexsb9o+HjIeugtsIUyJeJyZ/DhtmkQ2I=;
        b=snhvukdCrwf1RfzrwRqBKfrVxpjSz6VxDmSYfMxbLhSYKw6k7B2jI7eKie5FGjfp1O
         BjKtkqGDXw3ZPMRwoBukkM2k7WmUArtMqfgLL5iACb9TQuGd18xiBeI2iANM4Aluri1G
         Lijcy6TgxoH1moAFro+RARcks9OSTOpabLajsbFb/eevIkTyb36EU0b5Yykl9ESVru/Q
         0Z1IjyPbUzwGecr0PEhtQoOLeDe2WdwzjqQiLramNZyGwq2Nx83C6/SLoTiGruKxA5FK
         WVUMbctnciZIr1Udt8xly0wt9bVyc2qS+SAlFhRB9FAkBHPYBzO6J5deRL0U0PsXhyhT
         tPuA==
X-Gm-Message-State: APuU4Z//vhbKojOr3u2RoMGBxz4mZaclI1xwL0Y6YknjSPbi7+r27ljG
	XH1ZScaK6OAewr+GNd/k9l1EPRGz8+vnLErffdz0D2DEPCaORjxoR7BRAkihCYdkMYWyrg==
X-Gm-Gg: AYBFou3Rj5+yt3Q1i6zrW0tssTrbwsYX+N3PkH8U1luvifGc/d6AtoHbATVYZH44Yb+
	nOEOcmZ6L0W/vtzx0d3rhE4RavMeWhjzmVieCseqpb1+Lzp1hy+mjjcd559Asx7BZmIy323aClp
	ypkGdAEuSm6RpPG+mMV5JhfhPmr32Y8qnebTArYU/jsmgAuxckVa1B28xPFrTzFmJzaL7spTGJR
	MAI6jvJYOfSeoGY4nivfVXi9dr7KzT2BQlYvClL3f1kkriGqNKNOAOY2TCWhARF/qf4Gaogvamv
	7/fqYmhvkXI6Hhd83QYrWc2JWCFddISuLFlyJ82TegsJMY8jMOXi3Ve5pjeHBnRMSisR5a9mtfF
	n/Yq/0UCnaLpTI44phKn2iBgcu7uqe4dTSqXjIcE4jeGyERexeiShKGYYgXUjWwNvU5h7Lc0lp3
	06LYE/gzcJL14E1griRx7UR71q9WBxCIrcyQhvMhgAqU/Jhr/zFfEF6qLDoHZrsACoJFPdezDJk
	QVPnR35pTzLgbbZaYGu7XhVa1zM1H3RBEqatAzYxe+GL0wJs7y7iVqOkYVhr4ZU5fSMZZiD5FgD
	tlDqiekkAtIjrQfH5x1FG/Dou4CtaYaLmrFpg8TffMwuebEPlg==
X-Received: by 2002:a05:7301:fd12:b0:370:5a3e:7021 with SMTP id 5a478bee46e88-3725651c0b0mr3990051eec.36.1794158035584;
        Sun, 08 Nov 2026 09:13:55 -0800 (PST)
Received: from AERO17.taila7786d.ts.net ([45.95.212.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-373920a0219sm320926eec.9.2026.11.08.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:13:55 -0800 (PST)
From: Pufan Jin <cyan2254650260@gmail.com>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 5.15.y] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
Date: Mon,  9 Nov 2026 01:13:50 +0800
Message-ID: <20261108171350.66362-1-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107061055-failed-5.15-dc5ca34f5e8d@kernel.org>
References: <20261107061055-failed-5.15-dc5ca34f5e8d@kernel.org>
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
[ resolved context conflict due to mem->spi->master in 5.15 ]
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
