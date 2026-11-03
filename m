Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741419;
	b=FitmXqA8WNAEZuA2XVB1bt8da66nZTbVxMKHoeOA7FqR/UH1qTsWoyOQsmEvGmNdaWWT
	 UaSDCpMzhfZu6rCOIu8wMf7qGCNrdI8mLgX08yjnw99VigxQgzfLzkdWdTXwgcC6ANd51
	 x6A90p8QKzH+yeRjiZ7VxRN/QrBIFKrxiI4NsbN83MazSYbEJJ+/fwJfz6D1e6umk2paf
	 QaytXaypwW6S2so+gCc2jrPg1Mpaa7EJMJMcRZucxKp8qcC4HbDkekPqSREuPUrcR5JoY
	 m5mjkJRmsnLfcU+7qC80grsJ9+t3pFbCRtjh8btC+9XEb4tIn9O1MdsF4Z5Mmez4k/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kZJOzDauoYNsrCoO2C6W6zBNYUEYiaq0/P1CBtElekI=;
	b=4QCNJySHL9f5SkzFpl1OvMCGyY4d5zCJYJN7O2NaGXf/+UX/wW+5ZGyls/Y3nC/VMkHL
	 64vw1K+PcHyBWUPL3Z1AQFajSh+6rb/O16GGos599dj811cEBZKF/djr1DzLcj6PiTaKV
	 sRxbNf6n5adNTR5d9EAW4mq6P2ZmFa7xtmx/Jd/qbfExXKQ5mi1VXQ/vs3fDUEWz4BL+7
	 IkGanRaTFmkA2DuulaI9ZWG6TM4G1py3Dg0gbgspWHIHbv1mkfRDwM6ErAyGV4Z+fx63h
	 8mH3O4yKZTr9pX9pP8/DZkttn4WOW+3a2AjN/BV3MaG9QYUL+Xg+YRi72urcSbbfCow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQ8Q9hrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DC606A31B;
	Tue,  3 Nov 2026 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQ8Q9hrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FC81F0093A;
	Tue,  3 Nov 2026 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741418;
	bh=kZJOzDauoYNsrCoO2C6W6zBNYUEYiaq0/P1CBtElekI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQ8Q9hrRaX2ZAyUrBkbdXkItU0fTwhigtPiEd0fl3vtgaLJIHDV1VWPDO2EDF5dc+
	 qraDrCHe0JNj7ciU/cFBPoD5DecNQNvAFypvugugEcN51bbsbZLW7U71aFoilT4B6O
	 KjZNjeLByf/Ag3dgbyQqv55nPkRPfaf1wXew/qa6lR+7qAKbbr/QJl0g+wNDdvRa9S
	 PvsgJ9bjTc99hnkvc8BNwxdpBaNvihY35sUAR8dcVvixUT00hoRnKZseExGjVAPcG0
	 LgyWTuhyzFCKyLLedu33lEJNjV5H5poU5Dg31qfVd35cwC3Pq3ZiYnETuHRXBWTdjV
	 X/tYsE8cO+U5w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] pinctrl: sunxi: Fix out-of-bounds irq_bank index when first bank has no IRQs
Date: Tue,  3 Nov 2026 21:29:06 +0000
Message-ID: <20261103213002.1673560-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

In prepare_function_table(), irq_bank and last_bank are initialised to 0
and last_bank is updated on every bank regardless of whether it supports
interrupts.  On SoCs where bank 0 (PA) has no pins or does not support
interrupts (such as Allwinner A523 and A733), the first IRQ-capable bank
has bank > 0, which causes irq_bank to be incremented to 1 instead of
starting at 0.  As a result, the final IRQ bank receives irq_bank equal
to desc->irq_banks and writes out-of-bounds past pctl->irq_array during
sunxi_pinctrl_build_state().

Initialise irq_bank and last_bank to -1 and only update last_bank when
processing an IRQ-capable bank so that irq_bank always starts at 0 and
increments sequentially across IRQ-capable banks.

Fixes: f5e2cd34b12f ("pinctrl: sunxi: allow reading mux values from DT")
Closes: https://sashiko.dev/#/bug/linux-9c4dd832-02d4-4096-9e91-a03c1d4d85b3
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
index 8bcd566593ae..79ca1a7c4837 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
@@ -208,8 +208,8 @@ static int prepare_function_table(struct device *dev, struct device_node *pnode,
 	 * Assign the function's memory and fill in GPIOs, IRQ and a sentinel.
 	 * The extra functions will be filled in later.
 	 */
-	irq_bank = 0;
-	last_bank = 0;
+	irq_bank = -1;
+	last_bank = -1;
 	for (i = 0; i < npins; i++) {
 		struct sunxi_desc_pin *pin = &pins[i];
 		int bank = (pin->pin.number - pin_base) / PINS_PER_BANK;
@@ -222,17 +222,16 @@ static int prepare_function_table(struct device *dev, struct device_node *pnode,
 		func[1].muxval = 1;
 
 		if (irq_mux) {
-			if (bank > last_bank)
+			if (bank > last_bank) {
 				irq_bank++;
+				last_bank = bank;
+			}
 			func[lastfunc].muxval = irq_mux;
 			func[lastfunc].irqbank = irq_bank;
 			func[lastfunc].irqnum = pin->pin.number % PINS_PER_BANK;
 			func[lastfunc].name = "irq";
 		}
 
-		if (bank > last_bank)
-			last_bank = bank;
-
 		pin->functions = func;
 
 		/* Skip over the other needed functions and the sentinel. */
-- 
2.56.0.385.gac671c819a-goog

