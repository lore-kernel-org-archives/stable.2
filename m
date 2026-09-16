Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFB50EBF0;
	Wed, 16 Sep 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568379; cv=none; b=VqMWupF7y4cwSDP4LvZBhy4RLJ1J44y9JTOZGKoOWChR9RBtEckp7N8gUNsUXbwC4d5lrNhJuZTbFR1ri2XrdpQx/wLTOR0/Hh7B1+6mP/h6NaxlMHHHYbstnAe+QGQkDZYe6sLjgk7ha6m5upGBFTTpVUS7d1S4SLrUisbiT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568379; c=relaxed/simple;
	bh=RPWR+utL1wFVxZQuhh5GixCRURCkFv4ScEemilc8jQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EB58PEKSw7TnKbo3x/p1Z1k8cTs9CjneWL3b/wZ9FVTQol2t7yMoFSNzgqsiABHETXfSw1NUMn0rPI4eDseLxHSCZnU03qwiXMm+JksrpnJydmF11Ua3KMS2e3VEBqFhRTy7AZBAve5cNOiPu17s99g5y2/XggzVtSV4hd2TlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jvmvMmxa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jvmvMmxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568378; x=1821104378;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RPWR+utL1wFVxZQuhh5GixCRURCkFv4ScEemilc8jQ8=;
  b=jvmvMmxaOfVIxfilJBaK/RlNVaCcTJ5whg0d09pEr6ucZsjMVMHNKL1u
   CAvMGXukM87hc4C44TvgVNTZYDZuX+bZH+j21sTPJ/SgjidSikKI0R1rW
   GvxXT+lBQcj4u8/xJsegMGGBlxqar30RtX1YTiAEPUl7f8kZZ8nd3ccZh
   HZNdT/QwY7Du8Fu0/peR0PjFct3XVXkx3FQLVmMocdW0+egZ/ZrwYDyx2
   FnlMTRzu9XxV9P+OvIoCPQU2OQZ6gPR6X2M5UhXH1uuleN0qubUwuRYiw
   Ty8tK9uS0ey4rV/W8gMaQ/tP4lU3e8t2e4/rqD/A9yticOb1I8Bm2LlQg
   g==;
X-CSE-ConnectionGUID: CGbd2ULzTIqzfFz4HxHHzg==
X-CSE-MsgGUID: 9exf0U3KTw2GNJ2Uczr8xw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="64005049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:01 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:18:58 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:27 +0300
Subject: [PATCH v6 01/11] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-1-285464651f89@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1454;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=RPWR+utL1wFVxZQuhh5GixCRURCkFv4ScEemilc8jQ8=;
 b=Exlwv595arh3SX4kDlI5m2qfHMOo1eVwKK0mw+KX492bVaBXkRkUwjlzL8LPxFO3vqnq42mlC
 T9qWZzlZJQhD7jdKRzA5tzfbnNs+MCM9Iucd13Lmp6ZrLXs/ilWI3CR
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Prevent operations which use cache from overwriting default hardware values
with zeros by reading active DAC registers during probe to correctly
initialize the channel struct DAC values.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 8640b0ef4433da2b40d4b7e53fe6109737314951..6a3875e1d6a2c0cdd146410358130c44b1360f56 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1019,7 +1019,12 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
 	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
 		struct device *dev = regmap_get_device(data->regmap);
-		unsigned int pd_tmp;
+		unsigned int pd_tmp, dac_val;
+
+		ret = regmap_read(data->regmap, REG_ADDR(i), &dac_val);
+		if (ret)
+			return ret;
+		data->chdata[i].dac_data = dac_val;
 
 		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
 		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;

-- 
2.43.0

