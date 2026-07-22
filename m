Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2A374745
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732671; cv=none; b=Pulb9AKSjJMYOxqlpGpJMFlKn/vgkI3QFPVlqAB1dxkS6F3ZIG2KbZW5B9KG/NgUOtCtSD/d+AFn29p80saa6+FYjwSGgI7qULc9BBw04tKm1cqiEToiI6QcwwSOhcVXNVC/NkAYajDUMjoi97xldCp6F10yw260rhGKI9LsBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732671; c=relaxed/simple;
	bh=AQV1L8SPWkf1KORgfsgnuvG0fjYFPRlQuhXcyOD42xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN7xRrfLqEXZ8K1cZE+L/4MYO+pRdyMPadjf/53cFuH7MsdrtodKbn3zrumyWOmC2dGrrGOsq+XaMxGM1gEPIKGOYPQX8FEI0aTmjJUWdJ4vJRg3loV3fNxx/iGx0JMeNl91pw/+gKEfJhMshaVOKkpUVr3C+4s718le+zDX36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRYN006o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRYN006o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAB91F000E9;
	Wed, 22 Jul 2026 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732670;
	bh=ttMMSgFMnldUqfgTZqetRu+2A5V7k9K9BBNgkx6hUBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRYN006oxSyIUX54G6Pstqw7tT8yxLrSCE7qnpuE0NKWOZpgMWWDUEsCMQKSNjKXg
	 wmXLkMTGjaqlfQQHm3aHxsNkQCeiIRrlLmoFv75S0k75/d78MxP02WF3W1yrklsmlD
	 jEkrJ+BmVhJTWQnhDyTmW+ntltH/KD1RT6sX9L7ALR4Mny6JV/I+e+WJXYHz5Vas3G
	 Pj1q1+1WDQ3O8E+HvWaFHraklZHCoNGVq4jrmk49Ub6Gzxcf9ldrandZHr0+/5ECZa
	 yNGdz/QmNRb28yHuXdeNGKWEiRErgxglPVo0wQC0pnv0RaZzyQHZA3OvFoP+itL8C5
	 XclLfos7nkhsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
Date: Wed, 22 Jul 2026 11:04:26 -0400
Message-ID: <20260722150427.1659292-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072034-pointing-culminate-408c@gregkh>
References: <2026072034-pointing-culminate-408c@gregkh>
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
index 714c23f9504fc7..bfce8ad9a88117 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1193,7 +1193,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1204,7 +1204,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1213,7 +1213,7 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1224,7 +1224,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
-- 
2.53.0

