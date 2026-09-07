Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126874F6486
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792697; cv=none; b=kzfoz34q+LZxRDIsH7cS/yy9MNBfnoLmLiPKRIoH5QfZdjq9BFIV39/IJ4ey8ARZWTsu7Ka9visVWrAXK7ERxh2jd5w3zQ6+9o83XwQhRePak4MqeDhJQmhmuUZ/KCctTneNgh53L/Pr/6VLLgmbAHo1ga+AgrTmVYYBfXbBB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792697; c=relaxed/simple;
	bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgOVzA/o+cBduKYFz9wxr38cDgNeQ66fK1BhcpUb1mGef52pFHrvN4LUNx9ZaSd6XNrc7igAdNBffRQrzeVoqJZy/jU2hQVgSxyYlKOELs7lftHFTC1rvDSSfm5P6dJdWtL4BXcNCHLQyo8DhYssXc4NfWUXw0cFNwMg4s/Yylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=PqU4aRMZ; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="PqU4aRMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792675; x=1789051875;
	bh=zOE/xhizi9/jAXNjhr878qhJ9pvevPWCdRYDdJUXczg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PqU4aRMZZUPSE/h5PfLqlt6nHBY6QAWuP4oFzOstDeZkKTOwv4t6ch8vjUBTHE1sD
	 57LwOI9vEKFfIK3+y3ZjC4dQR8e9Utm4GOQ3qOWXHsOQT4OP45yI+K4jImpPXVyXiS
	 Gbrx3jw01gzvN8GxbQsW0MFctogmcojLLlr7MUktmEZBeoYKGRvJBYsch6kXH2hMjY
	 SvpZFumEkTCzy23lKe89cn3i3Ci5NyQdKvN5tLmL57KLHkVK+39fZiTqslmoAP9Qxk
	 gHT4yQah6LUTSxjN5JMr0DGF4WuGNDXdeOX8BFjo79BuD1TiqAcrdw+i1+hAkbe6je
	 p5v+Ae6/YZL/A==
X-Pm-Submission-Id: 4hdql42T6Jz1DFGT
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:50:57 +0200
Subject: [PATCH v8 2/9] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-2-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=1204;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=5aHhFmRHH7hXWezUncCFq6AliuOuzN9v+On7qJIecuQ=;
 b=tUwM07OBNBaUq8CnaH0j0TKVCSIhrdYPShQmZYg4zmm5bh9TUKvxco+tUDPd5d/MIGZI9wkof
 JGyzXt8o/zgD4HVnVXLiX5isbvXyIjtdQ+bItpkcRVFUykKk4lN+Udw
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

