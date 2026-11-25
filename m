Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643182;
	b=i17HwLiJRBETmQt3nATz0VLZqi/IDHY8bSwzUIP+UP94EhOavcxFlu813nxMGjT7KTut
	 rBmc15Fp1J5yEvS2tvtHwy/cZEJw+qCdS4PWEMBYUhzuxtaoex2BAqglGe4Gzg4h9Q8JG
	 Qacg9kQF5H6Jbo+L3N2IQLGpzBuBHezJnoIgitPFRFHQMoE4+Ow8VVLQdg3iM2BsJ6Kat
	 9NTejCsdY6A+bJZFCG/lsQ8cHidzf1lgZ6Clo/dqkgS8BEftc7aP4EmouTTSHoobLEdh/
	 D1dtfA6BqptkjGaI0Omn67ie168TYNMFJDv+iDbJu0rKC0rOnF3Rh1rScTw58vx7ghA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jgtTNB/8bbocTfRhVHcEg1OfuIMzxpxcjTFT2Q4Biuk=;
	b=nvVpmG6MPbSdStdB89GKyG7i6LxOKWO+Ya77/J1qfWNzMcuxbSdqBWnepDNOHYB0YPkZ
	 Xhvp5IyY2uF1j67uwRY+0ovQ4GiPclfnj2JMwT19zrWHPHtraa3u0a1CzBlIAfzdRXAxC
	 hG0QNKUjRWZ1bpUHbj206y14i5xsK1LKTs0FZKf3tphDtTtXAe3X1+4r2DYQPGIaSLZlP
	 SSFNnBGU9sXTCQSxFaBdOpy2Q3C7dZOfUU/U7LBM9gk5NZFRjG4ZdWxub/iH1pJyNyKvp
	 d6xz1kGHoVgJ4t1Ttb/0Ow/sBQJ0qBaB6gVVL61rvHBCyX48YhAjkUbyQ9abYT7q90g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTw5+xvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F2606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTw5+xvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA311F000C4;
	Wed, 25 Nov 2026 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643182;
	bh=jgtTNB/8bbocTfRhVHcEg1OfuIMzxpxcjTFT2Q4Biuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTw5+xvLyofo95vcjNKBDyUBpOeuiVy91ZsCxSz+2mSj83/C/lwPQpthlTMG4Z7F6
	 fnLChHFkjkFvWHfczPCHzXzvgZqYcmkdLeubheKOgZEPASA26NXwzgJIp9jnPn5VfF
	 J9kxpurJJUD9fGL1u8twZVmEW6LdipgU4RqjNAFEre0Z9Qw/2EQ7M/t6M9F0UxHbSO
	 T3MXX7iIzOmCLAtyrBklsWqHtkRJPhmIPmkBP363c/hy7x41ewme52GS/g17zg273U
	 2N/YnxxVPHIGSQjFuq3N6awo6GEuSZ39glQKzOJCi7rR51AxDJtlCCl317BLEll2kZ
	 aXPKardoFoQ2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 16:46:19 -0500
Message-ID: <20261125214614.1571817-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125214614.1571817-1-sashal@kernel.org>
References: <2026112518-hefty-profanity-1c49@gregkh>
 <20261125214614.1571817-1-sashal@kernel.org>
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
index 8979e7358eedc..54ea31c1a6511 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -610,6 +610,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -617,6 +618,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {
-- 
2.53.0

