Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8433A9FC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659721; cv=none; b=taKRXKbY0xjSZ4g17XOqP00eJEOZFeSja0QGk9qwb1rcFen5OWW0tBlbTPLBrcBVYGyvnT6YJ2Cuom/qVx7gZEWUV59t3Sc5DUqLRyya0N7r08uEI7II32ZcbUFYYpSxnLZUv+cTYUXY8DOQb5j2d1SmBTbKMQU/FdeEPOWGTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659721; c=relaxed/simple;
	bh=6X5tg/qVmaoTktb11pO2ZJ1v6PxEGyO9LKNAz3DhQO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOn5rg3L8V0p33abUQPyglIdrwmI3hBqo/9HKArTZovViwRqLTN5BnJcm7zEXal1vH0tF3GsOKVZBB+RGy6Q4USqCFHJGfdmqZ2vBE7eoX/3M820QpIvUS3EzwU6+DGqFD/I5B++OykQFgR+E+RFyxfVCKGJrSM5/6t0u7R6nC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckCjncJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckCjncJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D11F00ACA;
	Tue, 21 Jul 2026 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659720;
	bh=W+sFzXtnpjt7aSXhwSgF2XV2yyHCPvj6cg5qi0BLGfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckCjncJtiIvopSlt/VmF4sUyQIU2ogYC/bQNsji4K3T3fg5EuW2szbvtkS0qB9nwQ
	 ho9o1HcbfkRElGN+MVhXXX0H0kG8fRmf7I4ySnDx/A7bVs+OpJMiHdZYTgfqmS2iol
	 q1fIRrxpwk3kL97WqLagHMc/G0vOJ6yV9K9ctrqDI7WYjzfXxKZ1/QP8JqY6g7lo8p
	 POz+DDilMnBWZ3YsghvLeyi5CSNqEiPnmZaqIfZCM+K+0mxiBnaD1AuR5iAcQGlbk8
	 rIOWfLriR7QHoSrMzi4s+KHu0Y3tyogxZAbNOIOPZMWcJKa/6GslL/BLJlFU0Lht3p
	 iL4hAw75Hp21w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 14:48:34 -0400
Message-ID: <20260721184835.382100-3-sashal@kernel.org>
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
index 8d688d631ccbfe..70876470348ab4 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1557,7 +1557,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1603,10 +1603,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

