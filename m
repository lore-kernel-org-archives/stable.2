Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74098286D70
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261582; cv=none; b=bIAKDbRWzfD1k8ZH9UVZ1ixvKmZlAQE1TInwk24pBxVrgq1Da8g/D6ek1ouULkx9QfQY7LpDJdUsK0VX8rLTTi+SGO7QdCIhLqrBUYItNTGlBZmTSQWp6dLwLX6nUR6DLWa+hWb7VlKMsPzivEFJg6WNlVfwo4p1xJGGCKP+d4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261582; c=relaxed/simple;
	bh=tWsplIKQlCrKEI3znVxfP3UflojL0jxV8E4AkeIkcUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URVJbB9C7bK44D8N2l96n3vLZH4wg9WmLxhvHiKZZlYr52rMDtDci5R8iyyjreQBFHvwx6KkoJUDlQ+Q6F/fE+PtNTQpr+jDPfjFXFDzkugbywJbJeaLm1OEh3IXn34WrfhdgX4RcH/SavPmiYAe6tc5jsWIxfRInaMmOEDLN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojpBpqRO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojpBpqRO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so3245175e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261579; x=1791866379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNnyigt47m4RvfnCZkqOS4nkufUVHYq8Muto1Qo9rTo=;
        b=ojpBpqRO4s43J9v1K31CiRY4q11X4oaVVEDvz9FeviwXIltKo48dUjnRCA7VvB+Zm8
         oF3QiAsrT0ZTETk8x77ocx3Bg/MKQ1P7qgpseM30dZKV0najGCA/BZZ7v90j6GusCoP+
         n5iRZQ1YWdDoQm8GlA5hfxCUlSA3rW07UIdH/lhMpRFOSgTcPeftaM44/usQ+yrz6V2s
         PhfL2cFvWA1sMpAV92WtJ1aHdGyBYYltxtj/imz9Q99Erg+KDB955kvWGwvmI7pGcftP
         t5K2EGgK484RZFKsamBGX7jXzWafSxAzGXYxb3Va6lnvmBgZrJOrwjWabD23joRcAH7s
         3haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261579; x=1791866379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNnyigt47m4RvfnCZkqOS4nkufUVHYq8Muto1Qo9rTo=;
        b=rypf4tX2whyx7nPqQnN1+sWj7vX5/Bnbjj0aYWijyHyA4XaJzEln5UtyzWhht3IJR8
         wNlnKQfhe7MIAmW6yDiM4QaWsXnFUkPGMwW9NDWoWMp6u3qwFRQef7DrE5gDHB/c26Rg
         TYy8bXcTBYVhXBa++hQJlEs/fR9dsK4G0s4UtKyaSXORraI7mZMcVx99EJHVuyPIAuQn
         ValUnKSUhk+l33CPswrR4eysAAESQgx1uV8LdhiDF73sXD20mpIjfd4z/VEuHITDb+4S
         uJqm+A4a1YC+ojqTSQzuUgx1lxwdONBKRs6OnC7mfpRvx+nY1qizHT2UVDgDIt3iBgj0
         8hvw==
X-Forwarded-Encrypted: i=1; AKwUvBxZRS+1pY1RrCvhWB1qlK3OyzRwmIGBfbIBz1YVdlv6fhsZ90e8sXwLSneeQwHEYQK1qaZESV8=@vger.kernel.org
X-Gm-Message-State: AFuF++lFRhto8IjUDiQuhlTabmeZzekViMEWO+aSTVrVTn3Qvlr9asaf
	KA7jR6wIWKy4KnKQ9r6utnaSrQB7k3FeJv7exCyY/5dc+kI/fB+47Iok
X-Gm-Gg: AYBFou3oWQVUK56rYKMIT30W4PSB4qmIGI6W+DGcH8fK4XBGoa590yQksBIqp6TrEfe
	4LBkC1XxYRvEQh2X4Z9hX5yAfqZ7pC+l9XbC/D1AuQpU1gxcTSweUcQd7WKUHLolzwjK61plAMd
	lwjQXfh6dQjDT4NmewixPIQKQPSSVr7LNK9sPpaLlijmRxfGtap8DsioJNVj7D4J/aKSFCADbWX
	Mz3K3t+7AuKVTvr4hfLKdg0Tw9e/fkW+XnUkV+TE0WZeJZUcYoLUBWQ7xm7Lutvb/XnJ6g+6FlS
	bFQUJsz9tvxsd5ctWGsyKe4SAXiJ9LVE7+GUerfbKb7QzLNN+O4tXws7JLn1B9TiywRvt2D7ECp
	vSvPXPw5EeYAdXbcQNxAH45tq6kqtMbot8SIi6wZZ5aM38YOpZ0EQO3hsK2YKXWicL5fwrzG423
	PVob+vUD4x5E6djn0tvGlg1B4xECsZaj5yM0DIDFoD9IEutU3mYH+qfuEOsZNtHlREDjOdnx+ZL
	dUDNdkhq8AA84olDmzGq1PRqycGMqHTOPQyEszhyOwoemxGqMK5VGz93w0Um5Ei4PA0PqCy7wGB
	520g6HTHDJqF2HKwKP8Djox1LCvk0Rxb9l0=
X-Received: by 2002:a05:600c:4e55:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a17b54a224mr3366195e9.18.1791261578618;
        Mon, 05 Oct 2026 21:39:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8c6dsm62744995e9.14.2026.10.05.21.39.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:39:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ntfs: fix kunmap_local() of advanced pointers in check_mft_mirror()
