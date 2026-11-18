Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021897;
	b=Ibobq22ZTZa20tX2rbd1FomXMUL1Bz4P1ms2La/uzkKm9KzmQ8R+td3kWM2WiIIhGGSD
	 vzNE1pPBdoKqpwCoGwECWdr4km6Zv2LJ5mYFpC5KPUYcx93sJAwDVmPDfXqnvkvE0zX6N
	 HbdkVUbya4GJLH4376+icPEuA1lo/IDzPY46Ic0SkQ0oiSOBuHS7CjHXFQ3/jfgoEGBHa
	 SqakAbeF1lKyvcNh9+E/xjPNrqq8SgKo+vY+ONInaLZsORbsQ9/kaeI4veHTuBwaL6PX/
	 61okfkgAWQRsvTvnuaGz9PTns17VZRcuQBEb0r+5Y/KG0P/7isMmnb5/qUF0iyX6gXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWp0jG2juceevuM2YsolFtcRIHWNJWaTOnAlYBFAhC4=;
	b=xs5NwW9MENw2VD5uDAWH73+Qvy7fpuhHAw4449MtMzktwSxPv3GnvgoIlsbXHaMSta4G
	 ORN0J6DQ/uIL3z7Z0cEchbClIlJapmyG7qaTgjI4G9Wjog8ygh3dQvRrulaKCQ4awTHNW
	 6+EvZVGSs+vF3QZwG+kS66ZfG1aZSnngwE52ss0aJOVYB/YuIm33/P5NHcexKb24MbldB
	 /jhmUgPRNMTexGLK4zc947bFBCT/pSm6dPNQ/3ckqJ/cbEx75nM1VJFShvneBqdqy5WKW
	 QFb+sUy/XiK9Z6nPudABOKPwacpQQ4+08w8bi86T72E0eTsFe2nWqpBkKpLqt7jBizQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XO60H0VU;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBA606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1FBA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XO60H0VU
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so859125e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795021895; x=1795626695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWp0jG2juceevuM2YsolFtcRIHWNJWaTOnAlYBFAhC4=;
        b=XO60H0VU5b7Cy/MGh9DAcvSzwUqnZNksKEVgrM0j2MSzmV52f9+uN9r6zMFHo4zNR4
         m7w7KxhLiAQivMkCaopVVbKIw8Mn/zQ8twjcXkuKdzdnsyVzKlGaWMgxPxvWS6Yy6xA8
         4e3BrxPpCkSRY0ijPPtDdAlXTnriw8jn0XbGim54uDuMZMIYKlRG6yeF0mUeRj6oSmYr
         zRIJXZdb1Pr06OU6eaHRVodPHCc1x4UnsJ6TTEEZ+gktzCdpwD3PvVrQsKINWXnQSikA
         BhSO0pyztfkmayA4mZBptYCtG28CyJSYBNys3FcueyTopmdmqrgEpSFZcrJPiRizfA/i
         dtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021895; x=1795626695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWp0jG2juceevuM2YsolFtcRIHWNJWaTOnAlYBFAhC4=;
        b=q+kX3/9CminHwS/DmQF3BsJn6niLrGwEuHsjPm0j6L3jo/gu3XGbrWLzeVWtPFNyZe
         UXqu2AgxT2Ri6iCh7bRXREHOupntnx4rwi9uvmm3+VQWnKi0za83821jluP84HdSv/zt
         owK3KomxjCsbDIxed5+ZuIxluO20NOR+nM7pO3zzoELW86r2qalZwA2qh0W62czPBztD
         gFy091zcU6sxPmU6KMOzGFPvDsgcHXjqVt1f5Argf+gqkcWKzEF/3mUnlzpXLr5xhPuH
         qqRZWda83Rn2lDNFB5lJhabgb9dQ0gclyU5F/ZOIsOyty+lSxrhgUqpx5UX9j/d4m61D
         USgA==
X-Forwarded-Encrypted: i=1; AL+hErGp0Uue7tMT/FAolcOVN1MNuwH4jjZsCHLI3e5mUmo/lNnDa16zg/VXXmsn4ND+v1NXNPn1+ls=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jRTEDfJpzodXQE1+2zCKJ1F4bwIGVV6WGgEfI7UMADP0YU+ru
	OUIqG/AOh1RSYh450PPPxKJSibCG9Zgzk8fuuILxNpBj3CnFPsSPApev
