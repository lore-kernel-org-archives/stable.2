Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAE473C7A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678329; cv=none; b=IlfA2o8oeS1045OlDXTRQXtw0QyA7hzs+OhrsIHf4G+nArO9cT10s6zx/RhzxwMeVAbxJe4dIMRFCVa+6mTNClepcYSSj8mttsZAzBHVQY/QKq9TrqiZon8YyX8W/GOQ3ykLOqgww3QMukv2/sSFaD/z0CGEJNzBFJNIWfJKE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678329; c=relaxed/simple;
	bh=6Lovep4xUi6YDOsArGMyxBvyMAPOrrZ4cKjzzk5URaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIwVrIWWGv2t9tSG10GD8x2+MYpt/QrBDRLwGMZc7Wdcw8CfM4nqtCKvimFKRuba8jSjEOGGjpSSYvYIlsLpRfn1v9QsEBGUtrxPGi9ce9IzdW0A93MxOr4Ys4p9vE1HFksyZQj6DYzqAzTYm4hWfw63gb3mJDLwJP5618gdoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF/7u16K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF/7u16K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681251F00A3E;
	Tue, 21 Jul 2026 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678328;
	bh=40xdSNRBfNozE7Oe0+bsYMJ7nSaXYMuR3CwTxm0MaiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UF/7u16KEhLWV/ZzS74MYTspCjZf68K3Ss4DaaKuzs1/btqHto1d5zKMadk+IHI39
	 3qqPFdXU7m8acWP5DyXYCPisasI6geKcimk9k9DsR6Fdj6zRubihzctnlFFME4V7FL
	 D0C0kTr/G7FNxz+tgIwTblgTaMnYtcO7Tz1Y0u6+8J+S5v/firuyZ85D5jjS/hEowN
	 2TOIWwGs2AuOdJOOT8OL3WZUi5jjeUq7uXjJgY1t0A9wFwPYzUmHnZibaYa2hhZcPX
	 ydqg/woFUKHBEgLqn4XThSBcIIxot8my8aAu2fmWsb93L1C2U49JYoeOzOol0kJn+G
	 Xy4Ba7Wyr0kqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 19:58:42 -0400
Message-ID: <20260721235844.523900-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721235844.523900-1-sashal@kernel.org>
References: <2026071656-trivial-state-54ad@gregkh>
 <20260721235844.523900-1-sashal@kernel.org>
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
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f6e33bb3dd6e6e..df2ded29788d1d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1568,7 +1568,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1611,6 +1611,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

