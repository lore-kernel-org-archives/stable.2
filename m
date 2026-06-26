Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F43E5A01;
	Fri, 26 Jun 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467388; cv=none; b=TfYFnjZ/b55pkc+z3jhihkowwJ1o3pgPTNPBmVsf4YcJ1MJ3QyF36E3M+ilBEs7EZ2Gg2/HnEu3eJprQwhhKV0S1aQV7FUF+72Lodx6TNIHlIPv1Seg2SC+dt/mj5r98kmrLqJiIScEY2/e9I3WiAd+rSUJ0nuNiitF+9ScELB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467388; c=relaxed/simple;
	bh=1LokdJ3zG8LtINp6ckgq9V/KpWwVzsHektGPgs8K5+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXswBPdVjvdsdXQcz7azDIGbAidZmb3mairD9wUdM/wv+w8Zoi5/fEPxsXLGSNcnWR5Kb3MYCc7H6g2eFfGZoqbaFFoAbnu7SkRQWrPEaEG2fNdFrDUew0Kw4JXzYe6+fyLYlyF7oR9MaDQ6reglVXfYCOre1SmhyyHaDW8hUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uc9IjmKj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uc9IjmKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782467386; x=1814003386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1LokdJ3zG8LtINp6ckgq9V/KpWwVzsHektGPgs8K5+Y=;
  b=Uc9IjmKj7B3GzXBzcOBOqYfV1J5qwfmahaZ5dG4qSOcMf9tDfCtBiyiQ
   Hfo9Ua4COiXa1ASy5m2wd+CkgOc+zCeKFYfQUlEguggPZajzDKYZa4eOR
   pFzMaXbOlq0qIDvO+M8U1nmRBLcyPf5U6NO0HQmkd6LjpFMZZwR7+3li6
   DnNJXnOgHZspPQPurfzF8+HzgLjvaeXclJ7TCtEZKRjX3iyI4v/lwWir5
   eEQ+KhJzlU2UEWJeTCTQ4VCo5NGYGOlgBDTzhuehl3MFS68xlfBYhX6t3
   B5ezOOj3jh3ml6rQXHj95n2qFGxg+QkV4HER1ahpc03mewB1zMEVC38X4
   w==;
X-CSE-ConnectionGUID: yPGSV6jFRT26Wo8UqaYjKw==
X-CSE-MsgGUID: 4pkY0gbWSduSmUNqRmvLoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93612314"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93612314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:49:45 -0700
X-CSE-ConnectionGUID: PwhN8kRQQkeDKzj47wknWg==
X-CSE-MsgGUID: vXC6J0YNRJabdefG3cIHPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="250218411"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2026 02:49:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6484298; Fri, 26 Jun 2026 11:49:42 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	micas-opensource <zjianan156@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] serial: 8250_mid: Disable DMA for selected platforms
Date: Fri, 26 Jun 2026 11:49:37 +0200
Message-ID: <20260626094937.561776-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec03863606e..f88809ff370b 100644
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
2.50.1

