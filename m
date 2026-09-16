Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648450EC19;
	Wed, 16 Sep 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568375; cv=none; b=t8KqmF7eRqiBL6vPwz3NEaWfq8HmC7MHTBgnchE/DUQOTONPGKjElO8yx/Xd5DjkTazilGz8ZxNA8EslL+O1Jq83mqIIuuUHADyQB2ch9G7qvZ45kyLUK91ZDpDA8jsNK6RjiRj0WUQtAqgYokteGGF5mboZTviTEoMuRNpFWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568375; c=relaxed/simple;
	bh=+kWJEeu8ElxCpnX6JU4X0XLh4hbXb/rAngt2K6QiMbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h3o6llE/uRhcl+UQojZSa3j9zLvHrYZlvKDQTWMsJU4PgJi0K+riPAkHQynKaWdB3ETcZLWGLg4d9jr4v4N33ZyDA1ywKjyhOidzOeAzzFUGYhJ80+OxYB34E7rwxdQLZTQLkC+DLfi6gCe6ff7oksTIAr2GpRtHxYNCSZFF4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pH1nu+eS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pH1nu+eS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568373; x=1821104373;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+kWJEeu8ElxCpnX6JU4X0XLh4hbXb/rAngt2K6QiMbA=;
  b=pH1nu+eS98/7fZ+L858kNRcHL0ZDhLGRI6XKRbdPtyzIAu5UQKO/JKmE
   luzE2WsrRVZUTRktNQyHrWQnbjV+7AiNhOKBJz4JvzNOJuQP3OvMFYTyK
   42SMZCdQseHI4fX9VZqSfC4fhxz0JA5ETP5IbIYdtVEWT+EVrbkWRVarE
   uzpTJJ6pJbp2YxdlQpmCmzRPuWOFG3HYvrDbmTyPMYNy3zbWR0n18U/jX
   sAkTT2L6RT0zWehCGp5AgZ4dsuipgT8m21aKePh/iSSkm2mQ2NeFAZ3RC
   NMgbl38CN4VPicl7xB88+U2pAoJWOmBhROndXP7mOjKoVwavpreUw/KTh
   Q==;
X-CSE-ConnectionGUID: iP8P1HvzS8KO9TYqKEpMVw==
X-CSE-MsgGUID: wGUSn0uXT4COerlA6Inc8A==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295112902"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:13 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:10 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:31 +0300
Subject: [PATCH v6 05/11] iio: dac: mcp47feb02: Increase EEPROM Programming
 Write Cycle Time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-5-285464651f89@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1619;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=+kWJEeu8ElxCpnX6JU4X0XLh4hbXb/rAngt2K6QiMbA=;
 b=9kUc3+qb9QNQYz3yKGTwzW7P+uirbY9Alb0DLx6f2iZk4VwYt4CdETsAVE/M4370gY4X1rGOM
 +bJgMOeUGr7CgpbqOwymy3T1jJla+dMwMd/bpng96KYMa7KWgsavI31
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Increase the EEPROM write polling timeout to prevent -ETIMEDOUT errors and
incomplete nonvolatile write cycle, according to the time specified in the
datasheets (11-16 ms).

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260819125300.6B9211F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 117fd41257d5cd430c00847ff64c22c6700dbb6a..a93e05cda5f36baf8f7573a1bd92bf6167227362 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -448,7 +448,7 @@ static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
 				       eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       1 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
@@ -508,7 +508,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       1 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 

-- 
2.43.0

