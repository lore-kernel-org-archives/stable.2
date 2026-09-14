Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85057369D40;
	Mon, 14 Sep 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408031; cv=none; b=pxzf+yGzNTEtxG9y4FfLInKSI/ekH/3f02daNaCcvXkiSO8raAvqkD0QVi5QP5rrMJHQQiso+9KEnBzJ7cFSOtdTpUYZkxD7fjZD8eemAN5hdfzWB0v+POpjk49IPxSrMOywMW3Z4ZO9Q64sOL+sPhS6wE3ZWd0Cgg2YPP2kEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408031; c=relaxed/simple;
	bh=xXI9AvULH0ZWHacBFgKFrM6IavdHT+Zbc8dLwuT5l0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLnUnrcO3A6DF333vd0dtQkt75Oe20TirQZavvjh2Mi7UuD1XVDYZjTuNegPf/TJrhNfEMkC+nN8H8FQkwuc37+pQDjXFFc9J3BLO5TQSPrETEPSgdxQ3Vy/mCsOIW0ehVFKz2XWwltECscIr7pwCnnYxQJd+hbyrR5AL7QvhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=p2xJk0+x; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="p2xJk0+x"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 6E45B1F8D1;
	Mon, 14 Sep 2026 19:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789408018;
	bh=fEcFOKk4u49+lu8i7wUIHe8SeOyKWEe5+xW0wFXymbk=; h=From:To:Subject;
	b=p2xJk0+xjnA7FvkwtcukQ1EX2uhEWzgnkNSASC4gC+INwmUOeYdyXvTw48hW4FOT5
	 hPC1bLTQXdn1vfelAsySRSL2FmFrMJe2lW/wgis7Q2ewMZPsEK1Tecx5fpaELvzQuU
	 tvUS6i9hpngk5shrYWAC3StaFNdW6FhiXy+rqBpAqcWeCqz28qCPmuU10f1ZhZi2hu
	 q0kwKshkqkG7cR2Vuo2shrmuqFj98UgJQ0xA8BO60/bt/QTpMC4k+OWrDXarjF+UwH
	 G3tc5AWrde+lvDYm7T8zyoV0Jb63BUse6OjOiCJ7W1AMHWZihMH+eEVokBcbeia7fi
	 FbjQedu/oesfA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am62p5-verdin: build zinnia dtbs
Date: Mon, 14 Sep 2026 19:46:50 +0200
Message-ID: <20260914174651.6195-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add the zinnia dtbs to the Makefile, they were forgotten when zinnia
support was added and were therefore never built.

Fixes: 71c2a8124527 ("arm64: dts: ti: k3-am62p-verdin: Add Zinnia")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
in our OE build the dtb files are built from an explicit list, so we did not
notice ...
---
 arch/arm64/boot/dts/ti/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index fcfec8ea3165..e3ca60a30433 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -91,6 +91,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-ivy.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-yavia.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-zinnia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-ov5640-24mhz.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-dahlia.dtb
@@ -98,6 +99,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-ivy.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-yavia.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-wifi-zinnia.dtb
 
 # Common overlays for SK-AM62* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-ov5640.dtbo
-- 
2.47.3

