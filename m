Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678161;
	b=vdDRgYKiCyJAe9gEgPPkEaz4lM17il2X/KU0NKBv24Gc7Y0LwqW3eZwD7VvBvTVZUyTn
	 vxuMGWNhbiSY37OsvGqGTY3kHBiNWBdhHAAdC5zHnn4oUVplSAtOUEbVGcm8/lrsAP4V+
	 YOLmutu0LlSrrui6J1aSpWIxWMIpkDQDFDJ68jYhnUTbt50HsshRrlLo3xFh5X9JBPsET
	 PMuucVw1+bDaAmwSny8JcpMukPB1FzsI0WZmkVV8pVfr/hjN0cWpN+vrsMiHFtDY/qOkN
	 Ai/8kpfJ1fLxHfYkUhSsd5DAW5rct6xj8VFul+vv9bq+iLul5bwAL4de5D0/EQ1lDfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=adIJoqJlZFXmmVgpXHI3xnAlL71xIICcwP25wlWdzbs=;
	b=scF1n/FGvlWT19xS9QR4nUBKSawmwiGybgNlna1dpLrJ4rxxNoFDKnP4/HCZNBYgvsJt
	 v2q2iJiRmxl8doPNR87ILijW06RuYPfMgqDE8zZQ0bMINRy1VDbqy2cp5NIl0OkpV6Yl0
	 LPRw+35BjEvOXc3hVZayBhVtmJ2Yfpj2FQpK1wJZm7zF1iueJSD61kU5xRNKuQ0rQvdob
	 323gPDxGTh1GT5cAa8cKhladIpkG9GcQu29+Hc/fJ4Q8ET46W2k/zfPzz3ypOJyBkDpVK
	 owG4C3Wa4pQ6RBanhXdu/BnOjev8vIGJyMlkLkqqAP6oB6/NIPr/HCAzZ1dcEcJmzpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX9nxgYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06061606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX9nxgYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2336D1F000C2;
	Thu, 22 Oct 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678160;
	bh=adIJoqJlZFXmmVgpXHI3xnAlL71xIICcwP25wlWdzbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cX9nxgYPkH3wvct5+ZCBI6PDROWcmfIaxaewZSHgjjavWadVqoAY4g/tE9KSYSw3W
	 Gavh3y3cauG8dDdhX+gdUl7c9skRIQFkzPvj15ROEOcPOVNXKoVjqKTRahnJsobrUf
	 5oQRzgFRMPy+vIZ8q9XwdCdHJbXGBB4Am+l4oh39bcG59tJsZQ/CEefepQ9lZx07y6
	 3R3EjIc95CAwUCbDST2VIttPbELEZEcdXqKgUmqhjCi2LGA8NlbnxXfuUhM4i9vQpK
	 puJ1NQsYul0Peg77fLCmHBuw/Y8jx8Ijh9rvL3dmITQobUcnsfE0dpLNHSKoGXM4dF
	 OxnMXki1C43og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Thu, 22 Oct 2026 10:09:18 -0400
Message-ID: <20261022140849.1443380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102102-plasma-vividly-b482@gregkh>
References: <2026102102-plasma-vividly-b482@gregkh>
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
[ sashal: adapted i2c->clk references to i2c_dev->clk ]
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

