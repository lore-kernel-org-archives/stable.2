Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173023E008F;
	Tue, 25 Aug 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646500; cv=none; b=qPJIw34jiYM1opYZi/8c8wIdfmHUVt2/+XJhYBPPGH8xd17/2f4jGZlVt2nZBpCSsLKMG8OaGqGUkdQ/numVTd9SPTUHZ2KMGoiDaV8SXJ9SYGgE64Qe4Os3PejTqNtNOaAPHM6rOvvtYjt14gJL5FRA+PWjSL+T2RWJhTmvprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646500; c=relaxed/simple;
	bh=1z0WUiVnn2gL6zCBHOZj+zdKzGyMpC2Pb+E7fuMMRBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVRHCihwK67X/PH79QaGjgwW4RdPgeVcWhFCoVFEv52U2UbMJZjcRpdzYq+vP0PerDX4Jy1kM8cwIQcH8xIx1I7kKbXVNfdqZ33J3qxHeeykxtO5Lzx5R6ub08GgX0YH/ENSd44x6A+ochntg7k+30mtSK9kR58gn7lSczWPcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xj0Xvk7v; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xj0Xvk7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646491; x=1787905691;
	bh=G+moMU66xe+zRT76qfdaUjZtuqPx+W960mBLJAs2W2w=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xj0Xvk7vo0SpIGiwA2nuFP1Dr8ih0ccRjLK1RO/p38mDvPPtvgnGKBiOTi4LDApC1
	 LMmjw0aidaDyd4tVSNRjcUUgrYxg35TH5HHVM1072IeIMEAMAWbEQlxDcyqRgn9lt9
	 ZEoxZ8VmS/C6UvsPgYFGQLxv7folgjtc8PIPeohLH/tLQjnOylMsJIZOXqw3HHJR5u
	 1Ow6DGjBIugMzvFUPeUa9nP10J08nMRrI1s0OEi1TLXHT/budMwHYtZJQG42n4wxy2
	 Wy3EBgnNWAvMOdmgA6vWQQiqjoJ2pQDzgsSaNJf2hx8LT7xGF5yIBSAMOkYDuKx9k9
	 3dseUhtgrKC6A==
X-Pm-Submission-Id: 4hTgs61BWNz2Sd57
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:46 +0200
Subject: [PATCH v6 8/9] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-8-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
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
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646471; l=1149;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=1z0WUiVnn2gL6zCBHOZj+zdKzGyMpC2Pb+E7fuMMRBo=;
 b=r2DuqUSv5tCijZ2tk8Sj2yWbZg9aBRV+xN5e1OoEx90HTVRkyfMqJYfYRXP/sCL3fQ0pky41s
 CSkeiQwSZBFD5PBq0BugISza57bIwG0cP7yywr+uAIjnCBhfAmD9/zE
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

If mma8452_probe() fails in iio_device_register() or later, we could end up
with runtime suspend callback being called with a now freed device pointer.

Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9ae2c3e60576..4a1eb196589a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1743,7 +1743,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto free_irq;
+		goto runtime_suspend;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1754,6 +1754,10 @@ static int mma8452_probe(struct i2c_client *client)
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

