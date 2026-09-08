Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6842255C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867697; cv=none; b=vBsq+K6DaPGQsrUszDzKpU1dV3bXF+sAgDmqd4rYowJJev6RGzv5TDMQWHHsJUYoNriwNz18VoDb2LNbvGBsLHlQoLdEi0fT491XLvlyIv57DjRrZdXQ3K0zbvPenj+IqwRnFCY1uQ1mhERTi5B/EqVsIyHzTz8Dl7txzwcNzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867697; c=relaxed/simple;
	bh=JEriB6GDjlcrCUa78TKwGOGGWVkUgVsCS1pUbwbx7n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkKZxOvmAeMeeLslyV1dauQQce/5CRhAoNhmH8iVEfHjhSl//uB2Z5CZs8IFMs/79Ba7aFM7wTBFq5khrexWAEXEw6nCascPUUd/tWr0WBi2ig3TYmg85jn4+EYv7S1OHgxLWugATGTjrSxV7PZkT3Y985QO9Xd8h9Lq/eP71Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR3I+aF3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR3I+aF3"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so8435018a12.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788867692; x=1789472492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=geWMNX1K6rx9sqL3rAvPz4Otwn4ZznXQlhtRu8yNQXQ=;
        b=lR3I+aF3JKqFWmZq7/dZzhbQmd1vFF/b02TxJz5tfP4Tvm8OokaTHNqKVom4tnGf33
         21XxReeSPgCvtuIwaXSBzXddEWexpY26rH0+o08xcg7trZpb0ZNmXg9C0W520QTNdDFI
         IUxTYyppQX6f5KWLqnspucJy5rFe1Kro52kI4aStsfnVh5PZvacINOMO7MPUyRRC5sNE
         mMdB+o3g/ftfUInN2FahS12Sp3NY70sJqRqMmzbbS+lc9uVEzjCDeamWyq+rcEpqVDUr
         9Yxf+cOGtx5e85c16ucFPAfQD7Bv7uqbbHBqqcuPsaKEpUGGzghZvEsiD4PZbebqZpk6
         I7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867692; x=1789472492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geWMNX1K6rx9sqL3rAvPz4Otwn4ZznXQlhtRu8yNQXQ=;
        b=NYrbmyQ4Gp3+P8PMQnhfWwBBB8OC0DgAEPuVWmgrDZELIB6Xiy3DpBw1YeXfIFXLd0
         RrXro02V8p1ybTZbjW28YCSjnlcJoPLuEo9iK2bosLinOJz1aC6uuEj999BW/0PRwOpG
         26R/Fe0Updv0MSEf12Fv0/ur4f2BUeiOFLP7r1zc62UUT+ACKDjj14PIIBmoOdOHLCQL
         6NU3JB/HzoNLXzZqwrbn4WrOuwV3Y/JYdNtiqImeTumP4816KTCwKobHdpd0Mf3pnXNf
         OAXMcqxHuhpCQRo8mSWdhLbtw8aUjxXHIPvqDKCP0qVJBzCOIT91BMDtaiwJYl4jJJ1R
         5rFQ==
X-Forwarded-Encrypted: i=1; AKwUvByWbsr3xC8Q6kzXcb7VK5eJdBZ5BOZdSh64t1TcMp0ul8OLAkwXa+ljj1eat7EPk7VgEE6R9YI=@vger.kernel.org
X-Gm-Message-State: AFuF++m4LY18z/lztRFerCovtT7lbssr3vRJbeYntihoqwg8kiVFYQlI
	gfozFDx7+0tQaXIJo3pZMz8W4noGx5GbjRstQeVPOuFaeQEfYd4Fhu7i
X-Gm-Gg: AYBFou1kYpx1jBL01BaNIX1h7bqvRbnEbeB9iNblxXuP2Kvkpx+VP8545Pq7lXQk6xY
	Dkzh5s7zUXqsv2UiQng4jvheM8AoiTg+fhubpUBwbKxsurEW3GI3owGSMjPn5qzG5XE3PtBT1uA
	6pSlkQUKApuYy3DfxPKJFLaLWOJaKWWC5+fyzYzDOUO3AAwE5z8eKWGbSFziUsL3wPHj/Rx3zf3
	mANrVnIJE/YeiLoPe8iGtOmmw5+Gtrb5XRM73VZRJf905VpEl8AkTWXIXt9rDeZ3jmbIQOklIcg
	ZRE0pawES1ub3r3ko/5XjALTtWCG/oGd295aIembj3HGft3l/QH3iIMHyAXg6CRgrkmD/yb2Gap
	mpF+xU5SgoU0MLdJy5X+6Y0JmNeYxr+881uHiBSfW0whq4Ra6nJ+iOp62GDkvl9+1znsEsdX50L
	1cwyEIhRKR1Vfmecn8F6wW0m/Y0nuob8O15PPKGgR10cHNlxHd+NLmDUR+0O/8d6o7PBC3CI0aS
	4pU0Djq7NR8ardlYj2UFhQa7baPpRYaATiqV8DTBAG6/PbpSGW2FZjwrXyWR53b0aUVJRBAjV6o
	Qm41uJBX5EX8+s+HfG86X5W9KF/o8ZRGPP+JTyAZzPjScfrdppFN2mGxUnEqSQ8D2Mixf7kvrvi
	JvWuqhrhhK9puGBzyB8F5758G2XvOpI4TixfsEMdHq5YajtHblyP1Pfm1MuuKSIWWHYMKo7ggii
	9o9snHd83mEDxswj0fGatUTb008UV9aBWaiBDgiQ/1K215HY8MLvXB7dj7FetZks6vsY2LEkmZ
X-Received: by 2002:a05:6402:4050:10b0:6a6:92d6:daad with SMTP id 4fb4d7f45d1cf-6a696a98b4emr9152785a12.10.1788867692285;
        Tue, 08 Sep 2026 04:41:32 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (209.47.7.34.bc.googleusercontent.com. [34.7.47.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6beesm5530489a12.8.2026.09.08.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:41:31 -0700 (PDT)
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
Subject: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
Date: Tue,  8 Sep 2026 11:40:47 +0000
Message-ID: <20260908114047.1360-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
macro.

Add the missing macro.

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

