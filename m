Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795161947;
	b=a+As4N+aBm3mJY7ohFCDy5UqMeUZwDqvFLgtAkyy6SoHOUZ/1TeXINRh92GZoJC1Cnf5
	 UExZOHPrJB3yWO9PsAe+h4bJ3OqTiW70hl/18PqVRkbY0kanBhYus0X1SkYy9kKoDtSlX
	 mQfTxxiHETQszVbqFxQaRVDGWPyOC8y4hXmbfwkk8WaQoQ1qYu+l2WAl3wy5sGFXlN9MS
	 BfDZeICONI7JwmfRZ9BQqsnRtf1LX312UOTGC+//OZP54pWmFWPw4F9h2BH39YPtQSJ7K
	 x/IXm6tZ2MhB+6qzAxyzcJIw9d2W+3aa8rwcNZbT/Y6Hxl4hoiv4/K90QDr+8pCGZTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161947;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1CCLLifsL2Rt/fNIsbk4fz19PYiaB/uBdRSC29MqK5Y=;
	b=p2WRjOJHiE03H9VJgCWN7IHpjn9orKU84Iq1icb59gQ68LWBm3PwizyN3oVJiT6GvIZt
	 1Q2mcWdC4N/x98Qwz+e8Osj3Wa2wAR4bcWkQdMhEjL95DnoLf5VX32Cnh4pjqTJIZXdTH
	 lsmdN45YTJUNEVCIdnXgl/1F2XHSluQavWZpwpEtImZOur+xBAOu8GkziBxIsj04a/g9H
	 XfhrNZGvGpbKBexjMih6JMVHo4GbvDG05z8mKncZOyv+rLuIWL/VczLbR84tfRhqfikfQ
	 3ZkgUqe+UMsvNXtfutwrT4Nq3i6xcnHseGqNXhwFIdSPTxJjWc3LHI8uF1ETgb3dg0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYtf0b52;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B5606A337;
	Fri, 20 Nov 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYtf0b52
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795161947;
	b=M/eZaaIpP3NO38aJR6vLEXvmEUbz1XyWW6XQQHiaqcuX14uqSMTCP0TccUdH80zYfABe
	 VPGOnU3rrNH+rgfMtj7rTgYlXLF3mVAO7Dzr/+8ZlbG6m6Dn340/M8TI+3xRGjEZTmuaw
	 sNbh3buEBglnZqv/pDXKt/sGJEs+nP4/Q6ofVXVzgN/hywG+gqpdP3ubpTXmtsFIHopge
	 5Vg8KJXMpx+s7aojd6dLNmjpRSPoPTVN2Df2M4wlY1cU2gQoHC7CEZwzUz71+22DvJVO0
	 bYjzszDP7q4M3bHk/mgwJbusj76Q9ZbMgZbc0m1cBrAQ3fEZ5j3Mu1jwiXYKhLVJb6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161947;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1CCLLifsL2Rt/fNIsbk4fz19PYiaB/uBdRSC29MqK5Y=;
	b=uslirGbI42j2Z3NCxeEd+s/CpAHI8FLf7HeK5wmhBpMSy21//4Vb8AHIPokVYRnvWJzF
	 XBKkV7VZnW8xL5g53j0CLSQHd2bm2agHEyWcBeA0KZAdfg5g0vR6BfFJcUaa6g3efKdWD
	 gRD53doeCY8otr8NUlJNaq/mZ0NBKZmHbckhcrUGbmGhUwAWSZp+Mqn6wIkwMvyxIgfEu
	 PWL6JxvfTc5yDpccM+bmetVF6pSfNCim59PhfwYABH+tkjtjX53OPUmyBRGI4CtVEUSyi
	 5i33vX+dZxz5BQq6n9FTzOLWEAj8OuQcAKeDj1iADsRY6bPL2ROfX0fyfMYlWryZH+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C78131F000C4;
	Fri, 20 Nov 2026 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161947;
	bh=1CCLLifsL2Rt/fNIsbk4fz19PYiaB/uBdRSC29MqK5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eYtf0b52jFiOyCB6bG+MFsa+Mleqj8cResw8rScAkMFwe4oqNRZQP1KrfKnkyr1uc
	 bWixMM9R7yJUdaV8QLTToACIdvIvyX8R+W6igG5FbY4cTCBHkE+AyaRRLs+PjNNUNR
	 jU2OVL+iAIPFngHgvv8K8CmyI+WBEbddislSHj7/nhn3ND5h+8DXxgSSHGu/vdlVsx
	 OCyoyUHlB/oukTyPWoS4wBdsIgxbZqFCa4kK2shjmsjSWWUt9uLy08n8rt693LZ/Wb
	 BhS8yFzlnZEqmHWUqCttlYHZ7OmlmYcZWogGp7i2KA6Y8IqL9GM8whdmA+q8ivgu6l
	 6Y88EZ397GUjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 545854976C;
	Fri, 20 Nov 2026 08:05:46 +0000 (UTC)
From: Alexandre Rapaille via B4 Relay <devnull+arapaille.atlr-engineering.com@kernel.org>
Date: Fri, 20 Nov 2026 09:05:45 +0100
Subject: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt
 trigger type
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
Message-Id: <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
References: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com>
In-Reply-To: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Luca Weiss <luca@lucaweiss.eu>, Eugene Krasnikov <k.eugene.e@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org, 
 linux-wireless@vger.kernel.org, 
 Alexandre Rapaille <arapaille@atlr-engineering.com>, stable@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795161947; l=1213;
 i=arapaille@atlr-engineering.com; s=20261118; h=from:subject:message-id;
 bh=6q+rKn/BSVI/TfNaPILBloVMSgiRR3L4xqWRbPuJa0Q=;
 b=47cxJFlzFiTDcHUZs6zuR4YijCZcCkSb+iNkKof2I4Z7LlabC4BrCArM3sCmR109I/b5BsTSl
 9S67jRxwE4GAeWqfqP9n0rVGb4lc9tzsmDSVIqJNvoQe9ykzTeUYEoW
X-Developer-Key: i=arapaille@atlr-engineering.com; a=ed25519;
 pk=xskH/sIiNU/aZCeGeBB1TK/AuiG3MXlX0m2wMlbMl08=
X-Endpoint-Received: by B4 Relay for
 arapaille@atlr-engineering.com/20261118 with auth_id=1560
X-Original-From: Alexandre Rapaille <arapaille@atlr-engineering.com>
Reply-To: arapaille@atlr-engineering.com
Content-Transfer-Encoding: 7bit

From: Alexandre Rapaille <arapaille@atlr-engineering.com>

wcn36xx requests tx/rx as IRQF_TRIGGER_HIGH, overriding this edge type, so
the re-probe after a WCNSS restart fails ("type mismatch, failed to map
hwirq-177") and wlan0 never returns. Use level high like other WCNSS SoCs.

Fixes: c7c0edecfba8 ("ARM: dts: msm8974: Introduce the wcnss remoteproc node")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Alexandre Rapaille <arapaille@atlr-engineering.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index f300de74c4..b9666feb8b 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -814,8 +814,8 @@ bluetooth {
 					wifi {
 						compatible = "qcom,wcnss-wlan";
 
-						interrupts = <GIC_SPI 145 IRQ_TYPE_EDGE_RISING>,
-							     <GIC_SPI 146 IRQ_TYPE_EDGE_RISING>;
+						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 						interrupt-names = "tx", "rx";
 
 						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;

-- 
2.43.0


