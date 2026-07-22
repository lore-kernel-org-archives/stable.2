Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A431336EDA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681454; cv=none; b=tPwyXaLRrKmiCtBGOdEWuDhnPamF7whADMwKuLYovops4EV1yIlqOh9ODvILaQ+zzNNmDtph0ZHneWitm+igiUxVTUNBOp7REvRK64z2RT1Zc1RmM2EOsqKOkrpnVeUSgU54qpTAvOV+DxB1gn8D09OBcnUzwFYeK5SOLgilIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681454; c=relaxed/simple;
	bh=mYHfXdXf1OZmCxyr2tWaLK8Q+pLPqJVaqJUmHxAmlnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nyftk2XxI1Ml55ZZSMraNUlHvRL3NtwQWHZk4Ao+xoTuo5aIR6K6TMvf0TN7tdSlcHSRzHZe3AGijS8QgFYhBm57D3FZgwYQVh0exiq0ZtUeSgvjHGz5Y6OTxWhhfNsuo39r4sY9wGyLNbe0Ciqh3oz2SwzLb+PgMxttYRLBkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfw8g5OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfw8g5OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A31F00A3E;
	Wed, 22 Jul 2026 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681450;
	bh=muroeDoZIulpQeVpbyGzrVbIC9lrqjs8lgE6RMp44vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tfw8g5OIP7BswPKR9NCvMktsoFpmq8dN3ND3znGwbsOpaBkE+TIAHH+OgEaim7VBt
	 kehhL4ZmLqajI85BGx9R1AvE4c+tOY9LziVDEzjwQv/2P99o88XCXEvL1LxNoJDPz8
	 IyWsukvb3fbOW+UQnUw2lxzl1QkuDxFTmI3VeO9/4n5K4CVlsHRA7tvR5QuluJ+ANZ
	 4mhacMo12fargBF2498UOaj5UknonzkfBbGcYHxKnSShrojjulGGmAmBuHim/5t6JP
	 qJqq8gJdWGH4UCgV4Mb7p4xI+pgy/05TfqYD2wzjoKLxX/qU1T4A+ft1uuen8/yZQx
	 KK/gGTM46MW9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 20:50:45 -0400
Message-ID: <20260722005046.603973-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722005046.603973-1-sashal@kernel.org>
References: <2026071656-dullness-penalize-0e99@gregkh>
 <20260722005046.603973-1-sashal@kernel.org>
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
index 24eedea1ba409c..a4005dea21f054 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1564,8 +1564,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1605,10 +1604,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
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

