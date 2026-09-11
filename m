Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFB3ABD88
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092849; cv=none; b=mMlOl+n8PQ4pL2p4JXAsHLblYMCRakBoP6MTkmts73OiJaRYe8ZLmNMoSHGWYayZkOTPERoCySUqAG8Id8p6I9GLQQ2ZvHtdKiskLxUzwqx4dXswdCzmS2M4IrqdruCKgx8TVvzifqM+TY2bRpquwtG+CqWQtJtgm4em/G6j/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092849; c=relaxed/simple;
	bh=zj1oTPKLxympaGY3rMhUWW+F4nP1AriNt92Sq2qC6Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsGnQzP0ViBXGzSJTrljYFutmTg8CrxaOOrtEjQFCWJ4QBT8VdISvbf3GpiBzAultd+oTYfnJ/ym0Kr3FkJGBmKUUVP2flTauly1gZvAXR47aa4ObUEJu++H/fEJMe62aAOsUf+Avrd6SVcPtNScnt2u8RJdj5hwAR/Xdt4bVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMujAtCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMujAtCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5521F000FF;
	Fri, 11 Sep 2026 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789092847;
	bh=fPvV10Y8dPUlW5HNDZneRY1k/WFGkBrDcIvkMl9CEDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMujAtCzCm/nRyWd2kQn76wGjTQmP9QtAodPbev+6Zqi5+YoNcFdZImpLNan20mtb
	 os04e0mTd2UGwmXzzQ+IcufmpvdLtVLcYqixcE8wLsy5Gym7CXc9EnulmapWXIvZlA
	 N9gt3r5zHgemKwkTLtcu28/ndGeXmWVzBWt0NJRrv+4d6JFLroeLLBqNmxKCPn9hcG
	 VZXlvd3QARQoPvc9wF/evuelRugDpsAHx9qXK/jpMYPnnG+WReiq++A59aM3P+HPrt
	 YZ0m6z5fDwfFmgdZsjzudphl6wv6nDO1ZfbNv+V0eEj4FLc60bg4/r1dsy+WwaNdyK
	 12VFFTw8iubuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: pressure: dps310: fix NULL pointer dereference on ACPI probe
Date: Thu, 10 Sep 2026 22:14:05 -0400
Message-ID: <20260911021405.42692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090922-unread-confused-555a@gregkh>
References: <2026090922-unread-confused-555a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rupesh Majhi <zoone.rupert@gmail.com>

[ Upstream commit 26e9213898fc949923188ef0aeea31fc87708836 ]

When the device is enumerated through its ACPI HID (IFX3100),
i2c_client_get_device_id() returns NULL: the ACPI-derived client name
does not match the driver's i2c_device_id table. dps310_probe() then
dereferences that NULL pointer in "iio->name = id->name" and crashes the
kernel during probe.

The IIO device name is always "dps310", so set it directly and drop the
now-unused device-id lookup.

Fixes: 72ff282819d0 ("iio: pressure: dps310: Add ACPI HID table")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 519fcd425b6a3..0057e14a45ddc 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -843,7 +843,7 @@ static int dps310_probe(struct i2c_client *client,
 	data->client = client;
 	mutex_init(&data->lock);
 
-	iio->name = id->name;
+	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
-- 
2.53.0

