Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638671;
	b=LiMisQoZGn83fsISUCDvO9h3LkhjD5MKsNqZUISU3ZAQ0Ze9UecD2BLpGBy3e42uWWHB
	 l5domQdTWrRHCoKWAZ69q9QkHbop0XFyK9KwubIIpkNNgCpryoj3CZbUKxvliydrlb9Sv
	 EIcC19w3qGz7SM6o/0VUzab8n3fsr4cWktBjQ2jfEVL/Bs6ilCTklu2IUMUcKUSgvwW98
	 TLQvTD2M5KfdHv6j1afmxMQbRil+wV+qSsumRtqVL33nD7TfmGu2TTUDWXz1VtRD1mCcV
	 +wszVju6yL0pxV+GW1DRzTUasp9vBIU5vCWgftfFprCZly23jt+xGHwP2Ijb0iKaGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638671;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GQtdBeiFOXP728SD4q3k0TWUdrvTTTXxrXqVYnu7l4k=;
	b=Q/Ear70bdVCW1vLAANxrm//WFsyR4N1NQdTWTpIaZiTqoDdutE5eBPykgDqfho2YGgYT
	 pSPF28IpJjo9tzeEQX3Zes8rKRRhkBFp+1j+lBwzZK1oogl27bioAM0cGcgK0eBmbHvCJ
	 xJIlqY3oGSoDhXt9iMM181cfgSseiVFup5PbqsnT3jugBONQCBYBDk60SuncKS4AAsD4j
	 wAfQx/pPnvWVtxSEoyM+Yi5oJsE3StZqm5OA0z+1xdjHDZvPhQJByf26slcaVyR6wWo5o
	 TYKZwWQ9j7fk2pfbvgz0liQF2nerbbKRDHTHrdj+lKt+muyGXh5944/S9qcVBv16Pjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=mVxvbNwo;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D23606A323;
	Sat, 14 Nov 2026 06:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D23606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=mVxvbNwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794638667; x=1794897867;
	bh=GQtdBeiFOXP728SD4q3k0TWUdrvTTTXxrXqVYnu7l4k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mVxvbNwoQ2fLHFpZy8VDIpt7Sfr0JRryBGhX2h6oZlv2edn/kMNqa17j+XRJUQsLZ
	 LJ0cBxT9ZumVd5w59stkhKSM7R5MakEL2+o2KXpYPmn3/cmUGy5yAUHqqLyfcCH7H/
	 ToRp8BaJa5nqbHBLtgAIUExqeQznjJCC988tfWzVKqPAHL9l/+EZHtevivBh6Js2z1
	 YSwodNAiUpbngiMQ2L9VFzjx6kg+saq8zcgTCjmtcvxop98mCOpY83R16OohTx65yi
	 W7ElhL/GGvWC8+2rnsjUADndrmsAIKQc4dWM2sWzFj6V5MHaXQFfToOlD2eHX1y1zj
	 07fBwsNX8Z8JA==
Date: Sat, 14 Nov 2026 06:44:23 +0000
To: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
From: Soheyb Boulaa <soheyb_boulaa@proton.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Soheyb Boulaa <soheyb_boulaa@proton.me>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] phy: exynos5-usbdrd: power the Exynos2200 phy down when its init fails
Message-ID: <20261114064400.45572-2-soheyb_boulaa@proton.me>
In-Reply-To: <20261114064400.45572-1-soheyb_boulaa@proton.me>
References: <20261114064400.45572-1-soheyb_boulaa@proton.me>
Feedback-ID: 140697376:user:proton
X-Pm-Message-ID: b61ff92e42010bfa9a4b2839dd5c983310e9ecf9
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

exynos2200_usbdrd_phy_init() enables the regulators of the UTMI phy and
takes the phy out of isolation in the PMU before it enables the clocks.
When clk_bulk_prepare_enable() fails, it returns without undoing
either. The phy core does not count a failed init, so no exit undoes
them later: the phy stays out of isolation, and its supplies stay
enabled, until an init and an exit succeed.

Isolate the phy again and disable the UTMI regulators when the clocks
or the phy-specific init fail. The phy-specific init does not fail yet;
the next patch makes the UTMI init return the result of the init of the
high-speed phy.

Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm co=
ntroller")
Cc: stable@vger.kernel.org
Signed-off-by: Soheyb Boulaa <soheyb_boulaa@proton.me>
---
v3: full name in From and Signed-off-by.
v2: new patch.

 drivers/phy/samsung/phy-exynos5-usbdrd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung=
/phy-exynos5-usbdrd.c
index 087d552..a6fe779 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1462,7 +1462,7 @@ static int exynos2200_usbdrd_phy_init(struct phy *phy=
)
=20
 =09ret =3D clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clk=
s);
 =09if (ret)
-=09=09return ret;
+=09=09goto power_down;
=20
 =09/* Set up the link controller */
 =09exynos2200_usbdrd_link_init(phy_drd);
@@ -1475,6 +1475,17 @@ static int exynos2200_usbdrd_phy_init(struct phy *ph=
y)
=20
 =09clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
=20
+=09if (ret)
+=09=09goto power_down;
+
+=09return 0;
+
+power_down:
+=09exynos5_usbdrd_phy_isol(inst, true);
+=09if (inst->phy_cfg->id =3D=3D EXYNOS5_DRDPHY_UTMI)
+=09=09regulator_bulk_disable(phy_drd->drv_data->n_regulators,
+=09=09=09=09       phy_drd->regulators);
+
 =09return ret;
 }
=20
--=20
2.56.0


