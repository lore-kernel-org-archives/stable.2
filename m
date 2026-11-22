Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377546;
	b=vtZNwZFU0f/z8odyqNWLBydrMER+XY8+gg7mLfhLNOAbgRYnhogUczwIAxatNAEDatji
	 8QRvb6FzmUg2+uuqjy5/sY+xSksQrhPCJvKsIDmDpjHD0du8hHsruZtAJ1D/MoyUwF2SY
	 kn2DXjnjJyKZ5uPSqcdtJMkeQA5aF7vSEiCfZ1arpmi/LhHKkN8y6LqQq6fr2DUH1v6GE
	 ezjfPtT4M3dmdrD14ekZr9zJ0/6QMftfLhK9eCzP4IK7zoBStK3Lk6FD5dHXelK1gaSbP
	 Uz0buX04dr8g0ZrQwQPWcH+L0qCnoXt1ABv/+S2NVU1NBH7353OoIl/7SSh8SXNJxRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9486t8MDZh9CRWIIRPLLQLKLk1aMMjjsLJKjWbdp8Do=;
	b=OXvztHpyISK/6B/Bjh1+h5N/D1gW2wB6gc2hSOmKRSbKVmZNebgik3zIqZ2wSDmyPrmv
	 90lmI8FjEWmT97bbK56WE917lV26zrIzeAevuMWFv/FpZCGYNvoREgo4fi7l9d7L3sbn1
	 7Mhq2yo49NDiYoIIQeQBj9Wzoo0cRvLD9S2/i+YFT+UyAl9PkfnQ1KHJHnMqLSFUgBBtB
	 deASHQC3QPR2x83eDTeNoyVSXG/W+lhyMJLR95O6TxHRz1sBMhZjIAnn8aUnxZO17uiIl
	 6sO+GPs+fQhWAaRTnaA29zRKDpt66hD95lbCHBxiFDL0fMdjizYGPYym8weOqbWtOmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkPD0MQq;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CF606A31D
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671CF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkPD0MQq
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so19202955e9.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795377545; x=1795982345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9486t8MDZh9CRWIIRPLLQLKLk1aMMjjsLJKjWbdp8Do=;
        b=NkPD0MQq6shm1P6WXzCt9PBbua/tZdJvjpcery2bsGBOJ0EvWPvyi/7EOaS7A2Ajbc
         p980qjvF3+xj3MGa6vobnV9thburPoRiImDLxDCcsoROrSrTzQU3J3NncteuWCJZ+9XM
         TEST2Dsr/1wqCjHT+aci5RXhwxRtGwe19S+ZZNpgH4iWtTaWv5O2L9JWLIrdb30IScIy
         ecEIWOGbX2iECi+rQBBnHvI6MriNC5PuNIaemx/k3nXuTr8NF+tCDHf4ig8fSLB0VICt
         aXaxkxkw/JBjD7hpnF3PeuI1fgZavehgZpti7qxhTsjiLtahqj5UUpq2LkwIZWe0mAWj
         lNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795377545; x=1795982345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9486t8MDZh9CRWIIRPLLQLKLk1aMMjjsLJKjWbdp8Do=;
        b=KyHU+Ghh5nJS0196boyVT4j+mZiodEaZMDpQ8INRXHQPyg0C4RNb7Z9yTUDS7a5NNr
         5Pw3cfcukJ4UwMkR6wP6k267P1EGk3RfzD67jCSGjem0CzXl+nDZtztpHWdzQOSN/v3m
         3eLkK1/1P4NaoiRdAWzpQ38vDmFxHCNHCCuTez+nHszLx9msqdR2LiO/fLuKd59WRiP8
         1RlVzMs7laFkZlSEfOHg3H/eTjoGlAouLP8+LewmJVvxLOfJFIOuWjuZyvbzKwJZZ0Q6
         HT8oeCRKUg+F7oJr6dX2QUathMC0YUKSisq9oB/RXYNrWh0YLu/qzySi8tCFso5Ph7Yo
         yaDQ==
X-Forwarded-Encrypted: i=1; AL+hErF+NWH/aDYWlg8dgJv/SW+VHc/8bSVeiOiNs3rbY9DyT+GbGKmHIUhmf/ZeyU3WUD/oOFenr7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bJ889X0WMuzwr5q8HCG2aNYM8FfruCpPRRxNO8p9W+Z4mptIe
	dtd+OsPXL2b42cjeiSVZv1Sr+877riqbXfTysYlrpzInAcLFW2Ce1NZF
X-Gm-Gg: AZFdTZc0AFRrmT/hUbULdlmhkuUQ/Ahfiucin3AjD2nIWyv6GgiVowROM3UHYKJcuvW
	TPAgnu18FgGF6Ipak6c3qxa3OAcNZZu8UDy4A+tUNsuF+iNQ787rQABUE8scW7emo/eWP5ZewBe
	BfG953cLDQVOB80nMFJnlpKtXLvkr4p7dwdHyTsKm01yLkfj8ra7ppg5XI4vqDT7DVK7kayy759
	Hc7WJwp58cFUK7g6Sjzj2tkGGz0W4Qs4DR8EZaHna/mA192XhEcZL8mmN527tOB/OuoyL1RSCey
	09fLJJo5nc3feFmghfL0ZMkrOC1Ml3uY/BOAoIn+um9q4QrnC3ZPE781AU9C4n0c3fZhdqOzXm/
	dP71AVGrIRdLc7o2drRrJNdMxLUPlG9Lu1x2LiF9urEq9ndwZFUEFkg81Yc6tUT/7V2BiSN0/7+
	/xTQrPEeDgc8+NJxqFna2+6EPllfySwuzBqct7O1cxs78WZ0tkEhM7X1IjT16QEB9w/eSgGYDBt
	AM3N4kdEoNL0cCfCmm/cws8voipVF1R4ySLpLcrzoTi355ilxvGCDVs5olSNOTMLFFk34rogWu1
	7AGS3VTGIoqBSX81Nnb3ewpUYWrHoUmEhljepTJAqcJZzieEtpZ9jHwr0jC29EMy3OvPIcyeLoW
	qUw==
