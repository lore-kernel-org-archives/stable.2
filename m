Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757489;
	b=kEME+eDp+2ydwn1PDvUTkD8/89+0V7Li32wHdJ1xH5LyH4fwlx/OnYeNfkYeHjR3+GaB
	 4tC9tqRK3sRADGNh3SbMMeP8hVWzPNPo+B0H6GciSV1Fp2U1JhMOQ6cLhNIAD/oUXCw4V
	 1Z+K6I2tQTA4ZYjSRDQplGf2d0CkJcnb+vlC//mP7DKwawRO6HmZZhIUvN+wzLN13Y6Qp
	 jQLm/1BGc+Z5yRlZ1A5bes+6t+ajyVwY3ammhL6refsGWDBLlG5QpUUPwhOlwHn9U80lC
	 php0hJSe6hPDJncp0QFHKk5lDmTUGjBOmySpPsTpG+BDUxEJmTl3Jh+eBBPtQv1K8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MX988x6o1/Ce5mttzy33JSern4LXmqKq6kFYkjGT5s4=;
	b=qqmUt0P6K3DnBWNGt4ZvzL14AxD3p/J+oxE+mgXV2BrPuCCYhufhSAwFycblKceTNwb9
	 oACz3a9HYukdZl1f5UzIrGBu1j+sZU8/dEATfBtMoij8onxyOh3LG+qFFgZHuT2Smdd9x
	 6NcCfNDFQ/ER815xCULcqnJgYNpYHd/UySvsDQoHKloPteGi7y2oS1DkXUOomyKORfNUU
	 Ybdx6llYTt12xDLs+7iyqkjaOflpEscgK7Std3goV3LyDOy4PwXiOW/LjSDIiDqgMqSuF
	 d+AUbNOfeljjIVLXr22B9sOHYMCfBGJGepxhJDqlY9lbTusA1WQXcasTvq9OkRUf1Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guXzBWYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C91606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guXzBWYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2C91F000C4;
	Sun, 15 Nov 2026 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794757489;
	bh=MX988x6o1/Ce5mttzy33JSern4LXmqKq6kFYkjGT5s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guXzBWYwh8jnPLMyd5885g8lZpemQf4NSBYJR7A+eggX3bc4hcGeeI2pXim4EnnmS
	 SfumC/4Ved5REPEM3XVYavLqXtVg7VyMU2yqqyEbyT7aJ4qM7XgHzGFHoJcaP4XYCG
	 4czkcm2yYgqucQFwMZLc3Ny6cO60Xv+6Jv9Svp6aAlI6yfSOg7EnzTmWRqckkOZwpt
	 Y47fncL6vhb3e7/IRzuAwpGYlUo504ZzyebndVy5BK4bf77FBCWupcBxrNPkIMcR8Z
	 K2OaBKx31zodp+4UNvKvizIOYbbyqMFdo5f90WbfwfAKqcgTxFpBPiqCIQdtlp6cd+
	 asIPKAzln/nPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] udf: don't use eloc after the end of the unallocated space table
Date: Sun, 15 Nov 2026 10:44:47 -0500
Message-ID: <20261115154420.1273178-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202914-failed-5.10-94401199df90@kernel.org>
References: <20261109202914-failed-5.10-94401199df90@kernel.org>
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

