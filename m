Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50D45FFDE;
	Mon, 17 Aug 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986559; cv=none; b=dq8+YkQieV3rdkr+Nbfc8vhLU16/t0YZHDhiua6y9fqNgCtEeiV10O+XEDQniizHls3dhwxGFkltmit/oi3n87K53PtGulLd+Dp7qwteFi3U8g3hjookY2fnu854GtzJzunL39XXhcJ/t2Br2dXRuek2M+QwbTkJV+f20+bJSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986559; c=relaxed/simple;
	bh=g7nCiYcQngdCpXxLdXAcd1yyDzpaGAuCS7hpQBLAD9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rZi9tpiMN73mkH0+k6jzDYyxF0lB5d4M4SncMAeMp2phGUzZu3JFDbT7hxDsK3nisVoh8i/wE23WJYGoVrdtQtDwR2iKO1Eby+VnkXHDG1vxbLImfRv+pR0hTVezrzWgqB4B5rCXicPYRS1d6lDn7/pEFQj323tY/gAX40l3RyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=J2S6WTsE; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="J2S6WTsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986550; x=1787245750;
	bh=reDhZ9aU9Fk2ZVUwiW4cHGgqUkWbfEUrxNONFX7C3mY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=J2S6WTsEizDrSUNnRTJCcm2nZfuzOEyMIDLkjw24pg8iY+JD9vEKrL9A1Ftl3Fs6g
	 IEsOqf8QM+kBTr0TuywjPxeA32zLYsoPSqYmvGJOaexMIos55mY/6ekXF1FJ8mWhBU
	 WLClq/mwJv+ySVKbmOHKMmysjx0Zncguix9x1km/xAvS0x5UAhVruxepxg+sxEME2K
	 UJYPj+v0hevAP+7cUOK9jtD6auU3Va5TPobMTv5sHxpVA/xxJpZ0ejbVexKXRXOkMl
	 gCRXTyUMStx9ydba7teJL6gtACsExV4mfAMdk6AwRBa56XlyFsYADkP7nzFqdpKpE9
	 6OSaqQYiu/YSA==
X-Pm-Submission-Id: 4hNznr0T83z2SchQ
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v5 0/8] iio: light: ltr501: Add ltr329 support
Date: Mon, 17 Aug 2026 19:08:49 +0200
Message-Id: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Ny27CMBCF4VdBXtfI4zuseA/UhS8TcEUTZKdRK
 pR3rwNCQJC6PNJ8/1xIwZywkO3qQjIOqaSurUN9rEg4uvaANMW6CWdcMwNAT6nHrqWnPgu+oU6
 gBy5BWq1JNeeMTRqvvf3nbZcf/4WhnyPzxTGVvsu/14cDzHf3tlq0B6CMCmgYN0yB2sjdAV2bx
 nXovskcH/i/nFcewbpGKYzOqzcuHtwyueSi8qC90TaYYOQ7l08c2JLLyq2PIjYRFLfshU/T9Af
 I2JsjegEAAA==
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
 stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=3702;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=g7nCiYcQngdCpXxLdXAcd1yyDzpaGAuCS7hpQBLAD9k=;
 b=j7dwX35+Ko0AYTjKyG1cFzEZXW1smcDGt7nO5cudfcnZnDPEP7hwGqEKLPxoY+RbkNcEKkK7t
 bv4VDhuzursB76GmZ1XdHvAy8BNXjCqV4A/w5euMuW2yuk1Goq0S70+
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
interrupt support and related registers, which LTR-329ALS-01 does not have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v5:
- Changed error handling of interrupt being configured for ltr329 device to
  just print a warning message and get on with life.
- Mark interrupt properties as invalid for liteon,ltr329 bindings.
- Changed patch 5 to not claim to be a fix.
- Link to v4: https://patch.msgid.link/20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com

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
Esben Haabendal (8):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Power down chip if request irq fails
      iio: light: ltr501: Drop duplicated error message
      iio: light: ltr501: Add ltr329 driver support
      iio: light: ltr501: Fix sorting order of device arrays
      dt-bindings: iio: light: ltr501: Make proximity-near-level conditional

 .../bindings/iio/light/liteon,ltr501.yaml          |  32 +++++-
 drivers/iio/light/ltr501.c                         | 114 +++++++++++++--------
 2 files changed, 101 insertions(+), 45 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260711-liteon-ltr329-a3eb12414866

Best regards,
--  
Esben Haabendal <esben@geanix.com>

