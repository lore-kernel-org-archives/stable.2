Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733F364029
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731701; cv=none; b=hqd6qO9BNm3U+P9QQWAGCsNBoHkhB0/Ug9uQHfYr4okff+dbNMdbMMlhICsTwwxvwUGsYCxbGAdh6fPl+LeWeNwD326kgxzQNX4NlW5OesOmU3wQ5VTdQZLxGDaokpfHj+wRj6UpUwiVPZKyKFK+VVisSsv/iX/zXXyWWItffQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731701; c=relaxed/simple;
	bh=W009lVO2d4ktP/sekWUIrml2lliAEZ9vY/foEtB+3Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRsSBj2ehU6oiUQXZgc6GlSXP70iBfxcoFLPoMqX9A/xFq6rVrDM/5tKUzxGBYDIU78fKh+7/hCiIRjWcIRcdW9B+Lh9c4KXVSs4g+CeX4V+0+V5knRxecNFAbqpzlT3iNNznHmN23dbzbSaF/IRitkdKpTdeyVE+vPYvq8SfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSbXRzPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSbXRzPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E48B1F00A3A;
	Wed, 22 Jul 2026 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731699;
	bh=AIDgPH7sqZ92KNhlUD/ArLgijFNr/t5BSFFEqYvkVRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSbXRzPIwQ+pkpTiQCq5A6HbQNCLkN9l3mJ0rF9TeVP9v1aSIYt3bRy1DGkRo8axO
	 8NR73VzeZ90NihWKM5NPOf4o8sLOnBBOV1k7IO9pwGKBdkrCpAGflAs25eDaGiw4Dg
	 K+f3bGsSfVaToBVc1gwSq0+zdbrw9+m4+KPjiRoYg8ARV63b0Fq85lQlkQbV/YaoFu
	 bQ/Ybj/fRR7mDIQAAQpAfDqGiEfGPGZk2w2mwo+dFIeNMLTbjAtRkqNXNgf+fRkk6/
	 W+FxNHtu3X4xL0eeL0aIFgcx5GEbBlNjuYa0fYHB0nxVIIhrKORqJxFKJoRjaPM95a
	 /ICJt3W8tD1BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
	stable <stable@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] serial: max310x: implement gpio_chip::get_direction()
Date: Wed, 22 Jul 2026 10:48:16 -0400
Message-ID: <20260722144816.1599424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722144816.1599424-1-sashal@kernel.org>
References: <2026072034-facing-tracing-f6eb@gregkh>
 <20260722144816.1599424-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tapio Reijonen <tapio.reijonen@vaisala.com>

[ Upstream commit a483b1a91b33b7533280e7c3efd2bc1275caef18 ]

It's strongly recommended for GPIO drivers to always implement the
.get_direction() callback - even when the direction is tracked in
software. The GPIO core emits a warning when the callback is missing
and a user reads the direction of a line, e.g. via
/sys/kernel/debug/gpio.

The MAX310X keeps the GPIO direction in the GPIOCFG register (a set bit
selects output), which the existing direction_input/output callbacks
already program, so the current direction can be read back directly.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Cc: stable <stable@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index cfdd59afdd0a56..92c5ee79b4b115 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1231,6 +1231,17 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
 			    value ? 1 << (offset % 4) : 0);
 }
 
+static int max310x_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max310x_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[offset / 4].port;
+	unsigned int val;
+
+	val = max310x_port_read(port, MAX310X_GPIOCFG_REG);
+
+	return val & BIT(offset % 4) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1439,6 +1450,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
-- 
2.53.0

