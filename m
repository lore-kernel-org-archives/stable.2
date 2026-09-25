Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22794C10D6
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349042; cv=none; b=VlZ1TX9nHIB+9krrO58gukAw5fl3iDrpZXdlFmbtFhcSRUOV7+1LJvuUxoYACsTWDpuTUKxrQD89R+sd4oTOngPv1i5f6Fne2fztVzT858rRrmbg8jQkIhaMN0JfWR1HTLNc0277F/D6Zl1yE6EAIgI/21ZMLq5bb1r8QSodl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349042; c=relaxed/simple;
	bh=zjyT7VyYxW1CNOalWDJL3MdwN6aeRPcYEnsR/ZE02UY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OmCtQLYllvF5peIdcC78JDU9z/lN0MprVxNziMiVCCShDVdQE6bzk/HZ8CmQwlr4PRHoiRHTmOR0u2jjg9VIFI0sug7QC6BCwQu80w5255HnbRPkzPBQKHUg3pPFWIIbeurR2Y0AQ6zKDbJ+dZW4k1CsX+KNaV/bMrT25qR/VbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xH+riAv6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xH+riAv6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18873C653F4;
	Fri, 25 Sep 2026 15:11:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 047CE6073B;
	Fri, 25 Sep 2026 15:10:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7065102F1E06;
	Fri, 25 Sep 2026 17:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790349026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Vn9Tr1xJolmW78wFJwJBHDNHE9ScFHG6XbXCr7p2L1I=;
	b=xH+riAv6BzpC1AWsFzrgHy/CY5OTEaPn3DPpChJIqwQ1yv3bIfCPqdr+MrvczE1E2vorMn
	d1/q/lnFepS5gHO1toFZNpVjgFncp1zNfzVlKA0ZUdkvdfE2qORwZ1ujvyP2ySZGn9LTsD
	OF6wDBiU/Yy1Pn7wY7rMUfX10vANI6CFQrluiSGyiXl4F4+Ei+sCVJA6FUu8wuL8s3M3Fy
	Oc4Shz3Y6u3aG6WEAYq8hDB+Lro6TAssVP2Cmfc7K3qeSlx1QGMp70HqNdoYK8kOMcmEw4
	QpCDw7qazWvbxXdLPmcZv5nwLuwdeC/9wPY37NRn/flTS7DPua8hqO0uUVuRLw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/6] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
Date: Fri, 25 Sep 2026 17:10:10 +0200
Message-Id: <20260925-perso-ma35d1-upstream-clk-v4-0-f3697553391f@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQrCMBCF4atI1o4kE9tGV95DXEzTiQZtU5JaF
 OndjW5UBHH5P5hvbiJx9JzEenYTkUeffOhyLOczYQ/U7Rl8k1ugxFIapaHnmAK0pItGwblPQ2R
 qwZ6OUBaWrLOKTFmLfN9Hdv7ytLe73AefhhCvz1ejeqz/qKMCBVwZLrhUFTJt6hCGk+8WNrTi4
 Y74slaoflkIElCuXKORTC3lt6XfreKXpbPlXE1csURJ5tOapukO4SemBFwBAAA=
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
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jacky Huang <ychuang570808@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I am in possession of an MA35D1 NuMaker board. The SPI controller has
been contributed, but at this stage it does not work with the current
clock driver.

The clock controller registers its muxes with .fw_name parent data,
which requires every internal clock name to be declared in the DT. As
the DT does not declare them, all parent lookups fail: muxes end up
registered as root clocks and most peripherals read a zero rate.

This conversion exposed an issue with the WDT/WWDT parents which were
actually missing in the clock driver. I am not using these clocks myself
but it is worth fixing.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
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
Miquel Raynal (6):
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
      clk: nuvoton: ma35d1: Avoid possible error pointer dereferencing

 drivers/clk/nuvoton/clk-ma35d1-divider.c       |   3 +
 drivers/clk/nuvoton/clk-ma35d1-pll.c           |   3 +
 drivers/clk/nuvoton/clk-ma35d1.c               | 642 ++++++++-----------------
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h |   3 +-
 4 files changed, 199 insertions(+), 452 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260813-perso-ma35d1-upstream-clk-65cacfc1a86b

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

