Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0426738B;
	Fri, 18 Sep 2026 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722464; cv=none; b=b8boZlTtl1uGeCbm1bte1omYJnPagMPahN1JjD96RHVuAAX8Rgjuqfwn3OgBDBtl4FfEJAPjvpbN43syeTGdI8QPJvtg+GY3W3SUguKVpEMVrZhcnIFFARql24PukLJhkcE1eRkxG/VqPtPG7ulnXPKnZclyoy3FbLj8FvmpwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722464; c=relaxed/simple;
	bh=PCt9TlP746bRAwzSqEs7jhec0ai5iHZ4n/nlGDTpBs4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SvMXVf3WeRDUK/aHKpAvQOoSNIIUj8bFJ5XEsi1m/P+butu6oAGF8UGYFYt2RUNB5Ay1/ycFUD/3U8hcY7G0kshDp9AQz4b5x3JPYFXpbzqn+1dI3WBiGzCSi8kfbqeIx/+wzhzneSpCa3IbDS9A3/9t4h6x6EWhCkbhZMhi6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZDShLNlT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZDShLNlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722463; x=1821258463;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=PCt9TlP746bRAwzSqEs7jhec0ai5iHZ4n/nlGDTpBs4=;
  b=ZDShLNlTwjuZ/aLnfGa3iDQutYnKequRY5gIB9pB/aHrNd4Sn+TGQEFY
   UPn7CqqVOxMrbyN1sZl0yOMYYAljnd1xoEBSO/kqPKG+GFbpvXfkf6jLG
   mZDuFH4x0qyaIqPmoYlHyN5Pw8/aJt67Dg5d062p0M+cLxkvn75TodWv+
   lrE0FqO9nO2whWkCgaS86F/Z+LZW+umNaAySxjTuQKuwJ/pq/oFXnARD4
   NNnBDjCBPKtibudWzeO9UBtd4w1zRKSm8hfVzC6C/9eqDJU1FPs/+lUCi
   hjYACy1bGSzBxtTUQ3nlrE8ZJxFA/p7Fpbaxz+5/uks3aU6lRbPgkP5aA
   g==;
X-CSE-ConnectionGUID: NT/tX5rLSeK0wVAxIWwmQg==
X-CSE-MsgGUID: dHUOSyzURPapyBjGTXipNQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800274"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:07:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 18 Sep 2026 02:07:41 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:38 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Date: Fri, 18 Sep 2026 12:06:26 +0300
Message-ID: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABL/rGoC/3XOS27DIBAG4KtErEsFAwyQVe8RVRXgoWbh2MKVl
 Sry3UvSRSKVLv95fDNXtlIttLLj4coqbWUt87kF+3JgaQznT+JlaJmBABQIhk9p0TZTFPBRKYf
 0NVeeg9MgAilwwNrm0jrlcldP7y2PZW1j3/cjm7xVfz0LquttkgtOZDyhQgsxvU0l1TmNZXlN8
 8Ru5qYejhO676jmeJtddDIrBNdz9JMjfd/RzYkUIQQV8yB8zzEPx4t/HNMcF9HGFKJXg+w5+OR
 I7DvYHHBGo0Yjs/vzz77vPxIb1OHaAQAA
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=5479;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=PCt9TlP746bRAwzSqEs7jhec0ai5iHZ4n/nlGDTpBs4=;
 b=Oy1U+wYsZcP8k7rs6vGLnZapSL7nTRUR7Ums/lsIBtuhlmoRXUSD5C4KueVtR039qTKGCHDB6
 McnRxVPxNXLA9b2+zXR4OEgu3IobPmCESC7E5lJ8xNaETK0y0eloNFv
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
implementation. The I2C and SPI devices have the same memory map and
supported functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v7:
- replace custom mask define with standard field_prep()
- use "Suggested-by" instead of "Reported-by" where it was more suitable
- use "Fixes:" with "Closes:" instead of "Link:" for fixes tags in commit
   messages 
- modified module description for core when adding support for SPI parts
   in order to specify SPI families too 
- remove unused macro MCP47FEB02_GAIN_BIT_MASK from the second commit
- Link to v6: https://lore.kernel.org/r/20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com

Changes in v6:
- use field_get() in Gain, Vref and Power-Down registers channel formulas
- rebase from 7.2 to 7.3-rc1
- add fixes tags and Cc stable in the commit messages
- add numeric constants in front of time defines for better readability
- replaced dev_err() with dev_warn_probe() for missing label
- if match data is not found at probe, return -ENODATA and a suitable
    error message
- Link to v5: https://lore.kernel.org/r/20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com

Changes in v5:
- improve commit messages by justifying the changes made
- increase polling time for EEPROM writes
- delete unnecessary comments and extra blank line from header file
- Link to v4: https://lore.kernel.org/r/20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com

Changes in v4:
- remove unused headers
- add missing header types.h in protocol files
- create 6 precursor commits before the refactor patch for handling:
    - comment typo
    - renaming command mask define
    - for an invalid label use a debug message instead of probe error
    - correct return value in store_eeprom_store() for false state case
    - correct channel gain formula
    - read DAC value register to initialize channel data struct field at
      probe 
- Link to v3: https://lore.kernel.org/r/20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com

Changes in v3:
- renumbering the patch version to include the first patch submision
- fix review comments device tree binding:
   - change 'additionalProperties' to unevaluatedProperties
   - add else branch with spi-max-frequency in the condition which checks
     if a device has SPI interface
   - correct SPI address example
   - add clock polarity and clock phase properties for SPI devices
   - enumerate I2C devices in lexicographic order from the description section
   - specify supported SPI modes using dependencies
- fix review comments driver:
   - remove unneccesarry libraries and add the missing ones
   - correct comment typo
   - return -ENODEV using dev_err_probe() in protocol probe functions
   - use named initializers
   - move defines for registers and enums from the header to the core file
   - add dev_set_drvdata() in probe()
   - move mutex aquiring from mcp47feb02_write_to_eeprom() to
     store_eeprom_store()
   - write correct value into Vref register in resume()
- Link to v2: https://lore.kernel.org/r/20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com

v2:
- include in the same patch series the refactoring of the driver and the
  support for SPI devices, but in different patches
- remove changes regarding review comments received not related to the
  code refactoring
- first version of the combined refactoring I2C and adding support for SPI
  driver
- Link to v1: https://lore.kernel.org/all/20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com

v1:
- first version which did not separate the refactoring and adding support for
  SPI devices (into different patches from the same series)

---
Ariana Lazar (11):
      iio: dac: mcp47feb02: initialize dac_data field in channel data struct at probe
      iio: dac: mcp47feb02: Fix gain field initialization for active channels
      iio: dac: mcp47feb02: use field_get() instead of custom dynamic macros
      iio: dac: mcp47feb02: Return len when disabling EEPROM store
      iio: dac: mcp47feb02: Increase EEPROM Programming Write Cycle Time
      iio: dac: mcp47feb02: Avoid unjustified probe error on missing label
      iio: dac: mcp47feb02: correct typo from a comment
      iio: dac: mcp47feb02: use field_prep() instead of custom dynamic macros
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 +++++++++---
 MAINTAINERS                                        |   2 +-
 drivers/iio/dac/Kconfig                            |  32 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 388 ++++-----------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 ++++++++
 drivers/iio/dac/mcp47feb02.h                       |  43 +++
 8 files changed, 600 insertions(+), 380 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

