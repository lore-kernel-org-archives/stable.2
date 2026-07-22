Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EA361651
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681452; cv=none; b=OHl9mP/DJcsNnGx+68gRWDsRxf/05Pq03i9ZlbYwgBNmGfbIHoPhkdp0ufLMlAM0H3y9MizcMJS9QvSNLpuQWtlIh6ky5P/0oJfF9RZNM1im0PoK/WQ0F+eDvQfogSeieMCk8Hf3ZVXhXFXTnl+pVPmV2gnuEa4Hz4hVJ6wo8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681452; c=relaxed/simple;
	bh=u/ryCgwJ5I6WpR7n0SxYhYEbHwZX7c5LvYlGQ+ckBNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvAaHyQTZyBZ0aFyPZ4gC2IgIm98y3x717X7Jy2DeqeMCffDqpCABfTVSjNt2O/aCEAa+/+ynLR9KiQrKjfijZqqotsyttGxnwihlkbkI1v58PurnuxGSVye2fGYZFQMbOiKA5clgVOWIHGdI9GXeRaHT9vpnHptTTmozBjPtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaJacUFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaJacUFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935C01F000E9;
	Wed, 22 Jul 2026 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681448;
	bh=rv8gOrUJwOG9lsbHv2sioKO7WkJxkYw2X0Qo9a5yqEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaJacUFEYmNQjFp+YY2y/VcIiBM26J/XEY18ZOaZLci/wzxxly1cYtS1Qj5gUT0D6
	 OdUi8AwR91OHiI+B3hmXfOvdHwBjt4nGYaocRBjO1J25Uj5cOpDZGq26mmOZq1eDLc
	 4PHDsuuG7kPnrftk+4cDabC80hkW9qq0/LsrEyLjwU/2p8DH+T3tP9LNF6/QFZtIjp
	 nZbe2zYLFdudjg/5uPb4Q1eXzoPe0CQV9Z2X+PXK0xDHwZbEiJMQstrg56HoxXjVFK
	 58zT7qR5Ob7y7WENZ5Yo0wdYl4xtjRzS0iA3dM4gnOAJmtowVo/WwlZW9ifnYx/zmH
	 K3LxKjZgtEs9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] i2c: core: Setup i2c_adapter runtime-pm before calling device_add()
Date: Tue, 21 Jul 2026 20:50:42 -0400
Message-ID: <20260722005046.603973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071656-dullness-penalize-0e99@gregkh>
References: <2026071656-dullness-penalize-0e99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 60f68597024d5af727c8a5f5f3b11f246265192b ]

Platform glue code, which is not build into the kernel and thus cannot
use i2c_register_board_info() may want to use bus_register_notifier()
to listen for i2c-adapters to show up on which the platform code needs
to manually instantiate platform specific i2c_clients.

This results in calling i2c_new_client_device() from the bus notifier
which happens near the device_add() call.

If the i2c-core has not yet setup runtime-pm (specifically the
no-callbacks and ignore-children flags) for the device embedded
inside struct i2c_adapter and the driver for the i2c_client
calls pm_runtime_set_active() this will trigger the following
error inside __pm_runtime_set_status():

"runtime PM trying to activate child device %s but parent (%s) is not active\n"

and the i2c_client's runtime-status will not be updated.

Split the device_register() call for the adapter into device_initialize()
and device_add() and move the pm-runtime init calls inbetween these 2 calls
so that the runtime-status can be correctly set when a driver binds from
the bus-notifier.

Note the moved pm-runtime init calls just override the initial value of
some flags in struct device set by device_initialize() and calling these
before device_add() is safe.

Reviewed-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 265b7f7f38c6eb..1df75dcea8b97f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1551,7 +1551,17 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
-	res = device_register(&adap->dev);
+	device_initialize(&adap->dev);
+
+	/*
+	 * This adapter can be used as a parent immediately after device_add(),
+	 * setup runtime-pm (especially ignore-children) before hand.
+	 */
+	pm_runtime_no_callbacks(&adap->dev);
+	pm_suspend_ignore_children(&adap->dev, true);
+	pm_runtime_enable(&adap->dev);
+
+	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		goto out_list;
@@ -1563,10 +1573,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	pm_runtime_no_callbacks(&adap->dev);
-	pm_suspend_ignore_children(&adap->dev, true);
-	pm_runtime_enable(&adap->dev);
-
 	res = i2c_init_recovery(adap);
 	if (res == -EPROBE_DEFER)
 		goto out_reg;
-- 
2.53.0

