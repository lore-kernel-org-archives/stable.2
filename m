Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460A34A3BF;
	Mon, 13 Jul 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966724; cv=none; b=G+EsNslmPbTfUSP19auUJAThSdcHE9dQYzmNkM+SFq0nWnNLH8fm1fFDB+oLr3/0QQSXThfYrZbbNoFPe69Naeq/P++gJof8pb95fcVm42Z7e3a2vuhMb6YTFzvoAIaEzO7a120jBsLdHMlLeNECHWtZwHXV/HpejAGWvKBU1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966724; c=relaxed/simple;
	bh=MW0fHm4TEwvAk5mUjhZ7QSZSJF8LLYeJTbTRWroVGJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dcM58BzIxCTKgYx7iUFPT90ZHDCfh5F6ytnBwUr9QlcHUeV3c1uaq7SWGNvJvTfHtG1zXXIcgJnYC6Bs1lDf+tRlrOORLr+oBTwBbmciNfDMWhGCL3OhhpbBaRUKdAYfZxpodwUd23RUWWEg5dg1JA/S+/Ab1i2rNtDGkGoGiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HP9/4s5G; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HP9/4s5G"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 3D2728346D6;
	Mon, 13 Jul 2026 20:12:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [91.160.0.144])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 009BAB0055A;
	Mon, 13 Jul 2026 20:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1783966345;
	bh=MW0fHm4TEwvAk5mUjhZ7QSZSJF8LLYeJTbTRWroVGJI=;
	h=From:Subject:Date:To:Cc:From;
	b=HP9/4s5GL7nJJXLSYkAF+NqAQsUFE9JtmkJnD8cU4E0lmuJT2TZTQiygCb+inNRRZ
	 Z2WTVMEI2JpxTwiI2gTOo3k8Z+mkGkLH9ZNwIZOzbqXm8xdh/RVktt9ZH5GTBNKH3k
	 NBehoNisOosZP2h0hHq4oLvPWFbpMTM+gq2pO3mtYi4Thz8Juvgh3dn3D6wzpV79z/
	 Uc4YzUjDsztG80b5lgGRL2g6M51MwmwcVjgSmK/gaEnPEt/gUqDnQwUqxDnyt+OUrd
	 EVn7K/rpxEpFr7YRTWomdJnsP9EE2ItGY4Kp+vkX4GCF5pUTGq1f4C8K9BIGwyrvbh
	 pUvnksAgC3i3w==
From: Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the bus
Date: Mon, 13 Jul 2026 20:11:58 +0200
Message-Id: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4qVWoC/5XNwQ6CMAzG8VchO1tTugzFk+9hPIzRyRIV0uGCI
 by7g4tXPf7b5PfNKrIEjupUzEo4hRj6Zw69K5Tr7PPGENrcipAqNGTA9wKvIY7C9gGBHNwnKis
 EHyZIJaBrLFrEWrNRGRmE82cbuFxzdyGOvby3vVSu15/pVQev0TZGt219cGcvzHsvaoUT/YdRx
 qiy2rmja9GYL7YsyweAWWSWFwEAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
 Shawn Guo <shawn.guo@freescale.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org, 
 Carlos Song <carlos.song@nxp.com>, Stefan Eichenberger <eichest@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783966324; l=1860;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=MW0fHm4TEwvAk5mUjhZ7QSZSJF8LLYeJTbTRWroVGJI=;
 b=HB4/D489cBV9RGeIlXnJ5L0Cx4Oci/dGh9tVchNtz7Ut6n2ixBh23Cwbk1Xta51rz/iUbqwun
 XJ6O0CjdUAgD9GB9UUz9/kcWL1vmAwrDWZ2G2qkSXTeEdIDKXhaN4Oo
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=

i2c-imx rejects an SMBus Block Read byte count of 0 (valid per SMBus 3.1
6.5.7) as -EPROTO and returns without emitting a NACK + STOP, leaving the
target holding SDA so the bus stays stuck until a power cycle.

It was triggered by an MPQ8785 PMBus regulator on a LX2160A i2c
bus: when the kernel binds it using the pmbus/hwmon framework, the bus
locks up and it does never recovers. It was confirmed with a scope, with
and without the fix.

The same bug is occuring with two independently introduced spots, so the
fix is two patches with their respective Fixes: tags and backport ranges

  1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
  2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v3:
- no functional change; collected the review tags received on v2:
  Acked-by Oleksij Rempel, Acked-by Carlos Song, Reviewed-by Stefan
  Eichenberger (both patches)
- cover letter: add the real-world trigger (MPQ8785 PMBus regulator
  on the LX2160A) and how the fix was validated, asked by Carlos Song
- resend as a new thread, per Andi Shyti's request
- Link to v2: https://lore.kernel.org/r/20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr

Changes in v2:
- Handle when count > I2C_SMBUS_BLOCK_MAX the same way as count == 0
  Reported by the Sashiko AI review on v1.

---
Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

 drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260525-for-upstream-i2c-lx2160-fix-v1-0cba0a0093e5

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>

