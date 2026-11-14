Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638687;
	b=2rEzB8tRWKwA04IYtfSODRp8qObUX86fWos/aAemL3eW/CoOGwuaJLoPLNRKneDZSwG4
	 w3hP1ED7pdoFg7b3WCjsaayaeXocXKnLWbyD6g8OGlK+0AUcfs7EM84g5jPl+YV/jl0l5
	 FkvqovtoCNR+COsPFZKaBHF6T8KLlp5DXQ7bnv16yBxf75giobe7FQP35RwyMwazn5XLA
	 LMIbPZf8jymhwFztANMZkCkqu8OvcST/GCVrxib/8zOly6a7TwEF6xh0NkMR6cS4DY6G5
	 gVbUvjuMj0zRruBopVd7i7hxE2yv7NGmG07+c6RKifG0buxVTCo39RjHEMZ2BL7MwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638687;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1uDuxo1+312DZu4wP1WaNsqpNH1ZgoDA4y25yIziRQ0=;
	b=H36rjKmSfjz4LwMBP7Ql0JwkkGIRr/vaQy5pMvh535WgCmsTLtU5Yy4jkcICsNLkZg73
	 aaqXDI4haOgo6ZMCv72VR8dBZNJDhAXoxxLMcOTb7TWwT1pz2ehCWgpPU0miyoYRtLXw0
	 uzDQrQPZ+1DeK1ihhppwCaYL6PnKm0VuDly9n3izr0v3hH0TtfmnIkgDCmYYfFhH7DJjJ
	 tJ41tdHlBOingO901CftTmyEcNpfwStML27tpXCQEAEwlywnIEziYBj/hjYXeqo0+k86h
	 tSOvFB2upr8Gee5l/wQyq+5CQENVT18HbLdgX92ZRJm0S6IIxPyhBIqTRViYDIM/7Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=g83ilvhJ;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9445606A887
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9445606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=g83ilvhJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794638685; x=1794897885;
	bh=1uDuxo1+312DZu4wP1WaNsqpNH1ZgoDA4y25yIziRQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g83ilvhJAMVenwUKV+PYJzqUOE3TSAhJMmJo8a/vKqzIh8HVBUMA0Tp63gsJuoAM/
	 l835+Er3lSrslaJdPnrE38x18ChkZ3PkJXR79PECQdKIjJGUrK8hqS9NvoGJKcSQ6b
	 f1iPzdp5n18yfhNc2vKgPUO2bKLRp/WJevZ02k/bZ/CvLziV84LqExx5DORc0KsdZ5
	 wjQ47qpvLIgwFGnCIYPh9T+dcPBBMSdwR8Bpazk688jc3qyOgwRYnLie/YyF9ONfCz
	 fir48sa2g4YQP35fkMejt+sQ7RFO+v7JpezObwwobZPtYFdfjgf/Ixrd9PlUO4ad35
	 KRid9U0+1vlXA==
Date: Sat, 14 Nov 2026 06:44:41 +0000
To: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
From: Soheyb Boulaa <soheyb_boulaa@proton.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Soheyb Boulaa <soheyb_boulaa@proton.me>, stable@vger.kernel.org
Subject: [PATCH v3 3/3] phy: exynos5-usbdrd: fix HS phy init count imbalance on Exynos2200
Message-ID: <20261114064400.45572-4-soheyb_boulaa@proton.me>
In-Reply-To: <20261114064400.45572-1-soheyb_boulaa@proton.me>
References: <20261114064400.45572-1-soheyb_boulaa@proton.me>
Feedback-ID: 140697376:user:proton
X-Pm-Message-ID: 626748be6b44fdafbe364f3603ef7f1b9ca684d1
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

Exit the high-speed phy when the UTMI phy exits, last, once the rest of
the exit has succeeded: the phy core counts a failed exit as no exit,
so the high-speed phy has to stay initialized along with the UTMI phy.

Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm co=
ntroller")
Cc: stable@vger.kernel.org
Signed-off-by: Soheyb Boulaa <soheyb_boulaa@proton.me>
---
v3: full name in From and Signed-off-by.
v2: the high-speed phy exits last, once the rest of the exit has
succeeded, after Sashiko's review of v1; v1 exited it first. The comment
is dropped, after Ivaylo's review of v1. His Acked-by of v1 is left
out, since the exit has moved.

 drivers/phy/samsung/phy-exynos5-usbdrd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung=
/phy-exynos5-usbdrd.c
index cf0597a..041a555 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1510,8 +1510,15 @@ static int exynos2200_usbdrd_phy_exit(struct phy *ph=
y)
 =09clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
=20
 =09exynos5_usbdrd_phy_isol(inst, true);
-=09return regulator_bulk_disable(phy_drd->drv_data->n_regulators,
-=09=09=09=09      phy_drd->regulators);
+=09ret =3D regulator_bulk_disable(phy_drd->drv_data->n_regulators,
+=09=09=09=09     phy_drd->regulators);
+=09if (ret)
+=09=09return ret;
+
+=09if (inst->phy_cfg->id =3D=3D EXYNOS5_DRDPHY_UTMI)
+=09=09return phy_exit(phy_drd->hs_phy);
+
+=09return 0;
 }
=20
 static const struct phy_ops exynos2200_usbdrd_phy_ops =3D {
--=20
2.56.0


