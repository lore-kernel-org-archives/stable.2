Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643653;
	b=igLEIV1twylslCTslu/Pd/DoOf6g0uIoPk4oJYgeu7YmvJ/leJ5l6YcNtdGEFPl7ys8r
	 Om+5K1ruu/mlcO9ceTeGNOAaHi9kiXd4sS7y8VhD18NUhxh92ekvONFDt5VmQBzZySseb
	 VTLtpYyaFYcQelB3E0IC8pknGaqOhrP3BXTT+mHCzz9I5cQHZ2x6s+EvtK6zxrtDu/yNH
	 UDLqLvFjNUE3IjXfQlvMNA753cp7Y+3tLMDm6Fg94f4QFYGn6tP8Vo5gjR3E/cB3bS/bv
	 3otbziMiOKLq66iy7MJ/kv0//6TXhyPz8cp/sDyVFkzKqXYvNawF+ZxQ5TJ5nijpjZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ASyxTytsyJdeC4wj3Hxc2O6cL/6JRH+qExmqHoKOGKQ=;
	b=xjl4N4/bOmUGXaXrQQGIKpsdZKz9HsTug4YE7kGoG1Lhh+ziLMpA58Y0iK2jpKT18oCZ
	 syCsPKk0FybE6lnEiaOb9isabZRScWGmAjhbac1HkCAZWBthImSsjd4OSNYHLCJZ/85YQ
	 z//PnVC+HoqJs0X9MP+yQ/6cvvmVItb9E4qG/xZPN65ImBNix2DYyBeCN6RZyH+yiWGQj
	 Tl4fQDUjvamC8UmPAnzqN1dk9GnUu2nYIanC+SIWAjWCDpiAKEoRFv1DcuK+C64VjrpyZ
	 rzfXQd/2rApyGIrX/RYhG7AUBHqADxNKIOICb3pdwgo3Chi8zYdgOxB35O/tVAkUxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqEh5Ny8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E99606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqEh5Ny8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89071F000C0;
	Wed, 25 Nov 2026 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643653;
	bh=ASyxTytsyJdeC4wj3Hxc2O6cL/6JRH+qExmqHoKOGKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqEh5Ny8AYNJaaYS9uBnUuEA5d3bMPh52tr1MYhnRgbadMcMenIRgdLNig1mE66R2
	 taBAB5uWD8Dm5Q95Ix7QmlWjBBKijgA7Bbof8lffpIvjK3Rk1htsuhfGS8eOG12FOp
	 r5GQr6AuQkqm9wF78iNG0Jwdjbah/u1AB5H7dAQ9yujFjlehhYO19xNZnuIh7HPayt
	 mB7qOQoTpdBYxyXhWf6ExDpBtlTtz2/55Y7Z42U+e53NYqdPQgiW7a5t9VvKOQKaJw
	 LQXXEJd94rIUSS8YcMx3vI3ojFDPQr2q9ier1jCmYxfWEZDPGBETLymjKkGfPzbbY7
	 Z507zmfwoTITA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Wed, 25 Nov 2026 16:54:11 -0500
Message-ID: <20261125215355.1590581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-tidy-payable-b8f5@gregkh>
References: <2026112518-tidy-payable-b8f5@gregkh>
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
[ sashal: Added .use_raw_spinlock = true to the single unnamed regmap config (which already has .fast_io), since this tree lacks the named and per-CPU configs upstream edits. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 99b5734614ab7..7ccf01e4870b1 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1046,6 +1046,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	.use_raw_spinlock = true,
 };
 
 static int mvebu_gpio_probe_raw(struct platform_device *pdev,
-- 
2.53.0

