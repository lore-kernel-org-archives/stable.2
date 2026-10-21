Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618587;
	b=fqJGYhs/cnByA0CxrnpQfN0q4XuuSyq2nhRY+xfqV0KKegEgtg8qUivDl/Efq1yabzf9
	 4bZuKmz/503GUwta91bxNfZNzCsQ6e7MbkGz72DGR6ZqIPu9siYlRZxNlTx2/npFw4UCZ
	 13GediJ6VNOMkGIvsJNdBZGzQmv8fpMSYS/Nw9ujZ+RTVUgRcwcnigp4/lOYQdiG1ZhAn
	 hoWXGj5n0EkiPF/jCf+wmX9YAVxljcZcFhM0xBGdf+tmr9bmGTKUzD1cmEQEWwIRKUY5y
	 kzadKNwy9CxGOMZgftT2v8GEvySrjPO/9BCiJi0WFEeekasmqpfMVPb7Nd/nwlTf9Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pO0eQnTXtXtgELvzEwELbztqoU2D56FgS8ACZO2T9zY=;
	b=cv1CiNwSF2ODiVZVfWtNIRwvhtrEMJ9PlFqh1Yu/zut3b/ap0Ew87C2acHBRkur/Jth8
	 j7hPiyQ6wohu4e3v5MqWcFp4+Y2usq8ks2Xd4Occ/Dn5zS4cMfewwpf8gv1zhmOPeRzDZ
	 OorGCmuiInWWikpzVnFEeTHwKIh4z/AJSYDU3Rve8H5BnbPF9jqxUuqnVk/14CMevuTEc
	 c+3BJ0wANvZsR5sdYB1aVIQVF4ivrz+NIc4qpQeuo/vnQL8/MyK1M7L0UPnm4D1QM4rYp
	 n5KB5BsUCDlONNchAfJu7m0wGo9iWdslUtWdnp3QVAxIqLqLM8zuAPsCs2dwwU0FW1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfrtnpGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C8606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfrtnpGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24531F000C2;
	Wed, 21 Oct 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618587;
	bh=pO0eQnTXtXtgELvzEwELbztqoU2D56FgS8ACZO2T9zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfrtnpGZ9BcE2AhkwuPB1azVtz2IpIoiuuLnGjCHo8Hqz4pd9xmDejARGGcZfNn4D
	 GKl7TZOT0zPRzcyXxSI5BN0ORN6Z7NVMNuqr8i7ItFa6L9PyVwThFx7J6jrKX0KuuE
	 wLOg12/D7HSAGf14wIalWVLImBZAwJvKNYb+yxwZtNOjrQMUvJa3aCQm90OBcZ6WyL
	 iq+DhG7E+U1SWzwj1lQPCYJgL9VArTE6iCjZbQKAlgXa3YuqpOiBI1HZtiqb2NpcMV
	 t3GLkTn9HJPhw7SAf7RCUiQnufyQsHxxAUUS+AFEChIW5K73bEgUKeYevijq/TtgUY
	 bbea1HqBee/NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enrico Zanda <e.zanda1@gmail.com>,
	Andi Shyti <andi@smida.it>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] i2c: viai2c-wmt: Replace dev_err() with dev_err_probe() in probe function
Date: Wed, 21 Oct 2026 17:36:24 -0400
Message-ID: <20261021213611.464346-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102101-rebirth-zealous-7d04@gregkh>
References: <2026102101-rebirth-zealous-7d04@gregkh>
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

From: Enrico Zanda <e.zanda1@gmail.com>

[ Upstream commit 3b7d8d151a7ebebc5257766110c102ab173b5844 ]

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Link: https://lore.kernel.org/r/20250513210246.528370-2-e.zanda1@gmail.com
Signed-off-by: Andi Shyti <andi@smida.it>
Stable-dep-of: aaabefc79b0f ("i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-viai2c-wmt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index 3415683dab91c..133dc41fe387b 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -44,16 +44,13 @@ static int wmt_i2c_reset_hardware(struct viai2c *i2c)
 	int err;
 
 	err = clk_prepare_enable(i2c->clk);
-	if (err) {
-		dev_err(i2c->dev, "failed to enable clock\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(i2c->dev, err, "failed to enable clock\n");
 
 	err = clk_set_rate(i2c->clk, 20000000);
 	if (err) {
-		dev_err(i2c->dev, "failed to set clock = 20Mhz\n");
 		clk_disable_unprepare(i2c->clk);
-		return err;
+		return dev_err_probe(i2c->dev, err, "failed to set clock = 20Mhz\n");
 	}
 
 	writew(0, i2c->base + VIAI2C_REG_CR);
@@ -121,10 +118,9 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 				"failed to request irq %i\n", i2c->irq);
 
 	i2c->clk = of_clk_get(np, 0);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&pdev->dev, "unable to request clock\n");
-		return PTR_ERR(i2c->clk);
-	}
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+				     "unable to request clock\n");
 
 	err = of_property_read_u32(np, "clock-frequency", &clk_rate);
 	if (!err && clk_rate == I2C_MAX_FAST_MODE_FREQ)
@@ -139,10 +135,8 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 	adap->dev.of_node = pdev->dev.of_node;
 
 	err = wmt_i2c_reset_hardware(i2c);
-	if (err) {
-		dev_err(&pdev->dev, "error initializing hardware\n");
+	if (err)
 		return err;
-	}
 
 	err = i2c_add_adapter(adap);
 	if (err)
-- 
2.53.0

