Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415880;
	b=jSm8VhbC5gjQbAG4v7xHCYna16cnfo4VI2uKoWOa68MT4ngIoMdJOa7BIQTi6m2bj+Vj
	 L08g+ONexidfYbdgMe2SCf6zTMpsGX7sv6nEumZQg0Q3IAzc9r6G99TQ8ESsFP56B+6py
	 nmoHBjG9NZDTq0yKgIEKpwogK4jJ+a26Mc/E6W0UN5z8ZvZD0+OyzkAzI5zpB5oMinzTu
	 9HS1P9H63jF92OeW1QcvFD4ST7fb5fijOl8vNe2NR76AWJsc2dbv4hJMvE4R6/cIhsCCR
	 I0K3nhegj+jd3Uo/vfiWsvr5VZU9ydhtdtWGWRPDnEA+qSCZJgL+e4A1chbgv07Irkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PEriVbpfpUOcNfT27w5b/pnZi+VgtzlIE/nuReV/yy0=;
	b=25Q5Vb4E4cMjid61qTh0vXd78SuP/RR91XnYLt6l8HykP/W6azA9bOqJGDGY8pW7gomc
	 M9wPH14e6g8SFgmjWqdBLxrxxQKrizsSJqtrXv/HMdMZUp6J5OpH9OtC1g/R7yyeI4glA
	 MaeAKy/rYFm/B9CvY/jxM4A1UEwu8liY7ytFPN41VdkFoRydYtvkNZa0lG45VLn0Rfx8f
	 SQBtrQwNxtU2C8PR2AfHsAWxJon/G+8AczApriMFUMCHZcR8UT5ZEPl1VoYcdvyfto8/w
	 +wN2Uzxy6QVzU3cfYpxqUaK4CayOG563jDNBj2V192mI3jPmaFi0sI0NqIv8vJazFhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTC0vExy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45F606A897
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTC0vExy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D01F00A0F;
	Wed, 11 Nov 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415879;
	bh=PEriVbpfpUOcNfT27w5b/pnZi+VgtzlIE/nuReV/yy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTC0vExyfEXJ408wIen06TmI+Tq1ddbGqZYr8T/G8M5dX0qd6d7pbuItyCeGGoU/z
	 Zkshmz7YY89fUdTBNyuAC/sEMnrXuQpR80G1MAEahlfejSsX1BHfkQbFbp6n1sPh6Z
	 61+GVax4uSBvtxuu/nyO1lCFdsU31ezWzumSQtqVqgqOyMRtgdY7xFIEDFHvTyqM9F
	 ItSdkeeOO06yXYQ74TdShRYSJaPwn+UrT7TClcWcrVGX/C4lMSWZbc8a4KH1iEj7hR
	 O9Vn9P/7YFw7AdW4wIjmFTyPuAU6agud9g/DU/lFX7H84GToQDZgoTe4dBefZsa5ka
	 zquhsdqtgokig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
Date: Wed, 11 Nov 2026 11:51:14 -0500
Message-ID: <20261111164957.3294291-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164957.3294291-1-sashal@kernel.org>
References: <20261107052239-failed-6.12-ea9854a169e9@kernel.org>
 <20261111164957.3294291-1-sashal@kernel.org>
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

