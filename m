Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B9389118
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091514; cv=none; b=YLS2ikK0zGGPB2bDO1vaiiQrCx44YzaL1JWXtNFGIc8ZWpDU1NyGbvtHBk5Ss07bCurZ2A88wYPaJSugyrnPyzymbDjvnQbeuC2mIjxnIrI03EyfrLplAbU2uxWYNlJNBck60OikpoZgmeZtlzu4pzNplwikouHiEA7RqPfvdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091514; c=relaxed/simple;
	bh=OFooqvPH5XT2sTVnHTbI7z9BUvu2w6rBxaczlCNBQDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyPzTbd+1JkNMRDBBfThQznBw1FqSSjVfAw8B5ITrn6jmige2fCm09tW2ngBdEa5y7HNoDiTXluPGqJXO9WTtzOmyr3OcAL/H56zquWGbVpK3zIarjZet75xNmkevLWz9DlV1g+D+byBedLXKZMGAHeAuHehwZCAY5ba60ghN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow8fqI3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow8fqI3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3844D1F000FF;
	Fri, 11 Sep 2026 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091512;
	bh=uXPmYrhBtao8LcdNfJh+diyXXWUY3dHoFUL3rVg5paw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ow8fqI3FqE6Dxxho0JHazX3q1QFX6JikwKeZSoHUbaW4fvUu995zkaybnWSSJZS+n
	 Chpy2ZczhTWm49q4M2IFDOxJP1xUdYO7uqE2Q32+a2GLZWyhBynS2R9LtVU/zKIZ99
	 6Y9qiPrxiw+4KZVnCucw+eCNe2qYn0qcIlnXko3znLsGiwA35Z5yP4HLN3isjPmvU1
	 k5XVBSTyQmfRBnPFOoHFtf/an7MlLVly+f6wPwTvTXI3vevQ9piNmxby0LjAMsbgrJ
	 NBoqqBKZ2vxhehkg4qGdEZYKCrLV0dbOqZ4/dizDjT7aal7ShDoo3LSP0LN2htoqyd
	 XiiKFeQq/NBIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
Date: Thu, 10 Sep 2026 21:51:50 -0400
Message-ID: <20260911015150.4165480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090946-cross-rundown-5f1a@gregkh>
References: <2026090946-cross-rundown-5f1a@gregkh>
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
index 48995e50c6bd7..05aa612f835aa 100644
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
index 13e521cd42596..ad3abb3aa6388 100644
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

