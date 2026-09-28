Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0246F484
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584001; cv=none; b=o5/GDeEFDYPCAPDxULlpzDOUPcpP+XR0HfH5Vf3PvIWXrp45fSsO/CeYqusGxRUH2Jqx2wlbxI6z6kHxHOtnWZ6eAFr509vRC/Dhz3nmZC0cLZjUoll1+4GgtGUuXlvYO1eXh39B65wCSlsHKJErYx3/9Yhdbkw4YtlNtJUlzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584001; c=relaxed/simple;
	bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUnkXeFUppzg/OmXdjbSuvf0oON2UO5GDODKDKEhH1tJz1RT8cFVSPMUGD6A6aCthLv9w1z6p5TY+G3pB4raM7/EZCUTlCxn5BnlPaty3GfCYcF7djBi5K4kkO6VOr5LOnsikWhdIiQTSOBLhd/kquhjMl5KaI6o9lVitj22MiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NTDu6Qw8; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NTDu6Qw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583989; x=1790843189;
	bh=zOE/xhizi9/jAXNjhr878qhJ9pvevPWCdRYDdJUXczg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NTDu6Qw8bGoZOGwoxJifS+qzqMUIBygrTiRw2Ru1Rl5N28GQqDgAueS6/DIx9b0zx
	 L/Cl6pI3uJ3O791yqxd3/p9S8mEgubAso+NOpQGH1aMMx4rJK98EdPKC9e6qNxgnrV
	 nsaQ+i8isj4YOVJf9s2gEwliqqDO1LmYWYJL+4sE2LWYj4+3eFCPTa4iwnO2JDdHV8
	 zxA0sqLIyDASLAAsm6MkCnobphFL8aItbeJaR0+xX6XDITk7ct7lQquH6jx9rjpFkg
	 I2WSScPWGEL+nKWVlHR8n8yw2ndthx7xUuvON4g2GZ5DwdOnfi18iVjuC0mXfghJCl
	 NfFp9NwGQhdOg==
X-Pm-Submission-Id: 4htZCR2PRLz1DF4w
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:18 +0200
Subject: [PATCH v10 02/10] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-2-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=1204;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
 b=hW8GY8QUKVx4DKCL9nU/p3fhVjaQ36BWQAEmTL/kneYuZYusYvByhxM9Dp7cILHmYQGl6ptke
 cbi4odVoe1nCUd2Bu36B99n8326BntOr/vf4cpoSHolvP2R3twXsiVD
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

