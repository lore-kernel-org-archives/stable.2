Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE14B44B2;
	Fri, 18 Sep 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722473; cv=none; b=UWq910fzFZ6Tk0enSKW6GDFTj4iE4ZbRyWU8dxYC2retgNbzH2d35LRpACytsYeStnK/tRfGc2Rc9vq4kdf+WPFTyAcBYCvE1BZH7viOFFcI4HtA9somfgqnWhlF3oYvxqjU28LdwiiemU26AVqoq7pwjT0VRyW6JwJt+GA1hmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722473; c=relaxed/simple;
	bh=D13TZOBo/DBaAEpd1EHxDAh+ujhHKHZTmqUwewFTI2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r+JDWd+NeW8cFrFlpZ2ubZ13UtmUGtanVCMzyxtb7wwbrt6g0Hzw0aj0EReMGxgHQIhTIVFNcBhOM6Z1w8MgLZVYUS0hyrv5w0dDkqAccz5QV3kYHo0wT4LMg6PskkyqQs5kaCBLsjqNwWDN689YZjqDf5wNBLYO6wv6PurCfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0+QPEqwI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0+QPEqwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722476; x=1821258476;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D13TZOBo/DBaAEpd1EHxDAh+ujhHKHZTmqUwewFTI2Y=;
  b=0+QPEqwIHOqvRidtzsQrMOkKxOSlqXVOLSa3Ws+3ZATzlcLfkZ33AJvP
   sxli+CYV0MboP6P21CKN2FqCncdW/yMFsl3bG0XmlDY2EkOXHxThyjj5s
   Y3+0cbaXkkwRuyHNpgu05HiBw7B+foLegHgNyNs8l5whRkK5MwuLAc7qn
   Eh0sKTSgP9ywhBMlfPH4unVI87O93GXYibEccKJK+KpfzVIYiMgJ+MtJB
   DNQf7dFUxPR+M7G/eovbW+pZLTPwP+sjktLKVdtbOfR/CcsX4g21QJSVM
   eu6Q/bTCoBZFUnnvcOHvdVC6L2qscYhbmmezmXADgtVvWC1xG0L82bEt6
   A==;
X-CSE-ConnectionGUID: 22ucE62hRaioW9R9KVc3HA==
X-CSE-MsgGUID: 1NexWXW1RtaeAS2KsRfceQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="230919713"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:07:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 18 Sep 2026 02:07:44 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:41 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:27 +0300
Subject: [PATCH v7 01/11] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-1-82ca794eafe2@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1456;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=D13TZOBo/DBaAEpd1EHxDAh+ujhHKHZTmqUwewFTI2Y=;
 b=F+O1vuxIjH6444hmlyQoeW23D+z9Oszs0HPN72NbJ+CRlGqdslxu9Vr2vNU0DQ7eYUuOd5Tni
 XDmJfu7AyNsB0iKYAajM4B1Ldth80u1Bxnwc08Y5FCfx+Y00khGuUDa
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Prevent operations which use cache from overwriting default hardware values
with zeros by reading active DAC registers during probe to correctly
initialize the channel struct DAC values.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
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

