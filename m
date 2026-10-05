Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56094E0B6E;
	Mon,  5 Oct 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220586; cv=none; b=naTXLN5IcATXj4oOXHgNFnQ5bCPa95taZ/1Cm5n2sUvm0p14VE2tsKMpMTrOxWZDnIwTdQ9mhkZnINXR8a21YFNNqLz5jfSkapAT3+bIji296ViduwWqfmj6s1rZMlNckwb0iZi7DOqFpoLbidPitpGtl4IO9gATB1GlpDUVWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220586; c=relaxed/simple;
	bh=1vpz5KSKvttEqwc4lHX/13UekGUpX+XGsPDaCFZS+Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKJyXUGfp3e7m+WkxkO4ISh2iZNdmEnQD0PBqCCOhFwlZQPK7zHVQ9dwM0BbY69telXdstoj22FFlqDeQqjn5J8H+35mp0Us1yy7aW8UgG0bzLg1n+++6OhlJ1j4u8XKoOTpphl+kB/uSiPADQp5bGUOqtbOb6GVBBNZP162b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inBI9wXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inBI9wXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDE1F00893;
	Mon,  5 Oct 2026 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220584;
	bh=f+2JwLGbTaZc+mYS9z6oCnJ+12ZrMen25eGfd5wY4S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=inBI9wXjiDCUI0rTj/imak7HoLVynBCl37EBeEdIrw8Z3vrBoB/J4acV0Lg5X1Tdl
	 V4lycZXfLJKK8zzC9gDO286bPP0jEcJvxtYDT9LS5sIAFcRGyi4JZIRITQErpzHw3S
	 PFlvM+tZybNgxsn6AGfF2amBTp825E49AjcubgCVdi8nwZq9d/bF1xHV70f2WEqG+m
	 DmaSbQ2dd9YYJcH4U0Q5NQMnUY9rDByntBY73nCgtqXYd4w/Dgnv/GcS3veDwO25T7
	 I3VZqh+cX/UiEHTcAYNVHnACICIqMuBJ8YQCyQ5Y6mcvuj4yQCL+EwWevOpPPhXiNm
	 k7kD3PYiz8Xhw==
From: bod@kernel.org
Date: Mon, 05 Oct 2026 19:13:42 +0200
Subject: [PATCH 12/74] media: qcom: camss: Fix invalid declaration of PIX
 for SDM845
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-12-ed985aefd611@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=bod@kernel.org;
 h=from:subject:message-id; bh=8q6fx9v6Zjv1MQIk08iNUZV+5V+U+jFZ/fIQpShHrpA=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqw9sJDbdR4y57Z+TeXhdaYS6nJaLikKzj1t3Uh
 ARSTnEN21SJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasPbCQAKCRAicTuzoY3I
 Op61EACYDlHvqf8zlnI4nn3RF/Ihr9wOldZimVErrIlm2XQJBbgMxOkeuOC8sv0qJfV9GQ1gfJf
 g8+UEkdDXQNb2GirZJSzynMkZlblEfIBhbDB80+JMixnRC2j3VnmT81AiPy4iZ0Jth957ceypZo
 TW/5uAhMT0PX/8x2zTJRWmKcg2zgF9NWdHsxNtnT0UkJ2CWpvZSr5VlQPCQjF23nyi/c21hyi5y
 b52zcHjsR7LM5MjkRgp1ZgWRmLf4tf8cN7IFjc0AQXgiazsBOF0I7Wo8e5HyO52+ORWswoYaAG5
 dmorLfcTGO2sBUIkQRKbqTVZ1DvhnUlV5Qnz9UyJ4B2Qa6KoXXFQ5ENwydEVXbHujO/8QQIELm5
 f9LeiO3lhaftFFESAu8ABULHN7SHvuszdNh6FghyWD0lQIiwCt9f2MGtbmrg1vhkuhrydCkdoon
 sGRAr97I1/f2ljK3IOCunWHK9N1GSV0NonguiMiZNHJyspdZ6IulLe55ljdhots44lLHIUdRXm9
 B2K8VlmJQvdCxvneTRoRVBo0OBGfSFw66tgGuOlQf5yiNJnGGRasuWcsNzbfRGumDcaQUDu9M2E
 XhiKSqqmH2ng0N6Z7eDyAFPe1zpyyjgeWCxRTOQPcxEUtMDgKs4O7c4eo/cauLeimgVIHFWSox7
 QifZaFL353p3XqQ==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

sdm845 similarly to sdm670 has declared an additional line_num on the full
VFE path, which implies support for PIX which does not exist.

Implement the same fix for sdm845 as was done for sdm670.

Fixes: ae44829a4a97a3 ("media: qcom: camss: Add per sub-device type resources")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index f46ad1db6dbbe..69b976bac60aa 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1455,7 +1455,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife0",
 			.has_pd = true,
 			.hw_ops = &vfe_ops_170,
@@ -1483,7 +1483,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife1",
 			.has_pd = true,
 			.hw_ops = &vfe_ops_170,

-- 
2.55.0

