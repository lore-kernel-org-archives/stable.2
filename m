Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539120;
	b=wyX7Dm4Nv3NM2Kr/opYJa9cDuOqmETz4vyG3oXvQh1599+KLvXGkwd7X5BccIH0hJNzR
	 BQjHtiJZWRgJU10pjnB0O0RmaWD5RUfZil/+XsRy4DveCb1EEe9WhDY/cd9nP9tk4HvI4
	 q7CRrnHiORYIknxc08FbJuzceD90Tltmspiagm1tE3i92DsfmdYl/yROr9l4YpasFCbGx
	 K/tPpQLbVeOhUHMg/hhwprsvdqCf9B9/RoC1belRAazZIkbUmErEu7N121vZH4eKJgx19
	 LEqlODO1qiso5B7W1G0oyVh0pO5AqPOSEdmsS0RTS7WAiPgCuW6hNGg+yjl05r3LOlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539120;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=JCMRNLCXtjAixKYiY0U1Z6bAmyp64/cEbJSr4K8irp0=;
	b=vAPtAHB++LKBnB12/VZPDesA+ZYLMSiuwzyVRqAiJKiiJ9IeotXjsp4QiL3KsleEKhal
	 FWsry8rtR8pgZacH0L2Sokltg1iUv91HuIO8CVrHZCVelOOsVWaHLwhZCadBwFZVY1NlH
	 kpzyzx43aF4YXKv6H1erCEtQp14WD8KSRxxouf6dmiEMjKJ9XgB3wBLCcxjalQYCfw/Z1
	 B1n/BN7ek/ehvAGswO0ZY19wRPfZQsAj+hKmLKm6K+37NSc71lNf/C3rxnp2XKKVQVxJL
	 Kvrs/2fRfqPOxM4yLkKAVQ/I/1lAC5zcyAfoUfLcqw2bOVwPEEeOkHaBCs3/Bi3JFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1dC1xdIB;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE1606A32A;
	Tue, 24 Nov 2026 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3AE1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1dC1xdIB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 25E291A17A4;
	Tue, 24 Nov 2026 16:51:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3D60601E1;
	Tue, 24 Nov 2026 16:51:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 628CC11E694D3;
	Tue, 24 Nov 2026 17:51:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795539108; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JCMRNLCXtjAixKYiY0U1Z6bAmyp64/cEbJSr4K8irp0=;
	b=1dC1xdIB51jeovzPjBjMheF06Xdo8/PLae8qAQAeaL6OnlrncczAdrXxXsZDDMhf3Auwe0
	MvtF1EeSKo3+Td+ra+qhZgOpJQkIFeWDnd3qVxni2uyjoZQivPLsfrJJlzrb2nQx4j3mU1
	6rPPpn2CzxFng+8WxBIvNXHb1tonQ9U4WzaWh6smJfD7dgTgD/09AI5MMHwj7kKssQZFYB
	2JyjDkcNmBOgg9PrcaYehdplWKlqBtRN6vDkw2ufyAwwlB+EO31kL4epeIWD30AJVlm0pO
	OFg965oP1Qf8ALLVn5MmapDIAW3D4A508CIqO1UDDF8CfnPWR6OuM6kt2HcooA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v13 00/10] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
Date: Tue, 24 Nov 2026 17:51:25 +0100
Message-Id: <20261124-perso-ma35d1-upstream-clk-v13-0-c920f4a9f0ce@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43SS2rDMBAG4KsEr6syo7ey6j1KF3qMGtMkDnZqW
 kLuXjmFxsVGZDkD+jT6NZdmoL6lodluLk1PYzu03bEUKJ42Tdz54zuxNpVGw4FrsCjYifqhYwc
 vVEL2eRrOPfkDi/sPplX0MUf0VoemnD/1lNuvG/76VupdO5y7/vt216im7q/quKuoo2LAtFVCk
 BOKSL6Erjvv2+Nz7A7N5I54t+oTjsiQkbGkSKPh5JcWn8+FNYuXuTi4nAT3NgAsLTG3VM0Sxco
 5eDIEHLxdWvJhS06W0M6okpnDvLT0zBJQs3SxpHXCEOnoQlha5s9CAF6zTLFiSK6M5DU3K3nZu
 SVrli0WoUfQHrmNK5abWVjNyxULs5I2e16eQCv7BQ9jCFNiJjoTlPQW3Ip2X1dEtFUNixYSJiS
 Y/l2vaPxxbdrYQMSjTT5Jwv/a9Xr9AVY1YUAPBAAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
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
Changes in v13:
- Collect tags.
- Add a guard asked by Jerome in the clk_mux() helper.
- Fix typos and correct the MAINTAINERS topic line.
- Link to v12: https://lore.kernel.org/r/20261118-perso-ma35d1-upstream-clk-v12-0-bee2c8dad4e1@bootlin.com

Changes in v12:
- Rebased on 7.4-rc2 because of the treewide allocator change, fixed
  patch 3.
- Link to v11: https://lore.kernel.org/r/20261118-perso-ma35d1-upstream-clk-v11-0-bd1d1e060926@bootlin.com

Changes in v11:
- Add a patch to fix the CCAP mux bus width.
- Add comments stating that the HXT and LXT IDs are legacy clock IDs.
- Collect R-by tag.
- Dropped the DTS patches from the clock series.
- Link to v10: https://lore.kernel.org/r/20261015-perso-ma35d1-upstream-clk-v10-0-47c97b54a809@bootlin.com

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
      dt-bindings: clock: ma35d1: Mark HXT and LXT legacy
      clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
      clk: nuvoton: ma35d1: Avoid possible error pointer dereferencing
      clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT when possible
      clk: nuvoton: ma35d1: Reparent the gates correctly
      clk: nuvoton: ma35d1: Use device managed helpers for fixed rate clocks
      clk: Create devm_clk_hw_register_fixed_rate_parent_hw()
      clk: nuvoton: ma35d1: Reparent SYSPLL correctly
      clk: nuvoton: ma35d1: Fix CCAP muxes bus width
      MAINTAINERS: Add myself as Nuvoton MA35D1 clock controller maintainer

 MAINTAINERS                                    |   8 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c       |   3 +
 drivers/clk/nuvoton/clk-ma35d1-pll.c           |   3 +
 drivers/clk/nuvoton/clk-ma35d1.c               | 719 +++++++++----------------
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h |   2 +
 include/linux/clk-provider.h                   |  13 +
 6 files changed, 284 insertions(+), 464 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

