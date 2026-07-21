Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A2476075
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678331; cv=none; b=V2tCmysYddqDyb615p+NUdbvq9wL4x7UcQIth/TXG3aNoA8HWdqWLrUomb1Vfl1gMOvh+bc01/JKaID/k5mJ140xexoAIr/9HIvasPRlDOZf4giDnJifALeBhIyeS28kcXazrzA5IuUT9nY2AsUUsWMtY6vCWP5IgSI+X4brd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678331; c=relaxed/simple;
	bh=ZFq4lu9IOQO4LIrTrnq3M8XDXEti1eP822E8YXQkYzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUgcWpu4BEmNZOUYAuEJftZCJxN2MQH+RF7IS7jcx80NKveNR3pjA/fsSZc4Yz8V5lo+TtaeZ3UqC3FmFuyht2i9vxRxpcg0SN6AFbq21J5xHSPk3x/az9tkDO5X/sy7Ra6SxljiZWKSjUdr/gQ3CuSqAB1RFwEYl5iV9N7NcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVR4C2M9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVR4C2M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3788B1F00A3D;
	Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678328;
	bh=OPOlL4wPoeGh1DoPKb/OEfgM9j9BLDbj/ZwXHzkT2KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVR4C2M9go3e3/sO7pw0GG/ndvg+z23UydzVZbqJyHlthhP+ozDYWR1IV5/8AtW5A
	 9YawoKTMBStCa4IbzOSjbfNjiTwR3xFi+2bOtJNS0DHIPZuolRY33JKBf9ewMBhZXN
	 2OmPoym5Uo+yiM0Qas7YyyuY6Qx1lO93X+b8y1N8+rwzASTqsVrWVsVehvTFyyR45Q
	 bKWZVxTWmf8QAltaF4jDrnUTwtpYTp30nRN8QspJDD+QENTWOrGGiqRpQ74j/pOVg4
	 OVPez82KbB2yyMvrA30hMoGqPDmOYvXMdLz3McGlwqfbyo/iXMaEOd5o73u3S2pSZq
	 YA4fyccpKH13A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 19:58:43 -0400
Message-ID: <20260721235844.523900-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721235844.523900-1-sashal@kernel.org>
References: <2026071656-trivial-state-54ad@gregkh>
 <20260721235844.523900-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 2295d2bb101faa663fbc45fadbb3fec45f107441 ]

If adapter registration ever fails the release callback would trigger a
NULL-pointer dereference as the completion struct has not been
initialised.

Note that before the offending commit this would instead have resulted
in a minor memory leak of the adapter name.

Fixes: 3f8c4f5e9a57 ("i2c: core: fix reference leak in i2c_register_adapter()")
Cc: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index df2ded29788d1d..e82607643ebfb4 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1567,8 +1567,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1608,10 +1607,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	debugfs_remove_recursive(adap->debugfs);
+	device_del(&adap->dev);
+err_put_adap:
 	init_completion(&adap->dev_released);
-	device_unregister(&adap->dev);
+	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-err_remove_irq_domain:
+
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0

