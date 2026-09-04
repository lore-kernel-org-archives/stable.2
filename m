Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734523BBFB4;
	Fri,  4 Sep 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542600; cv=none; b=aRzVLDFjoBFDTMo/LDPymX4mchQHdv/45+K9alWZL9mqSzbcI2tSHe1qI7NjuNWl/XY13S3Bfmp93FNZawMY0Myzmuee52UJ0R1Q7DeWKtqOOc5HybRBRwvVNgOHtxkv+Nh7hB/8MM3FzVx3VCIFdRoPo0S6ZxwRseM3V/Q57VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542600; c=relaxed/simple;
	bh=8r5t0udPslDFnu5V4P+us4Bpn4IyIcEMmb6oOqAcZ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrCsbuz8DQnNcMz1Tx9HVxlwewUQqoKi89u2IEzH9sfkPmd0MWvUk8RPuGr891abJzj6chOauZ08QObsoY9/8UktsbAX8qsmLWJBB5Mu3K8yRbf6LjSEb/IKX0Mjm39mDwkvlVwBgpMwezQL/V1bDCupv/bfIxmdx0jR2ImRcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ3qV0/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ3qV0/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA3F1F00A3D;
	Fri,  4 Sep 2026 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542599;
	bh=Qe/SR/azOYN4FcYL3Zi0mhaXWiftLHOPJv3t4uJcphc=;
	h=From:To:Cc:Subject:Date;
	b=EJ3qV0/vmlS5DC4Ju+pgBKtyfO9cpsen5fo6kR4PoUfqdtTer1NSeBOZNUpKnCdYt
	 Ou0SNCLu0alpia5AHSY9mVSPodQ0mSwNaIKbcYJOpzc15gme3j/dHtyJFcWPHakJNY
	 M+RgFXVP8l+bvVR2VUur6Xyr8xX6mp3UWIUDG2lhbewtoWP440wZAJGaD30cTiyRu0
	 y6LXpqXl13Z9B89VIc9paGBLk0PGovB/GB5QNaf7ez8PtpvI51rWgzvociUoU0N0EL
	 lCvIZNzOCnFop3fQoxzdmnl7BMWzj0IC8DpVtE1k+x1paCv8KQIEOdh062iFm4iWQh
	 GZ5DPM1J6moRQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH] riscv: dts: microchip: beaglev-fire: remove double definition of gpio interrupts
Date: Fri,  4 Sep 2026 18:22:55 +0100
Message-ID: <20260904172253.2274751-3-conor@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=conor.dooley@microchip.com; h=from:subject; bh=g+2NEGXgnzSlaVh9vBHDs5IpNqnrxlZ37dU6ImCHIP4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFmz/uVN2VEnyLksbdMylX2/5kis542YuNw4ocR7o/xmS 12xqPT/HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIQSbD/5CNiZ5cDdzPfSwj vdcwJDzPdM/b8Sf5xf3go24N62yXGzMyzO2Qurvo+G+VOQFXTnZy/72zguPFGlOFO0bbP9RFf72 4mQUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the irq-mux and its interrupt-map were added to the mpfs
devicetree, the gpio interrupts became fixed at the SoC level rather
than dependant on the design - the interrupt-map is now what varies.
The beaglev-fire should have had its dts copy of the interrupts removed
but did not. As a result, the mcp3564 driver does not probe, because
even though it doesn't use the interrupt at present, the SPI core still
looks it up. This lookup fails because the second copy of the interrupts
property doesn't resolve to something valid when passed via the
interrupt-map. Remove the second/incorrect set of interrupts properties.

Fixes: b0258f69f1e0 ("riscv: dts: microchip: update mpfs gpio interrupts to better match the SoC")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Valentina.FernandezAlanis@microchip.com

 .../boot/dts/microchip/mpfs-beaglev-fire.dts   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
index 6d7037c9528d..a09371d9d064 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
@@ -90,10 +90,6 @@ regulator-1v8-syzygy {
 };
 
 &gpio0 {
-	interrupts = <13>, <14>, <15>, <16>,
-		     <17>, <18>, <19>, <20>,
-		     <21>, <22>, <23>, <24>,
-		     <25>, <26>;
 	ngpios = <14>;
 	gpio-line-names = "", "", "", "", "", "", "",
 			  "", "", "", "", "", "SD_CARD_CS", "USER_BUTTON";
@@ -101,12 +97,6 @@ &gpio0 {
 };
 
 &gpio1 {
-	interrupts = <27>, <28>, <29>, <30>,
-		     <31>, <32>, <33>, <34>,
-		     <35>, <36>, <37>, <38>,
-		     <39>, <40>, <41>, <42>,
-		     <43>, <44>, <45>, <46>,
-		     <47>, <48>, <49>, <50>;
 	ngpios = <24>;
 	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "", "", "", "",
@@ -115,14 +105,6 @@ &gpio1 {
 };
 
 &gpio2 {
-	interrupts = <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>;
 	ngpios = <32>;
 	gpio-line-names = "P8_PIN3_USER_LED_0", "P8_PIN4_USER_LED_1", "P8_PIN5_USER_LED_2",
 			  "P8_PIN6_USER_LED_3", "P8_PIN7_USER_LED_4", "P8_PIN8_USER_LED_5",
-- 
2.53.0

