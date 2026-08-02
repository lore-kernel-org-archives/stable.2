Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66571237180
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697702; cv=none; b=eGzsCBRWA6Jk9rstRRnPaLmIrsi56UXFWn6lhQJW6bA09J2Wl9X0YoWGz1em/9wIK9pCvfFGKmbBv3fKPgJWMJJIRkcvIGSx6CflO6lfu0qk1xkh3zl56amVY9neXjmXzq6WYZA3uOb98pvS7/s7HxVlwX7taSY8HYm3ntUgeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697702; c=relaxed/simple;
	bh=2hOmZdPlfBzKcHtwcK27rodmO/H/LByEIMeVmYI76r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h0zVpc5CyAXlMfGjtGFIYhDUCWLZaOe34ozCuC6frfka04AL34ZkaaVpjgqUBKXCw3zwARdISap4wAcztbeRQY6Dv176HkRaZo8ByMQGyaxVFlPaTAXSKdX99MEY5GX1+eZSNp+/EOlGRiP90T7tL4O2/sEYxvBHDg5fOdtlZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=cwVtQgf1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="cwVtQgf1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1785697688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCeDnJm35+LyDL6EE/vXkfkMVeZz2GdJ2gAVeksgF8c=;
	b=cwVtQgf1m39N9bovnrEWwjoCe37yGmY6hPciRq/PfJHAICFIGuKZccUIxBhJ2Bfw8/RCnk
	2FIy5x8BTm3dIbuCVwg6bGCquSBQ3w27Oafv20b9Yapkk7EEvOQpgBeLEDKKqcOSuDq2ku
	CSbC/xMt3qWHNNiXnXUrjSfSbNT8xXmb5ID2mJjfVq3tK1GvTInwPT4428qdPop+MrFcs5
	0vZpJBWlzlmR0Chhrv8XcIknlNMhoTS1l6qwKwFHNZXOmGVeWqLnwA4TGHoKlyMrXznYnC
	dSjmWzozi/B4pxGC9tz0MKI0qsSgepGqANR6ep5LD7xByP9lh0VbG1vhkq5a2g==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Sun, 02 Aug 2026 12:06:42 -0700
Subject: [PATCH] arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-judyln-sdcard-fix-v1-1-b3477cfc42cc@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAyF4auUrBuYBm3Fq0gXcRLbFBllYkUpv
 btju/wevH8B12zqcK4WyPo2t0cqaOoK4shpUDQpBgrUhlMgnGb53hO6RM6CN/tgQ5E4HLhjOUL
 5PbOWeWte+t0+XyeNr38I1vUH/GqU/nUAAAA=
X-Change-ID: 20260802-judyln-sdcard-fix-12c2a04a7ad5
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anton Bambura <jenneron@protonmail.com>, 
 Stefan Hansson <newbie13xd@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785697685; l=1870;
 i=sajattack@postmarketos.org; s=20250413; h=from:subject:message-id;
 bh=2hOmZdPlfBzKcHtwcK27rodmO/H/LByEIMeVmYI76r0=;
 b=AFOycZYR4EEw1U+zGFN8WNqUPPIrcnit6NfhcTP3n61vxYHgvZc6O43LEPwbRSJBl5TWtQvGk
 JYCmseMidMpARNlo8S7ToGE9lQDEvkQqxnpcBnsegtAaTk8THaqEmfh
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=ZFE/UBqiz9Wr8b+zBL27opOjw5x5ket5JFqks/VQGeM=
X-Migadu-Flow: FLOW_OUT

sdcard was previously rather unreliable during boot on sdm845-lg-judyln

Identified and applied correct settings from downstream lineageos kernel.

Verified card was properly detected over 5 reboots with rootfs on sdcard.

Refer to downstream: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/efa8458f79dffeb380d43b38b9403407f87d9f05/arch/arm64/boot/dts/qcom/sdm845-pinctrl.dtsi#L148-L303

Fixes: 28ae8aa3923c ("arm64: dts: qcom: add device tree for LG G7 and LG V35")
Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 5ac2e058827c..055d17e966be 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -581,33 +581,26 @@ &tlmm {
 	sdc2_clk: sdc2-clk-state {
 		pins = "sdc2_clk";
 		bias-disable;
-
-		/*
-		 * It seems that mmc_test reports errors if drive
-		 * strength is not 16 on clk, cmd, and data pins.
-		 *
-		 * TODO: copy-pasted from mtp, try other values
-		 * on these devices.
-		 */
 		drive-strength = <16>;
 	};
 
 	sdc2_cmd: sdc2-cmd-state {
 		pins = "sdc2_cmd";
 		bias-pull-up;
-		drive-strength = <16>;
+		drive-strength = <10>;
 	};
 
 	sdc2_data: sdc2-data-state {
 		pins = "sdc2_data";
 		bias-pull-up;
-		drive-strength = <16>;
+		drive-strength = <10>;
 	};
 
 	sd_card_det_n: sd-card-det-n-state {
 		pins = "gpio126";
 		function = "gpio";
 		bias-pull-up;
+		drive-strength = <2>;
 	};
 };
 

---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260802-judyln-sdcard-fix-12c2a04a7ad5

Best regards,
--  
Paul Sajna <sajattack@postmarketos.org>

