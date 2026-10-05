Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB74DAF90;
	Mon,  5 Oct 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220593; cv=none; b=igBvxhRQyIiBXWQ+5cQmCtecnElbDspjXdUBoD+0zItMzlnWPWhX8/v6yd9EFBuYDwAi4XqDBfcBB7EHYHWv+aw616ACUow12f67fvb8E2GI6ueKSXaELdmNkLxCO8KfPE0TU5Pth4mlzISACnHPaZbA60D02jY7a+sVI55aY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220593; c=relaxed/simple;
	bh=BBc2fZkVlqvtntjlMY63HQC3kRs5CDc4JX6+myTEaO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOFkr1zix5Uqt3qCtP0o9RhkuPEnuxl9CO5AzMZ6l/Idsqc4nD0ZcE+ZLhENORGqlSiNp6RD1Xw1t8nask1c1gYNOD1u6O+dYzPbEhyjsbuz9xbQr2/oFIdbX7Z4ynTqOrhFsfV259wHjB7V7UKRb7cIX9UhyIxr3EcRY42gX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbm8Fy0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbm8Fy0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8904F1F00898;
	Mon,  5 Oct 2026 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220591;
	bh=e2MXguAwMMDo6xaqdRB1C7dQDC79+Xupf9/yv9yqJfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lbm8Fy0SJGOgmf5e47oR0G4pwmYZO8iIbmNgg494qzVvMflMXq9KHBUw1VM6P17p8
	 jANqH6tdbOF8oTlwR2HYiSgrHfrnc1DkhGnVG343y30DqtMcRl2ObmoRGnon1LwBd9
	 wMsQX4ZeMW98jFj6OJ8W4He6BbTfEb9GWbFx7DMUaj6plyffehbyeKcsWAtnIjvwSl
	 P/6uxH6Og7O58ADpq8pN/JkKNb1QaB5TB/CDzMuB+XifDaI1fNIjpTLI2MVbKO+noY
	 vCI+JGgDc2yTqUPayZk+mzVqC/TWnRGm/euOc5M/JhkWVonePAhQrzQ3rVBi4UdfJS
	 AXSRVf2s70wrA==
From: bod@kernel.org
Date: Mon, 05 Oct 2026 19:13:44 +0200
Subject: [PATCH 14/74] media: qcom: camss: Fix invalid declaration of PIX
 for x1e80100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-14-ed985aefd611@kernel.org>
References: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
In-Reply-To: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, Keke Li <keke.li@amlogic.com>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, 
 Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>, 
 Robert Foss <rfoss@kernel.org>, Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=bod@kernel.org;
 h=from:subject:message-id; bh=1UiRMI3ubRDEFZBn2riR/u0i+XVLyRXRCYKacQADjVA=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqw9sKB4OLUcep1ZMazEUQ9KdfrhIOz18sZuV9p
 3sERh/XVCCJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasPbCgAKCRAicTuzoY3I
 Op4aD/9rFMX3//8bAe0JUuprRM3OKtkPJFbK/ewaUa0rpyl20mONA/J5auYL5Lnp9k5sCWW0szu
 VuBm1Hgw10J85OTzXS8jASNJDqIKNi9EisIvs1cdh/nfkfahysBkNXhWKPJ/kcbwStpZyYDJUIt
 SXyyey+7nFZYpzDoSfwwCBQ8yfqa26fbF98gCJpSKkjWv4L8m8ehHakdfQgmXakCyt7Zmfphmph
 XdD/hjSEMcgX7qhvaeSWJgC+2sxakXI8Ur8JlvtwnOVTUszx+DZSQW4h84p10M8YZLZaD/2l566
 1B47Gciq5hbSiVNOVmDAki7RrxA9OEuSYp2TCLG1KeW5nIkJNhy26rz7mqsvoMKYKGZ6ThqNZjH
 3a4SkEi4SsV2fpkCyPZrR84XpXBgu56uA4D0JjelqLqGd/RLTiybmtguNntadLBjXuhu9gIbjS6
 8jGFoYhaJpXBbrnEvms3nboSOvxmi0JDMfneAetyniqDbZcYGFLIOSbwvhtFNNYD1knk0eitoRR
 zOR5F1vUffwAWQY0/2l+rVikPCK2ENsZDWzeVlHqCdRIyiEi1nDOq43uB+g1jO438443kPFSStx
 0DovPeN2IrlKdDp1PmIBoigN1jmZFy0JishQs/Y6TZAvOE3z5+5gCCeF6JKKuRYF5zSpC7Hjumy
 4sRf1F8LoRWuKyQ==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

x1e80100 similarly to sdm670 has declared an additional line_num on the full
VFE path, which implies support for PIX which does not exist.

Implement the same fix for x1e80100 as was done for sdm670.

Fixes: 1830cf0f56c3 ("media: qcom: camss: Add x1e80100 specific support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 0960e7c1ce46a..e7a1a25d7c9a3 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4430,7 +4430,7 @@ static const struct camss_subdev_resources vfe_res_x1e80100[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife0",
 			.hw_ops = &vfe_ops_680,
 			.formats_rdi = &vfe_formats_rdi_845,
@@ -4454,7 +4454,7 @@ static const struct camss_subdev_resources vfe_res_x1e80100[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife1",
 			.hw_ops = &vfe_ops_680,
 			.formats_rdi = &vfe_formats_rdi_845,

-- 
2.55.0

