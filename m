Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673688;
	b=KgZLX6/LCrJIcvvrCg8JjbzXneVmLuVtyBVzbtrqmUyX8VttYMkZYROuu8jZeDeoIzVm
	 3/mNUpkaflFIv8tKwxwbH4JEwNnO0V4rCjKBNdupI5nHiLgydRz6l1rtS1NwywbLUfYz5
	 JaO72GW/vP6TLnoqi0uENsxAgXGiXyYXHtFoKTfX90nZmBzuo/E4obL2YTGzOVsMoLNiw
	 +giXoyIu65ulQ5o7xnB1M6TvwLIs9TNI4B4EOLldixwaRX3ISWujQYmGNHLaA0xWkS/CP
	 IPXPNwfhjRCRefdpk7G/wUaHOTtf2Voa1OQEmW6IFRspqPa2spBhYXfSbsg+Z0lonKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4/tx/ZYqiTB0UDMu9m8ijFVpagIOPtZNAU0MTOcfHzw=;
	b=38yEFm62upjJpfIY9sp7a7keQwHMver2+QjsTKZqro9d5tJrJEn26sdAOMXWjj82GRu/
	 EzgiPVvfIegapR4dnyE+6K9MAD0/gfTkwN7Qeb9wRJ4s3mwTN+Sv/h84JzA2bclu2RH24
	 o5lAbHWjbSiMFXgpP3SFu5AdMqIZPLHW4cajf3MrmOTRFMe3kyr42/PJkCFA2O82yDUiW
	 ZyuHv/c3My5vZE9fSe7c1wdCknDQk3cvmCQ+5o68OnmEoYSv5pZKX3xdBp3zVWVOUEkjw
	 fOkraNzM7u8XSZMay7k5tYZgq1MpaUSP5QnLYU0IItk+Ptob8qHdUrLuI4GuaiXQfnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYHUnHyO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C2606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYHUnHyO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027A21F000C1;
	Thu, 22 Oct 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673687;
	bh=4/tx/ZYqiTB0UDMu9m8ijFVpagIOPtZNAU0MTOcfHzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYHUnHyOCtOLcAKdqWDeh3NQM5ql5dagZBoCdl/QEyDeiX++zc1JUOPdEWsiY0xhE
	 c07x4F4e2VSUzoWPcVJZ/0YvKu6hGxJ4qGTuG7OWuAI8CDRgo4hxCXnuOGiVMWR3/T
	 qa0iXuQlJdDP84ogqqoIqPDcAiuQ+HfOxALsHOJZrODSb5Mm4OII4t6SIxjP7GzwiS
	 zyDjuCxdn3pfsGId6PI2jMS08TQ6RYDcCiT/zDxVoZbrxEcC97s3lGFWP016l3ad/d
	 D+sy7GoUmGpgfWdYhxiB4v5IaN302Cfubg/XdwsXTJ5cY0JzNLL5+Oy760/Y4fH3N6
	 lwMFmigNS4j/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Thu, 22 Oct 2026 08:54:45 -0400
Message-ID: <20261022125417.1187808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102102-unafraid-triumph-de54@gregkh>
References: <2026102102-unafraid-triumph-de54@gregkh>
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
[ sashal: adapted the clock assignment to use i2c_dev instead of i2c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-wmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 88f5aafdce5b4..33d085e564f57 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -391,7 +391,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	i2c_dev->clk = of_clk_get(np, 0);
+	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
 		dev_err(&pdev->dev, "unable to request clock\n");
 		return PTR_ERR(i2c_dev->clk);
-- 
2.53.0

