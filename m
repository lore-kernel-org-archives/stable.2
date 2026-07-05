Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF563815C6
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260058; cv=none; b=P5kf//8RJNMl02fc4HrJ9YGpuez2tg5r2lNOUjiVdvK+6KzLzB4WVdZMEsK8xcKcOAu+jjiPJIqeZaigbTt7XMKTLXOeZeFoH90LCwknfpIzd5SmpxyIbRR0wM6SpG1g5FYTu8WswzXRnSVyTFlt20duiPw0KRmW/v1F2iVdI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260058; c=relaxed/simple;
	bh=Ms6OCA16UfaHV4q8z59YB6PdSTYNOM/ABurv4ZwoYkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyXglrwTO/lTfwTxsNotBO5ymsxogLTw0YYVNSSV9PoYowS/YRb23NtNHAQHg7p1t82IlGtFfie4H0Gm+8crRadYdCee3aq5n3/gHLecUTanyfA2yQ/TqMtDZx21o6gB6WL6P3z+IfCz6PSAww8QQ6pDibTQ6tG0lMOkAD8ESIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/cIiIMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/cIiIMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C9F1F00AC4;
	Sun,  5 Jul 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260057;
	bh=xna9j9M/6t+mHnBQm6Du8va92oZMKuCreX9wEP3aD1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/cIiIMzK+sgEa4RhydW4fnpK2epRTBpE0fMaIw9+entzCT82dasOYbBgUbsBgU3W
	 wVkIM+ZKxRftx8JiFbJ0A0Qlbqp22GV11OwXJIv07UcnPNPPnKC2rPV9bvPvbcKcHy
	 VcgcApAD9ryUPmLA+FOjrV97JQJpk5A68YfJiGSgU9KTY1h5OAPA9B92gPYrIwvj7j
	 X6G09b4R54cJjQGzUM1qzS5XzSZMIw68+aH+dCihc5OAnQwdNKStuO7fTA90uoKYQ9
	 X5k+qiYSWtU66Lg8NWGG3crUacnxn1+lEIizyIOZmFr1SoKQIFTinlaT9BLZxUR3oR
	 tbQ2HElv7UG9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Sun,  5 Jul 2026 10:00:51 -0400
Message-ID: <20260705140053.1744489-3-sashal@kernel.org>
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
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
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

