Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446481A6815
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335883; cv=none; b=XVeQZZ2aUdbaLpWASupE/nshIXmKyQ5as4dcYn2tYCW3E9EBQTAQx7V3AdSDJ84PpzLni4+XSVsowNvIdoowztSHhAs68St/gaRAjExuV97Sx5rFL28hM0RFE55Z0HEI4pgWwKHU/MAWeZarR0vmHL2AuPv8l5iXsJEyPUOnjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335883; c=relaxed/simple;
	bh=9UXnDbWFiwSFiemBLxQCF7+9SAwpZsBHiB7cLDpxFpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXrT3NDeoY3cTmIYF8A6uDPokU7Wud8XifgHtQnZ6N9H8yIPzswjw9oqvEQHUyN3FaRJEKt/EB2P2vKg0j71RfyXk4+OIZqnuK/HMVq4vDcH/ytCVgw2tSbMsnLbgptuARX8e/WDoXDwlA9nHwvIIdOd5tCmWnVzf4vfpVHYwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfLA8nJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfLA8nJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0501F00A3D;
	Sat, 18 Jul 2026 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784335882;
	bh=X2qTNdYnjalagn01AqbugNOw47D8w7y4n+OEd7aeJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfLA8nJNrbAdhbqpBLXzfJ4m8+LpwFRkFtyuwqbFTOTeMSk9hfDy4cobPTqm7Enad
	 IW4PgASXZxvXoQoajNoNu30wKEvTwrgGCjgsyhOCBbWHnMR1syZAHu2xW384Cl1JTL
	 GRkepmgr1XtSyIyaoEYYJ0yW6ia8tIpTVGMoGeaCByH6o9mWg3Foifa80T3hgGwGjF
	 3fOhXmavlcJDr+bSpq4bbOsDNHDGFF5Nf8FX8CBoden3+IaFvP3sKrzhqCAXuZPGDe
	 OEw7l7XAnCu3SEz5XySVpKcy+HraPDp8JtmmEafVsBIgEHVPX0Ha7KY5L/M7z9f0WW
	 5jyhHNoX6rjsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	micas-opensource <zjianan156@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] serial: 8250_mid: Disable DMA for selected platforms
Date: Fri, 17 Jul 2026 20:51:18 -0400
Message-ID: <20260718005118.2484504-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718005118.2484504-1-sashal@kernel.org>
References: <2026071458-transpire-rigid-ad0b@gregkh>
 <20260718005118.2484504-1-sashal@kernel.org>
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

