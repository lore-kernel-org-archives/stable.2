Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430059;
	b=VxyE6gXTbIDlRngdbetrVK2rxaYC83o6WFhrmaDOcQLm8lKR4D/bOrY5qjNr08JNKHna
	 FMNB7V07r1g/0bO6OJRI2fntvFpMKVc1HKSWAbBJe+ZfK+SBixkUeEOt0yKVmUtNEBpVf
	 e2Vc+ULC3LrP5ViJ7kKC0TE3Ezm9EeQjp9gEr7xUdadRwvy91lH902+SU0iDzcs7SGWQK
	 YpayWovCV+UUj4GyTe6JX3lphR8hGzppsLlxwTQlAnSrCV+Zci8ctXZFeC/0LDlrQWQJa
	 hrZJcfr8HZtAcHnNlZCcJvN7oBaTh45tTJt3NBhFfBSMRp4npxlCLkaHHyzJqCjEo8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=rO0PLvuw6ce5QXFOrLKO42ZXm/30hY+KUJ+GebPFvXY=;
	b=G7n4e1lAB5zia1ZCgHYjLSG8M/+rOuDODEG55UWkRXOKcGnrfP0D7VscA5v1O2SRky22
	 sGwc+TB1PV54luegLyL/CNzpjjKJkHQqepLcaOBwOj2HN4XRUlCQlvPIRuzFYlQJpKrlI
	 8YNMPMKrmL9PNn5IypwqxPnyJAphjp2F1fxyeuj4xi4Ddkgus8OqoySKDhgvPKHuiCMbt
	 1tHBWivF7/MduguVRcRz3Kyl9a6PbSIdkhBfAtCDEFgC1KuSDY9fKeak+paFRKzSirIhb
	 Q5CQeGNgZs7ISqe+wvHLLfu1MrBIS2rQWMAFZyLXrm77LxEIbCu8K4DYAIzRA+XP0pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=SJX+LAaz;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C348606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C348606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=SJX+LAaz
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so2139952f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795430057; x=1796034857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rO0PLvuw6ce5QXFOrLKO42ZXm/30hY+KUJ+GebPFvXY=;
        b=SJX+LAazpKFZy4znH6MNzecKcIgg+Rjmvh7Zp3XhlehrLDz2DmdfiXpsPG1qYiiUWx
         z8nE+LqP59RXRUSZ/4C/S/gwY9LaARwlwx5R+Y2JH9Mh8v2CIULk1hQzEg8Shr00VyB8
         HFUEVxUetx1SqELAwQODf0tj48wlRJYKlr2w3Dzm5eiVgDfyZwtR3PM4q9zxQhDlXvR8
         Gzi2p1uCsoGc5zYMVD9fEIggaDorkwCV8Efi0o9kRAA65VZ96YEaMV5cARd4KFuLgfng
         ix6Fxf9HH7NmYF4uXi1p05wYV8swOtnDReRM2cPyqZqZcd5YyKbfbXRSEFVJXwtkuvN6
         X3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430057; x=1796034857;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rO0PLvuw6ce5QXFOrLKO42ZXm/30hY+KUJ+GebPFvXY=;
        b=F2K2Oy32h7yFtIZkdFxZQMnxHiLg0b4MNanx0a1Emypi4cPGBQaYd+ijWZLzs38U/S
         f1U0zCbzo4f0BH3IfjqNgTF+7lh7CH+XLybddQ0Me+Ozx3htp7PMmst9B/E2arJBD5x1
         rCo8NjVcvKnwGWILU4ULSPZrVh7O/its7XTg95Omn+gBgvYRpLhm2Vo8pzuHddAKS4bF
         9xd3BC3DSKeBvjygwH7Pnc2vyUhXaVNnieALXBprj19W0zHHNJ8GIclnAj2ntW9T/W4G
         MYHJRFc8shYPrz2wmTdgAGaTBzgOJfgQEl1MDNqfwswQDVk0sZMxpgYFHR09pnJHaKUh
         8f/A==
