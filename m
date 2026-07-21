Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFA471431
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659722; cv=none; b=X4lZSveQsvZw22cDlktyDDcw5+07uNlL0DdDrZU96pLiTPOUMEBxn6NYULZcqO8KODWBqGvk7gJo5zT1th/iZr8/9F2yULD4EFyCkR04W/gTL13mRmH542m+GKXfcovz0PBiwyUBjHH/VkOcwQpjEbVnlVAMPFoNgzOvi7tq4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659722; c=relaxed/simple;
	bh=PaQpVDJUjDSfmLBLFjc34LRZYW2N63PCrPC3M8uiRHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssyFAk0mgxiQwriBS5ed83YKaGK5tHTlb2LNjGDQFxhJsGgXH4uSKzMhIEqS3XfM27tiME0iW+cTQ69Id/lyVnIyXfxaBIkczv7vCPzuLdSLoOEO8eAbpIVfV/RxfAUapcY0LJLJyY6rVAdIjn/Qpp9sPKMT1ThuWA8kaoojZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyS4VNCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyS4VNCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1931F00A3A;
	Tue, 21 Jul 2026 18:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659721;
	bh=m8//W9FiHWpg0xZ90vLbhCmJ7ETSE+uaiptTOrA1+KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyS4VNCiPX2S8Oa2ZZP4w0DbSPDyAqpPielL8BuUa0205b7tfqzburLKePhrJcBPh
	 uuNEYIv/gX5dp8rPtlbism4lhHj6huWoQWcsPB8cTfEw9JH8mr/iH+yyIqd1qw9lRp
	 f7R10yXzsYlZvhIhj5Cnrywb/L0YwCtbzq3x8pb/LlRH1hxEu9XWXRoAa4aJ8rPtHC
	 5Z0R55DJL4C/wocCn9RScZfU3Ndsht4cJtM16m+pmqDRklcBrd/joZz33t8V+44xpu
	 uRbgjEUGlV/8xJRHw5rO1T165BrhtI9a0s2+WMm5XjGPXcSn6i7I7Eyq18WNA0UDLS
	 RsAow6TCgiyBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] i2c: core: fix adapter debugfs creation
Date: Tue, 21 Jul 2026 14:48:35 -0400
Message-ID: <20260721184835.382100-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721184835.382100-1-sashal@kernel.org>
References: <2026071636-deceiver-subzero-c7fe@gregkh>
 <20260721184835.382100-1-sashal@kernel.org>
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
index 70876470348ab4..2c54799670182f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1551,17 +1551,22 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
@@ -1602,13 +1607,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
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

