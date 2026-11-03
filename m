Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695308;
	b=0l9thvvBP2p9lD8L8brHvLOdm5WMrQN8IP0sVirXZVPbBRPpY8hQ4a9TATjc9HXqW1aP
	 5RcdVfmcHTCy0dNIidMNjbrq3cvULgF4ARaq+jfIXLIZMnnHsbALEMAEwSmhqjysimNof
	 xKYhafekDLtW8x1fIMbwnyil7ktRBfXvncJMqxX7s2UJDZC05RpMBBnnNbIP6EW3ipi5a
	 Hqurm9NbZpMUG5k+jnozcSOCUNVnGeB+t80ra7OncOIYhqflDRCGV6V3CSwzXIkQseiJ4
	 2H7yCOj7yPbTmnHgGNiOd88Y/3Jm+yuz+rwq6y0G9AKhkplWoL+EXX36QDRxrx8XjWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695308;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s2o2jqr0EGM36gGMYl7to7xFg0YvJBqNItTaIIIY64A=;
	b=e39yEqdOHpNSOxqsYzuIgcZNsJjVpCe5ticrQRjWZXPAGlQqq7c+uCBmEZPI3Pw8G1KO
	 3irg/KzAIBcC9Xzi9Bqklp2HYiUflQevt8JomP2X3wbSYK47Urgl/V9Gs4WEsl5dVzBrY
	 77eYIHdcfW45tca93rlZ+5CT7waOl23fyPxhh4kcUJPlEG9tRACaHyWK00dvv7ZDa+YM1
	 7EwNm1WCQpBZ/zbn7SFcuJftXpblVODJmkKNCHj6dXwVKxKoOb7/14N6B0VRf0oaEVk7A
	 YtzMEcIsPEboVkTJABCcZmQq3xg5fPuIkKedqpWYyNKzrhTWeMo1ukPyoOXvAOOIDmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pjPR3ejs;
	arc=none smtp.remote-ip=115.124.28.220
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447C606A942;
	Tue,  3 Nov 2026 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4447C606A942
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pjPR3ejs
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=s2o2jqr0EGM36gGMYl7to7xFg0YvJBqNItTaIIIY64A=;
	b=pjPR3ejsPzg1iIPsFBf8In7sSeX5iD5XvZALMntrMokdUBTAD99/FmSTOTDla4vUHbVQhQi5A+ef5aWyesZ+mjnvB22ObAGeq4sdZnbVmAlWHzYGNxK35wQYRYz2PhW6CdtAEq8ino3q4esrF6jpQWwJh6RuNERZgrbK//itq5g=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08976552|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00572124-0.00184533-0.992433;FP=3555928415803192499|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9Ee_1793695297;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9Ee_1793695297 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:37 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: mt6779-keypad - check the reported row and column
Date: Tue,  3 Nov 2026 16:41:33 +0800
Message-ID: <20261103084135.426629-6-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The interrupt handler turns register bits into a matrix position
and indexes the keycode array with it:

		keypad->calc_row_col(key, &row, &col);

		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
		...
		input_report_key(keypad->input_dev, keycode[scancode], pressed);

The keycode array is sized after the rows and columns the device
tree declared, but neither the probe nor the handler checks that a
reported position actually fits those dimensions. A register glitch
or a matrix smaller than the hardware's fixed layout indexes past
the array and reports whatever sits there as a key code.

Skip positions outside the declared matrix.

Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/keyboard/mt6779-keypad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index e5eb025c5e99..effd154f5bf9 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -73,6 +73,9 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 		key = bit_nr / 32 * 16 + bit_nr % 32;
 		keypad->calc_row_col(key, &row, &col);
 
+		if (row >= keypad->n_rows || col >= keypad->n_cols)
+			continue;
+
 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
 		/* 1: not pressed, 0: pressed */
 		pressed = !test_bit(bit_nr, new_state);
-- 
2.50.1

