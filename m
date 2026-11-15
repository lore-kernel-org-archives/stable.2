Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753231;
	b=S+A1L+t6smt6Olg6Xwx/VfPRXGWlDER7RZVKh8IT63KA4NXe9sL3scAq1iTythVlOCGe
	 MJ/FZ6NCGHfnqkcSciNjGFHrwxoPIcGUT5djJC4NLp92rceTxLrsmPMnzRFQk9HMekGHa
	 qJGZSaacgSlfkBz7ecAPAwvWBCVqPXDzaWaKvNUX75cUm4oT9ulPukAvoPREKYB8e6JRR
	 K9QMdtElt4wz5xkM1p+gHJpeCSymOVy7g6GuOMV9hnscTs7F1xFQI+2KAHXqysD1yUxdZ
	 iyu0QE2GVPERHvQtG9w0JjQ6OayVctaI15rwIMiZ8rsHGqCrxkBSaUxh6maVX55GfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MX988x6o1/Ce5mttzy33JSern4LXmqKq6kFYkjGT5s4=;
	b=fDPiBcKjn/cLxpb2gYBA0hAXS6/uEoQ7z7Is04CSzGVlQJX0sKNVJzMbrEefdV4APB1u
	 5nT+I5TYbAt/eIimgiwHK089t9GqgR+L1j6DTaTEpTSCzux3CZ8lwbe0XQ3ghJoaXlS6w
	 sKjJbFDUbE3JeOIuW3SET/xHcNoO7SSKE9zaMweRIchadeAsLkXH1YsVVSMB3fW+jFNcs
	 WyV72RH1Jm9Od3deWz9e5P7RNE8R+nEIONUqRNk1hC29rwGiYuk1hmEDFlAhryhEtREU9
	 Bu/l3qlFD9J/qHisVlGUK/qi9Tavl51pnUKmZTdtCIPdAlEdVTlXrcxNp+s5TZbCwgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqt3E5+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD13606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqt3E5+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250111F000C4;
	Sun, 15 Nov 2026 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794753230;
	bh=MX988x6o1/Ce5mttzy33JSern4LXmqKq6kFYkjGT5s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fqt3E5+QdnA0oD2KxcI5WAnLGmgLGr0WlC1TQzx32yJ7HR41DehhK/4WGmy1ouGrX
	 dSDjQaddguzahB2qz659V6pRtdnKwxw2J7nIoBi5ib5r29wq9UmshVyj3pEgnJF5ud
	 KlVUFgOTanSW2gO9EH99LxnA6YVn9VjrL53PUcjhXZrlhfgSyNCsyYVEiMqOtYZPlR
	 dVw5w3zwEvZXnmWOP6LYsjGA0JCEaB0eqBpbyWkite37QsswmLqubCe5ylJ5FUtIhw
	 gDLf1SVBwOf0HSP98gt6YIub4hvtDVKUN4/qYE4UYAlNhiFcWjV9xWF11Vqem3OPZj
	 dikAG9+E/ZhUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] udf: don't use eloc after the end of the unallocated space table
Date: Sun, 15 Nov 2026 09:33:48 -0500
Message-ID: <20261115143327.1200920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201951-failed-6.1-94401199df90@kernel.org>
References: <20261109201951-failed-6.1-94401199df90@kernel.org>
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

From: Matthias Goergens <matthias.goergens@gmail.com>

[ Upstream commit 94401199df90e1c2a50c6e4b73618ac5a4ba83ba ]

When udf_next_aext() returns 0, its eloc, elen and etype outputs hold
no defined value.  Two walks of the unallocated space table still use
eloc after the walk has reached the end of the table.

udf_table_prealloc_blocks() looks for a free extent starting at
first_block and decides whether it found one by comparing eloc with
first_block after the walk.  If the table's list ends in a continuation
descriptor that leads to an empty allocation extent, eloc is then the
block of that allocation extent, which is in use, and if that is
first_block, the block is handed out as preallocation.  Once
udf_discard_prealloc() no longer frees the wrong block, this is what
still makes fsx in generic/091 and generic/263 read back bad data on a
table, in about one run in four.  Only take the extent if the walk
stopped at it.

When udf_table_free_blocks() cannot merge the freed blocks into an
existing extent, it appends a new one and sets only its block number,
so the partition reference comes from whatever eloc held after the
walk, and with long allocation descriptors it is written to disk.  For
a table without extents, eloc was never set.  Take the partition
reference from the freed blocks instead.  Short allocation descriptors
do not store the partition reference, which is why this half remains a
latent long-descriptor fix rather than a reproduced failure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/fd9ca4c4ba98c00c012ec861f6c0bc08a3b1d07b.1793349907.git.matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
[ sashal: Replaced ret > 0 with etype != -1 to match udf_next_aext() returning the extent type directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/balloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 0bbe86da3d133..267365573bf7e 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -473,6 +473,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 
 		int adsize;
 
+		eloc.partitionReferenceNum = bloc->partitionReferenceNum;
 		eloc.logicalBlockNum = start;
 		elen = EXT_RECORDED_ALLOCATED |
 			(count << sb->s_blocksize_bits);
@@ -545,7 +546,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 		; /* empty loop body */
 	}
 
-	if (first_block == eloc.logicalBlockNum) {
+	if (etype != -1 && first_block == eloc.logicalBlockNum) {
 		epos.offset -= adsize;
 
 		alloc_count = (elen >> sb->s_blocksize_bits);
-- 
2.53.0

