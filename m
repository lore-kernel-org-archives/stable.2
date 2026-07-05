Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D73815D1
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260059; cv=none; b=KBQ86f2GTDrl/xm7zTUFc8BTpdl+8pLf/zmrIllyLhEdhdD9g3JUfXvJQm4zUHMZTrf7oq4MSgGQQnv61fd05tGSBRHBNhfBvukMNUvwwcpe9OgbZVz6RoYSzDHF6iXFUKOuwAzswFtdu3vLawWKF/OUp2T7nkbo29Wcfzqcxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260059; c=relaxed/simple;
	bh=Q3qdCDfHksLjPYSmnSzjCkR2PyRliflcOry72n4/zlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVvdbAYOykiO4BJWGweHCMgyOfTr1oWNeSJ+zzRw5NXllWqjidFMApXXtz9+eR9AGTc+bH3HS7mB7bYoLxrpgzX581GiEWstQf6Uvo1kg5IPwO2F09NeNrI4GtCUN1WM6XBCe0FyHRypDCOD+bsfdoi5PABa83FkVLFnpOwMgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjQs+GQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjQs+GQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FA91F00A3E;
	Sun,  5 Jul 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260057;
	bh=g1FCsEphG/2lF02uumcf1811HluiEU5cesHGoVNwdu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IjQs+GQ17IG5CLNmtY0Sl4YK5CqjxoJRXUlADsZQZYfUdsGyPyQOilEyABT1Ckvdm
	 RWUc7z3YXEGYgM2uAerLsgJu0E+0BMETX1QpWCuAzV3LSqaAGZ+hQdOvagBBw4O2pp
	 cGiHGHi/VZmJfzUR4PNNufViG+2Bcg2izjnLEUMtzeOCr0Jg8IVXht49ImazIYkER8
	 SlXKREgQx1GMF5pWoyk4DFwrSEH3mzvL4wUF96dJr3jkyZ7OxPkwoRDhVR5ptYiHI+
	 ufge84xUzWT6ACcnZULqWZSYIzdOBlqOtXBNPydEQFMMOYPGIzsDfVv6FR4ZqkEgX/
	 z4UYLaVKj4CYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] i2c: core: fix adapter debugfs creation
Date: Sun,  5 Jul 2026 10:00:52 -0400
Message-ID: <20260705140053.1744489-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705140053.1744489-1-sashal@kernel.org>
References: <2026070232-opal-musky-5819@gregkh>
 <20260705140053.1744489-1-sashal@kernel.org>
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

