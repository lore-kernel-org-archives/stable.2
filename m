Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A844ACC74;
	Tue, 15 Sep 2026 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511158; cv=none; b=aJ1d+bf3p6TzIm36V7XwuKAzJxspqjC4Cs3cn0mBMgJtmrJZpYXiO91bVyM9LF7SnhpWKA5LsZ3CtExlcqn2HgPQ5UbEITRYr+HqniQtNPY8VQ/yzgnXU3FaHT0UwyLwOQ3DZqAkqYQho4XnzbA8ph3TuEZpLXk7qlGrUsdFqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511158; c=relaxed/simple;
	bh=54zf4IhvJuQYjs4r0d1ivu6VMxXA4XmzlpQG3WEcAug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKQtUwgHRDibL6av1ddx0K58HFg0LuwsL1c766JpXneEwGwY3MC2vx9VH1HMaezFF6ZL1gvrXc4wYhQbYFJDouCfg7J04iASkxAwnMAQ2JjAUrgXHwvh2L3N2fiF2Of7gVF1UdCTdddgsFA76ov+GGsHOOq9RNHxmciVbBtDMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhSmslE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhSmslE2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2171CC2BCF6;
	Tue, 15 Sep 2026 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789511156;
	bh=54zf4IhvJuQYjs4r0d1ivu6VMxXA4XmzlpQG3WEcAug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EhSmslE29O3sUCEGEG4UHOyUzGc0beWvfdgpkSQ/+sB5Ob/uXJmbqlRFJEZVPMtYD
	 U0ZgQbamwX3lY4HG3VHGp+1Z1m6t1TQqvvA1P0neVWxMApxh7zPPqdOWDAzQDpcdVb
	 ryWMoBg71uiKnUAztXVMX16nueQRk+EklnG1fNE413/wv+4hIoxknDI3cBz8j3XZ/r
	 IoKOaQpr6rSvSx/sUvFA2PSGSbAWGkWdhTZK/sxLjfg273H8Oa/8CzGV60GBkJexpR
	 ESTAk9+GfhYtwWNuLldoHSqIYSWDMo7R/ud/mwfE0uu9WflXE/hy4qpVXIXe0sAodJ
	 X0xR+jc3SLSBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC1C88E75;
	Tue, 15 Sep 2026 22:25:56 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 16 Sep 2026 00:25:46 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the
 xbl_mem region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-sdm845-xbl-mem-v1-1-6e3c88507997@ixit.cz>
References: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
In-Reply-To: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, 
 Molly Sophia <mollysophia379@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
Cc: Konrad Dybcio <konradybcio@gmail.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=nkYxNGwqi71eWLxoR5wj/HoAFsGXPhGtpZfAJGRQLec=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqcXyhjnlZWX7C1cxpCl3Lx1Rfj3NlhXI+TYhL
 vkwFo2bGdmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqnF8gAKCRBgAj/E00kg
 ciejEAC4S/CPMXUM2vUubes9T7thsCMCtTny3IncbHCk8GVSUXTYikx59oAYAalERluT6UgvWFv
 OGbQBoLEej3+hAC3D2vNNRcrLy0OpChM+G6tyiGd8mvmeylRIxrTbwPSl1yHkHLDSjvy3/a5P87
 D+oqhQUCbTa7RaGPFefY7QD1O5oeJ7x/YdIfyQIvq8fLHLb6dBUOkqOCCeZRapyBQ5hM18StWPz
 kz9rQkCnYvrXqcP35zy83SRFiybadVjR1kpwdkOPxN+URWMVtEbAFEyI6wsaO8IxQsrZckJQVa/
 9PILag5dkIO5JYRQrT3/VH55ARkHhzn0hqTBRxm+kt5fNLA15/gfUd9rClkJmYyzBcnvbxgc1vc
 rY1lk9+LYJK7c+7s0sQCI0S8jDIibFPsKbYmODW5SIR6qIhK7BKNckLSWxe63EBqg4AKV7pf+Hj
 2v/9xnuf2XmY0cG2OCmtWkqmYGzHtqpd+AJMGk/aQvkbnLEEF0F2TMZFcNx5ryxRqpXhGmpwcgr
 s7jFBXm1WIwP1s3jUsKZKlRUnCTxl8YoBVy9Ae9aI+IxK2JU3g7kVhT220PH4lwxhmQGyXjEB9W
 0q6qlqRqbfR7d2Tx/R1xF1VVBz241iKIjROoTdCoNjPD9vANpCahRWRpl6oPg8F+N3XfFDw7mxN
 Gmbn/VZc+QpCAkg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Xiaomi's Oreo-era tree still had the CAF 1 MiB region, the 2 MiB version
arrived with the Pie import. This isn't a board-layout quirk, it tracks
the firmware. The later XBL wants one extra MiB below the old region.

Cc: stable@vger.kernel.org
Fixes: 77809cf74a8c ("arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 080f5294988d3..35babe8c5f757 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -22,16 +22,17 @@
 /delete-node/ &wlan_msa_mem;
 /delete-node/ &mpss_region;
 /delete-node/ &venus_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &mba_region;
 /delete-node/ &slpi_mem;
 /delete-node/ &spss_mem;
 /delete-node/ &rmtfs_mem;
+/delete-node/ &xbl_mem;
 
 / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
 	qcom,board-id = <69 0>;
 	qcom,msm-id = <QCOM_ID_SDM845 0x20001>;
 
@@ -66,16 +67,21 @@ key-vol-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
 		};
 	};
 
 	/* Reserved memory changes from downstream */
 	reserved-memory {
+		xbl-mem@85d00000 {
+			reg = <0 0x85d00000 0 0x200000>;
+			no-map;
+		};
+
 		tz_mem: memory@86200000 {
 			reg = <0 0x86200000 0 0x4900000>;
 			no-map;
 		};
 
 		adsp_mem: memory@8c500000 {
 			reg = <0 0x8c500000 0 0x1e00000>;
 			no-map;

-- 
2.55.0


