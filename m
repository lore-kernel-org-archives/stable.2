Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121509;
	b=MvdWT0BXR1uQZ7tXPtaf9LQj234l32YrDO9qYT2gRB/XiD93A4AQ/FJ8RiwtRCMB3sYU
	 bMTKVWH/kk5aDTIRwJ4rw5ITT7AWQfltZpL9D96a/qVPp9CTGsbLu3wAzPxOy3E3R0BaD
	 EtlzXZhlnqn76KWoLROF7pPdmB+hUb3iPAbCPWJFFoZep2XYUSUXS1At31czd3eb19AB+
	 kvYCqJhK3nzw/iMgbzbvd0nb6eXEvFiOjZpz9rfb+/XKhMvS1D26hEKWCvVoGfgn5ARH0
	 l31NnltxWU9mYYXKisRjja5sygoTEady2bMR1sV1vFG3AXzZFazbOJrxwK5GdW47DTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121509;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ozleJ+L+uNTLaGMigNL/2EmL/Gas2wcTiKBPcA8A+ng=;
	b=FUu/ywyWlvrQ2laRdIqbrnI8U6H8rZNj46qgduL7FTwzOrlxLVj/j4UgtZ3tNZIcf4SZ
	 nYxwu/YPyvM3pln3MDI6uyO9Gp8kmzibXr8/PGgx34fTi3wwOm/2CMmkhGOz6bbR/lPAH
	 toPBv84DYy7ZZHN+DY8W6cGAfYavqKuuYlIRe40UjJ2eQxPZgNg8uX8e2Ogap6+351RUd
	 QoAC0syMsFPSnwSnVATZmgdaWisKIZF9bRfhVYa3arqvtyTy5OgAJng4W6U2x79V3xnjr
	 6InBxPivka1tBmtvEmragTwcv6Z1+1JJRGYGGl1g0BYX1Dc6/tP09hMas4tPHML0hPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6lvy8Sr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117F606A901;
	Thu, 19 Nov 2026 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6lvy8Sr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C51F000C0;
	Thu, 19 Nov 2026 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121508;
	bh=ozleJ+L+uNTLaGMigNL/2EmL/Gas2wcTiKBPcA8A+ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6lvy8SrMm1caN0nwEFipqehaDace7R5FngazPpcN8ApF8n2IWLmcxHhA5Fnl1a+u
	 lD0jQnMmVwXbAcsatXZUh723s23r7zFfmyj6AJiqDEbosc9UpKnghaS5g/HgzoZYjb
	 QVPvSK9k2/chgan4mu/4p4e8S/tvjkLaW5/m+KqiZexAxDOx8UsP3AMIy4S1yqYZhg
	 EUnUHyYSB32BTIgHyQQowruyw194Kclm7GjLrlIBZZ7bliRF3+IZgAi8hqgEyFqOLd
	 ne+oCuBIJal3q4MHYjibt2rEM4ADrDPLv574FsMKgn9gsU4EjQ3knS4Wy4oR4RoQ6m
	 c6J8eXZXNBOow==
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
Subject: [PATCH v2 12/12] pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without duty-cycle support
Date: Thu, 19 Nov 2026 20:49:08 +0000
Message-ID: <20261119205013.2563811-13-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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
Reviewed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: Collect Yu-Chun's Reviewed-by

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
2.56.1.750.gf70dc682cf-goog

