Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175783D7D88
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541178; cv=none; b=RTs2mNRW24ma2tI02aSK8ottVkLKWFREgh7CxdSYyLEemGSmU2k7EChRiC0CdXDcccouZxP7ijJfBQKjfK56/0L6vKE8TANOQZ6v/7kA84OsNT/dSR8fxmV78wdgh8Ltlc5DkqIl52x3DXx3sPmvZ8ny9gZgVDljDivwrRbHJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541178; c=relaxed/simple;
	bh=Y1KsFU2y3gebISfFtKYATh5/e7triKxCJZA25Yp0gCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eRvfT31PUbKzSaOXOqOPtOYxPFp34Juijn23uKKAcTTazIhXdYWWv98SMVTHq0nJQtStcspuAvfwR9ljW0oS40LhUN0SYqsN/tkMKRWXdvcbYSTpWYsUT4tOAiADsixC3Iq6kx7Dk9aNuJklliZP+7nnURFjzFuYTQ32r46CHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kG27NwYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kG27NwYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4765C1F000E9;
	Mon, 20 Jul 2026 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541176;
	bh=xPOBmw4sK57KehepORobLxqjYF2MoJ/HsPWId9FbPI8=;
	h=Subject:To:Cc:From:Date;
	b=kG27NwYiZhwMesNN5S1TuZwkNMmmuXfjzY0sc9iRMaBG4Ea6HiF8Nyei3IgaktfZM
	 3tWktKQI8xQm85RNz6oh+cf/61zECpDBU7aNyrVh6xk2vz16GqOiXhsgz8xNTTIS9J
	 wuQ4xLD9t+SVac5jPG6E6U+cKdlScQsr/9wqjODg=
Subject: FAILED: patch "[PATCH] serial: max310x: implement gpio_chip::get_direction()" failed to apply to 5.10-stable tree
To: tapio.reijonen@vaisala.com,bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,hvilleneuve@dimonoff.com,linusw@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:52:35 +0200
Message-ID: <2026072035-wiring-celibacy-527d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a483b1a91b33b7533280e7c3efd2bc1275caef18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072035-wiring-celibacy-527d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a483b1a91b33b7533280e7c3efd2bc1275caef18 Mon Sep 17 00:00:00 2001
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 15 Jun 2026 06:38:40 +0000
Subject: [PATCH] serial: max310x: implement gpio_chip::get_direction()

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

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e28e3065c99d..92af02a39c7a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1244,6 +1244,17 @@ static int max310x_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	return 0;
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
@@ -1447,6 +1458,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;

