Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641794;
	b=2+OV1JEorQOdiUTIDK4M7ni6LgHlEdZzJ2QF+CYEBvnMwnEJBWJ1+o4MSqDm2l9YL9Ec
	 hJgex7ZyliHtkCoj9234PvbBhcKRKNsZ4ZZyDGygv0apebG18at8H6nYvcdblgvKdTmFz
	 dMqJh5zKe3x2Sdf4aouS67oRMqdKc2OWP+QjgKCpA6DLGkt0+I/J008alHelfdqEY2Mme
	 YFY4eHp8n3e2j788c59XDzlmEzDdG/7LH2Cu2wKNkZYwsEayCw1u8BPTkqhPxvwzRtTAr
	 BDEPV1JTNrhMxekf8D6CK/qCIGhgL7F5CwVRrxK6WZ2WA5ig84ylKJzaln6cwVmO7ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OGdO3L63nCI7q7+xApxtEYnTUMkQ0WVMuyKVj5tRY8k=;
	b=oWfZa7iJ8NHQr2kFx+JCTZtlal+BjbauMMYhIkEdkGWbZkgGdjXiwBHTL9zWHYycwB+l
	 LllNm5qsrcT80suxvkrZkO1Tp6bBS+sVidIaH7mC3XXP5GaJQqFUznyy5medk11S08/0K
	 3olwu365diZ5wpMEVWpg73la4XCqz3EU5WCtfYhsahJSXdLJ3W86JzDyCpy6kZOZQSoaD
	 5deSqgC6SfO3rG7Mbjo++Eelr62TLLnrZhdU77H7HY9i7SprdmBVrwxD0EzuLMYE57jlv
	 bNSphnQuTyI+IMvt6UingSvXKvn092qnsOdtSjiYNPhGgpsk2FfX0lUgHe1lNW7XBAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixz9jMWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixz9jMWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D909E1F000C0;
	Wed, 25 Nov 2026 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795641793;
	bh=OGdO3L63nCI7q7+xApxtEYnTUMkQ0WVMuyKVj5tRY8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ixz9jMWjV9OnS42QWa305HulF1r4tRkXROL7DzBHfAtdublUWco4KR+mjwHispDxx
	 YZKGEswZeBfX6vacXFU8Z8cEwDX9KKaEal6AKYKYU6oMHzYCbMPEPsxn1xHeqZlUme
	 LxeS9hfuGM5H+jFMvUImGCPUr/V7JSf9643kgaLkpj2F/81sZOAjAbTVaqYDNHS3a2
	 KwgU9NAq/ad4TzMeKjlqAzaTq1asVLWwsMEQPTZAK6CILgsKbG9bUKJihlhJbGlKvm
	 t6CwjNesZTeVb+mF/zVGGJGCm0aw4MCgaAPHClA5f/pYm2HZq3X0PneSKo3PgFD/fA
	 ud4Ux2tnjBHhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 16:23:10 -0500
Message-ID: <20261125212303.1542971-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125212303.1542971-1-sashal@kernel.org>
References: <2026112517-octagon-dullness-c22c@gregkh>
 <20261125212303.1542971-1-sashal@kernel.org>
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
index af60639e69b25..4a90ef79cdca2 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -607,6 +607,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -614,6 +615,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {
-- 
2.53.0

