Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE722579E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070165; cv=none; b=M/RnN4j06Cv1mn1rRwME4DMFPhpaD8qOdPjmCR9Nwb1WhI6yLXbfaIGJbXNXsH5KuFu/EG+vsgRqBc+1cbsnGT/gvZ78gK/6pWX0zgTW++zxK5g9xdtU8t//ZIW2bXewDaDmQQAQ97F4BUf3/YAUEd9SA26O4yob6v/uGm17RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070165; c=relaxed/simple;
	bh=HlLCCqGCwlypcfekbqivJJo5hpJU/1cqkV6/edupeo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bllfYOFCZYJPyeIOnSD3UhrkfgMWCNm++NcHcg3b5G6frnlbs6QUUwvbh5h3LQ8AQg0KC5XO63sAmNn/XQLfbqTVpcvROEPDW0evN0wJghQhG0oezu03nH4lnpQv413lohigk6ayXGyRPOC4Mw+FQKY5Ibg8zo00Cg7tsiXZmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPX14UkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPX14UkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F611F00A3D;
	Fri,  7 Aug 2026 02:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070163;
	bh=cUjASWec9NmVbNnfrsE08aLvjH4igHYcOPq5n1vd2BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPX14UkC0tpQVBAIDfh5UENJ5u4lBN/QMBbLIyvD2RmWzvbUobTosMjbtoNXsr6iH
	 iPsr2pzaigItIg6674IX82pTH/DIoIKN+KvJB9HjKWr9qIegzpMfGwANcsE8vz/e1r
	 auu4yncojVyvSzzQK3m8VQaoJ0A9AHdSicCakFApGXuEAqiNUDFpvANvxCe9pzcq+G
	 p19ERgHjvZwbDn3FQID32Bj70fayxrFmcUCSsIgOKjvIR48z2TBVpi/AfElu2uZbBA
	 MvqyEM/ckaZy/XdFoTUXP//0ZJre7mWt4dfJKF9GaTFUQwpyT0yKrgtHqIpYSfzX+v
	 HuWyGmJPtPvKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] serial: sc16is7xx: Fill in rs485_supported
Date: Thu,  6 Aug 2026 22:35:58 -0400
Message-ID: <20260807023601.1683108-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023601.1683108-1-sashal@kernel.org>
References: <2026072914-stainless-finishing-0e3c@gregkh>
 <20260807023601.1683108-1-sashal@kernel.org>
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
index 46aa2073b992e..81407e1c1f015 100644
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
@@ -1328,6 +1334,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
+		s->p[i].port.rs485_supported = &sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
-- 
2.53.0

