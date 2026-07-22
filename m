Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECF361972
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736484; cv=none; b=CGUiij4/jaSI28q4WREqXUMahHQ328UWFZV3qnz+bFpv52V8UZ88MPGPrYI7i20lF+pQZ3K/X5bBSj92uWxHcCik3fXWwyc19eLk+Q+J7LUmvIcKTaDV/REBSDNIt+S0UEHxDAIXxacy356NnDEgbp+nKitPbH3j87fSVXBNt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736484; c=relaxed/simple;
	bh=dZYBsuHdijpPm/wHCc+BPIG+VQptmXnBFUOz0JM/1fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqdzqW5ZeHXpFJHj4rVG34rk8YOzSUmjqWEks4nSiKaSQgrb+/CoYpYPmdR7USMTco8zdnsmqHeL0O5v7L/rESLmN5hCICsKigNtui0W+1KWimSbNDIFtRAe3MPXarJ9KxRhcHB/XuSTq4Otz9ayqjZouMBZAqaGELH9/yV/4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdUXqg6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdUXqg6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FCE1F00A3A;
	Wed, 22 Jul 2026 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736483;
	bh=Bpfv53qa+gY3LU2Z7yeMFlf1ouHaPL0yCuaOiavIxCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdUXqg6OFb2t4+9eyLA4wQtqqMtYUju7u3iJj5OWFKRrfP3pVmGoUWijTcSLAggld
	 NULvVZL1jc4RHPtYeE+8lyrXi1JjcX3y11KlNmVIJ1zrEYMZdneuozugZW+5fdbAvw
	 vqdV+xzXFy8TD6DuVnOnt+4e28OPqaps2LFDkVQjwVacBx0+TnJtMXpQwBJ3TlZlTg
	 KbRhdt8bNhc5nml40wAR5iVvvV6gXMX7Hs97Vtp4B6qZySMvlKQhBcT9uLQdOXV1MA
	 TlsQckqLe11xmm5bInuh43f3rfxHb3ZwNGmmPgPA19uiE0LuSwACFDCtqS/+4KoHdT
	 O+ockVW/tvONg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
Date: Wed, 22 Jul 2026 12:07:59 -0400
Message-ID: <20260722160800.1740676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072035-wiring-celibacy-527d@gregkh>
References: <2026072035-wiring-celibacy-527d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 79b69eb09cf5b6a77e621b2838b7e0d38113debb ]

Fixes the following checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

With this change, the affected functions now match the prototypes in
struct gpio_chip.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240118152213.2644269-16-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a483b1a91b33 ("serial: max310x: implement gpio_chip::get_direction()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4ef2762347f622..08ea98bd6d5ffc 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1215,7 +1215,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1226,7 +1226,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1235,7 +1235,7 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1246,7 +1246,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
-- 
2.53.0

