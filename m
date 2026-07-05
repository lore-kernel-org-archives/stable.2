Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E552C9D
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221120; cv=none; b=QUjEd9mJj+CH5QpslLiiuD39BO59yFHMMXnTLl6Gigdc7eKgMXrS5zh4fwyRsc3llNFRW95TUWVx0qy6NztKMK1TcRe5BFvq+ax32uze1qMM7sjL4sCRBG9VogLwUgnTGoSFave9Pi6x4yYgo6XZWhhVoH1Pnb+L1QSql2CK4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221120; c=relaxed/simple;
	bh=2HDWkNr3QX3oVx8wtUkLnlLDK6H3B/TP0s7hz6S3MZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI3A7aV2+XuTody9Ew8PkgJiT/xv7nDNsluF9Fn/uoBet7AyJiQYrB9Ena7aFF4Grusdqzrfx0jkRCqXioOzbFwVBpbI+OvPD/eBzX0GMOdqM0xhfD0Mhxcb+27HRMkv8kbcdAZt60616C9QlHUy67btVukEtUGsztmFyTK+fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iATAQvNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iATAQvNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A91F00A3A;
	Sun,  5 Jul 2026 03:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221118;
	bh=eSDgsBCN0HUQJshrXsRJH/RX+zCNSVAEXc64hzOa8mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iATAQvNHCYZyQ3ifWDB4wgeHD1s5xJ0bnEyycawmCB4Cjn2/0DN94D/yRfj5s/Y32
	 FH8XVnRvkFg5Eg2Ek1dgF8qbF+5ADKSKOIkODIn1RwuZP56VyTVuzVUmn9jLO8mX2w
	 44aMej45O9g8HtW/SaR21Zv8KEXFw626L/fnhh/NAtO8xl3o2hv21RQnpt7DiFeAAe
	 oyiGCron3Y3efe0SeSr9dOgM1pM6tSiEH5ZjW8A+5Bpb9u6rBhBvvn2pFGF59W2Rq8
	 qGd2/cVPX7O4eqRfumMtj8iM1dor5w4dD8+wgIDU8JQdVMJRuMwF0s3GLfsKI6LzKA
	 i4gQk1QntsDFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Sat,  4 Jul 2026 23:11:52 -0400
Message-ID: <20260705031156.1601242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070232-straddle-keenness-fbbc@gregkh>
References: <2026070232-straddle-keenness-fbbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8ce19524e4cc2462685f596a6402fbd8fb984ab2 ]

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 943f0021d6a2c1..4b3bc72ef53ddf 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1551,7 +1551,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1599,6 +1599,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0

