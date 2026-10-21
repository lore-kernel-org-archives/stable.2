Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594239;
	b=rL1JzHYk1yO3w+bII8Ri4g6L4G0mndBoSV6RWf0R4ySxEY7f6OLXn4GO0RDJ+PrXGN6v
	 AZ7tA8yqgyVWJSMJQH8TqM1eGenZCzqHHP1g8bmivYBlem4ZjFgAdvgHmRQpqbtoIwdw8
	 lY3syW/QweUM81/EqGoMSpR1gG8Jxwdy6Dz2QNsppXlKrtD6cPjElLbYDSI5RL4Ue/hfj
	 2L1+dXGQERAGsY0kCs9gpsKxkmcJA9qhbAXMaYRYQincept78FqX5dptduWCO4TTKgoPB
	 PAL+EP4tHuZy1raT4Ma7MDJMTa1HVK1q8rlGlnlCoyUIQL9C0Md0Ut15dnXlo/INiZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594239;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1IZGEUOWQKbYEI3zTeUSKChT0dyPwWCQj6PgyuEo3D8=;
	b=PD0FtiVulg0vz/ulQu8JOKZGacibx7kFoyXH9luulyZ3Jh+ObVhewsr/3lxxV7xHZ45P
	 NwZMXc8G3k/jUOP68uiF3ORcvo9eP6QBjVQ77/jfTRb37VB6wjbm1PT4oU0Np7Bn9X8Lq
	 niNV2sPGHdDM5rax7FMJNCsn8dcMYe2/MYn+6eycLKytWLmyM+bu+m3OGPdbyrq7u0baq
	 xbmMRk9gY4vBEFZiABkgcMb7kCbSsQHQFHUa8VK/wTqi8s6vue0TBBrCtrURJclSSgCTK
	 a0obugs7w/0mIhhLvrjFnJpdEVzCtvzpZzpMVoU8kHWWmijTKomqAkSdxNLSBK02w3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0gDeLYvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A801606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0gDeLYvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620631F000C1;
	Wed, 21 Oct 2026 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594239;
	bh=1IZGEUOWQKbYEI3zTeUSKChT0dyPwWCQj6PgyuEo3D8=;
	h=Subject:To:Cc:From:Date;
	b=0gDeLYvSbApUHyNGOLeEFkcpfp8gzJhp5Yx3lAw6SGjWpa1PpcZTBuX/sDxwqw7xq
	 /+/jX3P3jtQFQlh9u4xNj5ze+su6L7XTkT0YcavwrEyxHcLIaQtd+9HrhuliDmuv/m
	 V/dDnM3xQ3v+mnD9AX5uFLYSSworbsZ8ak1Pnkg0=
