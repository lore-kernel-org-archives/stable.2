Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764737;
	b=r3pvZ1lxyYOoJQmaxqHjWkXwq4YEFrEGWxBg+aqwA7CuA6x0sXG4SG/wEkZgetZ++7mq
	 Qm6aI09gpQgsbLfQmen2UHeE8tXBxinj1kPxUFq9vypsVTY9JZs+KZ0KeUr92laOwcj7r
	 iR+mD4uI5CZVkTU/eLyPAy5vni18PLGWhHf/a4oF+k3M80hNR2BIgAPQJvcHbOIpKTBxn
	 +r5ZP5MFpcy4sxHb9b5ODQpKfr9rX/8UFuNTkvm8jMpHUi5DwBamGy22RAr48Yq5yxr1N
	 CA7rDcSDVZdr4Ab8+BZMylcG+MHSKAKnCBFxzwW/Dk9b8VthW9SYjcjGJiMm1u/+xZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764737;
	h=DMARC-Filter:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QWbjlLOr+8hkpwlUSwLszIplc2RXylAKoniq+0KkMAI=;
	b=PNRThr+hVqw/YY/6QBof3B5CcxGc0x9ggeFYazRroyqdID7LC/BfxCppm9ir2qZoQxJX
	 Rq1MJuBUr2GLNyzxqavptero5ew+IGYj8FJIiw7kO1roRCF5y5tGnNycnEJDkcJikHmn9
	 qg2ghboTk7NXkLxk+11XL1w6xF2ErOVQeOhz38xXHVf97wiVtg+lmxd71RoA5ja6DDIGa
	 gWnclhUuXO7j01KTEHbPaW4ih0bef3I7G1VPOcsSz4c8wyXTvqSydCfUO2La2AAB7RFQQ
	 LO9kE9vw6B4f4Xi/3meIRd9ZSazPE89/Uyakh7j8YcSX5XmULRb4XSGih2CDEw4UrOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51833606A326;
	Wed,  4 Nov 2026 03:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51833606A326
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
Subject: [PATCH 0/2] gpio: aspeed: Fix lost interrupts from
 write-1-to-clear status bits
Date: Wed, 4 Nov 2026 11:58:34 +0800
Message-ID: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAGqt6moC/x3MMQqAMAxA0atIZgOmFAevIg6lTTVLWxsVQby7x
 fEN/z+gXIUVpu6Bypeo5NRAfQd+c2lllNAMZjAj0WBxLZLRaWEOKHVHPdxxKlL0hpzlEH2EFpf
 KUe5/PC/v+wEVUbMRaAAAAA==
X-Change-ID: 20261104-gpio-aspeed-irq-status-1fc21a4edfcf
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>, Aaron Antone
	<aae@amazon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1310;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Spxhcm05RN8n5Sh9TZW9A+mV+AO88j/EoIbdaSDAC1Q=;
 b=8g/Xu7pU2y1fekmgY5p4e8m8VTtBLtTYoqVWdQqsYQcNcbyBEVhAedQYqRNqcERFOBFSADxdx
 TTpXNzDJzH2DlwXjM5x/4B7aOHlLrSzdi4D7Qkn8sa3pN1cll6XdZ9m
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The Aspeed GPIO interrupt status bits are write-1-to-clear on every
generation, but the driver updates them with read-modify-write helpers
that write a pending status bit back as 1. Each write therefore clears
interrupts that have not been handled yet.

Patch 1 fixes G4 (AST2400/AST2500/AST2600), where the status register
covers a 32-line bank. Acking one line clears every interrupt pending
in the bank, and an edge that latches after the handler has read the
status register is lost. This was observed on an AST2600 BMC with two
lines of the same bank toggling together at host power-off.

Patch 2 fixes G7 (AST2700), where each line's status bit sits in that
line's own control register. Updating any other field of the register
while the line's interrupt is pending clears it.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (2):
      gpio: aspeed: Clear only the acked line's G4 interrupt status
      gpio: aspeed: Preserve the pending G7 interrupt status on control writes

 drivers/gpio/gpio-aspeed.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261104-gpio-aspeed-irq-status-1fc21a4edfcf

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

