Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741446;
	b=uUilN0dnFYRLndT4M/COTiZKf0VWlq4YX2E1CcibWu9WRNyzih78hSIlHpwwgI3D8QVQ
	 ZC/Qo9gDMi1GI55RnpTJyc0D8MjM5An/BhiZsVTQkvQ410GlUgP3O5AWzGttkzJGC/CeZ
	 j5257vxNrz3nvFwlRyroz87jlv1XI9v+3VJjE8h8MGQqqKuSzGfvHao3+u2xKQFOfeHg/
	 wBAQZfVrbj7SNwmOzUiVB4cq8nQ1YA3cAs/FD7pAqwHH1Gpn8MDr1BGpwtM2wUIVEx1Ct
	 E46iyksHBLRxHb8brWGK9BIXwu5cADF1cgLL3IUVUSo2nCnJul33GfhaSfknkwuT4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741446;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KBiAFwJBjOECAsi6lOaXohAXyvd5VSKVrxjrzr7WTOQ=;
	b=butmwnwlakU+slNLJAHGEcoDCbEwa+389YGB8J6TV6+iIR4vSkbt3VE9YxjggArl4Kz8
	 yH3ThzBOZn0FHvE0fi4eZ1CoLn0BlURCbSSsVN7HGhZr3p6T4jtaeRhY6724pN8IuiGS5
	 CURmKI/jNor36lwMq5UZXyJWXu/IQDH4eNB3nLulzZqicHeKGab+Fr0N7jjrRknIhlmyT
	 JRDTjWEt40r4ZNu/nXrLFxXgsRYNe3iSgqbZlqK82vp77U2dlPwh3v1vYsgChBIuc0Dy5
	 z6eopAq5KFk+zzvsk+/w0983zCQR2CcAuXhorKx0AbaDIKyn1e26X5nvgioJpEmKVXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVBgVzxk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E38606A31B;
	Tue,  3 Nov 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVBgVzxk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77531F000C1;
	Tue,  3 Nov 2026 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741445;
	bh=KBiAFwJBjOECAsi6lOaXohAXyvd5VSKVrxjrzr7WTOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVBgVzxkOHue8Bg8JZMVboN8UaAg+gjtemfKI+FdOkT7atn0v5vN2e9Fm67rCiD32
	 cYKDgbjBaFAD6SoS5R9qVbTl/nLZVR0MWI5qtlYlRey/oBI05VPAUfUU7uAbB5oa6Q
	 UH9GRuAA0idLh31GkoGdWpWZDW8kZt2wLKIRepoKrt00lC20JGhw0RUEWDsaGGGNaH
	 nZNupU8pZM2rBvzt7agksL8BoHDoJJGAhcVDJX31O0u/GpFq0bcpy+kF97rMX50mvf
	 /GTcmFrqnyOD3FZLJfKl3jOqT/cnSGur4nevvqukBL/uJRoz6+E+IBgi6DjOtDJx0Y
	 jH3VSMCq49BXQ==
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
Subject: [PATCH 05/10] pinctrl: realtek: Prevent out-of-bounds access in rtd_pinctrl_find_config()
Date: Tue,  3 Nov 2026 21:29:10 +0000
Message-ID: <20261103213002.1673560-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

Several Realtek SoC pin configuration tables (such as rtd1319d_iso_configs,
rtd1619b_iso_configs, and the rtd1625 config tables) omit trailing pins
that do not support pin configuration, making data->info->num_configs
smaller than data->info->num_pins.  Because rtd_pinctrl_find_config()
indexes data->info->configs[pin] without checking data->info->num_configs,
requesting pin configuration on a trailing pin reads out-of-bounds memory.

Check that pin is less than data->info->num_configs before indexing
data->info->configs[].

Fixes: e99ce78030db ("pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs")
Closes: https://sashiko.dev/#/bug/linux-60e13761-fd9e-4fd3-826a-47344f36d4fa
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.c b/drivers/pinctrl/realtek/pinctrl-rtd.c
index 60222339726b..2b877099ec85 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.c
@@ -252,6 +252,9 @@ static const struct pinctrl_pin_desc
 static const struct rtd_pin_config_desc
 	*rtd_pinctrl_find_config(struct rtd_pinctrl *data, unsigned int pin)
 {
+	if (pin >= data->info->num_configs)
+		return NULL;
+
 	if (data->info->configs[pin].name)
 		return &data->info->configs[pin];
 
-- 
2.56.0.385.gac671c819a-goog

