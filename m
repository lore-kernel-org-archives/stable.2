Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640278;
	b=Vs7WdgDz4pUHNgmRk9GeCV82awULvt8PW+U/2t444sqSD3dOQPmLxwW/Wex6cacxwZpK
	 nJHsYIlRhns/tF0dsyI5/Dk+GSSgal5GZNOiJKoJ/G9SPH1knFGXBt6F20DXRKneQb6Nh
	 wbdJLRLazXr3+6FJOPiqznUbfd5wxCUrfr0qllaRiEOnkm6WmaE6gZ9ppcUPKzxM5hhSb
	 4S4FNxXIvoPTpYhremWBg0Cr2jCig8Q/7piCip2AKwig3FdfWtZYM+4mbOy5C84hdhiRS
	 Ukob4bZJ7W6LCMr3Y8Ou70i3LW5quE04wzfrXhGeNMAIdotilMhzfk0JS+3AFr4MiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0fHFsvN2r9JRKrVU8dgdAvCfrmYLKDeiOUe92I2uAU8=;
	b=s+cvdnKrlhupbUCfsPXrlmURa7Z/ve8G73X8I/GnD1uvbXMLf6GQtIXdtH2vk+LAzbJz
	 EERbnjRgfE/qIwZ+Pf5qDUDv8YEqvv+TqiHU6pnllG1eEfWVWjKcLtEhITXW2w2PpBC8j
	 7J4hRRXZ/2jLdBzjSaF6nfEcuThhCf5q6pR70cHdK1gOsxBACOo+AmxgQSyN7GcIi34UK
	 HORQDM/Dz2X5xNytkMOMmPcVtISjtkI+VCyuNa+1aH33X5dBKlnqglRGeTOt8Vtmip7GO
	 xddW59QnNUbj2gol7GLZIisyyakrVsehy4avWXO9mS/udGuBI+E/K8YBGhXop2XBYjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELHHIP6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA4606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELHHIP6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2741F000C6;
	Wed, 25 Nov 2026 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640277;
	bh=0fHFsvN2r9JRKrVU8dgdAvCfrmYLKDeiOUe92I2uAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELHHIP6IJadLjWkVczuWuPEQfmSeZ9SBLrngFSi6mSl/aXpadaBnzn47FDCGbW87R
	 mRDLDdBcVCObdFlDU5XznzBNtq2WRHN1vrXwq4hiXNWT6G1zEocA8+V3pMbtLwaQ9G
	 juNDOagJc8tbH2lMEqMqdNvwgiXPiLzGqtRhDQC19TrY0+923sSUceRGQGLnti60+6
	 Zt5SvUToZtiN/9EKYMsba42noudktt09yWudIqnpzEUh0Rp+njYgBhTpIgUUx4Kaa5
	 LgEwdXZAonPF+1Mn9T6nJpeqEGkG/D10Ce0IuabY+ROLLvqxpIzYjWjoe5PqTN1l9W
	 WHdQgAKPhGG0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 15:57:54 -0500
Message-ID: <20261125205747.1491649-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125205747.1491649-1-sashal@kernel.org>
References: <2026112517-rival-mantis-1c17@gregkh>
 <20261125205747.1491649-1-sashal@kernel.org>
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

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 42269cdb3d3b46ba6e80f31d0e00d0bdcff1d8d4 ]

mvebu_gpio_write_level_mask() is called with a raw spinlock taken but
the underlying regmap uses a standard spinlock which can sleep on
RT_PREEMPT kernels. Add the .use_raw_spinlock attribute to the
appropriate regmap config.

Cc: stable@vger.kernel.org
Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
Fixes: 4d305c227312 ("gpio: mvebu: name regmaps to fix debugfs collisions")
Closes: https://sashiko.dev/#/bug/linux-6bee0c4f-384c-494c-868e-07c420195d13
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20261109-gpio-mvebu-sleeping-while-atomic-v2-1-41f070421e70@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index aa2484a8d8af4..7ad2b1fe95d5e 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -610,6 +611,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {
-- 
2.53.0