X-Forwarded-Encrypted: i=1; AL+hErHIvFSZvB5A6hJp9mBR/wVNL99cU2DinpDu/Zpgm9nrgvcsPl4eHYNxVgj9W1rhOgn2pO3q3dA=@vger.kernel.org
X-Gm-Message-State: APuU4Z80vynYiBxqA43Z3uLFg2b1pjhJdw8W4/pNGkkYV5HRjKzTkdDX
	DFAQgSVdvKP7HqPeBa9ttRD3hQjMqy7TXyulAUjBAHMqsqaAq2BCcyeyu2zBKhiN3+M=
X-Gm-Gg: AZFdTZdaEEFUqsvkREHkxoFfTNEycoMyW/JHGhAs+AbKJAwZfAlkxcqzYp71I7YcdMl
	1NE3CfnoyETaKOyhVn8SEISgtlUTY1J8CP0l67w57kToAtmzJzDJO1c2KqlhebVCGBsKuzDQkci
	/QBff74i6vgI+d0C8UHneGexN9QPYdOJT/WmhUVFCqxUiDFjoHb0YYx/SsjXV75R7XpB+fsZEtl
	FpTOpDqq1tuQRRMsw1HguTFo+lefYVWQUgaJdIRHy0Hznj84ghnpn4VLOmLejZUFcQ61rfmlqkE
	2n5SGosbsS3dV3VZksPUlCsGE8ojaLuQZH/MtTepkn9Iq49fWLoUmZ1wDbBAx1OuM+zTSHBKkEm
	sL7EKdQFjl0pIbS/mcaL37T7kQdNTeV5oJ8e2gqAV97y23F/1ad0TjaIQh+Iq+tRD4t+1Yalk+s
	RsPaIaCGhxGAn4PnH4YFpXFdED2rpKpLQKDSzZShl2sU2PWa1Aoh97XF+aSs8B0U0q0ZsL8ulMC
	ZItOu0J6Pwlzp+Er91+q8SU5qwuAVM0r19XiZ0ovCthuXse6tAcztMsfwQx7wclvmS2m8MRv6O9
	HLHhXfmUZgvnS3uInFAHQsp3F7SOgDSarj3xNEiAKB2IthPzeV1FyDrzkan5iqNA0Jzr3B/nChV
	V7ZY+mouzCw==
X-Received: by 2002:a05:6000:2085:b0:49b:f7e8:6f3d with SMTP id ffacd0b85a97d-4aa579a93b8mr26457325f8f.18.1795430056726;
        Mon, 23 Nov 2026 02:34:16 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm22256392f8f.31.2026.11.23.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:34:16 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 23 Nov 2026 14:34:10 +0400
Subject: [PATCH v2] usb: typec: fusb302: Keep interrupt flags across a
 failed register read
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
Message-Id: <20261123-fusb302-irq-read-error-v2-1-5539a09127d8@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dgxTBIGV9zAs2jKVMQZwCkRDu
 LuAcenyJf+/N6tAwhRUGc1KaOLAXbuCPkTKNaa9EXC9stKxzhAxAz8Gm8QaWJ4gZGogkU4gN4k
 zKfmCrFPruRfy/NrF1+rLYbR3csNm2xYNh6GT916ecNv9Iud/kQkBweRpfUptgQXqi39w35McW
 xpUtSzLB5kZn0vQAAAA
X-Change-ID: 20261116-fusb302-irq-read-error-8a3ca5ef9ebc
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3912; i=alchark@flipper.net;
 h=from:subject:message-id; bh=roam5Grdtbk0Ss1UgX0o2hvhZvIfWOfQ3AePotlY4MU=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGsEFqahmkf9hJIxmk3IIEJkrEtl4kjl+kmQLMrMCU+GCErAp
 oiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmsEFqYbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlpLMA/3t2jSkrpALLo+BYCnplVjMN/lQzKQJbIYGsIAVRlXp
 GAQDl/9PRZPBbR3RzWc7ixzsAMjMQL1u+WWo5vm0KO+TxAw==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Reading INTERRUPT, INTERRUPTA or INTERRUPTB clears its flags in the chip,
