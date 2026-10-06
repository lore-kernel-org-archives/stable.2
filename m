Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D76379C57
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262381; cv=none; b=LGtLoesD7w4qn8dIrceNqwvrD1Dzq58znqXZP3avVIM+1BooB2kLtxgdtGhC0ux9wob0FhZp3JL6fhb2kEBa8ChW3vFHD6u8ugZeGJ1ilDqSUhQysz6F06+S/GEsfti+eODgHgTp8dH66GN7O89q7fum+PVFsoIpZpwLXuMI68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262381; c=relaxed/simple;
	bh=tWsplIKQlCrKEI3znVxfP3UflojL0jxV8E4AkeIkcUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5tFyeBGbygQdEnLs9G5afJG+LmEwFf4KBNEyYty/J2F8Q+buTCcf1CXrKjTrCdNUNjGnL6YjwvC8jtvEDwn+EWaH+n002WQBFZKU9dxd8l8A9Ce6Bn3Y/KmdtRmlhgCjR4gnmEaGT1o8bVs3qXbXNGGq1YdqhSCAi8xwtsI5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gENbE+Wq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gENbE+Wq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso1336775e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262378; x=1791867178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNnyigt47m4RvfnCZkqOS4nkufUVHYq8Muto1Qo9rTo=;
        b=gENbE+WqfFn1PxWR6MM0w3E12/ymiq7M0igc0V+w8avrYZilcHxelR64/DtYh3W9eN
         SxkqojHaWZxeWWc7jB0V+JfhmzDQt+TXqhDnMr08MikSt1tpjW8Wt+HXaMBKxQhY94CL
         ELQ1PxyBgb1PgWFf8twHB6oXFeaaqNyq7aZNOzkx/gGn43rz4KqdLK8fpB4YuEVN67vw
         ogPnJHjBxMtnf5njOyTj8nMX0KZ1KGfiTPfaKxAQt5xjuMtG+ylPWpI67KLb863iGHyK
         1cQXIzZJGkCcoYwqfi4z0xb9Dl2ECT8yv+ajBvXH/WD3aqLjnDFpzRVQ13uJ/xNwoaTJ
         TH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262378; x=1791867178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNnyigt47m4RvfnCZkqOS4nkufUVHYq8Muto1Qo9rTo=;
        b=bFvLhnAwRy5+y+nR5RdQizWoSQ0fPs4e2W0sfrxfzruLUDSmSZA1ailTumwhwnAwR5
         6AP0kBOPLDn7T9JIHaanfsjS+yhxI9ZoMC6xapEK94h3wjOEtk3RR+wA8At48lamE8eG
         Bc7LEcbbS0lOt6m3p5oya6hHx2xzsRd0YyHb86IKQ1yOx7qngTY9hrmx163ak9KFqmwC
         +So5DTFv6gERHUyQ3EVTP65XeY/OX++Gv/Kygn9JVlaJO5uQNAiEwaC+8fAtjxpw8G2v
         HO/pyrTaISVJZagbA/mftvbPvt1txzWXj8tcQku8u321CbQMaia7/Gy6EycMupDk6ZEm
         Ck3g==
X-Forwarded-Encrypted: i=1; AKwUvBwicBc/uX88iOCUAI5aDWbn+9EU41DSqLOioqkaHAZpt9f9kBcD0YwkCpJK07n4XdRjwNxNTzc=@vger.kernel.org
X-Gm-Message-State: AFuF++mMhcTJd64PoJweUO8v+t/mAy74WdZ33pZxKZRFXrqSCPH9uQQW
	8yGIn9JDHfuqf3GlystF9Oasq8zakqGVyg92tftnRMdKrTskaf8YW65q
X-Gm-Gg: AYBFou2FfHG9mQe9+yO0wLI23oiEA5tJyHDxmeUKy2VlANGSji67F4mFK2vU6G27oc6
	Ym54ZPH+BxceQuIIePemYyKDOqMidV8xsmxUUqnp5bd+HlapJKpYfQXG+piRX8StJ4QuesayV7t
	3tV1+EGRRuG8l6ZOh57DXpRkMPtfhPHacjKxH0mOl9U7+q9YmhpTArALpV5oBdO8d8zpkIPWNLJ
	avLYTeLbuo9NwYE6e3NIXvC8ELU0ZdG8Og52CT0djxTe443eL55pUuWTMuWL6LUrKrZO/9WbZW2
	5RBQOa762NJduAQ9Ta5Z6xyBdeo5e3ulit/ONP2a0MBWysVaAgVXVnwjque4/FteelU1ZrGobEu
	oJQ0xXmOUzG564pP3g/E2UkvN4hRLmDFQ0USKv8wUELk6Ni94btaAsOnAK3uD0gDZWhkyZmJ8BH
	1GHrHgc8vqBG+RTyiOcsEMA9u/YLw3WKrKi2Ynpeoov6xraTdfIgU6V6AVxfTvgh9GTXsmdq1Qb
	9n6YGruPhQO5ow16EHzviJBPj6mNnsu5C/aE0ZeT3gbi5nCMq+GhnFS/o4yY865NczIHupwg8L9
	8in9MrCGUFpOCNJ9HvXd63USwHn1etFxrMU=
X-Received: by 2002:a05:600c:4e8a:b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a17b4b99a7mr4513795e9.0.1791262378092;
        Mon, 05 Oct 2026 21:52:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53299sm72322225e9.11.2026.10.05.21.52.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:52:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ntfs: fix kunmap_local() of advanced pointers in check_mft_mirror()
Date: Tue,  6 Oct 2026 06:51:35 +0200
Message-Id: <20261006045136.5911-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006045136.5911-1-kmehltretter@gmail.com>
References: <20261006045136.5911-1-kmehltretter@gmail.com>
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

