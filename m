Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434063;
	b=TmTAThXKPgx8at7xBlScyH5RAb9eJXjHiFSnQo1RO2szuyz2LT5Er3Pi76SzAUSOestI
	 ygQR6q5eZoyA8GtwNegGsIuhxfDF/WgQRl7ZcNrR8uVNOrFAFYOD53rDOUrIQLVU5tpXU
	 qJyRcn/t08/9ssX3vo/BfgA2KtS8TuXu8hN1Ne9qxtcI9n77BASUrsPL8ZjCbJqsJXFfT
	 s3qoLv3YSNxPbnViJd/n8EwzXMStgufUTgHw4veu9qe6fPfAx5AMcRTeJ+Vga5LeADp0l
	 qJX+Ym+oKemZIhX+CIAAJxnOMxM2mpgacHPf/6LA21EjOiDJy75Kp48XhOMxZ9iHqiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434063;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q87Wl85GfFdAm5sI7YhIU296WIXHysjelEmZ6Jt78Zo=;
	b=XEwRD+M5eDBj+ohSNiauvT9KTybOLHTydRH5dDWblhNZtqAL8kSlWtbs8u07bj7MpAyU
	 iN2qSgJPyi+LE3+XVsWz1G6QpHkdjoGRncEHiFXlfBGc+m6QldNL4yXSkozw4QiwHf4PN
	 0pvIbFgKE9ljerW9zmXeTScPnDDc2/l/egih1WSIra/rTLo8ndrJxFaALBKWFir0NqdPk
	 Qmdnf9ipEQ7fFJsRcZUgQdqpxIwd7bQGRTsObbMu9nlpleKpmQmFkcDXk7YPcaNDA9sxI
	 C1Do1buKTZwbK2S/206R1Bsf96LPIjSw3RQA/bAtwFNcvw5dV0tWqwzO+UVlDWNuaoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAbDfQab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771560A3801;
	Wed, 11 Nov 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAbDfQab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E41F00A13;
	Wed, 11 Nov 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434063;
	bh=Q87Wl85GfFdAm5sI7YhIU296WIXHysjelEmZ6Jt78Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAbDfQabkJCWMoI446YjnWaSVHAkThh4Xya03u901cDNc41eR145Skd0CaRzYQoGh
	 ZAEREymwRaHATtz1OkSCi0sAfMPKSvBPo6KVVyXbpEXXEdTwIbIqER6BbSYCTxGhEr
	 zwrhld9wfi1mxQ3vPy5p1eDcU9djnbtcENyu0wxamYC06UC2ptFtcI36AIbksl6X3q
	 s8PzmrvmwsMdJpr3VC22vFwfvitB9FeM2E7ZSZUNUjXuGgZdC9+Nq8qo+NX0m/tzsB
	 KBO7SOc5HLRBABrmR2agjY6BmWU5ATM1oNI+1YRf9gD/pwcwG1nb10vslRQrKO5/IH
	 i79eIEZjyZtjw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	James Tai <james.tai@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
	Linus Walleij <linusw@kernel.org>,
	Tzuyi Chang <tychang@realtek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without duty-cycle support
Date: Wed, 11 Nov 2026 21:51:55 +0000
Message-ID: <20261111215256.1982044-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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

In rtd1625_main2_sconfigs[], pins gpio_86 through gpio_91 do not support
clock duty-cycle adjustment (dcycle_maskbits is 0), but specify 0
instead of NA for dcycle_offset.  Because rtd_pconf_parse_conf() tests
sconfig_desc->dcycle_offset == NA to determine whether duty-cycle
configuration is supported, an offset of 0 causes it to compute
GENMASK(0 - 1, 0) and corrupt the pad control register.

Set dcycle_offset to NA for gpio_86 through gpio_91.

Fixes: e309dbd523b8 ("pinctrl: realtek: add rtd1625 pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-8a8f690f-15e7-4dbd-a3a2-87bc00edf7b9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd1625.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1625.c b/drivers/pinctrl/realtek/pinctrl-rtd1625.c
index 88f2be37f743..f6e038e4bbdd 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1625.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1625.c
@@ -2993,12 +2993,12 @@ static const struct rtd_pin_sconfig_desc rtd1625_main2_sconfigs[] = {
 	RTK_PIN_SCONFIG(gpio_65, 0x34, 16, 3, 19, 3, 22, 3),
 	RTK_PIN_SCONFIG(gpio_66, 0x38, 3, 3, 6, 3, 9, 3),
 	RTK_PIN_SCONFIG(gpio_67, 0x38, 16, 3, 19, 3, 22, 3),
-	RTK_PIN_SCONFIG(gpio_86, 0x3c, 0, 0, 14, 4, 18, 4),
-	RTK_PIN_SCONFIG(gpio_87, 0x3c, 0, 0, 24, 4, 28, 4),
-	RTK_PIN_SCONFIG(gpio_88, 0x40, 0, 0, 2, 4, 6, 4),
-	RTK_PIN_SCONFIG(gpio_89, 0x40, 0, 0, 12, 4, 16, 4),
-	RTK_PIN_SCONFIG(gpio_90, 0x40, 0, 0, 22, 4, 26, 4),
-	RTK_PIN_SCONFIG(gpio_91, 0x44, 0, 0, 2, 4, 6, 4),
+	RTK_PIN_SCONFIG(gpio_86, 0x3c, NA, 0, 14, 4, 18, 4),
+	RTK_PIN_SCONFIG(gpio_87, 0x3c, NA, 0, 24, 4, 28, 4),
+	RTK_PIN_SCONFIG(gpio_88, 0x40, NA, 0, 2, 4, 6, 4),
+	RTK_PIN_SCONFIG(gpio_89, 0x40, NA, 0, 12, 4, 16, 4),
+	RTK_PIN_SCONFIG(gpio_90, 0x40, NA, 0, 22, 4, 26, 4),
+	RTK_PIN_SCONFIG(gpio_91, 0x44, NA, 0, 2, 4, 6, 4),
 	RTK_PIN_SCONFIG(hif_clk, 0x44, 13, 3, 16, 3, 19, 3),
 	RTK_PIN_SCONFIG(hif_data, 0x48, 3, 3, 6, 3, 9, 3),
 	RTK_PIN_SCONFIG(hif_en, 0x48, 16, 3, 19, 3, 22, 3),
-- 
2.56.0.567.gdb80ae8cd5-goog