Subject: FAILED: patch "[PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair" failed to apply to 7.2-stable tree
To: shengchao.guo@oss.qualcomm.com,bartosz.golaszewski@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:41:34 +0200
Message-ID: <2026102134-resolved-spied-070a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x fbfd6d0d3596d072f7546b25228e4eb599f68a95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102134-resolved-spied-070a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbfd6d0d3596d072f7546b25228e4eb599f68a95 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 11:02:01 +0800
Subject: [PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair
 functions

QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
respectively.

Both mux values were named "qup1_se2" (respectively "qup1_se3"), so the
two distinct lane pairs became indistinguishable. msm_pinmux_set_mux()
stops at the first entry matching the requested function, which means
mux value 1 was always selected and the I2C lanes could never be muxed
out. In practice i2c9 and i2c10 got the UART lanes and did not work,
while uart9 and uart10 happened to be muxed correctly.

Give each lane pair its own function, following the _01/_23 naming
already used for the same hardware arrangement by the shikra, eliza,
hawi and maili TLMM drivers. Both functions still cover the full pin
pair, so a single pinctrl state per protocol remains sufficient.

Drop gpio129/gpio130 from the SE2 group list, since those pins
belong to SE3 and were never reachable through the SE2 function.

Also rename QUP1 SE2/SE3 functions in the binding doc accordingly.

While at it, add missing "gpio", "qup3_se0_mira" and "qup3_se0_mirb"
to the binding function enum to get the list complete.

Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260830030201.135637-1-shengchao.guo@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,nord-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,nord-tlmm.yaml
index 4bb511719f31..56758a85ead8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,nord-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,nord-tlmm.yaml
@@ -67,7 +67,7 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-        enum: [ aoss_cti, atest_char, atest_usb20, atest_usb21,
+        enum: [ gpio, aoss_cti, atest_char, atest_usb20, atest_usb21,
                 aud_intfc0_clk, aud_intfc0_data, aud_intfc0_ws,
                 aud_intfc10_clk, aud_intfc10_data, aud_intfc10_ws,
                 aud_intfc1_clk, aud_intfc1_data, aud_intfc1_ws,
@@ -98,9 +98,10 @@ $defs:
                 pcie3_clk_req_n, phase_flag, pll_bist_sync, pll_clk_aux,
                 prng_rosc0, prng_rosc1, pwrbrk_i_n, qdss, qdss_cti, qspi,
                 qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
-                qup1_se0, qup1_se1, qup1_se3, qup1_se2, qup1_se4, qup1_se5,
+                qup1_se0, qup1_se1, qup1_se2_01, qup1_se2_23, qup1_se3_01,
+                qup1_se3_23, qup1_se4, qup1_se5,
                 qup1_se6, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4,
-                qup2_se5, qup2_se6,
+                qup2_se5, qup2_se6, qup3_se0_mira, qup3_se0_mirb,
                 sailss_ospi, sdc4_clk, sdc4_cmd, sdc4_data, smb_alert,
                 smb_alert_n, smb_clk, smb_dat, tb_trig_sdc4, tmess_prng0,
                 tmess_prng1, tsc_timer, tsense_pwm, usb0_hs,
diff --git a/drivers/pinctrl/qcom/pinctrl-nord.c b/drivers/pinctrl/qcom/pinctrl-nord.c
index 7c21306e77ff..7f37f8e819ba 100644
--- a/drivers/pinctrl/qcom/pinctrl-nord.c
+++ b/drivers/pinctrl/qcom/pinctrl-nord.c
@@ -570,8 +570,10 @@ enum nord_functions {
 	msm_mux_qup0_se5,
 	msm_mux_qup1_se0,
 	msm_mux_qup1_se1,
-	msm_mux_qup1_se2,
-	msm_mux_qup1_se3,
+	msm_mux_qup1_se2_01,
+	msm_mux_qup1_se2_23,
+	msm_mux_qup1_se3_01,
+	msm_mux_qup1_se3_23,
 	msm_mux_qup1_se4,
 	msm_mux_qup1_se5,
 	msm_mux_qup1_se6,
@@ -1152,11 +1154,19 @@ static const char *const qup1_se1_groups[] = {
 	"gpio123", "gpio124", "gpio125", "gpio126",
 };
 
-static const char *const qup1_se2_groups[] = {
-	"gpio127", "gpio128", "gpio129", "gpio130",
+static const char *const qup1_se2_01_groups[] = {
+	"gpio127", "gpio128",
 };
 
-static const char *const qup1_se3_groups[] = {
+static const char *const qup1_se2_23_groups[] = {
+	"gpio127", "gpio128",
+};
+
+static const char *const qup1_se3_01_groups[] = {
+	"gpio129", "gpio130",
+};
+
+static const char *const qup1_se3_23_groups[] = {
 	"gpio129", "gpio130",
 };
 
@@ -1428,8 +1438,10 @@ static const struct pinfunction nord_functions[] = {
 	MSM_PIN_FUNCTION(qup0_se5),
 	MSM_PIN_FUNCTION(qup1_se0),
 	MSM_PIN_FUNCTION(qup1_se1),
-	MSM_PIN_FUNCTION(qup1_se2),
-	MSM_PIN_FUNCTION(qup1_se3),
+	MSM_PIN_FUNCTION(qup1_se2_01),
+	MSM_PIN_FUNCTION(qup1_se2_23),
+	MSM_PIN_FUNCTION(qup1_se3_01),
+	MSM_PIN_FUNCTION(qup1_se3_23),
 	MSM_PIN_FUNCTION(qup1_se4),
 	MSM_PIN_FUNCTION(qup1_se5),
 	MSM_PIN_FUNCTION(qup1_se6),
@@ -1633,13 +1645,13 @@ static const struct msm_pingroup nord_groups[] = {
 			 _, _, _, _, _, _, _),
 	[126] = PINGROUP(126, qup1_se1, qup1_se0, ccu_i2c_scl, mdp1_vsync_out,
 			 _, atest_usb20, ddr_pxi, _, _, _, _),
-	[127] = PINGROUP(127, qup1_se2, qup1_se2, _, atest_usb21, ddr_pxi,
+	[127] = PINGROUP(127, qup1_se2_23, qup1_se2_01, _, atest_usb21, ddr_pxi,
 			 _, _, _, _, _, _),
-	[128] = PINGROUP(128, qup1_se2, qup1_se2, _, atest_usb20, ddr_pxi,
+	[128] = PINGROUP(128, qup1_se2_23, qup1_se2_01, _, atest_usb20, ddr_pxi,
 			 _, _, _, _, _, _),
-	[129] = PINGROUP(129, qup1_se3, qup1_se3, ccu_i2c_sda, mdp1_vsync_out,
+	[129] = PINGROUP(129, qup1_se3_23, qup1_se3_01, ccu_i2c_sda, mdp1_vsync_out,
 			 _, atest_usb21, ddr_pxi, _, _, _, _),
-	[130] = PINGROUP(130, qup1_se3, qup1_se3, ccu_i2c_scl, mdp1_vsync_out,
+	[130] = PINGROUP(130, qup1_se3_23, qup1_se3_01, ccu_i2c_scl, mdp1_vsync_out,
 			 _, atest_usb20, ddr_pxi, _, _, _, _),
 	[131] = PINGROUP(131, qup1_se4, qup1_se6, ccu_i2c_sda, mdp1_vsync_out,
 			 _, atest_usb21, ddr_pxi, _, _, _, _),

