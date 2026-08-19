Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E03CFF53;
	Wed, 19 Aug 2026 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120370; cv=none; b=DsTjjyHvQ3QpqScUIJ3cqxovFDs9x0bIsKu5KjmCgI0Qsi34B5H1Dv10DkbzROnpRlRLmCPHbsjENM0+mutQJ5EbsEYoflRFCp65Vbm7onYLeFmiMaNhTOlpGn7B6j6IyzucHyXUmGLVC6zVfniT1BAx6CQnF9PC7Y4d1xuq6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120370; c=relaxed/simple;
	bh=ATCkRO2g6l2bTSEx7CNXrwSPV9W78Jrv6mGvvIGs4Ww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTrzetDGZlt8RN+eQ0CNTABC1tKHcGZ617lhH7HFR7jyZT4tON5jGGRTdM8vHEQtZT/5CUFqUXGtQ/JhKUrjfUA/Xrhbunr2iKCw1RIFO6EgZZt0b1WbEgEWjqyFcDJmC5FWAnSNW5kiYLvVlez/W/HD7UoFvhSrh0kPajYXi+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NhqRbQmh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NhqRbQmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787120368; x=1818656368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ATCkRO2g6l2bTSEx7CNXrwSPV9W78Jrv6mGvvIGs4Ww=;
  b=NhqRbQmhVSUtTgJBsYP8QT9KRZTl20Y2DJTkBZKTytZx3T6nTTiAcmya
   tsuLoS9akjvxPrsoHFqRrDMzNuZyoj59ybBju0Ko9pivt+AsmcJl1kFIx
   LFef+y4xxptOx9Kr+AdcIfjwFSSIXRtuIeXTipYoMJwa7tTcBjblF/npi
   vPn/1+L5vjn+JtonqKyEvaXCJEeW+sw1ladaiII1uNCwv78aadcOBf4FF
   nmvZZ6Fr/6SodWMnNYKTTotuOle3C7elTJs9liYtMKCD3fxS2Mfr2cSZS
   70AkTGlHheS5KdPblJmloBR4m2XqHGWpQKzzx9Qo1J1Z0D/tdtMrJUnQy
   g==;
X-CSE-ConnectionGUID: YKs8HlfwQe+CQGvJ1rIPqA==
X-CSE-MsgGUID: Aon8myYhRiuw5IKyAIHO7w==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="72082233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:19:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 18 Aug 2026 23:19:25 -0700
Received: from che-ll-i71840.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 18 Aug 2026 23:19:22 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@xs4all.nl>, Wenyou Yang
	<wenyou.yang@microchip.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] media: microchip-isc: don't sleep in the clk .is_enabled callback
Date: Wed, 19 Aug 2026 11:49:20 +0530
Message-ID: <20260819061920.22954-1-balakrishnan.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

isc_clk_is_enabled() calls pm_runtime_resume_and_get() and
pm_runtime_put_sync(), which can sleep and are not safe here, as
.is_enabled must run in atomic context. clk_disable_unused() calls it so
at boot, and CONFIG_DEBUG_ATOMIC_SLEEP reports a "sleeping function
called from invalid context" BUG.

Use the atomic-safe pm_runtime_get_if_active() and pm_runtime_put()
instead. A suspended ISC has its clocks gated, so report the clock
disabled when the device is not already active.

Fixes: 01192aa1c5c2 ("media: atmel-isc: Enable the clocks during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-clk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-clk.c b/drivers=
/media/platform/microchip/microchip-isc-clk.c
index 24358d804e75..66dc522a6190 100644
--- a/drivers/media/platform/microchip/microchip-isc-clk.c
+++ b/drivers/media/platform/microchip/microchip-isc-clk.c
@@ -98,15 +98,14 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 {
 	struct isc_clk *isc_clk =3D to_isc_clk(hw);
 	u32 status;
-	int ret;
=20
-	ret =3D pm_runtime_resume_and_get(isc_clk->dev);
-	if (ret < 0)
+	/* Runs in atomic context, so must not sleep to resume the ISC. */
+	if (pm_runtime_get_if_active(isc_clk->dev) <=3D 0)
 		return 0;
=20
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
=20
-	pm_runtime_put_sync(isc_clk->dev);
+	pm_runtime_put(isc_clk->dev);
=20
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
 }

base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
--=20
2.34.1

