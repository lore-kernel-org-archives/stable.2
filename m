Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312206;
	b=tcNEsi90OCVdQVtW/AxgcFirssW8bOJmWm9gCXShK6m+kqmYeOSZtlPA/R5HvVMlgCWI
	 l3V1BZhNcBX2xtzq8yJIFlLasHyAfT9mdeSJdOOXV6jwS+TfU/MZPNEHMlJnhjsEFn9xe
	 fIWLA/iz3A0eyfnHy2v1rO7alOt+x9eFPwstHVFU4DaoVb2ijPW8hK9leIdfwOFXY+I+1
	 dq9KrgAfzvTZgU41NLS3GfwWcDI7vpNNOnu7z+5T56PmKlcXm69nWY1jA2iivBMxXp1Re
	 PuWKvFGyuLSznvB5kJ7FGVBfLNyphCZjoBOCJ58IAS6JDieqfzHYAfAXVUtLHll87jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1tf/DwUt+p5daa7AR0/Dx5eMaqwikxhKwWDMnLngtn4=;
	b=bVYBfFkKsvjyaOUfnJsvHUouVDmNEvflTd3HQkMLrCmRpKczWbHuTBY2e70chwuvdqd/
	 h63sMh3jCS2qGHbrDIPBe7D987ZjDXA95PSjEeiLZ2g2qKgKYZeM94nkgJJklKvnY82Cs
	 eyG2bs+KoTeIi+SoUCiQ8YF/d4Msk0xKO+yZI2+V23ZZkjfrbNv7T+YyWRJwAmc71OthB
	 8kfUwcjEKycT64dRqaRyPsBMrdaPEAa5Zemf66k3E7uhHcAxagFOkGkCh5xlU0upnQdv5
	 lz5YiVHwYtgcV+tomsL+ldV8QrEPvqhIS1SDFmBwmqki5iHz1c5vfAzksNjZqQzcTug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BIj6r8/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIj6r8/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE921F008A2;
	Tue, 10 Nov 2026 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312205;
	bh=1tf/DwUt+p5daa7AR0/Dx5eMaqwikxhKwWDMnLngtn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIj6r8/nljBY+pSff833AVrYBYEl+IWeEoIqBwqotqCjS2ahOqmvylhytXm/fHy6v
	 mA/RnExMowsUOOMYBes8a3y+ZNxys8ZfG4te5rb9B3mHQigKjlE2kBPB1I0NMFK26z
	 w+Qa/UXkJsIjI1eUF3oCesj0l9rfACeBrRDPu2neb0d4OIl9FEABhzlDZElJyGgr/i
	 w63yVfGHtj1KlendUK6oL3Vfs5frr4NcFRxL1+FXdHNvWRNPVXxVQgTXNKm9AKUdOW
	 +u99DaVY7nO3eVTJtccsVP86zj4nEebcDsb6cJ8h1edlwumTMqmuejUDEBmkT9fLwc
	 Q1NNJKwBsI85w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC
Date: Tue, 10 Nov 2026 07:03:23 -0500
Message-ID: <20261110120312.954339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053028-failed-6.6-117d8d40be1d@kernel.org>
References: <20261107053028-failed-6.6-117d8d40be1d@kernel.org>
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
[ sashal: adjusted GCC node context for placeholder PCIe clock inputs and power-domain cells ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 82e4fd5eb388f..8a5df358d459d 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -285,7 +285,7 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <&usb_0_qmpphy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.53.0

