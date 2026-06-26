Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631E1D5ADE;
	Fri, 26 Jun 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486472; cv=none; b=fGEBAk6EiNhNLmCYLuVvIp8eqg06f7QagYQ+XqS0KyeKWrLIutI6+hhVzuujrV43HCnWhXatwKKySMx8pkUpX1OG24NQwKmrhC0HOdN5AtJYJJVxl37GKpFiziyDT95CyvSSRUTzEg6Dk6WsdjvB4zv9Fi+ef51QEtjYwRYdleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486472; c=relaxed/simple;
	bh=oZ2ipTt5slb1AoUB2bJ8LzEXXOAuXu+rODC9ZqClg5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UbPihYlOnZocaUzij0HmgtUuaF92Cx8o6d+6XlI4PiJhOYnOn33kQqtdE0dQPO4EUzrHuykRvz0946l9PnnJt5lhVOQgi4XLL+enjT0luiI+mUrzrKuuxs/7KMEom9qzMoLQmzsDZZtHUFahnDQxYgOmFEtsmrMOwVfY4nKsxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpsz10t1782486463tcf80c42d
X-QQ-Originating-IP: XGbe/E/kD0BLuFvNEizjzePgIMr6sFBBH8jL35vBlk4=
Received: from [192.168.30.32] ( [116.234.26.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 23:07:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2305747257967665330
EX-QQ-RecipientCnt: 13
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 26 Jun 2026 23:07:32 +0800
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Fix DWC3 core register size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-sc8280xp-fix-dwc3-reg-size-v1-1-ddcba897b19d@radxa.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwrCQBCE4auEXtswTqCZeBVxEWfK2C5imPYRD
 Ll7Wt0UfFD8CxmqwujQLFTxUtP76NjvGsrXfhzAWtwUQ5QgUdhyiinME1905vLOLVcMbPoBp65
 H6UTEhzwwVfjpFz+e/rbn+Yb8+BZpXTfH69ZMfgAAAA==
X-Change-ID: 20260626-sc8280xp-fix-dwc3-reg-size-89aed9666d96
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
 Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255; i=sophon@radxa.com;
 h=from:subject:message-id; bh=oZ2ipTt5slb1AoUB2bJ8LzEXXOAuXu+rODC9ZqClg5E=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl2U3dyKv27fqORkeFL/8bO3+XZTye5zt0hsq1jS9muv
 Z+e/H51saOUhUGMi0FWTJFFIZ5hLntl7rWnYqV6MHNYmUCGMHBxCsBEDgszMmx7v3be56xZAZXT
 1BM5VM7w6Z/btu+BmIFopY20EP+iCClGhhOu4s7SyYLfopP8FtZnXjxmpHmAITRsk6Dl3IAzve/
 z2QE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDqtQ4jGWXAGlDFsZ6teNi8YdJutqw3bQqc65x7w0U/v2pLdsK7Fw5O2
	HjqX4AE/JCWTGJfrLTYWeqxevTQ3Y4oWVWErqk0o2UVU+nvKNdiDCvqy9/I7CXqd0uwLrf4
	Kbm5WPMVmItWjjvpWCAErY8bO5CONvwwzGSDeBuVmWQ2mRcmsIG11r9/5E0N5Z6G7WNxC5i
	oo4qW3XkYVB65D4kU0lIOSX/k5f0H6BrIQ/WVfLoj+fFxOwnbANRo2KoWBFBF2prKZ7Zc/8
	ZoT5wnNnBWjvKQjLUIzL+FD0W6n/VUhtgX38YOTguShyf9pGOiHyHy97RbQJrbiwkyeBf8F
	z1P0CKTXP2bd7pr6ftzN7xu16Xr7/viWuNByohsCDXe2yVH8hA4YU7/AgIDR1xzWWvx6APN
	/5e+ol8K+2pY2DdaTF9WI13TkaZw1BGddS6MJwfSNLdV+pqIBaPSHVVLckMV7Dt3+1hOCHA
	KBcl81hsxeL+fBT9H3I0xKgB+hu07F0Ioz2D8TlFx2l0A6VdYi7sZA7GVk9Cc+DmTaDL6/Z
	MkBaUJ6mOY27WnLwxtEBDAbYcdv5RYFHIIEInoikdEdwHPqssrLfWBij1g5C20g2kvSusYO
	e1bn23oYknsqPpkQLVyUAmPftNcxm0uNfeNEY2UXgwNg9/yRgzmeuUjPpQa4bAzSxjSHf1F
	fd+4Rqb9Y/z9oO9qtOdAS/Wi30Vfk4n3V6/64cmqHKusWtG/AO17WDkm7hFJEp3ENEZjLh/
	cIcbOgcQwbXhoEH89iKqt1jxTbp0erH3QoWQka19VLGP8Ew+PQQ2ySTuoynfGgxLeMRQG6+
	pzPz+TVze6xIk3t4jbDNcIuAqd/jHq/PnYo/95BlfjM3fgVaJ+QMhFdE+t3G7h9G++Y2vgH
	A4H951Es9S9hDfDDDbJqvNRpCBiaYZBygapBm6ufiCL1PCCKTa3PVQiJpEIPSaW0IfBcrcl
	dXoEvYhs4XfBII8ugjIeSfFK1Gm5BMHOjohc9S38Yd/d/Oyiwmu/IdICXq+3cOk9ZO2Ldfn
	F1AkrMLX0lbO/OKjm3
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The SC8280XP DWC3 core register regions are currently described as 0xcd00
bytes, but the hardware register block extends further. In particular, the
DWC_usb31 LLUCTL registers start at 0xd024 and are accessed by the DWC3
driver when a controller is limited to SuperSpeed using
maximum-speed = "super-speed".

With the shorter resource, probing such a controller can fault when the
driver programs LLUCTL.FORCE_GEN1. Use the correct 0xd950-byte register
size for all SC8280XP DWC3 core instances.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Fixes: 3170a2c906c6 ("arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller")
Cc: stable@vger.kernel.org
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a2bd6b10e475..d06f79b7680c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4034,7 +4034,7 @@ usb_2: usb@a4f8800 {
 
 			usb_2_dwc3: usb@a400000 {
 				compatible = "snps,dwc3";
-				reg = <0 0x0a400000 0 0xcd00>;
+				reg = <0 0x0a400000 0 0xd950>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x800 0x0>;
 				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
@@ -4100,7 +4100,7 @@ usb_0: usb@a6f8800 {
 
 			usb_0_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
-				reg = <0 0x0a600000 0 0xcd00>;
+				reg = <0 0x0a600000 0 0xd950>;
 				interrupts = <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x820 0x0>;
 				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
@@ -4179,7 +4179,7 @@ usb_1: usb@a8f8800 {
 
 			usb_1_dwc3: usb@a800000 {
 				compatible = "snps,dwc3";
-				reg = <0 0x0a800000 0 0xcd00>;
+				reg = <0 0x0a800000 0 0xd950>;
 				interrupts = <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x860 0x0>;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;

---
base-commit: 30ffa8de54e5cc80d93fd211ca134d1764a7011f
change-id: 20260626-sc8280xp-fix-dwc3-reg-size-89aed9666d96

Best regards,
--  
Xilin Wu <sophon@radxa.com>

