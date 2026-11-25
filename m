Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640850;
	b=xue6YWytGs2EDwaEWtcFbXvrUjaNZyskmHysaB0Y7d2icCQQYHjamAwabhCeTSdH09Dj
	 PrPtNKhQTaSqDsizKFsCRLBNfVO+h7ZWlJxCLbexRCtmLI7c688ZuoB4PVErqdeAysuuJ
	 +gtZY3NrwL7xA6PY6o/oTuTL8o01rhfkGGHY9ORkoKD416rr6TcQkCuJPGxIOniWIJBoG
	 P05tb4xCyQjpCFksM8SOt6TR5jLzbslTh8buQllnR80zkGumDsIIDy1JD6NGYtrpHADOU
	 TS2rCduNdOWKgRQaN9nzaM5tWKHyt9h7T9wPgS/bUKbTnAfXgLdTjlCICGfAdQMNAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3iDqTzdlLZkLysluTW1KQAYS5n0EkSspojxZ3zDv/H4=;
	b=Li6lfZJ8sJv6did5/nzFnrdMi/+hjKwlrj44CaDghMLXzjLmAlbNOulCV+88Qh260jbl
	 WdFAyrJX2mn8aXBq9ZmvPoWl9cUjS+K8Ya9+N4mJ5yP5xNZSLRzBkTp1QXaBVOTxiBVPi
	 NGe4EmCpvbJGkgBgEH1jqAhlvyVy0+cgs9fYlVDWoxZ1Ya4HHGHcwz2WSMTjxVgdskMBC
	 gydW0EeMFa/typ+UUrHxxi9ISK3Qp8EphDlgm/QTQNT6Pn5D69yE9mQsxvRQ4KC4fyKvl
	 ycMbhFLl7wYJ8UXJd6rW65sqj5nKs42NYnLOd6B6IZ7Sl1vByGX8CsvcX7+9eBP5WHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaoxKVCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaoxKVCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147EE1F000D0;
	Wed, 25 Nov 2026 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640849;
	bh=3iDqTzdlLZkLysluTW1KQAYS5n0EkSspojxZ3zDv/H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MaoxKVChM1DBIptFSS2dhLTmFolEYM2O8qJFb8Gc/XS597Vc0TRCDqVUQ8SOT/upr
	 6jT7x2gJ972/LSMatisX3X00pbe4ABdnWW8b/0GWEDOBt7Vq0gUnNChEMNx2l2s2Xa
	 +jz665jpGT56cMvBgF7Ek25uZOYFLprK94iew/916+Ov4aRqiO/mGWZLVqa7BzQsYX
	 kX05imJbwo7mOAmrNAbJiNCy71a674MfPdW81BM4dV257wRtJRe9QuVmS9OKnfEFnp
	 II4f/FieFSLqoLEpreYNJN7r8NbF/xrGIx1R8znnADqiyAZk9NBEWYY9xs5G4kYtJ+
	 Q0/iHUGSx8a8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 16:07:26 -0500
Message-ID: <20261125210720.1518478-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125210720.1518478-1-sashal@kernel.org>
References: <2026112517-afterlife-nuttiness-c75a@gregkh>
 <20261125210720.1518478-1-sashal@kernel.org>
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
index 14023051eebe1..4b482d116d04c 100644
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