X-Gm-Gg: AYBFou2iw5O4P1vH8eByhnoGxUVx+4IXLtVTrwUmo6e0tYxUQSEEpHGgKkIlySoBqSN
	C94K05PIJTwHI7CrC500pPFaU47/dCOk1wECbHhzT2zQMueglm1F2SM1cofxEd1ku6nC8jklcwV
	v7YkZSUy9Lz5SV1hYFmHH32S6OBioNzhNHt3+jBZnukWklPKmddoMHenS9nKm5pN2MbAjlzLZDv
	H3Q0CMj/6MC+UANfeKgkx0at/0D1cFHKmUGm9V5qBJfq4G2/Bg4yh9qdOWmvNVeWK4+AQqU23Fb
	EvC0Rc5mzE9CEVZYOtze/FfsxWF7XTkJiZoGH6j3rq2vjsNT86oIoum/O81N4fToubMCJBsIRv2
	zKg8xy9Dxgg116lXT+brsrCNuBgwXZz/RmXvsuEBTyylQFbDVW99EnRJHxGQEAj/ROOkyTR8iry
	BSFjl4u+nWNtE4i4kciD4D6TZ8nB+7nY8PwwmYKKfeh+zOyjqdXeKG7qyCIH7Ngr2q3Bxw8Dsbp
	/JgWFwbQfVDRk5CjXGyoIwCvXeUP8RLbco3zCL5A8sJbcvZKPEydxZbvGs9vf41QEzMQnsZr1Ic
	jLwpkP9RCTEXldpq0UMQpPc5MH/Z55YteA5S6L0uaX1e5ptP2g==
X-Received: by 2002:a05:600c:4e92:b0:4bb:7ae0:30bf with SMTP id 5b1f17b1804b1-4bb7da147cfmr56248205e9.2.1795021895045;
        Wed, 18 Nov 2026 09:11:35 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb832879f1sm1345515e9.6.2026.11.18.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:11:34 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	takahiro.kuwano@infineon.com,
	tudor.ambarus@linaro.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6] mtd: spi-nor: take the flash lock around spi_nor_restore()
Date: Wed, 18 Nov 2026 19:10:54 +0200
Message-Id: <20261118171054.3885914-1-itai.handler@gmail.com>
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

spi_nor_restore() runs on shutdown and unbind without nor->lock, while
the MTD device is still registered. Tasks are not frozen on reboot or
kexec, so the restore can run in the middle of a program or erase. A
busy flash ignores the command to exit 4-byte address mode, so a boot
ROM that reads the flash with 3-byte addresses then fails to boot the
board, and the soft reset aborts the program or erase, which can
corrupt data.

Take the lock in spi_nor_restore(), so that it waits for the operation
in flight, and refuse later operations with -EIO, as the CFI drivers do
after their reboot reset. Otherwise, a later operation could still be
running at the reboot or kexec, and after an exit from 4-byte mode, it
would still use 4-byte addresses.

In spi_nor_remove(), unregister the MTD device before the restore, so
that its users, such as mtdblock, can still write back their data. If
the SPI controller removes itself on shutdown, spi_nor_remove() finds
the flash already restored, and does not restore it again.

The wait can be long, as spi_nor_erase() holds the lock for the whole
request, up to a full chip erase. If the lock cannot be taken, warn and
restore without it, as before.

Backport note: from v6.4 on, apply this on top of
commit f594a33f9721 ("mtd: spi-nor: Unprepare legacy controllers upon
RWW wait interruption"), which is also tagged for stable; only the
context differs, e.g. spi_nor_restore() tests nor->flags before v7.4.
Before v6.4, the lock helper is spi_nor_lock_and_prep(), and it has no
_pe and _rd variants.

Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exiting")
Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 7.3
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
Changes in v6:
- Return -EIO instead of -ESHUTDOWN, as the CFI drivers do after their
  reboot reset (Michael).
- Move the _pe and _rd unlock helpers up instead of declaring them
  (Michael).
- Take the lock in spi_nor_restore() itself, and drop the
  spi_nor_lock_and_restore() helper (Michael).
- Rename the flag to "restored", test the flag rather than the error
  code, and set it also when the lock cannot be taken (Michael). As
  another operation can then read it at the same time, use READ_ONCE()
  and WRITE_ONCE() for it.
- In spi_nor_remove(), unregister the MTD device before the restore,
  so that the unregister can still write back data, e.g. mtdblock's
  cache.
- Shorten the commit message, and update the backport note.
- Drop the Assisted-by tag, which the documentation no longer asks for
  since commit 1e035297ffda ("docs: remove Assisted-by references").
  As with v5, I used an LLM to help write the code, the commit message
  and the QEMU tests.

Testing:
- Built with W=1 for arm64 on mainline, and its backports on v7.3,
  v6.18, v6.12 and v6.6.
- In QEMU (v7.3, ZynqMP GQSPI, n25q512a11 with broken-flash-reset, and
  the flash model patched to stay busy during an erase):
  - kexec while an application erases and programs the flash, with a
    3 s and a 10 s erase: the flash obeys EX4B, nothing reaches it
    after the restore, and the secondary kernel finds the flash.
  - kexec with the GQSPI driver changed to remove itself on shutdown:
    the kexec completes, and the flash is restored once.
  - Unbind with a write still in the page cache of mtdblock0: the data
    reaches the flash. With the restore before the unregister, the
    write-back fails ("lost async page write").

v5: https://lore.kernel.org/r/20261029210153.3986211-1-itai.handler@gmail.com
v4: https://lore.kernel.org/r/20261004104311.2196527-1-itai.handler@gmail.com
v3: https://lore.kernel.org/r/20260915113811.2429311-1-itai.handler@gmail.com

 drivers/mtd/spi-nor/core.c  | 87 +++++++++++++++++++++++++------------
 include/linux/mtd/spi-nor.h |  2 +
 2 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a04d22d2e2e1..44cb9c4a411b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1230,6 +1230,11 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_exclusive(nor));
 
