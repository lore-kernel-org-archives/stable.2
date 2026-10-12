Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8A48FF9A;
	Mon, 12 Oct 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816713; cv=none; b=MQZS5CvsEumQdhZeaJaZdjPrvv2E73jN4zYLUr0RVxH1GYNPfUHaJbPfljczUt1vRMevbwq4dGDyAp15g+eRid1GCPhXWz976e6uhlQEgKqewleECdgGhUHfVCPfLla+40WrGQtzAKlPI+409a0zUrqXeBZeNi9Ayu050+qHy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816713; c=relaxed/simple;
	bh=f9EvugwLxELEc+dbPD6mVsUPxIzvixYfEzPGz/FCAZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAESYjPho875y3Gt5QGbJT6fqjtGZhFgaD+ucHEqJpjclI4lNAV/UMoN6MgcQd246e0/xTK7ZN1zDQxs5SDQlEZqHUAJ+dksm2K3WAlGMG9GkG+4IlJLWW/qgOe2ZaHJrAkm0E6SLyshJYLqKqEcVokqaHea9jXUF6wtkI1QRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=mKLL1r8A; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="mKLL1r8A"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 464C17D44C;
	Mon, 12 Oct 2026 16:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1791816224; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CXXXtlZeRstf+tA6ws1VZ12DOlR/eQxGc153GV1yBDM=;
	b=mKLL1r8AxfuGAYD10STmWe+yuU/PWRasPvlncTv8AP6r74pxZmRjfziazMZG48e1N3mNyH
	xj8/PFrQ/ZMuhLGh/oCKVZhHNTtJ9h0277Dm2zyAmIDrLFnrh48twYcY+bxohBHvvSK4rt
	hIXwkgs7pHHU9ULNi+Setc38qReZrXU0AdbwKpB/wFIF5CMhtp3pyVe1DCZp0vWdC6P3pf
	AWHgd+7RG5WTuTFQ8ZR9ULe6ohOSUWYSHhgbKRKxx+n3DnUuycdCuUroMiB+RtbpUjbrj+
	yjV0sWM5dsgxUZK0nVafW1SNN1LuPiHHFp7vLmBmtwAmHtK3hSfGb/UGrhHFbg==
From: Alexander Sarmanow <as@discnull.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Sarmanow <as@discnull.de>,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: vcnl4035: Fix reversed ALS mode bit
Date: Mon, 12 Oct 2026 16:43:15 +0200
Message-ID: <20261012144315.1678195-1-as@discnull.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

According to the datasheet (table 2) the ALS_SD bit behaves the opposite
way the current ALS mode defines are set, writing 0 powers the sensor
and writing 1 shuts it down.

The current driver thinks the ALS is up while it's actually shut down
and it's down when the systems powers it up.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sarmanow <as@discnull.de>
---
Tested on a Raspberry Pi 3B+ with a VCNL4035 on I2C, running Raspberry
Pi OS downstream kernel 6.18.50. Checked with i2cget that bit 0 of the
config register 0x00 is 0 while PM runtime resume and 1 once it's
runtime suspended. Also builds cleanly against iio/testing.

 drivers/iio/light/vcnl4035.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index ce1bd42b0c7c..f1cc75245001 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -44,8 +44,8 @@
 #define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
 
 /* Default values */
-#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
-#define VCNL4035_MODE_ALS_DISABLE	0x00
+#define VCNL4035_MODE_ALS_ENABLE	0x00
+#define VCNL4035_MODE_ALS_DISABLE	BIT(0)
 #define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
 #define VCNL4035_MODE_ALS_INT_DISABLE	0
 #define VCNL4035_DEV_ID_VAL		0x80

base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7

Best regards,
Alexander
-- 
2.47.3

