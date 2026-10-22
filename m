Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668893;
	b=cw8FcNtPlWbixQ4im9VV8dCUUVIQskvuBn5cibZkT+1R1nZBI1Mbw1tHgObfWtn42Phg
	 7NnvaeX6taKbEoQGi5vw13uM6ukpLfOPg7VUEHJDxPLFM0f+HfV1VwgmEcC8LvlT2FQBr
	 Z7oeOZMoG3C2kHaGJZjw8YAies1WOJOvob1DoZnFnuqNuoG3xQQMsJVka4asLbHBbzmXr
	 Q1Gx+Ow8uzGW66S4zt2CFRXnS/2zqm8lzoUqB14gxeOj/AOxs4TIhACgH3QOHrnk4aO4b
	 4bGuuXx/fbUcU0Ntci+B5fXtvFVMQRROGTqfsqBUdEGjx9hJiNhXmi03gORhX/n5smA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X0jciOGA6mGDiPwvGrmn+MAYk1uG02Qws7rhgk7JY1Q=;
	b=GeltBXWpn6sRpThHzRjsPc6ZdPq0JYUxnQmqDUfHrygRgHMJVabpcJfnIbmnoDTMtKQH
	 sLWRiLgRJihJ2WW/IWorDyk8GvAkpIO9yPHmH3dT4zEKVGEhiy4wORL8cj0zuPi1iuhzv
	 +O+6TLrlTxtL39NZ78ZMZJflegxGLB0CzqjzzpxsxiVqcST/9DonqKXGTb1wXEMmU0pRi
	 gsBhbv2sl3cv6LaL7Ft8yo5nrpbEqN8fVAJTvoKfhQMif2twXIWXCaDD4OZuDfx8w1iFo
	 nStHmaRGFxQryDgsvy5PPiqe9t9lBfG65zW/WE9H7OPCac4gihatdZPS2ApJzuhfEvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7tzVbSD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75728606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7tzVbSD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D0A1F000C1;
	Thu, 22 Oct 2026 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668893;
	bh=X0jciOGA6mGDiPwvGrmn+MAYk1uG02Qws7rhgk7JY1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m7tzVbSDZfuZsJxQlwIr1jZlJbqoz8Le6pOXIUOH0XJEVnEQ+MRl2FjXbX4RgJbNK
	 WLq3NDq1v0+1JPR1arVwWmStaczUMIAHKoR1qg9cr7Oje6LCybKr5gRJ+9gdbrti/c
	 3NvBy/2M1CKpiifmCqqxHEdbqWmD3CxdEK0he1rykTgqXHTGbQEGbbTxqg64RoqGhB
	 EENZoP2RibbDBrNI9l2g47ZjtwGTpJvvPptxF213z1CRXlFgD9MH5s+zQLbBrq689Y
	 SqM42+I6LtcOtL9L4YxNFBkLA8owoHY0yhCz3QNBoynf12crIHgzxLWG+f5hEFTGTA
	 ZfgMNjPZfrrzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Thu, 22 Oct 2026 07:34:51 -0400
Message-ID: <20261022113410.917078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102101-sculpture-murmuring-9b82@gregkh>
References: <2026102101-sculpture-murmuring-9b82@gregkh>
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
[ sashal: Adapted i2c->clk to i2c_dev->clk within the existing error-handling context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-wmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 7d4bc87360793..a1716dddfca8e 100644
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

