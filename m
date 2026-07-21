Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F01430CDC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663318; cv=none; b=R7iW4WZsl7CcVbzbzfuS+O9uy9djZaIWx2/3xuzf9BaItWYvcndCs+cglSApzrUnVuNWf7uLEWbEnaxzL7pj6wgMLGBI38ppspdows1EcdLMiwfvCGJ1lxkquTOGIq8xZQzPW7zF9yxPzjwj+KXaUDUuL3dRM+rhyf4iALH8Zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663318; c=relaxed/simple;
	bh=mIhwGgZDeeU8Y94rdlB0rEB+ikDPCPpwZlm1cO5SQqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2+2stFJ8rDMcO7vyQyH4Yyz1+E//FdzhxE6Lh/MNhEf/foTeurnEvsbhS+vVgdWUnakcUnrVdAJJtgkl8Y/XZZOXIatRmVb2VcdCy0hHuSRgf2sDIcEaMrcr44vMXupAs5QdIvlEk8IZr34ld+bTtZyJqtEiS/TzVlirL+oM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9sVPaG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9sVPaG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A321F00A3A;
	Tue, 21 Jul 2026 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663315;
	bh=YnCJLz85eGYrHTvI1s9sFxhZI2ThQiQ/ewoYXyhah9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9sVPaG58BJo0NTZQoSg9ebtaWSFT2g05iD8LEOSQ9ai5G7g+7/5ulgBq61y7Rr9x
	 mTDk9DPWGfhF+pAiEvFx8jWsZcpHSn1YmMa0DqpEi29Yiz8Fhv/agNN5rTxFtOcRGG
	 nmQBl39XJQlOs3URWfdadqjJzE83DzeUR214nCiaIPXrrQtgYu0o01x+1EdlbgcfGF
	 wicMhXuaJ3BoZM8Wv6Jugh1WriE3kvpVNWiq84ZunrYBBeemlfDTmAIKvLh5nXXsLu
	 0eWdsWLYtV2aEY5m6/q15kxH/Gi9GboarhkVVW5dgqZ8Bi4UJEn42956UZDDx9O5wV
	 jowB1CFmdrGaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] i2c: core: Setup i2c_adapter runtime-pm before calling device_add()
Date: Tue, 21 Jul 2026 15:48:29 -0400
Message-ID: <20260721194833.416799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071656-confess-dean-8762@gregkh>
References: <2026071656-confess-dean-8762@gregkh>
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
 drivers/i2c/i2c-core-base.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 943f0021d6a2c1..b529eb8214fcc3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1548,7 +1548,18 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
+	device_enable_async_suspend(&adap->dev);
+	pm_runtime_no_callbacks(&adap->dev);
+	pm_suspend_ignore_children(&adap->dev, true);
+	pm_runtime_enable(&adap->dev);
+
+	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		goto out_list;
@@ -1560,11 +1571,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	device_enable_async_suspend(&adap->dev);
-	pm_runtime_no_callbacks(&adap->dev);
-	pm_suspend_ignore_children(&adap->dev, true);
-	pm_runtime_enable(&adap->dev);
-
 	res = i2c_init_recovery(adap);
 	if (res == -EPROBE_DEFER)
 		goto out_reg;
-- 
2.53.0

