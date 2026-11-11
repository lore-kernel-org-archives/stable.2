Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415213;
	b=gYPtUH5XeXDvm/EQi99o4LL/vUFYgn/54RdN9uaPazCcpycS1kpx6arvfLNHNUIetJn1
	 ncxkNZMCQGNyZYccmD5Muq2wVkWIT18Wmn/T8HM7VSyI4VnjmjzxIWynCBdVQx32hKu+P
	 el8UmvULvHY+t4njQ8yhFP3LKZ/+eDYPbry0eIA4sdXUi5IK+fcqJUW7o4/noofjOMi3W
	 FfqiLoxtlXh3dohWVwa9agqc9eBXfvCJ7AjdQCsVlpWMPzluQ8i916ZsUP+S8T8ElsWCK
	 8quJqam6wLYnpdrC9Yvex4jrcgpx6JV/ppl6aoTBsHwEZ1G1wFLWAy0Rw7VlNUnH8AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415213;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PEriVbpfpUOcNfT27w5b/pnZi+VgtzlIE/nuReV/yy0=;
	b=e3Lkr3v/E0Nr9NZbyiBTMmfbd0m+D8Kbj/O89hTnEDY6mnjYrrQcxASfgFYjXctFvnPR
	 lPz5kGdBDBC9T2ZbGcgbQhaPAFsdzyRnZ/7oCy+BnkHwYIKTajvrKu6BS40t/YVNvaNVh
	 PMhJsP7HdSz0IdcBTMBiByUMz7EWM6qOEaC7MLbs2Qhw1Ga/KWGnLYXa00Lo/DqXCVcSC
	 L6mDbQt5yiX/YFWF6k72Mlo56/pFBaPIA9NdaheiEKIHVq6X6R768D3vhBNMkejdteBxt
	 vR0r8L+6mDsmCkXlHgF8sjvnoZ3QGb3S2X8c72zjjFIyouPSGZtpqZQeQrgOqUeaxNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2ibDE1m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA0606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2ibDE1m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E771F00A05;
	Wed, 11 Nov 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415213;
	bh=PEriVbpfpUOcNfT27w5b/pnZi+VgtzlIE/nuReV/yy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2ibDE1m9spLInEDnnzfDKnmSMzLARG9yNpnqi1bLQRXjAhwPHJFHBYDuEDlno2NF
	 uBJpE4rqRqtmBEIufWcjXekayiTMqf/PUyj+SRhqSwsfVwN++JGLtHe/Cz1cALslgP
	 5VsIptKsAvCiepd6VzISBw5Vftlf4jSTaUN+yf5A6oSN5ZXuaHZew171Kg+dogNyLe
	 lLYH59bPTNGEhOFeG1+Cx/qsgDOril95Nhoopp+ezyvjnygqUuDWKJH9M3XE3Pe4Ht
	 TmHUl8R5gZcEZMf1/YaYz9iE/dn1MT7J0f3zmvweuMy967/m/sbOM2wbrhZ68edyIo
	 BEq3cnZl9Ekrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
Date: Wed, 11 Nov 2026 11:40:08 -0500
Message-ID: <20261111163924.3264424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051125-failed-6.18-ea9854a169e9@kernel.org>
References: <20261107051125-failed-6.18-ea9854a169e9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 6f9e4740e8591176eb90bb1dae95bbbb5c7d789e ]

Replace ACPI specific calls to get device property with the agnostic one.
The code looses the direct dependency to the ACPI APIs and get cleaner.
This doesn't change functionality.

While at it, drop now unneeded acpi.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20251129151739.3998668-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: ea9854a169e9 ("spi: cadence-xspi: reject SDMA transfers larger than the requested length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 36 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c3676b21e8167..b6b42daae1bce 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,7 +2,6 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -21,6 +20,7 @@
 #include <linux/limits.h>
 #include <linux/log2.h>
 #include <linux/bitrev.h>
+#include <linux/util_macros.h>
 
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
@@ -775,19 +775,15 @@ static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
 	return ret;
 }
 
-#ifdef CONFIG_ACPI
 static bool cdns_xspi_supports_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
 	struct spi_device *spi = mem->spi;
-	const union acpi_object *obj;
-	struct acpi_device *adev;
+	struct device *dev = &spi->dev;
+	u32 value;
 
-	adev = ACPI_COMPANION(&spi->dev);
-
-	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
-				   &obj)) {
-		switch (obj->integer.value) {
+	if (!device_property_read_u32(dev, "spi-tx-bus-width", &value)) {
+		switch (value) {
 		case 1:
 			break;
 		case 2:
@@ -800,16 +796,13 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 			spi->mode |= SPI_TX_OCTAL;
 			break;
 		default:
-			dev_warn(&spi->dev,
-				 "spi-tx-bus-width %lld not supported\n",
-				 obj->integer.value);
+			dev_warn(dev, "spi-tx-bus-width %u not supported\n", value);
 			break;
 		}
 	}
 
-	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
-				   &obj)) {
-		switch (obj->integer.value) {
+	if (!device_property_read_u32(dev, "spi-rx-bus-width", &value)) {
+		switch (value) {
 		case 1:
 			break;
 		case 2:
@@ -822,9 +815,7 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 			spi->mode |= SPI_RX_OCTAL;
 			break;
 		default:
-			dev_warn(&spi->dev,
-				 "spi-rx-bus-width %lld not supported\n",
-				 obj->integer.value);
+			dev_warn(dev, "spi-rx-bus-width %u not supported\n", value);
 			break;
 		}
 	}
@@ -834,7 +825,6 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 
 	return true;
 }
-#endif
 
 static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
@@ -847,17 +837,13 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
-#ifdef CONFIG_ACPI
-	.supports_op = cdns_xspi_supports_op,
-#endif
+	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
 
 static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
-#ifdef CONFIG_ACPI
-	.supports_op = cdns_xspi_supports_op,
-#endif
+	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
 	.exec_op = marvell_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
-- 
2.53.0

