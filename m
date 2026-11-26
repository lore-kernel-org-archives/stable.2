Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723508;
	b=XqaaoCOQnWyshrVFCkMm5kFCe8zk6PdaHXTFc2oTBIN0nMoBho6qDT2HQAAi6WJodfhb
	 rlBwPunM5sW/eHCglfaDtZWKME2zwlsjdNJoydl26E8IRfR/lGFXwyFHNHJ5ccSLyVmVt
	 CJqHxiAhaQsT2kRND8LpgrfmcsnYbMfMa6RT+VYMmJZoQh4huT8BkCnybeMRgEj5PwMxY
	 LxcWdtwMUHCgVeD+lPw7aXo6ylCqUROTHgvQIXuRXWmMnaDFgJNG5u3aqomYBnzbHDNW5
	 s+KO4fysNIbMHwhlvorbD8+RUrIYW/JEVkVCRc44JJU4nk/GzBJ5SwFK6q3y2eRAaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xNZN4HN0iarz8uiHWLWlVZj+K8LaQpc5Il8O8NMbuXc=;
	b=RqdUT9EAghwlsEMXs525hOIRbzzcg+DSRjrkPGxXppRpnHvGpVYVkKb6OshyZ87wxqwG
	 qGBzf1Sz2ZLdpc/WazoeqQTUoLttoKcNHlT68z757gPN0+GiQfZQFxWj6/13BQTTNxh2z
	 Ru/7n/Zsrt6yv1FnEb8HSgMGe6MZwmWE5TS6whi/joHwAsALvuHzpZwboM8SzvsxJ9NRq
	 oKz/jrpC993Kkl07ewuNO0VV67IzVhxA4shTeYkkaC5B5MxK9hJDj/sXVdOSryI6HBB4r
	 F1WFsYKJJQ9UxaUb+7yxy+rniZa4dVV8BV/kITxQl51Ihc5BJXLuH0gWEIiUcp1lttw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LAX1hmyH;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EC606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LAX1hmyH
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71b0d330acfso5414261eaf.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795723507; x=1796328307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNZN4HN0iarz8uiHWLWlVZj+K8LaQpc5Il8O8NMbuXc=;
        b=LAX1hmyHqpxBatYsudig5gte2uihW8w7/6EP+pCD1vKzYRn0+T90EX8PCLIemFQTLU
         xrsCem07AcZ3W9SjRZxdvXSK4c0N91R5OAxAmpcA9qITssqTgP9ttVk1JWP5edcOENYi
         ZmbMyj9bUDK0af8wsOqAasUGAZXHVTc2YGNRjwtBW8bYP0aakYgn2+J1m/HUWeUZUdc8
         uyWvw13bPRBs14A5gW5jPIbBSRebCE4OH20+EBjazzb+Brw/okSNEz/QVseSXO9c3qNJ
         6u+8armK4dL6Altru1bBqHlq8smlq8udcK06qZsckBUM3ZQm/TIThxtSgRQ+8sKwbm6T
         ZCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723507; x=1796328307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNZN4HN0iarz8uiHWLWlVZj+K8LaQpc5Il8O8NMbuXc=;
        b=CUKkDDMN9npvmxn5lh2BNvFsgBhWH6wnNFh+fUC9ASzi3x0dTNz2d/ZMYZ0s5bRfta
         ByjURkWrikm3Pyy3AbEX/+L2+3OFBwhN1YAi30icKpaKMhb1N7uKIl2eDuidGDjfqT7p
         7vo6hScNzbiPr+a0Qs/ilGXVGmiO2FrDAFafqTb0m9P/yBOPqr5aWsLsjr6HY7EJ7zfe
         IkQCmPDxE8ttoHbVhLoOzzq6LbLEZwmlXf7rtaupG29ufeU/re4NdvsidPcABtRWE0sj
         R+zffqv7CxAByzEpLDIGqi25yjmbXNJ6T1GhqZl7OmaZNH/V8pRe8R1SkZhfT/KRB+rG
         fm0A==
X-Forwarded-Encrypted: i=1; AL+hErHZp0eYUI+WcVB3TMeSNgI5kqV9yNH1OjB4NTFH/b2lvrykLO2RaX6TBDTAwbFMADcZoMqsMds=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HdAzRyM7VXBM2V+mXW00DADGEno69Yq9wdg+GhNmacRLBb7L0
	qr12py9yQ5LSvFC3Xo/jC09UVfTnkAlyT3KoVVfyUf2PsmQToHjgOKwu
