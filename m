Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE83E5588
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948144; cv=none; b=BJH0kNxoLtWcqctI8UHNYw3uDk6m7CeDx4xqzT6jzffCdc7rS/HJseFrsvfhzyQ98ehTMPfdf09RA0pwbh5xvEN+WIw5p61dONqRbTbvCLajgs4wCd59D35f7M2mn909LcazUbqljjzJYE9zEdyW/RMlAkkEeywOxC0Iy7/ibEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948144; c=relaxed/simple;
	bh=iWMuw4tnOb40GQWsNsVOyptJKN1nvmn6kuZouECfSS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WxKwml1GaRKC1uGP2iAt5oT8VR1ffleVcsOC5W+/LVFGUSLwbMXXTOh39cU8hcLy7Ci3l4roASQvZpXkO9V0/iXaI4MlPUMQaAtQPs//OX3Wt7GubbgU+vhWyhinlXiq1wsWsoJ1c4mCvgLk51JL8bIw58jyGTbM4oNkyAnqpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rV4NqunR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rV4NqunR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0E91F00A3A;
	Wed,  9 Sep 2026 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948143;
	bh=XKCGXck9xXfckHWJFqWlSWGBa9LxZpI00HFmCFjs3zI=;
	h=Subject:To:Cc:From:Date;
	b=rV4NqunR4DRMI40xxbqYWIuGcad5Ts5H4CjRrIHeiBd5YPbAV4mIuSkkiz82nuGLY
	 G234tDp/As+NhvkbofpK+Feb1PUi0I0WqXvDIR0pqCQ8KNQCsG8eQxEs20h00cULp6
	 kvXoVBbzCxuxwgxZTM5/7J6eS53qDHeI2Ro7j+JY=
Subject: FAILED: patch "[PATCH] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs" failed to apply to 6.18-stable tree
To: imran.shaik@oss.qualcomm.com,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:58:46 +0200
Message-ID: <2026090946-matchbook-corner-21e7@gregkh>
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
git cherry-pick -x 830ead322c39c99bf972425b3c35323ec56c29de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090946-matchbook-corner-21e7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 830ead322c39c99bf972425b3c35323ec56c29de Mon Sep 17 00:00:00 2001
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:53:47 +0530
Subject: [PATCH] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs

CLK_ALPHA_PLL_TYPE_DEFAULT_EVO type PLLs do not have the PLL_TEST_CTL_U1
register, so clk_alpha_pll_configure() does not program test_ctl_hi1_val
for this PLL type.

The GCC PLL configurations for QCM2290, Shikra and SM6115 wrongly use
test_ctl_hi1_val instead of test_ctl_hi_val, deviating from the hardware
recommended settings. Fix them to use test_ctl_hi_val.

Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
Fixes: 01cf3e27824d ("clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC")
Fixes: e88c533d8a2a ("clk: qcom: gcc-sm6115: Add missing PLL config properties")
Cc: stable@vger.kernel.org
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 02ca37f58477..77cff0e9af93 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -116,7 +116,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll10 = {
@@ -148,7 +148,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll11 = {
@@ -309,7 +309,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = 0x1 << 8,
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll8 = {
diff --git a/drivers/clk/qcom/gcc-shikra.c b/drivers/clk/qcom/gcc-shikra.c
index cd192ff38913..2a1c1fc253aa 100644
--- a/drivers/clk/qcom/gcc-shikra.c
+++ b/drivers/clk/qcom/gcc-shikra.c
@@ -122,7 +122,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll10 = {
@@ -155,7 +155,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll11 = {
@@ -360,7 +360,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = BIT(8),
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll8 = {
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index c5251aff9886..a3c9dbe3a48a 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -120,7 +120,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 
@@ -173,7 +173,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_val = 0x2 << 20,
 	.vco_mask = GENMASK(21, 20),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 
@@ -367,7 +367,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = 0x1 << 8,
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 

