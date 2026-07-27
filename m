Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A55412C17;
	Mon, 27 Jul 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158364; cv=none; b=GxXywwQaiUsEDhs/M3SsynWgTub843yjhkv0rW25s1tJaZHHyhYcQlryq027/wA0r26JOAp8Gcn03wYes8W8ALmjePDzb+7H1MHwfEC5ioH9SYGTaUWF8iNVIuIwuLzzjSc+5X4p7zrl/IIyTjf9vd0LeAzC2GZAt03kUwMdBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158364; c=relaxed/simple;
	bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNu1GMLohlPZ6zLt5Uz/Bn9xkWa4EliTQUmPdXNCgz5U67vJnsx6vTmSfRgiLApieyPSY0YJi6EUob8Rk2d2m8CtWhHfa4Nt2mCJkk2Ch2oUltmCJfOpkXJ7TqrNXaMUK7SKajj7K/h51uSzqPkYGPvXPwPBaGF5F5leWXDfAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=NBO13QEF; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=sqLKFpzz; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="NBO13QEF";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="sqLKFpzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158359; bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBO13QEFh+k6zczRAMOOmz7lCaC6OenD450tMBboSC1PeS3OV0Txb4O+FgomajDN3
	 da/poHVAM34FRmWYpKbim+DSec8VLGwak0bAGQrQ/cmpFYUom9iXFs7jw5xMSzU6kU
	 hFnn87fyGMlnmMJ2g1yQxRUoTWV3bOt1UU6wn6Ck5HhoPWMUKESPE4nXezhteFH4ZQ
	 nStu0WwGkxg/b8iF/5adH0MJPaouCtDJ8LSTPnBqOh9TYi6AYFwqc2bRMy5KyH81Wu
	 xu/9xsIDh4zS98F9+mt0LIhGLD5thg9OUR8mc818WN+5lhf8Ihp0ZSUSmTPQ7hHhxO
	 XTayijD9hIdQQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 4306042560; Mon, 27 Jul 2026 14:19:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158357; bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqLKFpzz60rxBi+jIKGo9Ns40U/RV9l+WkcLahd3wlii1dAf2R0nFJfTGh6Ad/Axt
	 vjy5kl3zwsNe5Uz/A80lTnN6VMM4lwBzbSgmB8rHXXFkQRf5ZWDsfjS4/PlOqRymft
	 vg1484ZoPuCoZFQ+rf2QZBJArPriU3P6ktEoMyphiESRcuewjYmQVQvVKgtK1j3NaX
	 zhmAeljayJZZl5ltWEX1oXAe8PWOCWWveWtvp0NOH3eBugYrmpNX9AlJwzv1v8p/rU
	 nHdWHbzljKQ22XJE3WusZI/dPNvNxbFm9XVumanOToT4hqqgWH7KjFWeEnvsE1cJe5
	 0bYe5xMkle5/w==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 7C6924252E;
	Mon, 27 Jul 2026 14:19:17 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Guoxiong Yan <yanguoxiong@huawei.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/15] media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
Date: Mon, 27 Jul 2026 14:18:53 +0100
Message-ID: <dec62fda5dff04bc573f6aacdf645365a8f87096.1785158244.git.sean@mess.org>
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

Once the interrupt handler is enabled, priv->rdev can be used. Ensure
it is setup correctly so there is no race condition.

Fixes: a84fcdaa9058 ("[media] rc: Introduce hix5hd2 IR transmitter driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/ir-hix5hd2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 1b061e4a3dcf..aa3de4d57a58 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -316,6 +316,9 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto clkerr;
 
+	priv->rdev = rdev;
+	priv->dev = dev;
+
 	if (devm_request_irq(dev, priv->irq, hix5hd2_ir_rx_interrupt,
 			     0, pdev->name, priv) < 0) {
 		dev_err(dev, "IRQ %d register failed\n", priv->irq);
@@ -323,8 +326,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 		goto regerr;
 	}
 
-	priv->rdev = rdev;
-	priv->dev = dev;
 	platform_set_drvdata(pdev, priv);
 
 	return ret;
-- 
2.55.0

