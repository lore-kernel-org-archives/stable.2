Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD69275AEB
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259283; cv=none; b=HIDYruOkY0CqE9ASAqQhPBcvQQ8UQc04dbfXEa6AgWjxX3AxkyWs8qcjeZSwD7OSkDNlVBYUvr2P4lQpqZQZ7OCZQwpQGsknIhqey4pjYLn7V/2beUuZC6vkF/GGsXDmglr9y22Ct6qlbuRHWKb552lQxmzU7pVqzne7yB0eF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259283; c=relaxed/simple;
	bh=J4gaM/jFmfhUvbDwYUj4j8MMbr61QcfEyoo9fungOL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1SPImpkVSOJnYgoc1SjWXY5RTYBv9QseJY5dtPWdSv0zpf1R/nXEGlXcdV/tXWQrQExe7rSld1PL7h3Ift9h1qXFqMyuvx2NNolgHypaFtrtgNMiwWRkMw1q1tMv4vVPG0wLj+e1kws257B85iPbk5GMBvxoP3ys5GJx/FHRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5Mf+uHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5Mf+uHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3571F000E9;
	Sun,  5 Jul 2026 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259281;
	bh=pMTN4Dr75E4vr0VUwXfxoE0FHtUde5XyC3Ur3ytrtJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M5Mf+uHlK2iGHS9uQcoY/1+Gt7gQ22clC85TgX0FoCOmpPSie6Mo6afcwDwx/SgVw
	 GxvooLxW27mQgpyfYYhkHo0Tz9v3xwGWasSg8QNBv3qSa0EQKQbYaSiC7xvrDohCK7
	 uzgHGZL1M3psewGu0glfBeQFTzcbuqmttAoqQRH16qdApeuc5qs8n2DBtKI3NPPqIs
	 KtJxXP6l2mqzt5Inpq68ydvGMkOZZE4FOgq51q+nuad5VjWz46yBLa1Kqilwr/D90m
	 VtMIV6WPvOUQq0Ds1AOPG5bbW/XrLNBGub+k3wV+EBLzxw8kVSZLz/SoOeUzNKaetg
	 S7g9UFdTmE1kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Sun,  5 Jul 2026 09:47:55 -0400
Message-ID: <20260705134759.1722831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070232-jet-sheep-e8a6@gregkh>
References: <2026070232-jet-sheep-e8a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8ce19524e4cc2462685f596a6402fbd8fb984ab2 ]

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f7e3fc0b3a1daa..e639c679d2737e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1556,7 +1556,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1604,6 +1604,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0

