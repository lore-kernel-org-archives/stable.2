Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55C3F8226;
	Wed,  2 Sep 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382759; cv=none; b=p0g49HVu8Kxkia8OdNuNOtj37Yqp+N4laOuE1aXPwC9ePdpRZn5q9ak3XE/OLB3zsyOybA9xrbcSBrOJ5Z+ZXMM5dhHlwxjLkidlIgINy2dj7LVafLoRAxKfvE8Kp7+WPhJ62F1NOWRMtVEEm7vpYFuqFnkaAjNINK+N4CjD0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382759; c=relaxed/simple;
	bh=ygV6uynBNTvJ/N1k//rza1WLAun6ScEs+RIRh+uaKD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9cS982ANQlezaEeLPSnaqM9JBIEcp8U7Izl7h1KueMQc+40iUpPsApzaWRqcW+dkvNJ5pZRp47ejuUbMB85U5I1pMEdyQ9kJLXSMeSnyHlcwnfxXP6FgcY7Ih+rAptG4CFfDz560kTdbBjVtSzmUTg0UJNw+T/Q5fONWvjSTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovRlTkx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovRlTkx+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D46C2BCF5;
	Wed,  2 Sep 2026 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788382759;
	bh=ygV6uynBNTvJ/N1k//rza1WLAun6ScEs+RIRh+uaKD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ovRlTkx+ggy0k9blom6CGY/rfWOJhPDW46NDjFQCSDG5l37Cgj5eUxZiBHiVLPuHI
	 fsZnx5RXghJEBdoUaLWavSVb53wQtJavrHuBSBsj1bCxz0jaAFKUSSvj8NJEpAftK+
	 GV+ZrnBJhe55sZ3BRvEVeqo5n+tVo1hinTJqMQrCZ9Arp9n8uvG/Uf+3p1/PHWnYxJ
	 3s0QrF66/zCwlbQ6rkUpxmTroE1hGEEePLg4TRNC9b0aR1+w0XNJ7FP5rnpoNSh4ci
	 f0pgevchHMVVPreJpZSj8sB4Ox+EtkkJq/xldCUsrqr2U8yMmf1YGwRZiqHC8/s1c5
	 sZGkelFOLdSeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE67C624D4;
	Wed,  2 Sep 2026 20:59:18 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Sep 2026 22:59:12 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845-google: Set i2c3 frequency to
 400 kHz
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-sdm670-sargo-nfc-v1-1-bed1cbbffc46@ixit.cz>
References: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
In-Reply-To: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Richard Acayan <mailingradian@gmail.com>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=T/CRKHYH4PIgdGiSr8q4F541f/u8HxxrZ0dMSKkBtEE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqmI4l+pCJ3gAVi1n8xvqjRvyWxHpn+m0A5goCe
 gohhxLxPT+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapiOJQAKCRBgAj/E00kg
 crogEACOYjOXFkXvRhVblWYmN1Qp5NNVlbfikzjXOt1Zxa/KYTRFPlouVMDHBxRSDP0ySBBbvbj
 SJneiCh9dIzQ8thojQKGxgWhnFrs9xaWNWQYJpWp9pilDU5vFb0ptCnpw1tm6NEwroOzRYvsgdn
 a2fTvW986kqbHOtldB+Jn0XT+7pcn+g1wK0Mr2HgSMVjD0KSZw6/yrkAVtH8aC32T7X8K+sFjzz
 7PFHzDJ7PCzdHYAK+17qaIUNbX09J7aAh7LDnCid7uYL5raycbd5k6Fb8acYXrFW93rOYlqSaPB
 IbOSkn9AnSUCslfAW6jBDdszYDidQj+AxWFOzctXJfVRnnDXWhocCk7nOLJWoQhgWrncMlP424p
 P1rneMsrVaqb+oBY+Cj1AbsSvDVxEQkcu6Bt47ZJJkz/rarAgVEexU4BMPPDulFOM8IsF4gffiq
 RnlPYbgSAmo5EFjdjl+QMCwI7CuWs+Wp6tZHc0C+tC5mCj9epeZ2Yp43yac10gbhMcwdb5VUzzT
 T7+RnYIxe3BSq2rleumRUeld80bJIoy/VEnI0JJJtyYfuxRIsU4B0GfZDiGMCMv6S4+B04lhVF4
 K5m3Aj8mCbicU+ygIVPMHbQzWgK+IuvFvKJ0j1lAFq8+vlGxeQX0PPcaux2ITgboaV4Jj5oraE5
 S8A3249GzIx5XPg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

When downstream value is undefined, it fallback to 400 kHz. Set it in
mainline too.

Cc: stable@vger.kernel.org
Fixes: 10f91b0dfaf6 ("arm64: dts: qcom: sdm845-google-common: Enable NFC")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index 9e952f9862f24..f73d4ea57705f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -387,16 +387,18 @@ &gpu {
 	status = "okay";
 };
 
 &gpu_zap_shader {
 	firmware-name = "qcom/sdm845/Google/blueline/a630_zap.mbn";
 };
 
 &i2c3 {
+	clock-frequency = <400000>;
+
 	status = "okay";
 
 	nfc@28 {
 		compatible = "nxp,pn557", "nxp,nxp-nci-i2c";
 		reg = <0x28>;
 
 		interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
 

-- 
2.55.0