X-Gm-Gg: AZFdTZddnRlJ3RLw6wbkrhoewrcIeFXV7M4VZx9pCnjlG2LgSdOIUxYuAI/8E0nCKRu
	dVKnQSNMqzLeTMOtofWyVjagfJQ+HMTBIhwVjYmwg0G+B7fHZP5N+4+vNBb8Mjd9081hTJ8iq5R
	qA99pbvqUpModY7PMMxwXACSQBEw4oO1VUqtKQ8d4zM2Cj2u68NELMeSa79lwVre0lxKd5NEcj5
	f+cmGV4FvgB+gYcJo7tkgwqs28EZPjtlnJ95v2/Wp3Ade6Xh2omjg3iJgud06FPZcWXS8sCtgyV
	9VO9e50iR0TFiQXib2xSZrHItFaEqmnq0GoH81Q0GpBERW+ThYWqDoLzUVgDyGvWf2m0MeCG7OW
	nCSjOy2ce0XQYvwuH1RqEclQ1nOdiLZddhNzCVxnnGrip7qgFyIuZedyYoBQS/KgAHulPbznNnF
	/vuVTu3TrfiUt5PblzF2tmL0+K3NMdjoL0F1b/OzSraeUj2waWgb9j5TlF4xrstwusitBoVQmt/
	YBpRZ9u7/UD30QN9dZv5JMO/2Tc7LwVCgVKuDz2Sum3/d9Z/1qV+J18BFa3orMIeVMPTBqQigBT
	sF9LwmoLQGR4A486xRxOlQHXTr6wx9xh+FzCu3PkcfHyM1GCsvYUSouKH4l9UIf3iRhbaYpyPGa
	v2eCQF0UVKxGo+VVnqVGpQ9hxR31it310tv9QqVsNlaXytw5tfnKeUI2kjVHFDd2AdioRTfSF6i
	N1JVBC5ZQG1ysMhmCDU3YqcqNsxnlHAOwkXE1u9G0VPSS7cYl8UCvC8Q==
X-Received: by 2002:a05:6820:1628:b0:713:d536:1d33 with SMTP id 006d021491bc7-71b3277f48fmr16157284eaf.46.1795723506801;
        Thu, 26 Nov 2026 12:05:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm19548249fac.9.2026.11.26.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:05:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 26 Nov 2026 13:04:51 -0700
Subject: [PATCH v3 1/2] mtd: rawnand: serialize OTP operations in the core
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
Message-Id: <20261126-submit-rawnand-operation-locking-v1-v3-1-cd3794332f23@gmail.com>
References: <20261126-submit-rawnand-operation-locking-v1-v3-0-cd3794332f23@gmail.com>
In-Reply-To: <20261126-submit-rawnand-operation-locking-v1-v3-0-cd3794332f23@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Kyle Roeschley <kyle.roeschley@ni.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

OTP operations on Macronix MX30LFxG18AC chips switch the device into a
dedicated mode before reading or programming pages. Their protection-
register MTD callbacks bypass the raw NAND read/write wrappers. A
concurrent NAND operation can therefore access the device while OTP
mode is active, and OTP access can bypass the normal wait for a
suspended chip.

Add OTP callbacks to nand_chip_ops and route raw NAND protection-
register requests through core wrappers. The wrappers hold the chip and
controller locks around each callback, so normal NAND I/O cannot
interleave with OTP access. If the chip is suspended, OTP access waits
for nand_resume() to clear the suspended flag.
Device-specific callbacks retain target selection and OTP mode handling.

Fixes: e87161321a40 ("mtd: rawnand: macronix: OTP access for MX30LFxG18AC")
Cc: stable@vger.kernel.org
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nand_base.c     | 106 +++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_macronix.c |  32 +++++------
 include/linux/mtd/rawnand.h          |  24 ++++++++
 3 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 58dbcb004a62..5c877e2536e4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6180,6 +6180,98 @@ static const struct nand_ops rawnand_ops = {
 	.isbad = rawnand_isbad,
 };
 
