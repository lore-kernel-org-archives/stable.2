Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA662559CBF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958992; cv=none; b=GowQKSSOJsFDzPZkQbuD30ehoQ197YFSWP49JAGRbXLXLkKHqd/HnXOG9o/XSbupBEKZudB+KVrkgDLQUoxi+E3A8JnOhonuqPKb2x5Ruzp2SnvjK7qhMoB6o0GC64GD+oihWOMWhR6fadSee2efSJVz/9Mjt4z7OpBDLRfcsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958992; c=relaxed/simple;
	bh=8aRTU8lVGgUweHEo4N2lqmZpdLeCLEASyfjPi1iOJ0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TucpD7eOmivl8ve0tz9QY3Rj47cblfGkOMhRm8kvc0TZ3jvby5Mq836Hpe807dDb2QFhyVl8c6o4t/6G08XN+6cgdDNf3WyxqJNv2mXR8RG2ESutaNmM80n3EZDWupVJT4pZOU0d3ErGGodw+tbalf9xpDtXxnGHVfKGBw151BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnujjKsz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnujjKsz"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so9355669a12.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788958989; x=1789563789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ODTOke9WBLLFCAtlr6DbY54kUxk8UUHwnHp/PHXh6k=;
        b=JnujjKszf80hjdJW8mAw+V3sOnMfW77+6TQ/VlE7CZs9IgjQfdXJbI7eqt9qxY83eA
         hodaQGOTNSQpyAkFbTbVCRRetGh/YHzE9UoU/G80SPI1Oa2SPV8jWG1iP8oXedswgBgt
         0Y8pExycguvz9mw4bIMHOFfgVOClbSPckyFxUnMD2uhT4P0PzkYufzQTJkqUVXugOJag
         OvO/llZRU9yJdX0N5p8w6pPZ2WTGx+JnKt33eClCAHrcR3KSQ9ubOA73EzJsgfLU2qP6
         ZQNno9FyP6okHXZWWvw4L95dX7svyMZExXdGc5gWHxcfZcvljRQFZhvT8/KGMqt36tP/
         u1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958989; x=1789563789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ODTOke9WBLLFCAtlr6DbY54kUxk8UUHwnHp/PHXh6k=;
        b=H2Fs9+2SdSB+2aQtCZ6wpuVwoq1ckWq8eMvH2KUYtDsfJBV288r2MKgn2eXPuC5u03
         e6P882DFM/i9XE4iA82Idox/t4Xvw3Vr+HmMkdOtun1ynSUgfQx5LP8cvLsdFEGTHlSv
         AurmS+9BC5bK7otRCsvt+Bi50vPLPYZklhySutGgh/zZ1Df1t+a5q3u7c7z1A6cJ0WFF
         SBFaaDwZAfrqRL9YV1LcL6xGDKHHH5Pk4/Z6OtoZuIPh1R05H3YaPkTpU+eYRpfh+sQ4
         eW/+/vDi9oXoYcy0N0M791r4+VO4HxVUSKo+rHpfxX+MFoJ+xwetdCI8Z0Oqms6jFPKk
         aQ0A==
X-Forwarded-Encrypted: i=1; AKwUvBxh5LjbrhZtlukD8pBAEhLyotHIg45mxSTPMEoaITnAeuvdEychBV6g8yfPUik3TsZMPxlBPYI=@vger.kernel.org
X-Gm-Message-State: AFuF++nB6bKMcgcZ3ZEuXrEdzpR4H6yBHXg4rfKbi4Z3mYtO8Lv4K9ot
	KxpF7Dige++8zeMro5pnx3t1HHgeGEiM9v8Xz3bNJlDma8EeXt06UynE
X-Gm-Gg: AYBFou1UcWb1+NXPovqs5My0Tc0fICjBSJ1T9udpLK74pJSULQqVyTtoy4TB6JvaSn+
	HvqEwUKsWuzpAEBU9aQkvD5RSO+pk2rbnDRRadlPgzju2DfA0yVC3yScpIsHX6ZndyC2VLCv0n3
	GPtQldgpMfTJ+cFT/cdXxJW6uRcSM343UWvFg00iGPv97dZMszEFrveKB+RR/IxjIPqci4GtMP/
	zw9OOMZ3Q0FGxh1eho+SdyG6EHlp6mK2FegNylOWOJeR7LVaDlHFndXecWjVs3GyEAegaJoRoB+
	uYJigdL3xH+ZExjKogRyCgp20XPb9bk8RLQ9Ud+RzkDHOlKTQrO5fm/UZUx/mKctNWiZKXKpSed
	Cvwg7cUT4nWPEjk7OYsoAjr/hlXeSkg8KGXO5rB3S+JydfUTR1O332o/pKcsq87Mk1CbtRk/txQ
	/dEcKEAReQHKfZ64ReqIYCmahRFLDadoWevFJXh75XxyU7bOPJxGQCZkNenbza/s+zH8CaQLZnq
	GFk1ub8thO+Pt7LsXKeC9rqgmkvROXR9H2DgYhQHkbmofphzamJ+ySuqHqFr+xRcT1G/TN+ma5e
	+5Ljdvw5YXSuQESIluKykHQXclwDoVLLWyKb7W3TqWhjqs7NbBguDPtG98qo4tF+wHlKm07FPzZ
	VvptaUZWNloTkwvD/tHAF+W4wn8kVt/h7pJxzDZywQhJEMs2S0MtgqzhlR2/23+jbr4HuyMMsuW
	98GI5ok67rydkmx2HwqQE8EIFWvqRhHpXl71buqhsdTiFoZCf2LOC3IVyGvOcXxuR0/tdnk5KCT
	XnA9sNw4pEG794=
X-Received: by 2002:a17:907:94c7:b0:c1c:3b06:ed03 with SMTP id a640c23a62f3a-c260cb54617mr1419558766b.23.1788958988471;
        Wed, 09 Sep 2026 06:03:08 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (158.54.90.34.bc.googleusercontent.com. [34.90.54.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e4579395sm506159166b.48.2026.09.09.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:03:08 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
Date: Wed,  9 Sep 2026 13:03:04 +0000
Message-ID: <20260909130304.1395-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001 has an SPI ID table, but does not export it with the
MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
autoloading fails on systems that don't use devicetree (e.g. via
spi_board_info).

Add the missing macro to export the alias information.

Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/max14001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
index 58adeac62dde..7694fbb6a9fd 100644
--- a/drivers/iio/adc/max14001.c
+++ b/drivers/iio/adc/max14001.c
@@ -366,6 +366,7 @@ static const struct spi_device_id max14001_id_table[] = {
 	{ .name = "max14002", .driver_data = (kernel_ulong_t)&max14002_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(spi, max14001_id_table);
 
 static const struct of_device_id max14001_of_match[] = {
 	{ .compatible = "adi,max14001", .data = &max14001_chip_info },
-- 
2.47.3

