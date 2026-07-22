Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A6360EC5
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731700; cv=none; b=nkk3TW0gcE2bEzM7Y6y/EnEHEZaMQiHWEqdLLg7fzzAeoo0v+5n6rHc0ZmR2aUA+bxkXJa+mc0jGC86ArtvB1QMkKwPz61RN0PpaRmAkwt54aqMd9tW/WFg+8VSK6YBht9fTvaIWfjZn2slYBP8YbJXF7fhARYV/tED1RUm/zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731700; c=relaxed/simple;
	bh=oHd2h2OG7ZxhOP/T/Onh4JheScYUYZaU2ZDpfE9QrpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQNW5X/SCchf7f33FZABLIFiVkxmANbiPptBhkhjT3+nNh9BQEoC22sgAeejT9fAFPBp06Sq2T2A+Kl2M6dKNZGI0mschO5NtR1QvkkEcad0/dKzSOQU1FWBzR+P5bMlrKDg0LGjiJLqoLNQCby41cNsRp1PU3FT2c4PdGQAbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGRbji2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGRbji2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8211F000E9;
	Wed, 22 Jul 2026 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731698;
	bh=vX0950vSX0VDLgsHS1BzfZjNo2dfu5iUJJsQMH0RR0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TGRbji2Z0RNc0Bw20ZAPeeZwI0CPNTcJSlkgZiIuhC8m+ZaHo8ph1CsuQH20mEsX0
	 vO8OW/lz6YIMM11BVrTTMXmLrLDkh1q/qa8WWNoiHG22gpfmEeFoT78H6+dD4vRbug
	 fKqBpDc58MGlgPtFBvCGn3cO06+KMO/ap7//jmcwb+qvxLKn1ugja8cIVd5Ydq0m46
	 n7w4E16uVZjciAgTGgJpDDgMkl1OQVhjBQxiTDqyZmyHHACMjsVIAOtDmNjT6Mp2AX
	 U+vcr4SI4CCOYR+CTDTjRqpVrYS6evSaIv+Ft1abSH5HqkaTu1GfQ/EfUxYj260dD1
	 f8GG/OtX1W7Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
Date: Wed, 22 Jul 2026 10:48:15 -0400
Message-ID: <20260722144816.1599424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072034-facing-tracing-f6eb@gregkh>
References: <2026072034-facing-tracing-f6eb@gregkh>
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
index 44b78e979cdc44..cfdd59afdd0a56 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1211,7 +1211,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1222,7 +1222,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1231,7 +1231,7 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1242,7 +1242,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
-- 
2.53.0

