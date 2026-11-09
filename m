Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187773;
	b=bkZsbpPQHvEf+a7Uak2ZBG/yUiKBd8jz5ZDgGitluZjvSJrXFLvAIXYMrkLX3qZydu2C
	 hVzBYnqZ/xwID4h5o/gpXBmCxd/i3b4Hk2/qluL8g/O/RWRLDuSaYi91und83uZdlBOyi
	 sKxZOExDeNpm0msHKZIvA38JxHPbcr1G6dXW48XubsUx5MG7+cf75iegy3XHZTrUup6E+
	 E2LsK0LdIB7ogd9xgreZiMfHIhr5Ud4mQf/pnoowd8DO5ic9VSTpV3picQVwjlaxhYvK6
	 q8JyPZccPdm6m6vvlGpO2xZqLI9KJgqqAm3UPCsRNivSpUmjF01Wmce3ICjbzIqAgjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1LGO8kbqRjWmKCJdidhOgv7673/JPMkKyXcsVD0AoBg=;
	b=krbe1nMrioXVmbL/tE+u7CuFHxW2LTr3kpaw6f5YGTNVAVqPbzQHTMtjP9z61qsmWSeC
	 ltmM/7NedX8RlTSOpT9+g64XMB8fMRnVnFFelPhIU8pgv3VJ3wyRXdMKwu9vmRq0I2R8i
	 rLqBppx7dPyySg2D0xOAGKVsSzNH5ITUs2g5UV6VlcCl1poMt+OjcPtcvfKR5ylgefWtp
	 fyaJx4sCtA2mio//djtf84FErIDF5uUgj5sAzxd4GRxMedSea22Wm/ssReZ5a1ozm+SKc
	 pv/imkxcIUWjbNUGptuRH0nfTvjWnzC4AyTpPtCQSmkKiUK7U+hWYMsy0SHfsZJGtpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFbwDHi1;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E3606D477
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 968E3606D477
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFbwDHi1
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-716da696c1aso245580eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187771; x=1794792571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LGO8kbqRjWmKCJdidhOgv7673/JPMkKyXcsVD0AoBg=;
        b=AFbwDHi1H24PUb/SvFwKhJqkhV1gmrS4q3qIyQBzWWfXdN/mNRHn2Osx3mZa+A35ty
         b7NXioFL9MohkRiqLOb69geSNH4u/QlClxnwXHWMLzOH07yqobQNV3slNXTpP64TJvY7
         ouwUI3FFzD2YhxgRxYiiQALgTdrgQcuhXNQYn+vuLtpTQHY6iPWpcGOX3EKo2vItC9W6
         7sUsHClT/9kpDrO0VMPMnLrA1RBhEVUzmXLeVM8Aw8oOuLrKCYn4blUn5nvYfTm66twf
         oIvVN/JuIgxZ/ybiSrgrHyO0TkRsHx3POEwtIlaQSolsrEWx16EQbEmR/13+RSJvaJWK
         SOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187771; x=1794792571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LGO8kbqRjWmKCJdidhOgv7673/JPMkKyXcsVD0AoBg=;
        b=Ba6z5/V5mDRHGhXooBwnwgaDiAmJCOPDUN6Aee5BSPYxn8ACPAQY4zG6lAI1cgsrPI
         +K+P1RhA+HO1jIx7YvbhilyeIkiFRfvBHWWxxF0/yVVi5iZx6aLjZ2ePQ8kHei7f7ybq
         awYV0NIYaUzTbEicv5OI8X00pAdSJ8h8Sgk22mQzF4aGurtJ1f1ZrKoHvW/BWngBdb66
         AoXixWM03PqLDsycSv+DVb8CPfa42MrXZDTyKCbPY28oFiFkrzW1C1SuAjh/hfVlJTK2
         1pNyTlIzucSP7PJxohfuPNylQd45OdW8047eubE9FPWjv9i8bofoVMSxGT1fRC4nEGq4
         av2g==
X-Forwarded-Encrypted: i=1; AL+hErFchPaFcjXIssGywHGEEKGCjuWCUUdYFm094dshTDbSGA6QmlW7YRvpsBz1gsGluTmZS4PXHxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OP4q7yLfu+PkfDVfl9tv9ZzNlxlBUhy6S5cpjkMi9XBN6Cl4l
	VEwc7vp00nBEw+IKyKJ2JHb8pn5hxoOI09EXA2hpHxcyCaxAUySFDFRJ
