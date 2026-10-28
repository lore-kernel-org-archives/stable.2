Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164152;
	b=Xx39jgbQb6GE5hS9jY//j8ObRzklIHHiN92kA5+dmFao4WZVZ7MWNMJr8nv3SM6bX5OY
	 Zk5PgpqOYbkOfeo2fnYDPOnzsoK2qXZic74BUtUUnfc1lV4oyui4dAlyjDjxCFyGZiNFd
	 O0yQYlHuiUBGrY0g6WXNxWa5TwFyYPfKaRHB/v/WxhmELgcILdOa/v0bb1icnprnrV77K
	 ZOuL/eVI/ZU/q4o/jxBpHArzV5Rjum/x2eAks4/51K68NJeLpT7eNM5p3FAqxVs9la4s4
	 L8mlB6rcms6bR/Qj0riYUe65TsdOtUQHb04eyQa8RLPduHRjM6olK8rb2nq7fMviyEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164152;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=RkLs06oSKjndtEtH9UzjUkBgZdd4DTrmYRSHCcEFS1c=;
	b=LIb7ecYb3D3plY8Osq2ccpSjzfXTaSYhKz1PkexONccp/dPSr784r8afJQcNWdATEMJg
	 Pl/Xg79y69YHPSdumxnS72iCKN1vE8feem6gSmJL8r902JANVccrvYSXiIfIyPSWYUr0Z
	 Nc4uSZRjXk7RqyggjSvRmVB/TOdANnE8mGLGkT2Y0YNMjIuAsjVAR8JFT4sH/LhDLocn4
	 EEvI0WTQGvR6TP5UBzWww4XJjvahKTJp8M7F5zJkAoT3eAHMBQVnwieBc7k1A7XwE+nC7
	 oruRxdlypweV9djOcHnmtRG9ZJqJrg4l91a2SvfTuJwzvda8AUEPwkAozqZcmCdcJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=b5RUbuWT;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274D606A31A;
	Wed, 28 Oct 2026 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8274D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=b5RUbuWT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rk
	Ls06oSKjndtEtH9UzjUkBgZdd4DTrmYRSHCcEFS1c=; b=b5RUbuWT2UqmsPUIYn
	TJl39qzVRLc75xp4+W1YILKglhDYoierqyAQGrbJhLAOt1oZmCx0QvCL9ODe4VmZ
	dwj+i+Orpci6ySWPe/6ITE3U7byxSeqEH4K1jN28eU2BWC1XFbkGzjcLtL9bGJJC
	jvtIueKgpSbWBczpljIyJ2kcc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXn9Ntg+Fq8KFYDA--.38106S2;
	Wed, 28 Oct 2026 13:09:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Charles Wang <charles.goodix@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: goodix: validate coordinate package length
Date: Wed, 28 Oct 2026 13:09:01 +0800
Message-Id: <20261028050901.139292-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wDXn9Ntg+Fq8KFYDA--.38106S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy5CryDXr4rCw1kXw13Arb_yoW8Zr1rpF
	WfCFZFkw1qyw47Gw1UGrn5CayrJrWrJw48uF9rC3yS9345Kry7uFyj9FWqv3y3Jrs7t3sx
	Kw4kK3y5Ca4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwdb8UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ4PSWrhg27IXAAA33

The coordinate package length comes from the device.  goodix_hid_irq()
checks only that it contains the length field before passing the
remaining length to hid_input_report().  A package length larger than
the fixed coordinate buffer therefore makes the HID core read beyond
the data fetched from the device.

Reject coordinate packages whose declared length exceeds the coordinate
buffer.

Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-goodix-spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 03d549efbdce..eb63ee728a20 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -574,6 +574,7 @@ static irqreturn_t goodix_hid_irq(int irq, void *data)
 	struct goodix_ts_data *ts = data;
 	struct goodix_hid_report_event *event;
 	struct goodix_hid_report_package *pkg;
+	u16 package_size;
 	u16 report_size;
 
 	if (!test_bit(GOODIX_HID_STARTED, &ts->flags))
@@ -600,13 +601,15 @@ static irqreturn_t goodix_hid_irq(int irq, void *data)
 		return IRQ_HANDLED;
 
 	pkg = (struct goodix_hid_report_package *)event->data;
-	if (le16_to_cpu(pkg->size) < GOODIX_HID_PKG_LEN_SIZE) {
+	package_size = le16_to_cpu(pkg->size);
+	if (package_size < GOODIX_HID_PKG_LEN_SIZE ||
+	    package_size > GOODIX_HID_COOR_PKG_LEN) {
 		dev_err(ts->dev, "invalid coordinate event package size, %d",
-			le16_to_cpu(pkg->size));
+			package_size);
 		return IRQ_HANDLED;
 	}
 	hid_input_report(ts->hid, HID_INPUT_REPORT, pkg->data,
-			 le16_to_cpu(pkg->size) - GOODIX_HID_PKG_LEN_SIZE, 1);
+			 package_size - GOODIX_HID_PKG_LEN_SIZE, 1);
 
 	report_size = le16_to_cpu(event->hdr.size);
 	/* Check if there are other packages */
-- 
2.34.1

