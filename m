Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.92.40.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880566;
	b=bMPwxG1ODLlj0yTNXbfJQvmewNs2BJnXxLaLT5PrzHPDQq0KNr2In4EYlXsn+iCCVz9X
	 8wAY+KQEa7dESlTXYzvF2L+FgUfpfvvVjphlcBSZLa+FR2UaNmfJSdvS+9kG+9vsE6/51
	 ys69uMfkp0fBhbc1Rk+JaZlW/jmh1CwWIE3KotCVJYUdqhVGhFgZrmKPtdxOsCjTF2Xy6
	 OkD1TZ/FwpQNrMJYic3ja12Qxfk/dCEShUOcVy91zcnT9Ms1ENziucEB7me8ZLGergFDz
	 X//+dcZqB0MAT7xy4BAadfFdEfBHInPiILebVsB96eFJwcyvggT/49ns4XU3vMz+d/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880566;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=+zy6lijmScjxOAMWEF8MrPaSb7OpuW14nYg2KILAhV0=;
	b=hhZEcaGfL2cAtY4hgg+2W2+qr0usCNzqBcmRNYKT+dwNN30xE1BJSAdynHZ4ib2dpuyL
	 HoIRPApV8fI/0ou342DGatNMq3g/koQ89FcukiUAl1DJf/iH+485GyXZYJxamjdA+09gW
	 S2a2efX+Wz6rTudhEEjUuuMPXpp5rzrzY8t4SCAZdG0eaTOLI2XUtRDtpDPRY6qm+7kaf
	 0/i384iUePpFV9p5h4w5EtZArLqVeseyszUfjKtq0vFJm2A7wNwsU+vBQlmZjtoQl9wj/
	 wf78iV1ZVto3E3m5QJYYR8SYnMQQQNBaapoVEhg3ghHRE/rV0XIvRWAxxvJwO9BZs1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thorsis.com;
	spf=pass smtp.mailfrom=thorsis.com;
	dkim=pass header.d=thorsis.com header.i=@thorsis.com header.a=rsa-sha256 header.s=dkim header.b=mgJMCC8V;
	arc=none smtp.remote-ip=217.92.40.78
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FE606D804;
	Thu,  5 Nov 2026 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78FE606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thorsis.com header.i=@thorsis.com header.a=rsa-sha256 header.s=dkim header.b=mgJMCC8V
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5363814966AD;
	Thu, 05 Nov 2026 13:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1793880599; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+zy6lijmScjxOAMWEF8MrPaSb7OpuW14nYg2KILAhV0=;
	b=mgJMCC8V1e0Z9bWdBiraqhChx35xPFncQMYtijgBslTztVMd0s5ByewH34RJeLOU4wmPFE
	tXSk7mddxTl1U2Y0NKRWKnaVfHzMvJU2oYqa7TZNWmkphmVNTgmRGFjL1AVL2NilABf5Um
	0m1tD1jgW8udbcA2twbwtWDvSIDuyE5SwyaTXV/tutL42h/p096C8WcF90771dkFJuv4/Q
	hKDlRsZJ51Tbz4OIC5qPwPmI70wPrHpYdmctL25VNN+N8uwoQlJuZ9yqDl0DVGtJLyBbeS
	YCk9Pv7fqJATWOQCvQPB1Tx4lUd45YJ5p5kVjqyKkTm9dAASbS8P/H4RlwcHOQ==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 08/16] nvmem: microchip-otpc: Avoid reading a write-only register
Date: Thu,  5 Nov 2026 12:06:44 +0100
Message-ID: <20261105110715.2486432-9-ada@thorsis.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105110715.2486432-1-ada@thorsis.com>
References: <20261105110715.2486432-1-ada@thorsis.com>
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
X-Last-TLS-Session-Version: TLSv1.3

The OTPC Control Register (OTPC_CR) has just write-only members.
Reading from that register leads to a warning in OTPC Write Protection
Status Register (OTPC_WPSR) in field Software Error Type (SWETYP) of
type READ_WO (A write-only register has been read (warning).)

Just create the register write content from scratch is sufficient here.

Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")
Cc: stable@vger.kernel.org
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v4:
    - Add Reviewed-by tag (thanks Claudiu)
    
    v3:
    - Reorder tags
    - Add stable tag
    
    v2:
    - Add Fixes tag
    - Remove temporary variable usage
    - Reword misleading subject (s/writing/reading/)

 drivers/nvmem/microchip-otpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index df979e8549fdb..e2851c63cc0b4 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -82,9 +82,7 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 	writel_relaxed(tmp, otpc->base + MCHP_OTPC_MR);
 
 	/* Set read. */
-	tmp = readl_relaxed(otpc->base + MCHP_OTPC_CR);
-	tmp |= MCHP_OTPC_CR_READ;
-	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
+	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);
 
 	/* Wait for packet to be transferred into temporary buffers. */
 	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
-- 
2.47.3

