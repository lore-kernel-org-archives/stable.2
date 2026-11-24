Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560358;
	b=CuCq2/ifSxFkLdlqN/yK8FiBBX/02sRrfbArRhH5R5gDQNlT4BJH/N6vkG7H84lfB06Q
	 oSogRAxL0s6CG1Q9A7ScMa5jNNiE86lbhXXopc912ntUyj28aEkFniV4BnCNWN1CqdUEc
	 nWDsKzX/zgzqTNw4af723ZIk1f92SL1Py37DEB561cQu1xhyTtnLuKgHtvZipMjYXgiWO
	 tHPElTU5IOdl9cqQZyhUb2KsYyIRIiLm6eanxtqs6V0PQJ9rzhGA0RhDxqmwXn7pTqtEP
	 6agnUnuJLwpzLdhC2GulVoNLTRBeCIT6WUdZsgvO6oEZVPp6UbvKfhSNMhwQ3TY2MxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XaHsIMY6GCdwAMM5rktMhsHaqS/UYvvihMsPHbZs9oQ=;
	b=uPFzSR0cBHyjVLqIVV4r+UHXFaBS0Qd1O9p0OVNrDIhBAWW32oFiYEgnoS0IgSzw3KYJ
	 FHoQ9Jv+SFvfxP0FKOqHE/doBOEV7ArLojAC4cbFDlARxHEFGYSi/JbhzVTYPMTE7/cHm
	 3yf2Ro+gRtKweZxWetFp+tDiyq+XJh074h3z7yzB05X9EBIdrJZEbFZEtIS4oAEr4J/9/
	 N8mEHxcCR3z8P6fV9YFkV7pzfXvrtobIyozDuMjCQCxtaOb5ROi/Kkzsxiq/7K21YxNlD
	 8JRKxlsDkIgpTG6xWKnjNhoi8vh6iGwtw0+tgrDpoN45GtKlSGWIixVBmLBGOxpo0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhFeLbBr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD3606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhFeLbBr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6BA1F00A3E;
	Tue, 24 Nov 2026 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560357;
	bh=XaHsIMY6GCdwAMM5rktMhsHaqS/UYvvihMsPHbZs9oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhFeLbBrr6bRq4mRhef6mn4/sE6DfwLGBQnRI9YaLuDFe/+cXZM71G5Ql3PXcErwU
	 CZC/S4rFVB25L/0r2wVnyRNcAO+MRZF9Wd6ihgkqNpnUiXRaL/Ibt8VImClpKMZ7Jn
	 gxojg7GGTe2dX7AW692x6dQCPnv9c3+i/mgzdpXwYynJwKhWOv4sAlYigh4VEo6Wvd
	 m0UlBkrf0Wcp0+OWCqTAq9DiwBxwNKrPwacjyquJw7sv5Z64Q0BCu5adVnc8k5F79H
	 bZKWychxnF5LcHZ77Xqi/c1nvbg9y+BlCHQRwRpCCHFJrjdEqoIeJWYS0Bjp3q4wm+
	 /dp9cLC7RjMrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] btrfs: check type flags in alloc_ordered_extent()
Date: Tue, 24 Nov 2026 17:45:53 -0500
Message-ID: <20261124224517.3116600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112428-spearmint-famished-4675@gregkh>
References: <2026112428-spearmint-famished-4675@gregkh>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 232770bcf3aa65ae83fd7389961fa651f09f7b3a ]

Unlike other flags used in btrfs, BTRFS_ORDERED_* macros are different as
they cannot be directly used as flags.

They are defined as bit values, thus they should be utilized with
bit operations, not directly with logical operations.

Unfortunately sometimes I forgot this and passed the incorrect flags
to alloc_ordered_extent() and hit weird bugs.

Enhance the type checks in alloc_ordered_extent():

- Make sure there is one and only one bit set for exclusive type flags
  There are four exclusive type flags, REGULAR, NOCOW, PREALLOC and
  COMPRESSED.
  So introduce a new macro, BTRFS_ORDERED_EXCLUSIVE_FLAGS, to cover
  above flags.

  Add an ASSERT() to check one and only one of those exclusive flags can
  be set for alloc_ordered_extent().

- Re-order the type bit numbers to the end of the enum
  This is make it much harder to get a valid false negative.

  E.g., with the old code BTRFS_ORDERED_REGULAR starts at zero, we can
  have the following flags passing the bit uniqueness check:

  * BTRFS_ORDERED_NOCOW
    Be treated as BTRFS_ORDERED_REGULAR (1 == 1UL << 0).

  * BTRFS_ORDERED_PREALLOC
    Be treated as BTRFS_ORDERED_NOCOW (2 == 1UL << 1).

  * BTRFS_ORDERED_DIRECT
    Be treated as BTRFS_ORDERED_PREALLOC (4 == 1UL << 2).

  Now all those types start at 8, passing any of those bit numbers as
  flags directly will not pass the ASSERT().

