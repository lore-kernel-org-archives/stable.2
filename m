Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64927A916
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070167; cv=none; b=rp8VJ4kgEZDXmoH8Jic4NdUmnKUO4hYVb1vnVFSj2rP2wC5Eap8LRnlqt7U/C9OmvVVDnwT1J0uqazuy6ZVw4RVmSkL1zvr/6eIPhaXtP25zEgrm/N7bJzRMK6lHRwlg5pX2nLNH4S+qyObUH0kNmTX5jV+BG5Q6Qj5lfhLA/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070167; c=relaxed/simple;
	bh=SfbP/udNVDHUaJ3LM2eh1vXGoPuwrAgWbQpWZGkAnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya36sI5NdFzWdrJzk0kpMb7hQb47o0QQFJsH9V+zh4vPQs15V9soTfScZNDHUH+++M+b9S/1ApZQizt0aAErkgpJ3gKAsNWbQT8xWx8Rru1usbd+3T/LbvldWaW2b2hV2unO4J2o89hETKvp3HjgeSmPP/I8txLUP78pCqFlgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah4x2+s9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah4x2+s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE511F00A3A;
	Fri,  7 Aug 2026 02:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070166;
	bh=1FXtiTH8GNRI6Gcokwgugd25kmz5OXd+mFakRqj/jUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ah4x2+s9jmxYutN1VN4O+nqeftVIVU/N6tD8gmq15j7BSq/0Gc0gHVRYwiFFZQxxq
	 sNoYhl5P5V1oQx+0859FzeWUkIj48MZwJx7LdZ7uE2jvGBl4LRWGoyLculzFadO0Mx
	 KlxCVQr8DggvYMnqnYgPxn3MntP5wmrrLOzjJ81Gqm9dRUYyVyiuOWX3a2HdVdXfvD
	 j5rgtv+hMEdDmixDfECgqlbIi+I68xDTD78/jKEzvJMNt1FMWZH2SVytcKCbeCaT+2
	 vspD/0MqEPpLUgNWLyQ44wrKOhWrTIAWAXG5rMMao5vJaM2ByTulE74IZDBR27HmDr
	 Quke8ZEhEcO/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable <stable@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] serial: sc16is7xx: implement gpio get_direction() callback
Date: Thu,  6 Aug 2026 22:36:01 -0400
Message-ID: <20260807023601.1683108-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023601.1683108-1-sashal@kernel.org>
References: <2026072914-stainless-finishing-0e3c@gregkh>
 <20260807023601.1683108-1-sashal@kernel.org>
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
index bd377488af6d2..e1bb025a700d1 100644
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

