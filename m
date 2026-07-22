Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC740DB52
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764025; cv=none; b=I8wxHd7d28nGqBA1V0IqCJAFCuFh2YtlyXplTJxrV1hYiy8rvXFW/ob1OcjNPizkPoecW8oB2CRBI6chUjFRDvHNu3251eYIRApFHCFZThbYgkf8UnL46WVd07IE3ztf932n0IguHaAxm/nOdW/DRGKB1GlNXjiDcCHfDw+VS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764025; c=relaxed/simple;
	bh=ZyqFhWDf4ef0JBGxuGG1TABAiAhvIEmTcH83qJoo668=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKemEOfUXvtANg5dHX6rGC6KiQ4jZ7AgtjekgVCE2GKeGrfdU8YnlxFSkDUCwxDwNqW04hdGy+coXHnXlv9BwQhwJ8/eorbbgP/oaPrZZWnylVp/E3PDrdVCRZ0WiT4IPqOay5py7+s/kvZuDg4nOp4bY3tV1Kp8fI+mpRvJ78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqxvvj+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqxvvj+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D51F00A3A;
	Wed, 22 Jul 2026 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764023;
	bh=zHNqwRJNa05NRWtAMC7i3/+SdkOXYjXGOsoSEY2LlwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oqxvvj+1YzfzQd5WBVbw9Gr3RiVpoZooYdHH8Pb2PTIqEPlLqffEP5rDQb4gJtTT2
	 GjJohhXqbY/NZDPD+WLiztGPOu9M9yEGNV5Q3eWVnByhyFF2e2yp0vzf34/AuFf2L0
	 PDiXY05jAKxW/GYJEZLKb2aY+yuznwVDuCXnqb7zdQaLsWn+i5dJ0FpOvNgydQYhbV
	 4I95/118C7eubNfdAomhKe9TL/qlNN5go43rUDz1kGoJ2Vu6HQT/OuSXHgYB8KxXjA
	 tm+tjz7lAcahhKyuDLELnOlODS3vCVU/0p1K0940HvFZt4HWdK98DUdkArClZVqNmf
	 39U9kXW9eR7lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort controllers
Date: Wed, 22 Jul 2026 19:47:00 -0400
Message-ID: <20260722234700.2612312-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722234700.2612312-1-sashal@kernel.org>
References: <2026072017-wieldable-parkway-61e9@gregkh>
 <20260722234700.2612312-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@oss.qualcomm.com>

[ Upstream commit c17e220946675232d383620ed9cff6685735ec48 ]

According to internal documentation, the corners specific for each rate
from the DP link clock are:
 - LOWSVS_D1 -> 19.2 MHz
 - LOWSVS    -> 270 MHz
 - SVS       -> 540 MHz (594 MHz in case of DP3)
 - SVS_L1    -> 594 MHz
 - NOM       -> 810 MHz
 - NOM_L1    -> 810 MHz
 - TURBO     -> 810 MHz

So fix all tables for each of the four controllers according to the
documentation, but since DP0 through DP2 have the same entries in their
tables, lets drop the DP1 and DP2 and have all of them share the DP0
table instead. However keep a separate table for the DP3 as it is
different for the SVS, compared to the rest of the controllers.

The 19.2 MHz @ LOWSVS_D1 isn't needed as it's not an actual working
frequency and the controller will never select it. So remove it.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260323-hamoa-fix-dp3-opp-table-v3-1-a823776bd1b0@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 77 ++++----------------------
 1 file changed, 12 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 022fe7c9cd3a47..7e9de1b7c7a314 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4758,18 +4758,18 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -4806,7 +4806,7 @@ mdss_dp1: displayport-controller@ae98000 {
 				assigned-clock-parents = <&usb_1_ss1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp1_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -4837,30 +4837,6 @@ mdss_dp1_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp1_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp2: displayport-controller@ae9a000 {
@@ -4889,7 +4865,7 @@ mdss_dp2: displayport-controller@ae9a000 {
 				assigned-clock-parents = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_LINK_CLK>,
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp2_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -4919,30 +4895,6 @@ mdss_dp2_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp2_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp3: displayport-controller@aea0000 {
@@ -5002,19 +4954,14 @@ port@1 {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
+						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-810000000 {
-- 
2.53.0

