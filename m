Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202053;
	b=Q7lksfjdIZBTMJT6LdOxmauI4o6xOU08oRWiTX6B2YHbGw2uU/U5H8hKkITF9hFCfXhN
	 gmp4lAJnaTAVgirjvmvHm1kxnncicdwFr4d1PvJADIn3jVevtrR1AH1TILVsHZWwzv4e7
	 Oas1B9YaexJPQlyItYbeNsyNgB3+W0m6zL4ZdlYzd4lzXvznNQVtnSp8frpCw4yE61Yxu
	 4q4PCqQorJmPhlmh3m+0mqzJKKaBQaTp5cPoKNXdrWw36EsI5D2HagsrjnkOT5BD0FsDE
	 rlopgpoDEX7jHdB9jbQOqJnAXE8ydkYCHDIXcrRePHR+oEYwqTxnFjdsWjKd1Prpk2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202053;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1BtYHxxSpkoc0eJPO2XWBHTEKtWfzsME850atTr5y88=;
	b=Is+tfQOFpKH4a0gveqylaH/Bli88UhDTFkll4FhAdSJLLYFq9RgNQZ13UCVRk+ul96rG
	 mCHEVuOjZNuzJTw8fLRsKVrZiBzf0VtIMAnd9ipXRkIbVK3l95P4sU4df62u6o3Xq6T0N
	 +28ucatvq8Ah7KbEDYzuM96PSb19eTTb4o0RIja1H10HYjyxjHpBZLXJAl74+KlrBbXY7
	 AtlphPZOROV+C888QVyh78z7qCqo2t5Bx7Nn2PHLWYhX0uaMB+PvnJa+SIFyMG3Tcp3im
	 dy1QJwB6edC1fEcWxmMH/bQGBU4S8yrI22iLQpLJh3bGKVD0/S3Pg+1JoJPPGEm83Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mu1LLSrb;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B0606A322;
	Mon,  9 Nov 2026 05:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D0B0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mu1LLSrb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mu1LLSrbUforV64iiqvmLBcZBvjKdmB1+qzO1laEiA3KSJcj2qQ9pPj3gtVjZ96WVPvf7ee34bk40
	 4RBCdh0VEmByamH70AWtMVfrekrfxw7pnXbtFReD+9cBZgeQbPRL1fUhzfuYB3flupb+Dtmscnd98C
	 BGbRHhw4tVIfykO0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af159bf31e-c65a7;
	Mon, 09 Nov 2026 13:27:28 +0800 (CST)
X-RM-TRANSID:2ee96af159bf31e-c65a7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af159bcc11-8263c;
	Mon, 09 Nov 2026 13:27:28 +0800 (CST)
X-RM-TRANSID:2ee86af159bcc11-8263c
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-mtd@lists.infradead.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	michal.simek@amd.com,
	linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: rawnand: arasan: fix GPIO CS leak on probe error paths
Date: Mon,  9 Nov 2026 13:27:24 +0800
Message-ID: <20261109052724.1032-3-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261109052724.1032-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109052724.1032-1-zhaofeng2@cmss.chinamobile.com>
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

The CS GPIO descriptors acquired by anfc_parse_cs() via
rawnand_dt_parse_gpio_cs() are only released in anfc_remove().  Two
probe error paths leak them:

- anfc_parse_cs() itself returns -EINVAL on an invalid DT GPIO CS
  layout without releasing the freshly acquired descriptors;
- anfc_probe() bails out when anfc_chips_init() fails, leaving the
  successfully parsed CS array behind.

Factor the gpiod_put() loop of anfc_remove() into anfc_put_cs() and
call it from both error paths as well.  gpiod_put() accepts NULL, so
this is also safe when the default all-NULL CS array is in place.

Fixes: acbd3d0945f9 ("mtd: rawnand: arasan: Leverage additional GPIO CS")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master.  Not runtime-tested (no
Arasan hardware).

 drivers/mtd/nand/raw/arasan-nand-controller.c | 26 ++++++++++++++----
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1391,6 +1391,14 @@ static void anfc_reset(struct arasan_nfc *nfc)
 
 	nfc->cur_cs = -1;
 }
 
+static void anfc_put_cs(struct arasan_nfc *nfc)
+{
+	int i;
+
+	for (i = 0; i < nfc->ncs; i++)
+		gpiod_put(nfc->cs_array[i]);
+}
+
 static int anfc_parse_cs(struct arasan_nfc *nfc)
 {
@@ -1413,7 +1421,9 @@ static int anfc_parse_cs(struct arasan_nfc *nfc)
 		if (nfc->ncs > 2 && !nfc->cs_array[0] && !nfc->cs_array[1]) {
 			dev_err(nfc->dev,
 				"Assign a single native CS when using GPIOs\n");
+			anfc_put_cs(nfc);
+
 			return -EINVAL;
 		}
 
 		if (nfc->cs_array[0])
@@ -1469,23 +1479,23 @@ static int anfc_probe(struct platform_device *pdev)
 
 	ret = anfc_chips_init(nfc);
 	if (ret)
-		return ret;
+		goto err_put_cs;
 
 	platform_set_drvdata(pdev, nfc);
 
 	return 0;
+
+err_put_cs:
+	anfc_put_cs(nfc);
+
+	return ret;
 }
 
 static void anfc_remove(struct platform_device *pdev)
 {
-	int i;
 	struct arasan_nfc *nfc = platform_get_drvdata(pdev);
 
-	for (i = 0; i < nfc->ncs; i++) {
-		if (nfc->cs_array[i]) {
-			gpiod_put(nfc->cs_array[i]);
-		}
-	}
-
+	anfc_put_cs(nfc);
+
 	anfc_chips_cleanup(nfc);
 }
-- 
2.39.2



