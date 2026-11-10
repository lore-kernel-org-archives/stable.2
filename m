Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311894;
	b=eyedPGdZIqCLPDdf+d1R7Zunyn4RZUlOm25PPIRLWguiH2ysViCj/VN3/NlaBActF4yh
	 E7OtrKjMvh3731ZXeBP4KxxjvTiGlm2WUrcz7VcU9UC2bdmsuKNH9ls5QSXQg6IwhjJOJ
	 y9SoIpukVfGQ79y49HeDuRqe0KuPXIN9k76s0jeCPLHhG1SYxXvgGCwZDmi0Q4c5dRM38
	 +Cg00/52QoBRuEKvJaOIZcig4uxQUneV7ZaPJOWs1DSUKVX1cwnlKyuTb7GoOnz9ril9E
	 rcEyXLOu7mdxNRMlAitKUxuVFO5nGMcROBuYtx/unQdjWtb1Vn/84GaNdSEzx/vBeWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nm+GX4WcZ3kNHvpsPK+a/kV8vGM3Dphdvw4/FqFA0hI=;
	b=XBx//B9rF4JIsv46nzB7FSd8hclM1cBVjzrJerCry7BNLZjJmObBEeUelb7ZsOyco/eq
	 EIGTlmexUK/lfxYxypn74WmFFApqXlmPaSjiDJiPP0/dBGRx0UZylThNFx7Uxm/xSTS9N
	 bJMtpgVKN+xsldTBVF+qbzhenvX97X87Nt8oHN2n/iprmFyhbYbkCHkxtR8cBh5CMZSDq
	 2cW9HTV0lJHFgIXtk6H8nc7Vco+lXenlAy3V2AnhFuiyLpTwilLN9TwcmFk4FfEHdp6Kq
	 8og7RETivlMADnz1i+DMe4+T0XueIom1tfgODE+tqdb5yw7CozSOTM6MH7d2Gq2RJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdhhxXNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D2606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdhhxXNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC11F00932;
	Tue, 10 Nov 2026 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311893;
	bh=Nm+GX4WcZ3kNHvpsPK+a/kV8vGM3Dphdvw4/FqFA0hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdhhxXNrmH1lAwG6g4F4Ze9qYlIKaiQIqn1UQPlyGzWzqPGfVu6f9CSR2IMkOc67Y
	 W4KsTrtwUSBuIkgyc2nl9uVYGWF3PM9u9k15hdBqRLimthzWY35zOSBIagW3k6DYEs
	 g1y2JV2lbKYR9W1zyJkfCGbK22gQvksSbaQwg9XvnY3RWdJKUnjK5U+1X+f2GzFAa0
	 Z5P+ogIZ47ONGEXAelH5plXkTSc8rYPa0Ib/1bToLZnnp9MD8pVFtWceKv/QlkV3a2
	 roNNTs2NLXPF9EjvTzsn/KcFUWUbt5tPJvLlf23zZJ5u8xM0Zwf9fTX8uO+xUFc4OX
	 aOF6ZLfpMJFlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC
Date: Tue, 10 Nov 2026 06:58:11 -0500
Message-ID: <20261110115757.884247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051753-failed-6.12-117d8d40be1d@kernel.org>
References: <20261107051753-failed-6.12-117d8d40be1d@kernel.org>
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

From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

[ Upstream commit 117d8d40be1ded4f35f3252efa83607a7134d5e0 ]

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Link: https://patch.msgid.link/20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ sashal: Adjusted context to preserve four zero placeholders where upstream has PCIe PHY clock references. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 81ccd0600c5ab..31f97309c5330 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -315,7 +315,7 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <&usb_0_qmpphy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;
-- 
2.53.0

