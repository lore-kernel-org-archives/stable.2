Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6439CCF3;
	Mon, 10 Aug 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345895; cv=none; b=cdwVMR7bqdTaPAF4vUtm5cRGtkS0yInsO7eyPfX2ZEZWZIbDPhNgWGnyRJnuf/XaTHddxDmZh3lM2mwUgcerdWQbnBRb8XqAgcGB6GujnijLoXlSlaFGKlfTwpxOD+0FInmGiuO1J0olY/stYyGjgFB9uWcOnT2vx11GyyXbD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345895; c=relaxed/simple;
	bh=c/mDFrY4/yuZu+lUEYakK9YL3Jw4QINcPDYoWBQTJEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LLsZAAZYaWJdU4BRzT5SMqAxS2muVU6bpsAoqJ+B6vmaWvGAQTa9VjcWYX0qrpOw4EvX1hbTpNjqY5hcLc+yQEo+UIhKRDUHcI/3gY7Y1+WaaMr46+M8yoED4n62rze4SY0JoTHSiyGutZuHBFUVFteTKIgLvELFUqzEtKDPRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kxjN2Caw; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kxjN2Caw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345887; x=1786605087;
	bh=JnexPPFz+UbtAWSUNri5xgxSJQV0RH8ziFNUwphCS7k=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kxjN2CawerTROXnZPAlfcXJgMbXNkP1a/if/D7S08R8g3dbEqZezv9QdA3zzRnU6a
	 ntgx6MxQLiPtuuJAH6xYkrnwf1Pv3wuz4bVXMSCOAkf4X6+ROl0PYzbAo0b6BrKXNR
	 2TPFQg3aLmsRkKTBXNagRGUOwU/GYiRaNgjQAxsIKBqn+Bj8DonHAFImM4msqQzxjA
	 xoCrslGAJ6NW/0R9Lqp5W3NysagncQOimVJ04Dn4kuH6Bc2rd3eQ7FyXD8vqe5WTvy
	 K4CKHQiY8OzBOka8E4AeFcFoPIGQLZxg88JWEGR8yBTMyAEjlkj+OJnHIJ5YCjGeje
	 +FUlrxM8kbmfA==
X-Pm-Submission-Id: 4hJQsS6sgTz2SchD
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v4 0/7] iio: light: ltr501: Add ltr329 support
Date: Mon, 10 Aug 2026 09:11:10 +0200
Message-Id: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrCMBCG4atI1kYy+a2uvIe4SNNpjWgrSS2V0
 rubVkSs4PKDed4ZSMTgMZLdaiABOx99U6ch1yviTraukPoibcIZ18wA0ItvsanppQ2Cb6kVmAO
 XIDOtSTK3gKXv597h+Nrxnp/RtVNkujj52DbhMT/sYLp7t9Wi3QFlVEDJuGEK1FbuK7S17zeuu
 ZIp3vG/nCdeQGZLpbCwufrh4sMzJpdcJO50bnTmjDPym4/j+ARNJ3L0OwEAAA==
X-Change-ID: 20260711-liteon-ltr329-a3eb12414866
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=3264;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=c/mDFrY4/yuZu+lUEYakK9YL3Jw4QINcPDYoWBQTJEY=;
 b=KgvByXAM36ujjjmQqY1ATsM5+wiz3A8rpwupiXSZ1l5F1PymWa95rVYUFgRd2u6YVaCTb+0C8
 Obmc6iLvl8jD3hJpZUfn6a3eiDy18n2go7+rH4mn9d6EOMylGaPfFqF
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
interrupt support and related registers, which LTR-329ALS-01 does not have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v4:
- Split the duplicate error message removal into separate patch.
- Removed uneeded enum =0 assignment.
- Use dev_err_probe() instead of plain dev_err().
- Link to v3: https://patch.msgid.link/20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com

Changes in v3:
- Removed duplicated error message on devm_request_threaded_irq() failure.
- Added Fixes: and Cc: stable tags to fix for error handling of
  devm_request_threaded_irq() failure.
- Added no_irq_support boolean to simplify checking for chip irq support.
- Moved check for no_irq_support from ltr501_read_intr_prst() and
  ltr501_write_intr_prst() to callers. Note: event functions are not
  registered for no_irq_support devices.
- Moved #include <linux/array_size.h> into its place according to
  alphabetical sorting order (although the rest is not really wel sorted).
- Restored alphanumerical ordering of compatible list in bindings
  documentation.
- Ordered device arrays and enum values according to alphanumerical sorting
  order.
- Link to v2: https://patch.msgid.link/20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com

Changes in v2:
- Fixed error handling when irq is defined for a chip that does not support
  irq, powering the chip down again.
- Added simlar fix to error handling of devm_request_threaded_irq() error
  handling, powering the chip down again on failure.
- Added explicit #include <linux/array_size.h>.
- Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027051594@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
To: Maslov Dmitry <maslovdmitry@seeed.cc>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Thomas Gleixner <tglx@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (7):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Power down chip if request irq fails
      iio: light: ltr501: Fix duplicated error message
      iio: light: ltr501: Add ltr329 driver support
      iio: light: ltr501: Fix sorting order of device arrays

 .../bindings/iio/light/liteon,ltr501.yaml          |   4 +-
 drivers/iio/light/ltr501.c                         | 115 +++++++++++++--------
 2 files changed, 77 insertions(+), 42 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260711-liteon-ltr329-a3eb12414866

Best regards,
--  
Esben Haabendal <esben@geanix.com>

