Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC235E1A0
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681455; cv=none; b=hTJa9ESuD3+BB9PArfpeT9L3b7SEk/QsTxGE4Jh8tiE0D/7XU5WhIeXw/4hT0Nw5fwNDcs6pY3lXlgOkysvpyXluB6U/549tA9q9uuU5bs02I5NObkBAIx840N1wRPdgDPD96++m7HgcP7rXsap+g9gloe4oATMRYedBWo63YTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681455; c=relaxed/simple;
	bh=xSBiqKEL76epL2Pc1g0NqgiCoxY1vFqhwiqr15betus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF9+Vdz58rxhcs+jSnYAkypIdXfFEghFlcR+1/YV7fBoNaDSyeV62DUif1ZPnebCrs4b9QCjSaDiEK4NixplZoN+ejKwx1LctUJHHUnqxrFd1ef2FNKfdnpIHfxyi4pd8ZHfpP1oYtv395suBnntITlKA6GzwmVL+wCL5ZY6C2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgrB3njw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgrB3njw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCC71F00ACF;
	Wed, 22 Jul 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681451;
	bh=oH7P+s1klW4QiX/3s23/QQPELPIyCTPlVz/r2NXaEOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgrB3njwxDgq2dq7IJR6z9W/otQRkAP2ZH9cy+jVYUf2lbnH99/GqYyHpL2t95/zN
	 ADqt9IqIZvfZRBk/xonN6YgIlGbOPA1UbWZq8jt6UslX1Qocc4upcEWCmOjkKHqlbE
	 7ORfn3p9VJaUzoDG+sZMkc1A4IzxLfEVqZVRPcdlEKvscHBCOmKV4qJWR9uuBXATrL
	 2MouorzpIvPFV93n9UhXDp+Z4OMNJbeu+FPM7FjOK4rg37fTPSkxhXeqClDLUCg17Z
	 sVcPa2pTh/JwU0Faxlw5gTWFtHMOpNHT/dtK00pqFS48KiaqsErZL76E5eIXLws724
	 vfSx0cVgVF5+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] i2c: core: fix adapter probe deferral loop
Date: Tue, 21 Jul 2026 20:50:46 -0400
Message-ID: <20260722005046.603973-5-sashal@kernel.org>
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

[ Upstream commit 158efa411c57111d87bf265a3776614f32d70007 ]

Drivers must not probe defer after having registered devices as that
will trigger a probe loop if the devices bind to a driver (cf. commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Move the recovery initialisation, where the GPIO lookup may fail, before
registering the adapter to prevent this.

Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
Cc: stable@vger.kernel.org	# 5.9
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index a4005dea21f054..f78ae38c7fd2c2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1553,6 +1553,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1573,10 +1577,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 #ifdef CONFIG_I2C_COMPAT
-- 
2.53.0

