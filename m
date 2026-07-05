Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351219D074
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259284; cv=none; b=YYFIy23lxhw1eM4nspV6Kh1MjHKhRgOxFzbwEgv165tbLwhja1i0VAFR62HRZb1lD1ykGamvJ8QCbQHYJVVquv4xx3fKhYZSTNXecXMIln48b8GZkalmSz9pk4+4A2PPq0CmcYR/GUDHf3dn63Ai9bf9VvdkFqJ9ZEL35kPrAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259284; c=relaxed/simple;
	bh=vBoJg3FqyPwQbrtLbmZShlo3qsFQGTfoa11sZo8YnmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddO9XBVZTbgYLOf4R+RicBI4niKES5+qj0HN8iTV2z6cs6D/BjsmXKJ8RvKPy4+Rnza3tfGu1w6Yms5M+Eil1WRiTPois4/QcT3cUDkl59xF3lCPDAGWgi5FO7CY1R/YiwQ6Bk8SFQfFzyvbeMG7uKufLYecyTy1lhubx4pgn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFzJ1Yyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFzJ1Yyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED471F00A3D;
	Sun,  5 Jul 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259283;
	bh=nFuWnvcv5LBZefmpOEnMjP4Jmlqq65ALZc3sRxH1N6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFzJ1Yytg9oNiSWqw+5Ev51S21UhBTnPXzAYQirYfE/Ied1HebMJTAaNJulNBjQXt
	 P07YeEbomVLfqmgShnRJ5hI0mmwoUoufzQdmCwYRUN/11x3crxQq7USA5HBbAlm0fk
	 VuWqNFJ6pCFDkNQiQsWgtuhFqkmm22eAF68EWv0bY5wmn3DsIX6jwvi5vDl6jSi++Y
	 gtVigWCKH/LNiDU8Qk1K5lRPDUOhSsbi8q6XSse5QSVwJQiOMUiz/UpvLIrAiWTnFn
	 ic29ja/7RlnHQ43d8N+kFnfVp2IY49dogBXpYgO2aL9hV40NsCN739H70UDnK30UfA
	 K1kS7nFfkCydw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Sun,  5 Jul 2026 09:47:57 -0400
Message-ID: <20260705134759.1722831-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705134759.1722831-1-sashal@kernel.org>
References: <2026070232-jet-sheep-e8a6@gregkh>
 <20260705134759.1722831-1-sashal@kernel.org>
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

