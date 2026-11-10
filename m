Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333824;
	b=oYC3r0NJp8R0Em+WxzgRpXh/vN47CvCtzZo/vpl68Ob1SWdnmDNLKMgBxJ9rUbhE4wwm
	 aDr5KEjr+eX0jfbzFW6OPHFHdqztviVZ9th0QxRagyvq3Q0KPIAAb3JKIsgbLl8wVsJM2
	 TOy29t1oUSKMtRjXeiGxusofBCxPQ5hdBHsmwl8mAhCAU6mDnT/NG0fjWkgbC2Il4CJF6
	 4HvSSF4ZihqYfyx1c0NibP6TdYw2ji+1jvAu+6yFCPHfJMARKdG/zbI3h4EClDeFuksEF
	 tcNqzWTCacFIILHZWdxqsZ1dtTIImMViGQnm8k2gilhhIXV7I9ofKpZtvZdlsyV3fNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=psuzUoi1yoOBbY70NZF/K19ouJLZaTz+XhReHvLVWLE=;
	b=1aDpShD2PNKTVfKcVU4uy6d0sXFzV1DNVY10Q05XnPuLUCT7u0kDkT6TaIDddBneyJXf
	 PIMbR8RrTIx3LiLZO32Nm0afD+sUskFikQDWui53nVczY7CxWo2EGSKwf34ZVaNNOZL14
	 C1LM/ghGopTnL9MG9hLifvJEurlP2PNIJqEvgG1/PCtbTxMVQX0tZJOWlZMnJFQ5JNgSN
	 p1gBdfKZxRjwYE+/Bp7u8vGiUahLLAGxvCzUg64j8Com49EddkQnUM4v1TEhbytH3ZChj
	 z6sS/QRy/k0Zvru7lnyZiBUzXBu+sutLe6rI+3KYvwRfyl0bW3pyqdBVU0xMIj3bd+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXJ4dYlE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE202606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXJ4dYlE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118BC1F008A5;
	Tue, 10 Nov 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333823;
	bh=psuzUoi1yoOBbY70NZF/K19ouJLZaTz+XhReHvLVWLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXJ4dYlEFzxsCbBm+uqJKO03o43/Us1roMVURmTLMb8TgO81X3dsKUAitKawdVj01
	 Z5S9+ufQ08RXSI/Ec3u/GL6CA6tULBOfj1l+nUsiYA28GkfI2SZkJ/VZhHOTAa/uAc
	 FxelXugZ+dyWkwpPzWo8yn57XgTUbypntbJ5+XZMVGjuVcauvUw6Ac3KHPRYcjxZ7y
	 pyH6ajQYlzfxZNUMeuj0iQnrU2xBghq2TizMNtyhkqdRx3RHm94pGDX1nOJdzglkSz
	 Z8b4vU78MyFeG3g9C0qoI0T3twcCc8iKoBvAOoH4tbW9a2vm0wMQYHBPxXr/5PMZ8D
	 w2EbKgClzChGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 13:03:39 -0500
Message-ID: <20261110180249.3093454-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180249.3093454-1-sashal@kernel.org>
References: <20261107052158-failed-6.12-1c41d09dcd07@kernel.org>
 <20261110180249.3093454-1-sashal@kernel.org>
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb ]

MCR register has the same address as XON1 register.
IER register has the same address as DLH register.

Which register is accessed depends on bits configuration in some
other registers.

To prevent potential access errors, declare MCR and IER as volatile
registers.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20261006192540.234402-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 92869e56ce5d2..5c6339f6f1bcb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -536,7 +536,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
 	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
-- 
2.53.0

