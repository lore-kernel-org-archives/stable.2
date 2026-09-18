Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD13EFD27;
	Fri, 18 Sep 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722484; cv=none; b=dukqcb16HTEzqRc+s895POsTcfPOq6PBI5A7w5P1waXMO+w+3tko6gDUZFzGvtwP+KvwpfKpU5L7mT/J6aH+fiuAwBY9I3nqTio3zcEiFS0Nl+pd5BU5RhBRcxYUib7iqFxRAn7jS8weEgLBVvXtVXKqhhbxfyZYiEiMVU5Ty34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722484; c=relaxed/simple;
	bh=a+u0WLPF1pBjssaax87p4zK10+4fRro4TveSh8jNkAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YziWDJe9Jm0ADAsh89jP5ea0wZtIUtFC/YoXEFHXKK2Z+zZb7648/kHALulL6OMAabGJe7lbS2q4lApLuFtSqNmTw96muyCuyw5ulF/iIZPCpoXiCDwQe7LWzmGx6Q+1fMWLHOK0rxZANk1921vSPLI0rc3Ii5hwMbsdNrmYOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LlcUTmcM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LlcUTmcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722487; x=1821258487;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=a+u0WLPF1pBjssaax87p4zK10+4fRro4TveSh8jNkAk=;
  b=LlcUTmcM3iZq7xzOE3sAejD8cs7VbWeSLbkHiNQL++NoEp0ZQTKx8zGG
   EPhqY0JCBsZ0ImoGQ0cByfKGc4SHIh6R6wrvqzJwBA5wQvTCnISjfGOSa
   Uw56JQlMMrAiCk/dvWCtanhYNIpqgPZHWDCD/WwyRnXhL8TbXonj+bYJm
   YG25XKSh2F9cjTfJZaZ+dhASGb7FVTx10Hm0FYIkZ8DRa1JEbRGzw/xLY
   GTcrzgMQPl8MkXTmUoKTJpGRDBsjQ+TlPWAmi8d8dtF8hcEC5sLz3VKM4
   fYNsRFIt9wOXLw6sBrtje8N6dVVW/D42YlMpQl8ZlhKQrrW5QrVicaoKj
   g==;
X-CSE-ConnectionGUID: DfTTcDInRgeI3lAjtihk3A==
X-CSE-MsgGUID: 10IzJ8zEQZ2Q3ChEWdD84g==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295219128"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:07:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 18 Sep 2026 02:07:53 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:50 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:30 +0300
Subject: [PATCH v7 04/11] iio: dac: mcp47feb02: Return len when disabling
 EEPROM store
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-4-82ca794eafe2@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1073;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=a+u0WLPF1pBjssaax87p4zK10+4fRro4TveSh8jNkAk=;
 b=+QIx3hxCTSWoNnDjJfyfnG0dC1wLSDQZVo+MyJbaUbQVAZmP3XjYiYkkAlXiRngtztRll5o2E
 Xy20XwdifGACmD7yZsPWduEM59vojlMWHjNAZgDf4+J7GlAiTCCalmR
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

When state is false, return the number of bytes (len) the buffer has
instead of 0 to properly signal that the input buffer was fully consumed,
preventing unnecessary write retries.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index d910a6cf9718d6c6ad68eb1bb1ff5f3b15b33e84..2bd2e1bd93db01f79122aaeda2ba4ff14320b404 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -467,7 +467,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 		return ret;
 
 	if (!state)
-		return 0;
+		return len;
 
 	/*
 	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,

-- 
2.43.0