X-Gm-Gg: AYBFou2CCKKWRLQkomnZ6TnidbSTt/RCimRIEJ+WIARUr9vUkpEjblDheyXoQjNCuzf
	KwVqELt9tx48atz5U6TuKywvxSoS75LwnJs5bpV5ta3rs7cHBfajKesjMjnKqeytVFSb1vIn6GW
	MNbMkXl1XlWgZY5CNsEPgHsSMLzGfBQjNImk74XIUR3CSBVmb9Zg9TFyxdUDOuSxDAi59UTjOBO
	iHPz5lP/XrriCbntRsgrCJ1PAjzDehc084m+Cg+kbp+y4kOptLP2LIKlR5x2Oki1viwW8B2oYEn
	rUzCn7+gy8SQawTyWwpK0Qfj7MrZXJEBii8e2UVo7T5PrrtYV0D9D8d/MX/iiX5sFrAYs2aBeAw
	ZJXpcGXGvJRwkXKwKjpcYmnMe3lW+0sNV30Uqc48nayDc+lR9N3kjP/ZxPW9knlh0QfYyamUJgu
	Z2o59nDu4vkC8SiPCEbCMsIOUTsZVURDRKGbZB0/+eGS4VubSJ5x6meaBTeghwMIltY12O4WcBv
	DLucKHcYak4VX2l03lsPiB5gzh5qB+RAaeKz0lORq73JMKwYdioaABaC/6gsC1F7+GfKkeSws3W
	UHegSyFT4AuG4UfBamnZjtGpUW1UGFqVvLOLWmfkQe9lUv3GbCeO9iUSXOR0Tq/KGW9LqB4nHUH
	Wa1VVw1yCsagquZDNAcnWD8Y4ilnuKO9hVNvF1zQFDqFFek9oYH9i5oodfbdYdkuERkO9pj+WQU
	cRGqCwBNxW/Lk9p5RKL5XXFoMh1tmQiw0aWuM4dS65usmg15Q/GW/u
X-Received: by 2002:a05:6820:83d8:20b0:715:2147:23a9 with SMTP id 006d021491bc7-7170f23a98cmr975721eaf.19.1794187771525;
        Sun, 08 Nov 2026 17:29:31 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm4225818fac.10.2026.11.08.17.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:29:31 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 18:29:23 -0700
Subject: [PATCH 4/4] mtd: rawnand: r852: restore SmartMedia and ECC
 initialization
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-r852-smartmedia-attach-v1-v1-4-56d08c0571a2@gmail.com>
References: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
In-Reply-To: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

r852 uses its own NAND controller and attach_chip callback, but
sm_register_device() installs sm_attach_chip() on the unused legacy
dummy controller. nand_scan_with_ids() only calls the active controller's
callback, so the SmartMedia setup is skipped.

This leaves the generic OOB layout and bad-block criteria in place,
omits the SmartMedia bad-block marking callback, and skips rejection of
unsupported page sizes.

The same conversion removed the hardware-ECC default from probe. This
PCI driver does not set a NAND device-tree node, so rawnand_dt_init()
returns without selecting an ECC engine. The zero-initialized engine
type remains invalid and nand_scan_tail() fails with -EINVAL.

Restore the hardware-ECC default in probe. Export sm_attach_chip() and
call it from r852_attach_chip() before the ECC-engine check, so both
hardware and software ECC configurations get the media layout. Propagate
its error before scanning finishes or the MTD device is published.
Remove the unused dummy-controller setup; r852 is the only caller of
sm_register_device().

Fixes: 7ef969a04228 ("mtd: rawnand: r852: Move the ECC initialization to ->attach_chip()")
Closes: https://lore.kernel.org/r/sashiko-outbox-204208@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c      | 8 ++++++++
 drivers/mtd/nand/raw/sm_common.c | 8 ++------
 drivers/mtd/nand/raw/sm_common.h | 3 +++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index e78606b97b42..ce7def018099 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -820,6 +820,12 @@ static irqreturn_t r852_irq(int irq, void *data)
 
 static int r852_attach_chip(struct nand_chip *chip)
 {
+	int ret;
+
+	ret = sm_attach_chip(chip);
+	if (ret)
+		return ret;
+
 	if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST)
 		return 0;
 
@@ -883,6 +889,8 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	chip->legacy.read_buf = r852_read_buf;
 	chip->legacy.write_buf = r852_write_buf;
 
+	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
+
 	/* init our device structure */
 	dev = kzalloc_obj(struct r852_device);
 
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index a6387111d271..291aa21dff4f 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -167,7 +167,7 @@ static struct nand_flash_dev nand_xd_flash_ids[] = {
 	{NULL}
 };
 
-static int sm_attach_chip(struct nand_chip *chip)
+int sm_attach_chip(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
@@ -186,10 +186,7 @@ static int sm_attach_chip(struct nand_chip *chip)
 
 	return 0;
 }
-
-static const struct nand_controller_ops sm_controller_ops = {
-	.attach_chip = sm_attach_chip,
-};
+EXPORT_SYMBOL_GPL(sm_attach_chip);
 
 int sm_register_device(struct mtd_info *mtd, int smartmedia)
 {
@@ -200,7 +197,6 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 	chip->options |= NAND_SKIP_BBTSCAN;
 
 	/* Scan for card properties */
-	chip->legacy.dummy_controller.ops = &sm_controller_ops;
 	flash_ids = smartmedia ? nand_smartmedia_flash_ids : nand_xd_flash_ids;
 	ret = nand_scan_with_ids(chip, 1, flash_ids);
 	if (ret)
diff --git a/drivers/mtd/nand/raw/sm_common.h b/drivers/mtd/nand/raw/sm_common.h
index 57fc9f86f9ee..599fce778fb2 100644
--- a/drivers/mtd/nand/raw/sm_common.h
+++ b/drivers/mtd/nand/raw/sm_common.h
@@ -33,6 +33,9 @@ struct sm_oob {
 #define SM_SMALL_OOB_SIZE	8
 
 
+struct nand_chip;
+
+int sm_attach_chip(struct nand_chip *chip);
 int sm_register_device(struct mtd_info *mtd, int smartmedia);
 
 

-- 
2.53.0

