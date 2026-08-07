Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FD3806CD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073697; cv=none; b=kNyBs492zCZNxQhajiZUFb0RZDrwofMsHPXLsPunaKkG6yGVbHX6hFijWLqT0g4bRIL2xLhdfZmsRqV4SNOk3PzvzpBkZGc7vTKYB1gEuQzRIkPtfHgikjvAj9Hcm0TM4lSzMJ9Xh8CC0U0TiSQv0tWW6X3iNd/WkTA3Vy9ePsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073697; c=relaxed/simple;
	bh=7K6pIGVPoED1/wKmxdQRa7t9Xw+X4mfWu5hY9EBMSyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsxs4DVJlUUeT0afqC8Bs43ANhFcZ+kg+NhMbTxoYfIf95OCknMpaSg7duLFx9uaa4IL9T0mJ+WVHYaYqRz/F4kO3Kqs/hPgcFYQP9Aet2Hol+zbvXv2UFlO3JrtzECATjh2fYX+6KdfN8LnlVFFFrWzSUO9uZHl76KBkiC1xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d671TMSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d671TMSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF29F1F00A3A;
	Fri,  7 Aug 2026 03:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786073694;
	bh=GggGM68qNvpt7qMdj4jbwZx5oheCu48p1GskMHdzCUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d671TMSo54u0vOz0bi6dcaXKe3Rl1sfvzIvJTbL3TtxIqyDo4Gk+ZEd/9P0hbLCRd
	 nlF+DEL+P40pLE/NMLifkWv4JeFgIhEsKWuEX/xnfk46OIDSrM2TZXnRC6ccIuKk0h
	 6KJu7zW4R/FZqEXllnwqLstuYQjL5CRsRtlmAigmw335r1R3a1kwF9SUKWcD8hCcBV
	 DWXR9/yUZgaVD6guXxp4SswG+LTLhXh0XodXpAS8ty9aMvcyUfLZEQz3jW+CDnhsn1
	 +qnGFAYIPGZ4oMmuYJs7MNEnkBry83+tNeq4gUa0Kby1uzZDyuyTqjYJrZ3wykdAKX
	 iQKbTaXTNvREg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable <stable@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] serial: sc16is7xx: implement gpio get_direction() callback
Date: Thu,  6 Aug 2026 23:34:48 -0400
Message-ID: <20260807033449.1725763-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807033449.1725763-1-sashal@kernel.org>
References: <2026072914-sandbar-very-7f7d@gregkh>
 <20260807033449.1725763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit af071d9e07e57cfff239e8d09d2f3b05ebc9c667 ]

It's strongly recommended for GPIO drivers to always implement the
.get_direction() callback - even when the direction is tracked in
software. The GPIO core emits a warning when the callback is missing
and a user reads the direction of a line, e.g. via
/sys/kernel/debug/gpio.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable <stable@kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260716210813.2582826-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e94006fd6e63b..e177df2c4ea22 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1204,6 +1204,17 @@ static void sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 			      val ? BIT(offset) : 0);
 }
 
+static int sc16is7xx_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[0].port;
+	unsigned int val;
+
+	val = sc16is7xx_port_read(port, SC16IS7XX_IODIR_REG);
+
+	return val & BIT(offset) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
 					  unsigned offset)
 {
@@ -1281,6 +1292,7 @@ static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
 	s->gpio.parent		 = dev;
 	s->gpio.label		 = dev_name(dev);
 	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
 	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
 	s->gpio.get		 = sc16is7xx_gpio_get;
 	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-- 
2.53.0

