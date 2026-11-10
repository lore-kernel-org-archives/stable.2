Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334567;
	b=rB6ewIPWyIkkDexQahQZm3/iXW1WScNTJN0wViwUreCOaOT3VTsxaWB+sV5JEogPcBSI
	 +/KlHFO+In9rANykEAkXn3ogbnxjKO2z5elnRweGSlx7ArnOkn2QlxMMWSZNCAP9E7HZ5
	 iu+oDhZKlbU091MTr9lzA5gITxCKcKHfkHRF9gxzpozwInBF+e6TzPEfrldIHN/aFN8g5
	 P6hD84izXvv/tGS4nTolh9DB/kOceR65c/yrkisFIdywBpUb59y4GkLdlw0obvOO5IUQM
	 USw2ssaMAQnxc140dks5Ch4dyo84BSe4S+HPpUsc60ExyH6u32k9zxURr3ISdcDQZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PXBRwVUIhTouEw9uswFQgaqP/RPRRolgvpzzkdxdnSI=;
	b=CJWnFxhBHi0cZznVmkA2H+3kP+ydTertiOmMZYmcia2gOODoccltmkUBzbSOzbGSPyyw
	 ulgRGECjVWDawFM5I0nudEyJA4xvHFfwHRKa5s1h/upp8wkr+w/rni6weE7+VN9rim8yF
	 qJpD+BDtIRGvI1EbcnwAGCV+evpA1/hAWjK6VcyVNiHPiDPgFCyhXhcW6bgkbRvcsjmXk
	 DbJL4qT2XzwzDr6n343BZ7aPs1y+5i7ojLtZQDGCGZpPoC/5hGvT4qJogS16MYf8hjumj
	 v1OixQFkbJSr1WVM314S42N9fctEawbhHQ5N4RvoWCvj9NQnb3TZpAIrehKJpH4wToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiYNOuZk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA8606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiYNOuZk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B3C1F008A5;
	Tue, 10 Nov 2026 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334566;
	bh=PXBRwVUIhTouEw9uswFQgaqP/RPRRolgvpzzkdxdnSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hiYNOuZki8BigEvQqB2b5JjEWvg7fnKK2oVt13FB9Y+5X9iMv1BDte3u+6K9pmRu6
	 HkzJUElNjxCuG18fx15edrbJ5syJ43FGImUdLXhaPIvhMEFUxfPWampEGt4Aa6vbcB
	 kJWdcRTZEmhDn3ukG0q6owtQio/Wh8rCDHympj1HeiJwwX3eE8h/4YixGdtxwbkVER
	 ZRtDHh+DR/MwxNhTbq/FlZs12Yq2CXo0UG/uW0KcjJCD0YH4yvXFMy7wsXxde+5mU0
	 CExFoEFKad8OA5A3KsSjxAYW0QXcKrQrm22s2KVEKf0EfjO/35vlOT3LcPiUvlohBP
	 Pz2/LsNqSuTiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] serial: sc16is7xx: add comments for lock requirements
Date: Tue, 10 Nov 2026 13:16:02 -0500
Message-ID: <20261110181549.3115506-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110181549.3115506-1-sashal@kernel.org>
References: <20261107053420-failed-6.6-1c41d09dcd07@kernel.org>
 <20261110181549.3115506-1-sashal@kernel.org>
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

[ Upstream commit 42405cb77fd35b5acc0e5a11d74eef68c2afa484 ]

Indicate why lock needs to be asserted when accessing
MSR register, as this is not immediately obvious when looking at this
register in the device datasheet.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251027142957.1032073-15-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c41d09dcd07 ("serial: sc16is7xx: declare MCR and IER as volatile registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index fbe8128b5e681..3a11bd9230555 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -532,10 +532,10 @@ static const struct sc16is7xx_devtype sc16is762_devtype = {
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case SC16IS7XX_RHR_REG:
-	case SC16IS7XX_IIR_REG:
-	case SC16IS7XX_LSR_REG:
-	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
+	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
@@ -780,6 +780,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.53.0

