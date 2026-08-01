Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05E3D7D8D;
	Sat,  1 Aug 2026 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625002; cv=pass; b=q2hVqZazmrO2SKjZ7vhdMgMJ+ChzSvOZY5fSlZ/pW+bukiMidJJ1p9ytNqMS8z+5NRmXgOkdSqIxcuLPfiQI3MiLSrYsV1agIND2Cif0uQrY0kcp4CZmaEnIhpm1seUE4TSY1VXuYcUb/m0IqbYo8ki4ugqF3dkI6wrdKrOT8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625002; c=relaxed/simple;
	bh=XdkxGDfzSI7P6MMJk62hR0JJOfNVTLTtD0YeeEO23Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfhp1IU099NLRzZCQMO3x/2CdgFbVR3bVZeJJrU9dFJAHL8uzkcQv8IiQpVY+2RCV2NdBJ9e3nWhKkVIoS5gVnyABDTFySCa9JvkcQjuxsN6CJDKpTLHZN10KIqgNevvCurSfxXvxxylWCFJ2aSTLVApgVMhm9cZDPoSep7Qe4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=pNv5cwU9; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="pNv5cwU9"
ARC-Seal: i=1; a=rsa-sha256; t=1785624971; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jt7sRDIDN01YmpNDQD2JZw3uk2DdwbrICvORWzJXdc2nNeYeU+9fOv+oqkyBAynjTAD97R996oq1NgvjlvNmNPMekuHu9SETwCyc6RFPxtft6X2o/Loyas5KiCaCkeEtiaw2slwLlEg8/XIMRBXkbrADnEAIPLYVHFAGYrSsN9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624971; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oPnFqlEANbkxNnysV+MSTA5NNFDMwBcEWEn1p+4Ko4s=; 
	b=XWfwFvvZ/YNfeEAbIAcY5XvJhcnPag1k1jHe4BJWc6OyoaXePH+zkd3x0pPUolluPbtiiIwRFlYLWjqv/G4MdpXRexYFxgEw5Ux/ThSdyqnOmvvQBppngSbZArYdVQPjLxZfRU3hFxQUs0rftTEGKYhEQuSO1UMVAp+8aYRPvic=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624971;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oPnFqlEANbkxNnysV+MSTA5NNFDMwBcEWEn1p+4Ko4s=;
	b=pNv5cwU9dUWyxx2DprP+0yhrDe+G2Q/p8T6ImYk6PP79vtlB6/wIA0NkPKbcFUBq
	oLwzChfbE5L+NnZfIDIW7NCBnSDvfqna+KWdGSceyD4cetVFDuQHPtvWEX8DL1urCZi
	84E+vLknDDKz5OK6GXuRN2gGM7ZSae/5oVGYii5U=
Received: by mx.zoho.eu with SMTPS id 1785624969818237.25911884847096;
	Sun, 2 Aug 2026 00:56:09 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] ufs: fix fragment relocation offsets within a folio
Date: Sat,  1 Aug 2026 22:55:26 +0000
Message-ID: <20260801225530.148386-7-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_change_blocknr() walks the buffers covering the fragments being
moved from oldb to newb. Inside a folio it starts at the buffer holding
the first fragment:

	pos = i & mask;
	for (j = 0; j < pos; ++j)
		bh = bh->b_this_page;

so j is a buffer index within the folio, not an offset into the range
being relocated. The body then uses it as if it were one:

	pos = (i - beg) + j;

On the first folio i equals beg, so pos comes out as beg & mask where it
should be zero. Every fragment is then shifted by that amount, both the
source it is read from, oldb + pos, and the destination recorded in
bh->b_blocknr, newb + pos. The tail of the relocation ends up past the
end of the new allocation, which is only count fragments long, leaving
dirty buffers pointing at fragments that can belong to another file or
to metadata. Later folios start folio aligned and are unaffected.

Reaching it needs a page larger than the filesystem block. beg is the
start of the existing tail and so is always a multiple of fs_frag, while
mask is blks_per_page - 1. When PAGE_SIZE is at most fs_bsize the two
are powers of two with fs_frag the larger, beg & mask is zero and
nothing goes wrong. ufs_fill_super() already refuses fs_bsize below
4096, so every 4 KiB page system is in that case. A 16 KiB or 64 KiB
page kernel, as used on arm64 and ppc64, mounting a filesystem with a
smaller block is not.

Keep the starting buffer index and subtract it, so pos counts from the
start of the relocated range again.

Reproduced on an arm64 64 KiB page kernel with a 4096/512 UFS1
filesystem, where a block is 8 fragments and blks_per_page is 128. A
file with a one fragment tail in its second block has beg 8, so
beg & mask is 8. Filling the fragments that physically follow that tail
and then extending the file forces the relocation:

  ufs: RELOC: beg=8 count=1 oldb=1457 newb=1528 mask=127 beg&mask=8

Before this patch the first byte of the relocated tail reads back as 0
instead of the written data; after it the file compares equal. The same
test on a 4 KiB page kernel never gets beg & mask nonzero, as expected.

Fixes: 5431bf97ce69 ("[PATCH] ufs: prepare write + change blocks on the fly")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/balloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 628edfde3a9f..f617df64c45b 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -241,7 +241,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 	const unsigned mask = blks_per_page - 1;
 	struct address_space * const mapping = inode->i_mapping;
 	pgoff_t index, cur_index, last_index;
-	unsigned pos, j, lblock;
+	unsigned int pos, j, lblock, first;
 	sector_t end, i;
 	struct buffer_head *head, *bh;
 
@@ -272,8 +272,8 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 
 		head = folio_buffers(folio);
 		bh = head;
-		pos = i & mask;
-		for (j = 0; j < pos; ++j)
+		first = i & mask;
+		for (j = 0; j < first; ++j)
 			bh = bh->b_this_page;
 
 		if (unlikely(index == last_index))
@@ -284,7 +284,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 		do {
 			if (j >= lblock)
 				break;
-			pos = (i - beg) + j;
+			pos = (i - beg) + (j - first);
 
 			if (!buffer_mapped(bh))
 					map_bh(bh, inode->i_sb, oldb + pos);
-- 
2.55.0

