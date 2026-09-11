Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3E329E79
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090510; cv=none; b=roLBDnb1EZfZsJ+uNBMV4yxk4sSkFq1mjqtMLI77sR3iQ6qRCJ7gUAEn8qTozZ0ybhnOgMApbh9tNAlPOKwUEtPUv7B5Wt2kJvfRIG54kZvY9nXn5JTEP9xKWiB6kDCnPDPKstWoMIHR3McyHg2cAkXgAQeqIx0GJWuTF5b77Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090510; c=relaxed/simple;
	bh=lPSo8tqjqRoni2Fw2YY3PNNB2VMLsC6m3495JyIh7aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onJMkTqw343xyLTUrKxpyRJN0/sP/JVOkxSZRZ9CHZydf6QYTdPJWjFyma/ZBBunjQ0C9n9V9+PX0nPhQNv6bkY6opPeswPsilvKNIsHTtTsYwxfgxy/L2Epj8zoSv+vQmdTWYyEzUoMpfbABMIq9Sy0uq9gbj2sgijvZCAzYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+o0UiH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+o0UiH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E78D1F000FF;
	Fri, 11 Sep 2026 01:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090507;
	bh=dVrESku6WrxnpsabIHm0v909CUO+2e82fSoO3kP0mlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+o0UiH38TTlp8QQ1BvBs9xMW9pMmylzluCrdMa7GNOq5UBtJHF5XUtAoySui3X9D
	 fr+mUxN8omMUq6lowGzmbOm7PQ7Ui6shqWqahs0wJj124KWthBdtpNL5EaymvjEP0W
	 c/wP2uiKVshn1UExvZU47iGyczwKbE6sXYqO07nMQLvxoMtrw7vPDDIpNzcBx/+3DH
	 6Z6LHpJ5qw76d+MSyTHQjS/8qIRlcshdv9ftXDmHn32jHua+JvDdjekdXBhG1pUF5Z
	 in9+kebTkkOdK4SxoQECWY4dgHHOrz6CpUMNIq1brdYDgA8ooFrvXuhKBLNLqQYjnU
	 pXo07gfPb2kKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
Date: Thu, 10 Sep 2026 21:35:05 -0400
Message-ID: <20260911013505.4124326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090946-matchbook-corner-21e7@gregkh>
References: <2026090946-matchbook-corner-21e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imran Shaik <imran.shaik@oss.qualcomm.com>

[ Upstream commit 830ead322c39c99bf972425b3c35323ec56c29de ]

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
[ Omitted gcc-shikra.c changes because the driver is absent from the target branch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-qcm2290.c | 6 +++---
 drivers/clk/qcom/gcc-sm6115.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 6684cab63ae11..690f23793af6b 100644
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
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 4c3804701e243..4bd2ebc158946 100644
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
 
-- 
2.53.0

