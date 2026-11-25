Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595328;
	b=MFA8g0l8tw4kMPQCw+0OoKjE3iJNIpWVCHOtH5XnVAOFNUeQFuuMVhIDowhx0sjR9Qgw
	 uoJYvhceipsb075Idf/ehKVpIWG9GbfnVFkPDHbR9Y0aAQFypBZEuU6p97pFtuhjg7vBd
	 1O2qPl4fJhENuMMIbZn5h95uhCnpYCUIg0ephfqASV9ahxfn4GW/4t4Yrqw55fMu3EDnD
	 8pSLES8plZZWbdKsIcWcsFOWI2WQhSdfo/AmTMQVrTqn7K9RmFJkNQWvxhbgaEhl5WG8F
	 Gnx/w1FtCnIfYVmhgjQ01BPXmHqtXJDz1IzyQGVDmKyfy1V+5id2hPA3MMD3Lkz4RFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
	b=r1hkgpoEHZ6SImz6oKyJ655Q0oL/tA8butD6P7hkXXmVD4XVVCl6T9N2jhw8+oKML7nn
	 0diRUwvnU4Uy8BaaUfJk+zvRCUtxt7PYSqm8MpB0EoUmDRnCkzCV1W0KMknqVgAw7S9pT
	 +u8dliwMB0v7V8iQHUTHqU8iUlXpEaY8jJ8u1NkGKrnpKWMZVP5hEqrXOUpsjE/ZdXK3p
	 2S0pgWw5k8WBgJiJynfpeR7dOyB+16GftKFTAS/+m9iReTPmsYBL2CiTY+7kHCxeYCMmP
	 KswbY6Ri/kEgAJDFrJnXXAY3txxIqO0tah9TjM5HwlSNQFomwoYOtfChJF8lc3NxF/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0ThPuBz;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C69606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C69606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0ThPuBz
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so8396733c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795595326; x=1796200126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
        b=P0ThPuBzy8A+SceJKFTZCU5j5QqK8FO9NPu7KDw8M2BgUEoLTMxkxOoVJA7f1mJLDi
         ewuPK8y5cEdtO8SsFdncNnjmKeLoBZX/0/GztLuOMUdJb+hQYFYvFMY8ZWJK80Vemw39
         SgqbHIz9i6FcjQy0LpWsF7yd1cin1x+Tn3bMXtW0sikpN1GQNoThGIFR8JFfJ4sNrcJQ
         s1rIS+SRADhlv54ibcUx5Rlv6SjOdhuhn9pK83SzdpliNxv5WX1QiVpdRbP1n5LDJVEK
         p+51LXljwzvjOM610lAv+v33SxKFkAa/GEm83dQkqtQM8uCil98uQvqw/fPfpqAm0D3u
         eB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595326; x=1796200126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
        b=Su5n8yRe4ulx1CNT3HyFl+AYqO4HpnqUQ7KZ3V/VjadPNX5R+VF3G4J/yFS73BxuH5
         GURi7tyYiIApUHoi9CsvB79Fb9tsNJL4m2yZcISwo8NwnSreg/MWREK27OA+6+zTKl8Y
         3JAcnoYSKPlRb+yP8s/lFmWQAGn81NmjBbKKp9pUaHYVgvQvkABOclclUxBqqquTewoP
         V34eshV59ZD+BY36mYH/LdsVHdI21EKh5uiTqi3v1MzoGa8DZAGdFQq30L8V1yTQXlOQ
         4c3qUYBUCC8BgkmDbHs602etbKSrXE8tXwQ+5Ps4aTdBB3FK5yYLTB3lQ4eL0LqwO8UZ
         /ALQ==
X-Forwarded-Encrypted: i=1; AL+hErEsz7eMNbBsk0bNrrLX5gbJXXCK0+P6ji7yUKUNREbKNZMz59EPP1VyasTnTbzgFTXiZngEXhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sN15ZjNiQOCGwg0HvXr1yRkZosXd3IrDAcj89+OUuRN+zdQ7v
	1sBhZXSltWXCWFmZwlqb0UX7z7AP0q/kHympuwe5RNRjAbrNvndy8NmW
X-Gm-Gg: AZFdTZfcY1yA5n7HMOWjUoNzAGeBRQv/G1jN7DWyOj0ly0gN7BiDZzpnAg8q0P4YzqE
	rrGV1EXquqk7clFVNo4f8rqx9rmBC+mZBDMRzxhGfBPG04oi5k53SUMs+v0dyOT2fi8IeTezPih
	1HWydKPpPczD6NherfKjRuGanp7OogYy1Ic9grZVAMhlYa7c/aBmQer+Q5cTsa3P1n4xCtE24GL
	wum4sFJmMfZ2VAipjV/0yWsBXkFg0RPLaahydTX0cAPxp4FlE4GpM5aLb/1x9Ovg0Dyvwrz/xTt
	QKmR0julMk7sfXyxTfRyReermf+/nBUWGwXniAgCBHQy9TdAIbO6bmYKCiCRjNdHEQCuu3Sx20l
	llBvZvwqILHaY2EFnc+Aa7VZzQGnw9Y/h/SzfCWpiY7dfdMJmqtpsPltUz7Ja1W8OkWC/w2vGe7
	cmb1b3A9GmF5N5sFcrQ9+iynrwd2lkW/BEWxDE8Hz/yr/1j2iI59xPQLZIwL7sU1nttSeB3kpJw
	YUkPP9B8g3WKx3uqVEKTbWIP3kqfz0vjZ83iEpRwxlZwGl0kJNcyq9cl6eygumVJUnQc/PfZSg7
	/Lw/5LocCEzs9ocDJ0K6Ef4KRPcq/TT46oju/XS/axC8n2dgKaQmxg==
X-Received: by 2002:a05:701b:2704:b0:1b5:4f6d:8277 with SMTP id a92af1059eb24-1b5568e78b1mr16606421c88.26.1795595326056;
        Wed, 25 Nov 2026 00:28:46 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm40511409c88.8.2026.11.25.00.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:28:45 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Andrea Merello <andrea.merello@iit.it>,
	stable@vger.kernel.org
Subject: [PATCH] iio: imu: bno055: restore the order of the gyroscope range codes
Date: Wed, 25 Nov 2026 16:28:40 +0800
Message-Id: <20261125082840.1340359-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate
array") also reversed the hw_xlate table of the gyroscope scale.
bno055_gyr_scale_vals[] runs from 125 to 2000 dps, which the chip
encodes as 4 to 0 (datasheet, Table 3-9 "Gyroscope configurations").

With fusion off, in_anglvel_scale now reports and selects the ranges in
reverse order. Restore the order.

Fixes: 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate array")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Noticed during an LLM-assisted review of the hw_xlate lookup check [1].
Reproduced in a userspace harness. Not tested on hardware.

I used an LLM to help write the harness and this patch.

[1] https://lore.kernel.org/linux-iio/20261123135554.2983499-3-maoyixie.tju@gmail.com/

 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index b1c7b4f88bf10e7e0477a1d424bbb4815f59c6a9..50543ac35f044c18b6734224dba94286e6292c76 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -171,7 +171,7 @@ static const int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
-static const int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
+static const int bno055_gyr_scale_hw_xlate[] = {4, 3, 2, 1, 0};
 static const struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
-- 
2.34.1

