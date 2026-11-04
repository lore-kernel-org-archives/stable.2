Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787817;
	b=Mw0Gv9Kc3tx+GlzOF6rwTTNQ8bKNQsiTnYKuBseM7HwoGd6+QRgzQs0JPb7EDSlHEWiw
	 mixh6wmcLX18S6ZAd9jdj+U4my/1W4a0lgihGZ/ix5ZXYvT43NgPX6XMTxoH4rWvvu0R8
	 PvAycBiKbyUOpk58A7NjolqdBS1WlCqIHUyDfLoImnQhRde2IoY2vqGHZE7xEAsUkJ28e
	 Pv6vX46uVD1gT04OzumyE4SMSNHgOwcJChan93qJxVnm56TcYsO4vSxjwfWFkexW4E01f
	 TJKaTpjH4aWbAqJvn/th4WKgyfFJ56qWE1Uztuu2NLQDS7w5yIfZxmgymH3zR2h1VGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m3d/wzGNwOwiGd7h6SwYhY1GxTniyAmLrkyjp/DieEQ=;
	b=GmSundv5w2XrGBZ7ftLrFaNUHM09967gvAgRM8+XhWgAs0lloQ10PVOxiaKCZypuwLJF
	 T+cqdKlISyLQIyUB7ZNIS53Q15fzNfmy4yx6E8LrE57SNtbRQzmRms56RHonoQTirvylD
	 PTYk1w2/74VB5VESdUnN89QYz1caQr80PCzR1nZx7OSOYHJHfAKDgNx43hfQm/Sh1e/cY
	 m7KTlawTjU6mmQP8FJyzgn5VV9J7Zx/znGy61FqQ/vzARs0IT3I533q54kHUZ9ailB9Q5
	 a5AU+f2OZDlPHIxOLl0iz6lY9/d/Rp+KcSdlwI5PqDa3UT4yYKafQYCbVb5GieKIggg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=Rw6J6PVY;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC485606A33C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC485606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=Rw6J6PVY
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so682782eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793787811; x=1794392611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3d/wzGNwOwiGd7h6SwYhY1GxTniyAmLrkyjp/DieEQ=;
        b=Rw6J6PVY5JuXf3efAuBwBkmOqE0fmQT6ehKVaHVqWMSFdzWr3DEFzWO6B/0eRMq08u
         ONefvo1rdhn7rgB995tA3v7K+u/xhWlegbSUAw2Gu4gEQh5+mu95QpX8EndSqFHSyagB
         I8liLFX5toT/OAMZGtwBx44EytCBpHrGkKFYd9PrUBnBddNrUt6nnlymi1akZ/XaFuUm
         o46JgYh/cpcE0isJGA0kdD0qoC2CtlECn2+4q53WBkC8T9QJoaT0W/ZPdpkRtZYouNJv
         Hmg/cjIfslmaOowC76NHERWGt85a7PTcSNE6nVvOeKDQJYb6Db2RCMZsQ7X4ApIptDCM
         rlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787811; x=1794392611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3d/wzGNwOwiGd7h6SwYhY1GxTniyAmLrkyjp/DieEQ=;
        b=JQ3wkjDtp/ypqNUR6T5uaKiG+od79I6wZbEyLZe/BrgtTLe2Ar3qKY7XsgBk3d3O/Q
         HQPWxcgDaLxKZWe4eosnjx77sO7PhsJV8lkQBms79v0A6vC93lFkfzNAw0k17JrRQgq6
         yB+YuIKqbLaIihzx6d/XdGzI+Kg4Jywdh+SMLt8BcaRbW/MIJh2AJnH5tO8ImNlGi3iE
         zemb0pRi6NfQ5OzulZKLDBQUVHTMXbGErt/UKqB/11jKew9aoy3Fe4+FzCkx3i199aep
         iGJDuxTywcK1EjCM4cJYRSx0sT2iGlTozRFA2jUNk9z++2mNCl8zbYZ8RIRDfw1Ni5PS
         DF1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx1g/BjxLsS4t1N/ZZeJh35fLwtcCkwimYKB35jy0jU3GfAHNgEFtlukO/I/dVTLMl2f3iAcB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fHwuw16/VdBqmF59549s3neGV0gdZnQTZAS+6AllygVlIOwCh
	v6FkpubjuEsblrzFB+j5liVSjn7wGHOKlMbM3Um6SGJ+cnioqD/GdIH4tBf2tzWJtw==
X-Gm-Gg: AYBFou3ZtX6kigTzd/fE90mybFLLvIMqxM2ucjBpBjm0oSX8aSeergYFF4+5QjNBLjV
	ghlvl0wqU55E573D+VNqJdmkKDfO0GcywMPREz6ulJZFKmpUfMUNfVBI8mO4Tuarq+zr6R5vre4
	vSrfWIDFVJtieEo2tGIP71j//1TV7YfDRWzvpN/8zYHYMyDQcKDzFPhaafgo0UE0LQyuhbVgI+Q
	K9jYCsg4+R5lzKI62x8cx/kQT6JWU1oXQlN3lHccva2Y6Ru1r4PXIoSD26vbWlLYMxDhuNRfflv
	dFUgmrZZnrUE5C/k1SEOzAOnKBSOfex+D38/+ketM07yDOB1Bz1Gx/ERS6WciQ+qr1wZDdHCV6a
	XulQE7GfB6A8n6efgDIoabMdXZgzVS0GgjyMWoEB4T96HvN9yQSKYSeIX3Cc7RYPEcd5wzEnqaI
	WNr8ogeMmRCKT3YlVpgTxhQK5IdMZ2TpyhiS2obMzr3KDAaiqEGyBmYV0B5zwZzroVgF2YXSRtF
	9UlwidsH5gediaI0KiC8vvWqKY3jABbfb9TYMjjTkI2C8RhQUugN7ubsGY7grgrr/Tz/4D1iV5G
	tdInBYnWCJ/uLI3fdEVyDZSN2Ez2XkxPCW4MzVdaLg==
X-Received: by 2002:a05:693c:88c8:20b0:369:f2d6:4108 with SMTP id 5a478bee46e88-36a42401233mr23215503eec.10.1793787810538;
        Wed, 04 Nov 2026 02:23:30 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:ff01:97fc:f9e5:d7e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm5749086eec.9.2026.11.04.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:23:29 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: dsterba@suse.com
Cc: wqu@suse.com,
	boris@bur.io,
	josef@toxicpanda.com,
	fdmanana@suse.com,
	mason@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] btrfs: skip tree blocks in btrfs_get_extent_owner_root()
Date: Wed,  4 Nov 2026 03:23:19 -0700
Message-ID: <20261104102323.4090290-2-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104102323.4090290-1-smish149@asu.edu>
References: <20261104102323.4090290-1-smish149@asu.edu>
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

[BUG]
With simple quotas enabled on a filesystem without the skinny-metadata
feature, deleting a subvolume triggers the following warning:

 ------------[ cut here ]------------
 WARNING: fs/btrfs/extent-tree.c:393 at
   btrfs_get_extent_inline_ref_type+0x1b9/0x2d0, CPU#1: btrfs-cleaner/84
 RIP: 0010:btrfs_get_extent_inline_ref_type (fs/btrfs/extent-tree.c:393)
 Call Trace:
  <TASK>
  btrfs_get_extent_owner_root (fs/btrfs/extent-tree.c:3128)
  btrfs_lookup_extent_info (fs/btrfs/extent-tree.c:187)
  walk_down_proc (fs/btrfs/extent-tree.c:5647)
  walk_down_tree (fs/btrfs/extent-tree.c:6170)
  btrfs_drop_snapshot (fs/btrfs/extent-tree.c:6392)
  btrfs_clean_one_deleted_snapshot (fs/btrfs/transaction.c:2728)
  cleaner_kthread (fs/btrfs/disk-io.c:1553)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  </TASK>
 ---[ end trace 0000000000000000 ]---
 BTRFS error (device vda): eb 30720000 iref 0x3ee6 invalid extent
   inline ref type 0

Writing to a snapshot (update_ref_for_cow()) or a metadata balance
(relocate_block_group()) trigger the same warning.

[CAUSE]
Without skinny-metadata, the extent item of a tree block is an
EXTENT_ITEM with the TREE_BLOCK flag, and a btrfs_tree_block_info sits
between the btrfs_extent_item and the first inline ref:

	item 3 key (30441472 EXTENT_ITEM 16384) itemoff 16079 itemsize 51
		refs 1 gen 5 flags TREE_BLOCK
		tree block key (256 INODE_ITEM 0) level 0
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		(176 0x5) tree block backref root FS_TREE

But btrfs_get_extent_owner_root() always takes the first inline ref
right after the btrfs_extent_item:

	ptr = (unsigned long)(ei + 1);

So for such a tree block it reads the lowest byte of the first key
objectid as the inline ref type. For the key above that byte is 0, and
btrfs_get_extent_inline_ref_type() warns. If the byte happens to be
BTRFS_EXTENT_OWNER_REF_KEY (172), the key bytes are returned as the
owner root.

The filesystem is valid. It can be reproduced with:

  mkfs.btrfs -f -O ^skinny-metadata $dev
  mount $dev $mnt
  btrfs quota enable --simple $mnt
  btrfs subvolume create $mnt/sv
  btrfs subvolume delete $mnt/sv
  btrfs subvolume sync $mnt

[FIX]
Owner refs are only added to data extents, never to tree blocks, so
return 0 for an extent item with the TREE_BLOCK flag before looking at
its inline refs. This covers both the EXTENT_ITEM and the METADATA_ITEM
layouts, and gives the same result as on a skinny-metadata filesystem,
where the first inline ref of a tree block is never an owner ref.

Fixes: 8d2990914073 ("btrfs: add helper for inline owner ref lookup")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 fs/btrfs/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b0a5c6b9..3ab4f2696 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3117,6 +3117,9 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	if (btrfs_extent_flags(leaf, ei) & BTRFS_EXTENT_FLAG_TREE_BLOCK)
+		return 0;
+
 	ptr = (unsigned long)(ei + 1);
 	end = (unsigned long)ei + btrfs_item_size(leaf, slot);
 
-- 
2.54.0

