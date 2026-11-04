Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764739;
	b=Tav6Z4ZvogB0k+pz0hMcYff++85MTpoAf+BwuHZ1ksHjt3L5jfNpcv5YZ2sBgW+xwZQD
	 C1m/ssYAtU4q+dN5ZISo4Q+VNAOZsvDUTupL2jq1G0+A99wsKL1PowI6vUUxJUCpYktf2
	 4KlhHO3blboRlny2eymS4IsiT4IbT0/XWgUAhPnINW4Kw3R41lDdTuSkbZ/uokZFRbSQ1
	 bc5ucP9x0P9HwF2IPJ0oNSzzyHivxAKQW1KPmpymU+f5AIUSZMzzw+dCGHDNENrH1Lw20
	 Fi3vl+jXdIXqG7f5Ov6IgpEPnlr7Y6OJ7g3hewR15w1mZLj5pi06IGtHti5GdZZqc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764739;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SO36a9ub9Qx/UKW73LBbXZKVdS501hGyizN5TKPiU5o=;
	b=3raC/GvDTPB+lQt0gxMgw3W2cpRNU2AnIKAYlTXPtk/0IQVsRCyp69lUFnCZbBprx6ef
	 vEOKDj8lyeoy9t2vfjpp5RMLveRs6uBb3HqYsJNo2IBBIOb3sYB1tdNKcJCGI6BbOphaR
	 zTd2vv84044Zzxnsk6gbZKiHEhXx1hh8mmb7leTu9UfkrqZ1ZuRnUu1AuKCeLmLQcO0wr
	 VcM0br/UAA6l4ed9li5O2tMH2h1fM3XgJajCNTJAdVNRaGh+v0Z+otQS/WCFiIhAszPd+
	 iCoaQylWiQVRVXy5OuAV7kBAmDBzCB9IAS4nmE0Nc3knhOV4vFYhT8ssNeFHOyj6ztQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCF606A336;
	Wed,  4 Nov 2026 03:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BCF606A336
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
Date: Wed, 4 Nov 2026 11:58:36 +0800
Subject: [PATCH 2/2] gpio: aspeed: Preserve the pending G7 interrupt status
 on control writes
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
Message-ID: <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1628;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Fnj2zvHZ9ECX/p3mEpqFA6hScNcf6xsh2LB1gDUZzP0=;
 b=nImNT7EHh4sK2dh50Xr8PxvYhqt+V8ubRfexjyIzDbgkEfG4NiobJ4sjZ3lCDSEWYoMlbtNTs
 f/8oBGptk7fBi7v2A+6wjh+ZNQGytcEIKQAVLPCnybfMuwWaKKhGMO/
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

On G7 each line has its own control register, and its interrupt status
bit (bit 12) is write-1-to-clear. aspeed_g7_reg_bit_set() updates a
field by reading the control register, replacing that field and writing
the value back. When the line's interrupt is pending, the status bit
reads as 1 and is written back as 1, so updating an unrelated field
such as the interrupt enable, trigger type, direction or debounce
selection also clears the pending interrupt.

Mask out the status bit when composing the value to write, so it is
written as 1 only when the status field itself is being set to ack the
interrupt.

Fixes: b2e861bd1eaf ("gpio: aspeed: Support G7 Aspeed gpio controller")
Cc: stable@vger.kernel.org
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2482f2ff735d..6e834e83915b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1168,7 +1168,13 @@ static void aspeed_g7_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
 	u32 write_val;
 
 	if (mask) {
-		write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
+		/*
+		 * The interrupt status bit is write-1-to-clear. Keep it zero
+		 * unless it is the field being written, so that updating any
+		 * other field leaves a pending interrupt latched.
+		 */
+		write_val = ioread32(addr) & ~(mask | GPIO_G7_CTRL_IRQ_STS);
+		write_val |= field_prep(mask, val);
 		iowrite32(write_val, addr);
 	}
 }

-- 
2.34.1

