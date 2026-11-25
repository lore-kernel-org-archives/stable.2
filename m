Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639768;
	b=JGV7j0kytzAUo36qKGbVoOBe8wtwoYZGN2LoNmzpu2woOt2KQiahNTqGPN8C/zNGQ3x4
	 /Kv25LBP/5Bn2ti9Qy3HGw8nQ83/NBXcS50Jf8dVylLeGYHAGXWvxvZhoZHu35jUG0Ybs
	 7aHqRlSo+N9UdHvd89qe5w6T/zg3Sv00/ih50z3HS9m1n3TC3ri3V9kV/0/eLy6a7vwh/
	 wVmsV/QwlpF9dRNRA4HEi3vijeYYTYRfgtCV2gnyXKSksA1qi2FqEZVOpkPK7ObqgcyvM
	 DEEmVTutXQRc5mgfAebCOJcd6n49A58ziO2/Y1dB8y4ewpkzsuTSz5IPfhy9YWOxkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VUdp+RPlljA0BcKKW77S4pZbKvj4xFDKJ9r2p9aqrng=;
	b=owKwXWJDdSU8DNPj2YkkgUpgPHeO5NqHra3klFFzPfjCNNd0Y1shBpxpdEmyBlINl/mN
	 yWLEtHV2bIM295WvfrXPKqH1Pw1WlQb0Nsc+pN3aRBf+3RjafGUB9f/TpLs1KlQsJEoL/
	 xpHDVcd5RBgBzpwE8KA8u2bxB7x8/ha117Baz7Mcx7sq7FmE55PTL+LmTekAeBiQMydW8
	 MwoXGm/YCj2yD+oX/7Ih2uuBFCnGlS9gL6UvB0jJ+CiaPH93Yq7YTZ+ERfE5SmcJ6dMIn
	 rivfCINWANnXhljmrBPLf4x0nIxz37taqvQ6jE/2N4WJyxCp0o8nhEWIhr7FNPLXjng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyDEDlAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61161606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyDEDlAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562D31F000D0;
	Wed, 25 Nov 2026 20:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639767;
	bh=VUdp+RPlljA0BcKKW77S4pZbKvj4xFDKJ9r2p9aqrng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MyDEDlAXo/EaZA+hX2akif7ludRioM37aEwQHGVKXmPDwuvWz09fjL2leT4kbBVf5
	 /DbbfTvLMZ6zLn23XyuquUl8FYrwLlApOS6Cpmiw0er2m/WeJhguhPeAv190K7d8Ib
	 rUIIdsjmWarZsN6pWkoApnXyNOPrV9iK63MROMRyXb0gaqwhJnXibtDGWOOYMC21DL
	 v5bbnpzgecHKQCkinwoThx/dNtp9Jz/3mMnrk9JrFb92LhwEL2QX7pa8taMxf6lBN/
	 pNbwqwsPj8+2s83tXxE7aWXkEJ+ndyWEuZOggikP1D1+D4I3NKkjem8joEEqmgbKiY
	 +ArbqCAOjCDgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 15:49:25 -0500
Message-ID: <20261125204919.1453286-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125204919.1453286-1-sashal@kernel.org>
References: <2026112516-citation-stage-72ea@gregkh>
 <20261125204919.1453286-1-sashal@kernel.org>
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
index 267e6d5bacd0d..92ce02441cc99 100644
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

