Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793297548;
	b=z3Xy1ToutTJJJvN5g2ZrO/LkGf05a+NvZcDlWIESqTap48ToE1q37SSX1pcez62w7TZk
	 KGcUDYNvgGesNmbRhKDgrcHNrr0NBiyGpoaIJRfv62kUxO3yhLPCewTbachXnf95BSrJu
	 Z58k7LKJgye0m6+0Qtj9NF3nm3y5inzAHRF5M6sH5W2zrumNpy1NDf+pHeieapNxIPsCO
	 l1J3bVO8MSdc2SORIG38bnE51gE5q59JpmYs2N/iP7T+bR8iFBaEhh/jUMQqquEPFnwVA
	 72qXRPLFbSKkJKTvWU932xvWUJKgVuTSGffQ6yVF1QTsgjmI8fXFNA95do6jWe+MtmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297548;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vc+dk4sXUAznOiMsvmZSS0emw2t3qJrqqCqk1XvgqYs=;
	b=v36ruXcCboulj34qlHA4SI0gg95gWtJAhf9JjHAXnUfigvTY2URWD7ltcgOzwpv17qlP
	 4r/5eg9Bx2BSiHtdBYEAUwnK+XSRtxvP/M2WZW8/qof+7Sp8WOKEbppFFkLaEzgBbNckv
	 8cwt6cMpm+5MeRQcqLz7bX/vb9FrYCDQl2tagFs391v8ekEQLh6o0MHmsKyMA6zFY4AJS
	 yiJcDOKQ6BA5lDSU+0Aw5vgG6vPHoIeLtQmiU/ZLAkR+P0r38rC0zomdgURKnyXqFKiDm
	 Dx3fjwZEHgWVc8huFPVE42r6HH7F0OW93irS+ckPZSwUTyfXDaBH7T5R7szymNVmy5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIzgPmtW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BE606A31A;
	Thu, 29 Oct 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIzgPmtW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793297547;
	b=oDBCn3IKh/jOMEo+O5TGEpdSCElDKBsZcHW15AIqx9LxxxEvXBWaqOovD+E2ihtrzOT9
	 8Yk7pcCBl2yRcMJUicDYrT0PemI8dGj6hnssYjWdgZ2tpff8/L/QPkMK1ra51mwpyIxyJ
	 jwz1ZCjxmq7xOzYoDrzHe2ldVDFpd49HG9Sb8x13APK9/aGkZyslWPpdGlRk7WVdf9o2f
	 TzLhCOaWXMrHZO5avR5pVaqguwYWee+AHdRIePe4H2kdXvlRSi2qS6OMPsol1npQhr67i
	 86tr+3Yt4oPj7xEE7MclZuRtqhEQcWon3Vyrw8a4wRIuHr1F192jTft26sgjekm+psA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793297547;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vc+dk4sXUAznOiMsvmZSS0emw2t3qJrqqCqk1XvgqYs=;
	b=RA5FKBXBzVrdVeJWH+8bh1xCBk6lo+mdLwYdKyeSsF/bb8jfpG9iWSgT7Y0EIrIaKuaY
	 6qBUs0MK3naReOXHv28ISvSXuOTpriPdzbSqWLNA1sAdkA8FX3SoGHrIFz/MMZ4HqNRrh
	 Cn8TaSv74+wWrMMZbq6vteqQKL58lgceHBKEqFVRgJcVBWj6U0RXmFiLD3PmRMID9wf3X
	 P6DE3fPbpqefsi6Ak7PCNAth/Dw3+Z8XYD6PixGtMxwWb5zSMKirwObTL7SHWS8jlW25h
	 hjkXsa5rIFe14vdS7hEXOa/BSb54ixOSinNwfYRB6eO4cHMYCQup+DYRlK2bni0M6hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 36A501F01824;
	Thu, 29 Oct 2026 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297547;
	bh=Vc+dk4sXUAznOiMsvmZSS0emw2t3qJrqqCqk1XvgqYs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=cIzgPmtWSPM9ByY4xVnebopFV8nPtmzVizGxn1LMaHsOniW0oKpegm3Gya9xjHpzx
	 QodWmKH17/l6cf426VcBSgPUJaTf1nCU9RHpL+Qy6gJNdl1NydYvXm3FlsvPq3Np3z
	 ShZG09uXCW14tn59McdG3fTNHCGIsl7AGe+w36fbVHY9uCQXCnbZoE/W/5R53YEor8
	 yZw26XqvoGZtdjT1E1OCJiAk+nXLjeZvC3fTqw+3PrndYQHG2DisZXlATBU7EWM/yF
	 1pzUQXL7nEqjHKsEgAOZj/PZ5+s97uyRxt8gG7LUebNbeoXujxCiuNqzMUponctIxR
	 5IPzJioEHCSbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BB16A45935;
	Thu, 29 Oct 2026 18:12:26 +0000 (UTC)
