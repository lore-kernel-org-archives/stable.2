Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2487331ECE;
	Mon, 31 Aug 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173496; cv=none; b=lVVA+9s24hKPgyBq++BHP0U6aO3vHFJtpjQMokTZ6O28LGvp/vCA4nSof6yZVaT5Ir7/pOATUrGVWda6yqMwlVrZy9sXYGVLSdwaLFhkZYZSsYWgttvZusBMalyfYwl+HgzBPwwbIAmzsS/kZWlaeIf0mTgkaRFJZNs5BrIKA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173496; c=relaxed/simple;
	bh=1niTMfBLzbpsiIzfN+AYwRqUvyi3f3U8pFVTukwIqP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQr3kkYE9VG/yZJ5z1QX67fcurW4V4Ut31DMBTk13/mOul+79AkaaOnkfWQI2XFuJ2HqG8LqtxBX629fvgLKJRGHh5jkosQzrgnsK891q2Vuk0F0pZ6KZ+80Wn5ykz+197b3O7pvgXaM9b7cxpEV3nlQnk3xGGY+lgua5f/B2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3DeXQtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3DeXQtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA601F00A3D;
	Mon, 31 Aug 2026 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173494;
	bh=rR69ic9FQZSapE5sg/ABBzxhACPJIL3BPm0zD8pyE60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3DeXQtIfnUV5+F5oMPHi9dhGZB+kNoIBsw+ZHnl5BldpgSE0cnGHeZy3LNq9WV3u
	 VpjaqydyJ0TxkVXNKNd2ENMGt4o/OnMtdypV+iUgyGlbifQD+m3/k6B+qCRrcx8PuI
	 XLScuN2XYZgCFwu7OSuX7p4eUO05xggujeQaYSPuC8iHvCyQiWD4vKXLlBZJXjg1d3
	 0qHNBzCz6YNLbak/45leEF6iH4aUDgWZxa8df8kCgI3eymfzHwvUrUnv7Dx1O35Qti
	 v0iOHLnNNajS7nGsuWgdsO2QdkapnXLlMq4ONQEcUXmMQcTrp9KrZMGPyuSKqC06a4
	 dC/RMRdhF6Gyw==
From: Conor Dooley <conor@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] pinctrl: mpfs-mssio: use correct regmap function to set bank voltage
Date: Mon, 31 Aug 2026 11:50:59 +0100
Message-ID: <20260831105056.756259-8-conor@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831105056.756259-5-conor@kernel.org>
References: <20260831105056.756259-5-conor@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=conor.dooley@microchip.com; h=from:subject; bh=iZ8hHPxlioduqcAJXU0xpcnuVbcgYDtpROhjkH9+UbE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFlTY1b8MahoOJg09c0qG1dtpzNs95RSmBpvnjb+WGok0 LZ2ttTyjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEwk6CrDP6U0B2fGNJ7+Sewn 1J22HWR8N+l+3XRD5RTTK4E9WVv1/zAyPE27+uaO/AfXvtSVO5oFy7cuOrlQWP2t1QHxHtOJMw3 YGQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

regmap_assign_bits() is not the correct function to use for an RMW
operation, as it maps to regmap_set_bits() or regmap_clear_bits() and
the former will never zero a bit. Use regmap_update_bits() instead,
which will actually set the bank voltages to what have been requested.

CC: stable@vger.kernel.org
Fixes: 488d704ed7b7 ("pinctrl: add polarfire soc mssio pinctrl driver")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c b/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
index 9e6d233804cb..8da0c5312ce3 100644
--- a/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
+++ b/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
@@ -156,10 +156,10 @@ static void mpfs_pinctrl_set_bank_voltage(struct mpfs_pinctrl *pctrl, unsigned i
 	u32 val = FIELD_PREP(MPFS_PINCTRL_BANK_VOLTAGE_MASK, bank_voltage);
 
 	if (pin < MPFS_PINCTRL_BANK2_START)
-		regmap_assign_bits(pctrl->sysreg_regmap, MPFS_PINCTRL_MSSIO_BANK4_CFG_CR,
+		regmap_update_bits(pctrl->sysreg_regmap, MPFS_PINCTRL_MSSIO_BANK4_CFG_CR,
 				   MPFS_PINCTRL_BANK_VOLTAGE_MASK, val);
 	else
-		regmap_assign_bits(pctrl->sysreg_regmap, MPFS_PINCTRL_MSSIO_BANK2_CFG_CR,
+		regmap_update_bits(pctrl->sysreg_regmap, MPFS_PINCTRL_MSSIO_BANK2_CFG_CR,
 				   MPFS_PINCTRL_BANK_VOLTAGE_MASK, val);
 }
 
-- 
2.53.0

