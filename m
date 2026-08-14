Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0F4582EA;
	Fri, 14 Aug 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705288; cv=none; b=JmXnPUYcuCICDJ0MTB/BanhB05pgIWgGcic9fso1YAGsYoajjUVA3C3hs7IBFj+uY55a2z3ULrsqc3LWN+N5uD7xptSVwWWhVRpNmcdbLwI+Vi+YmbYAzYo2Hj3HI6HWtx2YyW22rJHQSGs7EABC1+OMc3ol8kx0CO+60M47qTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705288; c=relaxed/simple;
	bh=0ghVpFavg1/uLlMHIuze0nLyf4DDxLIRKpsZBa0Bw+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kr73oSoWQ9B9f8B8xF40CaqpJAK8F3326lfw6H6ZzZAifv6IT1lmd9cO8cQd8hoJaCBZe87gE1iN6Q5cZF9akSyrUPrJ2USGVs/xmHnJ7JRSbGU7k8Cxf2k465q3woN0IUNQYzzhQG8suoQ3jOhG4k7BcYQJTQ6RqpaE+81ut1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7F9212021EB;
	Fri, 14 Aug 2026 13:01:03 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wupep-001RYy-1H;
	Fri, 14 Aug 2026 13:01:03 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wupep-00000009uX9-1HEL;
	Fri, 14 Aug 2026 13:01:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v1 1/1] net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO
Date: Fri, 14 Aug 2026 13:01:02 +0200
Message-ID: <20260814110102.2362246-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
the probe path, which may sleep and is not timing-critical.  When the
reset GPIO is provided by a sleeping controller such as an I2C I/O
expander, gpiod_set_value() warns:

  WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#1: kworker/u16:4/61
  Hardware name: B&O MAP CA33 Rev f (UNKNOWN) (DT)
  Workqueue: events_unbound deferred_probe_work_func
  pc : gpiod_set_value+0x44/0x80
  lr : rtl83xx_probe+0x1d8/0x3a0
  Call trace:
   gpiod_set_value+0x44/0x80 (P)
   rtl83xx_probe+0x1d8/0x3a0
   realtek_mdio_probe+0x24/0xa0
   mdio_probe+0x38/0x78
   really_probe+0xc4/0x3e0
   __driver_probe_device+0x15c/0x1b8
   driver_probe_device+0xb4/0x120
   __device_attach_driver+0xb8/0x1a0
   bus_for_each_drv+0x88/0xf0
   __device_attach+0xa0/0x1d8
   device_initial_probe+0x54/0x68
   bus_probe_device+0x38/0xa0
   deferred_probe_work_func+0xb8/0x120
   process_one_work+0x184/0x4e8
   worker_thread+0x188/0x308
   kthread+0x130/0x150
   ret_from_fork+0x10/0x20

Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
be used without triggering the warning.

The reset GPIO has been driven with the non-sleeping gpiod_set_value()
since the driver was added in v4.19.  The call has since been refactored
across several files - from realtek-smi.c / realtek-mdio.c into the common
rtl83xx.c module and then into the rtl83xx_reset_assert() and
rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
applies as-is only to kernels that carry those helpers (v6.9+); older
stable kernels need the same gpiod_set_value_cansleep() conversion at the
corresponding open-coded call sites.

Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/rtl83xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 09fd64880232..8121ec12fd8b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -334,7 +334,7 @@ void rtl83xx_reset_assert(struct realtek_priv *priv)
 			 "Failed to assert the switch reset control: %pe\n",
 			 ERR_PTR(ret));
 
-	gpiod_set_value(priv->reset, true);
+	gpiod_set_value_cansleep(priv->reset, true);
 }
 
 void rtl83xx_reset_deassert(struct realtek_priv *priv)
@@ -347,7 +347,7 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
 			 "Failed to deassert the switch reset control: %pe\n",
 			 ERR_PTR(ret));
 
-	gpiod_set_value(priv->reset, false);
+	gpiod_set_value_cansleep(priv->reset, false);
 }
 
 /**
-- 
2.47.3

