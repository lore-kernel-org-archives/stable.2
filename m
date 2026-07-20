Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00B3FC5A6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549848; cv=none; b=DNkJSfCibPYr2iIft9zCErztLygopO7cz//Hdo59sd/AYi1qoCITV3BElacmW5ych1OKb1HkHn3UDqA2YIUhtpf02MrMcSDvEjdd91+8RFhXp3qURChwEXilatRaP54HHQcuQSD2l281B2nzyrMlfBZMo/dpHfXlBd7FHiQ4EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549848; c=relaxed/simple;
	bh=erykb40pdIqflCisJoCKm/w8fGXMI4u4aQlHJ5OT22I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Md2Y54+v5FtcWJPfphkm/ql2QTB0BYtcaJczkMhO5GL0SdvDuxjb0kQw9PPGafOINeyjek+gaiFSaW8SUiKvmraVEAnWpA95AhrA4hBLTw44Wdnilr0YP/L87HhmczkNl5zZq4eUlYHR5KDCdbS1htiC9PEB1LaL0EmJYSnmKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6eI7r5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6eI7r5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1351F000E9;
	Mon, 20 Jul 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784549845;
	bh=7LWaN0Ior+eRSiJZfy+KB0nCekpr+pqRg1csYYVh4hM=;
	h=Subject:To:Cc:From:Date;
	b=E6eI7r5wjH+r12KfsCdYZCALzO5aYBSYr5/X+RJmQDYyvrxfqKqN0xsFfBNbETJJU
	 5nDM/i27Gssr4bEfX3hTpeRRDEtMFam7/BP3Aki5Vo8ZfODw50lBrZfpplBAEWWZWp
	 1sUKkR9oYA55bPwOGUQvqUpTF6EjyV0VImF7jXcE=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort" failed to apply to 6.18-stable tree
To: abel.vesa@oss.qualcomm.com,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:17:16 +0200
Message-ID: <2026072016-discern-gooey-8e42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c17e220946675232d383620ed9cff6685735ec48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072016-discern-gooey-8e42@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c17e220946675232d383620ed9cff6685735ec48 Mon Sep 17 00:00:00 2001
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 12:01:12 +0200
Subject: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort
 controllers

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

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..4ba751a65142 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5744,18 +5744,18 @@ mdss_dp0_out: endpoint {
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
 
@@ -5796,7 +5796,7 @@ mdss_dp1: displayport-controller@ae98000 {
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp1_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5829,30 +5829,6 @@ mdss_dp1_out: endpoint {
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
@@ -5885,7 +5861,7 @@ mdss_dp2: displayport-controller@ae9a000 {
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp2_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5917,30 +5893,6 @@ mdss_dp2_out: endpoint {
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
@@ -6004,21 +5956,16 @@ mdss_dp3_out: endpoint {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
 						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs>;
 					};
 
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
 					opp-810000000 {
 						opp-hz = /bits/ 64 <810000000>;
 						required-opps = <&rpmhpd_opp_nom>;

