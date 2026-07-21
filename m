Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1840587A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658484; cv=none; b=RZEGk/0DMd/1dUnmgLOdRA6tNkInCkJiHq+iLoLmUxHczeCKVXxBealn0mMupsq3w0AmZjqelMw6dcJ9gTD5qoWhzQVzYP/3MDSruUtxT7BxcRvUhnQTvqOpD3k7JiUXOCe3qpuYoNXXubyPkOzQOtHgPtdYtUcRslInAZSHErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658484; c=relaxed/simple;
	bh=UcA2GIgb6nLwcs9r4I36jYGJAxTmmnesArR2nF4tzCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRm8pay8O9NqIIouTXibwLQPNiaKEt+oUrDzsRAbUsrrccrfs0BwE5mxqYoSLj6cFSpsc7F9qB7SNPP5JFnHNgdqzlBXguPXGYyu77pRoYYZs+Lm32hEGDUaXsMSAzBhZXtZGu3Eh+oxaHOw2Fn7AFJwfDRO7VZ9fp6Ml2m3GFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLHA2ESn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLHA2ESn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3F31F00A3F;
	Tue, 21 Jul 2026 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658482;
	bh=GwucgIVE71b98vkhijoZfo/vwh4fJtT2yc+B+tFO+Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLHA2ESnOoHFpqCl8Z5afi5e4MYSgecRicuDige8+xwPe8c7kHUwVhoBuGHl5eNqS
	 H+xUiq/6iIsoW1zkotkpDmTjovPmM/V3cJBAf/4MUa8PC96O0eFfzfrhH5K8kbR8VN
	 l6DorcHrea/kiY72JRD2qoJzW3nnlSj27rK6HjnjZTtlTMryYL5nOuHro2KayGosbE
	 wqeO7otQPhQucSn6gU9qwHz4zqcDkE3uzJPnnDjuGYgmwc9gXyxMijeV68zF+tld/h
	 6s69OuuOngbXiN1/MkZX//hTAKMeshXl0BXdwtdt57cgCCdjAzEZSu39Xq2a6rWpsH
	 q9dxSQS5+wK9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 14:27:57 -0400
Message-ID: <20260721182758.332454-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721182758.332454-1-sashal@kernel.org>
References: <2026071636-amusing-conduit-3c6b@gregkh>
 <20260721182758.332454-1-sashal@kernel.org>
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