so bailing out on an I2C error in a later read loses the flags already
read. On Flipper One, a NACK on INTERRUPTB just as a source raised VBUS
lost VBUSOK. The driver kept treating VBUS as off, so TCPM never attached
as a sink and left every Source_Capabilities unanswered.

Keep the flags pending until they are handled, and retry the reads a few
times, as such errors pass. Otherwise a flag left pending waits for the
next interrupt.

Fixes: c034a43e72dd ("staging: typec: Fairchild FUSB302 Type-c chip driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Added stable
- Rebased onto current linux-next
- Link to v1: https://patch.msgid.link/20261117-fusb302-irq-read-error-v1-1-a85d45b91912@flipper.net
---
 drivers/usb/typec/tcpm/fusb302.c | 62 +++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 83bd287dadc7..9fb76fdd3b7b 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -100,6 +100,10 @@ struct fusb302_chip {
 	bool intr_togdone;
 	bool intr_bc_lvl;
 	bool intr_comp_chng;
+	/* interrupt flags read from the chip, but not handled yet */
+	u8 pending_interrupt;
+	u8 pending_interrupta;
+	u8 pending_interruptb;
 
 	/* port status */
 	bool vconn_on;
@@ -1499,6 +1503,43 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Reading an interrupt register clears its flags in the chip, so keep them
+ * pending until handled: a bus error on a later read would otherwise lose
+ * them. Such errors pass, so retry a few times.
+ */
+static int fusb302_read_interrupts(struct fusb302_chip *chip, u8 *status0)
+{
+	int ret, tries;
+	u8 flags;
+
+	for (tries = 0; tries < 3; tries++) {
+		if (tries)
+			usleep_range(1000, 2000);
+
+		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPT, &flags);
+		if (ret < 0)
+			continue;
+		chip->pending_interrupt |= flags;
+
+		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTA, &flags);
+		if (ret < 0)
+			continue;
+		chip->pending_interrupta |= flags;
+
+		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &flags);
+		if (ret < 0)
+			continue;
+		chip->pending_interruptb |= flags;
+
+		ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, status0);
+		if (ret >= 0)
+			return 0;
+	}
+
+	return ret;
+}
+
 static void fusb302_irq_work(struct work_struct *work)
 {
 	struct fusb302_chip *chip = container_of(work, struct fusb302_chip,
@@ -1521,18 +1562,17 @@ static void fusb302_irq_work(struct work_struct *work)
 	intr_bc_lvl = chip->intr_bc_lvl;
 	intr_comp_chng = chip->intr_comp_chng;
 
-	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPT, &interrupt);
-	if (ret < 0)
-		goto done;
-	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTA, &interrupta);
-	if (ret < 0)
-		goto done;
-	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &interruptb);
-	if (ret < 0)
-		goto done;
-	ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, &status0);
-	if (ret < 0)
+	ret = fusb302_read_interrupts(chip, &status0);
+	if (ret < 0) {
+		fusb302_log(chip, "interrupts left pending, ret=%d", ret);
 		goto done;
+	}
+	interrupt = chip->pending_interrupt;
+	interrupta = chip->pending_interrupta;
+	interruptb = chip->pending_interruptb;
+	chip->pending_interrupt = 0;
+	chip->pending_interrupta = 0;
+	chip->pending_interruptb = 0;
 	fusb302_log(chip,
 		    "IRQ: 0x%02x, a: 0x%02x, b: 0x%02x, status0: 0x%02x",
 		    interrupt, interrupta, interruptb, status0);

---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20261116-fusb302-irq-read-error-8a3ca5ef9ebc

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