+	if (!ret && READ_ONCE(nor->restored)) {
+		spi_nor_unlock_and_unprep(nor);
+		return -EIO;
+	}
+
 	if (ret)
 		spi_nor_unprep(nor);
 
@@ -1290,6 +1295,18 @@ static void spi_nor_rww_end_pe(struct spi_nor *nor, loff_t start, size_t len)
 	rww->ongoing_pe = false;
 }
 
+static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len)
+{
+	if (!spi_nor_use_parallel_locking(nor)) {
+		mutex_unlock(&nor->lock);
+	} else {
+		spi_nor_rww_end_pe(nor, start, len);
+		wake_up(&nor->rww.wait);
+	}
+
+	spi_nor_unprep(nor);
+}
+
 static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
 	int ret;
@@ -1304,24 +1321,17 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_pe(nor, start, len));
 
+	if (!ret && READ_ONCE(nor->restored)) {
+		spi_nor_unlock_and_unprep_pe(nor, start, len);
+		return -EIO;
+	}
+
 	if (ret)
 		spi_nor_unprep(nor);
 
 	return ret;
 }
 
-static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len)
-{
-	if (!spi_nor_use_parallel_locking(nor)) {
-		mutex_unlock(&nor->lock);
-	} else {
-		spi_nor_rww_end_pe(nor, start, len);
-		wake_up(&nor->rww.wait);
-	}
-
-	spi_nor_unprep(nor);
-}
-
 /* Internal locking helpers for read operations */
 static bool spi_nor_rww_start_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
@@ -1366,6 +1376,18 @@ static void spi_nor_rww_end_rd(struct spi_nor *nor, loff_t start, size_t len)
 	rww->ongoing_rd = false;
 }
 
+static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size_t len)
+{
+	if (!spi_nor_use_parallel_locking(nor)) {
+		mutex_unlock(&nor->lock);
+	} else {
+		spi_nor_rww_end_rd(nor, start, len);
+		wake_up(&nor->rww.wait);
+	}
+
+	spi_nor_unprep(nor);
+}
+
 static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
 	int ret;
@@ -1380,24 +1402,17 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_rd(nor, start, len));
 
+	if (!ret && READ_ONCE(nor->restored)) {
+		spi_nor_unlock_and_unprep_rd(nor, start, len);
+		return -EIO;
+	}
+
 	if (ret)
 		spi_nor_unprep(nor);
 
 	return ret;
 }
 
-static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size_t len)
-{
-	if (!spi_nor_use_parallel_locking(nor)) {
-		mutex_unlock(&nor->lock);
-	} else {
-		spi_nor_rww_end_rd(nor, start, len);
-		wake_up(&nor->rww.wait);
-	}
-
-	spi_nor_unprep(nor);
-}
-
 /*
  * Initiate the erasure of a single sector
  */
@@ -3231,7 +3246,16 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 static void spi_nor_restore(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
-	int ret;
+	int lock_ret, ret;
+
+	/* Already restored, e.g. remove() after shutdown(). */
+	if (nor->restored)
+		return;
+
+	lock_ret = spi_nor_prep_and_lock(nor);
+	if (lock_ret)
+		dev_warn(nor->dev, "Failed to lock flash, restoring anyway, err = %d\n",
+			 lock_ret);
 
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(params->flags & SNOR_F_4B_OPCODES) &&
@@ -3248,6 +3272,12 @@ static void spi_nor_restore(struct spi_nor *nor)
 
 	if (params->flags & SNOR_F_SOFT_RESET)
 		spi_nor_soft_reset(nor);
+
+	/* Refuse any further operations. */
+	WRITE_ONCE(nor->restored, true);
+
+	if (!lock_ret)
+		spi_nor_unlock_and_unprep(nor);
 }
 
 static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
@@ -3630,11 +3660,14 @@ static int spi_nor_probe(struct spi_mem *spimem)
 static int spi_nor_remove(struct spi_mem *spimem)
 {
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	int ret;
+
+	/* Clean up MTD stuff before the restore refuses further operations. */
+	ret = mtd_device_unregister(&nor->mtd);
 
 	spi_nor_restore(nor);
 
-	/* Clean up MTD stuff. */
-	return mtd_device_unregister(&nor->mtd);
+	return ret;
 }
 
 static void spi_nor_shutdown(struct spi_mem *spimem)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b3e3c6b10186..b9f4e041c4c2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -361,6 +361,7 @@ struct spi_nor_flash_parameter;
  * @read_opcode:	the read opcode
  * @read_dummy:		the dummy needed by the read operation
  * @program_opcode:	the program opcode
+ * @restored:		the flash was restored, refuse further operations
  * @sst_write_second:	used by the SST write operation
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
@@ -402,6 +403,7 @@ struct spi_nor {
 	enum spi_nor_protocol	read_proto;
 	enum spi_nor_protocol	write_proto;
 	enum spi_nor_protocol	reg_proto;
+	bool			restored;
 	bool			sst_write_second;
 	struct sfdp		*sfdp;
 	struct dentry		*debugfs_root;

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
