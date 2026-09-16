Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAB50EC17;
	Wed, 16 Sep 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568376; cv=none; b=atv6Zj9Q5l74/2jprUJQhcaJBJPuNyo3EQg0GUqjCINfX7+HIRCownyhHFdOmx7ETz1paPT3IY5NpHTOSEkdJkmLzWazfeGMR6dJ5HmpwxPyqZ+PF2pgy7do6f08ZE3UHy+5OFN2bxb7qnpY/vXmWgqsCjDJ5cYwi+CO2OBu2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568376; c=relaxed/simple;
	bh=7ixAN1P45rRGyJOWyzUIt+JTzNcUYOwqNI/WyCYDSD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CIPt2Zrx0vMYzxUcKTPuSPigk4DLD6nJ6Py+pmQwcXb4KQPJ8w3WdxXYctW+75cXH6SfFaxJ+PsK6AuPUK4Xk9c9CcUhI5lQN1bdYCymyxIiVcgCWiwWHqHp7K+U0uhUc8SAIoljoHBn7MyTdtb49wNsQCdzzCZyPSk9OCKyf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OYKecV5q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OYKecV5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568375; x=1821104375;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7ixAN1P45rRGyJOWyzUIt+JTzNcUYOwqNI/WyCYDSD8=;
  b=OYKecV5qrMVZma+2TTTfZtt/5jatPQfxNj4lMCyPI7hccgal7T8AVvEA
   sBFZ3FeGYpY1DFfVCKcVvpibkpJ+dnzNNBmZXYgTfaWeNDh9P2hOdPqXs
   uacgzYl2eNC196fjY8/jvwNYKmL0LKVFi7xuc3ZNFpWmxddb4dhezk4Pl
   FNCoN/3/lclCBb77PAkPau7rP4fTS5hZ3V6wz+il3ws09ftdxdR78Oo0+
   8BA4sgN+vbmWKnM9KZmNOsN9cdzUF2EumjgSPlA4wQehKFU79cJz7/Ska
   BsDgnuaKQd0GDu4lDdxOB2XGMQ6Oc9gPRjiA0D7ZXKdj96552tkskxIWA
   g==;
X-CSE-ConnectionGUID: iP8P1HvzS8KO9TYqKEpMVw==
X-CSE-MsgGUID: gCiHPTHQQ6itT7YB2SV0jw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295112903"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:16 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:13 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:32 +0300
Subject: [PATCH v6 06/11] iio: dac: mcp47feb02: Avoid unjustified probe
 error on missing label
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-6-285464651f89@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1735;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=7ixAN1P45rRGyJOWyzUIt+JTzNcUYOwqNI/WyCYDSD8=;
 b=qQHHMbG+TTwMCpiZQdw5Q5zPz+6tJPH9Rmt5lBGu9kX0kyFaks+O7gSd8/zEJBJIkHF0z7fZf
 GmYR593uD9mBdk4Ssek14svjgzoruP5HgVSRUNo1SmlyO+M3AoVJt4r
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Fix unjustified probe error on missing optional 'label' property by
replacing dev_err_probe() with dev_warn_probe(). Correct %pfw usage by
passing the child fwnode handle directly in the error message. Besides the
probe warning a read error is returned at the attempt of reading a null
label.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index a93e05cda5f36baf8f7573a1bd92bf6167227362..67bf8d9d9835095263b2ca6b710acca60612354a 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -922,7 +922,10 @@ static int mcp47feb02_read_label(struct iio_dev *indio_dev, struct iio_chan_spec
 {
 	struct mcp47feb02_data *data = iio_priv(indio_dev);
 
-	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+	if (data->labels[ch->address])
+		return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+
+	return -ENOENT;
 }
 
 static const struct iio_info mcp47feb02_info = {
@@ -977,8 +980,7 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 
 		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
 		if (ret)
-			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
-					     fwnode_get_name(child));
+			dev_warn_probe(dev, ret, "%pfw: invalid label\n", child);
 
 		chanspec.address = reg;
 		chanspec.channel = reg;

-- 
2.43.0

