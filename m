Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A633154425
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716236; cv=none; b=Y7fqRbSLFl4mbWV/F5HUwOFInkEM0qC6/cQCylSAkn7Zjyry0i4u8LFtm9nmhGsFvCOFT6hS/Nhbh61fWadtP+6Cw3iySEQV4nC28wCJbEkZ5df+SwsImTcMoJeRV4Iq9NCYlPsvclVIx3ETbpcRPnZhF5KAF0K76vmWsbTJ350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716236; c=relaxed/simple;
	bh=iGVvWAwOU2FtHs49WaxhnDBcWuY2+bMAp9rSI2ivgVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbS+75GycAYxRw8iPPO7ufEndIJHd5FTcZqVNDJ97xcdrtfTJ1bVyDfOLvlffQJrlimLmjCF71kE4xRyK0NSnie8LtAh3D2dkQfwD4ucMOrCulndHvieGyQW6c6BBA1zGwQrhnt/9uIx/OPARjXhDkxWDaRYRq7oWbcSOGrHxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhSW+KPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhSW+KPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF061F000E9;
	Wed, 22 Jul 2026 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716235;
	bh=4Dh2Hm7K8TSCMxCQkc4OKAtgGukOyu3B32o2eXfABmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhSW+KPmj/fPbE1rXXJoXfY2AtVP+ZaP0xwDJ8j79Nda1qtUwid5QRQiVdiSQX5LX
	 sXtQuq/o5T11zn7NYS64+qf0OzZMJcVt15k4F1TmjHFbL2TxF1AbL0KkBV8gMLddOI
	 PwpL75clUWdwha/3+oSY8b/PiADfxI+uMQpWhBOBUI3Oagq2ZXyoZxrlZcJF6uewvO
	 UMJ8+WtrvWfK1HxDPRZkAF2i2LjjaXxq1wUgZ3gkuFLeijHMZJD2NtvoyaNYRYlpUi
	 v18tQaeUxGPl5QuNG7U/1vzMkLrEVKsD208rdmds0I2wI08Wb/Ga1cExP2kd5G9YzB
	 RyBbCfmVZFiJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] i2c: core: fix NULL-deref on adapter registration failure
Date: Wed, 22 Jul 2026 06:30:27 -0400
Message-ID: <20260722103029.890864-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722103029.890864-1-sashal@kernel.org>
References: <2026071657-book-manhandle-a0e6@gregkh>
 <20260722103029.890864-1-sashal@kernel.org>
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
index 04fbbe35b9ffd0..1c4afb30b29c42 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1471,8 +1471,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	res = i2c_setup_smbus_alert(adap);
@@ -1509,10 +1508,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	return 0;
 
 out_reg:
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

