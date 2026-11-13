Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610831;
	b=KfMBqMPO7pAp07GotS/HG8qynZQNrWaRH+yXsg013FjIvmhPSe3g2n7DM4LlB1M9dKNa
	 d3m/Zk7BzEyA6VmWpRsXiu44SatueNftLX2L/ptARltlEQ/70o2TZtgT/a1GgWCNihPOU
	 Gd8kvLsPzeyvJwhCjToiKsxwyAcecPIKHXzl74+EBxejUjf/b8Azm8LO3ERt1uTiqvzdS
	 HKM9ObAcOI3SqwozjT2cxwt6Lf/7DRc8drmWvFZ8K9KQEaDWKxF945+HbnXR+jihHaHsT
	 xb4OZQ3SSLO6bLv+kgRcM8cTPheAuRtObfiW9QO1Zx8UR3OefNVePgw741QI+0Kq8/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
	b=kJvJtFLvx8V8o+EDWYNWwFvMHz1MKvDXoR4dIpcJTiyKul3ogwzlWc/xQp8w1CxO35YU
	 YDVO+AkOMENNg+c9GORjElCy08TPLWL7PEdlPoLsDEU4I1jZEbrgeGn3x3mKvztXsi1UL
	 2ZNHSF5xIGb97jCfP//c+P68GPVz64qVUYO6ly/3Nk9x0iVhbhkH1DrWV+P1JniVnZGyc
	 EAEGJZuzVITPVnBfVRx5GIadw9YtvEif+qWR6eTLPQyo20V7qbVDYBWHfyluptfYM6IER
	 VyyP0yWpkzIejuFrM5bdUKo3vqkue1zUEXmmDniwTYt8cyeuyIvW0b0aXf/avhpqp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lwz5yg62;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A45606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A45606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lwz5yg62
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so715699f8f.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610829; x=1795215629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
        b=Lwz5yg62JgaQRlZiPSOj584M7rkeHIagPOY1EX5+CA9EnvesQJJwgCD4ntm9j72SA+
         /kwNure6yR3wQZB6HEViS6wEYxxofjW/SMUy2VelFXX6L8JY0Dsuh0Kg04dNWKFlz52V
         nvElu5IrGXb4PhhRGCXVuPfF1TbS97pIuh4LAODSY8lLBELeuuf3qluAOTVz7ygczgp/
         bTR8c2iYZUJHCqTKszcAxDkhYkLMIc/ZoVPh90lN8XbVdn2GzvSh4UOls0QSZ4UXwD/B
         Tvo9xL5XsDLNZZpZqRoi7BDTedTpB18zgAT7TdtMz4D2E1LJd+YEhGlEh01pfw61vvNi
         3u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610829; x=1795215629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
        b=pXXrYCjAAnjrp8Vp3RlI6U+/v+ved9BZf5NpaXzQ85PldAzmJWY0FcFLokahX68ZZv
         /1FeMxCrZ0qSYNHhkTh641ZAjVzEsdylAtmUf4qiKgx+Afj+gNVqwHE6kWF4Yw84+9JH
         VN12Sn1lfpkSB5kmK/jPCVRyO5E2QUcKxdMqi0ujO+oUlkUeRKCT3dflTU7p9J5w7ETH
         bdioZTvQeaGcLIdmJ47pWBYK0gVxbEOC90Dpyi2jwBuLTHg8cIn4m75PP9OUFOYCQCH8
         0A4nfEckDyIdtOEQqSUsi/1y9mWomY9rWYm2r5fyzcqoaYeYt5SNNzXrTRJK4gnIbhvb
         amjg==
X-Forwarded-Encrypted: i=1; AL+hErFwIXPQ9HceeTztpMImvgrThK0C+XazNB5j9zPDcMRhPvYhlVPhq7vZ9S7frMo7nBFYHSkrAn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0RROqY9LRSEs5DSZwssEvnGuwBT+lCVi9N9YbBE+n5hX/7AAu
	DiDD3doqjHAspPc6SoL8tUKadEKrB2MWNMLOWQ8IEbAPyWID90Pmyq8g
