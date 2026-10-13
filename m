Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net [46.105.35.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6551531610
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.35.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914253; cv=none; b=PMZUXcxt4Vb4Q9xCwZbAMqq45sfk5J02K8AXUudQHvvFW7L9Qdk7/uFkg1Ge2yYhs1oVy+lWo47Yk4grlxqpAr4mQIH/09wfu4/5/7RMVFjTmZFG8XFcYpHaeRo7cmxkVGxMYEONRGrjYfGhWZRp7WtUk9D6VZiYyuO/kyOcOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914253; c=relaxed/simple;
	bh=kfP8OPsPqO/oUZC3gPAT+oD2S4HQ3xDeqjik6j/TtY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dhmyrSWrT5dtwYeAvw9FxcQUbPDKSR7dfbGOCzj9tCwUCLWN6TrVlXamS50hcjt7tntribJZCdFisPJmt//7yYSyPFDDoi4NEns+I+iLNuNQB41DgVZD+88DXXBACrKdW64m9hAurpkONRW/CQBCRD0hXU2NiB/IwhnquyJMqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b=htzndDN0; arc=none smtp.client-ip=46.105.35.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b="htzndDN0"
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.231.97])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4j3zkg4d4Lz5xJD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:07:39 +0000 (UTC)
Received: from ghost-submission-c7b579475-655hp (unknown [10.110.164.42])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 10B87C12C2;
	Tue, 13 Oct 2026 16:07:38 +0000 (UTC)
Received: from armadeus.com ([37.59.142.104])
	by ghost-submission-c7b579475-655hp with ESMTPSA
	id J4tGM0lXzmr7Qy8AW2yxgA
	(envelope-from <sebastien.szymanski@armadeus.com>); Tue, 13 Oct 2026 16:07:38 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R005ed722c48-267d-45b9-9d0f-38bc83d56095,
                    E71387541862F9B32BD99FE93336DDEC16E392F6) smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp:92.148.202.169
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Tue, 13 Oct 2026 18:07:24 +0200
Subject: [PATCH] ARM: dts: apf6: fix Ethernet support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-apf6-fix-ethernet-v1-1-9530efe1d23e@armadeus.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5FMBSE4VeRs3aSloS4ryIW1JRj0SttiUS8u
 2L5ZTL/SQFeEOiXneSxS5C/S9B5Rmbu3QSWMZkKVVRa6ZL71VZs5WDEGd4hsqlrUzYKVmGg9Fs
 90v422+5z2IYFJj4huq4bM+Rl6HUAAAA=
X-Change-ID: 20261013-apf6-fix-ethernet-c77c390ef0eb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?S=C3=A9bastien_Royen?= <sebastien.royen@armadeus.com>, 
 Julien Boibessot <julien.boibessot@armadeus.com>, stable@vger.kernel.org, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.16.0
x-ovh-tracer-id: 6290121306616026755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFwwrfl1iPxPmWO6o6uy7jINWKAyMh0x8QwmnQbFs9EgGBBoRnjM3BUaJEZr2O/b+jim7kDcbnaQ7gbObCvdaGwmrI7ygNuePUx2XfOlPU+ynH2L/Y3qjv+8V1sNGQDoWzTS4dPbg8+1q+A4z3650pMSEERHWOc6c7wHIzQ/cd0AAinuhk1ciGuYw2D4AM54rlUTc3EI7eSXJzVYl3OyTQSK/C+/uQKTz4zratc5VMMn5UDog0h/EUCyQxoTf55Y9AhqDDFZ6zvIsDrjC6HgMcTURajxU4gpbIZHaHPJuId6YRUZECM9rjL8rwWeXi3BZLeaf9O0cp/v2LK91+ydBE1pTLm2s4JxFKXWtJ/yu6vMrg29SnoiDv0xXibe5WTtlonW511aXUqOWCeA1qVbSCdSMaD5xI6UaucYANf7IUBGIaXBHOwnkHaetpmKyRJUcnLOylFTAoecaXImSmO4olTWEAIESqh/WalrxSuRAkI2bquzKaOHt/+YCzqSw0+LbtNXqfssElbEz8nYBjg1gF4VWpHTR9s8PMy7NmlzEAEeCh5qR7wWBfyh/DpgDqynt/Z5ElF+x3tAe3JkAP7vBh9zvzGfhAvbKCXPUhnp4l22ezIBiDNOjw2W35lpauNtsTHgkBaR/4zqV5fEEaoqTcxmsH4Tm3m3/L/GUgZzIdO6g
DKIM-Signature: a=rsa-sha256; bh=3JJebDaF8d0BDkPiP93+YZIa8Qgu2HPfzUYjFA6D8SE=;
 c=relaxed/relaxed; d=armadeus.com; h=From; s=ovhmo103079-selector1;
 t=1791907659; v=1;
 b=htzndDN0tLZisLCb4+yCj80PN7xv9g7YXxQHdVwxNFA1I1KYQbyiZdbAzxypK7zIFvtWUdlA
 r+p/WVV+ppUAzuY9Cza1y/KRrwjnBRzj7oRtHamoL4OZoIQbEG3XxkBEHIrdeIpf1KXsfSXMgrq
 2/UbPM+mFpBi2IH1HsQ5viSypY+iiIFKg1drKuXZkQavLVjJhuqIRQm3zouS2VZrbD1Xz6WIxod
 yySiVzNtMLCjy/x0YLJTaXg29Aks8YfKXhaRmr6Nr6MiJWt0mlCrXkCR4PjW8lgmCZKsqFPEfV1
 4XJdz2LUx6I4EgcjawOWbX78kUilhY/TtDYORO48qvGqw==

Commit f5d9aa79dfdf ("ARM: imx6q: remove clk-out fixup for the Atheros
AR8031 and AR8035 PHYs") removed a PHY fixup that setted the clock.
Make the Ethernet interface work again by doing as advised in the
commit's log, set the clock in the device tree.

Fixes: f5d9aa79dfdf ("ARM: imx6q: remove clk-out fixup for the Atheros AR8031 and AR8035 PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi
index b78ed7974ea9..b55a3539fbe8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi
@@ -41,6 +41,7 @@ ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio1>;
 			interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+			qca,clk-out-frequency = <125000000>;
 			status = "okay";
 		};
 	};

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261013-apf6-fix-ethernet-c77c390ef0eb

Best regards,
--  
Sébastien Szymanski <sebastien.szymanski@armadeus.com>

