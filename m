Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C33815D9
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260060; cv=none; b=NX5g2PSkAnEo5aJnekT9u9qJ+khJuYuz1P1qzY3VJknHkj+IU2vV1SRZYgetqOXB0+BzgISue0/wLnLnIYwK6JXetRjBWGs2uwAWn3zBpjhpxvN+rgR/CouKh8YhyDuRMB2Ny+pbCcV4ptKSmsPRtNV4f2v8japnxU28oXz5is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260060; c=relaxed/simple;
	bh=86rP26WK/SUmS5VkMYM0/n1bIfSQZ8h4a05DuMSy5po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqzfrFD01PG1tCyEnMLdDOZtruqfcsuSWN+5aZktAS7FonCoCK/TIH98PX3SO5OmZ1KFLza2rqf4787pm1Osnqp6c17abnsaxWCbBiKSQ7gOiXni1FLq6syesjOcMys7q5OsvW2PryIkWItjge1qKFW7+Oa5alAAgHoYEPYXY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+0yfoPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+0yfoPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF91F00A3A;
	Sun,  5 Jul 2026 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260058;
	bh=9e+5PLhjfOeEliH0a9GJ2AnF5M4XuuVz7e/NHKbZ+cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+0yfoPjc4jzVkvH6qscfoRmNZ5H6veiGrt3SzZFxMuT1JFkl0R2fanmEHm5dcqZh
	 FrwtYrLAMfKD2P3J6VjYRA4xwStIaZYaHmNclQ3zSZbTW6EMLSMT0GV8VLbfGIce9m
	 A57XzTiZZ4s+YBQqu+W2EHWT7GW/tfgengID8zAbIC9QKJknWkel50IZ/kjgEk02et
	 Oe3c48/0thIYQU8NpDBuegrN3ssIJhBhBc8F81gNGm11Rh4Q2MNY6hWDoMlciXeOoq
	 6csiuaLjhyz+AfR4UHjyNnBOFKP1gfODs7lZuJZaI7SbKUsvIah+4g83L4V4fdv8us
	 OGz9XaGfFKGyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] i2c: core: fix adapter registration race
Date: Sun,  5 Jul 2026 10:00:53 -0400
Message-ID: <20260705140053.1744489-5-sashal@kernel.org>
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

[ Upstream commit ba14d7cf2fe7284610a29854bdff22b2537d3ce6 ]

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Note that the i2c-dev chardev, which is registered from a bus notifier,
currently uses i2c_get_adapter() so the adapter needs to be added to the
IDR before registration.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 37a75d57175b25..98c281a35f5879 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1559,6 +1559,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1631,7 +1635,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1667,7 +1671,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0

