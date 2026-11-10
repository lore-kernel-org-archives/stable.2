Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313664;
	b=vXMl56LW/brhtMBmuL4XGzn3asfJE7uQ0TG3kczJMBdYAA2Qoeec8DohkZM2rRNuFAij
	 yc8tE4Sc7Qj8zsCW0I2h0t8xyQZE2m2zMonrjF+yp1AedNRf8Tz8aHuk69IM0sBoDoPAq
	 muz128je26IJaBf/jqqSQfu2o/JH4iq+7OLxBDco45Tq+9R9CZELS6sSy9gXZwyMtkpBf
	 muELKeWXtk1TEq+aNvfLzCLDUs/bYoVEJl4JjAm06RseI2qKugh7uPCUwKkjh6DzxJq8O
	 SIQK0T8u3sokg9TBEOZBJ5yARVUl5YoKcwJykY2LL+oiPiWDQgPIvqw70MOPFHidW3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cDbIr2cQbYnLjyQfWBIxZ5GU0Hz9uiVQ8wABVgV6aEo=;
	b=HMaQj2xlNBe1T/0pzBtVal5dJ/mAWc1oWyqvFajMUAx8fC+da/AfIIjmSu46Mau6Y9pZ
	 c8lsfTuBsusjAxwlB3v6IVzMMnxUZ6X0d65cotLTgFfjc9WItpJQGNmAszyq9Upv42TtS
	 cHILELfkje/Kt+tDWn+6dopGn1bX6PH5bWKE2AiE33hxZXJm11fJvwfBonA+DEI7VZXj2
	 KxdTs03fjqBU8NX1vYUQK6JZtT59NAOblkm687nXzOc1vws/WHBnnLZk3u/y6Y7/cRAGE
	 yNNqEWmO/uBzEE6Tn8BaRmE4/gtVxJ4LSnnarHE5i2VXCk1gCkTANxNgBURD0YhpSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZWkDH+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZWkDH+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B8D1F008A2;
	Tue, 10 Nov 2026 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313663;
	bh=cDbIr2cQbYnLjyQfWBIxZ5GU0Hz9uiVQ8wABVgV6aEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZWkDH+16aSdzH6BXHp8Fv7PT0LJcPfu7R1tKcciMBy15TuL/NSdkUFBy1LLK+AVi
	 Ij11mM9XY0Kw5DKu6VxIIzeRrXe3QngLE0YoyfkkWrLk2OgStHfraH0LZMgrqfmtKS
	 9Y/Fink8w/cHfu9AG2oY8Z+QwDSlwdKtDtL7LgWtP03MA8RS+Hz5OX4LpOLMMbMuJG
	 Ux/rSfMC5otzJrjwwelLiONfy20Y56T7L+1zdjDqXkiCtXwbIzjW4sGdncIH4G9jH/
	 IF4ti4LaGleuldmUJp+GK3sZ+c1kGCKEAZt3Svw2pxbGfY65UZ8S6MVFjzZMIUWtJa
	 Z+774PMUr84Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()
Date: Tue, 10 Nov 2026 07:27:41 -0500
Message-ID: <20261110122732.1208057-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122732.1208057-1-sashal@kernel.org>
References: <20261107060034-failed-5.15-082723fee626@kernel.org>
 <20261110122732.1208057-1-sashal@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 082723fee626532f176727b6438b666a96d5246c ]

of_slim_get_device() returns a device with an elevated reference count,
and wcd->slim_ifc_dev is intentionally kept for the codec lifetime on
success. However, all the failure paths of wcd9335_slim_status() return
without dropping that reference, leaking the SLIM interface device
whenever the register maps cannot be created or the codec fails to come
up.

Put the device on each of those error paths.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917164853.2163184-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 24c3d1c28a294..61da127dbe11e 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5208,25 +5208,32 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-	if (IS_ERR(wcd->regmap))
+	if (IS_ERR(wcd->regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->regmap),
 				     "Failed to allocate slim register map\n");
+	}
 
 	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
 						  &wcd9335_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap))
+	if (IS_ERR(wcd->if_regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
 				     "Failed to allocate ifc register map\n");
+	}
 
 	ret = wcd9335_bring_up(wcd);
 	if (ret) {
 		dev_err(dev, "Failed to bringup WCD9335\n");
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
 	}
 
 	ret = wcd9335_irq_init(wcd);
-	if (ret)
+	if (ret) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
+	}
 
 	wcd9335_probe(wcd);
 
-- 
2.53.0

