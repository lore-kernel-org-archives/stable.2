Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A824AD7DD;
	Fri, 18 Sep 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722469; cv=none; b=C3PXOKdi0bVUGasSPGLCl3N/OF2ABefqNxe0GrFc7PKDXuNGwn+Iu1QM+fW7xrBC6XvwbFlzGboDbNabgy1EPfw1+gYN/Gm2FcjLydoMDOrReS3VQt6WahKEnc3GElPrJ+jIehmMLEyZfLewE02/xN0e7IOGJSnK1TeQqmByj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722469; c=relaxed/simple;
	bh=H7ypP81i1RuzGXOXcicos0XVLScuC2MwSzhDWEVRRBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Jsd28J+ZFL3gv35XLs0ggsgVIWsuMKmQ95+h8Y0F0ojwmEfqjNIW28Quk98ZBmoPztRrbr5O3br4XgIJm6PyWFZtdHOuwvYwtpc4NUnOvJ7OVQHmILtO1XNgTtHg2naHnEWtIzOdc2ClH0cNgqFf8BvVi1OQLJaIoaQZ0UNSfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KmvugFwh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KmvugFwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722468; x=1821258468;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=H7ypP81i1RuzGXOXcicos0XVLScuC2MwSzhDWEVRRBU=;
  b=KmvugFwhntLqdB9PbvdXfYodzfH3Q5/ftvtel60UwbBjmVz/pOfNExAu
   YeK+/GjkqIMAlvT7nTu4iRkN/ojawdtXgSwKuGPweI4BvJns6nvkbc+KJ
   DWFpCw2sKtoCLcLQKpH5rZElA81ghfFs8nygoln5wrz1iZ1CWiFM8dBrh
   N/GQuTXSZmG+e00ft+blau8Jj9utRTiRque64Hlh1zuopE7mSsSj+5HVM
   4JrsBfPbTwXFMFNH9M8DiHdppOd88ZzlocymcBvMJwBziaiLaU6cgosas
   02DQu2BLUsj7Z/z3sMcXvDY8FhkkZSVZfSoHeBR84ygVCUuBms+LsZ/Cn
   Q==;
X-CSE-ConnectionGUID: bxSGWTohSHyBFNDg64CJ0Q==
X-CSE-MsgGUID: 0BYFzx4wSuupdEM1507mCg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800289"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 02:07:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 02:07:47 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:44 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:28 +0300
Subject: [PATCH v7 02/11] iio: dac: mcp47feb02: Fix gain field
 initialization for active channels
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-2-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=2236;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=H7ypP81i1RuzGXOXcicos0XVLScuC2MwSzhDWEVRRBU=;
 b=YM+CWxQLIQNtgmVIRUYXJmcA5GV+wazsedslWyjwr4QspNdtN0TKLaYMl/OCaSwdi9mAXaj7J
 ifQ7HcVPwI/ATQrlwwo/Jl4acNQLuGZWgxXu8gtPQjO+OgqLryVhxrR
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

As per MCP47FXBX48 Datasheet, in the format of the Gain Control and System
Status Register each DAC channel has one bit to control its gain,
starting at bit 8, while bits 0-7 contain status or unimplemented bits.

The previous formula didn't initialize correctly all channels, being
replaced by using field_get() with the already defined macro used in write
operations where needed in the rest of the driver implementation.
DAC_GAIN_MASK(i) extracts the gain control bit for each active channel
correctly in one step.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 6a3875e1d6a2c0cdd146410358130c44b1360f56..1b1a4972f77196399297b3912abe69efcbf17d75 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -36,7 +36,6 @@
 #define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
 
 #define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
-#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
 #define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
 #define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)
 
@@ -1016,7 +1015,6 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	if (ret)
 		return ret;
 
-	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
 	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
 		struct device *dev = regmap_get_device(data->regmap);
 		unsigned int pd_tmp, dac_val;
@@ -1027,7 +1025,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 		data->chdata[i].dac_data = dac_val;
 
 		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
-		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;
+		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
 		 * Inform the user that the current voltage reference read from the volatile

-- 
2.43.0

