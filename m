Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642353;
	b=quT5tFamJnQwFg4U+TNkDv0dbdbClWnytgMkPVSm6IRmoQHc+7XOlS1TL81x5Zg/zBlY
	 JJJ2yK2orkSePW0R4KDST0H2ic6DGyHMLFO/83QLOZKNIVd74KzIVz+uISlDBgbztehUS
	 GvR83iIcuXkFXoo6G/OcPhzEX+9ExS7MG+SghXN6WVqJKiv5QSM0DQ+xwLM6VEhBIXzbB
	 nfdap4dNpqhnmAqiGupCVH33WkZbGLHdLptoq9/fDsdMm8eBGrzNBlcQlsB4qrO4JW3Tt
	 JJ/58NUGJW0wSc+bpATi5XwFW7UX+cf1uOblxYfQf/pu/k4oBcf5JJiFj4DO386lf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fdDeNSRXb6890Fbc/rN3ZMd/+ep+aifvCrSPPw2PkSk=;
	b=aSTclu6t+nWuCttmB6QwyumnaAJWmWj7CcZgTTQ+mPTqfNvkYAvBRSkDmkhOS4KNE5rz
	 W0/uwxDIA08MvlHlk3/2QH+9PbOgwfUb/yq2j7/E8suntflSRdRIKCWlbzdUrg56+TSAL
	 OP7jEKVpWBgji9PF74u5zSjjgSzTPeraHOzUQJigUeKYSxR4C72H8u+C0DtBFBFqUfurq
	 MjPjkVvQsfIDUhOEYPtZkMrZvQgYRp80Qi2UB+3kCZvxmqr+x88s112ikZaLWSmLyrhGR
	 0AlJr6ZeMrvc1p6gnivPFSLr3zQH2+6eubsi5z3Eez5eQ1tzG1Er/iIWhcwmR3YC8Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4tdWfJv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB23606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4tdWfJv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F781F000CA;
	Wed, 25 Nov 2026 21:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642353;
	bh=fdDeNSRXb6890Fbc/rN3ZMd/+ep+aifvCrSPPw2PkSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4tdWfJv8Ywb45K92ollswHEeDwzwxFlE6Un5Zi2FWh6weHqYPDx63FF7dL+Cza84
	 R9eoXL6MlgSAhCTOSwf9f2L/ogJ/tGdVe43csk9uxWjpCZsQ8qXTlum6iftj5dglKq
	 ZOU3NXkAxZvpH0QlqKXkK/CVJU2A62Sp7MldYhZLLnkh6RcdMp70zX4FeADF8IO7tP
	 Sqtgcia7NJ7uYdtIzcEdarAoK9JzflnNUGYyM4AZQHZjJxbGzqLRreeVHtzS0hzMHC
	 twbcWh894HgEE3ICk2BOvVV5O8e+fP6EKe8pifDKvf+rDFX5xskP68zlH3djg9v7RZ
	 VTvKFYdbz6zsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 16:32:30 -0500
Message-ID: <20261125213224.1556380-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125213224.1556380-1-sashal@kernel.org>
References: <2026112518-hatchling-drastic-a78d@gregkh>
 <20261125213224.1556380-1-sashal@kernel.org>
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
index 8e893aef83d56..399eece49235e 100644
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

