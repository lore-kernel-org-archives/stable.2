Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792632612;
	b=gC8X90Xb9t73BrOKJtW+lz14GWYxL3sDsifsqfcs3q3fVZpUe7wlwRrgihhgpaJ3WKtb
	 JeRzpZs6yOg2rDSSSTkOB1KJ9aE4Y/Wwk7XoWiQxCvdLgHmCdP1KjLliT9hMbzdxNOEIr
	 7Zjp0+cDV8s8SeEzFpjCmPAAsf7QLVb6tNVh3HQl1eC+l0IFwTH3qe+61RqhoyKqjNKwz
	 qWsZ8eqPh8p3i0SnjmAJhaAqAysMRrvhIYUFGmFloskzzJPBSbyGb7rlNEdiKvcxdyYaK
	 kmnXIZfJh2TMNv0gORLDh/TWCCVJEQjTSpvUdMNc47pqzYGJPIPdGLUYjlbWpxC79xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8lciGfyDVUBWA1ZLjktvr8FMtyg/AzWFO1e7UFW+vnM=;
	b=KmTJHOej0y3PQfAaTLiaa3IXXIQ6HfX9YcgIRPvIY5u6cOdh3JdLTJwy2LNwVwc54/qd
	 s8PUoIc5rtwR6snkxdQn2Fuuy5lLDZtCq/yutf+GzLDZvfMdydRe2C/Pi7/WQrHCvZFoC
	 HZmbb6rDloibFl1huqY2o0uWpRoHBnu3CfykpMoj+ZUXQQSydcHpAJKl+/8/LjqV4oWzV
	 bPeej3bRySAaR0csFtxlBinIMSfSAZf++uz2gdCeMCQihf8u7qN/ULPGWnSKsHaPMJBTQ
	 pkfodHhIT3qzfkXpcmCYRsF/OEHrh9hSOjsyz2Dg07UTEAeBxLZQFia6GHqQ1GonioA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28RAX2N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1E606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28RAX2N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76481F000C1;
	Thu, 22 Oct 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792632611;
	bh=8lciGfyDVUBWA1ZLjktvr8FMtyg/AzWFO1e7UFW+vnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D28RAX2NjgQ79I+l2xhdTZmQJk1vAydnPqdRWuoU0ui3nwSGqGxwzuegYe7nANhMS
	 Q2T9QOGJmiG9WVRgtnLbotRsyxk0uZVuWdLoj3NYX8k2CQ+HXan0ZlZ+pED/RdQd3O
	 +DxtkpDjR1oDnsfMEgDwa0SYAO6s3q6QdXufcKQTOGz0XESuUy9udPgGaRw+1pYRRI
	 OfjNhE4RhBQwD0Nw1k2psdTkH4tfZCChfwL6VU0GTMi6nimY7LYwbdCvE2VUecORZL
	 es9Dvl/Se00eS0oLg40BKQMV13wj5b2hIBef6WcjquuHkFjRgWXu68vVe8CLrIPp0V
	 zPykWdU8ADj4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Wed, 21 Oct 2026 21:30:09 -0400
Message-ID: <20261022012948.692852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102101-diffusive-dawn-53e3@gregkh>
References: <2026102101-diffusive-dawn-53e3@gregkh>
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

[ Upstream commit aaabefc79b0ff0018e8e3832169bbe359d0551fc ]

In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
subsequent operation fails or when the module is unloaded, the clock
reference count is never decremented via clk_put(), leading to a
resource leak.

Switch to devm_clk_get() so that the clock is automatically managed
and released.

Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260916070631.1965713-1-vulab@iscas.ac.cn
[ sashal: adapted the change to the unrefactored driver using i2c_dev instead of i2c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-wmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 76118abc6e104..8682143e15acc 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -389,7 +389,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	i2c_dev->clk = of_clk_get(np, 0);
+	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
 		dev_err(&pdev->dev, "unable to request clock\n");
 		return PTR_ERR(i2c_dev->clk);
-- 
2.53.0

