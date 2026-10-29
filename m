Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292361;
	b=KNZeFojxzSSJNXxiTSOWgiScIDYD5oNMmJgsE5cvA7eAvKWd7IHgY1T/HdVie1Wpgby9
	 nHSuDMmpMFJOPqO7i8THbIE0ufQqK78j0wHsieP0nCPCrM7JriLXdPJvAQIg9PMVDvNwb
	 fFo1T7dl1x4wq1JkpU/RQrbVO2EGmiG0LLDnspMD9c4PSpHEyDxZcFlY6Ku5ohd4Btfxv
	 fWRNJmPJvAfJJgPMDLiu0nUFxvqKZ+/Goc2WbOhbT+iTuMD7smI3h4u9IDnWHIHcLSRCc
	 iuDywE1ao3u/wDdIQf6oxxsrJkYqAc/Us5GJGGfuk0jAAnzanpZEehX4lWO69DgSRYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FmG3IyhSjaUBd9pVB2Ah61BXJF23t56t3faR7UzfUPM=;
	b=baiuhzReIaCcYqXbkJZHpRADz7u0j+mPZELIr4L2JxpIBTO+5uI8ZEkKwI8Kb2isJ+Sg
	 ezENyfON7A64RY1mj/Yn9djyL9QhVa+VL8AZygi5ZfAaJ1AhqUhwYKKWDnKqGr4olFDZw
	 nCXA8////KIfWeCknQLkqjA4SEmlzVI9d4IpGzj+uBJKhsHwCcAAN4+q5o3bIs+mne/U5
	 UAo9XWaVwTY0PMEXnpp11OaqYOb5Tbg1mteX141NQ8FCxB9Q4uvRpJkFVJxIO4K9NfiHk
	 mmyMzMR4H3yMMnQ/8bz+Y0JzaUFSoobNQLJXC3NCIrm6r1fFFxBH/sPagudJqWw2cjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrNKtEFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957C606A31C;
	Thu, 29 Oct 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrNKtEFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3386A1F01824;
	Thu, 29 Oct 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292360;
	bh=FmG3IyhSjaUBd9pVB2Ah61BXJF23t56t3faR7UzfUPM=;
	h=From:To:Cc:Subject:Date;
	b=OrNKtEFBKz5snJLcapaz05qn9aIF/xTUS+O1Qd0D/kD8lugxNYckkMwiHGIilVYK0
	 wpqsfhCli+5rdzJSbeBgSpWCLFPLwT+m1mzUM2MI/+obKwM4Ukyw66dI3bW+J/y4FO
	 El2z9OhHuzxrC536GOUryndVP5LMCAquGAxYm6drmadC8mDeebmOR+7e/s431eYIpE
	 BAXv9+mNbdNIYdocaDOC+KYiS7NP5nksEMnka/LslCUwyGfVMav29smhvLmutkqr6O
	 GWteoxZ1OYU4xCPrUxixHhZj1QZfel+XHdUsMpogoNtgl/OXVIgNakxuvIYbhZUVMT
	 4Xt2ygV3oJlmQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dinguyen@kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: stratix10: fix i2c node for emmc and nand card
Date: Thu, 29 Oct 2026 11:45:55 -0500
Message-ID: <20261029164555.672439-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eMMC and NAND daughter card uses the I2C1 node and not the I2C2.

Fixes: 4bc04eb90b7c ("arm64: dts: socfpga: stratix10: Add emmc support")
Fixes: 3c0f3b8545e7 ("arm64: dts: add NAND board files for Stratix10 and Agilex")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts
index b2a3449638dd3..bda2fe059beba 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts
@@ -51,7 +51,7 @@ &mmc {
 	clk-phase-sd-hs = <0>, <135>;
 };
 
-&i2c2 {
+&i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 7951ce46ae1f6..a450c42a6b35f 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -124,7 +124,7 @@ &watchdog0 {
 	status = "okay";
 };
 
-&i2c2 {
+&i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-- 
2.42.0.411.g813d9a9188

