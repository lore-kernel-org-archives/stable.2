Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBC471D03
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080115; cv=none; b=dGd44hCFjdQKPOe/glQamL9B2OrjVpdo6lhiX4xVQdFkIpMus64fTKNKYD0fHBjkj9n8ks/9x8XSkAUmOqEhJmcQdCsJx5W/VaF4uEWXd+tsv/qO3qzeUW3HCQobHf1SzRgaNwqbB6MhS/L+kh5+rgCN6GzWBOkumYWUUE8wQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080115; c=relaxed/simple;
	bh=tex/KT0R8L1S/hdQ8NJyp+7lHiatRcXigxiBWWukSQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C72q5Aj0vIfGM73pTn4dWs5+eJlC1EPBpJkWVNLV84hcO0XT9T61aoxrXBa2hLep/H9WmcCHN1HYAqD9iFuJ+q0svRioKsogEs1UZF91aKu0rMygu9fVKBISScDgCRqFL2uwGuSd8yrqdyYx7pjS20IbQ08mgO4HM3KHlAcuEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VDXpmMwJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VDXpmMwJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 17BD31A1244;
	Thu, 15 Oct 2026 16:01:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DAF226075C;
	Thu, 15 Oct 2026 16:01:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 831EF10328B42;
	Thu, 15 Oct 2026 18:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792080092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ssU7XTi+BfG5/GcUZNrJrhUAVwvFZ6ghzUoVfKgt+Ds=;
	b=VDXpmMwJ2uUzBGGyt+JPr2H8EGwyJQl8VHqcIBWwaYNkBkAF70quyTWCiMbaGR1jBn+zC6
	tfVCHU6xFpYB1nXBwfUO/d/S09Uijdm9+OkboCZv4b3lovuxYMZOQShMF1H/207Y6OQeN+
	IOHa3FE5DWdCRSF9nQ92KkNi+C0tZwtNZ/CriwM/SGNiBCpUv81dYra/3AnnWDSrP6T+g3
	Bzw+BWo6Y7gXkniexo8sO8IYpHw+T46CeXRg5G81eFnqf3rk4MSI/goaz4CuAPO7H8ER1Z
	EIRwXNTLC3tgsNQBTrGYJ0w8JRjWZ52NjSsijhqCadRcU+/XblXNpmOTHfASbw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v10 00/10] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
Date: Thu, 15 Oct 2026 18:01:13 +0200
Message-Id: <20261015-perso-ma35d1-upstream-clk-v10-0-47c97b54a809@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTU7DMBAF4KtUXmM0Y8d/rLgHYmE7Y2pBmyopE
 ajq3ZkWCYJSWSxnJH/z/E5iorHSJB42JzHSXKc67HlAuNuIvI37F5K154VQoCx41PJA4zTIXdS
 mR/l+mI4jxZ3Mb6/SmhxzyRi9TYLfH0Yq9eOKPz3zvK3TcRg/r7dmc9l+q0GFhjobCdJ6ozUFb
 Yi6xzQMx7e6v8/DTlzcGX+tdsIZJUpyngxZdIri2lLLXNiyFOdSEEqvVfQJYG3ppWValmarlBT
 JESiIfm11/7a6i6VtcIY7C1jWll1YGlqWZavzQTsim0NKa8v9WAigWpZjK6c+cKRolbvRl19aX
 cvybBFGBBtR+XzDCgsLm30FtrCYzpeo+Av01zqfz18obTfJJQMAAA==
X-Change-ID: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I am in possession of an MA35D1 NuMaker board. The SPI controller has
been contributed, but at this stage it does not work with the current
clock driver.

The clock controller registers its muxes with .fw_name parent data,
which requires every internal clock name to be declared in the DT. As
the DT does not declare them, all parent lookups fail: muxes end up
registered as root clocks and most peripherals read a zero rate.

This conversion exposed a first issue with the WDT/WWDT parents which
were actually missing in the clock driver. I am not using these clocks
myself but it is worth fixing.

The second round of reviews raised another problem with the
crystals. HXT and LXT are external crystal oscillators wired on the
board, while HIRC and LIRC are on-chip RC oscillators. HXT was described
whereas LXT was not. The series now also takes the two crystal inputs
from the DT: they get documented in the bindings, described in the
boards and looked up by the driver (with a fallback for backward
compatibility).

