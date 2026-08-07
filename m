Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC646272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073693; cv=none; b=ZuCV3wYzfWcM2LmvOuK7qnvKxl/GuHkx8KVxHK4ZEmH3UgSuesfqduK4cNt51qcjz2Okn5kpJD50tRNyq5lCzNRKGRV9h2ob9aRnQVTEt/nankZm2YdsoMxYqzE4hL+c/r9tET+/zyQ92Ko/wWijKmLEteQ8k6i3slJvBr8hWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073693; c=relaxed/simple;
	bh=o3MEJ+b30H8SorwPPh7fnd9cZmhHua0YBHe5+14+sJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCymWIj5P1PpxUWelFF5NLVSnqJtr8vgkTPRDXCDc/dXH/wdq8HlKuGWe8ZVue5dvl9we+5tfoA7Lny4Li35rJUaRWkCUg52P6UZyAQC4mqcBDMljBxL5r6XDIzRSjcNQ8cOkdhBkQDZxi/JH6kHRIMFFvPk5t1gQCjBClMdZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAiFbJqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAiFbJqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516E21F00A3A;
	Fri,  7 Aug 2026 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786073691;
	bh=Dp2voy1y8LfYtH/KN1xUziBW9fyCuQbZ+HxJu+/LUxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oAiFbJqEqHwHeUOcbDwx9QkYwdhfzNzE0N5c9+UYTrwkxPwTP3F8w2M00BydwUNp/
	 LlE0khUoCTUF1lnIWK7B/N8sBYPCiHmIiI1ggOw9y8VGhM++U61N4h3i0WDlsKcJXx
	 veNXTcpj207Yh0bWD8HfgGizNzuoW7QoNRae4biAxsG7cllN88liW0hMPYJ663bPZK
	 lT8XvG6ohNP+qR3U4Eb3zrpKzof+CYTXIaKnFvwnjUUZTjlEZ3L6I1wKMlTBN50txf
	 ed60GZVnyq0DuuaBdeLXpl5g/NNulOKLroHl7qjvIj2AzdLQnU8U1VhzcK0oBn3Y8y
	 SFpPv3Lmg9nyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] serial: sc16is7xx: Fill in rs485_supported
Date: Thu,  6 Aug 2026 23:34:45 -0400
Message-ID: <20260807033449.1725763-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807033449.1725763-1-sashal@kernel.org>
References: <2026072914-sandbar-very-7f7d@gregkh>
 <20260807033449.1725763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 267913ecf73745ca3e8fc8282671b0b4f24df5fe ]

Add information on supported serial_rs485 features.

This driver does not support delay_rts_after_send but the pre-existing
behavior is to return -EINVAL if delay_rts_after_send is non-zero. In
contrast, other drivers that do not support delay_rts_after_send either
zero delay_rts_after_send or do not care (leave the inaccurate value).
As changing this would cause userspace visible impact, the change is
not attempted here. But perhaps it should be still tried (maybe nobody
finds that kind of API oddity significant)?

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20220606100433.13793-21-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af071d9e07e5 ("serial: sc16is7xx: implement gpio get_direction() callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3a28331dec407..717ba88a23d21 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1239,6 +1239,12 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 }
 #endif
 
+static const struct serial_rs485 sc16is7xx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
+};
+
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq)
@@ -1326,6 +1332,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
+		s->p[i].port.rs485_supported = &sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
-- 
2.53.0

