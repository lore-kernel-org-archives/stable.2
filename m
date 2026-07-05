Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2672FE074
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278377; cv=none; b=idqWsa0Yxnrkv2x3t/dc1I0is5WRdn/lN3G/TUIZoJNZt5zfh3lBZnbz4rrlOBfS7KCuPmL1FOXsdwT20cfWBS80Nu0lHNxgXHd3y7WVgWmkCvjjYULd7lIzmt7pABnfqt9IDOMS9auC8xUe+ZXBkRABW0V2D6hQj3D7iuafPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278377; c=relaxed/simple;
	bh=1bmP06qdlOPYNQtpo2Ay8x1+V5UFSSdpHUwsch5fW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0fpgfUuVEh2EFbwmLL3eSnwnkwKgxZTWE8M5RsPSOjkxXzFk2uw2m7+CpuTXtyFuQIrfaxNn9Z/v88Y9egWpdERETpA9fn0K9zgplrBgTbQtkc9QA6mZmGk5HhorvIdi7Jx+hv6obzQOQJypyRd32lCkisqRBO1q18PSgTWNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Eixekz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Eixekz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F791F00A3A;
	Sun,  5 Jul 2026 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278376;
	bh=ri2ksZwSfkppbA2N9S8tVQDmt6rPqmrCwuSHtYplI2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4Eixekz48m+kN6pma9uZd+qNjvLnsgUnm4TkBRH58ZHqBWUfWh11I2c4tbKqBakq
	 CXuLkYQC2F9J7iD9jVhIxvwocyPsVpqhaZ0wBvvNNTHEwVr9JsCW1/nxWOLg4T/RCt
	 00GJGhjsUhpKQNo+7iJVj6aSa/+xZGUtvbK9MMVyWhNr9jED22qs8XZbn+p7iBDuEz
	 RrnMyLZ9PthUj7R3YwvzipqYu/Y8NgO9eAHb5OZhjmUTXPKbt02GBjaucs+Fx1v1Sr
	 gi5nawm403lxDhIW5mAMhy39HRiEPltCCE7ABfGAUK9zmzuV3jvckQxiw46Ont4MS1
	 zpQM9UhTbBQDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Sun,  5 Jul 2026 15:06:10 -0400
Message-ID: <20260705190612.1987801-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705190612.1987801-1-sashal@kernel.org>
References: <2026070233-lushly-episode-a47f@gregkh>
 <20260705190612.1987801-1-sashal@kernel.org>
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
index 8abd576d357b67..59b34d11f8bdae 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1462,7 +1462,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	res = of_i2c_setup_smbus_alert(adap);
@@ -1504,10 +1504,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
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

