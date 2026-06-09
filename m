Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFE3E51FC
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994738; cv=none; b=PXpcNMqHwcvb6mTBP2Fe1u+7LDxecarNEQc+G6/9OGiuU+wUAIm6Ic16qDtUcFwcEbnV1hFiKuMuJgVa4RutRYB9C7FEroXDV76Bk4f9yRMwIYfNKNKc+2XlQKehnnhJVG05LcWeDIm1AhLs79jGgH7l+hMlzkV5Ynv7SM/AXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994738; c=relaxed/simple;
	bh=nqXLEk6Rb2TNsf/WwovB1x5mfWIHQ0SFbCOZRW3avUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGwwyKpBIWTm5ABBvbozgLA+LsaIvr/l4SaOC7M73irs/Cs/OdSKwWikBWfmTFEMmB8YV/hiiXn6gWp0/Tqzwnh1IgTgrWEaiDT6a5NrEY5aWsRjiDvUFYZNFhEvDE/piYq9kT1OwpEaam19oeLiHpeJB9cn+yAUnj38aOhG5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6BV755B; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6BV755B"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c859a374903so1796336a12.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780994736; x=1781599536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c61z23tDhGwGTfT6EkieyR0JW4w6MV+Sv05qJWF5n1s=;
        b=H6BV755BbR2cSn1Xq3XSUAXqLMFmeL+EczCsdCnXcUvsiqpTx3TqPeQVW1WBE/vX4I
         vTztWojnVyZR3ljLc7XeqgD7CqKVK3+OC3i9PrBdfymjz9Ho7G9kbB8/XzLjJSPNkj8B
         O6UfTmv/sYuLyq+axlMMOPz+EvrkVjqottnTPR7Wbdlk335KTIOeGIjeMm99XlkzUah6
         lCLW/Rq6sQQmAGhB7MppX9iKsOSb5SS5bV4+2MDexgVXL1SR6jYLUCqC4mqv2lUTKt5I
         5G3c33oS6/W/36eg/10jOZUfZ3I7/PXFXV2oZu5u7EYqTNNMd3W2xK35RYRIGoPbIosU
         YTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994736; x=1781599536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c61z23tDhGwGTfT6EkieyR0JW4w6MV+Sv05qJWF5n1s=;
        b=ofnLZPo0Oxh5lwF/ctf/4ewaRXFip+XNF+vWF6Lgd1ZtDHA/ffYLuuVwvmJ5gktgRE
         2+BJLnym3ohjO8OmKkyAqj/wcUfGZt6HKOXP2On0mgZyA0QDFp0roHGdLx70ES8J8zUv
         /iFWc4owqalIx3AMSbEG7doSvUafO/K1+x4RREfqJ+2Bu1Gm+Q6ecbFKH+oLe+kx1M9q
         t1GZpUZ4qTCIs044XYvlLCZ5LPaC1gOis5s8UKKBb1tcLiYBx1YhuGXe0PGCxyH4vosc
         Qc+j2xI8qEPZKlnzax65F3QpMUS4yYvJoe5EgqGOh1mE4RT8KJMfUvishHOjJfIP8GYx
         h8rw==
X-Forwarded-Encrypted: i=1; AFNElJ89Q2ZQomo+APMeS8uiWktXN7uijLRafme50wWFq5Md9pGOPiLN1jFy/otdVdmE2lkO9d7qCtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgw2S2PZuH5a3C6IFTmKnkzktnpBVHhZnccVvSGAyzKjrY2J+a
	oKaG61Li5HMDOACSf+mfLUk13KPI3NkXRNCiHU/VaJ6zjx9Vo8EQHfce
