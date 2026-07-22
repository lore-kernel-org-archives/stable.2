Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90830C15B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743252; cv=none; b=ieAR/vQU97Sj1Oh34/8QZHKKt32w0HWeJln6wPpsdtGtvoTQcywhqlJfvCxFsEQn0WWMnVMjfp64mvH3MZ16fMVt0YnKqNgjNreJ8bnbMynwEs1VXdHSM8sEGoTHWkUGE8a+sz4eIU1qScw4gjJbuFwdkWE0NbvNJ5ud+xn2yoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743252; c=relaxed/simple;
	bh=NHOfQI6GLtsgf6CemlMN3F4QPwG8FGzI65lgnluXfL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HICY07fmE8nKS2yuVazLErr/JyoJCx5/FGNxmWnk3fGFqXqqq7arxvzBnc2OsYOhg56/wCKtHPBT7k55rvOALJplTq7gFhpc2u5sbmtFkzhDt3qZK5ljhNrhvsElaIOxm28ik2uraIyYnYKN2oJ/VlllCLJJ1mpITpExDeYiTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/sgQD98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/sgQD98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659B21F000E9;
	Wed, 22 Jul 2026 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743250;
	bh=tlOfVo/qBtAA7dSCvqtnHm1gm8UWhyOJEe6T+wpEZcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/sgQD98UlxDTSv/caZrtqHe8CQRot0EVWDF014V88p8Wt5TEbT2OwsMhvxZUr3Gb
	 affmgVF5D1Nn51rv0uCwrCoteIIMazLZzUB6hfW9GLSF2uXmGyWF7LmUnzwzbwB2B1
	 QgO+wmZpywviqFGxx1/EOm0tSRrMrfahX7bUcPxaD+vh7NAbmRzsgbiaw0z6vZatp3
	 eQyAWudn4MDhOJbydY0Wk/yQw6YWcCqMCwQzP377CLI44YXcYPhg81IaGz3V5ZkC2U
	 n1zKMJOI61G2OAToM49sEZxSs1bigN0awd8izMUFYkblwo+c5tmkeI/q2GmHwtgoWr
	 GO5MqA3D9nbeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] arm64: dts: qcom: correct RBR opp entry
Date: Wed, 22 Jul 2026 14:00:47 -0400
Message-ID: <20260722180048.2184180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072016-discern-gooey-8e42@gregkh>
References: <2026072016-discern-gooey-8e42@gregkh>
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
 arch/arm64/boot/dts/qcom/lemans.dtsi   |  8 +++----
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
 11 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index ef20ea941aa918..fdb92cac20f7fa 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5138,8 +5138,8 @@ port@1 {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5226,8 +5226,8 @@ port@1 {
 				dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a0df10a97c7f8a..d2207084b5967d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3448,8 +3448,8 @@ port@1 {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4b04dea57ec8cc..c5c22724835f6b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5192,8 +5192,8 @@ port@1 {
 				edp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5291,8 +5291,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 85c2afcb417def..8ee3b0c5d004e3 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3303,8 +3303,8 @@ mdss_dp0_out: endpoint {
 				dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -3385,8 +3385,8 @@ mdss_dp1_out: endpoint {
 				dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -3461,8 +3461,8 @@ mdss_edp_out: endpoint {
 				edp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d89938e17e0930..40649fe7a50950 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4754,8 +4754,8 @@ mdss0_dp0_out: endpoint {
 				mdss0_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4836,8 +4836,8 @@ mdss0_dp1_out: endpoint {
 				mdss0_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4916,8 +4916,8 @@ mdss0_dp2_out: endpoint {
 				mdss0_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -4991,8 +4991,8 @@ mdss0_dp3_out: endpoint {
 				mdss0_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -6110,8 +6110,8 @@ mdss1_dp0_out: endpoint {
 				mdss1_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -6190,8 +6190,8 @@ mdss1_dp1_out: endpoint {
 				mdss1_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -6270,8 +6270,8 @@ mdss1_dp2_out: endpoint {
 				mdss1_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -6345,8 +6345,8 @@ mdss1_dp3_out: endpoint {
 				mdss1_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 19a7b9f9ea8bcf..0c6787d46ddcd9 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2306,8 +2306,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index acdba79612aa8f..e1f480e3ed0b73 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3939,8 +3939,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index adf6b49b52c48c..79ba2c0c96b7e7 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4824,8 +4824,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index fc4ce9d4977e81..af892b76322fdf 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2925,8 +2925,8 @@ mdss_dp_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 6c00390010f1f7..2caf2571b95558 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3483,8 +3483,8 @@ mdss_dp0_out: endpoint {
 				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index ee9c12600f95a1..062911cc208322 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5522,8 +5522,8 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5610,8 +5610,8 @@ mdss_dp1_out: endpoint {
 				mdss_dp1_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5697,8 +5697,8 @@ mdss_dp2_out: endpoint {
 				mdss_dp2_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-160000000 {
-						opp-hz = /bits/ 64 <160000000>;
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
@@ -5779,8 +5779,8 @@ mdss_dp3_out: endpoint {
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