Finally, I was still unsatisfied by the clock tree because there were
too many root clocks. Many "gates" were wrongly set aside from the
downstream clocks they would gate, and SYSPLL was simply not parented at
all (?).

The clock tree now looks much more accurate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v10:
- Make sure muxes registration is device managed like all the other clocks.
- Link to v9: https://lore.kernel.org/r/20261015-perso-ma35d1-upstream-clk-v9-0-1f548fa2002e@bootlin.com

Changes in v9:
- Create devm_clk_hw_register_fixed_rate_parent_hw().
- Use the above helper to register SYSPLL.
- Keep hws[HXT] available in the legacy case.
- Propose myself for maintaining this driver.
- Link to v8: https://lore.kernel.org/r/20261004-perso-ma35d1-upstream-clk-v8-0-e1a106a128c0@bootlin.com

Changes in v8:
- Fix an out-of-bound bug (syspll parenting structure was wrongly
  defined).
- Make sure HXT_GATE is validated before being reused (and possibly
  dereferencced blindly by the core.
- Link to v7: https://lore.kernel.org/r/20261002-perso-ma35d1-upstream-clk-v7-0-cbd991fa6270@bootlin.com

Changes in v7:
- Avoid opencoding core helpers, replace them with existing helpers
  (mentioned by Jerome)
- Rebased on top of clk-next since the first patches have been applied
- Link to v6: https://lore.kernel.org/r/20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com

Changes in v6:
- Drop the clock output names entirely, they are not relevant.
- Error out when the crystal providers defer probing.
- Make sure gates are correctly parented.
- Make sure SYSPLL is parented.
- Link to v5: https://lore.kernel.org/r/20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com

Changes in v5:
- Fix the bindings wrt HXT and LXT.
- Fix the DT descriptions of HXT and LXT.
- Collect tags.
- Link to v4: https://lore.kernel.org/r/20260925-perso-ma35d1-upstream-clk-v4-0-f3697553391f@bootlin.com

Changes in v4:
- I forgot to bump the clock counter in the driver after adding the two
  new clocks in the bindings. Sashiko will keep complaining about the
  incoherency though. Since binding and driver changes should be kept
  separated, I cannot do both at the same time.
- Link to v3: https://lore.kernel.org/r/20260925-perso-ma35d1-upstream-clk-v3-0-ffbae7e020a8@bootlin.com

Changes in v3:
- Drop the number of clocks from the binding, set it in the driver only
- Split the binding/driver patches completely
- Link to v2: https://lore.kernel.org/r/20260921-perso-ma35d1-upstream-clk-v2-0-209fd32a8b00@bootlin.com

Changes in v2:
- New patch 1/3: register the missing WDT/WWDT parent clocks
- New patch 3/3: harden the code
- Link to v1: https://lore.kernel.org/r/20260813-perso-ma35d1-upstream-clk-v1-1-e78e5e6172ea@bootlin.com

---
Miquel Raynal (10):
      clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
      clk: nuvoton: ma35d1: Avoid possible error pointer dereferencing
      clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT when possible
      clk: nuvoton: ma35d1: Reparent the gates correctly
      clk: nuvoton: ma35d1: Use device managed helpers for fixed rate clocks
      clk: Create devm_clk_hw_register_fixed_rate_parent_hw()
      clk: nuvoton: ma35d1: Reparent SYSPLL correctly
      MAINTAINERS: Add myself as Nuvoton MA35D1 clock controller
      arm64: dts: nuvoton: ma35d1: Drop HXT clock output name
      arm64: dts: nuvoton: ma35d1: Add LXT crystal and clock-names

 MAINTAINERS                                     |   8 +
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts |   7 +-
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts |   7 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi         |   3 +-
 drivers/clk/nuvoton/clk-ma35d1-divider.c        |   3 +
 drivers/clk/nuvoton/clk-ma35d1-pll.c            |   3 +
 drivers/clk/nuvoton/clk-ma35d1.c                | 716 +++++++++---------------
 include/linux/clk-provider.h                    |  13 +
 8 files changed, 293 insertions(+), 467 deletions(-)
---
base-commit: 6b78cda327cc2dbcd0e60f411ae014997a684b55
change-id: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

