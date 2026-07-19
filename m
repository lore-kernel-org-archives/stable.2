Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4923812E4;
	Sun, 19 Jul 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454310; cv=none; b=SvyKC/ui9Ly16+FVtQ/D0o6/63ITYEQ1QqziRI3X4jdG8WAUDF1Go/jJ271PSGxhg0W2GLqJqc63egFtGt76w0If7hwyHWysh6sW8oBehEtiu4M2CTqoiZNl/ZjIvNsndsg4qZ/Mu5ApZI716jdDBrPibdMOt2rk9WkfKmPQsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454310; c=relaxed/simple;
	bh=7XVb+aWZavzvQpvvndZ+LSfqnfl+7g29MbheipKJ8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwPuYZL5HraQekc4DfYtZuPt0YahjBf9LnFgyRBZKhQrwZ06Mmzk3X8V3z8CHPp8058vtma1Z0Wd/rewW21PVOGdbFctulIuVVnMmufkYxhJmU2ROu50H5TRg0HQCckKnGFE8wZHyNgNc7FlGzkjGcy3DQnHtUaFhnfrVSdRPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IADQy3uU; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CRSyoB/Z; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IADQy3uU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CRSyoB/Z"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h2zJr10j1zKn7K;
	Sun, 19 Jul 2026 11:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784454300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3LNAIyV6C/kCfkSIjYEVhDnFhKOD8ilH36CMkTJD3bU=;
	b=IADQy3uU3UdXp/KqwdTAzzsW+AHWpy2l235NFVSa4SvaQicKpLhZgmuzmtnqBWtjut34im
	bd5Y7PhLh/33s0DO8u9QugmsdaS8G+qXZXTnJq4qn44ykwVdUr53fmER0BCOhU4lLGOMSd
	7+318D0GR2qMCoYICsP68hFxLgh3hM/Jj6f8fNHJdeoPR7ouSuj9rcqvn51K52RokPeRF/
	lox9GE5DvLeznJIeA5dHDa4nIbpii9K89OAgn7+++lUn2qIocCIVoT7PFQeX9Gx0ReCqia
	XEh3b26VSyjzpco9WoHVpY8oOBla+UGsK9oqPMM5wAgHxWQC6gvs6x7tMLUZQw==
From: Benjamin Boortz <bennib@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784454298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3LNAIyV6C/kCfkSIjYEVhDnFhKOD8ilH36CMkTJD3bU=;
	b=CRSyoB/Zu3MbzjI+iWEVej6njA6+4ihQkPg9tZmPxyuH2ZuIXCKQoGKA/xCB3phDX6PysU
	qFbAZ33EE7y8aGc/g8MIqjLO6ZyNyyS1zoeRNfGdxccS8SstLe7j10d7trGt9d9YYOjo+S
	pSOv2V39fMs/fPedBO3/zSL4IkSeKZ9Xh1AlO7+IBANoXbCbX6i8Fs43TgZpJsEaQ1J3iU
	/c45uVlYpQ6BhnTw5a9BNE3eao56/9L1zJRZNQvd0fff9yjHrs6diMSAKfKawhUv6V1vRp
	1SJFEfbeWvp6TI4Ap7irc/QktUM9LjHXd1PsqghUZCbam9fxzKDrukA7r2T+og==
To: linusw@kernel.org,
	andy.shevchenko@gmail.com
Cc: lee@kernel.org,
	vladimir.oltean@nxp.com,
	colin.foster@in-advantage.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Benjamin Boortz <bennib@mailbox.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2] pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
Date: Sun, 19 Jul 2026 11:41:46 +0200
Message-ID: <20260719094427.1328725-1-bennib@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 28842fe07a6ab262c79
X-MBO-RS-META: sbtoftzcxn4919kxjc3aupafnoccsg5h

The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
The Kconfig entry does not select REGMAP_MMIO, causing a build failure
when no other driver in the config happens to pull in REGMAP_MMIO:

  include/linux/mfd/ocelot.h:34:24: error: implicit declaration of function 'devm_regmap_init_mmio'

Found by randconfig testing on arm64; tinyconfig reproducer below.

Fixes: 2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Boortz <bennib@mailbox.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
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

