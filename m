Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56C39A7FD
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658485; cv=none; b=nzC/ZpDOjYPijGMni1m/B/+jQjNYPehpRaOq730supFRiJKsD3hwZ+jir1vOE94fPwoESBYXQNErVo1kBH1ucFMN13c7Qi6LZHGX4UFtdrmgLnc/CxPsCIHRHruwlYImY/WLN0Mg128w2JFhjQk8egu/k5uXJeqASgcqG5Qc8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658485; c=relaxed/simple;
	bh=7H9PM27AKtsB6Esaf7nIwX0f1Cp9NS9LHrV+1PUa2gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8ei5gFOx5YFJuD7pb5bPMX5qMFsJVswU55cceVybuE4dIztZRZIBOTSiDn7t7AeHnB40Kxzx7AmhBEWxOcAR0RcmRtXxfXzWCawWd/HvTXeldNsghvp9nslP+NDftakKhZXt4APZwbe8utl94Fqn5bWPE6JgnFIvMLMDzE2baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjxwohqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjxwohqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5B21F00A3A;
	Tue, 21 Jul 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658482;
	bh=d/mN5rG3TDtJNQmKP0axKlqgEJJCzlnDLU4cMR7qZKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjxwohqtdkH2AJEXoGkueMirfKsupI0qaF9QXKZwGXIyVolZBBLnSE+v9G6X7QRSX
	 YA4Bi51/BgRx8ncE9+wpivvtcI9kLGROg4u/SukVdkQlIVM30jZ7oiKbdy8D68BmLJ
	 PO/YybuHXEvhP6LB3/IfZ+rdEsn5AOkEcOBHeK862/rO73OgxGrFTtuojYEDR4zZZr
	 JyVLcCqHsseJCL9YNW8ErBBwvGLC4IiMLK97bogKoBg+1n1qm9HPqwoApwiL8vpDY2
	 xd/TxxcOiUEIjQJOijJN7MSDLI1gX0C6oQXThrzQQN8rNIxhmmHIHsOfcI1YqRoOzo
	 e7jLUHxBmfP9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] i2c: core: fix adapter debugfs creation
Date: Tue, 21 Jul 2026 14:27:58 -0400
Message-ID: <20260721182758.332454-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721182758.332454-1-sashal@kernel.org>
References: <2026071636-amusing-conduit-3c6b@gregkh>
 <20260721182758.332454-1-sashal@kernel.org>
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
index afa51e3e6b5b08..f5338a8441a66a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1546,17 +1546,22 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
@@ -1597,13 +1602,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
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

