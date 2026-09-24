Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942E2E4257;
	Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254775; cv=none; b=ltsHzQJZUr5vwJewmRm7nCrxum4nen4AqZ/DIz2HZqXyFFgcw51t6LUGVHYdP3HtYLQlXGP8tgHUlyYc0eMLPFGpQuqI5mXPOSqgnG0ARpGTgOzXCiQ8CILGL/5IedMY1GciMaMcEmCnGQ8WV8s1shzrZ+EbJMDBcGn8Zc7zO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254775; c=relaxed/simple;
	bh=+JrXAtVBVqegDGgtW79BTSXQHzo3yblwMOVTotibgo4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=plereA7G/bCcBBwSUW1SOJu9nupgNlRk6glH4POQq72mevy7UhsMKiU+jwf1y6+QwfCVSBOKdzFPFVfe/oG7qaVVmg/JCnfljpkBbik/N0ww5dRR28l6PqX6gdi05dvTqKiaEY3AeTv/YrnYHwWzwnIdm8/Uu86Wx3ZlhPpkqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X6spdxh0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X6spdxh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790254773; x=1821790773;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+JrXAtVBVqegDGgtW79BTSXQHzo3yblwMOVTotibgo4=;
  b=X6spdxh0MDDCD1S/0tO1vrbKFcYoD91PkVFWr6rwXf/ve+sPs2qduzuY
   CaSLQTYz8RUvz+8ZDkOzp5f3Bpn4WyYmbzWYBRJ3QsYCpW8298CMjx75A
   nSDwFmhajro+SKQk7YDj00PuqhCCdmLsgQfugz86DvaIUnYgvSZSk30H5
   Oz9QesfSg7U2OZt9UpS3cOw1jmi14zhm+xQbDRrPm+nmMHee9H+vzRfkV
   y+AuikbufQWGF4okKqNjJNFJrDXXH5tkzEjm9dbqOqtS7hKrMPM7nVz6Q
   CSn+iPD/JgMZwL6vCuLBTLTW3nNvaVP/Lo1F6+bi8poLQYc4yKWicJNBd
   w==;
X-CSE-ConnectionGUID: GKMKZxmSQXOzXk2HFKINSg==
X-CSE-MsgGUID: vHuPeq6fR9eKIZA8LSPnFA==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="64097078"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 05:59:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 05:59:26 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 24 Sep 2026 05:59:22 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v8 0/5] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Date: Thu, 24 Sep 2026 15:59:18 +0300
Message-ID: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYetWoC/3XOzW7DIAwH8FepOC8TGDCmp73HNE1AzMKhTZRM0
 aYq7z7SHRpN7Pj3x8++iYXnwos4n25i5rUsZbzWQE8nkYZw/eCu9DULkIASwXaXNBmXOUp4nzm
 H9DnOXQ5kQAbWQCDq5lQ75euuvr7VPJSljn3fj6xqr/56DnTTW1UnO2brGTU6iOnlUtI8pqFMz
 2m8iN1c9cMhadqOro53mSKprBGo5ZiDo3zbMdWJHCEEHXMvfcuxD8fLfxxbHYroYgrR6161HDw
 4CtsOVgfIGjRoVabmP+7oUNtx+z+QgvOGQ2b462zb9gNC5JRSIgIAAA==
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790254762; l=5458;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=+JrXAtVBVqegDGgtW79BTSXQHzo3yblwMOVTotibgo4=;
 b=JmjSRd4H3S1c3xUWlk/NHFdEDfKlhvnxDcEqPNcP8pTtrJydDoCswiQD+em7Qxa3vMqEoZvpS
 G1y1sDs82mUAttxeFG9c26vDNB6kG+qk8sVH2NgJt3bJfHl7Rgs/cA0
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
implementation. The I2C and SPI devices have the same memory map and
supported functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v8:
- create a new precursor patch for moving mutex in store_eeprom_store()
- add property present check for label before reading
- use EXPORT_NS_SIMPLE_DEV_PM_OPS() instead of EXPORT_SIMPLE_DEV_PM_OPS()
- base this version on testing branch in order to send just remaining
   patches to be accepted
- Link to v7: https://lore.kernel.org/r/20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com

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

Changes in v2:
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
Ariana Lazar (5):
      iio: dac: mcp47feb02: Avoid unjustified probe error on missing label
      iio: dac: mcp47feb02: protect EEPROM store sequence with mutex
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++---
 MAINTAINERS                                        |   2 +-
 drivers/iio/dac/Kconfig                            |  32 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 342 ++-------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02.h                       |  43 +++
 8 files changed, 573 insertions(+), 361 deletions(-)
---
base-commit: 81e043887112f846f88ef9ef20c744b5c815de57
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

