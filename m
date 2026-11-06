Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929780;
	b=U8psex3SmxTYBemGB7/YIsdtTk7p4FrBn9JHiHYiWeLDAK93DoJh/C6YJoDLLUuq12vi
	 uu/L5TLco4+6sVEaVNPmYhJS9bmh2fj6h+YVdMYKZZrXlvdKtb8s6X8U2XIlB/ByegjYJ
	 c9YoyX4+zA8FlaZiyXiaO2kgeoT2Km06LySoiKJ40LeJLlG/a0l33kNHrmgH4fOsomw5D
	 XROFKpOiE0A4Y6p6iR8sA0LUlD2eGfFfrtaUPwT07SIqjr2yANPvuTTab6KxBy/ZUkDmc
	 vzdvOyWvji2FvTkaau8Mgnmtt5W6VCGPN923CHNh9ZR2oQv/5iOU2GDu1qq0czo6zAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929780;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3wVPvgXMObIvEiKqVWoN+3DnMWZhPdBWHG1bhWGhuUQ=;
	b=19oZ0+6pcxpgSMCrwUKNUeEfKHfs5vZ2+ThyYazHkRzEtPYyeBrrJ+TGRS07hyMSzo/m
	 wIN3yab2nLL3qF1ZE5fAUkwUWUPxNLGgZ3Z0Li9iBlNaLK7074ltYy2QA9dNNOG62JRfj
	 DT3fVvfq4GO21MVewNrvhYMUFoqDzs7umYcTlu9xzCNSs8Grqx86Cz121p4yL/xH9BFZS
	 4kogCtH7zKtEBE++RUHuEnV303Gte3nIDgnzGGcl75lnoZk1JoNXxKN/1vSMOZ2WfuJ5l
	 1aM5y/QCVJeeCU7nThhwTLSDGIIHYSdjsHLzyGgjQnO+R89fMTOHyiPqskBxlpKYLkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hkYXfZ3O;
	arc=none smtp.remote-ip=115.124.28.149
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38EF606A32E;
	Fri,  6 Nov 2026 01:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38EF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hkYXfZ3O
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929770; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3wVPvgXMObIvEiKqVWoN+3DnMWZhPdBWHG1bhWGhuUQ=;
	b=hkYXfZ3O2uKn/GBin3CGL5JYXX0AZzWwNy3viJuCsM2mRuV52T6+vvBlYtb1a6F+qHkenfd51TZXzuye0mZ6fdhpi19EfFH7zoWIRxwivTqE4d3lJZHmMSF+EmK+KlVanqQ6Lqq/VkB8ts1P/rvmBZevAnjNTtZQSKq5qCf4VjU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0840445|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00178982-0.000206233-0.998004;FP=17750681906991275378|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jxs7sS._1793929769;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jxs7sS._1793929769 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:29 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v3] Input: lpc32xx-keys - reject matrices bigger than the hardware has
Date: Fri,  6 Nov 2026 09:49:28 +0800
Message-ID: <20261106014928.328020-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aurPvymSFACa_kXH@google.com>
References: <aurPvymSFACa_kXH@google.com>
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

The scanner state array holds the last state of eight matrix
columns, and the interrupt handler walks the matrix size that the
device tree declared:

	u8 lastkeystates[8];
	...
	for (i = 0; i < kscandat->matrix_sz; i++)
		lpc32xx_mod_states(kscandat, i);

The probe path only checks that rows and columns match; the
hardware supports square matrices from 1x1 up to 8x8, but nothing
stops a device tree from declaring more, which makes the state
array index run past the field into the rest of the driver data -
including the keymap pointer the same code dereferences.

Reject matrices larger than the hardware supports.

Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v3: actually include the LPC32XX_MAX_MATRIX_SIZE definition that v2
    referenced but forgot to add; compile-tested with
    CONFIG_KEYBOARD_LPC32XX enabled.

 drivers/input/keyboard/lpc32xx-keys.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 2392e7e..b3c1dc1 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -39,6 +39,8 @@
 
 #define LPC32XX_KSCAN_DEB_NUM_DEB_PASS(n)	((n) & 0xFF)
 
+#define LPC32XX_MAX_MATRIX_SIZE		8
+
 #define LPC32XX_KSCAN_SCOND_IN_IDLE		0x0
 #define LPC32XX_KSCAN_SCOND_IN_SCANONCE		0x1
 #define LPC32XX_KSCAN_SCOND_IN_IRQGEN		0x2
@@ -65,7 +67,7 @@ struct lpc32xx_kscan_drv {
 	unsigned int row_shift;
 	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
 
-	u8 lastkeystates[8];
+	u8 lastkeystates[LPC32XX_MAX_MATRIX_SIZE];
 };
 
 static void lpc32xx_mod_states(struct lpc32xx_kscan_drv *kscandat, int col)
@@ -141,6 +143,12 @@ static int lpc32xx_parse_dt(struct device *dev,
 		dev_err(dev, "rows and columns must be equal!\n");
 		return -EINVAL;
 	}
+	if (rows > LPC32XX_MAX_MATRIX_SIZE) {
+		dev_err(dev, "rows and columns must be at most %d!\n",
+			LPC32XX_MAX_MATRIX_SIZE);
+		return -EINVAL;
+	}
+
 
 	kscandat->matrix_sz = rows;
 	kscandat->row_shift = get_count_order(columns);
-- 
2.43.0