From: Vladlen Grachev via B4 Relay <devnull+webholt.gmail.com@kernel.org>
Date: Thu, 29 Oct 2026 18:12:17 +0000
Subject: [PATCH] arm64: dts: qcom: msm8996-oneplus-common: Drop LVS2
 voltage constraints
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-op3t-lvs2-fix-v1-1-42ca9d992c20@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bsHMIvtKdAhbayFSNCQI/550n
 IGZFxJFpgSTeCFS5sT+qtA2AuyxXjshb5VBSTW0Uhn0obvxzEmh4we1tqORvaVOO6hNiFT1/5u
 XUj6vgMRpXwAAAA==
X-Change-ID: 20261029-op3t-lvs2-fix-44c8905ce34f
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Vladlen Grachev <webholt@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793297541; l=2127;
 i=webholt@gmail.com; s=20261029; h=from:subject:message-id;
 bh=HebHQtTCozbcTjBAD2cRWkL8+SEDKdyhDnbeViDQK38=;
 b=lRJ+qH7Rt37iPLxVprrqAsVq6NOKR62bVoWBe6x0IUwCAw+I7n+az0QKhhiMKSpk3JylSNISV
 ywt0RvU0gRpBXfNeZ2dkJoqiJ32HYRIyFz25kCtcPCOvcOlCF1H9zNU
X-Developer-Key: i=webholt@gmail.com; a=ed25519;
 pk=8kq937AiLEx3pRQ9J+BUXm28cQqT4RyMTPY5dyb04kc=
X-Endpoint-Received: by B4 Relay for webholt@gmail.com/20261029 with
 auth_id=1356
X-Original-From: Vladlen Grachev <webholt@gmail.com>
Reply-To: webholt@gmail.com
Content-Transfer-Encoding: 7bit

From: Vladlen Grachev <webholt@gmail.com>

Since commit 27880745470a ("arm64: dts: qcom: msm8996-oneplus: Add SLPI
VDD_PX"), OnePlus 3T no longer boots: the PM8994 RPM regulator device
fails to probe, so UFS, USB and the display never come up and the phone
hangs on the bootloader splash screen:

  lvs2: failed to get the current voltage: -EINVAL
  qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
    lvs2: devm_regulator_register() failed, ret=-22
  qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
    probe with driver qcom_rpm_smd_regulator failed with error -22

The switch LVS2 cannot report its voltage, so the regulator core asks
its input supply, vdd_lvs1_2, which is not described on these
boards. Checking the 1.8 V constraint then fails with -EINVAL, and the
RPM regulator driver aborts the probe of all PM8994 regulators.

Drop the constraints, like apq8096-db820c, which describes LVS1/LVS2
without them. Keep the node, so that the SLPI still gets its px-supply.

Describing vdd_lvs1_2-supply as S4, as done on other MSM8996 boards,
would also work, but it would only serve the constraint, which has
nothing to enforce on a switch.

Tested on OnePlus 3T with the msm8996-mainline kernel based on v6.19.5.

Fixes: 27880745470a ("arm64: dts: qcom: msm8996-oneplus: Add SLPI VDD_PX")
Cc: stable@vger.kernel.org
Signed-off-by: Vladlen Grachev <webholt@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 7a3f8afae..98fc45dc8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -497,8 +497,6 @@ vreg_l32a_1p8: l32 {
 		};
 
 		vreg_lvs2a: lvs2 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
 		};
 	};
 };

---
base-commit: f5672a3dff0291d6a45eb0c258b9d2baeb4dc577
change-id: 20261029-op3t-lvs2-fix-44c8905ce34f

Best regards,
-- 
Vladlen Grachev <webholt@gmail.com>


