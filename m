Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713011;
	b=qdagyDZXEdwOLiPCBHyvbt89gHrKDNlVojTtNvd+WxJX9kAqDwbcM9yznVhy8J7jqRUY
	 dWBr7E9n5BDkLMq7bi0d44P9obCsb25EYqYM+RxGblzHgalUh6f9LroRn4XvdFctuV9a/
	 Jua+1ptBTw47B/DWSOT3kSVQiV8VReBScJyz5qwoMqHyGKXlHVyUvF4QQA3GKQ9+AuIT7
	 t/lUu9bGScFZhxqK4tZcCBZQSJYKa3SZqoKDxIt2/LdbfPqR6P3PyCuXNNXCdjycvJSRg
	 /+3k4mk0tmmlnGJ4zs1CXs4w80GxXPN50+JT8bdMc5j5nB74FLapVMVMSKzy5+Rg00w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/TQAxZWvGiTXODZv0TJVdIOqvRSbPp1Br6DGJpZcNJE=;
	b=RdITju7lFvMI5+3CfZZkWKoqCHrCNDpoLE8Qd4mnNIiy8OQ9Bp/0gKNqA8dvi59yq7vc
	 g14PlSQ2i8gSXvXVsuSvWoBxGgeh1fEcT5clvbrtJKwEGcv0M92kIQrOtjU+kATafp/bE
	 KoPxsaM/Po7sgSopGvXQfuaorMN5x++V3TUkbd+N5IRPON4k0o12zFwoaAglhWpTKk5HA
	 ig7euG6DiveoHnZYXTiRr+cfpGHB5a9GxVLedbWBEJm0g0oKbNb83F5tb3uMGeduFzOTH
	 uoH1hyFiT6FLLS/olp1SNBFGtoYUcmUN/0jrW8yQzQEKrn1FXPIbM+0+uSjVn7JbfAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5+DNyI1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A0606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5+DNyI1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B11F000D0;
	Thu, 26 Nov 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713011;
	bh=/TQAxZWvGiTXODZv0TJVdIOqvRSbPp1Br6DGJpZcNJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5+DNyI1MWT5z4iuHWINn/T4CNrnS0a6S5BlxqTqez7AcsbNw6mrdQG+PTVf9pMup
	 5FR6475mmEKFGj7Er4gqF9v6KTFgqSpqgJnaBwuE3zsibppstLd0O189T4doRG7EiX
	 UA76CCErQ+v94sdgLRDhYwX7MZ9E31oicWFqMI3WxDTyvM6g2/we6QsyrU844P6nqz
	 pUTna5igLqfG1JoAE2QMLxsOE7F1LK1KHYuq9Cal9QR7ijQnjVPSpw5YpTNIYdq9al
	 /ffAFyx/D+DgIYEIwlaILNjbCVsr3DPbr6mNg+YPCgThTxgBHNFaftw4fzLCBA8c3M
	 Yz41KzS3HBJMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: proximity: hx9023s: Allocate trigger before requesting IRQ
Date: Thu, 26 Nov 2026 12:10:07 -0500
Message-ID: <20261126171001.2690575-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126171001.2690575-1-sashal@kernel.org>
References: <2026112510-rhyme-sizable-422b@gregkh>
 <20261126171001.2690575-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/proximity/hx9023s.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8488b9a751f2c..1fba29265bfd5 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1131,14 +1131,6 @@ static int hx9023s_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "reg config failed\n");
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						hx9023s_irq_handler,
-						hx9023s_irq_thread_handler,
-						IRQF_ONESHOT,
-						"hx9023s_event", indio_dev);
-		if (ret)
-			return ret;
-
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
 						    iio_device_id(indio_dev));
@@ -1148,6 +1140,14 @@ static int hx9023s_probe(struct i2c_client *client)
 		data->trig->ops = &hx9023s_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
+		ret = devm_request_threaded_irq(dev, client->irq,
+						hx9023s_irq_handler,
+						hx9023s_irq_thread_handler,
+						IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return dev_err_probe(dev, ret,
-- 
2.53.0

