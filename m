Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288E48CD65
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331894; cv=none; b=bgpG9Sr7EJcUagAv7dpmCduu5Z55+PdoCfVmTF5HZJHL7b2CiW3Gs8BF3QpVi+hA7vLOoMCvZp8scS3FBaVrOFRBKmInTmYJCQbF+pLsRMhPBIYpr9ffrQwu5C1EykdOSG9zcKZqNUCVWZleIby3vmZV9qqz9tJi3rOEnErwWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331894; c=relaxed/simple;
	bh=ElQL5R3hfNcXP+B3KZH2YaeRlW4eaWFNuqIPTqrGozY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rmEkc9grTPY3rmx0gNvq95ANihvCnrQB3EPZWxlbjaRf5Hjp5qTi8dlFx5Ps3MTTAIiOASdZcZRDP6dAg8OSkJs9twaOYd0khjLwLzBKeym8C1jM5Ll67ug0tVAMAAAiid92yfcmCS4Yn8u0h/TJsWIx4uLjOD4b2tiEgbO76H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWexm+3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWexm+3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B051F000E9;
	Wed, 29 Jul 2026 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331887;
	bh=RSzEY6WjFT7gu5kx0HpzUMjnNZD4z9h8L3mUkLn6pbE=;
	h=Subject:To:Cc:From:Date;
	b=MWexm+3RRuNEkfXIjtp/inxD2U20o6m6IfBsZWjvCYkKSoGoxgK9P0BUp8VPACCqw
	 skndRMdHdwuRwM5qIxWwBLCSa/TwvEOBkiO/HxyfwHH25SjBUtxnaclnNWw8ufzR0L
	 vgK6sk1t5uudm0FQ5Jz9Qq5Sh1BcytxDn3LExwbg=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: implement gpio get_direction() callback" failed to apply to 5.15-stable tree
To: hvilleneuve@dimonoff.com,bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:31:14 +0200
Message-ID: <2026072914-stainless-finishing-0e3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x af071d9e07e57cfff239e8d09d2f3b05ebc9c667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072914-stainless-finishing-0e3c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af071d9e07e57cfff239e8d09d2f3b05ebc9c667 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 16 Jul 2026 17:08:09 -0400
Subject: [PATCH] serial: sc16is7xx: implement gpio get_direction() callback

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

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index daebd92f32c7..6c97953d593b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1273,6 +1273,17 @@ static int sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	return 0;
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
@@ -1350,6 +1361,7 @@ static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
 	s->gpio.parent		 = dev;
 	s->gpio.label		 = dev_name(dev);
 	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
 	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
 	s->gpio.get		 = sc16is7xx_gpio_get;
 	s->gpio.direction_output = sc16is7xx_gpio_direction_output;

