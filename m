Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266840F755
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728471; cv=none; b=T07ocMTsLuLd3/VAupvQXvhQetfeuYYLM9OzgLnYoFqUPOeG5jeEShn88vzva3vwoYgu6MhWA6cr8jAdpzlkrYASc4tIo1SiLqKu7quj9mRsAnKR4Sb+isOeQ01kQKW5lVQ4dyWbxiOn2LP4zKWjya5f1N1bc32J6tFxneDBJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728471; c=relaxed/simple;
	bh=axwKA09QoFn2wvvkP3Oro5w2hdW0INVllUoojcFMCDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEMXp6Xg3/zr/hOJLcTkqoV7lbSxVOsw5Ri+kah9eg0zY5oJjAyRXvEt8H060vy6jaTMTiqwsq8/5+PAX9Dz62Z2vYMhZemha0UsdA7XWo9c/xOe8yRZkwat19wr0GOlko3194VRt7ATx0faFnRDvLldCzoCxIQqdzMxsV+L3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZMh20Dd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZMh20Dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA81F000E9;
	Wed, 22 Jul 2026 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728470;
	bh=5nNcYHy1v22o5mMJV29z2vdxpf1k2BGTUTL2rL+AnpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZMh20Dd6v6zBPd/vPl3KCpNBSF4ctDpjChFtkMbKggiN/QaRRcaZnUU49oL41HEZ
	 WpZO2P7ro588UIGOIT2xGg5QH7n5lrZw+dVhQKXKxffCiNBS7lDte7GArfHkBI67Hp
	 I+75b2u+EOdHXxLYbd5y6agfSW0VgM2u58Mm94qxiqDtMQg1G6eyiWNHlXuYkl6/Bn
	 3K7EoZm9R2zn1Kg5VOsLMl/kSC5AE3tDg370XCi1VpQ6iC6zX7aTMvBhl9tJRYRzjw
	 VWaefaJftruLmZq3mSeeiai6mF1z5dSoF1+vrVq/eKH5Yh47SEwFODfh/qWunGUV5a
	 +rl9hseO/o6dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
Date: Wed, 22 Jul 2026 09:54:27 -0400
Message-ID: <20260722135428.1365359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072034-gnat-junkyard-971e@gregkh>
References: <2026072034-gnat-junkyard-971e@gregkh>
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
index e10dcdeeda2d32..6db83ecf77d690 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1209,7 +1209,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1220,7 +1220,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1229,7 +1229,7 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1240,7 +1240,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
-- 
2.53.0

