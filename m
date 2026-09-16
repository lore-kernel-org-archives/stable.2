Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984F221FC6;
	Wed, 16 Sep 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568358; cv=none; b=H6q49rrWxMSeFUj8qZIFtYLzetx8VvDXkUpdXYRnpKa0ibNANZd31xsvXPNWNPwodKcgbLPCBEIgsJWG/w8pzSInqCo4sKMiSJG2SocM8T49XNGyrTWVDd6Hubhke/UFV6D/8c0YLAyaObxqBaP/wHhIJRqTV/G/cunWHM/lWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568358; c=relaxed/simple;
	bh=VOZY+QFz4ZsjIpUzis+4ZEZT0aWP9ydqzPyw7njG/3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PfeTfNx5WyYRX78CQLYuAnWFlZCjcuNJDWaWc+gUVp5wTe/VjhAYvLBAmYG3DrzsfNUVaP/yy8+qOuN8fYvlGhnEkbhmy7TFtC+0YCCX6JVc8eKIV0wonkwetNgl+SAc84Wowl9mVBuHF4Nia9dcFvJUnYlbPEfkwr4z0cWtrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wb6a/tuw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wb6a/tuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568355; x=1821104355;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VOZY+QFz4ZsjIpUzis+4ZEZT0aWP9ydqzPyw7njG/3U=;
  b=wb6a/tuwuOYvd9pwSNzWf0cbo3A2Da42JswQxNV8t8q8O7PT5/hhw9h/
   5Di3zoI5QMJnoBYlHmciVmSj625q95z4CzCWcAS5c4kHhBi8IaLUEqPtn
   lXptWrjeFsZQ7lIttKD9E2FkCDky1BOpOTaFEXCusjJDTphXmsUPxDa8Y
   ELCCV8Bau40QOssj6LaqLkfs59o0BjY/z3WCiGXDQhu1RqUnymowirB8x
   vY+0oO7E518v5YCfB3Tu/21CXdAPAL8q82YfIoISYfZfXFh3yhDp/AoRL
   Bp1/iiKeIGwfHTzrqjUJqXVLBZQVi7IyGUkA0vkKBrCrYmH9bheLpPxiY
   g==;
X-CSE-ConnectionGUID: ceDk0jBeQo+D85YcNJyfCA==
X-CSE-MsgGUID: Ar8f7sAiQvWjv6k62LoUlw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="73741287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:19:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 16 Sep 2026 07:19:04 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:01 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:28 +0300
Subject: [PATCH v6 02/11] iio: dac: mcp47feb02: Fix gain field
 initialization for active channels
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-2-285464651f89@microchip.com>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1952;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=VOZY+QFz4ZsjIpUzis+4ZEZT0aWP9ydqzPyw7njG/3U=;
 b=ENkUIWDHksVxKd4JSg6T2JwHOjkX8GVDpOpQLnPd1hmLf+OqlEU80IDP+Ox9jPX0F9KTdRMhi
 e96wkDg29emCVEwjLOlMTy4mESq4vmrL7ikqQSgBdkDF7FV+ZaGq26T
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
Link: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 6a3875e1d6a2c0cdd146410358130c44b1360f56..fa4bd1df954844da35a8496758489189aeceb60d 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1016,7 +1016,6 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	if (ret)
 		return ret;
 
-	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
 	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
 		struct device *dev = regmap_get_device(data->regmap);
 		unsigned int pd_tmp, dac_val;
@@ -1027,7 +1026,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 		data->chdata[i].dac_data = dac_val;
 
 		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
-		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;
+		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
 		 * Inform the user that the current voltage reference read from the volatile

-- 
2.43.0