X-Received: by 2002:a05:600d:600b:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4bb8882375cmr203166315e9.32.1795377544621;
        Sun, 22 Nov 2026 11:59:04 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm536568555e9.4.2026.11.22.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:59:04 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+d7ffeb5538fe5c793f74@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] jfs: handle NULL folio->mapping in metapage_write_one() and release_metapage()
Date: Mon, 23 Nov 2026 00:57:58 +0500
Message-ID: <20261122195758.32692-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

syzbot reported a NULL pointer dereference in metapage_write_folio()
called from metapage_write_one() during lazy commit teardown:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:metapage_write_folio+0xa7/0xcf0 fs/jfs/jfs_metapage.c:428
  Call Trace:
   metapage_write_one+0x2c8/0x520 fs/jfs/jfs_metapage.c:818
   release_metapage+0x5b9/0xab0 fs/jfs/jfs_metapage.c:884
   txUnlock+0x509/0xdc0 fs/jfs/jfs_txnmgr.c:948
   jfs_lazycommit+0x52c/0xa10 fs/jfs/jfs_txnmgr.c:2734

During unmount or inode eviction, truncate_inode_pages_final() can
remove a folio from its address_space (setting folio->mapping to NULL)
while jfsCommit still holds a reference to a dirty metapage on that
folio.  When jfsCommit subsequently runs txUnlock() -> release_metapage():

1. If META_sync is set, metapage_write_one() proceeds with a NULL
   mapping and calls metapage_write_folio(), which dereferences
   folio->mapping->host (and filemap_check_errors(mapping) would also
   dereference NULL).
2. If META_dirty is set without META_sync, folio_mark_dirty() is a
   no-op on an unmapped folio, leaving META_dirty set and the metapage
   stranded on log->synclist; drop_metapage() then skips freeing it and
   jfs_flush_journal() stalls waiting for log->synclist to empty.

Fix both paths under the folio lock:
- In metapage_write_one(), if !mapping, clear META_dirty and call
  remove_from_logsync() on any attached metapages, clear the folio
  dirty state, unlock the folio, and return 0.
- In release_metapage(), if META_dirty is set on an unmapped folio,
  clear META_dirty and META_sync and remove the metapage from logsync
  so drop_metapage() can release it cleanly.

Tested locally in QEMU (x86_64, 4 CPUs, KASAN+UBSAN) using syzbot's C
reproducer with per-iteration mount namespaces: crashed in <1s before
the patch, and completed 56 mount/remount/unmount iterations in 15s
with zero hangs, KASAN, Oops, or synclist warnings after the patch.

Reported-by: syzbot+d7ffeb5538fe5c793f74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7ffeb5538fe5c793f74
Fixes: 35474d52c605 ("jfs: Convert metapage_writepage to metapage_write_folio")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/jfs/jfs_metapage.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 41fe12e64..9df810c97 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -812,6 +812,23 @@ static int metapage_write_one(struct folio *folio)
 
 	BUG_ON(!folio_test_locked(folio));
 
+	if (unlikely(!mapping)) {
+		struct metapage *mp;
+		unsigned int offset;
+
+		for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
+			mp = folio_to_mp(folio, offset);
+			if (!mp)
+				continue;
+			clear_bit(META_dirty, &mp->flag);
+			if (mp->lsn)
+				remove_from_logsync(mp);
+		}
+		folio_clear_dirty_for_io(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+
 	folio_wait_writeback(folio);
 
 	if (folio_clear_dirty_for_io(folio)) {
@@ -879,12 +896,19 @@ void release_metapage(struct metapage * mp)
 	}
 
 	if (test_bit(META_dirty, &mp->flag)) {
-		folio_mark_dirty(folio);
-		if (test_bit(META_sync, &mp->flag)) {
+		if (unlikely(!folio->mapping)) {
+			clear_bit(META_dirty, &mp->flag);
 			clear_bit(META_sync, &mp->flag);
-			if (metapage_write_one(folio))
-				jfs_error(mp->sb, "metapage_write_one() failed\n");
-			folio_lock(folio);
+			if (mp->lsn)
+				remove_from_logsync(mp);
+		} else {
+			folio_mark_dirty(folio);
+			if (test_bit(META_sync, &mp->flag)) {
+				clear_bit(META_sync, &mp->flag);
+				if (metapage_write_one(folio))
+					jfs_error(mp->sb, "metapage_write_one() failed\n");
+				folio_lock(folio);
+			}
 		}
 	} else if (mp->lsn)	/* discard_metapage doesn't remove it */
 		remove_from_logsync(mp);
-- 
2.53.0

