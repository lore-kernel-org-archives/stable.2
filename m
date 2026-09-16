Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BB20D4FF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538500; cv=none; b=PG8+dHsK7OdX9uJRwrroDHSdUGXbBHDiilcMtsXTwUhwFk3f9LUq1Yn3iJiN6XzFYxkj67xL6HVh0vcXNk1WAJk1H8DO5b0Kme+yOkNF+2bGGqOMhADq+pou8aABc/519baCcs0CCJySTUXvi5/CvKbCnRfmFCEtM0LUK/NT8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538500; c=relaxed/simple;
	bh=2Orkx/0NqOZ8km/RXqu4dfyHpd6v/U3IDJ3+BOniJQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra8PD94XVdqulUH+ZYUcSIT2F3P57STJHwXpn0SnftZbmwBd1TXoqOu1klvm+jTLmpaw+gc9qwGcn3DuXvXJG4G/3+gKueEeRvnzyxrRwGZ0bnNulXAZZ/Igtu3g3fIq2K17r5QccDf5ALG1Fkd0RwrIo9bBkvZuHOgctnoBfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flLMuHXS; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flLMuHXS"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1215787a12.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538498; x=1790143298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJ6nkhLgAEtz5X/dBEi4fkLEohVcqre5Sm/6ZumIFn8=;
        b=flLMuHXSOD/zg1Vapzhp9UKzusQ8Ge4s9ybg+vkIUE+t246JiqJKz+nQaBimQiTF4q
         QXvZNP5w9szjfNzLbHBK3EqW3dsfQs3BTn/K+bkcil8hFnsJhUfQVwYppUQj413gEqvL
         EJn2yR907VYDbomAFjMZj8lHT64TB726KX7D2o52GemR9c/D/9Z8aaMLvaStqLHfp97H
         +JtxuaRfvE9PCu9YVT0ron2uvRRNLOW0XWMDc3bItVGvEtrPbL+y7rxlwFvX2AVCSF7J
         P4eGxNnvnTJu/VddevjruktryLwJZqDg62oPl+lv/nRpRiA7ySD8hvF3i3p6K9P1dxBM
         KPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538498; x=1790143298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yJ6nkhLgAEtz5X/dBEi4fkLEohVcqre5Sm/6ZumIFn8=;
        b=jxU7xivm2g2bt4Ou6LRjXC3JRG5oS/b+5JyuJ9TBn6viQ2GhVsAMfTWyae7A5Dk8tN
         8Y1T5PaF3Xmihwn5p5paIN9a3eJ3LgiD15Je4tNWCWG+Kv9bxGZaR3S1D3ERLWwo2Ziv
         memUkfHq83mdqos8Uonz1hjVxpUwj+3/GjsmP18VbgxuMwB48OXhi7sEJE5FwTPyKsWP
         gSYs8hAZO3UPDEGn1L4W7yk0EI+/0gpZ/8GkGdzZIFTp/Oe2Q96ShQGICWNYCLm0gp7A
         daKyCAWKRzvteW5jjjvAVDESFKzxdmZaI7TP1A50b1bZZs7XEIsg+FS7qkcegwTkDVJ2
         qX6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdk9HJoMEuP0zFzukctYaAOi5oiaQq0r8Qb5xmCpbRw4DRJG7l6J9a2BKW9muAkmvzd4kvI+s=@vger.kernel.org
X-Gm-Message-State: AFuF++ka00NAyjL2oHyEf5h8ouim778GC3eUDuWIldX49qIeQ7ul8lTZ
	LeSDh8bBfhQDr41FGyUQfVB2FaVx3dUcClc7//Hb/0zW97FNaCo/JuUG
X-Gm-Gg: AYBFou0a8rHPcHLChj9cmtJ0uq9wCmS0VMJdeGRMXB5cyqGRV5d67lULlwa7/dIbtXY
	R7/ZVJ4dgPLEDBOETDHwAmr8X4mur6QZon8gNHPmX+hOwEXqA81vvbQuFt09ipA5AplbM6H42Pk
	xEbxGAXCKl9et+6k6u1KP2bUerjWDOrmrIfWPjE06PGalNqjG0RGREvWLq0VG1MKqZysv559Fxp
	YqyZLrugb8HKQwP28Uk3Nar64P17Nz8D32V2qgox0c3d+AB8YFTK2qaQfQRrDNTDAtmA3JF0Y53
	2HnsAwpPcSzDZnEqNdm/0rXxNZ00dIN6DBfNfmnq8VQZZG/YbkaiXRBPnTWIbMU0PxNm+8RdZAt
	qtuIXmxKkGpuEp5GS3SC8Uq6SUtXosBzAfcfmpAd0qD3sceJvMRST0SwHKhL/ursAdvAFbUomZA
	lCvOsHX8a7N9aUBAKc/hb6I+Ezmgeypxg6k1FLP0tyrf8dfq3AKYQQU04aIn2taCddxgPu/bb3O
	yoOfVEhJfvWJw7c7/A=
X-Received: by 2002:a17:90b:5706:b0:39e:1a96:bbb0 with SMTP id 98e67ed59e1d1-39e1a96d303mr2976100a91.29.1789538497871;
        Tue, 15 Sep 2026 23:01:37 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:01:37 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 1/7] iio: accel: adis16201: fix channel order for buffer mode
Date: Wed, 16 Sep 2026 10:55:31 +0500
Message-ID: <20260916055547.15206-2-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916055547.15206-1-shehryar.amd@gmail.com>
References: <20260916055547.15206-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reshuffle adis16201_channels to ascending scan_index order to avoid data
corruption during IIO core demultiplexing since the ADIS driver builds
the buffer in channel array order, while the IIO core demultiplexes it
in scan_index order.

This changes the raw buffer byte layout for existing adis16201 users
reading buffered data directly.

Fixes: 591298e54cea ("Staging: iio: accel: adis16201: Move adis16201 driver out of staging")
Cc: stable@vger.kernel.org
Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index ba0f97944..834714fb9 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -202,19 +202,19 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
-			 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
+			 12),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(7),
 };
 
 static const struct iio_info adis16201_info = {
-- 
2.43.0

