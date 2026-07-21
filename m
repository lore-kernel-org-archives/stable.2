Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C046D57B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660352; cv=none; b=Ou3+xrr0bnhR6PZDAj5oLzFKTfzN7dk3Ex3Ro6Eiv4Q7SQ/OkMfyau3587Vu70dPKO0jDh/KAo47n/V0c3nSYTTFe+rVGtLGl0IYmECyWHBBZ2RwbfAbGfVubUE7oAv7ypW6NUZ1JsYIyvuMmKbbRwgLw2JsKFDuPoZmhuWYOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660352; c=relaxed/simple;
	bh=JszYArdeFnjUp3ZcESs0pNNpjD7t8WrWkuzc+nb+SuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvg05k4/t72qSvkTaEnfq7bmd4WeAR/tyTjTp/Qepzv1V4Wak/Jou5DK5C/aCeCv0vNXtK+pSFyyKM/8Avzyr5BSl7ZT1lA1kDm0EekeRvqlxsEW1E/zPeg1LBIhQdgSi/GqyPqbT26igSL7ShgHEVXhJgPPZz4ZJ7oqc9z2/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oams7NkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oams7NkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984721F00AC4;
	Tue, 21 Jul 2026 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660348;
	bh=kXdNycSzON+3bVM0o5NbgfvXxm4plcGFiDEdfo57LOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oams7NkU87+7TF0VISn8RWFHkIt+LoV+4zjnYdncvGAzN6U8QRA1wJ/WzC//HkWOS
	 iI1T9gqPbQl0a0uuUiZjhOVgYwDcQh1yW7tIqqHsSkGYY4d0zoJ6OdzbwCU3yPau2g
	 /aTViVIorr5YKwWUspM+0GQ+DojthSVTfSQVhmHWNPbr1Osv8dnt9b3nTC5eO286OD
	 6gXyH1ZE7iD/fGuGoeVbWk3AaCmKhNEZxiHErwrQPLMapsPIiWKobc1XJxNWDYr0iC
	 ZXkt/2O1xXCAEQJtnuQOh6hwOCzE+gjlMaqdugmtJDN+K3B8YbpKB4p/7nErvPjJ6d
	 btO5kbdfE5j7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 14:59:02 -0400
Message-ID: <20260721185903.397573-3-sashal@kernel.org>
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
Stable-dep-of: 07d5fb537928 ("i2c: core: fix adapter debugfs creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8bf8d395807f6f..899c7310c77423 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1555,7 +1555,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1600,10 +1600,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 out_reg:
 	i2c_deregister_clients(adap);
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

