Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741601;
	b=nMThCxM9PgrZ2vpTReXSFyFL/wtaP5R7AKHBMTgbhM9YsoYtJZXOGCx5NNJmFSqlQMLo
	 LLpZ2lf/v9BlH4dOQiVXwTZqn45w5Hlo8LqwC/LT18Y7rgzNm9whz+QA+6hWI0qUjJACV
	 YCy8yhyHcODEXKUj0Uu38caxBO0uprNwDM3Sm+/x7VBTE+l+dOMKJ1t+LaIkFv7RJe38g
	 uOhnIOehC0XrazX/qIfYULWaUPK0LiG3l2QhQ9iFXzGC2t/kcBoMINP9Lanle8V71JWrm
	 lMTsTt1+gSBfXQUvghghHmffZrZ6JCU14TJKZWxFaG829eL4/C5y/PF28iIELSyuOrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741601;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KuBrMsz2C5u6FWjzgp8V8uFD+UU12dr0+LzGx7V9auU=;
	b=YLQ29HfY7OSu/eAh07xaHbcxXntkZqkyNuDmWvdM0aXAz2+5nAh4XWdwYsljiyDmjxnD
	 wiSxWUy3dm9ljGTsYT7jbtZtGUPJFzdHqWFYisaqpBcOGBqnL+dBbqG84FzrPvD4AqeU1
	 7OjwRrUTUJlVqP5NFvwobrlCT94rAvwE38auTbMXE2Pj0hQ9sJjAPpTU1T91LKR1F4Uxo
	 XMK6S3DRTDxl8i6FUlwB1z+qhtADQMzeL5+BnmmyoQZn7Cp/psBjIpfs2d6k/MCB9HCn7
	 vXOw5Kmspn15EUiKwIq8z+ollP6vWVN5RA5XejoMsExwoQ1nb4KqmVQr88QcwqYPwmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VyaYNaDe;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48F606A31A;
	Fri, 23 Oct 2026 07:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE48F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VyaYNaDe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ku
	BrMsz2C5u6FWjzgp8V8uFD+UU12dr0+LzGx7V9auU=; b=VyaYNaDeXX6Jf6MV7v
	c095IK0Dt0ugwrE0ub/C7S+M/SFhDHi3piUDhuSKMOnXutVKKMaZE5bB6oGq0InN
	OGCitE+zbQWw/oVrdARMWkr79qHFmgfiSjSCrWJ0+/tqI9WRaz4pD/SysKALvdGn
	q4NQOcW5jorpGllg+Qafpa0Rg=
Received: from dinm5CG319492G._sites.dc._msdcs.ad007.siemens.net (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v4jOENtqsIqrBw--.50066S2;
	Fri, 23 Oct 2026 15:46:22 +0800 (CST)
From: door_110@163.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	kairen@siemens.com
Cc: linux-kernel@vger.kernel.org,
	Kyle Manna <kyle.manna@fuel7.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: tca8418_keypad - fix debounce disable register configuration
Date: Fri, 23 Oct 2026 15:44:17 +0800
Message-Id: <20261023074417.3078016-1-door_110@163.com>
X-Mailer: git-send-email 2.39.5
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
X-CM-TRANSID:_____wD3v4jOENtqsIqrBw--.50066S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF45Zr4UXF43Xr18GFW5Awb_yoW5Wr1kpF
	y3Jw4Dtwsrtw1DtrsI9F18u34xX397G34ayFyjg347Xr4Uu34jva17KrWfu3WUG3y0vw43
	trs8GFWY9rn0qr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYpB-UUUUU=
X-CM-SenderInfo: xgrr2sqrrqqiywtou0bp/xtbC7g7IG2rbEM5rbQAA3a

From: RenKai <kairen@siemens.com>

The DEBOUNCE_DIS1..3 registers use active-high disable bits:
writing 0 enables input debounce, while writing 1 disables it.
The driver currently writes the active row and column masks directly
to these registers, disabling debounce on the configured pins.

Invert the masks so that configured pins have their debounce-disable
bits cleared and unused pins have them set. Mask DEBOUNCE_DIS3 with
0x03 to keep reserved bits [7:2] clear.

Use unsigned row and column masks when constructing the keypad-mode
configuration, avoiding the existing left shift of a negative value.

Verified register readback on hardware with a 4x4 keypad:
  DEBOUNCE_DIS1 (0x29): 0xf0
  DEBOUNCE_DIS2 (0x2a): 0xf0
  DEBOUNCE_DIS3 (0x2b): 0x03

These values clear the debounce-disable bits for ROW0..3 and COL0..3
and set them for the unused pins.

Fixes: fb6c721b69d4 ("Input: tca8418_keypad - initial driver release")
Cc: stable@vger.kernel.org
Signed-off-by: RenKai <kairen@siemens.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 3bbd7e652533..92234df25397 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -234,21 +234,29 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 static int tca8418_configure(struct tca8418_keypad *keypad_data,
 			     u32 rows, u32 cols)
 {
-	int reg, error = 0;
+	u32 row_mask, col_mask, reg;
+	int error = 0;
 
 	/* Assemble a mask for row and column registers */
-	reg  =  ~(~0 << rows);
-	reg += (~(~0 << cols)) << 8;
+	row_mask = (1U << rows) - 1;
+	col_mask = (1U << cols) - 1;
+	reg = row_mask | (col_mask << 8);
 
 	/* Set registers to keypad mode */
 	error |= tca8418_write_byte(keypad_data, REG_KP_GPIO1, reg);
 	error |= tca8418_write_byte(keypad_data, REG_KP_GPIO2, reg >> 8);
 	error |= tca8418_write_byte(keypad_data, REG_KP_GPIO3, reg >> 16);
 
-	/* Enable column debouncing */
-	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS1, reg);
-	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS2, reg >> 8);
-	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS3, reg >> 16);
+	/*
+	 * Enable debounce on used rows and columns only.
+	 * In DEBOUNCE_DIS registers: 0 = enabled, 1 = disabled.
+	 */
+	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS1,
+				    ~row_mask & 0xff);
+	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS2,
+				    ~col_mask & 0xff);
+	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS3,
+				    ~(col_mask >> 8) & 0x03);
 
 	if (error)
 		return error;
-- 
2.39.5

