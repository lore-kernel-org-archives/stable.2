Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9514137BF;
	Mon, 27 Jul 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158365; cv=none; b=MfV9+yva4xx+Nj4ujIpMPaDQcqvf/866eF04lI9rflsE2qs2+If4o2ZkYoKsIExDqmt+O03xBR/bD/rlrfFJ6y6tac/E04vlEWTlxqxrdMsu+SUC7rGjm17TJFsvMSj3Hc0oKIMXjUaP+XZ/+ddAji7thr43zFCtK3EJnnq7ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158365; c=relaxed/simple;
	bh=eSs17I3gI0a4kTGzSQjzniOZzuQNj3YU+5kAUZgohrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB0sUnNMDSo2bII4pclcqOYKxqrV9WHLxfQzKht2DRDjntUStt9K6fD73QBwp+UUh8FYv4uO9BDSJ+k5iYQJfq07QJeeRW6r7zuAbJXgyH5Lbo4odF6w1RzynCT0UhU7WWlH2ALoaWRHqANvI8g6/JrT5IiwfwibEzsqUwTwt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=cFaSMgY8; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=FwA6BcLZ; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="cFaSMgY8";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FwA6BcLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158359; bh=eSs17I3gI0a4kTGzSQjzniOZzuQNj3YU+5kAUZgohrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFaSMgY8MJVUuB22bMC0fMzmGcjsXuimAoX+yjYyj8aZTzyid+5scfTiTPngIl8bt
	 w4TuKJpdNN161n0Q2LpHxwKoL8FP0Oh82dK+AVFOPecuIBe+ztaNsdAnJpZQhk1jaA
	 iAwUkiDdo639jSCQnQHI54JOS3zutQ43X03NijTvDY/wTnB2vXrBecxOXB/GHCfHTK
	 qp7zVBRZW5Djs2Tw667AwWxpfxOJBMSmlhJUjP7fV2FuL7onidEMyILWBl9hpRG2f3
	 LXHX9NDNp/CUdyr0Fydh7kuaVSU28V0OJSLBZkg6mjB9OgLOCPhYvtXOiCBuGIA1N8
	 CkQ9wHoIK1t7A==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 5E47B42568; Mon, 27 Jul 2026 14:19:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158357; bh=eSs17I3gI0a4kTGzSQjzniOZzuQNj3YU+5kAUZgohrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwA6BcLZVQ884ht9BqiiKjjKp1UmdkCuqqFzzEbnjxrfb8gYed8A4AhRdXnGFb7KI
	 SqiGhFp9DMzqzM1gEhWtoWdhpnbBUt56BLP6nqFdXSsMhYxgKKqQ7eHNzjCHJTE1sB
	 yGAbFlpxttmexsnYz1FKtdLXrwslY/lw6Uyl7Kh8SYYYvPxiTxfsqtoQSH8b1WXcm7
	 CgDwedvDy92RkdDsBOjK4hd5SoQlAHd9LgMXiu04gOy9qs3XdFbdwTfnyA1Bm/b6Xl
	 e3KO1klW1xEKRWVTOXWWu7abn5vcoHcgtk1tFOG2MilpT5WOkUHXxGr6ytRNN4RVK3
	 GfvBm4GeoGE8Q==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id C897E42554;
	Mon, 27 Jul 2026 14:19:16 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/15] media: meson-ir-tx: Ensure probe error is propagated
Date: Mon, 27 Jul 2026 14:18:52 +0100
Message-ID: <45cb104675d7abe96dd3570d54f017bce7063be4.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_clk_get_enabled() may return -EPROBE_DEFER which needs to be
propagated else the probe will not be deferred, it will fail instead.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index abb107d19e8c..174d5135e1bb 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -290,7 +290,7 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 
 	clock = devm_clk_get_enabled(ir->dev, "xtal");
 	if (IS_ERR(clock))
-		return -ENODEV;
+		return PTR_ERR(clock);
 
 	*clk_nr = IRB_MOD_XTAL3_CLK;
 	ir->clk_rate = clk_get_rate(clock) / 3;
@@ -324,7 +324,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	ir->dev = dev;
 	ir->carrier = MIRTX_DEFAULT_CARRIER;
-- 
2.55.0

