Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FD481A9A;
	Thu, 24 Sep 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254778; cv=none; b=Qn2F/rczu05ZHS9P1gOAF98kZratDil6Yp8AYl3o0ELQ7dPs11312Zo5PwfJI/grKhtuas7LQMC/SIkOMOp5xw0akjMkE/0PjIowWBPMBECh9cbjyxYD6s2Ajv7tfPVDwH3p8g9wNJTjK6qJsnKH6lodXkZWuZrAAeXxE7Psw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254778; c=relaxed/simple;
	bh=bdoHuvE8UWJ8R4nrZBOTOtHzH+i6nDMYSEr/axEaHJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hM7cfSfuSpAxMzTmHHEV4bs/bBK1cti9TwamHSXT2CB8lkAuc2wNALEMzqrUXJnA5HC32W3n4EbzfjPPjqX7tE1iY9S2wR5RthMA636rlzciedXL3YyNaBSZcvHDmOmJI83aYW3V4i+9TFF6nX8RpL7FcDlO+kjuexDoAXu6Sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vNA2QnOP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vNA2QnOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790254776; x=1821790776;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bdoHuvE8UWJ8R4nrZBOTOtHzH+i6nDMYSEr/axEaHJw=;
  b=vNA2QnOPv88EfgwXGL/FNFkwvVt69yQ5ZcmEx0y4Hv7jpEx/55s/gyNU
   S59/Mh9u5zaB7UO1XuO4n9atAHm5ghzzrFchzFgNhb1ALItxTU4AtmAjB
   1BlYMSK1WOO7Fbs+kIplyXv341eYSeOuHI3SWSrp/LBkKdzShvrr9LEVr
   IBM47tb1e0E85d+17IorJHWLl9BPDaOuD+QfNOsONhUkO7R0uhPyMUJqF
   M+EdKJ61Hn3KbxwC1jKDQgFi+DmGH01mijWGIKshNeEHtXhGXUN8uf0sy
   GV4nINX/VpObkNNEs7QNv5BxcnBanSX8oDSj3BdCPnpd6a09c27HYvKQ2
   g==;
X-CSE-ConnectionGUID: +Q1Pv9x4TZiAbI17mVrZfQ==
X-CSE-MsgGUID: EouVIACxTJKN6ydkeL7pew==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="74233423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 05:59:29 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 24 Sep 2026 05:59:25 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 24 Sep 2026 15:59:19 +0300
Subject: [PATCH v8 1/5] iio: dac: mcp47feb02: Avoid unjustified probe error
 on missing label
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-mcp47feb02_refactor-v8-1-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790254762; l=1944;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=bdoHuvE8UWJ8R4nrZBOTOtHzH+i6nDMYSEr/axEaHJw=;
 b=FWQOOM8vDJxJ55BxHm2eUiypocpw25h3XgsnW83GczuWu6UvvnoQK43o3gpwE5QQVdHgIHG9a
 /HncETmmyNUBCqFR5NPPyIL3O4Mp6x0BC9Cq13SEjRGbyrIC++2zlo6
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Fix unjustified probe error on missing optional 'label' property by
replacing dev_err_probe() with dev_warn_probe(). Correct %pfw usage by
passing the child fwnode handle directly in the error message. Besides the
probe warning a read error is returned at the attempt of reading a null
label.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 3187a7d95ca8ce4aacf27efc588d9b33eb429aec..349574bc7489d9e5ac9722c3abbaaab0d2c3350e 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -929,7 +929,10 @@ static int mcp47feb02_read_label(struct iio_dev *indio_dev, struct iio_chan_spec
 {
 	struct mcp47feb02_data *data = iio_priv(indio_dev);
 
-	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+	if (data->labels[ch->address])
+		return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+
+	return -ENOENT;
 }
 
 static const struct iio_info mcp47feb02_info = {
@@ -982,10 +985,11 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 
 		set_bit(reg, &data->active_channels_mask);
 
-		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
-		if (ret)
-			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
-					     fwnode_get_name(child));
+		if (fwnode_property_present(child, "label")) {
+			ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
+			if (ret)
+				dev_warn_probe(dev, ret, "%pfw: invalid label\n", child);
+		}
 
 		chanspec.address = reg;
 		chanspec.channel = reg;

-- 
2.43.0

