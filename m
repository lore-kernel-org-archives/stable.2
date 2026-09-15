Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22B4A64C4
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472330; cv=none; b=JAQDkkOUEg/vdM75Fuv9mnH727jiH9Zimx/XIO9IveEyeZOa114zksOJDeeviKm1PBzokWmITtI+ZKngwH0SV1US6QaV6Hd1YjNRMlCXChpoo3+jhPWU3/sZieFD/iHnfgI2ylPhOvbi3MQrxt0Omxvn3gvE7sBQvLSgpg0yj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472330; c=relaxed/simple;
	bh=gE+Fcg+IgZvXWr4qO2g38IDiaOpjPNINoQFbRMUClhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RageZof6evByLHBI8hke8KDBJX/6Hl4fZqHzpdHmfcy25rDNdCevbUcl9FoLiaCWyhktCohFhoM3eURDfYRYXe3F8d/4c4A+TuYxzWWR+zz/NF9FqYaX6rX9IjqWhoRI/8ECR6w/3vEoYF8BMHa8md1Q8kA3KMnZZ7cu4btd7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXlbACZS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXlbACZS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49c5a927a1fso1318715e9.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789472326; x=1790077126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5LU+QL611XVkEd8eqie07UbWEHcEKmuwpDc2acyE/A=;
        b=BXlbACZSX28MZ0qBAM2GgtcGEuq3aEedxX8aGU3hQ77byo6SsNtFnckUvjTs04hLz9
         Fmvn3qXpw7wiv00Y2JvVbuHl4KpzjBbgaDDiqRUhgS7RjVXRN0VR3C1VEYsiuts+lS7c
         UQhp39xnpLfecnQpC7lZR4+lHJR3fIpYRU0QlyuZ7Vt2CuyP55Lkm52VMuIlVlykoxhG
         KbT+Zh4LKdJAEcwvAI6XqABMI6rKgSthUmRKD5WnYyK6v3QLjSZMehU7pcPlMxNYxrdw
         +PqbnfIg8f5Q7xNAT5EIV/QeL25g+3q0wYMojs3IEhCMok73yNK9ijuJ7/sB8n9eY6Bt
         pTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472326; x=1790077126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5LU+QL611XVkEd8eqie07UbWEHcEKmuwpDc2acyE/A=;
        b=TTuFPzkV/SFMgAS4WjxqBV1r8cEZoHLX/xqoR8j1ekNoNI4c1HgfApZtVuiwvOgLDR
         iCAloY2v7KMIV3sbMiegC//XwBR+InLfIu2E2S9wM9VUbUh5qRtfqZ6ljAePnzfaMezs
         2/BWDgiygDsVdOssk9G/llsw/tpiejdOSlahJapKjH68lxb+tf8hXgAxrkZTFJ7yDXLI
         ENYYIUbXd5OC1QyOuyx4dF7qYBNXJooozN57Yg42S2Y78HE9YQkYBlOlVZ7c5G8dCfl1
         QSSX1DsD0njLE9ZJg6UzgYsEBxIILD1oxvhvzY+bllj+G2ZApV9JN0ZrDq93niPnhzKM
         cMBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxB5vDbv52RaYKjSqyPZ75ArTZsojuB6e3sqS6zh7x7IlDunPKkF5W3yv7ovnGfpaeZRS5HwGI=@vger.kernel.org
X-Gm-Message-State: AFuF++mBHu2xJNyHMY8JIE+r/wINtbw7E4McVuq2Ul9z2ZoxCG8Wb5YU
	FEo1PLncTU4hMNMCS0JPy3SRbe/mlUgd1dAa/K4hjs54HKYhmLjmG9MB
