Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458993644C7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974105; cv=none; b=JJs4isugQrbqV/Bdm/hVIsUV3ZEsnQxLTEcQq/NCVIiquJ2HgS4w/E005XzNOXHzeUfJENRBiZtRV8QBoErw56dlhfLcAMLXZTW2m0ljTNyRb7G19BwWw52KxWDIQYy6Au4gw/ECWnAgAa3JgP3ZB/hxmzdM55KKr3hTfgA3qQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974105; c=relaxed/simple;
	bh=p36NGXk1J8EytNin7TndrbQlskhsZ5tsoRwtGo+R9ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw+R1+u9OMfQFTixxCDCweKDnY1xYwDQInWHEfgQZKTulOb6dU8ylCeVFdM0yQFCMhBlm8PYPeT+nMHx5jcnHd5mreJcDmR7uriG8nsqCtVj8Et01KuD7MC+QQpVn5NNz+M0MOgIdFnmYZzBlUIhlkFY+mxGLPgQ020NufkRGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stj3nyOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stj3nyOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E8E1F000FF;
	Wed,  9 Sep 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974103;
	bh=tiROQF+wt5Jpx8gZCiUw2QSVL8rdiuCALorQiNImbUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Stj3nyOsIlE3/FJ7TBLeEsFBXl5USN9AFHGfFItqDalM7dRa+KJLWjXmqqRv0TEvp
	 XRZhT1f+7eYNhfaT4j5cH4qOKl8vkrMNhqGtUZ24+JKQol1NkAHa2Xj4NGavqdn4In
	 8f/YfaNm7hATWByTi8N2Rw0m17W6/QQbgbVZGMG3DQUn3OcRoutg+vDb1vRzsi5x2s
	 7gj1w+ffq/ZNWh3jirImSkiGxISplOqzSSSs+0UddujaI9bfdKCz31qTeJUfmpEgBV
	 sPKwJX3txqFWsFDlY82UcrDQZAs9guIe5hJIEak9GjKwQMSnpy8tRJ7jFxy64EXv+z
	 ZI1auBV5tagmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO
Date: Wed,  9 Sep 2026 13:15:00 -0400
Message-ID: <20260909171500.3236319-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-refreeze-maritime-e230@gregkh>
References: <2026090351-refreeze-maritime-e230@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit fb58b6a696b30bcbfbe0cfc0a91b19c816a955fc ]

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
Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Link: https://patch.msgid.link/20260814110102.2362246-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted rtl83xx.c reset helper changes to direct GPIO calls in realtek-smi-core.c probe and remove callbacks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek-smi-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek-smi-core.c b/drivers/net/dsa/realtek-smi-core.c
index 6bf46d76c0281..289b83214e6f3 100644
--- a/drivers/net/dsa/realtek-smi-core.c
+++ b/drivers/net/dsa/realtek-smi-core.c
@@ -425,7 +425,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(smi->reset);
 	}
 	msleep(REALTEK_SMI_HW_STOP_DELAY);
-	gpiod_set_value(smi->reset, 0);
+	gpiod_set_value_cansleep(smi->reset, 0);
 	msleep(REALTEK_SMI_HW_START_DELAY);
 	dev_info(dev, "deasserted RESET\n");
 
@@ -469,7 +469,7 @@ static int realtek_smi_remove(struct platform_device *pdev)
 	dsa_unregister_switch(smi->ds);
 	if (smi->slave_mii_bus)
 		of_node_put(smi->slave_mii_bus->dev.of_node);
-	gpiod_set_value(smi->reset, 1);
+	gpiod_set_value_cansleep(smi->reset, 1);
 
 	return 0;
 }
-- 
2.53.0

