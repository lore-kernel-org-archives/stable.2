Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30C47254C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678328; cv=none; b=KSGlFU22ssPJz8OtuX171sO5h6bVkWwSjVeWloz85HDp88kwnokGmIomJ1I2XPM0NCTlasVkP3DRYtHYQRg2HNseDtVv8VcEB1c42QUS8BDLiPiNF1jycGImgCqSEPgzaNyNLI2bruBEVeHveGb/s4n2xHHgFTXfXCfKkl2aKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678328; c=relaxed/simple;
	bh=/GYcheVMJS/g5VnL/GDKwpmAjJYzt9E+NfsG5floJ64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbsMerGpBtKmXIcZ1gwf4nptOmGaYvuzuExdack1YwLSG1P+/U/E8HaVL5L37UdVgfTSR3hion4/zu6vhHFBpUf3fOUxJYE3vBmaKYh7pdVp+rSrDzqmIm8EwxvvkhgdjAhie5CyM7YIlDOn5DGRhybZlUG3SxYhXwgLtWWhRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGBMMIRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGBMMIRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7181F000E9;
	Tue, 21 Jul 2026 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678326;
	bh=zgzazan7+GNmy91NmnChCdecXbz14Na37nVynnUVCLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGBMMIRMm0et6tfefRfIwABqd85cMELRASstRrbfXTT5KD1umbPBLFhgz4f0xEC/q
	 j/YvVZqrq3QWUNoCP2+A7AgrFZx6wdGx3ObwIrKO+EAxSVnwH9NKWmsDqhYE2r9y6y
	 9U/N565Dg45AKz6blpMEcIzIUH/rouPYbJs68o+AZOMJBRJp8ldhmtJXmxXJIqPlrX
	 Bu0q8qITe6hurp8HDYx92+7aMlHX/LzUDdG0NT19g8gEnO9CKYTGn8kSQnSCrzjrx3
	 uHeXXO15LwU/qcDuFAqPwa0opEY7np9DY9a9xQcDzf1kYksQyYxUUXd1K9rqHYQlqX
	 BczgfApa7nhUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] i2c: core: Setup i2c_adapter runtime-pm before calling device_add()
Date: Tue, 21 Jul 2026 19:58:40 -0400
Message-ID: <20260721235844.523900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071656-trivial-state-54ad@gregkh>
References: <2026071656-trivial-state-54ad@gregkh>
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
index f7e3fc0b3a1daa..c9b1818f7779a2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1553,7 +1553,18 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
@@ -1565,11 +1576,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

