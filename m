Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262568;
	b=APyDiieqEbxfEY7AkWPjOSFwZ3szcuZvZYwDDNBhNShiAolnYXQQX9uW09G1JXpJB82h
	 s4hEHalnpBln9KsMRSwzXKFl7uSIpfVVl5LrZa62Qi6jaXoQyLe4optPMiVqFdeIk9R0A
	 fsOD0QPnzQtbtNU0db8Tyccyry+JnzsaV+P/lhR9WKCSzY/W6cmAi9ymilw7+QQMbnocn
	 zh7OLQyGqeG+UarCZ1bRC39BQ/uEtT/SYVStrg6dJzPJRXDXsSqUosT6bAaosUt4CRFnX
	 DJVZ+nCvYQXv1+0UfQe/YVdPfRSqY+/MVjbvRBpIJsN/Hioyfz10N0GQ3jkryRWN85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262568;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kE4syZx4j/5qX4L+2YVxHbOJsxFk3bQcYDZtlzgC2zA=;
	b=RK0q34p0RyjclwqHyzEWz9Yh2iWfhyh3ELTexLBNxyitwbghK7w3OufOKbiNMOLztrt4
	 ZD6Pd0obDpCDyH881G1qI0x6mb4vIXGYiEAxPi3UtVE2dbq9JzfgjC9GEb6JvXaqvGHZs
	 M8S9NS79kWOmhnqO1raOsuqjl9TLygAo2yf4pV+LflaVc8y4zPE46rBrfXgQ2glr2IidA
	 AlEP9Zh1p21IOuD+kVBo2Zmj987GvhsogypSbp2CArTHVlBjTT2Lvn2idIyS4No+Ohpe5
	 M9sTvPeT1u+XDeemAjIa2kLTmmi0EKXwV24wWMfnhEnhsSky2jiTuWbjalJZ6BsndQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=nLWFZvSY;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096D60A260A;
	Mon,  9 Nov 2026 22:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C096D60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=nLWFZvSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794262565; x=1794521765;
	bh=kE4syZx4j/5qX4L+2YVxHbOJsxFk3bQcYDZtlzgC2zA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nLWFZvSYE9lR2C9K/r8k0MTD19qXnddoMFxZKLIOatwKpWURP0sLdOB38Pow89wpS
	 UA4tJjDcc+9FZBvm5oGkRwLPrL5Zlb0uWg1Snqp53csXFY8tHH9PxfGfWzBZSFINW6
	 YdPF9X2TsTcQbIjQB81Q81+4K+89p780GR0Vi9kA4BSHzhDWCrXTxnxo3BhNNdQHVP
	 3QSSMdAdM6ccd1CYfytwB+k3qROci7ZZMVDabBn+cf7Q5zje2xisB/VuW72oxLXwrV
	 ogz08D4DKyNxlC0GXxF2NJObnVdO+/aZmZsZlasJS/c10IpI7Gt7NQzq7qJUsq7AZr
	 a1aZPYQaobvUw==
Date: Mon, 09 Nov 2026 22:15:59 +0000
To: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
From: Soheyb <soheyb_boulaa@proton.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Soheyb <soheyb_boulaa@proton.me>, stable@vger.kernel.org
Subject: [PATCH] phy: exynos5-usbdrd: fix HS phy init count imbalance on Exynos2200
Message-ID: <20261109221522.2796426-1-soheyb_boulaa@proton.me>
Feedback-ID: 140697376:user:proton
X-Pm-Message-ID: 5ec8a07a4fff850a81f2eff5aebc5744ac5da29e
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

exynos2200_usbdrd_utmi_init() calls phy_init() on the high-speed phy,
but exynos2200_usbdrd_phy_exit() never calls phy_exit() on it. The init
count of the high-speed phy therefore never drops back to zero: after
the first init, every later phy_init() of it returns early, and its
clocks and supplies stay enabled across an exit of the UTMI phy.

When the high-speed phy loses power while the controller is suspended,
it is thus not set up again on resume, and the DWC3 core soft reset
times out:

  dwc3 11210000.usb: DWC3 controller soft reset failed

Exit the high-speed phy when the UTMI phy exits, first, in the reverse
order of the init.

Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm co=
ntroller")
Cc: stable@vger.kernel.org
Signed-off-by: Soheyb <soheyb_boulaa@proton.me>
---
Tested on a Google Pixel 9 (Tensor G4) with an out-of-tree port that
uses the Exynos2200 phy ops and powers the USB block off in system
sleep: without this change the soft reset failed on the first resume;
with it, USB came back after each of two system sleeps. Not tested on
Exynos2200 hardware.

 drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung=
/phy-exynos5-usbdrd.c
index 087d552..0bee928 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1486,6 +1486,13 @@ static int exynos2200_usbdrd_phy_exit(struct phy *ph=
y)
 =09u32 reg;
 =09int ret;
=20
+=09/*
+=09 * The UTMI init initializes the high-speed phy; exit it in turn, so
+=09 * that the next init sets it up again after it lost power.
+=09 */
+=09if (inst->phy_cfg->id =3D=3D EXYNOS5_DRDPHY_UTMI)
+=09=09phy_exit(phy_drd->hs_phy);
+
 =09ret =3D clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clk=
s);
 =09if (ret)
 =09=09return ret;
--=20
2.56.0


