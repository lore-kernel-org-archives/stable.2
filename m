Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630276;
	b=xmpfDKmoMz3nWDdIX2wO92ezx0shZzuJ5FZmHLszo0v1zEDKOtExhXFToP3HBM1Q2ied
	 s+VO7p0UkOyYRW8QHixzY/U5msHF2CN8MfqajSQmkw4zLLlwYikDSE+ELj3oEdWVHg4Mf
	 clfJyErNGuH/xsLuy90CF5nSE047BT6OqpITjiYIltYM6GD4JSJibxIfinV8nQHjTOY47
	 6iXL171Lqrfq6ynXM6dVyzZqzL6D+63HXAe/v6Zi03a8JQsL4twqAvj8fGKjLv998E29K
	 rZuVMGSY8LTcVCfyTMUHh2z7Lea6saS3dCoI5X4x9ykd7N2YebOZWCtfzCjjObOwLqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630276;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Envelope-From;
	bh=KkZEDMc9TV7vIke2IgqAteHrPzpueQVEpD8e48hwjuY=;
	b=n8O7pUnYjFMxWd1R0wy0t9an0nUHcH9HLXtyVHszryJy7i7VygE8u0mK/fmACUCNuQcm
	 6EjOLHcdULaLhTJWj2CR5IjwXyM4OabLe5aw8B2t7d9CoHqv4Y5JKKC2kYXoH1iyPhlAO
	 JnyzHE96J2XwBNJ7WTy3FbpbBCF1g/NIFj/kflXBb1GAPvjZi5j7uaCm10GF6L88kZmWj
	 Ha3gbxcwvcatiHE2IXNu/dCFijN6wvcwG529eKiPZPUsp0NB4YFIDUwpz9MxBcteGt1+U
	 KrfuLVHWoNr0ELFlGRqZv5ejMH76oieyGq1rUtup4guC2kB6+dRDMj0ykDlkM6OYhqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=elliotjb.com;
	spf=pass smtp.mailfrom=elliotjb.com;
	dkim=pass header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256 header.s=default header.b=Lucy0rYA;
	arc=none smtp.remote-ip=63.250.43.117
