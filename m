Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804617;
	b=BpXMOFrWvPVJQldn8DpN7b0Z5QQwk/3m1XufTg17QWGK5i/JEmmJx7PGcXJKsVtbVLbG
	 UK5+kprtq1cTesQMuOmJmAfVsj7se5Ca62zLPfgXRNA8J8tmtvkpBkHHNWLNIYFsVi8/P
	 jXqrEpsaV7QQit5Snerqr0iBWEU+/SUGinyYFN3G0GfaHmJ25Emen6Y9VDge1njFd2qNt
	 8pBe1hRjh7Y14lpTZ0pquHCzjBgc6Hd+VUnCgcolqpMV8D2Dxfihd7BsO04vh2sIZCC2t
	 8KI9zS1k/lDhkbbmk+eCW9zWsYRb8ImVUvkfMlOcKt4T/C927ZhY6bgr8SAWr2/s8gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9+/JLOm6t3ePC4KR4UQzDZNsuXPLcaUwcUQv+WyJLd4=;
	b=2VH2P1xCuuMaMBzIg35yiGNPS1hwS/gQNKSYM4+9W15GJXFI5jfGhMK9M+NFdiP19wFs
	 YYR2d4YyidW9K2NMA34L6zCvyC6WBC1nCGhYPjvYGeAXwDw9OD0BGIXsHTr6sDOakFHwR
	 /mTHzsD9fyvU4sfvw2gGUDQnk966Z3lZyE6YxQY9CoelZc860i0dik35c/NeSsPNV7rbJ
	 xTosBGCMq70yuuBtPzTi8462DimcvJNj022VLJi5IPxfSlT2nJs/uAh5GMHUoY/thSdJU
	 sTyJVeLuIPAJkz3J+hsINPspJg6m7KGyqswTztLcz75TUqsrQpyohnUDo3LiPJ/J6Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzGa5oCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4B606A33C;
	Fri, 27 Nov 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzGa5oCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18E31F000C1;
	Fri, 27 Nov 2026 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804617;
	bh=9+/JLOm6t3ePC4KR4UQzDZNsuXPLcaUwcUQv+WyJLd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzGa5oCGLgeAx5PjXJ79y03M5s26YauS+eKULGRUVtiFkT3Qg3nUl6N1XB4TqHePV
	 wq5HAzS8xxGsuJtVbhpsA3kCH5KNYve1jw3bxDSA5Fnucna90A+6gGs4HqAdkvsJJx
	 0EgcA681VBCMrj1pmw70t4z6lE9AeVGcs/cDj7KkqdBB51QCa0viuQeQ7GzLWcV4+g
	 IhRx1zAYNmAHVNw/iRxqWiJk96A3ryCv6o8gG7ykr7DkyXpse3RYFrq51e3NRQPkr7
	 KA5CQlLjAPGQ2/3PAtqvitD34KR8KNbdSZsni+w5INLYDNHSi5RdNCOJ6R5IPtTif4
	 DZxPEc5Dpjd5g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Eduardo Candelaria <jedu@slimlogic.co.uk>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/8] regulator: tps65910: Fix OOB read and bit shift in external sleep config
Date: Fri, 27 Nov 2026 18:35:44 +0000
Message-ID: <20261127183624.3341010-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

tps65910_regs contains 14 regulators including VBB at index 13, whereas
tps65910_ext_sleep_control has only 13 elements.  Both tps65910_probe()
and tps65910_shutdown() iterate up to pmic->num_regulators and index
pmic->ext_sleep_control[id] out of bounds for VBB.

In addition, unsupported rails such as VRTC use 0, which collides with
VMMC and LDO6 (offset 0, bit 0), and computing
(1 << pmic->ext_sleep_control[id] & 0xFF) shifts by more than 31 bits
whenever regs_offs is non-zero because << binds tighter than &.

