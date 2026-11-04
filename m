Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764738;
	b=GnMWNMZCyI4QSA4yCb5zODY00q3F3M0QUsHX7cEgwf5VPCJja+uq7kTlsjVdEk2esUCr
	 x4IIRwfi8sXSVZba20cHW1HcM9VjtbJyxxvdeaWJy1mhMYkWYeJLkNDKunGhDVdh9v7DT
	 MGbaHiy62kRCOfDatkjNTLi6e+ARZjS7biBW5ISJ4AMvNVziaAi+uARcCiPzuPAkHgscN
	 ZD3P2hVPTEmTBD3DfZmOkfxs7Eqj8M0mMIJF5LpzWgXZLGD/Moqn7fj9va69w7cPngbUN
	 2tkDlPxeLoPLXx4Kp2eCjW7wTfoDG9A3lpT9KhuxWdM57zNT3zsYS09bUHK4oo/V8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764738;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uBHr36LK49YQkkFNPU7jgzWwlJeQFqDRMsaYzjRg1WI=;
	b=FPjH2py8pkjI505HtIG1TxdbYYMubmFUv8VHT/cFI4H6ManUo01NKKbfv0WF4M2xshx7
	 5gkyG4VAF2SkhmRvlyIhF2qGyjKO0P5nbEnJylxckyiqhLziAujdUVpiMLbU2jb0mdSK4
	 Hol+sGA1vZpN/EjvWvUgChUZNqRcefXjZKVDFQEF6Ma0AkTMUrXQ9TbtK86kBqsggWt7i
	 GaSGwUx59T0WQc3orgteytQy2IhIpo5C+wZqJF4MESNrICTkjRLJ9aktMKCGW9+pDQCQ8
	 Kj0VJB1tDxKin0Ccz5/1SWar2Ds9jY1y3SO0ak3qrOnbKg//EKkQ4ZnFP80G9wX8WZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D6606A32F;
	Wed,  4 Nov 2026 03:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419D6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 11:58:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 11:58:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 4 Nov 2026 11:58:35 +0800
Subject: [PATCH 1/2] gpio: aspeed: Clear only the acked line's G4 interrupt
 status
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>, Aaron Antone
	<aae@amazon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1851;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=TEOj7oqwxfBFK2B1FS9iy35fS31jC1PHn9rs7TGEd8Q=;
 b=A6uNk7/EeJuMSlFXFHIIuh48EZqHYrN2yYSRc2hFsh4mWw8YtVum+F4B801WohKC80pkwuaT2
 vpUwXOtKplwAr5NofnGBl7YfHRbziZzCYP0uP8WZB7Q9wLfy8wNUP6W
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The G4 interrupt status registers are write-1-to-clear: writing 0 to a
bit has no effect and writing 1 clears that line's status flag.
aspeed_gpio_irq_ack() clears a line's status through
aspeed_g4_reg_bit_set(), which reads the bank's status register, sets
the line's bit and writes the whole value back. That write clears every
interrupt pending in the 32-line bank, not just the acked one.

aspeed_gpio_irq_handler() reads each bank's status register once and
dispatches the lines that were set. If another line in the same bank
latches an edge after that read and before an ack in the bank, the ack
clears its status and the handler is never called for it, so the edge
is lost.

Write only the line's own bit when clearing the interrupt status on G4.

Fixes: 79fc9a2fcc45 ("gpio: aspeed: Create llops to handle hardware access")
Cc: stable@vger.kernel.org
Reported-by: Aaron Antone <aae@amazon.com>
Suggested-by: Aaron Antone <aae@amazon.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index dc53b2decb66..2482f2ff735d 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1041,6 +1041,17 @@ static void aspeed_g4_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
 	void __iomem *addr = aspeed_gpio_g4_bank_reg(gpio, bank, reg);
 	u32 temp;
 
+	/*
+	 * The interrupt status register is write-1-to-clear. Write only this
+	 * line's bit so that interrupts pending on the other lines of the bank
+	 * stay latched.
+	 */
+	if (reg == reg_irq_status) {
+		if (val)
+			iowrite32(GPIO_BIT(offset), addr);
+		return;
+	}
+
 	if (reg == reg_val)
 		temp = gpio->dcache[GPIO_BANK(offset)];
 	else

-- 
2.34.1

