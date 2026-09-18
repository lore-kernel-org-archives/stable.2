Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7C3AAF73;
	Fri, 18 Sep 2026 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722479; cv=none; b=Fy8R8u7/3tgSrOxbDCZjaixHB7lc8KkchNA5CQF1sZr2f1cly5JAtwCPvbrd+JRem76DD0kZqL4sXNU6Wgdg3FZqXi4KowfAa18v/T+ZQQq4LsgmuK+k9h3zH6R647Y9h135+Y1Q1VOYN6Ob0jYXAeOhB4SXpm/Wwr9MADJmFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722479; c=relaxed/simple;
	bh=OwppHPjFW6q4/wKixu3bgggc1W8zAnp5gDVDPfMzhCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ALuEN2ve9OxyfV72uRvc+q1GjogmqEmJz29hV9dl7ugYfxuENs9wgigLIJ7l1Ix6aiht/UNqyJvyksJA33JwjCrbZ9h93+eMxA4uX/6KG85b+DIiuHGU5Hm83WDei/Li+DBfacc2VWb1cuCaAYjuJy98Y2emSEAINto6uag8buY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kzRV8qfi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kzRV8qfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722478; x=1821258478;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OwppHPjFW6q4/wKixu3bgggc1W8zAnp5gDVDPfMzhCs=;
  b=kzRV8qfiF/ce/nzCp1Ds1GKrMk9o4JCG6hh0YfXUnsNsGNdylTj067ev
   0y8Ehb3r9KljFASLoJQRIN1GnQ4lQLzFETUc1drAHVHwXcYKRkN/20Yrr
   Fp2zJp0xQ1U9IOOUFcSjmmo0UnvZR4d3XqdgjrCA9/KoA6xQ80LNQFYQ5
   ogKWRShFusmit66dqAG7RXc+EghPvDGBl/mpmMq1gZMzDyUONQyWXT/Yp
   +Jbs5lpOOWkIaVIbbJyl3yQBdZEbOhiR9KemUIXdrTeuAiFLqt9k3qusv
   IC0sO4cz8tI7Y3zkrPse594DIJTIsDLSvE13EptGrmoX3UXZIUT+XdAME
   A==;
X-CSE-ConnectionGUID: GJQqhz/ARuSzKB+Aiy7X9A==
X-CSE-MsgGUID: gdX/MxDhSdiGkcjucePuAw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800309"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 02:07:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 02:07:56 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:53 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:31 +0300
Subject: [PATCH v7 05/11] iio: dac: mcp47feb02: Increase EEPROM Programming
 Write Cycle Time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-5-82ca794eafe2@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1621;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=OwppHPjFW6q4/wKixu3bgggc1W8zAnp5gDVDPfMzhCs=;
 b=ZDJICOI22B1TAHh1bLTA+I/rawICaxGI4eXnjDV0CeAgAXrJAvBVpds8GCexwa8k0SIjo9748
 ewZO55F8KIsAkc7uH7V70qW9M7GmWZMvyZhO+KZ+OH+dJG4ZVBymnyB
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Increase the EEPROM write polling timeout to prevent -ETIMEDOUT errors and
incomplete nonvolatile write cycle, according to the time specified in the
datasheets (11-16 ms).

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260819125300.6B9211F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 2bd2e1bd93db01f79122aaeda2ba4ff14320b404..9d4ba95da84ace639aaefe87262b7125def2a48e 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -447,7 +447,7 @@ static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
 				       eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       1 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
@@ -507,7 +507,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       1 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 

-- 
2.43.0

