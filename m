Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8525A359
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221122; cv=none; b=dmI/Wl5QwqgPS7U2lRAlxRZQl/FJCHbIXRKbG5ZIt0Ml9nt0HveA8D8o9OGatqQ5O1u4c2wAvobpIN3Z6akpYzRQjM5WNQsiSvG+HyWnZrhzrI5kSYEj/uXuyGKX7RscZcBMLH+wOwmsO/pFkMcA77/kH4gOjy34nuWMmylYNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221122; c=relaxed/simple;
	bh=C2xRQepKDPTr4V0DO6+zDCaZz533qMzfROCEvs+OZSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UI0EPv+7DhKTHg+Qm/oD2aloy121rP0ilZiAXEGcsqlh/YO9w7JkzFepkP26pA+160CZ/cg2alXD4e6WWGPHP4MZJjYGdmHtL+amtiTMoMbUJk71mvckaePyGNJTvw9oDFZt6o5Nk6Jbav4ipNLGg1VXMPxpk5JC8vT6IChGK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkO8Gz4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkO8Gz4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFEB1F000E9;
	Sun,  5 Jul 2026 03:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221120;
	bh=S2JHku0LDuH5L1/QRreFQYMyaMkzBtZtB7nSsd4hPgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkO8Gz4eoj8uOuG4KhH5XWYsNXYkkKnfvs3mguIRemsJxOgJ+6iLkKuS+WagfJ4G7
	 JBO2FSmPddpi4d1QeeMJdpe+ooPd2DoiXg9bwy7eBWXR6QsTTWzb6GVhr/FU8/YeX0
	 TIrpfSo5u+H5gIlUCxFlQwboxja4kRrXAxovFbHBxRIVsQoGVLHQZdPlb0z1Kigt/y
	 FZHMQGdtEvIwhCHNm9I2Lk3ZZ+UxmjCYhW0h+N8QuJo8coNIGgLpv2XUSoQ1/ccypM
	 v8icddCNvEMF86K7/ug+quapJaNFnD2g/KZixnX3UWyHNcXiXc+LraqfqfMQhjkVEo
	 T5X+Pbe/Mlxhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Sat,  4 Jul 2026 23:11:54 -0400
Message-ID: <20260705031156.1601242-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031156.1601242-1-sashal@kernel.org>
References: <2026070232-straddle-keenness-fbbc@gregkh>
 <20260705031156.1601242-1-sashal@kernel.org>
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
index 14f09576bf5fc5..afa51e3e6b5b08 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1552,7 +1552,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1598,10 +1598,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

