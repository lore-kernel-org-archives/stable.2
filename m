Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE330DECE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278378; cv=none; b=MYITgLAN80BodM0JxsjKtjy/WYgGw8oUmF7GjPnNjbtph/+vDeOEb64xT7AGuQ8bHkmEYyrowi3PVfDCZe3OBSNTtXZbAiF4l53w1O9rn9PXcZ63DOrIZ92T8xeKnbiQPoRd5Eu8/em4uZjb96evAAc3HbP1G/enpMDxb7b8gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278378; c=relaxed/simple;
	bh=tqw7bvQ3plNp1kObNS06dnt/E0v7pIdJiEIjPMJBnkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJSVmBJkH964ehstqi86k+yTaq0Q9HLlozqvmSMXSUt30kWnJeZyWAff9THTSjGDIPaKnXKcsw9EoOekcWOz1ysPRHtyTs7MDiyP74QLvSTJzbVhtzd3KFpksjRPPKd6Kt1a4Brh89uj952XbrotoTMSGh3ImBnZOQwvGxHyvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+toa0X3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+toa0X3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1C51F00A3E;
	Sun,  5 Jul 2026 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278376;
	bh=AqpXgE2JqFloIknQWnaiIYG20YAGZzokRMEuIvcAy5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+toa0X3Ld5v7F4xPHYzqZmslpjx3gZJjpIb9E7mEd4DsrBcw4567/3e8ng7e3RIK
	 j7IVGV7B+hppDK6khDFVn+RfliNXuN1ltz3eDqq0TgAftDFuM8RtwftyGCiHn79Nw0
	 ecDw01RgxXqJ1Xrx1PhBL6gRHWdYJg4nsPPfPa2ua6hhS/PdXb47mr/FgpMpLaKJn+
	 m6hnYXLPyqi1pPfrSpQGGIJ37cbQDEEkDUdabi2/4U2vzm+Ckb6plnEm0d3o7JwLu2
	 Qdl5wm7HQauK6RLrobhC52rZsYur8ngpHDbwEIP377fmWRmjc1W8s+2gsoC16Z5f6Y
	 Vfvnk5jkKY3TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] i2c: core: fix adapter debugfs creation
Date: Sun,  5 Jul 2026 15:06:11 -0400
Message-ID: <20260705190612.1987801-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705190612.1987801-1-sashal@kernel.org>
References: <2026070233-lushly-episode-a47f@gregkh>
 <20260705190612.1987801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 07d5fb537928aad4369aaff0cbae73ba38a719af ]

Clients can be registered from bus notifier callbacks so the debugfs
directory needs to be created before registering the adapter as clients
use that directory as their debugfs parent.

Move debugfs creation before adapter registration to avoid having
clients create their debugfs directories in the debugfs root (which is
also more likely to fail due to name collisions).

Note that failure to allocate the adapter name must now be handled
explicitly as debugfs_create_dir() cannot handle a NULL name (unlike
device_add() which returns an error).

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org	# 6.8
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 59b34d11f8bdae..b81a9f5f234303 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1456,10 +1456,19 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_remove_irq_domain;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
-	res = device_register(&adap->dev);
+	device_initialize(&adap->dev);
+
+	pm_runtime_no_callbacks(&adap->dev);
+	pm_suspend_ignore_children(&adap->dev, true);
+	pm_runtime_enable(&adap->dev);
+
+	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		goto err_put_adap;
@@ -1469,10 +1478,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	pm_runtime_no_callbacks(&adap->dev);
-	pm_suspend_ignore_children(&adap->dev, true);
-	pm_runtime_enable(&adap->dev);
-
 	res = i2c_init_recovery(adap);
 	if (res == -EPROBE_DEFER)
 		goto out_reg;
@@ -1509,7 +1514,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-
+err_remove_irq_domain:
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0

