Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777D46D2C3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663319; cv=none; b=K/FzCI6FU/jjoCxICZ4+hjhFrZrffX41oyHgMh3LLjOrOM1iTYaIaCL97HGeVMNIkDav8YjMjlV/l+4Kj5uitvn/DzTPcLiVMelV9gpSNV5ECq/q6cl4dUpYjkZ3bbJ07T74g+ZX8YwWYEaQ0od2Un62TxLPUj4cmvtJ7IZQga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663319; c=relaxed/simple;
	bh=JiE4Cw+SxDQbFsdaH1LPrxbW0mIR3lpqcavbWPltACM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEXf/FxE7L8tRAPxknghr2W7MBE7ME/Gr8e72NCNECAuccCS23axxpd+jlkVzXk2h+wGiUz55c2QLbCaJMewzifpdEPv2yzkyVNV94esuxnXNzRIkhb6LFiJN2akGBkEF1tyiKQSZQZCOqf+4Cuc/zwndChJSyis/oT234s7tNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp4dW9EA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp4dW9EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D61F00AC4;
	Tue, 21 Jul 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663318;
	bh=KLq2tYzHKZeTGA2u/KwooopPvCg+41VjXthFVfYOIkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mp4dW9EALJBwN6BKrv/dh2TjD+bx8zVvZ+8yWf0UpI4DE9ziOP3GCef7aQtBGr8eg
	 Q99+Fxt0/0cJXrWNhN9Kjq6+vfi3eiggpcIvMGgGd7J0GqBlnp7vHoDc96b4wFBwTM
	 ycpaPEDTaYDVwn3VIM8dRv/Z29qVidyEDqxUYzuOwUleVJ1gFwWqDUkAfiGA9OiUBD
	 5vyKHdltSXe8JNctKlVT/m6GEevHG637hzTbmF4PUjwsM5T5gldt4NRdUMmgDKVDZ1
	 OzPKWPIrbc/2jSSMf7QL9Ibb2nvRl5U8wmkXrIpP7KZ2f7k6uVZ2mLy4uOdE2UwKiL
	 1+AdAVdNTJf9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Tue, 21 Jul 2026 15:48:32 -0400
Message-ID: <20260721194833.416799-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721194833.416799-1-sashal@kernel.org>
References: <2026071656-confess-dean-8762@gregkh>
 <20260721194833.416799-1-sashal@kernel.org>
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
index 9e6cd1942e201d..739d9d8cce2216 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,8 +1562,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1603,10 +1602,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
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