Date: Tue,  6 Oct 2026 06:38:08 +0200
Message-Id: <20261006043810.5393-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006043810.5393-1-kmehltretter@gmail.com>
References: <20261006043810.5393-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mft_mirror() compares the mft records of a page with the mirror
records by advancing kmft and kmirr by the record size for every record.
It then passes the advanced pointers to kunmap_local(). After the last
record of a page they point one page past the mapping.

With HIGHMEM kunmap_local() warns that the address does not match the
top of the kmap_local stack. What it does next depends on how the
architecture finds the page table entry:

- 32-bit ARM looks the entry up by that address. It clears the entry of
  the neighbouring fixmap slot and leaves the real mapping in place.
  The next kmap_local() on that CPU that reaches the slot hits the
  BUG_ON(!pte_none()) in __kmap_local_pfn_prot().
- x86-32 takes the entry from the stack index, so the wrong address
  does not select a wrong entry. In QEMU the mount carried on after the
  warning.

With 4 KiB pages and 1 KiB mft records the four mirror records fill
exactly one page, so every mount whose $MFT and $MFTMirr folios are in
highmem hits it. A fresh mkntfs volume on 32-bit ARM
(multi_v7_defconfig, 256 MiB of highmem) fails on the first mount:

  WARNING: mm/highmem.c:623 at kunmap_local_indexed+0x254/0x26c, CPU#1: mount/85
   kunmap_local_indexed from ntfs_fill_super+0x224c/0x35a0
   ntfs_fill_super from get_tree_bdev_flags+0x1d8/0x2a4
  ntfs: volume version 3.1, dev loop0, cluster size 4096
  kernel BUG at mm/highmem.c:565!
  PC is at __kmap_local_pfn_prot+0x210/0x214
   __kmap_local_page_prot from ntfs_check_logfile+0x1fc/0x1210

Found with syzkaller. Kernels without HIGHMEM do not show it.
kmap_local_folio() returns the direct map address there and
kunmap_local() has no mapping to remove.

Keep the addresses returned by kmap_local_folio() and unmap with those.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested in QEMU on mainline 551c722f4080 with a fresh mkntfs volume and
with the syzkaller program that found the bug.

  ARM     multi_v7_defconfig plus KCOV, virt, cortex-a15, 2 CPUs,
          1 GiB RAM, 256 MiB highmem
  x86-32  i386_defconfig plus HIGHMEM4G and NTFS_FS, q35, 2 CPUs,
          2 GiB RAM, 1.1 GiB highmem

In the table, warning is the WARNING at mm/highmem.c:623 and BUG is
the one at mm/highmem.c:565.

                          mainline            with this patch
  ARM, mount              warning, then BUG   3 mounts clean
  ARM, syzkaller program  warning, then BUG   3 runs clean
  x86-32, mount           warning, no BUG     warning gone

x86-32 still warns when mount(2) returns. That is the bug fixed by
patch 2.

The other kmap_local users in fs/ntfs unmap an address inside the
mapped page. Only check_mft_mirror() advances the pointer it later
unmaps.

 fs/ntfs/super.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 4066bacabe37..a53f9997c152 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -959,7 +959,7 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 	struct super_block *sb = vol->sb;
 	struct ntfs_inode *mirr_ni;
 	struct folio *mft_folio = NULL, *mirr_folio = NULL;
-	u8 *kmft = NULL, *kmirr = NULL;
+	u8 *kmft = NULL, *kmirr = NULL, *kmft_base = NULL, *kmirr_base = NULL;
 	struct runlist_element *rl, rl2[2];
 	pgoff_t index;
 	int mrecs_per_page, i;
@@ -974,9 +974,9 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 		/* Switch pages if necessary. */
 		if (!(i % mrecs_per_page)) {
 			if (index) {
-				kunmap_local(kmirr);
+				kunmap_local(kmirr_base);
 				folio_put(mirr_folio);
-				kunmap_local(kmft);
+				kunmap_local(kmft_base);
 				folio_put(mft_folio);
 			}
 			/* Get the $MFT page. */
@@ -986,7 +986,8 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 				ntfs_error(sb, "Failed to read $MFT.");
 				return false;
 			}
-			kmft = kmap_local_folio(mft_folio, 0);
+			kmft_base = kmap_local_folio(mft_folio, 0);
+			kmft = kmft_base;
 			/* Get the $MFTMirr page. */
 			mirr_folio = read_mapping_folio(vol->mftmirr_ino->i_mapping,
 					index, NULL);
@@ -994,7 +995,8 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 				ntfs_error(sb, "Failed to read $MFTMirr.");
 				goto mft_unmap_out;
 			}
-			kmirr = kmap_local_folio(mirr_folio, 0);
+			kmirr_base = kmap_local_folio(mirr_folio, 0);
+			kmirr = kmirr_base;
 			++index;
 		}
 
@@ -1006,10 +1008,10 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 					"Incomplete multi sector transfer detected in mft record %i.",
 					i);
 mm_unmap_out:
-				kunmap_local(kmirr);
+				kunmap_local(kmirr_base);
 				folio_put(mirr_folio);
 mft_unmap_out:
-				kunmap_local(kmft);
+				kunmap_local(kmft_base);
 				folio_put(mft_folio);
 				return false;
 			}
@@ -1045,9 +1047,9 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 		kmirr += vol->mft_record_size;
 	} while (++i < vol->mftmirr_size);
 	/* Release the last folios. */
-	kunmap_local(kmirr);
+	kunmap_local(kmirr_base);
 	folio_put(mirr_folio);
-	kunmap_local(kmft);
+	kunmap_local(kmft_base);
 	folio_put(mft_folio);
 
 	/* Construct the mft mirror runlist by hand. */
-- 
2.53.0