X-Gm-Gg: AYBFou0u7mmi/5pBS7Z9yT6jFkxfwxxZKcHPpI+rpiobCyCmiq5GljM0NEL0y/cDfTg
	ui3BPoYayeRahwvLcR0z3cMUgcGJN6c/xEj5suziin0N/mlBwvE5lOj43PYY0WffEDr5f9W9AzA
	swfva1CCAVHah8bgzUYG+gzeAulpkuJg3C2FlwAgkL+Dq5A1KcP75V6wxLSRFEn4drIy/ail1Zx
	Im7NL+R6Jsab/7phxA0xUpTXyaluicvlfj9eRUhsFnVgjE9plyHVmrJyyzm5XXopJotT/KOfv4K
	u8LIDdXUS70J6ILCR1DHR5ZV7miLuATEMDW2WTE82TWMhp3+rcJUdQ/rmHrbA9OieRkee2HuAth
	Dm5+r0obh49agIFwNJWNDcP+4acfVxVvdX/wzQz7R1aAtkQgUcWdnv4aVfwwVDd5qpnBVK7lcSm
	v1vCmhy/EGgG/Krtx0lFExLJcsl0bF/dXJo1Zn6dkKVv/baSrBlN/FWbL79VSB/eSFs4wYufF56
	auEu3tWxNa7Z4fgAJACpl0swXdM7E5pBV8tbO+jtaLYcTUK5em9n51HHj9KdHlbwxHXX/IQNl6g
	+JLtR1KBy1uW5Ok13uBNYAc/Rx8p1HHy0JOFSV7dxacnPpYnNHpS
X-Received: by 2002:a5d:5846:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-49dfd36c520mr1002069f8f.4.1794610829000;
        Fri, 13 Nov 2026 15:00:29 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm8617592f8f.11.2026.11.13.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:00:28 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] spi: atmel: limit transfers to the bounce buffer size
Date: Sat, 14 Nov 2026 00:00:15 +0100
Message-ID: <20261113230016.4144717-2-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
References: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
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

On SAM9 SoCs (CONFIG_SOC_SAM_V4_V5) a DMA transfer from or to a vmalloc
buffer goes through bounce buffers of SPI_MAX_DMA_XFER bytes. The whole
transfer is copied in them though, whatever its length, and nothing
limits the length of a transfer: a longer one is copied past the end of
the buffer.

The MIPI DBI panel drivers send a whole frame from the framebuffer, a
vmalloc buffer, in one transfer: 153600 bytes for a 320x240 ILI9341
panel. On an Arietta G25 (SAM9G25), once the driver accepts their 16 bit
transfers, the first frame oopses:

  Unable to handle kernel paging request at virtual address c8915000 when write
  PC is at mmiocpy+0x34/0x2a0
   mmiocpy from atmel_spi_one_transfer+0x4f0/0x77c

When the bounce buffers are in use, report SPI_MAX_DMA_XFER as the
maximum transfer size, so that longer transfers are split.
SPI_MAX_DMA_XFER is even, so the split transfers keep whole 16 bit
words.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - SPI_MAX_DMA_XFER is now even, see the previous patch [Mark Brown]
  - Rebased on spi/for-next

 drivers/spi/spi-atmel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c762e28407d8..08075c9cc07b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -591,6 +591,12 @@ static void atmel_spi_release_dma(void *data)
 	}
 }
 
+/* Transfers from vmalloc buffers are copied in the bounce buffers */
+static size_t atmel_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SPI_MAX_DMA_XFER;
+}
+
 static int atmel_spi_configure_dma(struct spi_controller *host,
 				   struct atmel_spi *as)
 {
@@ -637,6 +643,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 			err = -ENOMEM;
 			goto err_release_dma;
 		}
+
+		host->max_transfer_size = atmel_spi_max_transfer_size;
 	}
 
 	err = devm_add_action_or_reset(dev, atmel_spi_release_dma, host);
-- 
2.53.0

