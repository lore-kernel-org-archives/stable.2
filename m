Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FF4E36D0;
	Wed, 30 Sep 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789127; cv=none; b=ewF9mESfVPqXAX/MCuL6nvh54XBCopLLPzn69kRwAh5GkdXeBliRu/Pbxr2dYgmb81qIFzYAH3MkZJPrceJj7a/I/4h9q2mq0mWObNC4MjB0a/XAeBGl+pm3N0fXULuoOBmXM8KPmBuD686Utj1FmIXubQ8wSY052IIPkH/HrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789127; c=relaxed/simple;
	bh=9TbQFctVtnJONPkvVyxdkrPwktkUUjJY/iQeei9VOHE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A8dP5VCo9xa2xvUMRncYYRBXQ95pWqSpqn5lVEKFkNqCaM2KD9rYFg3oXnxIFeITf4WFCcmqgAEGkKHKhWhGMjWiGEdjq8+47J94csKWFy8dSzAcXdiUVoFQgTUJMxWKC6I3zJVGUttMUjgVWkccorr+1pkRcCFon9w13frZxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GSGgLhE2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GSGgLhE2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 73C0F1A107A;
	Wed, 30 Sep 2026 17:25:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B71C60749;
	Wed, 30 Sep 2026 17:25:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B43F110328A02;
	Wed, 30 Sep 2026 19:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790789116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=L8/OODqwok8+iyAtj/XZzViXaiQxHsPKEsXS6DG3Xq8=;
	b=GSGgLhE2bvk/588d85GTM9KlFlwOVg9/UtzISuHcLNPVHxT30hdlFGR+secNCLrkgczG5M
	IWORn8JTp879B1BNEaOPMOLbj6A4V5+bdfPMNgo8u73sUCdyKRP6pKXnYEL9+r/vNd4Ix9
	kuvPxm7zqurl/NTx1xWPKklHVlvVMbKUTfSrfgPxYDVopgqBNTICmOi043Wy1ix/nGa0I+
	qJ/Dqmr9fSNEZZBOY3E6KaeqSPouSG9AVQnqAc6Asg+AHVLuv+nANqZ78ySHpHpr0qRK2e
	QOagn8NAmp3mS38JV5stOcnUgullb9r0n5t61WpoZMXHMpC9Z9/8YIWKZPJMNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 00/12] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
Date: Wed, 30 Sep 2026 19:24:46 +0200
Message-Id: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTWrDMBAF4KsErTNFP5YsddV7lC5keZSIxJaRX
 NESfPfK6aIpBpPlG5hvHnMjGVPATF4PN5KwhBziWIM6Hog72/GEEPqaCadcUc0ETJhyhMEK2TP
 4nPKc0A7grhdQ0lnnHbNadaTuTwl9+Lrb7x81n0OeY/q+nypynf6qhpsdtUigoLQUAo2QiM1bF
 +N8DeOLiwNZ3cL+rP2GhQEDbDVKVKzlaLcWf+zF9ixee3FqfC+41R2lW0s8WnLPEtXyvrPYIuX
 U6q3VPG01qyWUaWX9mWH+v7Usyw8cTqic9AEAAA==
X-Change-ID: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jacky Huang <ychuang570808@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
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
Miquel Raynal (12):
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Document the missing crystal inputs
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
      clk: nuvoton: ma35d1: Avoid possible error pointer dereferencing
      clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
      clk: nuvoton: ma35d1: Reparent the gates correctly
      clk: nuvoton: ma35d1: Reparent SYSPLL correctly
      arm64: dts: nuvoton: ma35d1: Drop HXT clock output name
      arm64: dts: nuvoton: ma35d1: Add LXT crystal and clock-names

 .../bindings/clock/nuvoton,ma35d1-clk.yaml         |  16 +-
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts    |   7 +-
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts    |   7 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi            |   3 +-
 drivers/clk/nuvoton/clk-ma35d1-divider.c           |   3 +
 drivers/clk/nuvoton/clk-ma35d1-pll.c               |   3 +
 drivers/clk/nuvoton/clk-ma35d1.c                   | 723 +++++++--------------
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h     |   3 +-
 8 files changed, 287 insertions(+), 478 deletions(-)
---
base-commit: c5137d373338693fc18f03824782c7d383bfd57a
change-id: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

