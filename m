Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278989;
	b=Q+VfRAaWyPV1PNenOZVkkjjM8vk7BGs5AKyBYTyaCD1q6YYYi4gQtqEUduIj6WvjLF8m
	 p/w5izAmnicLcqoahyiX6XsV9GffUXlMfy8sPrN6MmffYJ3zmx7zkbkG50GP9bq6AkR+e
	 cGmDSTMSuIF6y0OGPdN7xf/95ixXD0W71x5FfG9qIMS8j3FjcCezWgyT+7IU0pufB+/Mx
	 38dSxrftCxdL1fFKj8w+MOCVHqJJikJrzqei2skpIqq0QF1fUuMZG6aG4gxLqYI/IYS+w
	 2UiiX0at2oEm+50eFWMYycvGNcNGdEvZYGL/pesOmQS7KblkUPOnNYgfuxYiVLAKhGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EvBivEDjpkSHzrK4UmoCXbUGbkSDodyK5JPhjs2MDNA=;
	b=LCDKsGtZMkfsM85YtKcLFu7EwW3oxwLnbINkQn0+AkI93RIt8uPok0NkSnh8MprdGv78
	 +L/xMLBafhteCcVxYU1iuLpSkAIQEKZrWwLz5Bzas8e3vRP19toVq1Z7NY2myxFdpu5Qk
	 Zau/sAbv1lVy3N3/e/OAGGcIulBSdUlF+/h+riO5+Ja7KAIQy1rkoCKLA20E+vWTF8k1j
	 me5OfUTflchwYyMMROukjSj+Hw8tIlte0p+nr4TCBUn4A51ubAE9/XT7UIWiHvngCYnjU
	 /cAFDakiNxocxLyWNi0X8tfyfsryZVA0eE3dLypsH+NGiaRQZywE5XH60wjS3TXog5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1I47bXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864E606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1I47bXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA51F008A3;
	Tue, 10 Nov 2026 02:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278989;
	bh=EvBivEDjpkSHzrK4UmoCXbUGbkSDodyK5JPhjs2MDNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f1I47bXbGWWTuLJ2f/dO03JqMklj3imYFr2UuTcR2O+Qw9GkYIZ1g0sBY2pNIM5MN
	 MoSaW3eM7buK4OkSdzp0GLm+Nb0+h6kalT23yD82ZbTjtATgSk2YrYFznZ/eeLz5+Z
	 JR1U3qojhfnpz0CtDTCtXhHnbQK1N9NJ9VSY1yPo6vqDk/HnI9Qree6CRsqEfj2kuL
	 oSSJ/zqyh16oqluBOo8huNhf2lwQPS4ISOhdhJj3iFZJVFmETMpO/QJx8vD/1NSN+F
	 SsbDN/JJOYid2JAbCO7kiZJSOQPvxHe8dHXEVDo0vzwdP175lzHxHsnuZXsELoOeME
	 9H9KoFXUOyNDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] media: meson-ir-tx: Ensure rc_free_device() is called on unbind
Date: Mon,  9 Nov 2026 21:49:45 -0500
Message-ID: <20261110024931.3828324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110024931.3828324-1-sashal@kernel.org>
References: <20261107052820-failed-6.6-32999b8a9d5c@kernel.org>
 <20261110024931.3828324-1-sashal@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit 32999b8a9d5c4f497c9739e70ac4ee390cd650a7 ]

Make rc_dev devm managed.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 94208f76bb33a..2824e2c69ac38 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -349,7 +349,7 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "irq request failed\n");
 
-	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
+	rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW_TX);
 	if (!rc)
 		return -ENOMEM;
 
@@ -362,10 +362,8 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
 
 	ret = devm_rc_register_device(dev, rc);
-	if (ret < 0) {
-		rc_free_device(rc);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
-	}
 
 	return 0;
 }
-- 
2.53.0

