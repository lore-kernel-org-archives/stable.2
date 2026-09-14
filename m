Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE663F4DC2
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373561; cv=none; b=jUpM1mwiRnHFG0075samih7TlEptiJo52Ks0ERwLsUOpmug95010VOGV3jpFfkEiMdSvj5QuC8ejDB6Ojo7Ce8h6FwpA0uxwMiZ2KkiUGftmqYpmnapD3QM0yKLdykvoJxmHxYWGfIBCYoHM4pY4YCvN7rgrS7DDADYIpRArL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373561; c=relaxed/simple;
	bh=QFaOVSaXo24SfPWobdaFHZRuDdTnE2qTXwVifB86x00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvzNzzBULFjnDQT2fprsilU1JAVuaUoOBDMfb4uJN1YpsoeRnJU4eDxwcbW+ePbjpzwxLEvGn/bbIeInj8X2lKV5mgvAFfXqksVCq0uZpvSkjftULtoTO1Xya+c7chz6uY8naBC29xfpFoqDkdQX1nzsUMmDIeBwewS4ip1/Azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jekJlX6t; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jekJlX6t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6af07e08so756445e9.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373557; x=1789978357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aj7IiomPonUj9qywT6/YurZdwlPYR2aG7U6PbbSw37I=;
        b=jekJlX6tBY33oG2iw2w/02lsBFrVP5pjNjIEaaZ0k7x5tPqSacnT8UnyuD/xLZH8H/
         r3pG+DgiBtKzgsVgVIX/PxcjFOT9AU3jG5C1z9krtacehnIgGWYJC2MHqRBafy2WES6j
         /csH5PyKvUo2ZjqJ1UUVT93vmGvYdlGOUvTtr+vWrkA6Kd2zJVEJg3OogoUeHyito6Rr
         QsNXmmwqR3J7KOYRm668h6sxSoJMeNSDOTrC9c+KM0+Szl/KuX0cA2o5JVESNgElFQ4I
         eYV6VjKgQ5RCFBJRBwPieCrGJHuTT15RWavYUjPR5AjYXxQmFLzxNqXmAh58FlVTVJJa
         yFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373557; x=1789978357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aj7IiomPonUj9qywT6/YurZdwlPYR2aG7U6PbbSw37I=;
        b=j84TqwRq7ne8FGp+Ion0BXZp2r3pAtoGpsVcwuEI8Muvf8sRkB1gQROtZfqPaG+CmK
         yAGlgvQaTxxUZ7KcpnVWvfMTvMaHg+gQOLHoSVrIEymW06Q9BJ5+uJWKkQqJxg2e3Njq
         TT/DQ+l+rXA8CR8j0vegD8UbRaXEvgoqGjCH75PDxOR/2u73Mgrxt4NOppf000CvH10C
         MbbPA5o+NU2cLZRswtVsIBMPKnl+Jemw7CyZAKp3O+n/FIGbQBXmbGY3rpft61OMfcYX
         ZimeMdCQ8FHf4rp1nUP7ZzwdypxghqXlieQ59z8/2MwCN135uSQlr7IQs/IKCovDTULy
         h3nw==
X-Forwarded-Encrypted: i=1; AKwUvBwSYuK0TIIzANmJEUFkvly2SpkDkhqBLazD5uLcIwhao6LXZ0unSl7JMZ3KaI9xjmzIuzQ4K88=@vger.kernel.org
X-Gm-Message-State: AFuF++nOR9tM4s9lQVi3PsxTjNDYH/MMzf4K9m3GGm+E5Hovq6oHi7pO
	KudxSouM4jdE2tPudtFXS1YxII7pG2LyJLOzINjNSKsTFRvSsF1tVuZI
X-Gm-Gg: AYBFou0j+w3oglSYxFRnLUkvRF91YsalL8iaA3yQKEMOUYZ51WMv6qoPVVypDzz22S4
	Abp5Fkl01WCdVsAKFmWbNcz5pKR3deth7WgO9mkIgwxc0hezC/2bLBlXzEIFu8TzpjROFnNsaNE
	vUktWmmV2vIk4pwR+rxc4+5V0QaxP92c8k6ES7WDA7z4s5rEOmV7Bc1XSP4ZsbjiUIM0p9ntXMk
	Bsx5fTzMIYksH8XmBwPTIwPQ2TzeCAf2gfOGQb6qgygOhMW7sJnLUtcAO+4RIXQM+XgdBPd2Gzv
	t5vEF4Ojr1ymrMEgcv4zaLPFh9LmL6q+jHPTnM+MsRQvG8zfL903So7NSYc9yiZdhTwgKxdbAms
	EIaDn5In/Ni3cNLdDW6sC1frmFgmO7QZaIgMlkpGhPM2GqdWf+tEfrc/dwCB8Z9nof968B50AIl
	QqadmWAVVTVLehkH2ueu2p/BrTJS43QxY3FfvYX30J30NSdyuyBC+sqyXn18Pi9+nEy4mg5q+Mb
	QVUdQcbuvtZ0+u1JPQ=
X-Received: by 2002:a05:600c:3b9f:b0:49e:745d:5768 with SMTP id 5b1f17b1804b1-49e7a5f1f60mr19047885e9.0.1789373557305;
        Mon, 14 Sep 2026 01:12:37 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm301434385e9.9.2026.09.14.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:12:36 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mtd: spi-nor: take the flash lock in spi_nor_shutdown()
Date: Mon, 14 Sep 2026 11:11:48 +0300
Message-Id: <20260914081149.1916589-3-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914081149.1916589-1-itai.handler@gmail.com>
References: <20260914081149.1916589-1-itai.handler@gmail.com>
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
index 8bc117b46e02..647bf8dce719 100644
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
-- 
2.34.1

