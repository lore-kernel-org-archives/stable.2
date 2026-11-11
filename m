Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411631;
	b=IYakTL9EfJ0jP1byCjRPjONk+OcWc2XkaylkHOeTyhJ0NN8Rh2COu9J5lLuei+xvmVbG
	 AX7zuGkhfwgiuARIQcAJpto5fcI2rLHpCZKHK8F4yRgvFIoR0NpHk35QeEWOso5boEd2e
	 kTuHdd0jvSlkHSQJKpgg8XPZR+bRLdHu/foGAumJfmvCNBCMXZvk4zkp1C3Vg803USyRV
	 B5/sB1JFrWVXHYulBg+hdiU5WVbpsJjtWkB33NT+hWP37e4LcgfX13L5qytX7cXFalquN
	 wmhIQWBnMVhMoVasJld/M+VCf++ZzA/y+z6ulkBlGSEnA4n9/6YUBZ2SAIVL+usKNgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
	b=TPyzd66ezoPAWgOrq22Fm34DH8c6Vkjfd5pFCoMPTNu2OFmXhLLhCpHkzRlDSf4lAkMB
	 luOSdGSgXOlicvoF7xdBN85VFdyKLJukAPMrPhyesPmEq3kuT27pJbFNu+kVNDVslFRyn
	 zMgJ6+8XrTZw2J0VWjP+xFNkx1j3Pvukb0XTfQkQw47RFpYX7pPattUDmC+u6KmuPPFtN
	 /FPVFJkMPl4lHknouiptqtooI8ViaO4ubUiRRKmzvg8tOSeJweESRv1aGWbYxyPdZqyJE
	 29Pkl71no6jiWqRhKC12FXQAbcVY/vnuLtLLrZ/pSVzCQWc6oEUKfU6magt4MAqgXmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqvAAroa;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EC606A894
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88EC606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqvAAroa
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so28961685e9.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411629; x=1795016429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
        b=LqvAAroaAjuSjZCmj+eQNjPfmn9E5Vsa3t/Z5s3c9YnW/OEGBq9M+IEN/DcBv59Nyq
         x8Vg2AGeyRWnbSOz5PhDQmhd/v6PtbCbJitSzDOLUCM5LrH/VSPgXaFNhM/6eG7iFZZY
         hcFX+uXUdCRabDuoESJsAt/6UZaJxMXhTI5TBMdfSx0bnV8Y4GPhO/NFqs3w0xI1dHMK
         fuqVZaJKouR8syN3HHWmLTFCsJj7ggHCTomfTfuZiwNxAZquJJR87aEXW+7fKzm+TG5W
         ndiFUJX5OjvYX+y3lyYO5OZAHe3zRJOFX84XqIcIeExd3Jujh74mX5cjwcWhwyCGNLf2
         2jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411629; x=1795016429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
        b=opGRCQ0euTRGZKR/pysjlTtQjW8+aEu0d+UC46ro2zVrp5JSipOwvaxRqXELBLakIs
         biOZq5udihn+ce7n98TZCeTqSK2z9H8FCX7vn1ScvKz8eqljN+9Vmjkj4/m0aCTVp3F2
         kkJM49KZIWSm04C8nDmMNzJ37bfrD/7VC84di4SXsSqWJzfirQdOlqipezhzDCbf/PN/
         BXoej5u0xKMZM1Sb/QEwg43x1iGiVL9V5chMcVOfUAXYtVit2mkp+Q5QhUg/9ItACqfj
         UnHaGLFvhdnoFYFHvccXPHYXzpJ3TMxarFM6G6tmFolJuIpOzMIIN0LpTD/pbEl/f66x
         MOKg==
X-Forwarded-Encrypted: i=1; AL+hErEsnUIG82eNG0PDUJrZUi7BLzg4kj6sNokraZrSqW0uudU8QESUTxwOU4UxjMKolWuFVh955m4=@vger.kernel.org
X-Gm-Message-State: APuU4Z//l3VbU7XIQkXT6+1YLqfF/Qu2HCrz9RuALUfJ5zNTsmJQYQlX
	S6DzMfQUg6HVoA6kZShT/WlIUbD4VuIBDzE/odVcEkbrwxdLsmpn/DaR
X-Gm-Gg: AYBFou1LTPkzXoC7t2m+5/IG+iaDhwZNh0k6I8+d2IRDYbiM6CvyUT2x6tbYfeKJveG
	lo+YX/jNxi2L/yf8+p98xouEHMLRfn3eXi4u7dw6M49LW+A9uEaYKqRqIwjxWGHOjYMEF6TFCwg
	2m6WfHzqJLpa1D1pWlNduDkgMGuWG0qqljeeKIqJEhnQdbUNyMwtAeNPMvNYHO4ym/GmuM5deiu
	F++YUYXOYuSNTFCcz7jtHERACv5CIKP2XdoJpCazGLe3DBwK9BYtbNVhr4jYZKPA7Lr5oPPXgFi
	lR7MDKggWhYXAF4IjC7OhXO+zAQPlT+C5aZOI667XETYqX78f558cpLcVcto2YkWaueD61YAPT4
	3XPtw3e86/TBkIkTgHY72nmk4pjTuiAWX0fiQwx5BqLUXIeXhSvmAWLd0gU6ARiCj3n7Vom3cvr
	5hFrmHQoc1cS5UZ37N92/XiWTlu0mX7+02TAIj1xzpAm2cF51OO/mAPwC7Ctw0XCU53eA7jEBqj
	R8aFDNCWBTq7X0eavARbwmo9qGBqTrwYXu6DjBg00rN6Hopy6SpvYzr16uK/AhEisUn2F5oe0/b
	gCt4dDEopYQQLRyp2Wa0x+tGv4CabgkseKe6JhjBjvu4xx/e6lnH
X-Received: by 2002:a05:600c:8b24:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4ba09383fd2mr46107035e9.35.1794411628946;
        Wed, 11 Nov 2026 07:40:28 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5d831esm3899675e9.9.2026.11.11.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:40:28 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] spi: atmel: limit transfers to the bounce buffer size
Date: Wed, 11 Nov 2026 16:40:23 +0100
Message-ID: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
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
maximum transfer size, so that SPI device drivers split longer
transfers.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/spi/spi-atmel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc1292b0..fb8d4c7c9 100644
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

