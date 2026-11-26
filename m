Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713505;
	b=L5pKXR6unehi7WeOb5ZUWxSKY0swcTAgs512SUjEEy6ypO3KtZp/aX3/QmwX1J83zb9p
	 vtQI7gc1wfYsODoJVES9shW7ZmnXV7nw2L1krqNEvvDDZNuoi7d+N0K46QzlXU9KWYpX9
	 CHa/7o0SgcTgKA1YLGMwC0JbrvEMuF410j4eJjOGAUeOprzp24dZ6AqKfDJfyCXS5TBWA
	 ZXc//nJdJzFIAncmz2Oplfe3SBIFXZcUMIbkJhjGDyyHTwlhb/vNSimcmBr4fnGh9DAta
	 ucYI99pxfQcrJPWoGh5If5eGnbFxP+O8ZV9c6IBv6/hx1vFITapHEFhDFY6Bkfv3DKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9YRHUMdMTmjZwLWs1KhkV60CTCsq35FDQvmMobciHTs=;
	b=DV9waGkgWZ5+NTAyN9kUbGdf2etavUxCBcYWOfOxXxpOWCd1PW30QzSJjtNYSs5sVYz/
	 LpRY5NMqPLQzDOtbEDnppL+h1GknqIj6EAnpq94ZsAfCvmaZRwJyczNbMOOHG2jRUtS7h
	 lM4OI9nMCNv9u+eerJuejBiW+MWGpNWP1jSGq1rmBGftd3G8weIrBi+AtGIJSSZCoAJIS
	 wWLB2l2amZ+/aCom7NCA9VbRDhlgT1JomtbpUG2LHsM5IkULaV94GejAoH8ehZ/JVyI+A
	 8rNDnaStqxEGmZmt58TiiQdhnzJGQqxn5fKvUrAjGcmjvEzFYyfe8nDihLjMnlP97NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+yhfirz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47100606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+yhfirz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD81F000D1;
	Thu, 26 Nov 2026 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713504;
	bh=9YRHUMdMTmjZwLWs1KhkV60CTCsq35FDQvmMobciHTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+yhfirzYobj+4ER0SMYwy5x89nRYroi9vvSlmqsbEtF2vV9PAD4Qjw84JZ9JtEQG
	 q/GALsnMDGPyJ9J9RqTPTgOy9/t6JJ7KLkP8dmmQokHoJwCnT2Ozi7bTPjK9vAtGH3
	 Jbwnq+bhJ5uJX4iOWQe9GY5Elpfr7/dRR7rbo695k/UxzCBjhWq5nY+HS52dina2h2
	 Lx3gYc6ZWSQK5B1g7uUicgqq/BP0XdBJDr1LOuvBVT0qsSrb3U+qo7wdOPLZnQM2+x
	 H5wiDcBc04OqmTiewuaHARlS+/dsq8r8+tQzj7DP7Y9furhNYtPJEGGSpjNEbj7oCf
	 Ej1tZq5I95avg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: proximity: hx9023s: Allocate trigger before requesting IRQ
Date: Thu, 26 Nov 2026 12:18:22 -0500
Message-ID: <20261126171808.2738246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-mosaic-gigahertz-6594@gregkh>
References: <2026112511-mosaic-gigahertz-6594@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit bfa3b177d839bb303d0187335115b572a2644920 ]

An IRQ handler that already read trigger_enabled can poll data->trig
after buffer disable. Detaching the virtual IRQ does not join this
physical IRQ, and trigger deselection can drop the consumer reference.
Devres may then free the trigger before joining the handler.

Allocate the trigger before requesting the IRQ so devres joins the
handler before dropping the allocation reference.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Kept this tree's existing dev_err_probe() error return on IRQ request failure instead of upstream's plain return ret, while moving the IRQ request after trigger allocation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/proximity/hx9023s.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index e780373af2d6e..b0905cfc06d2d 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1053,14 +1053,6 @@ static int hx9023s_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "regcache sync failed\n");
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						hx9023s_irq_handler,
-						hx9023s_irq_thread_handler,
-						IRQF_ONESHOT,
-						"hx9023s_event", indio_dev);
-		if (ret)
-			return dev_err_probe(dev, ret, "irq request failed\n");
-
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
 						    iio_device_id(indio_dev));
@@ -1071,6 +1063,14 @@ static int hx9023s_probe(struct i2c_client *client)
 		data->trig->ops = &hx9023s_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
+		ret = devm_request_threaded_irq(dev, client->irq,
+						hx9023s_irq_handler,
+						hx9023s_irq_thread_handler,
+						IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "irq request failed\n");
+
 		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return dev_err_probe(dev, ret,
-- 
2.53.0

