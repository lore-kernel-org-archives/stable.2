Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CA4503F1;
	Wed, 16 Sep 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546191; cv=none; b=ERCfqESv8ENA/J9f7evhPZBpMp95z1rIEeq0Av3klu8hDNreP0qcshDS+l48XP0G0YRhY+oo56VB3KN54kMcY/sGNnEHWih4vtU/ADgPv+coYQqYT/nfUswVr3W73EOHrUM/WaIa785sUDeyxJwJMaOH9EzH77mhAl94CXdCDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546191; c=relaxed/simple;
	bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si2ukkPkURYaUxeWIbfO6eAC2mrlVIvlzFNwaQLMP2GXiZTVrBpCjV6wwcGm26Ls4fTRZH3eBXQf1LZw7s96wZWjr17eiq+OECOwtJtXjubPRQ102W/SD7vBEx5KJWP97jjenQifBYnorTguLEDKRmnhl2UzOeM33QayrztHmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mTe40gpC; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mTe40gpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546164; x=1789805364;
	bh=zOE/xhizi9/jAXNjhr878qhJ9pvevPWCdRYDdJUXczg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mTe40gpCsFwjDlXKk1V4xGvJ6ezlsbvtBUGg1i0rD84HkSwTks3dfv8Bm8hI7PgpG
	 rvzuQ+/WdRWelFkTM41vb3Z7kRPx3NGAlH56lafHkpX7CI+uBrhbOtrc684IPl4Ngu
	 j0ynWDjwfTURQgBDmroIFdRRb+X3bkua/pidO/kxe1Zw8O2R1WIuYF8SIN4CYDFAUV
	 I6gDDEzfOAxXUdNf/MvdWPx5xGAxjY29oOWIh8YzKRTbpcab2xfjo0JwROpa1nbMK5
	 xTeAp7d6DZeh6gzgGstkuBBeBShxz9G+lhBA8p2Ya/WW/B5SPqRZEAt+EIbDPW+aC+
	 CsDqwl4RyMZFA==
X-Pm-Submission-Id: 4hlBPG2rcXz2ScPL
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:07:58 +0200
Subject: [PATCH v9 02/10] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-2-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=1204;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
 b=AnhOLZlnnsjC9TEsu4H44Gr+JFYy10C6rPUBbLciYyup55qtYEXW6A3S3zMbQ8kWayrSoEFQ/
 fVwVunhD6TUD1/1wwWblD6QQUXkmJ41eBdS6hWMccvYMgm/fGxe+i87
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

If mma8452_probe() fails in iio_device_register() or later, we could end up
with runtime suspend callback being called with a now freed device pointer.

Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index fe62a903f0e2..a937cbd84f30 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1681,7 +1681,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto free_irq;
+		goto runtime_suspend;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1692,6 +1692,10 @@ static int mma8452_probe(struct i2c_client *client)
 unregister_device:
 	iio_device_unregister(indio_dev);
 
+runtime_suspend:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
 free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);

-- 
2.55.0

