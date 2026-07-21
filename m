Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263C476078
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678331; cv=none; b=krhtdcuJ5bEn0bN98/JtLmH1I2YgVLuHee1sRkM6tmDHeFGHSwGLCEd6k+lmffhqjmgzoZYWZAIvffZVH3Ev8XVHlgeXXtXxNc0OCebK/q3JAIxflHjkeEfUvobVpnbkia1c9bMzqSVFGedrFQDQhvYstV45tU3D6PzvbAVv3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678331; c=relaxed/simple;
	bh=yphffioGIE2brTsneXPxwZyKcq2t2T+sffybcqs7QfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYfl8lhSDhzzDBIL5X5237sCxuQ9UsBlK91NO3VwaqU3cFDjUM27AX4tNMrLU5tKusGsuv54S1jNQ/vax4yJBAuItv2h04LZ/tQBdLIKgUjw4GSyHZblZsvAizUTdoQKcuQSOrBKVXvFqQcZD2tY3Afth6yAr6XOBTWrowy8c4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHBzd6Ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHBzd6Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097DB1F00AC4;
	Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678329;
	bh=yxvsKd100HTCG320yGGnvTcGszkHCq20oC+xfsgMTLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHBzd6RaK3AgCfXpFtUksTwhZ6WuHnMQHfxDjl8FBsDZugUKmdUv44csGF6csKYAA
	 HJCP9ap3k16jpPQ8lx8DOhLSVhd288RC8fVULXyfYj24aqd7bb9JytxcGpkZMbGeT1
	 1/mHsVgxxwidzi5gZs5zMGhqnQ0Cf+oBQmKI/R8roABBBTNkZb9c+FRq/aLAHN17hW
	 fiGjdyEQF8KgdwWiYdYm2NYOl0GGF9gAdxAI3GCLGuvumg56jIP8OPNIOHZEYNPZVg
	 DsxNLQls1rKs/UJmVTYTzOgEcIJsj7joHSSQeeap4s4cMptm7unAGjVtPS4+ae0N/X
	 e4HPiDre1zOXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] i2c: core: fix adapter probe deferral loop
Date: Tue, 21 Jul 2026 19:58:44 -0400
Message-ID: <20260721235844.523900-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721235844.523900-1-sashal@kernel.org>
References: <2026071656-trivial-state-54ad@gregkh>
 <20260721235844.523900-1-sashal@kernel.org>
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
index e82607643ebfb4..dd1b6d8779e210 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1555,6 +1555,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1576,10 +1580,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

