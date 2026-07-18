Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9970836;
	Sat, 18 Jul 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784410709; cv=none; b=N2K2TnhEJaZl7gxRtEhxFzpaZklDMDp43Nt/8OKwf1mRFySRnssLo7E3E38Z/v68M+ZjVGGlENEjri3zr3POMwNS/Dj3tFDiAPjL7gQeZzD/Cx0Ayc7YdfPMijrMPkbg6wGkXp4BEXGvuoIlyBzdDT5nKru43nZmrPUex0iWTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784410709; c=relaxed/simple;
	bh=OTfzyKQ7+oCD1jpnlmlq0O1dWNXiT6pkFts+V4CBv7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z75AZnH7CnSkGUVjk5jvXbn0ylK/y0+p1mTWp5ctfYcGd3tC3drk0OUboga+xl1OF/VqTrYOC+veraQsLzrLMsY89EvuIr0+ljkIOkTYTyGRsEPUBFMYyV8tMhMRd0BeBkJBi25EMYGFYzJ+lXmJTUAygtvy8/dqjLq/IYNiuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bx/4U/R6; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D5mzjP1h; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bx/4U/R6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D5mzjP1h"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h2gBT4jMczKq6c;
	Sat, 18 Jul 2026 23:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784410705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2sznBgGicK/LYhOMmvPfuquDqZpSQCSAOYd1pIJIztU=;
	b=bx/4U/R6TOJZKLu0+buETkLFlv+J8dn32nZA3eJGDCGtzuujt4pE0kwz2XPGxiQF02zRHw
	nQpzFDBb5jHnZ4N0nbKxnyTzQelgx3M4VKEeUy6D44NqAsNRSyWFwi8CfTPsIfJ2/QYULG
	txYoHQu03rBpcOLgr8UDyOjm4pbAe4+Lba1sA3UxdSyRBSwIT4fCj8dLFuDlXFkDufiENw
	xFdh2JodyXyiQ2BrPVNLb4fWeBZmBa61foyE0eExoqUib6hBCcoARFmszfOJgeE9jzla99
	nWOubtnCqXp2BulveV/z6P2NjLUkFbvFKTD/3GloOwQzfjUo48mElbHXlrxEQQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=D5mzjP1h;
	spf=pass (outgoing_mbo_mout: domain of bennib@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=bennib@mailbox.org
From: Benjamin Boortz <bennib@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784410704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2sznBgGicK/LYhOMmvPfuquDqZpSQCSAOYd1pIJIztU=;
	b=D5mzjP1h/j5S2y7G2aqguBhTjY2wmFsZGTnKvmsxWhB/0sgJGYo7ZbCGqHGB77cfqw4rRs
	hbQKd7gqrvexe/VOfqX0sLGVM0s4vuor9ZXheI56N8weDPvqARtfneNe2uRZBaGPPMosTo
	iq4APGJVreK3eNTOx6KzCJGa66TEkLF4dEEPQQM6cZKmAtOfhqQibZxpi6yLUcQixk26ex
	r+mN6vGBD6CUMllqWL+TL7t1fMAM8amxL+nAvaU+HFQo2a4mKx6Xv3Qzf+tcc9MvcKyW0q
	cIhnQ9Zb1MvIxnZAg95/+vhBVz7Cdc7CWVbNYxcHd1/2jnvfc9g/pK4RZkG6Sw==
To: linusw@kernel.org,
	lee@kernel.org,
	vladimir.oltean@nxp.com,
	colin.foster@in-advantage.com,
	andy.shevchenko@gmail.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Benjamin Boortz <bennib@mailbox.org>
Subject: [PATCH] pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
Date: Sat, 18 Jul 2026 23:35:15 +0200
Message-ID: <20260718213738.2470294-1-bennib@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ed84a9c939c8868e3ea
X-MBO-RS-META: beiuuyrqrmnu7seahqze71diiu15kkfm
X-Rspamd-Queue-Id: 4h2gBT4jMczKq6c

The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
The Kconfig entry does not select REGMAP_MMIO, causing a build failure
when no other driver in the config happens to pull in REGMAP_MMIO:

  include/linux/mfd/ocelot.h:19:51: warning: 'struct regmap_config'
    declared inside parameter list will not be visible outside of this
    definition or declaration
  include/linux/mfd/ocelot.h:34:24: error: implicit declaration of
    function 'devm_regmap_init_mmio'
  drivers/pinctrl/pinctrl-microchip-sgpio.c:910:16: error: variable
    'regmap_config' has initializer but incomplete type
  drivers/pinctrl/pinctrl-microchip-sgpio.c:911:18: error: 'struct
    regmap_config' has no member named 'reg_bits'

Found by randconfig testing on arm64; tinyconfig reproducer below.

Fixes: 68c873363a78 ("pinctrl: microchip-sgpio: add ability to be used in a non-mmio configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Boortz <bennib@mailbox.org>
---
Reproducer (tinyconfig, arm64, without patch):

  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- tinyconfig
  scripts/config --enable CONFIG_PINCTRL
  scripts/config --enable CONFIG_GPIOLIB
  scripts/config --enable CONFIG_PINCTRL_MICROCHIP_SGPIO
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
      drivers/pinctrl/pinctrl-microchip-sgpio.o
  -> CONFIG_REGMAP_MMIO absent, build fails as shown above.

 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c2cdd7b2c49b..23ea76dc6261 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -426,6 +426,7 @@ config PINCTRL_MICROCHIP_SGPIO
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
+	select REGMAP_MMIO
 	help
 	  Support for the serial GPIO interface used on Microsemi and
 	  Microchip SoCs. By using a serial interface, the SIO
-- 
2.55.0

