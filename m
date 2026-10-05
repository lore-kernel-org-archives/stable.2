Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FC4DF4C7;
	Mon,  5 Oct 2026 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220582; cv=none; b=MHPWjxcjiTF433KtX7RGuqqn5Bd96eebVOgatBv5t5uSrMXC9fOuvuBYqfdnw3lIV2RdJvyzk0/2TKTcZMfe/lu2MtFrvwMPoNWkEZIAbeBe4OO+nWbJnd1/HERlGfY7SicwPb/zNevXqs5sfFskH5kHINpkXRExaeiBW0rycAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220582; c=relaxed/simple;
	bh=BDPjvElV6veu97EtCHgL8yshNpwmmWw0oVcoogBFb7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ti74tfa2aN/Jln4P1VAHvNdhtqPnT0TLtfCSOXjdhszqWvZBOHlNrR5OID0hUgmdja39yJyNwEEh/v9iDxvHx0H+4S/iBHhznUdC1pLnhJhM4ak7QsLoPOpQnoDDDRm3wyArzgi5njhEP81Hi+MnhS5zvfxbxS1Z/B7Jgf0dqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdaQ2AQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdaQ2AQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE301F0089C;
	Mon,  5 Oct 2026 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220580;
	bh=CU/2pHcIwZjVCY0zvaYuOpndOzFif20oXf+dZ1rSz4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AdaQ2AQqHsXaaHQkmmwwcaZia8ow+LeN+QiBUn1MlU1Bvaxr1kbEa8kvkd8VG4+EH
	 lKmeINpCwX92jUgqB1YYIUh5Rt5mP5RKCjxgNEqhpM0TLTQmpNXD50fusoU4LlQ9xe
	 pzzdllOGvVaNWVpHOAG12r2+0R9TUwNgSedxKEDAjEkv1kbLVHxBG0iSX7NkviU1nb
	 19KbdqHvtlMswP7YucHJ8qwFJ/Wqp9QvYwL6Gpcuy4CpcgSx2AQATKX5pZeeSVs3KY
	 DsMawhsXGYJh/ihK0912S5om4h97lUq2Yq8DG1I7cwj3F8Rbyy7UJb37BPDSDdSLWo
	 ZJ/SRv2pZua6A==
From: bod@kernel.org
Date: Mon, 05 Oct 2026 19:13:41 +0200
Subject: [PATCH 11/74] media: qcom: camss: Fix invalid declaration of PIX
 for SDM670
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-11-ed985aefd611@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=bod@kernel.org;
 h=from:subject:message-id; bh=oJfDggzpN4HqDQr43P0N9+yo61zWxM+FInpjnInlkuE=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqw9sI0t2gULmz/NdS3z7cjvb/0f5xi+OZ4UL6W
 6nIjc7x2ZOJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasPbCAAKCRAicTuzoY3I
 OmYrEACe2+t1aQ2/TBgxw/FzIgLTOCRQDqWYttM+4yRRaErm1L1IOFg8CuNzLAyiIAmB4/HEkEe
 7tArtRz+1EuKSieAO5g2Xnp32I3EVOBLwyuE9NHXa0wvJP373z6Gq7ZED/kbo+38KwzAYbXgw7r
 PRyLiQ1pD0dOt0a328IbjCcWze2wqxqcb53nY3q1xE0d6YFpSXjInKNrgvcbj16Bh9wWutCAmyE
 gg+UBX2+TtPaUdnMNarEhh11DpvP4+gW7saD0wKLWKO8g7XGZX2Mp0smw3SUvXyXohvQ0KLjYLZ
 SniSvc5uapdI3xq1KH7duu6FdWxaiNBu58mu/1n0JnTZHVAydsShFiUP9p6eJwI1pyppsWSG2U8
 7aEmkpDncbSXTOJnV61BQGiyhKd7XtS4ZVg/Q0qSJeZnqyHKE6Rfku6yDT3dnSounqIeqxfdfHh
 g89MsTB8SvV+en8ZcNea02qPx2eR4A0rp9NssTJXFVunC5W4KrH2eW5BfIHt4lY/L9nZ2EIjXdX
 HEXkkZ2iZqp5MsQ2/3le1IK7FXAB9fxx/nZgw+wNA9nk4lGdBc8GjoQjC7tdy2QlaJiQ9g9sSjf
 t+8QeNNpe/5OZxroFyuK36EJjxBZuT0Fiug27zOGsibOcwrG22lmL0MYTqlw8v6B8xp0pE2wulT
 bynR79elkop02tA==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

line_num is declarative of the number and type of data-interfaces a VFE
has in CAMSS. The fourth line on full VFEs is reserved to the "PIX" path -
meaning the path that can do YUV, downscaling, stats, params or some
version of that.

In contrast the raw dump interfaces (RDI) 0, 1, 2 can only write
unformatted pixel-data and cannot generate stats.

The PIX path lives at a different register offset and has significantly
different setup to RDI.

VFE Lite has four RDI interfaces where VFE (full) has three RDI and one PIX
interface.

Unless/until PIX is actually implemented for SDM670 reduce line_num to
three to stop populating a pix path which simply isn't implemented.

Fixes: c52643b24152 ("media: qcom: camss: add support for SDM670 camss")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 40a993ade5f6d..f46ad1db6dbbe 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1202,7 +1202,7 @@ static const struct camss_subdev_resources vfe_res_670[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.has_pd = true,
 			.pd_name = "ife0",
 			.hw_ops = &vfe_ops_170,
@@ -1224,7 +1224,7 @@ static const struct camss_subdev_resources vfe_res_670[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.has_pd = true,
 			.pd_name = "ife1",
 			.hw_ops = &vfe_ops_170,

-- 
2.55.0

