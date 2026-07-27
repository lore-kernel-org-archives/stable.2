Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C7423EA1
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169944; cv=none; b=aCOFHwtFyE99iotr/IQTRc1TzWHJAxfEygDW6LaXDGKWCdp26zdSe60mUAELwmt5eg/lBYXJto5omeuDFDj42d+DSPJid4hWlURl2qbxm3cLfBA0rFUHOtmvO9BR8qLdtakAuqSnVKh5IDW42bl/289kOWmq4dJUK8WjDMXR6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169944; c=relaxed/simple;
	bh=RGCKEOMha9P/cJMiFFMNuTbLtfsjjddXLsvFvL+tt60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P24RlGaFliyBHbF0zZsp377Oto/X5FJw4JZaIpc/VAMNDxCCIhT32JTiW1d8/StpFeo7G8v6LdSIZp3NGNBEHqHJQVGR6+1MQB7RtzUV6pY2U+ZAUZblltNPFxCBRif/3lTNvRVBTQgPEl+qN2ptuTaEKUA9eOqTXVzrUfTp4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcGoiiRj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcGoiiRj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495635a85d2so24467235e9.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169940; x=1785774740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjStuC+Z5BSoMlb9btbKypwZnxjerVTTywVtGN/OSE0=;
        b=kcGoiiRjLmw7au3yEla2o5cWEH15nz6h5ymWmcmPQWZ6qYFp4mKTZ64gMF0DR6HQp/
         FbouctBjmBU79XgT2xCkP1jvn59PrgJlEEawAbB25kDln/yBsJ6g0V4Y7Z94Tz1s3Tdk
         iLSkZyzYs53ONfqIrbJ4+oiXrMKbAHa+t/r5JogQxdS+niKXCfyj3l3eTausYX7EvD6k
         4Jqy9dT9X0eoALfY8ac6mFqqF0L8yirHCYSzc7ZSLwo1d4zPqqTeO/BTA1L3sJA2Wlkt
         FUFmOYmdbJvUlfGIcyUlKm9pziDFkRyDoGHedkLPsBJAGK0ogtCmU6MxClW47ukpM210
         yRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169940; x=1785774740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjStuC+Z5BSoMlb9btbKypwZnxjerVTTywVtGN/OSE0=;
        b=jhf0lqLGO4Cu0zHb6TYQGccfcTHCBa1jl2hHfjMq7VGuOYAPB8yjrmyNeULJ1qIf/v
         5qwzasuNjxfLwaOWpLgq5ks8NAt8v1AwJjorwtUgNDf1YxzG18d0DWTZ1sjaJDVUP7q+
         XgMO+ROvPZwV41fOwVgMEsoMJdEaVMtFol1YIcQKxum8/MSf7C+t/IfvJQu4sWoEq9yx
         Vg89K67/hXYSrQ9JMeYE/t3/AjMArQR3jzo1yKzA/3NY8oK3H9dFRAF57RFPQAksTzs6
         y8loXwhI1OZbm5lx77GSWIDHIzLdsZfj9NchSWiMnEXe/c9eu9ADBPRMP1WUzRof8iyF
         vmDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoA3iTQUbIq4k/0OqiwTkTGbXydmhHHpasJ+l5kHzPlfaWsY5tp7FQKsXBTtJAh19OURZl5sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4PLXLJnaxhfCthhH2z/ZdwBgNcsojSiPT6kTcn8Vth2Rexg/
	89ltSX+opWQrhDRCsjSP4MkzA5mTLE1fc2+bsXhr3NxH0CbdOM3ha5O8
X-Gm-Gg: AR+sD125Oy5QtOAWGzx6Eh/H6ZspgQS2XcA17IC6/kDeKr6GUYjRTcmaJKSMjue2d6p
	NgLIo38vt4QNsQD69j/i8O30iBkogFH/jzTX/cN9HpY01jw6qgEPGX1BjDUmhXjM8tC0J/PwNO8
	BG1e6sr6Ao4tf+LgFTwSehYhqQrOyjEKD9cJAAR1NH8lpYy7TA3B32ezHS2pRazMzt71MB7ky55
	M+SgoAOu8o8kiqsAtsBfg5QGbDFoawSb2HYEteyK17uaFRrZrZ9Ova3FNM+11CG46In4xTek+cN
	hS19WtMiQ5kbH4jQgJssGLXb+3mKEN+tNmYi9NHorXYhHKXbVOeBTVNMEtNf0THIsYpz8axBunO
	fzNt3N2LLDc4G5g/keP5heNzx30cI3j9fPM2wVqzysIDaPdVqorLpXkYXL36K/HbPOVbpE2hM7J
	J5EGVSxoxI4HAMvKnLn735T1pUiJA72bsjMPOud0NbLdwt9ERil2/UJVR9HHmOGOc7
