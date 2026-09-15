Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8D44065A
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456425; cv=none; b=hgJRaVz0zYIXuABUGxJNtBcq+bsNvyT/PQGkEknKIb6Ly8uCjIoRsN+RYq86TiDC2s77WoVggd53EM7OLz1o8cwTXhydVuWNkun35C97ReppUwcnXoIyfzV2rtGpvD3CihuXHv5aXhNKUMVasKed85pPHCUSeipu4xas4z3GIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456425; c=relaxed/simple;
	bh=p+iCQyGWiwdNhc8Zk8JYmMuYIZNVJjaJvY9S9XcQQ6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YO+masWtw6Vgn71I6BSWx9/ujhKSvoiPO6KwyAjaO1nBQ2OkgnZ5eh6XJyRKvae4mYKP/7I8uZP44kVUUpiblknyB/xJVv62xgJpMr/2cy1+3EmVCLFIbwNKKQ5QJG7NnKWBY3r4W0ds+b1ZAcKJ+gq05cUmYpFjZK9+S8SMMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfYnG5I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfYnG5I"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so35142615e9.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789456422; x=1790061222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7qaufosLZLxweL4OTJOiBy2CZI8aGJ/EJYf86wkdYM=;
        b=CCfYnG5IMNtosyxj2oZYbZJRmW5u/trbzNnd2RzoQbMLK1suliraA3hiv7pc+is4le
         KGVY9YUIEzSf/aWhUknkN/oO4PlPEB/M7Mhvl2Inx5aqjwEvAhtzDZeLphU45dVL6Y9z
         a8/YgHDjOcrwbcF9xiBRfyPxWDkfzXKy2WgRGai64wr0WYDaJvFfrzVzreFjOcuivCKW
         1oNS4YWgW5tzIQ4LBKEaoTundLUzppzKNIDZMxL1ubjQ8Wby2w9ufCMlWYQoFjugn8nk
         c4fqcmeWwc+Dng3gFoW19b4Qa6a2O8A347U4i84sYmgKzRugmmyM63aJLbE6AFKw7rJ9
         X49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456422; x=1790061222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7qaufosLZLxweL4OTJOiBy2CZI8aGJ/EJYf86wkdYM=;
        b=mXrxJFv2RcSvGHby5pyz/WgHFyPqJ945FMIyH1DXrKW/hbFj3bvxTDY1C/noh3lqug
         rDXMzDLmJ94ebyld1uL1JpIQo7uOfWjAouA/t9jdD1fxHN/j1rHeyXpC2lSPpYB1tZRZ
         J0SPj2sPzphkv/5oyOjq+42yoNs/hh2uOee7ect9KvUc+d0w+1fUKGQJ77oKnMqtuQRn
         8PuGfbWoCAfnADVLSPWnSZNDvVlNb2mze12sg+KJ02JRwp+32twiwZsqSBwO5iF2wc17
         aI71Rc0qOqs+OJLVpk2CvRyTznX3GK7BLr+Go1kL7QUs6m0JcZ5QbH68BXiFolk0DBya
         yAZQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5xMj8/vojIXLvRaseBGbYpy7XFXMb4O9NlO5vRCcUPFB8W91AxDV2F3CJcg1HQ7ZJINwwtAg=@vger.kernel.org
X-Gm-Message-State: AFuF++ldYxE9BeeloD0ZWqSxgbuuYRf2XqaJV7FVihx5HYZJT5iPgDFw
	fysCFTDgSiZAS1XiPF05TZZ78EaLnn8kn3NhUZO4IUdk4VI1i5GenU5n
X-Gm-Gg: AYBFou2NPZAxYWMDsNtyTgeGtvdBKHHPlpwWgs2AwifQISBZFZnbBO3vYcX2tvZQDqA
	J1Os7/j/xIFvymg/F/a5sdOuX3PjBTGE6J2mNsBjiU4lsZg/lfzRDKSbUmIAgIOsg+5X66r1HQg
	7I7oVIWwb/p15DOw4GXqzZ5n7NatY3uyXZbvQF1gPRp+u4p5h0uWs5RwLaBe19nwAUa5QqOPAvj
	qShIpe5z+FnRLQmlWA5m8KmHLflP4zC1OI2NrXcetDzDIzKchCEZwbAcOyPWB1hzwAG8CX7h7kf
	SUCUe1iZUc9ohjQ5rRydFxqkquRSAoDe6bv+ghu40CRcO6tqTBFk7ZfGmFEetnHgjYwaemd8c88
	g6rfvNIR+BQfRJUxhwipvKcw8p2LCW9zPvq0OmxtIo1QEFL0+yZGKP3NOX/vR1L1kmN88u9KTUy
	VpRQVXRyPZIdaS7ct3Fk5kfEtvkFh8Et0+EhLk4EcNb93zUhob28oDhniqNfLplCXKX+Yo+jsVz
	3Sn2W9XOGzmziNqf+jUmFKausRTTjUqoatd8tPToXxOVBTbFtuf+deQNtZtaqS0zXIC8gFFHLbO
	pteyjbz2esgYNAQl
X-Received: by 2002:a05:600c:37c4:b0:49e:7862:c09e with SMTP id 5b1f17b1804b1-49e7a656db2mr84113715e9.14.1789456421649;
        Tue, 15 Sep 2026 00:13:41 -0700 (PDT)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d1f85desm38601675e9.0.2026.09.15.00.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:13:41 -0700 (PDT)
From: Orgad Shaneh <orgads@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an 8-bit bus
Date: Tue, 15 Sep 2026 07:13:37 +0000
Message-ID: <20260915071339.15172-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word count of the Write to Buffer command is a single bus word, so
on an 8-bit bus a chunk can hold at most 256 bytes regardless of the
buffer size the chip advertises.

A Micron M29EW (an x16 part wired in x8 mode) advertises a 512-byte
write buffer. cfi_amdstd_write_buffers() used the full 512, CMD(511)
truncated the count to 0xff on the way out, and the chip aborted the
program on the 257th data byte. Every full-size chunk failed while the
partial ones at the start of a write went through:

  MTD do_write_buffer_wait(): software timeout, address:0x03278bff.
  jffs2: Write of 4164 bytes at 0x02c789b4 failed. returned -5, retlen 68
  jffs2: No space for garbage collection. Aborting GC thread

Clamp MaxBufWriteSize in the write-buffer fixup when the bank is one
byte wide, and keep mtd->writebufsize (computed before the fixups run)
consistent with it.

The bug predates the git history, so there is no Fixes: tag.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -283,6 +283,17 @@ static void fixup_use_write_buffers(struct mtd_info *mtd)
 		pr_debug("Using buffer write method\n");
 		mtd->_write = cfi_amdstd_write_buffers;
 	}
+
+	/*
+	 * The word count of the Write to Buffer command is a single bus
+	 * word, so on an 8-bit bus a chunk holds at most 256 bytes no
+	 * matter how large a buffer the chip advertises.
+	 */
+	if (map_bankwidth_is_1(map) && cfi->cfiq->MaxBufWriteSize > 8) {
+		cfi->cfiq->MaxBufWriteSize = 8;
+		mtd->writebufsize = cfi_interleave(cfi) <<
+				    cfi->cfiq->MaxBufWriteSize;
+	}
 }
 #endif /* !FORCE_WORD_WRITE */
 
-- 
2.47.0
