Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBD58B6AB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065947; cv=none; b=Mly2T94zHIdd2HJQm3jsjYNwnk4J4aM/lgLvmY5WbqSX40AwGsF2eu0ooR02mXWN6RnMzOQEMdNqy2S22hQoUtWDmbYMbO00C8uu+MIXjMTfhE22vZ1oDQ2VNhK1vf9oE6nXSkd0oYTUBzn8gWEshEXhjCV+2zGBU/vPdb77d4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065947; c=relaxed/simple;
	bh=We2CtplNBgDDHP42d3oV8K1++E9MJ5VWZ/GusjF3Qyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhtFmYVYZ0oUgQ9ykXQZKUTbyCs/MJVbrd1aIxqfwid8F7FrjxgMLEYO8jHnBFWOyVUm7Hi8OOgmDO6dEjELZILF/72aSaw19mYEgeAEjD/y1TL64le4YxCb4SGts5IJaAFAYjTtzTBdF7xtKx8PpOgc5ssDvpjIo1K4O98OKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgeJoTPd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgeJoTPd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5faa1cfso187455e9.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065944; x=1789670744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYKvuY+VqGTbeddLCjHS1PA1XfFdTZPu7ob+AkuwS84=;
        b=DgeJoTPdQzBLIr2j84y19A5oghnz/wX8obUOywVJ1Nzx/nijMqHWjnz0ZnJebKKHDh
         c6M7plFYOWROp28ForCoFLdW0j9+PBeOf7u0f1jdyPrFRkgrXBQSl2VbTFmo0mdRySGC
         wRY/x42LS4+nf+FVr+6L/3YlydGHEy/RJ9j7B37K9aHuunPXqUr+LkpA7dPeuaR9x7VA
         U0Th4pF9LXIADHdAlRuly8ePEeqIkkOoKRJGVRRGiBeofvB2Hef3lSsIffOaJVJ3OMDR
         xypNQSHelLH/y0LLa9b2kJTqlmlf6IyU5/KNuu3pbjlcz4xw2WW0Mb2ND7TQJ3kXETsQ
         3vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065944; x=1789670744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYKvuY+VqGTbeddLCjHS1PA1XfFdTZPu7ob+AkuwS84=;
        b=SzM4493K/qM296f0sObZWSF+T46/hhIhan6zZha5ST5Fgm4rzfWhrK/qoAm8HyYuIO
         bJJq2mZ83mZLSqANGnCPIteMFiS+G+J0c4aM5D2plN+Fl7kTW3gbtdlERuGzsw9o0xOK
         AMfp6HbAupxt1110pj237aFJVhz+ZppABDC8w/B69stucGmSu7CiRp65MH7CEhJ86EDx
         lbTKezzzEl63Fq4vOPxAO7UXTpA3+vnKi4VtUdUbCtShojsVOYi3VwjJjqdqBY0/gFB0
         qnCKKTQUljORDBBGnGZy8lBe1QzVSjSvszAqJTiY6CYsYeJ+ym0hTPVDTq07QNT3OfS9
         ZAeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+cf7VjUIBk9AOUwUtcwEXGIB0mMCFfF4BV4+kBrbb4FS4dbXkitnicys4I4ErOxxcpGwORE8=@vger.kernel.org
X-Gm-Message-State: AFuF++kXSNh4DGjE4R7T/phDt63koP7zzATY99nGxyY3Wxqi2L83TOo7
	zWk4XrTLlL3SVg2MR6PP5qKjjqYGTVcz0BNbzldfraLGUFcUPYu/2P38
X-Gm-Gg: AYBFou1hKvEEr30d2nWKbI/IVzXptbQ1lLIj2uZNrVQqJFrKN5n+fTttwrpBEfErVpw
	lBEcVy1IGUgAxTGQIbuLpSHQaKO7y2Q0d4R0SQHS5QQ24hjNZuk8tecDBuYPeKdGuMOzbKPDGCO
	CGc83UoIpJEPBiaU7Ofcdbhd1q3hLiJc/VlpHWq3CPglysFpGGWjEP+ZXLjkfj80ynXMsIR9ElU
	24g5iby9Tj4QWCqaO8/7gpvY61TFxPSonLiWhMAf6P2DaxAhj9SzOPhUD471Q4TbJivie8zRsT6
	UsLeDQMX5h7o90I/5lwDD0IYeZ6KH3d0prJu70fUQ2JfJEjLDa2CXxei+wgBnax4FPjWDRNgref
	QOZ/I4Di0e1w6NQ9N+I4TzohZNgVgCgsjoZ2OR0Px+JmsJAT2YRBqjb6lAghaDYcZPGE9misNkv
	Zaus/aFQylGMKpzYdqrDXP4p4I5Y7PCiBOkjs9GMyPuqmwgBpd9Fd2eR4PTdlM1PqhbdB2kdiGF
	woAfq+NUG9zsl/hCO8=