X-Gm-Gg: Acq92OGrYHez5yM9ZRQMGr6vNwSsl6Ky7RpHQpJQiE7HoZPoxs9T5i28m/HWOvVNsYe
	T55S2T+nXp8exkKAHKdmSLqNoU2YBuVZ3TmcwLaSSqU1P8W6LvOYxcldPnaxre0vc8oj5CUnGBt
	oBRKX9w5Uxf2a+dbpyeOBq2zv9cx66L0pGesLdScs/bwYPAhoauGe/rr8LzTQgfFC+808YDxdfw
	O9RMXXoBHfaEigO2NCN2V/mz8ik/KrDlVeqqv/9NJKhjzp48JR8F3VG3JzmSZXlgAf2nZLpm7Fe
	lUyJrtib4jtLdHDx5uBBIDEVhVBmR2w5E4oKB3Ix/tEY4InjWY1BubrqEm7yRBmz4IvffHPXbEn
	pHVQTyFyEBD6Hpc+sPzfdBb19SlZoFNvIrHRmWWgVdIS4BTHntNtvcR5WeZMGOdM2RNBNQ04WAU
	tyC3yA2oUHg5vchkILVEIbBUjrubCQMDg9X6gXtoaqaztWPIipKzIgkg==
X-Received: by 2002:a05:6a21:1b8a:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3b53beb5c12mr2707477637.37.1780994736430;
        Tue, 09 Jun 2026 01:45:36 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85deeb2bdesm17608599a12.0.2026.06.09.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:45:36 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: slram: remove failed entries from the device list
Date: Tue,  9 Jun 2026 16:45:27 +0800
Message-ID: <20260609084528.5-2-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609084528.5-1-ruoyuw560@gmail.com>
References: <20260609084528.5-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_device() links a new slram_mtdlist entry before allocating all
of the state needed by the entry. If a later allocation, memremap(), or
mtd_device_register() fails, the partially initialized entry remains on
the global list. A later cleanup can then dereference or free invalid
state from that failed entry.

Unwind the partially initialized entry and clear the list tail on each
failure path after the entry has been linked.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/mtd/devices/slram.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 69cb63d99f573..48c2bc6b65eec 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -129,6 +129,7 @@ static int slram_write(struct mtd_info *mtd, loff_t to, size_t len,
 static int register_device(char *name, unsigned long start, unsigned long length)
 {
 	slram_mtd_list_t **curmtd;
+	int ret = -ENOMEM;
 
 	curmtd = &slram_mtdlist;
 	while (*curmtd) {
@@ -155,14 +156,15 @@ static int register_device(char *name, unsigned long start, unsigned long length
 
 	if (!(*curmtd)->mtdinfo) {
 		E("slram: Cannot allocate new MTD device.\n");
-		return(-ENOMEM);
+		goto err_free_list;
 	}
 
 	if (!(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start =
 		memremap(start, length,
 			 MEMREMAP_WB | MEMREMAP_WT | MEMREMAP_WC))) {
 		E("slram: memremap failed\n");
-		return -EIO;
+		ret = -EIO;
+		goto err_free_priv;
 	}
 	((slram_priv_t *)(*curmtd)->mtdinfo->priv)->end =
 		((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start + length;
@@ -183,10 +185,8 @@ static int register_device(char *name, unsigned long start, unsigned long length
 
 	if (mtd_device_register((*curmtd)->mtdinfo, NULL, 0))	{
 		E("slram: Failed to register new device\n");
-		memunmap(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start);
-		kfree((*curmtd)->mtdinfo->priv);
-		kfree((*curmtd)->mtdinfo);
-		return(-EAGAIN);
+		ret = -EAGAIN;
+		goto err_unmap;
 	}
 	T("slram: Registered device %s from %luKiB to %luKiB\n", name,
 			(start / 1024), ((start + length) / 1024));
@@ -194,6 +194,16 @@ static int register_device(char *name, unsigned long start, unsigned long length
 			((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start,
 			((slram_priv_t *)(*curmtd)->mtdinfo->priv)->end);
 	return(0);
+
+err_unmap:
+	memunmap(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start);
+err_free_priv:
+	kfree((*curmtd)->mtdinfo->priv);
+err_free_list:
+	kfree((*curmtd)->mtdinfo);
+	kfree(*curmtd);
+	*curmtd = NULL;
+	return ret;
 }
 
 static void unregister_devices(void)
-- 
2.51.0
