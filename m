Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104B3EA66;
	Sat, 19 Sep 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807095; cv=none; b=VUChMOQgpXJ6OHQMoSsED2fzpDtbP4sx34S4PGmd6OeneOGwknSmgD4bFNdpntxNW/CwFFkkkEqlEWF7AVYW/ReBWeBMs+Ebuz+t0atErTLbJuzU9qzAVOh+sZOrgOTOZUjQrnyPJGpu0G7TcvJS3DK4CsWo4Clr/w6gvlJVGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807095; c=relaxed/simple;
	bh=ebeWsw/dv3nBGXHdntVt3cRqdDCIzpBc/6uDEjPSN+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awwCgcFMZCD5dRL9140b1v5LXImUROl/SLHtEGi5qU3kqRqAzBkRLo+pI60/0C7YsmFyFsGSUocie6SkaWbuzDfIDR6ULY6DQbR70ZdoJJ+y8SWXVzYhWQYkTmVrMw0vZMq3qb0bcrWJFz6z8P69KWD22A9fM8v1BpetsBDB+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=J81FI8cX; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="J81FI8cX"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CF7E23D81827;
	Sat, 19 Sep 2026 04:38:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pC_bzgV-DfBY; Sat, 19 Sep 2026 04:38:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C67C23D8183C;
	Sat, 19 Sep 2026 04:38:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C67C23D8183C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1789807084; bh=PCIjiH/RIxkpROf3JPRP9Gia/W9nF2ro02U5ljcPHOg=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=J81FI8cXM6b9m5zFAYKxiLv9InpsiNug4fcE+MzmDmmFWb5GzlqndNrheujESLVWv
	 MFL/R0aG5u1RJYUDFCl5sjTMMNjeqnuO0rg8JTQhzhGMsgCmvHd248PAZo4norHVzO
	 0AIzpLgkS/IlA8yAyf1ZyplfaaT5uK9pnaHEkvjfC7kpm2yvE+L9IXskBfI4668pTQ
	 iVNSrnVhejmd89KaQmzR1Odie0yuQFS3dQNwctARf9WrrjoLCeFd/5RSrWS1+RTuh8
	 806Oc7MLOZe5NbwACyAom4NgJa1yVZZZQgzdOI20NvKvZrRnNGQ/ic/91w9vYDGYgA
	 qNUq+ru39Xkaw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id N34Amp_2wPQn; Sat, 19 Sep 2026 04:38:04 -0400 (EDT)
Received: from aojha-pc.taile0726.ts.net (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 802673D81827;
	Sat, 19 Sep 2026 04:38:04 -0400 (EDT)
From: Abhishek Ojha <Abhishek.ojha@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	linux-kernel@vger.kernel.org,
	Abhishek Ojha <Abhishek.ojha@savoirfairelinux.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] regulator: ltc3676: don't read the write-only HRST and CLIRQ registers
Date: Sat, 19 Sep 2026 04:35:45 -0400
Message-ID: <20260919083545.3092992-1-Abhishek.ojha@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HRST (0x1e) and CLIRQ (0x1f) are write-only command strobes. Writing HRST
triggers a hard reset of the chip and writing CLIRQ clears the interrupt;
reading them returns nothing useful, and the read itself fires the comman=
d.

The result is that a plain register dump resets the board:

  cat /sys/kernel/debug/regmap/2-003c/registers

walks every readable register, hits HRST, and the board reboots.

Split the callback back in two so HRST and CLIRQ stay writable but are no
longer readable. The readable range is left unchanged
(LTC3676_BUCK1 ... LTC3676_IRQSTAT).

Fixes: 37b918a034fe ("regulator: Add LTC3676 support")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Ojha <Abhishek.ojha@savoirfairelinux.com>
---
 drivers/regulator/ltc3676.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 307c6f7a155d..d67cee4e0be0 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -232,7 +232,7 @@ static const struct regulator_desc ltc3676_regulators=
[LTC3676_NUM_REGULATORS] =3D
 	LTC3676_FIXED_REG(LDO4, ldo4, LDOB, 2),
 };
=20
-static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned =
int reg)
+static bool ltc3676_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
@@ -243,6 +243,15 @@ static bool ltc3676_readable_writeable_reg(struct de=
vice *dev, unsigned int reg)
 	return false;
 }
=20
+static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
+		return true;
+	}
+	return false;
+}
+
 static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -255,8 +264,8 @@ static bool ltc3676_volatile_reg(struct device *dev, =
unsigned int reg)
 static const struct regmap_config ltc3676_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
-	.writeable_reg =3D ltc3676_readable_writeable_reg,
-	.readable_reg =3D ltc3676_readable_writeable_reg,
+	.writeable_reg =3D ltc3676_writeable_reg,
+	.readable_reg =3D ltc3676_readable_reg,
 	.volatile_reg =3D ltc3676_volatile_reg,
 	.max_register =3D LTC3676_CLIRQ,
 	.use_single_read =3D true,
--=20
2.43.0

