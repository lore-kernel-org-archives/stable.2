Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D0256C6D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888517; cv=none; b=Dpc8xBZWjFoakasd/b3cfUKAg1B4aEn/39Ha4/96fOWzCjwYPswVd6nK7qVASdAghZQOz58cGqJ5tDjjUoLiv/MrjkZpSaIdIPl4Ie1tQTRGgriSw6GIOGscYD3yJGIZ8n3BjCIcRexTxP6JpbpPG2WtSLvtnIvfyJCW+XWkkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888517; c=relaxed/simple;
	bh=4fcje+r/Eftgg6YPq4zT0/PIpoAIi3EHNJaoa5yiShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FT6/baj9sQgZhzqfx4A/EOXpO+5wXby78Z0y7OuDq/n12LH+l4hue9BeUitywerbGqKoC4rWitmny9iTNquCd2J8fdck1xk1tr7cO0Hno3JkIIfZpFOeN+9d9L+xTjtY0kTOivEs3/bUS4HdEBTQYd1OLsPBaYgWs7veSfzgvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtDgNhAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtDgNhAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3601F00A3E;
	Wed,  5 Aug 2026 00:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888516;
	bh=8lWKFEW1IT0u1aCULazf8X1tbiyCPC4m70Ygv8f9kHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KtDgNhAbaKMhHd2V4e9d489CT4gT232b4t3VkgDL749YNtrDdiuwOVZDO6NBap/Zf
	 6T2wD+hpTqVyI7udTV3lK5aquiMEmI62LBUb4OpMlabYZXNsRYoqWIHf2mCS7eoHJ3
	 9bGW3md+noovK9VBeI5O39FhHw3NzQF4N2MGTRr4+z0y2KBVA/racxYZJwzTNTlGu9
	 gxwAOPYI4IHYyFOVbJ2p5TrcOxxNk/+nuE5qBbLMOA+hE4CHc7IO6AF7RljR3qRmJF
	 M+df/y0H6ACIfeONtrapumuxx1DaYwBg3/rkEvybRCumjglm4azoFLkksjKB2bIdH/
	 x83PoJC5QQ4Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: qcom: camss: Fix RDI streaming for CSID 340
Date: Tue,  4 Aug 2026 20:08:33 -0400
Message-ID: <20260805000833.3902619-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805000833.3902619-1-sashal@kernel.org>
References: <2026072933-pungent-everyday-da96@gregkh>
 <20260805000833.3902619-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit cc1c35619c9895f918f9e388e3caa6ab2ff2fbe7 ]

Fix streaming from CSIDn RDI1 and RDI2 to VFEn RDI1 and RDI2. A pattern we
have replicated throughout CAMSS where we use the VC number to populate
both the VC fields and port fields of the CSID means that in practice only
VC = 0 on CSIDn:RDI0 to VFEn:RDI0 works.

Fix that for CSID 340 by separating VC and port. Fix to VC zero as a bugfix
we will look to properly populate the VC field with follow on patches
later.

Fixes: f0fc808a466a ("media: qcom: camss: Add CSID 340 support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/qcom/camss/camss-csid-340.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-340.c b/drivers/media/platform/qcom/camss/camss-csid-340.c
index 2b50f9b96a34e..0231985746edf 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-340.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-340.c
@@ -74,9 +74,9 @@ static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
 	writel_relaxed(!!enable, csid->base + CSID_RDI_CTRL(rdi));
 }
 
-static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 port, u8 vc)
 {
-	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + port];
 	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
 								   csid->res->formats->nformats,
 								   input_format->code);
@@ -88,14 +88,14 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
 	 * the four least significant bits of the five bit VC
 	 * bitfield to generate an internal CID value.
 	 *
-	 * CSID_RDI_CFG0(vc)
+	 * CSID_RDI_CFG0(port)
 	 * DT_ID : 28:27
 	 * VC    : 26:22
 	 * DT    : 21:16
 	 *
 	 * CID   : VC 3:0 << 2 | DT_ID 1:0
 	 */
-	dt_id = vc & 0x03;
+	dt_id = port & 0x03;
 
 	val = CSID_RDI_CFG0_DECODE_FORMAT_NOP; /* only for RDI path */
 	val |= FIELD_PREP(CSID_RDI_CFG0_DT_MASK, format->data_type);
@@ -105,10 +105,11 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
 	if (enable)
 		val |= CSID_RDI_CFG0_ENABLE;
 
-	dev_dbg(csid->camss->dev, "CSID%u: Stream %s (dt:0x%x vc=%u)\n",
-		csid->id, enable ? "enable" : "disable", format->data_type, vc);
+	dev_dbg(csid->camss->dev, "CSID%u: Stream %s (dt:0x%x port=%u vc=%u)\n",
+		csid->id, enable ? "enable" : "disable", format->data_type,
+		port, vc);
 
-	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(port));
 }
 
 static void csid_configure_stream(struct csid_device *csid, u8 enable)
@@ -117,9 +118,10 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 
 	__csid_configure_rx(csid, &csid->phy);
 
+	/* Loop through all enabled ports and configure a stream for each */
 	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++) {
 		if (csid->phy.en_vc & BIT(i)) {
-			__csid_configure_rdi_stream(csid, enable, i);
+			__csid_configure_rdi_stream(csid, enable, i, 0);
 			__csid_ctrl_rdi(csid, enable, i);
 		}
 	}
-- 
2.53.0

