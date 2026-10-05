Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888114DA9C9;
	Mon,  5 Oct 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220589; cv=none; b=lpWQSJcWS6a5SwHDlXIEfbM63l41z5XIeXeqFp+qq5D+RJ+W8rE8Ub4jqtEgTkFCAC80Okoq1oaSad75tpDYDdY4LlvM4xXetfvH8bzkshKQkx/jWgKF2OGMki9vSbgUsIl4Y9gBDhV8/+P/QPVzSuTtfo/m7wh7XDzyGCYKtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220589; c=relaxed/simple;
	bh=dqgT0Ktpaxl/8CAttOMqwVIpJa49TxH280UQtZmmnsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXQ+6GNHK3sHzqHYk+2qQeZl2NyLJt62pAnboJGIpiRqVQu8G9bE1Gdwfj5WseTrUPw7FnYWSA9BJIqr8fWd1L48/Awwn5+jhJsHXbUJm7NEbRn4/K3TlAHe/DkOs331Bn0Zd9hFSKoOsSU/FNlTdAMGNL+5suIk/42TPx/XFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8YMes8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8YMes8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D11F000FF;
	Mon,  5 Oct 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220588;
	bh=vcpn94EAf01QkQQSpgKLiek8Xne3UjKkrSDJcREdA/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a8YMes8kuXXRKeHQO8PQfadVwjgN5Bo0yjOa2+4xMGwSsm8BkNQ/f2IZI+O+6SUs6
	 tAwODRrjq7urnuPrBVobgy5ua8PLnnpnTnUTdruslTxmKbgRtIj1aufws5L+7B2vrS
	 wZIuO/0SVSq4oM92FTks+lL4baoHVRz0zMHpSxY5XdL/ZdJbjA2uI0QlRoxg0ku0qI
	 tRG7lL4WDQ5jFoWR//S6+IWg6FWmeiZgRc/KqLi8LOE1JshlJ1FxMFzVajPw3unC5K
	 NoB4jdOIqp8xvLGx7EXdv7nbPrglo6v33PjJEO2/h5AK0jOMSMybM50HeiSzwfOJ6g
	 cqO62KDd+Er2w==
From: bod@kernel.org
Date: Mon, 05 Oct 2026 19:13:43 +0200
Subject: [PATCH 13/74] media: qcom: camss: Fix invalid declaration of PIX
 for sc8280xp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-13-ed985aefd611@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=bod@kernel.org;
 h=from:subject:message-id; bh=8x14J7Q2GNW14/kZXRbNcgidg1q4IaGSNGPIZmA4ajs=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqw9sJw4nkNeLCSnh8akZZJ2Qn4NJ1zqpxVwowG
 cfc/gEUQb2JAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasPbCQAKCRAicTuzoY3I
 OgTCD/91hw1QQwKHV8ilyi0HjLAhEMbiqI22hqgepvbC2WACkugEH4hXO/yGs5jdF+ldar/44Nz
 cBW1vqzuy3VKVkLj2vTT5OiD2NUSP2NWOsGNHX0ZH83zJmbkDHi6v6kznZDWW94kP8jA2nMWTGv
 S47B628rHOC3hf9WWutRT4kefJ3fyJ7c4d3rT0M3USsylj0x43cvS4b9J7FnH6QlY+z2ifQca34
 9tqPWbGNHzdc/OdnO/mXayaOJ4EJ3dTKIoysRu2iblLym79pi/mZ4fH/vOPCQWzubFiHJLW+rcl
 JVCigWbTFfje5hY3NEL0jRSsTG7yjM0gjJWLQyZYzpEy/dZzvfRbsWeJC+3of42YYzL0EolKgU9
 HdLBzOVCsIqkYr+kHLrRHEbty+IQFKACiRmLywLWDpOXdpFbFEn7JJKrS8BGUHmsT/UHvuYkatX
 XRJjl+/84Hm5m9z6CC6h/fQpGzc7KxcePlypC8wM9uLju1o6z5QZa6SyaxZLUD6+aKSfSOTH3MW
 hdZm4OUFAKjxiO0OXZ8HB44q2ntQV34Fd/tKswwx5Nc6fnk0QiEZNQnT9gWdVt6LAJw7G95K7Ik
 3bwlm0mMLngF8pFjVdieDlGoriVNEzqP/hRf5kglVoT23usLNrnolTNUKef8QgwF6QOEF7cZKEU
 IrfgKlBv83nknpw==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

sc8280xp similarly to sdm670 has declared an additional line_num on the full
VFE path, which implies support for PIX which does not exist.

Implement the same fix for sc8280xp as was done for sdm670.

Fixes: ae44829a4a97a3 ("media: qcom: camss: Add per sub-device type resources")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 69b976bac60aa..0960e7c1ce46a 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2809,7 +2809,7 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife0",
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
@@ -2829,7 +2829,7 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife1",
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
@@ -2849,7 +2849,7 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 		.reg = { "vfe2" },
 		.interrupt = { "vfe2" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife2",
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
@@ -2869,7 +2869,7 @@ static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
 		.reg = { "vfe3" },
 		.interrupt = { "vfe3" },
 		.vfe = {
-			.line_num = 4,
+			.line_num = 3,
 			.pd_name = "ife3",
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,

-- 
2.55.0

