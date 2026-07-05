Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7634752B
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278378; cv=none; b=WEiPpV5tU6J0G6uDvp5HDFMwHIl/E6s+AF7+MtFkRgvV83bcaSDbdShq7wDC9U60CdWjrl1/dSh7jNfEUecM4TPN2pMvRPjrbcmIiJbFqSVJRqjN9B3zShbkmGJrftb6tYypMbFuKG/tD7PnAYcb3eQLRToSq/XmhR+7bUflNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278378; c=relaxed/simple;
	bh=8ecTNmG4KzOrEf79qIndrG0rZIrJfjzUwqTiwcbo8jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA0TeWIT8FxmsA/ahLgjNYvnvazSguIHLIvWxzreUp88tCJDduKA9DzvHlqxRLbQn3C7aohi8meTHbPEBc98likiIhywqn5MqqFFJapU8A0UbA6PBryoX4J6UEP3Cn7mxkM/Wem2Ph0z7jXb4vW7mEocWoVPtDI47AKGYY+wrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQSl67MA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQSl67MA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F83D1F000E9;
	Sun,  5 Jul 2026 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278377;
	bh=V03F+R1i8i5K4aqIfAmojzUu3DSXacJNHwINWw2Ugn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQSl67MA0YkGHg2/4eyKUiNGto1L5wTUVdSKvpEEEdfqpGcTS6S7BIzNOqhot+FDJ
	 UTBjN20Nr5ygABhe9Y+2OjFnCvdWGIQEruPLzWo2bMVBP0YCnfAd8wYbz9LTYvBm84
	 6m5BjjJBeF0m/JmqWBOWsvR+83uqBKcmttrIBmQW/nK5WQGZN1AZvrYDrdZ3za34S7
	 zjtsJbVe3w2JMiZx+x+hPBrPUhD9tAjbZkQB7cBIumJjBKsvkILvY0Q9GEHkzyJak0
	 OSZSidfr/NARw26GnLzVb44MzYNh9c2EkTKgQflbxf2Jqy/Un+42XAnuLxbCZcYuLf
	 FtyTY34Baf5kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] i2c: core: fix adapter registration race
Date: Sun,  5 Jul 2026 15:06:12 -0400
Message-ID: <20260705190612.1987801-5-sashal@kernel.org>
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
index b81a9f5f234303..cf7c91df21d59b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1468,6 +1468,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1535,7 +1539,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1571,7 +1575,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0