X-Received: by 2002:a05:600c:4688:b0:49c:cbf4:572b with SMTP id 5b1f17b1804b1-49e619ec129mr3232775e9.2.1789065943543;
        Thu, 10 Sep 2026 11:45:43 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm18760055e9.14.2026.09.10.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:45:43 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	vigneshr@ti.com,
	richard@nod.at,
	miquel.raynal@bootlin.com,
	takahiro.kuwano@infineon.com,
	Itai Handler <itai.handler@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: take the flash lock in spi_nor_shutdown()
Date: Thu, 10 Sep 2026 21:44:51 +0300
Message-Id: <20260910184452.895485-2-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910184452.895485-1-itai.handler@gmail.com>
References: <20260910184452.895485-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_nor_shutdown() calls spi_nor_restore() to put the flash back into
3-byte addressing before the system reboots or kexecs. It does so
without taking nor->lock, which every other path that talks to the chip
acquires through spi_nor_prep_and_lock().

device_shutdown() does not freeze userspace and does not stop kernel
threads; it walks the device list calling ->shutdown with all CPUs
online. Another thread can therefore be in the middle of an operation,
with the restore running concurrently with it. A write and a read are
both damaged, in different ways.

A program or erase leaves the flash busy, and a busy flash accepts only
status register reads and ignores everything else, including the EX4B
that spi_nor_restore() sends. Neither spi_nor_write_enable() nor
spi_nor_set_4byte_addr_mode() reads anything back, so the restore
reports success while the flash is left in 4-byte addressing. The next
boot stage then addresses it with 3 bytes and reads the wrong data,
which is the failure commit 59b356ffd0b0 ("mtd: m25p80: restore the
status of SPI flash when exiting") introduced this restore to prevent.

A read, by contrast, does not ignore the restore - it is corrupted by
it. spi_nor_read() holds the lock across a loop that issues one
spi_nor_read_data() per chunk, each using nor->addr_nbytes.
spi_nor_set_4byte_addr_mode() updates nor->params->addr_nbytes and not
nor->addr_nbytes, so a restore landing between two chunks switches the
chip to 3-byte addressing while the driver carries on sending 4 address
bytes. The rest of the transfer is addressed wrongly and returns wrong
data, and nothing reports an error. A restore may also soft reset the
chip in the middle of that same read.

Take nor->lock for the restore, so it runs between operations instead of
during one: a program or erase has finished waiting on the chip, and a
read has issued its last chunk. This is a locking fix rather than a
missing wait - each operation already waits for completion at the site
that started it.

This narrows the race without closing it. The restore still runs while
MTD users are attached, so an operation that starts after it has
completed will address a chip that is now in 3-byte mode while
nor->addr_nbytes is still 4. Closing that as well would mean having MTD
stop accepting operations before ->shutdown runs, which is a larger
change; serialising against the operations already in flight is what
keeps the restore itself from being issued into a busy chip.

Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exiting")
Cc: stable@vger.kernel.org
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/mtd/spi-nor/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..96dd6ae6d619 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3862,8 +3862,21 @@ static int spi_nor_remove(struct spi_mem *spimem)
 static void spi_nor_shutdown(struct spi_mem *spimem)
 {
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	int ret;
+
+	/*
+	 * Wait for an operation started by another thread to finish.
+	 * device_shutdown() runs with MTD users still active: a busy flash
+	 * ignores the commands spi_nor_restore() issues, leaving it in
+	 * 4-byte address mode, and a restore landing mid-read changes the
+	 * chip's address width under the transfer.
+	 */
+	ret = spi_nor_prep_and_lock(nor);
+	if (ret)
+		return;
 
 	spi_nor_restore(nor);
+	spi_nor_unlock_and_unprep(nor);
 }
 
 /*