X-Received: by 2002:a05:600c:5253:b0:495:636b:e519 with SMTP id 5b1f17b1804b1-496b56ff142mr126651835e9.21.1785169939939;
        Mon, 27 Jul 2026 09:32:19 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs192625.centertel.pl. [46.134.91.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44a91ebsm4458925e9.3.2026.07.27.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:32:19 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Stanislaw Pal <kuncy7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: spi-qpic-snand: write the feature value before executing SET_FEATURE
Date: Mon, 27 Jul 2026 18:32:16 +0200
Message-ID: <20260727163216.109938-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_spi_send_cmdaddr() programs NAND_FLASH_CMD/NAND_EXEC_CMD and submits
the descriptors, which makes the controller execute the command
immediately. For SPINAND_SET_FEATURE the value to be written is only
placed into NAND_FLASH_FEATURES afterwards, by qcom_spi_io_op(), in a
second submission - so the chip is programmed with whatever that register
happened to hold from a previous operation, and the intended value is only
applied by the *next* SET_FEATURE.

Measured on a TP-Link Archer AX55 v1 (IPQ5018, ESMT F50L1G41LB): writing
0x40 to the configuration register (0xb0) leaves the chip at 0x00, and the
subsequent write of 0x00 leaves it at 0x40 - every write lands one
operation late.

This stayed unnoticed until v6.18 added SPI-NAND OTP support together
with OTP entries for ESMT chips. spinand_otp_rw() enables OTP mode,
reads, and disables it again, and mtd_otp_nvmem_add() does this during
MTD registration. With the off-by-one, the "disable" write actually
applies the previously requested value, so CFG_OTP_ENABLE ends up set:
the chip stays in OTP mode, every subsequent array read returns the OTP
area instead of the array (UBI reports an empty device) and all writes
fail with -EIO because the OTP area is write protected. On this board
that makes the whole flash unusable and the device unbootable.

Write the feature value into NAND_FLASH_FEATURES as part of the same
transaction, before NAND_EXEC_CMD. While at it, copy only the bytes the
operation actually carries - the previous code dereferenced a 4-byte
pointer on a one-byte buffer (spinand->scratchbuf).

With this patch the flash contents read back bit-identical to a
known-good dump of the same board taken under the vendor firmware
(md5-verified across partitions), and writes work.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1358,6 +1358,22 @@
 	snandc->regs->addr0 = cpu_to_le32(op->addr.val);
 	snandc->regs->addr1 = cpu_to_le32(0);
 
+	/*
+	 * The feature value has to reach NAND_FLASH_FEATURES before the
+	 * command is executed, otherwise the controller programs the chip
+	 * with whatever the register happened to hold from a previous
+	 * operation.
+	 */
+	if (opcode == SPINAND_SET_FEATURE) {
+		u32 ftr = 0;
+
+		memcpy(&ftr, op->data.buf.out,
+		       min_t(size_t, op->data.nbytes, sizeof(ftr)));
+		snandc->regs->flash_feature = cpu_to_le32(ftr);
+		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
+				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
+	}
+
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
 	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
@@ -1395,10 +1411,8 @@
 		copy_ftr = true;
 		break;
 	case SPINAND_SET_FEATURE:
-		snandc->regs->flash_feature = cpu_to_le32(*(u32 *)op->data.buf.out);
-		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
-				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
-		break;
+		/* fully handled by qcom_spi_send_cmdaddr() */
+		return 0;
 	case SPINAND_PROGRAM_EXECUTE:
 	case SPINAND_WRITE_EN:
 	case SPINAND_RESET:
