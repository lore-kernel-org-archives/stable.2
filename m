Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218170;
	b=iM2CKu6EF+veGAOQdaTdaA14H+DjGtxnTefe+vmLpDl1aBdL9BoeycppqHw3iph1Gkbf
	 9LK7wqO43ZYHNyQ4pq8qh7YoHArs3wUQYRZUQX7rxORBf9B9AwBOZTZ+AIs9jMQziu0y0
	 yfwoMjy4CWq+PSrBqPuGePp8RSvRdzjQJleDl+hXa/n2GEj2EMfvWgIAe/xPdDV2WV3qa
	 31dymozjZCZjRUKlP6vontgGCKt6uY3I+RL67r75IJcPX6hU1mA9jEvwQwuzLnzVci7ok
	 kpBOeeq0h4XCJQeNyUyoJgB4kqR53v8AkXInwroh0YTBUmKQp7VkJWL4sHylMxnSJaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218170;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:
	 X-Original-From:X-Mailer:Received:To:Subject:Message-Id:Content-Type:
	 From:Mime-Version:X-B4-Tracking:X-Change-Id:Cc:Date:
	 X-Lms-Return-Path;
	bh=P9v5gomtHM+UM7ktgSnN33eoEYmTkj5Bo7NGWriI0nc=;
	b=jiRAgH914jVfV5ioisimn+4N9rfigxoX6pnqmRMcE+z/MbhyzdOfsCLiAHVFmkLFQwlv
	 ganR3FKiwn51dmN2QTdwzS8Fw3/qylnss2FNUNSeLCrJZNsAX/iwHQVCTmymWCfBoJJ7P
	 mHf9zmUcCog+MJ4M8soWnVPkyp32gTBRyLD2qya+jhhWZAXvEqE05FgabJJoAS1spI/a0
	 QRYr4v80tAX50HHhzaxsmaJPGsyq2Jh0esifVYDDg5qnsDB8JzYrYRxxaVPHix2hm7EsG
	 McM8DBpuRLz47hdbU9gWW7CLiFj8O21EMfHagnzxJJXcURRDZW81ayHzRQwM6KP+dNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=XcC1dZxC;
	arc=none smtp.remote-ip=71.18.227.5
Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A460A2613
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0A460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=XcC1dZxC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793218163; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=P9v5gomtHM+UM7ktgSnN33eoEYmTkj5Bo7NGWriI0nc=;
 b=XcC1dZxCpezEigz/exLwbpTt8YPBE+Iw/METqBr+UwNl/EN9xKZPS4RNCbkoy6tJHOsW4O
 InmVNrqPI7y71335YRnjoi2b2BwTtVGeYjEFEvv9PGT6Gwb0f7Xxhm02fdZGsB2zlZdxsR
 WUXpCpxVPdCAJWWiImlnN1jI4hSq/JAHkhCSZTZD/rnG9ygUlVegrw4JKidogVrrxkomkP
 docqjpylhzbnadVymLeKCPWBYdlhj/GD2xKkkYthzcKYdLEKETi7YUuQODUa+iq3JXz6OM
 auUYmiKHH9+em/jGWdmvqztCpGBhz/nmOsFizlAT8grHU+nLyjdKgXahmiAULA==
Content-Transfer-Encoding: 7bit
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Mailer: b4 0.16.0
Received: from [127.0.1.1] ([111.42.148.156]) by smtp.feishu.cn with ESMTPS; Thu, 29 Oct 2026 04:09:20 +0800
To: "Namjae Jeon" <linkinjeon@kernel.org>, 
	"Hyunchul Lee" <hyc.lee@gmail.com>
Subject: [PATCH] ntfs: wait for bitmap folio writeback before modifying it
Message-Id: <20261029-b4-ntfs-bitmap-writeback-wait-v1-1-e2ba711b2dbf@cherr.cc>
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG1W4moC/yXMwQ6CMAwA0F8hPduELQODv2I8dKPTapxknWJC+ HcHHt/lLaCchRVOzQKZP6LyShXm0EC4UboyylgNtrW9ae2A3mEqUdFLedKEc5bCnsIDZ5KCo+t 6E6lzYThCPabMUb77f778rW9/51C2FNb1B/jXAemBAAAA
X-Change-Id: 20261029-b4-ntfs-bitmap-writeback-wait-d4561fa54c97
Cc: <ntfs@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 29 Oct 2026 04:09:18 +0800
X-Lms-Return-Path: <lba+26ae25671+5f788d+vger.kernel.org+me@cherr.cc>

The bitmap update paths lock their page cache folios before modifying
them, but the folio lock does not wait for an earlier writeback to
finish.  Writeback can release the lock while its BIO still references
the folio memory, allowing bitmap changes to race with that I/O and
expose partially updated contents to it.

Wait for existing writeback after locking each folio and before
modifying it in ntfs_attr_set(), both bitmap setter loops, the cluster
allocator, and the two MFT bitmap allocation paths.  This follows the
lock-then-wait sequence already used for attribute and raw MFT updates.

Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
The change was checked against the existing attribute/MFT waits and
the iomap completion path.  Existing base and patched NTFS object
builds with W=1 and CONFIG_WERROR=y complete without warnings.  No
runtime reproduction or filesystem stress test was performed.
---
 fs/ntfs/attrib.c   | 2 ++
 fs/ntfs/bitmap.c   | 4 ++++
 fs/ntfs/lcnalloc.c | 2 ++
 fs/ntfs/mft.c      | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index fce7144d7bef..b460d2223314 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2332,6 +2332,8 @@ int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
 		attr_len = min_t(size_t, (size_t)cnt, folio_size(folio) - offset);
 
 		folio_lock(folio);
+		if (folio_test_writeback(folio))
+			folio_wait_writeback(folio);
 		addr = kmap_local_folio(folio, offset);
 		memset(addr, val, attr_len);
 		kunmap_local(addr);
diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
index af86fb1c199b..057b315789ec 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -213,6 +213,8 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 	}
 
 	folio_lock(folio);
+	if (folio_test_writeback(folio))
+		folio_wait_writeback(folio);
 	kaddr = kmap_local_folio(folio, 0);
 
 	/* Set @pos to the position of the byte containing @start_bit. */
@@ -277,6 +279,8 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 		}
 
 		folio_lock(folio);
+		if (folio_test_writeback(folio))
+			folio_wait_writeback(folio);
 		kaddr = kmap_local_folio(folio, 0);
 		/*
 		 * Depending on @value, modify all remaining whole bytes in the
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 3ebcac4c2864..aac8627a9283 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -348,6 +348,8 @@ struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol, const s64 st
 		}
 
 		folio_lock(folio);
+		if (folio_test_writeback(folio))
+			folio_wait_writeback(folio);
 		buf = kmap_local_folio(folio, 0) + pg_off;
 		ntfs_debug("Before inner while loop: buf_size %i, lcn 0x%llx, bmp_pos 0x%llx, need_writeback %i.",
 				buf_size, lcn, bmp_pos, need_writeback);
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 89288b794348..b8aa8b0891dc 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1206,6 +1206,8 @@ static s64 mft_bitmap_alloc_free_rec(struct ntfs_volume *vol,
 				return PTR_ERR(folio);
 			}
 			folio_lock(folio);
+			if (folio_test_writeback(folio))
+				folio_wait_writeback(folio);
 			buf = (u8 *)kmap_local_folio(folio, 0) + folio_ofs;
 			bit = data_pos & 7;
 			data_pos &= ~7ull;
@@ -1402,6 +1404,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 
 	down_write(&vol->lcnbmp_lock);
 	folio_lock(folio);
+	if (folio_test_writeback(folio))
+		folio_wait_writeback(folio);
 	b = (u8 *)kmap_local_folio(folio, 0) + (ll & ~PAGE_MASK);
 	tb = 1 << (lcn & 7ull);
 	/*

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261029-b4-ntfs-bitmap-writeback-wait-d4561fa54c97

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
