Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F050C2AB;
	Wed, 16 Sep 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568374; cv=none; b=CHxakXVC3u5LGdd5NxnHGCghHryRI2kQq63B0Ms2xhXQiQjdjbpEiZwm3uoRioRT14aqkboZ5yTODaVF92Tu+LT79uQSpdVhsElODbhCxqczyFqh7W9bs9v5IzSKn+YoF8l/im1oDNB4uCHJYLfT5lDoL0J/mUKqw3sRAJFcduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568374; c=relaxed/simple;
	bh=6CbH5g9xb8aGFIjAvPk/cTfD2Kwj5m96Ep3ntBhZmZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lVExViRNCttgj/pkX34qjt4/QAlDMzOVHoysDGihijj8UahtXNfUCzkp/u0bG5X2yAxw3avtnj2OSTqW+7SFtJWvBPfvs2fR0wpSSnfm+UgC9095aBS0N3FFckAs2nujria2jl6fcv92S/Wikks/g9nN9EOGjidKzk+I7uZPqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DSloliY2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DSloliY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568372; x=1821104372;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6CbH5g9xb8aGFIjAvPk/cTfD2Kwj5m96Ep3ntBhZmZY=;
  b=DSloliY2af+U1lyvFQ4NIb/+Ypy8+hdOUiA32KbS7K2zwXlCCusPr6vL
   ynLQ4DVUxjUwF3OYY81Bzqp2j9L2hITq0etriMqKtvHC1e0uYlScw06Bx
   Qdo9A29c0c5BAjS9DU00krmb/30AajgWFH7A26pTcvkgGVeSm/mn3dALg
   wrmwmQT9pkR6PDOikA6FDE7gYjs6Z5pFGpnkKP9QYrsJspuYU+vbXPwe4
   oYM+JgrMzVRcQP+JDWgz28z9krKrstzvVkmIMGVnTwIBngDAVdvHt0UL1
   hcCmor+SomX/pKZZz1SF+bS3k2o4dOrxIS2uBCX299rlNcrKUFHK6FxBr
   w==;
X-CSE-ConnectionGUID: iP8P1HvzS8KO9TYqKEpMVw==
X-CSE-MsgGUID: 8GHGdDTcQ5GdfS2oKYlD2Q==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295112901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:10 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:07 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:30 +0300
Subject: [PATCH v6 04/11] iio: dac: mcp47feb02: Return len when disabling
 EEPROM store
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-4-285464651f89@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1071;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=6CbH5g9xb8aGFIjAvPk/cTfD2Kwj5m96Ep3ntBhZmZY=;
 b=Ir8FfkHfkV/Lm5x1jMwuM+PJkYn8QS9ILDopmbIjazZslDy9IU6KSAuMnVbbaJ9GHme7clIo2
 JHVmufGHrXuBsJvbZq54JlvHmOPElDcEFPvke6OZIKpjXd9zSrI7x0/
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

When state is false, return the number of bytes (len) the buffer has
instead of 0 to properly signal that the input buffer was fully consumed,
preventing unnecessary write retries.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 81aa9063fcf730342d4af114da73ac2fc550243f..117fd41257d5cd430c00847ff64c22c6700dbb6a 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -468,7 +468,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 		return ret;
 
 	if (!state)
-		return 0;
+		return len;
 
 	/*
 	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,

-- 
2.43.0

