Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077254AE12C;
	Wed,  7 Oct 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383657; cv=none; b=Krs7U7hDQBcdxx5L1WOJi0+/7UOc2LtNLIzEv/Bv5LTFkYWICgsKjZCDv+lpPl66arZebfYlyKAGXBSDeeclxnxNf2Xt8PQsGyOMEN3Jt7keh5ddvqPdJ/PciEm8vNaZmqqL+QbkRRax83ipek/BarrTntrmXvj8XXQDGucnuKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383657; c=relaxed/simple;
	bh=aaBl7jM0AvoHi5hBj4hHL6VWxSJ8btl9O2iC5ZxmqWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oYC2NgSSTlpr2MlsFRpuPcZKY/IA7CCR3058/oGyCFmiuUTD+WGj44G1m8Pa10/c90MmhADGhAbbv9hvXDKOy6B63qsOMNSBlM57vOWJWenYy5GVG3zFefUIQ+5kHD9ErF2wWdN/wi2N9LfoS2mVnOJAgGSD8B4Bb4wPOFtqrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7ale+5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7ale+5m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F6EC2BCF5;
	Wed,  7 Oct 2026 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791383656;
	bh=aaBl7jM0AvoHi5hBj4hHL6VWxSJ8btl9O2iC5ZxmqWY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=C7ale+5mCeNekkQlyW3jrTYVSkHHrKji2+WnlZhJUpxv6KdOZRnq8ifzsgr4lt6Jl
	 RpuHlOr2lZCAp7qLEb1DjndgkFJM+v07aYLZW8A0Tdlr2QpTXymonXcNgxuRyC0k10
	 GqvQPADSW6vJMp9mi9wyuK5pQkr3J3/fCn+g3k2kz2oFzZ4nSh/LHNX2LQ6JpxcC/a
	 DWVJOCT8ErZCYKJdbKb3P6vUL5+6wkYcwhicfk4M1F4KA0w3QzunAHo883bPb1mRkZ
	 gEeom7UV+yrD1sUeM9UgWxwtBybY5fOX7LWRSK34myVIpd4yFOoNSQncNaGz9nN+Cb
	 SPyi5zO90oT9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CECA6007;
	Wed,  7 Oct 2026 14:34:16 +0000 (UTC)
From: Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Date: Wed, 07 Oct 2026 09:34:16 -0500
Subject: [PATCH] iio: accel: adxl345: select IIO_BUFFER and IIO_KFIFO_BUF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
X-B4-Tracking: v=1; b=H4sIAGdYxmoC/x2Nyw6CMBAAf4Xs2Y1tBYz+ivGwbbewiRay9UFC+
 HeLxznMzAqFVbjAtVlB+SNFplzBHhoII+WBUWJlcMb11pgzJlmQ4vI4tR36d0qsGHkuuMv8xf5
 CzrZsuhgIamRWrsZ/cLtX9lQYvVIO456dVAbJxyeVFyts2w8mY0JckAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, 
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791383655; l=1713;
 i=BouziguesAlexis@JohnDeere.com; s=20260527; h=from:subject:message-id;
 bh=s/yXKM6ln4x9Rm+hNY2FnXFaP1MQgX8qNBneutc4oYU=;
 b=aKlLVve0fWP0+XrcqwgW4kxbyVmfM7iWxiONstwX/yYmAoM9Vnsb6im4zKzYpqzsY7/1IodZR
 ew04scKnQPeBoJlKi9+E3W8zZHbppfifc9IefWhq9uJNUqbYHG4ePB5
X-Developer-Key: i=BouziguesAlexis@JohnDeere.com; a=ed25519;
 pk=5KJ7ArL00x5flpPhi9zRLC2p88V1rZXDQ5SXhpRvTDk=
X-Endpoint-Received: by B4 Relay for BouziguesAlexis@JohnDeere.com/20260527
 with auth_id=797
X-Original-From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
Reply-To: BouziguesAlexis@JohnDeere.com

From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>

Since the addition of FIFO watermark support, adxl345_core.c calls
devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but the
ADXL345 Kconfig entry does not select IIO_BUFFER and IIO_KFIFO_BUF.
Building with CONFIG_ADXL345_I2C=y and CONFIG_IIO_BUFFER=n fails to
link:

  ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_irq_handler':
  adxl345_core.c:(.text+0x145c): undefined reference to `iio_push_to_buffers'
  ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_core_probe':
  adxl345_core.c:(.text+0x1db6): undefined reference to `devm_iio_kfifo_buffer_setup_ext'

Add the missing selects on the hidden ADXL345 core symbol, as done for
ADXL367, ADXL372 and ADXL380, so both the I2C and SPI front-ends are
covered.

Fixes: cf04212d1fe7 ("iio: accel: adxl345: add FIFO with watermark events")
Assisted-by: LLM
Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
---
Add the buffer selections required by the ADXL345 FIFO support.
The shared core symbol covers both I2C and SPI frontends.
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4094299e2ed8..fc130854af71 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -61,6 +61,8 @@ config ADXL313_SPI
 
 config ADXL345
 	tristate
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 
 config ADXL345_I2C
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"

---
base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
change-id: 20261007-fix-adxl345-buffer-deps-review-69a214e05dca

Best regards,
-- 
Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>


