Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898869;
	b=hLgEWUrO2PGQukE/DyuNGu3f/QHNChNdGx6Nj/UePk6zas7Qvx6vrtnFlsFdOp5Bhjk2
	 bXThHq2VXyau9QZyzU/RjPJovpV2wDF3psIYU6OoNJHW45L5YmS74z2dOTQifr9HkFdw7
	 kRGkM3Lh9WwgSev1zPbpoZBxyLk3aolVakGbosyzvbPm5C9blKKxVZjMUsHZZMAs34tOG
	 ilgeVnu4ie7uRNEeyw/O7fCi9EaSsK7XOEL5n2MvcuqyIut9RsPC1yAka1rn1jK8vSDbI
	 5rXHvpTd2BsPNKhdWdavilvSy4YEeQ/XmiWUTD1dGA3hyeIi0tQ8waL0F4oC7mEsqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P37lfkefJrBtIa80/UeHYr21OR8REM2KEKfvhR2BHG0=;
	b=okzLgqs9TAC/d2v7pImnEe49r7ZHlBLfNTuxaZqk2QZoqki6v1tQu1T/9ECLpkDPJZs0
	 bIVJ7DRhfnUMpdjGKwDawvbaHpK1MpbUIuz6G1FvGYM/55TV9sfbQey3peuG+Md1vyhDO
	 /koBbL+ycsOyptOBEVktbvQHPy5H3/bx4PLEXHu6j4otUm11284fwJXaYefLe2juqVJCV
	 u5PCky4KkO11FsYB4lyxW76blw0xgaKeGt8Ph8l2bx7aLS+PoiYiPMy1FJeC759abWIOO
	 7K5IIBXBpt+rcv+oxDb+tv/J6I45mQkldAKf1ZEyhMxt74Z58q62NcQZT6ZDav7nDFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXWBqCbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C63606D80F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXWBqCbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E441F00A02;
	Thu,  5 Nov 2026 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898868;
	bh=P37lfkefJrBtIa80/UeHYr21OR8REM2KEKfvhR2BHG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXWBqCbnigwyGLnADKQhGLAaDv8ywk/TWRoEAhcHpMSaObnwyHIT2eXV+dIFFzcvH
	 V5mByOKv8WzmNufF4wCs4kwzI+2l5Ps5fvSPD4d6WrLL6Ndzbkh0QzKRMaCt9Z7Y/0
	 9NaUyS4thQmXWt0rljwI4xe44v2e75mZKysCcm55KHcc2o8Y0/bbVHEH9rQUcDY4J5
	 eHIblOjjW+CTgD74t7SUFLxPQy0gtNaP2flc+LvKp9c+LzDlS7a7mmwHCkIeN0x+z5
	 3bw7lvUdY5CEgY/7iLDCvAJUocj5tmgFRxmKHKp6ocaTmAlb6vee4x6SqEHw9Zri0d
	 85+nD7oHJkvLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: bound da-node entry count against the correct geometry
Date: Thu,  5 Nov 2026 12:14:26 -0500
Message-ID: <20261105171322.2093902-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-hyphen-guileless-3849@gregkh>
References: <2026110407-hyphen-guileless-3849@gregkh>
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

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f ]

xfs_da3_node_verify() bounds the node entry count against the larger of
the directory and attribute geometries because, as a buffer verifier, it
cannot tell whether the block belongs to the directory or the attribute
tree. When the directory block size exceeds the fs block size (e.g.
mkfs.xfs -n size=64k -b size=4k), an attribute node buffer is a single fs
block that holds only m_attr_geo->node_ents entries, yet a crafted attr
node may claim a count up to m_dir_geo->node_ents and still pass the
verifier.

xfs_da3_node_lookup_int() then indexes btree[] up to that count during
its binary search -- an out-of-bounds read via getxattr/listxattr on a
mounted crafted image.

The buffer verifier is the wrong place to tighten this: it has no fork
context, and the transaction-less read path used by getxattr does not run
xfs_da3_node_set_type() either. xfs_da3_node_lookup_int(), on the other
hand, always runs on that path and holds args->geo, the geometry of the
fork actually being searched. Bound the entry count against
args->geo->node_ents there, before walking the entries.

Fixes: 7ab610f9e0f1 ("xfs: move node entry counts to xfs_da_geometry")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Omitted the xfs_da_mark_sick() call because the helper is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_da_btree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 08871fa84419b..8300d67ae007f 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1658,6 +1658,19 @@ xfs_da3_node_lookup_int(
 		} else
 			expected_level--;
 
+		/*
+		 * The node verifier cannot tell whether this block belongs to
+		 * the directory or the attribute tree, so it only bounds the
+		 * entry count against the larger of the two geometries.  Here
+		 * args->geo is the geometry of the fork we are actually
+		 * searching, so reject a count that would walk btree[] off the
+		 * end of this node buffer.
+		 */
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			return -EFSCORRUPTED;
+		}
+
 		max = nodehdr.count;
 		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
 
-- 
2.53.0

