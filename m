Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336572;
	b=R0JALxlW+oc5wl2boo4/PuS2WeI4NMJnmJkVbqU4FYSmsdhYaRQ+nBXa0TfEBJ8jE8bu
	 NPqQDrzI39HzZXqJcTBPAsRq4qtylhT3gBVbbmxdpIZhfs6MqTrt4y3Acu6TZQ3/i0t0s
	 m0K0Ft5ubAqGThbce3qQlFQ0p6clGUB6S3Z5PcU52HXpXnF9pgotnx8IRObOotLUjlQkl
	 /kJcXJk54eazwPCRcAkM6myxqNfKDR2SfynZ9RsgUf4V/Yg1qV6hKI7tsZ6quC24R6hOv
	 etVeSDrJwhe/eBf0UMhQQNanHo4kvexXlhCYtyjBwxTc53P/FbrHePTCoR6gfaRsiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V42Ru+7zL9sggO/CuIwh8o7X7mznwqp2hIQrPiKVrc0=;
	b=i2+5USL/jmlMGtXssIGoqnHe1MitZeFLNz7DSA0GFcHg4Zc6561dM2ynhs5ayZJXlgB5
	 zwQ/hcokLtJOJ6AbP0qlW0k3oO6vMNKff+whWhqpDrn1INgg0vDRUNDE/AVkHEPChKM8V
	 2zF6xpAsVRcD51ZB206c5tRH1CO5OjgdfwzYOztSE2Dqa68xW+mHHbBF73KtfUwAdISX7
	 bvJvzP+0f0VZjgLsU4SqMWMpKbzDHsETqW4S7NkA4JpfxXiyw47UZM3bGPlRGhOmS8+Ao
	 okclq1APP5jlEFLM4nTjBsfR45FzcTMvjHely7DvyZOQ2OQvoLmYRcgkXziDwhZzxsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIxZcPUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAD606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIxZcPUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CCF1F0089F;
	Tue, 10 Nov 2026 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336571;
	bh=V42Ru+7zL9sggO/CuIwh8o7X7mznwqp2hIQrPiKVrc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIxZcPUmZGvM6jm7LoVLi7ODF4ghe6pHl4teZSY7h9z2RxPL1rVcNwlN68NTeN5Ek
	 SB1zntdxBdHQVeV6suWYwyCDgsmUGwWzNGK/9yipzffQSGcL3EtLiF4l1bzrIIoghe
	 XBSfs+SaIPbc2NG4TIQy2ticEQnorVbA8uAZler00QWRVJ0cxG20miElRubTIriR2W
	 ARtuaWVpjIuaN1Mt/zr+U8MtM6oHJF/5PgPa5LaF3wkI3jkjey3XOtsq9wXfuD6vz9
	 lgSVFzH+OGSpTcar+wSWOvIC/f4FouDBPamXYusGMP4sFIrz86q/p04bf1ztdVZIf1
	 wwx6lL+QPUcbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 13:49:29 -0500
Message-ID: <20261110184858.3413225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062211-failed-5.10-1c41d09dcd07@kernel.org>
References: <20261107062211-failed-5.10-1c41d09dcd07@kernel.org>
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
[ sashal: adjusted context to match the existing switch using reg >> SC16IS7XX_REG_SHIFT ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e177df2c4ea22..1934fce0fa732 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -467,7 +467,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg >> SC16IS7XX_REG_SHIFT) {
 	case SC16IS7XX_RHR_REG:
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG:
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
 	case SC16IS7XX_TXLVL_REG:
-- 
2.53.0