+static int nand_get_fact_prot_info(struct mtd_info *mtd, size_t len,
+				   size_t *retlen, struct otp_info *buf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.get_fact_prot_info(chip, len, retlen, buf);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_read_fact_prot_reg(struct mtd_info *mtd, loff_t from,
+				   size_t len, size_t *retlen, u_char *buf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.read_fact_prot_reg(chip, from, len, retlen, buf);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_get_user_prot_info(struct mtd_info *mtd, size_t len,
+				   size_t *retlen, struct otp_info *buf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.get_user_prot_info(chip, len, retlen, buf);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_read_user_prot_reg(struct mtd_info *mtd, loff_t from,
+				   size_t len, size_t *retlen, u_char *buf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.read_user_prot_reg(chip, from, len, retlen, buf);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_write_user_prot_reg(struct mtd_info *mtd, loff_t to,
+				    size_t len, size_t *retlen,
+				    const u_char *buf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.write_user_prot_reg(chip, to, len, retlen, buf);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_lock_user_prot_reg(struct mtd_info *mtd, loff_t from,
+				   size_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.lock_user_prot_reg(chip, from, len);
+	nand_release_device(chip);
+
+	return ret;
+}
+
+static int nand_erase_user_prot_reg(struct mtd_info *mtd, loff_t from,
+				    size_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	nand_get_device(chip);
+	ret = chip->ops.erase_user_prot_reg(chip, from, len);
+	nand_release_device(chip);
+
+	return ret;
+}
+
 /**
  * nand_scan_tail - Scan for the NAND device
  * @chip: NAND chip object
@@ -6443,6 +6535,20 @@ static int nand_scan_tail(struct nand_chip *chip)
 	mtd->_block_isbad = nand_block_isbad;
 	mtd->_block_markbad = nand_block_markbad;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
+	if (chip->ops.get_fact_prot_info)
+		mtd->_get_fact_prot_info = nand_get_fact_prot_info;
+	if (chip->ops.read_fact_prot_reg)
+		mtd->_read_fact_prot_reg = nand_read_fact_prot_reg;
+	if (chip->ops.get_user_prot_info)
+		mtd->_get_user_prot_info = nand_get_user_prot_info;
+	if (chip->ops.read_user_prot_reg)
+		mtd->_read_user_prot_reg = nand_read_user_prot_reg;
+	if (chip->ops.write_user_prot_reg)
+		mtd->_write_user_prot_reg = nand_write_user_prot_reg;
+	if (chip->ops.lock_user_prot_reg)
+		mtd->_lock_user_prot_reg = nand_lock_user_prot_reg;
+	if (chip->ops.erase_user_prot_reg)
+		mtd->_erase_user_prot_reg = nand_erase_user_prot_reg;
 
 	/*
 	 * Initialize bitflip_threshold to its default prior scan_bbt() call.
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 16847f28b19d..30e42594daec 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -326,7 +326,7 @@ static void macronix_nand_deep_power_down_support(struct nand_chip *chip)
 	chip->ops.resume = mxic_nand_resume;
 }
 
-static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, size_t len,
+static int macronix_30lfxg18ac_get_otp_info(struct nand_chip *nand, size_t len,
 					    size_t *retlen,
 					    struct otp_info *buf)
 {
@@ -368,18 +368,16 @@ static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
 				 feature_buf);
 }
 
-static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
+static int __macronix_30lfxg18ac_rw_otp(struct nand_chip *nand,
 					loff_t offs_in_flash,
 					size_t len, size_t *retlen,
 					u_char *buf, bool write)
 {
-	struct nand_chip *nand;
 	size_t bytes_handled;
 	off_t offs_in_page;
 	u64 page;
 	int ret, cleanup_ret;
 
-	nand = mtd_to_nand(mtd);
 	nand_select_target(nand, 0);
 
 	ret = macronix_30lfxg18ac_otp_enable(nand);
@@ -418,11 +416,13 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 
 out_otp:
 	if (ret)
-		dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
+		dev_err(&nand_to_mtd(nand)->dev,
+			"failed to perform OTP IO: %i\n", ret);
 
 	cleanup_ret = macronix_30lfxg18ac_otp_disable(nand);
 	if (cleanup_ret)
-		dev_err(&mtd->dev, "failed to leave OTP mode after %s\n",
+		dev_err(&nand_to_mtd(nand)->dev,
+			"failed to leave OTP mode after %s\n",
 			write ? "write" : "read");
 
 	nand_deselect_target(nand);
@@ -430,22 +430,22 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 	return ret ? ret : cleanup_ret;
 }
 
-static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,
+static int macronix_30lfxg18ac_write_otp(struct nand_chip *nand, loff_t to,
 					 size_t len, size_t *rlen,
 					 const u_char *buf)
 {
-	return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *)buf,
+	return __macronix_30lfxg18ac_rw_otp(nand, to, len, rlen, (u_char *)buf,
 					    true);
 }
 
-static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_t from,
+static int macronix_30lfxg18ac_read_otp(struct nand_chip *nand, loff_t from,
 					size_t len, size_t *rlen,
 					u_char *buf)
 {
-	return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, false);
+	return __macronix_30lfxg18ac_rw_otp(nand, from, len, rlen, buf, false);
 }
 
-static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_t from,
+static int macronix_30lfxg18ac_lock_otp(struct nand_chip *nand, loff_t from,
 					size_t len)
 {
 	/* See comment in 'macronix_30lfxg18ac_get_otp_info()'. */
@@ -459,7 +459,6 @@ static void macronix_nand_setup_otp(struct nand_chip *chip)
 		"MX30LF2G18AC",
 		"MX30LF4G18AC",
 	};
-	struct mtd_info *mtd;
 
 	if (match_string(supported_otp_models,
 			 ARRAY_SIZE(supported_otp_models),
@@ -474,11 +473,10 @@ static void macronix_nand_setup_otp(struct nand_chip *chip)
 	bitmap_set(chip->parameters.set_feature_list,
 		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
 
-	mtd = nand_to_mtd(chip);
-	mtd->_get_user_prot_info = macronix_30lfxg18ac_get_otp_info;
-	mtd->_read_user_prot_reg = macronix_30lfxg18ac_read_otp;
-	mtd->_write_user_prot_reg = macronix_30lfxg18ac_write_otp;
-	mtd->_lock_user_prot_reg = macronix_30lfxg18ac_lock_otp;
+	chip->ops.get_user_prot_info = macronix_30lfxg18ac_get_otp_info;
+	chip->ops.read_user_prot_reg = macronix_30lfxg18ac_read_otp;
+	chip->ops.write_user_prot_reg = macronix_30lfxg18ac_write_otp;
+	chip->ops.lock_user_prot_reg = macronix_30lfxg18ac_lock_otp;
 }
 
 static int macronix_nand_init(struct nand_chip *chip)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 43fefff02025..b08aaadf133c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1191,6 +1191,16 @@ struct nand_legacy {
  * @unlock_area: Unlock operation
  * @setup_read_retry: Set the read-retry mode (mostly needed for MLC NANDs)
  * @choose_interface_config: Choose the best interface configuration
+ * @get_fact_prot_info: Get information about the factory protection area
+ * @read_fact_prot_reg: Read the factory protection area
+ * @get_user_prot_info: Get information about the user protection area
+ * @read_user_prot_reg: Read the user protection area
+ * @write_user_prot_reg: Write the user protection area
+ * @lock_user_prot_reg: Lock the user protection area
+ * @erase_user_prot_reg: Erase the user protection area
+ *
+ * Protection-register callbacks are called with the chip and controller
+ * locked. They select and deselect the target as required.
  */
 struct nand_chip_ops {
 	int (*suspend)(struct nand_chip *chip);
@@ -1200,6 +1210,20 @@ struct nand_chip_ops {
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*choose_interface_config)(struct nand_chip *chip,
 				       struct nand_interface_config *iface);
+	int (*get_fact_prot_info)(struct nand_chip *chip, size_t len,
+				  size_t *retlen, struct otp_info *buf);
+	int (*read_fact_prot_reg)(struct nand_chip *chip, loff_t from,
+				  size_t len, size_t *retlen, u_char *buf);
+	int (*get_user_prot_info)(struct nand_chip *chip, size_t len,
+				  size_t *retlen, struct otp_info *buf);
+	int (*read_user_prot_reg)(struct nand_chip *chip, loff_t from,
+				  size_t len, size_t *retlen, u_char *buf);
+	int (*write_user_prot_reg)(struct nand_chip *chip, loff_t to,
+				   size_t len, size_t *retlen, const u_char *buf);
+	int (*lock_user_prot_reg)(struct nand_chip *chip, loff_t from,
+				  size_t len);
+	int (*erase_user_prot_reg)(struct nand_chip *chip, loff_t from,
+				   size_t len);
 };
 
 /**

-- 
2.53.0

