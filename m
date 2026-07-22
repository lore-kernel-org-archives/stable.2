Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9033938B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716237; cv=none; b=UFFxNh1k+q53LapZQbbaY8xFLVjXswYygl6tG03nun/xtutDPlvjtTVPDgRCz308OaYTzQHG769c0kBB7mRSAMOAg8PcMsZMNKgq9gT6DmPj4C3wn+bf1wi6YvZ+6pevpBhwQE7kpwIWfp81hKSeUtjJVqdH7Qr/fKWKIULSCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716237; c=relaxed/simple;
	bh=sYZgmQjEoB2hvC7VVELsFO3JyCfeijehVrDXIdFq7go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0JYwfrJeez2L5DGou7AKx4evd6jm1KeVELM25BBx8rNg/Vypk9cf+5nCJtXX3EDE0a9l71wTg/FJkacmHyzhtlx+R5Du0Ut9ZIfbgA1i0+R2Qh84kLsuutXAOMjNLEyj9jy7nRVr67LaG2Wbf0ukemULuA0zCYqQeJ3DzTa824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKJc2Qfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKJc2Qfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BAB1F00A3F;
	Wed, 22 Jul 2026 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716236;
	bh=Bzq36+KWF+zbJ8GnlXsdUMbjSy7mVPbkc9OgwnG4i1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKJc2QfoqhYetbuQ7Nl4wb59sGCea623M+h2rmQOlbrSRqJcwJmBiepgu/N2iAFxL
	 Vm48NDf3onk1JyJyUCE2USerse1vcEFZStvpkPbaEP8eeQVKSof0Upl5icxSu2k9UI
	 dJGOHzDwvZWVdzzOFkwhCG8ETdZRlX+oAV2Yspxf6FSoOb3PC2zTQKqahwpzkrkQ4M
	 xFy/FrTm9Nyzroe8ia8j4et0gRK1/c4ayZEbZAUuZN8Lp2gc6hGQOlql8pf4LrptGO
	 eBq/QvKDCc++Dkxr7uY3FjPF6FbzvRWlrZwu7mJ0zOgeZtWDfylcfbmQe7X0ARVO1y
	 iJHzCkqJEyVpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/7] i2c: core: fix adapter probe deferral loop
Date: Wed, 22 Jul 2026 06:30:28 -0400
Message-ID: <20260722103029.890864-7-sashal@kernel.org>
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
index 1c4afb30b29c42..9b2ce5b7adaedf 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1460,6 +1460,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1478,10 +1482,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

