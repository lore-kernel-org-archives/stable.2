Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833A233947
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338422; cv=none; b=Tz029OEFbqp+tsweEfXMnLz3QbBN0SjLnxrK303vTlnUDahWjyvxShET6cDzT4IofAtOsGL1J0Obk+d6EC8A3Ffqkq7DgP+Gc4KJS2y8kH+2o9AkT11Yx85ril2OmFaCvcCsNGNbDaktw4n5MwniA2tSursddGK11xbwz1+9BQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338422; c=relaxed/simple;
	bh=t5dfLnmYrFlvfi9cFjKLCh9Lsw9U8pkmQFfRb4GC2sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTOXwrTTD9GSZhCpAywfN5Egrx9yXBmOMyJ9WQYD+jtNV3VBYK7mCzF/cFkPE+C4+jAzd76d9eF6MODkKY3xXGaZ6bvCwKQEbDxJkzI2jBmPcFyQUjWC9Pp0BJ7QJ+4tHlHMkFV59zMBKYN9+jwA+uH3qkCgoR+MelPA97JWueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6V2J2Pa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6V2J2Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CF11F000E9;
	Sat, 18 Jul 2026 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338421;
	bh=zEy0vrcIAQdZHqGH6iHTtKXXYXKbKBH7te6MIzhw6p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B6V2J2PaXW8TgNV8VcWxLQUxEWyk4BHETsSTFdXv6oRBWpEB2xW3EKYCPY4XTEm1e
	 dtzm8jdprIKAcZGpmzMM6xGe5ufHUdBfDahgIb1JShQZ3wwX0SoO1+lJTQTss1Kf2G
	 VgJI3dfaIl6+YDemaA0gDteV/As8PheVlMxmT+jl1z9Dhe6ZSr7Ui0iBlgETBe6QRx
	 OHtC5JAS7LdUPKo5S+G3SoLBBenVkxUihMtyzyqEcIVNUCaO7yxjMOSy4I2m+62UaU
	 m7bcmN9I+lZ30sHdGN/8Tc0gzx4CpTCddb/aVUnNqMhvj+tP/oEDKKgLDeDR/XflFD
	 7UpktSQKizJDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	micas-opensource <zjianan156@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: 8250_mid: Disable DMA for selected platforms
Date: Fri, 17 Jul 2026 21:33:38 -0400
Message-ID: <20260718013338.2621443-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718013338.2621443-1-sashal@kernel.org>
References: <2026071459-sulfite-malt-aeff@gregkh>
 <20260718013338.2621443-1-sashal@kernel.org>
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
index 220857a45ac2d3..9a4c6466ab026d 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
+#include <linux/util_macros.h>
 
 #include <linux/dma/hsu.h>
 
@@ -371,8 +372,16 @@ static const struct mid8250_board dnv_board = {
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
 
 #define MID_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-- 
2.53.0

