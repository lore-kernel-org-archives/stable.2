Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459E1A6828
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318124; cv=none; b=EgWHsFcJivUjpfHSPgNB+BZ8Tr94kkGliADu8folT987R1JDeVtp2tYYpwtSha9zh3RIO6XZl7seyYgo5CCrpZi3SmQybEnjTeB9+nnzCK9aNPxkQnzVYYOb/I52q+ym0Cl5Vv12xU0rofKy0nNDFWK2Ahc8dfx8F4rj+ZR3FdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318124; c=relaxed/simple;
	bh=9UXnDbWFiwSFiemBLxQCF7+9SAwpZsBHiB7cLDpxFpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9XARJqpff/9q8X9OBSfSWIlWymot0v3iepxl2d60Nf2aqI2oAeCLyz/2k67sG46y8uzGtNuRuJaw+GZA+c5KjFpP5hYViddT8kROmceeR4T1byPft0EVnCZwm0SpVlNlDOgtRHQsZ7M1/iKUM2cSUGDDEr2oSDzi8IrtNHOuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxh81x9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxh81x9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223C1F00A3A;
	Fri, 17 Jul 2026 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784318123;
	bh=X2qTNdYnjalagn01AqbugNOw47D8w7y4n+OEd7aeJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oxh81x9TqaeLUeKN2B5Ahxa+rBAEzcS3z0J+5Swf8+susesSVmwCyVJqJ2Gjw+OM6
	 S1LIc+kUCg+IB74tJfeMnc35GbMknStv5t4zxk7Xf9FJMLSMKHD3vvt+c8Q8i69Ryh
	 8FSZPtVUWbIg3xPHLSFEJS8CDlblxzEtbeNVozTNI+/tZiLW4CN/kmOgXaW2V/VfAq
	 UeweM4xTdebQRy5lQD0AA+87SUckFxTy4h0ZROPyLyAYxMWdr3nrWYmQ6vO7Yyic8n
	 +m2xVFDh70d1VMpRtxHkmhM6500R9xn94GbmjogfK8F+3bf8oY0b6kbL3AK2xpT9pA
	 zWfSqcHZbEvzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	micas-opensource <zjianan156@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] serial: 8250_mid: Disable DMA for selected platforms
Date: Fri, 17 Jul 2026 15:55:20 -0400
Message-ID: <20260717195520.2195138-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717195520.2195138-1-sashal@kernel.org>
References: <2026071458-expletive-shrubbery-16e0@gregkh>
 <20260717195520.2195138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b1b4efea05a56c0995e4702a86d6624b4fdff32f ]

In accordance with Errata (specification updates)
HSUART May Stop Functioning when DMA is Active.

- Denverton document #572409, rev 3.4, DNV60
- Ice Lake Xeon D document #714070, ICXD65
- Snowridge document #731931, SNR44

For a quick fix just disable the respective callbacks during the device probe.
Depending on the future development we might remove them completely.

Reported-by: micas-opensource <zjianan156@gmail.com>
Closes: https://lore.kernel.org/linux-serial/20250625031409.2404219-1-opensource@ruijie.com.cn/
Fixes: 6ede6dcd87aa ("serial: 8250_mid: add support for DMA engine handling from UART MMIO")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260626094937.561776-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec03863606e4b..f88809ff370b73 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
+#include <linux/util_macros.h>
 
 #include <linux/dma/hsu.h>
 
@@ -368,8 +369,16 @@ static const struct mid8250_board dnv_board = {
 	.freq = 133333333,
 	.base_baud = 115200,
 	.bar = 1,
-	.setup = dnv_setup,
-	.exit = dnv_exit,
+	/*
+	 * Errata:
+	 * HSUART May Stop Functioning when DMA is Active.
+	 *
+	 * - Denverton document #572409, rev 3.4, DNV60
+	 * - Ice Lake Xeon D document #714070, ICXD65
+	 * - Snowridge document #731931, SNR44
+	 */
+	.setup = PTR_IF(false, dnv_setup),
+	.exit = PTR_IF(false, dnv_exit),
 };
 
 static const struct pci_device_id pci_ids[] = {
-- 
2.53.0