- Add a static assert to avoid overflow
  To make sure all BTRFS_ORDERED_* flags can fit into an unsigned long.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 9a58e56e70f6 ("btrfs: reject refs=0 subvolume without DEAD in SUBVOL_SYNC_WAIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ordered-data.c | 13 ++++++++++
 fs/btrfs/ordered-data.h | 55 +++++++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b3ed4212bfecd..03b1d1e28cfec 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -156,6 +156,19 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	const bool is_nocow = (flags &
 	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
+	/* Only one type flag can be set. */
+	ASSERT(has_single_bit_set(flags & BTRFS_ORDERED_EXCLUSIVE_FLAGS));
+
+	/* DIRECT cannot be set with COMPRESSED nor ENCODED. */
+	if (test_bit(BTRFS_ORDERED_DIRECT, &flags)) {
+		ASSERT(!test_bit(BTRFS_ORDERED_COMPRESSED, &flags));
+		ASSERT(!test_bit(BTRFS_ORDERED_ENCODED, &flags));
+	}
+
+	/* ENCODED must be set with COMPRESSED. */
+	if (test_bit(BTRFS_ORDERED_ENCODED, &flags))
+		ASSERT(test_bit(BTRFS_ORDERED_COMPRESSED, &flags));
+
 	/*
 	 * For a NOCOW write we can free the qgroup reserve right now. For a COW
 	 * one we transfer the reserved space from the inode's iotree into the
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 2e7879c6cbc77..96486c4015c45 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -47,8 +47,25 @@ struct btrfs_ordered_sum {
  * IO is done and any metadata is inserted into the tree.
  */
 enum {
+	/* Extra status bits for ordered extents */
+
+	/* Set when all the pages are written. */
+	BTRFS_ORDERED_IO_DONE,
+	/* Set when removed from the tree. */
+	BTRFS_ORDERED_COMPLETE,
+	/* We had an io error when writing this out. */
+	BTRFS_ORDERED_IOERR,
+	/* Set when we have to truncate an extent. */
+	BTRFS_ORDERED_TRUNCATED,
+	/* Used during fsync to track already logged extents. */
+	BTRFS_ORDERED_LOGGED,
+	/* We have already logged all the csums of the ordered extent. */
+	BTRFS_ORDERED_LOGGED_CSUM,
+	/* We wait for this extent to complete in the current transaction. */
+	BTRFS_ORDERED_PENDING,
+
 	/*
-	 * Different types for ordered extents, one and only one of the 4 types
+	 * Different types for ordered extents, one and only one of these types
 	 * need to be set when creating ordered extent.
 	 *
 	 * REGULAR:	For regular non-compressed COW write
@@ -61,37 +78,27 @@ enum {
 	BTRFS_ORDERED_PREALLOC,
 	BTRFS_ORDERED_COMPRESSED,
 
+	/* Extra bit for encoded write, must be set with COMPRESSED. */
+	BTRFS_ORDERED_ENCODED,
+
 	/*
 	 * Extra bit for direct io, can only be set for
-	 * REGULAR/NOCOW/PREALLOC. No direct io for compressed extent.
+	 * REGULAR/NOCOW/PREALLOC. Must not be set for COMPRESSED nor ENCODED.
 	 */
 	BTRFS_ORDERED_DIRECT,
 
-	/* Extra status bits for ordered extents */
-
-	/* set when all the pages are written */
-	BTRFS_ORDERED_IO_DONE,
-	/* set when removed from the tree */
-	BTRFS_ORDERED_COMPLETE,
-	/* We had an io error when writing this out */
-	BTRFS_ORDERED_IOERR,
-	/* Set when we have to truncate an extent */
-	BTRFS_ORDERED_TRUNCATED,
-	/* Used during fsync to track already logged extents */
-	BTRFS_ORDERED_LOGGED,
-	/* We have already logged all the csums of the ordered extent */
-	BTRFS_ORDERED_LOGGED_CSUM,
-	/* We wait for this extent to complete in the current transaction */
-	BTRFS_ORDERED_PENDING,
-	/* BTRFS_IOC_ENCODED_WRITE */
-	BTRFS_ORDERED_ENCODED,
+	BTRFS_ORDERED_NR_FLAGS,
 };
+static_assert(BTRFS_ORDERED_NR_FLAGS <= BITS_PER_LONG);
+
+/* One and only one flag can be set. */
+#define BTRFS_ORDERED_EXCLUSIVE_FLAGS ((1UL << BTRFS_ORDERED_REGULAR) |		\
+				       (1UL << BTRFS_ORDERED_NOCOW) |		\
+				       (1UL << BTRFS_ORDERED_PREALLOC) |	\
+				       (1UL << BTRFS_ORDERED_COMPRESSED))
 
 /* BTRFS_ORDERED_* flags that specify the type of the extent. */
-#define BTRFS_ORDERED_TYPE_FLAGS ((1UL << BTRFS_ORDERED_REGULAR) |	\
-				  (1UL << BTRFS_ORDERED_NOCOW) |	\
-				  (1UL << BTRFS_ORDERED_PREALLOC) |	\
-				  (1UL << BTRFS_ORDERED_COMPRESSED) |	\
+#define BTRFS_ORDERED_TYPE_FLAGS (BTRFS_ORDERED_EXCLUSIVE_FLAGS |	\
 				  (1UL << BTRFS_ORDERED_DIRECT) |	\
 				  (1UL << BTRFS_ORDERED_ENCODED))
 
-- 
2.53.0