Received: from out-2uec-a117.jellyfish.systems (out-2uec-a117.jellyfish.systems [63.250.43.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5166606E03F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5166606E03F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elliotjb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elliotjb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256 header.s=default header.b=Lucy0rYA
Received: from mail.privateemail.com (unknown [77.233.63.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4jJDnb6wCZz8sWR;
	Mon, 02 Nov 2026 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elliotjb.com;
	s=default; t=1793630261;
	bh=KkZEDMc9TV7vIke2IgqAteHrPzpueQVEpD8e48hwjuY=;
	h=From:Subject:Date:To:Cc:From;
	b=Lucy0rYAla2d7RoATI04kJj5bIZJlfOotWlUwswr2HfsfFXFgUpeFleOqoUpxdkpJ
	 53LtC3faDdcMCljr/Odo+kYpLmIFCrVTklr0LtubDj6ZyJI5JtOfYOT5NMcglHJnsP
	 rjFCpYI5r4RxnEK9gMxVnGsK/z0RnP0cMIsCDPxjLEI5IV/rlss9DyVdqNU0mdLXl1
	 hBpqOyeMvczEC90aLF9y2KMiwkv/pbYMfQ8mGshfTcSJ/qGaqWW8bFZln8ZcKLXWUh
	 pnWKpn+Y1tRjx8CaUU4M9qZye5RN3gl1GhMzKvul0kmIUEbRfuW13TAXeKJacU0ahG
	 mzdU1GUMlgROA==
From: Elliot Berman <elliotjb@elliotjb.com>
Subject: [PATCH 6.1.y 0/2] Fix NULL folio dereferences from IS_ERR() checks
 in 6.1.191
Date: Mon, 02 Nov 2026 06:37:02 -0800
Message-Id: <20261102-ext4-ntfs3-null-folio-v1-0-4fd91ee23a4a@elliotjb.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6g6GoC/yWMQQrCMBAAv1L27JYkDQH9iniozUZXQiLZVCqlf
 zetxxmYWUGoMAlcuhUKfVg4pwb61MH0HNODkH1jMMo4rZVGWqrFVIMMmOYYMeTIGc3gR6e8PVt
 F0Np3ocDL8b2C63X/hdtfy3x/0VT3J2zbD/H2EFaAAAAA
X-Change-ID: 20261101-ext4-ntfs3-null-folio-23da60d4940e
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Sasha Levin <sashal@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yongjian Sun <sunyongjian1@huawei.com>, Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntfs3@lists.linux.dev, Tom Bereknyei <tomberek@gmail.com>, 
 Elliot Berman <elliotjb@elliotjb.com>
X-Mailer: b4 0.15.2
X-Envelope-From: elliotjb@elliotjb.com

We hit a kernel oops in 6.1.191 in ext4_mb_regular_allocator(), When
ext4's s_buddy_cache pages are evicted, the next block allocation
dereferences a NULL folio.

$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/zero of=/mnt/b0 bs=1M count=4 conv=fsync
BUG: kernel NULL pointer dereference, address: 0000000000000000

PGD 5f19067 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 908 Comm: dd Not tainted 6.1.191 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
RIP: 0010:ext4_mb_load_buddy_gfp (fs/ext4/mballoc.c:1536 (discriminator 1)) ext4
Call Trace:
 <TASK>
ext4_mb_regular_allocator (fs/ext4/mballoc.c:1641 fs/ext4/mballoc.c:2798) ext4
ext4_mb_new_blocks (fs/ext4/mballoc.c:5793) ext4
 ? ext4_find_extent (fs/ext4/extents.c:925) ext4
ext4_ext_map_blocks (fs/ext4/extents.c:4369) ext4
   ...

The cause is a mismatch in these backports first released in 6.1.191:
    d34e4fd4e73f ("ext4: convert bd_bitmap_page to bd_bitmap_folio")
    862483175d3d ("ext4: convert bd_buddy_page to bd_buddy_folio")

The ext4 mballoc folio conversions were written for v6.4 and later, where
__filemap_get_folio() returns ERR_PTR() on failure. 6.1 does not have 
commit 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio") and
returns NULL instead. The backports should check for NULL and not IS_ERR.

These came in as dependencies of a3a7d360252c ("ext4: fix e4b bitmap
inconsistency reports"), also new in 6.1.191. We could revert all 3
patches and translate Yongjian's patch from `folio_test_locked(folio)`
-> `PageLocked(page)` instead. I suspect backporting 66dabbb65d67 ("mm:
return an ERR_PTR from __filemap_get_folio") is too heavy for stable,
since it requires updating all callers.

Since the same mistake could exist elsewhere, I ran a Coccinelle script
over the tree to flag similar missed backports. Besides ext4, I found one
more case in ntfs3:
    95b917a14b15 ("ntfs: Do not overwrite uptodate pages")

That one needs a folio allocation failure while reading a compressed
file, so it required crafting a fault injection in __filemap_add_folio to
reproduce. I've fixed this one as well.

Reported-by: Tom Bereknyei <tomberek@gmail.com>
Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
---
Elliot Berman (2):
      ext4: fix NULL folio dereference in mballoc
      bs/ntfs3: fix NULL folio dereference in ntfs_lock_new_page()

 fs/ext4/mballoc.c  | 28 ++++++++++++++--------------
 fs/ntfs3/frecord.c |  4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 08889840163ebcdb7e24bf7ec311bc2e6fc3aaea
change-id: 20261101-ext4-ntfs3-null-folio-23da60d4940e

Best regards,
--  
Elliot Berman <elliotjb@elliotjb.com>

