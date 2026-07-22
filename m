Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A153C8716
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764025; cv=none; b=qQaqioUAoFrLD96mA5OpEo7koP/yUY0oL0OeYkw8yXU7u8RyyViLalloXYul5EUcaf6zTwEUA3SLLFdFeCfX1yiHsPsEbpevjHzzIIIyMgbuYKJyuW6EdOEYlgchgrqyZbfkg3edUz4nS1Zi0cIofqbHX+MpKiz6Z74FBlgTY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764025; c=relaxed/simple;
	bh=wfZa2uA3HmKTBH8Yjot9l2zFai3MN82S231U/wDl91w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf3zGutXWKVYCA0OIjApplBn2eXOWLgr705/U5AUwpheDfDfVnhYHGcQyxBV7BRfjzl1UFCTFAsv8xcl9qHKqOQql/GE7bt9xQgAQIsZSil8/q6UOoVA2VGEb5JE5QSv+NvyVt1VDho+OcKzwt2ZDNrLtVMl8ISJkkxw1qt/uaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeENXydf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeENXydf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0298C1F000E9;
	Wed, 22 Jul 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764022;
	bh=Un3YiVS/mS5tr5LRXAkqaaSUJbp3kjsUqVKb0QC8sow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeENXydfRwtYp5yPRs4bzZDQiol/KHSqHET7XqlcYu+F/12YRyG7JieZkWLJOyhBw
	 izQqruxnvzEvkTNxOj0HmVUrcDj/f5cYAsLPSaJWAzdQDeYBm/kU3EC9Z6aebiw8r9
	 74lPDS01wCJNVbahQxAJtB7dTsHj9y+kyXC7JD9YrrNUS0jWPbArkKQWGOYrJEssyO
	 sshq8UzYBelAKo7KSqdQaKwyXFchDGQnLrOiau+7mSK43crmasGArce0i4Zm3YjQPl
	 RMN4O66EoJMRCrvQfBnEWXibjCsmJir5+biZxOu0VXLm7WnQhNlcW9UlFVbpxUFO5T
	 O0jYc2HBe9Msw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] arm64: dts: qcom: correct RBR opp entry
Date: Wed, 22 Jul 2026 19:46:59 -0400
Message-ID: <20260722234700.2612312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072017-wieldable-parkway-61e9@gregkh>
References: <2026072017-wieldable-parkway-61e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit a5c21b9bd5f531e50141b0484faabb707b92f1e2 ]

DisplayPort Reduced Bit Rate uses link rate of 1.62 Gbps, the main link
clock should be 162 MHz. Having the incorrect frequency (160 MHz) in the
OPP table will result in selecting wrong link frequency. Correct the
entry in the OPP table.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260304-msm-fix-rbr-v1-1-b9eba986eaef@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: c17e22094667 ("arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort controllers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  8 +++----
 arch/arm64/boot/dts/qcom/sc8180x.dtsi  | 12 +++++-----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 32 +++++++++++++-------------
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  4 ++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 16 ++++++-------
 10 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6ae5ca00c7187a..8ddf66631c2dcf 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3406,8 +3406,8 @@ port@1 {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8fbc95cf63fe7e..e1f1d9518bef27 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4719,8 +4719,8 @@ port@1 {
 				edp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4816,8 +4816,8 @@ port@1 {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 60f71b49026153..a257abf688f48b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3269,8 +3269,8 @@ mdss_dp0_out: endpoint {
 				dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -3347,8 +3347,8 @@ mdss_dp1_out: endpoint {
 				dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -3415,8 +3415,8 @@ edp_in: endpoint {
 				edp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c10ee18cb611ad..3fa2e13f4baf02 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4259,8 +4259,8 @@ mdss0_dp0_out: endpoint {
 				mdss0_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4337,8 +4337,8 @@ mdss0_dp1_out: endpoint {
 				mdss0_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4409,8 +4409,8 @@ port@1 {
 				mdss0_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4481,8 +4481,8 @@ port@1 {
 				mdss0_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5547,8 +5547,8 @@ port@1 {
 				mdss1_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5619,8 +5619,8 @@ port@1 {
 				mdss1_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5691,8 +5691,8 @@ port@1 {
 				mdss1_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5763,8 +5763,8 @@ port@1 {
 				mdss1_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 10418fccfea24f..1234df16d51f28 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2222,8 +2222,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 27f87835bc5595..0aeceffd872c09 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3932,8 +3932,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 9995fc515e113d..4cb91f31340dbd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4818,8 +4818,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 0be8f2befec7c5..1870ec4176daa3 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2909,8 +2909,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f5be69e3be997a..d8147c59c73e71 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3223,8 +3223,8 @@ mdss_dp0_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 8843dac449000c..022fe7c9cd3a47 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4758,8 +4758,8 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4841,8 +4841,8 @@ mdss_dp1_out: endpoint {
 				mdss_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4923,8 +4923,8 @@ mdss_dp2_out: endpoint {
 				mdss_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5002,8 +5002,8 @@ port@1 {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-- 
2.53.0

