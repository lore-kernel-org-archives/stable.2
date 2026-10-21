Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618588;
	b=cmDY0CZQSnCYIw+4Y/+Jv/qK5+Z0EiKFHheH6rZELSw+7QNYmYDEkSA1EfEIeEg1At+1
	 hJfk8F0eTPiZMX2xNz+ngSR9GBXwBLl02zxcSGSDY1XLkuCzFT9fAje0A/dEvmZtibZWg
	 rIVaUxeibQvOPWTcRIJU9kjF6Iq23/ov7yqKCBCMslyKm3sq51xnVJs8p7xEYHX6dZgTv
	 KK6TY1yXmoRovScqihek2DHtTzc9hRe+1ujb9KTqgYW4BYkx3SGWn7R9yAZLF8GYR56Am
	 H964Kxf5vd1TrxqwqU3sKVB2nkF0N5MuQrrfeTSKYJ02QUsB1zigDVdTYfvU7CY856A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mQZ6kO5kF5iP/GV5yLDaTH/FFcbyLZoXVZ1UBqWAlBs=;
	b=QjP7/IeQR9m8XM/Guv0N79oFIiq4yddJH1nVvrEFk9FnhoWD5j2bIaextmcbMQPKUqNe
	 qTYXKroLesT5e51LaCW22SWoVbtekpgrWRd+Qo9EMbZ4+/i5VQy6SgYKhXeB/I/8DsQNe
	 1sulXaFyaWBMluTfsYl2dEZo/WNlYhnKg3JfzVoygwS358GtlWsvC2QL8iQW0uAcxjSog
	 Sm9WWb3TeFqSfT8VHHxRiPtnu+lEPT2dhQUgIbPSxP+hFMe+VoTBDxWGIUrijK5U4livY
	 2Dq9deXP4B5rnQWbFUr5/9Qodg0eKvZRQ2inkeKPJlyeElGK+8HIX85/zOHSp5QLVCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idTVXl1h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F2606A321
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idTVXl1h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7181F000C7;
	Wed, 21 Oct 2026 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618588;
	bh=mQZ6kO5kF5iP/GV5yLDaTH/FFcbyLZoXVZ1UBqWAlBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idTVXl1hk4TiclYlUfjGLgr9xU3qBILn03x7i4AbidDfBnAtVmrrvOzJIqW2Gwctg
	 lJ1KDX11w2dU9Ew/u39srRYSCNfLvFV7leaqWwlNm/yZ8KVGYRiv5AbJGmTG/EdXBe
	 wNXAX+hl+yBC9mUQQJM8k41Nn3dcAGP/tRohu+KlNESvaI5uZG5dy2VJ5QmHTBd03s
	 E+XcLYp6Q7md5TtTKhEwOjdJPbFDn9761Vo2mn9PJgqGh5JrIJ8Uw0z+GeZljHdVBV
	 IyxmSoI30ZTfg1dMDxCmiLgNkNpd6perdQm+LFXPovL7AKA5Z8BKaMK0C8+6i4pepL
	 XVOi+pe/Fr1Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Wed, 21 Oct 2026 17:36:25 -0400
Message-ID: <20261021213611.464346-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021213611.464346-1-sashal@kernel.org>
References: <2026102101-rebirth-zealous-7d04@gregkh>
 <20261021213611.464346-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-viai2c-wmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index 133dc41fe387b..029473ef3fc50 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				"failed to request irq %i\n", i2c->irq);
 
-	i2c->clk = of_clk_get(np, 0);
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "unable to request clock\n");
-- 
2.53.0

