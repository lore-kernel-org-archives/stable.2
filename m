Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD04361DCB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732672; cv=none; b=k9Qtw2ZFfGK7PQ/6ny3k1w3fuUMeAkD900ptS3ESFfBkop4FIABt34bExWxAWFUY0Czxn2G7ahvODKl3nAFR01KvXxEhXx+vi3mNpEJ290/J9JSRS+a2ojh9/A52CGLIMC90TtG2mrzmgNC9eCouSITHdpO/UKU7hDtQvPdyrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732672; c=relaxed/simple;
	bh=IFSWDc3LjOPTWYAPQNs98ixuyaKl4CCl24Ci2P5i3EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHIPO3e00gH6qOht1DjtV18LwzFA4qibLisOSGQcXo+F1YSOw/QyQZMLHG33qDm8ExZ4LDda5bWA1d3uasxOGHPC/jW4b++aSI4xiRIogKPf0GTcrGMh0SQhef3LI5/r4q49NNSF1Gig71bdKG1Yy/NY3joASecAYOxSRyXk0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5Fmvd4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5Fmvd4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD301F00A3D;
	Wed, 22 Jul 2026 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732671;
	bh=722Va9xnpxJRA6NyIGySj0OrNwlgYdYxPOu4S73spxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5Fmvd4A+g9HoDJiKZ8uXebOuVMzLtihEho09MF5sqDWpGZb+c1OxmK+ViKD7ci/F
	 8FF4p9/M8iUTWcG6KVag1sWiA4G3aQym/ElKrF5zFlyvWgx/B1MxN73mWip0Qz5YqI
	 UfZY7OKjwZ8x90NyQ0aN15dOgmt6G6ibqOdVdU0DE4Fle8byS8yOldXCFNpsCR1xKy
	 Nw49vYzrjYPostLAMH7olDSxjAbPs99FGCfUicpwmkpsNdksHFgRPSm86EM2BpdiaH
	 XEQIX3wxyoc4TXixuAmZ3+VtMJv9RVROMPK+jxtb3ENBW2yqlNRqqiOiBMhI2mhqP+
	 bBxeD4Ro8kpOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
	stable <stable@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: max310x: implement gpio_chip::get_direction()
Date: Wed, 22 Jul 2026 11:04:27 -0400
Message-ID: <20260722150427.1659292-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722150427.1659292-1-sashal@kernel.org>
References: <2026072034-pointing-culminate-408c@gregkh>
 <20260722150427.1659292-1-sashal@kernel.org>
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
index bfce8ad9a88117..8e7aa24da23277 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1213,6 +1213,17 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
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
@@ -1414,6 +1425,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
-- 
2.53.0

