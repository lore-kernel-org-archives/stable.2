Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239F43302F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663320; cv=none; b=hISj3tpGYVuUk7kNa3Ulm5wcIGdkVaPV8h/hrOkwcZ0QNIcpFvnQj/AQKw7HmDvQnSfPjaEXsRWXzkbCbacYYe1NWPDLIeKvp8Sm+D7kyN36j4acti/PbDODPJvwFp/+WkA/SPD15VtbbRb4cbq3cQ6S5Tvgo+CN30qa53Jqfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663320; c=relaxed/simple;
	bh=k7l2pCNhy8P8YKzKiMnW0SLWxugvg5dTrrNaq53gP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICTcZucpwRDi1N1RPkoiF/4EEv6g+ECWg9amkXDhOEzf2kXmBqutCAbAjzc6rFQLYCWPnOGYEHSSwlEAoFRZQvB/PPJEk1imkqh4bB7bi1oz+TXxI6DrXr0pWU5aMvS/KZoZ/x3KbBDJ9fXG31szQbCATBjLpn1GOSHQoxsS+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt4rd0NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt4rd0NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9761F00A3A;
	Tue, 21 Jul 2026 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663318;
	bh=4Uv+tn3T4XAPMZXM1NjCDzF56JloQSSUwcPMgnLEk0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dt4rd0NCMkLuDMGWeCy56KeURoTGbEWgXHMh/CVkwBhaMZqUkZm4c9A+abFsTSiRP
	 aqCMbJz6Kd7WDarD9iTUFB9C7aLVaQsuKgo3KUDXaItdOAviO8kqIY+DH6Y/fB7CKP
	 DvG0jl0h+NeyaJ50PzTxkFTu54e09weHJT5xlncmk0ejTBs1j2k8l6iIg2ek7pW+2o
	 DVPJfQuKior/CyB48zheDFwmXo3Ax9ZY/9SCRhUOryqvIoKl0ZtPYTOE7H08CLQvYG
	 EE/Psna6X78LazkCz1Rukn21yFXM/USE5Ds6MrvCg3/zo48eqZzOP5xLJSnCdvj81K
	 zKrS6n5s61NoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] i2c: core: fix adapter probe deferral loop
Date: Tue, 21 Jul 2026 15:48:33 -0400
Message-ID: <20260721194833.416799-5-sashal@kernel.org>
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
index 739d9d8cce2216..73f0f3b7b5987c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1550,6 +1550,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1571,10 +1575,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

