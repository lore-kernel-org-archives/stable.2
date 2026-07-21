Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4146DFFF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660353; cv=none; b=DDubMl5UUZ7FnIWuPaQfVEPozUe0JJXDjGEHuarPVPcCvYgm/mJCWv4Unee1eP6D97l3ZAj03tVz6S2aj2+hVkVT0CnZzYrlEmwJIWFh97kZ4qt+4NSTxXKEcSS9WFBl0W0JE/2EjXylkt6aU2b+LGeAZzUEivez26CQbtaTVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660353; c=relaxed/simple;
	bh=TV1t3k9m7jk9bKRwO/MMLwf3C2WgmU34kgLEWWMnVzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iip8uM8ivwM+gt5Cq2mB2xxxAMJc/la+UJxXbAVOBS9x7ZtpRzEtwj3rp7faAz4YQnEgclFBfP0zOhwdJegKvSKvyZnYcKMYjTBRQMJKuGellEA2b9gXrSzz+PL5BnK+vlePUJyG+d6kduepkkNQG+kkL86/yiZ2BIyItxuFe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF1cEFQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF1cEFQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704AF1F00ACF;
	Tue, 21 Jul 2026 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660348;
	bh=37Rt5LHeeRtj1ewlawLrzqT/jCOMkoDJr1OQ60X09YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YF1cEFQ3jBH1+PkhMefxLPFM6FxJHHiDrtlhKwtGgQm8+KGB2OBwsoBzkeKcfuR1y
	 Zr0Xn3TsGmdLlrrv+bhfSe6TQVBkNgI/nUqB3BCl8pluXEK0aop8KY/KWUVcGMeJXX
	 ieYlnuFlb+IZ1FdRiizhtRb2xcS4Jl8+NOfaacnpw4Hc0iEm7LNo1TO6CT8klCMqz5
	 zYlajp0kLDoiJauwdLvav76KLu5BSPvadjs/G5FjyrGMZcK9bClO7cKadiNsN1SvHq
	 gmK1HR1gmqYDXvABMXubHzoyesQK7paf/34fxm1eliRg7NIRC+t9IZ5hv59tMbXANr
	 V/VW43n7iWEsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] i2c: core: fix adapter debugfs creation
Date: Tue, 21 Jul 2026 14:59:03 -0400
Message-ID: <20260721185903.397573-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721185903.397573-1-sashal@kernel.org>
References: <2026071637-frenzied-roundworm-4d38@gregkh>
 <20260721185903.397573-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 899c7310c77423..37a75d57175b25 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1549,17 +1549,22 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
+	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_put_adap;
+		goto err_remove_debugfs;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
@@ -1599,13 +1604,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
-	debugfs_remove_recursive(adap->debugfs);
 	device_del(&adap->dev);
-err_put_adap:
+err_remove_debugfs:
+	debugfs_remove_recursive(adap->debugfs);
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

