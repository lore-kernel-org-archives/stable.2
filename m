Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916A41D129;
	Fri, 18 Sep 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722481; cv=none; b=at24empVilia3x9WT6DD/PGUGIaJCcEz/gplqwePq5tJIUkxQSqZOfT6M6eNIG5d5DINo6df0OFoZKHQ/dJ5VNB8WOu1R3Dc2cwn8rLduROYjubGVbshBn2uh6zwFI3m7gkceYWgpi0C+jZmmwXZ6O4fmpQebJK6f3Xl5oI4ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722481; c=relaxed/simple;
	bh=wWM5hqIN2zstuEyBHmaV/+dpBvmKR8Oev20eC7wtBCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TKo2BP7b8rLuQIDkrKLivQZ7cnLHg/yhR2sPpp+oBfOjfIxg8JvRujb+bXoRU/5Pw6hxEK+mdxwecQlezf0pmSFLl4jEpzwrG4EYVxDL95kBANxjUq5uJDpJWoBzElVS6HGxBlGD6a9Nl9P38v7cTf8NVDMKpUxdR6jIkwVZQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xVEZAGJP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xVEZAGJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722480; x=1821258480;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wWM5hqIN2zstuEyBHmaV/+dpBvmKR8Oev20eC7wtBCk=;
  b=xVEZAGJP/ysPgFqBqnFm/xZLyOrHCQvKQGCYkpSGCsIiZC78VBsKsW7y
   tLlPoeJzCs5/deS4lakDaK+YmheSQHWFFTLJfPG7his15C1jqCY+HXtTK
   IOF7yYxHL2sWPv2pJ+6EdeB0lYEVoS5h1oKeRn3Iuv8XUVye7Y/0X2CXA
   MBETCjWHLptDIzCDXb4yEqf4uP6mqU80ICO5RnqM22vHlR9rRcbIlBhzO
   jejrTI3PYFK+bhc6VCWUWPSIIMOghtwNH0v+oTPmHUwfD7xKEesML5VP9
   waUqu9Wu8By1ASnwYyweqzUKmS1bQ/V90iyRsXZ7TjrNNLAfqNwZpevhW
   Q==;
X-CSE-ConnectionGUID: 2UlMkbp+RV6cNPq72wdzlA==
X-CSE-MsgGUID: JmG4YNgNRQ+MjfrFNTUsDg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800312"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 02:08:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 02:07:59 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:56 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:32 +0300
Subject: [PATCH v7 06/11] iio: dac: mcp47feb02: Avoid unjustified probe
 error on missing label
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-6-82ca794eafe2@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1737;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=wWM5hqIN2zstuEyBHmaV/+dpBvmKR8Oev20eC7wtBCk=;
 b=IRcDYWBk46gaAxH12SzBj2vHACcDb0TVucfkKgSczTLivkX5FCTv0a1p4z+LG/x3hI8xT+cBI
 O//BIhUY4H7Cw8mgRFJdtZ2st4QfkDHTpy21yNfTeaNWiV00HghB6iH
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
 drivers/iio/dac/mcp47feb02.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 9d4ba95da84ace639aaefe87262b7125def2a48e..43cf69e43a41e3555e37d1351328912dffb84a3c 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -921,7 +921,10 @@ static int mcp47feb02_read_label(struct iio_dev *indio_dev, struct iio_chan_spec
 {
 	struct mcp47feb02_data *data = iio_priv(indio_dev);
 
-	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+	if (data->labels[ch->address])
+		return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+
+	return -ENOENT;
 }
 
 static const struct iio_info mcp47feb02_info = {
@@ -976,8 +979,7 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 
 		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
 		if (ret)
-			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
-					     fwnode_get_name(child));
+			dev_warn_probe(dev, ret, "%pfw: invalid label\n", child);
 
 		chanspec.address = reg;
 		chanspec.channel = reg;

-- 
2.43.0