Introduce EXT_CONTROL_REG_NONE as a distinct sentinel for rails without
external sleep control (VRTC and VBB), add BUILD_BUG_ON() array-size
checks, return early in tps65910_set_ext_sleep_config() for unsupported
rails, and use BIT(pmic->ext_sleep_control[id] & 0xFF) for bit_pos.

Fixes: 03746dcbde75 ("regulator: tps65910: Add backup battery regulator")
Closes: https://sashiko.dev/#/bug/linux-ed3bcc60-149e-497b-93aa-50138953c49a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/tps65910-regulator.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index b99923773701..d42ffc237bf4 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -271,9 +271,10 @@ static struct tps_info tps65911_regs[] = {
 	},
 };
 
+#define EXT_CONTROL_REG_NONE			(~0U)
 #define EXT_CONTROL_REG_BITS(id, regs_offs, bits) (((regs_offs) << 8) | (bits))
 static unsigned int tps65910_ext_sleep_control[] = {
-	0,
+	EXT_CONTROL_REG_NONE,
 	EXT_CONTROL_REG_BITS(VIO,    1, 0),
 	EXT_CONTROL_REG_BITS(VDD1,   1, 1),
 	EXT_CONTROL_REG_BITS(VDD2,   1, 2),
@@ -286,10 +287,11 @@ static unsigned int tps65910_ext_sleep_control[] = {
 	EXT_CONTROL_REG_BITS(VAUX2,  0, 4),
 	EXT_CONTROL_REG_BITS(VAUX33, 0, 5),
 	EXT_CONTROL_REG_BITS(VMMC,   0, 0),
+	EXT_CONTROL_REG_NONE,
 };
 
 static unsigned int tps65911_ext_sleep_control[] = {
-	0,
+	EXT_CONTROL_REG_NONE,
 	EXT_CONTROL_REG_BITS(VIO,     1, 0),
 	EXT_CONTROL_REG_BITS(VDD1,    1, 1),
 	EXT_CONTROL_REG_BITS(VDD2,    1, 2),
@@ -822,10 +824,16 @@ static int tps65910_set_ext_sleep_config(struct tps65910_reg *pmic,
 		int id, int ext_sleep_config)
 {
 	struct tps65910 *mfd = pmic->mfd;
-	u8 regoffs = (pmic->ext_sleep_control[id] >> 8) & 0xFF;
-	u8 bit_pos = (1 << pmic->ext_sleep_control[id] & 0xFF);
+	u8 regoffs;
+	u8 bit_pos;
 	int ret;
 
+	if (pmic->ext_sleep_control[id] == EXT_CONTROL_REG_NONE)
+		return 0;
+
+	regoffs = (pmic->ext_sleep_control[id] >> 8) & 0xFF;
+	bit_pos = BIT(pmic->ext_sleep_control[id] & 0xFF);
+
 	/*
 	 * Regulator can not be control from multiple external input EN1, EN2
 	 * and EN3 together.
@@ -1104,6 +1112,8 @@ static int tps65910_probe(struct platform_device *pdev)
 	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
 		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65910_regs));
+		BUILD_BUG_ON(ARRAY_SIZE(tps65910_regs) !=
+			     ARRAY_SIZE(tps65910_ext_sleep_control));
 		pmic->get_ctrl_reg = &tps65910_get_ctrl_register;
 		pmic->num_regulators = ARRAY_SIZE(tps65910_regs);
 		pmic->ext_sleep_control = tps65910_ext_sleep_control;
@@ -1117,6 +1127,8 @@ static int tps65910_probe(struct platform_device *pdev)
 		break;
 	case TPS65911:
 		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65911_regs));
+		BUILD_BUG_ON(ARRAY_SIZE(tps65911_regs) !=
+			     ARRAY_SIZE(tps65911_ext_sleep_control));
 		pmic->get_ctrl_reg = &tps65911_get_ctrl_register;
 		pmic->num_regulators = ARRAY_SIZE(tps65911_regs);
 		pmic->ext_sleep_control = tps65911_ext_sleep_control;
-- 
2.56.1.839.g22a8290db9-goog