X-Gm-Gg: AYBFou1N0GCj7OKt9uGKk/mdUzKQwuXTafyUj8QSEAaUEk3CLulloJELQ/P/EdiSUdj
	Q/PA0kaeZByzpQKPiivuYUcQ4cIg5VrdadLekIXAoVEHxORQ3qAFUrkYydHCrMvb9BMk4Td4SIU
	o2OX5yu4DntGgwE9DJfvLXZYdazTIxsqiQ479X+Vk2Gxf5+b1k4SLFpk0ZPmnlw5iKihtTIIm5K
	+WgkaY597QfE8WGwvCnFmsILY9bwstMFOyddAFwvbKPMcf6VwDsaZ0hHa9TsqN2OrK8xZqbSMHE
	JcfJ5XBqTR1SI0+Og6uulVf+8OeQqUuy1xBfs1AD/o/8VBqFTRaYe2Ot0+nCU4dNzsTyzWlSFGJ
	G7W76sszvJf9tSLGYh2hgJg2KKKSJHCEDfHipYI0IQMQgK9reyLJWRDV8kT9P1Hl+fg7fWtEYrG
	L/cCIbBThkGHEA6p4B9DuXNAgO76pObKbnjEFaVMw75FHpxhIZ1Z5nbzEpcVOnAFjhp4gDrYbGN
	C0z7Kh5dfB2qSxjlyE=
X-Received: by 2002:a05:600c:3b9f:b0:499:d95a:41f with SMTP id 5b1f17b1804b1-49e7a5f41a5mr97454745e9.0.1789472326047;
        Tue, 15 Sep 2026 04:38:46 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef6bbdasm53917485e9.4.2026.09.15.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:38:45 -0700 (PDT)
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
Subject: [PATCH v3] mtd: spi-nor: take the flash lock around spi_nor_restore()
Date: Tue, 15 Sep 2026 14:38:11 +0300
Message-Id: <20260915113811.2429311-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_nor_shutdown() and spi_nor_remove() call spi_nor_restore() without
nor->lock, which every other path to the chip takes through
spi_nor_prep_and_lock(). Both run with the MTD device still registered,
so another thread can be in the middle of an operation.

A busy flash ignores everything but status reads, so the restore is
silently dropped and the chip is left in 4-byte mode. A restore landing
between two chunks of a read switches the chip to 3-byte addressing
while spi_nor_read() carries on sending four address bytes.

Take the lock, so the restore runs between operations instead of during
one. This narrows the race rather than closing it: an operation starting
afterwards still addresses a 3-byte chip with nor->addr_nbytes left at 4.

Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exiting")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
v2 1/3, the spi_nor_rww_start_exclusive() lock fix, is dropped from this
series now that it is queued in spi-nor/next. This patch still depends
on it: it adds the first ->shutdown and ->remove callers of the
exclusive lock, so an RWW flash would deadlock without it. Please let it
reach stable first.

Changes in v3:
- Fold the spi_nor_remove() patch into this one, as requested by
  Michael Walle. Both call sites now share a small helper.
- Cut the commit message down.
- Add an Assisted-by: tag, as requested by Michael Walle.
- Drop patch 1/3, queued in spi-nor/next.
- Link to v2:
  https://lore.kernel.org/r/20260914081149.1916589-1-itai.handler@gmail.com

 drivers/mtd/spi-nor/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..c891197ffa5b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3849,11 +3849,26 @@ static int spi_nor_probe(struct spi_mem *spimem)
 				   data ? data->nr_parts : 0);
 }
 
+/*
+ * Restore between operations, not during one. Removal and shutdown both run
+ * with MTD users still attached: a busy flash silently ignores the commands
+ * spi_nor_restore() sends, and a restore landing inside a read changes the
+ * chip's address width under the transfer.
+ */
+static void spi_nor_restore_locked(struct spi_nor *nor)
+{
+	if (spi_nor_prep_and_lock(nor))
+		return;
+
+	spi_nor_restore(nor);
+	spi_nor_unlock_and_unprep(nor);
+}
+
 static int spi_nor_remove(struct spi_mem *spimem)
 {
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
 
-	spi_nor_restore(nor);
+	spi_nor_restore_locked(nor);
 
 	/* Clean up MTD stuff. */
 	return mtd_device_unregister(&nor->mtd);
@@ -3863,7 +3878,7 @@ static void spi_nor_shutdown(struct spi_mem *spimem)
 {
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
 
-	spi_nor_restore(nor);
+	spi_nor_restore_locked(nor);
 }
 
 /*

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.34.1

