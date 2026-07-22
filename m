Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B43F3295
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736486; cv=none; b=mPWDeZ9XqfR2ybM1QnshiYD792XoL6AYs4KOUxkX+c8MU3h/xGGjH2YhkzcWvRV8i+Y5IOe5lCFFdQQMxOxBKIW/jpxT4939bFzn6JbkmEr+YRn6hUHIhUcos0RynQmeaQ7dbPbD3HfoSt595dYJyZsOO/rizjAE4hLl2WFE67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736486; c=relaxed/simple;
	bh=j8VFDByGoZa54sNL+SsGTbaZLzigq7tjFPMFPBIyQ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F58ENKsEK/Id42FqxMDrYWC0o4t/ptUEnsobdLGz8HyxuI6iVRn1beGa2rXi/2XfwgJckf9SAM3ynTosIejoVBMDbOA9oum2QGw+f2XxdMaq/J1GKHlsUPwsvNcAG/VKlhOz9N5LIFy+D0W3RJ6ezaGCOKFhYw+ll5Am86EvCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKKNLeJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKKNLeJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8B91F00A3D;
	Wed, 22 Jul 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736484;
	bh=xZDX5yIHEwZWeyfFvVo7fgSwhA9XYY1ZXvr2xx9dMwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKKNLeJEMFAxLVdCzwdriKtTMgb2j3MXrAJZtRRYbmKf63mBOWg+3G3juVpLVGUmF
	 UIygD3KWgke7l8gSSe1ACL0M/PAwOgEOJnHIhSVVeAPLfLiseLtdTFukFqPxfSXX6T
	 I8ERDgFtmZCLvcHHSW9b0NH8WTWLf0X/K6tmpbte2JwCZXLBZEz7mLP7wfSuUQ4K7Y
	 dGl4CrQk/+7FccLn0YQr69TdZPqQNnZQt+oTfpTh2wqr2gYXQJG+3LqXU9YWdznWlA
	 AkS4Vgo7xgujfhesyhkIRy72P8iLZ1kwvrAhAJ1B5u6ltJlCNDA0JMKwJbeT3bq8YX
	 dvD5vXNb1wkqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
	stable <stable@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: max310x: implement gpio_chip::get_direction()
Date: Wed, 22 Jul 2026 12:08:00 -0400
Message-ID: <20260722160800.1740676-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160800.1740676-1-sashal@kernel.org>
References: <2026072035-wiring-celibacy-527d@gregkh>
 <20260722160800.1740676-1-sashal@kernel.org>
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
index 08ea98bd6d5ffc..9cbfaa0c0b051a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1235,6 +1235,17 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
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
@@ -1441,6 +1452,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
-- 
2.53.0

