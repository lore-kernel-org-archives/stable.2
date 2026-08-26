Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC819AD90
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707078; cv=none; b=oUJMeEu3eJ+ye0jl5LRST2DaKSkY5HJBy3G40b6VY+D1ydUOQEAKPwyMMMs5yg1mJ2hJyUOK0rW76JZZJvyVwiCtw+tT5YErE+KsyZRn5nPV5yvuwpQaAObQm37V9w1Rv2gjDOuN8rRztaOQBm1v88lmTaljNzHJymtBnGSvzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707078; c=relaxed/simple;
	bh=+Iqok1xp3PGBZJsnVKh+aGEjW9BfCx+zGq3OyjgF4+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8lhBgYAmzZmE9EaG86CW+Z97S8hkPH4D6cuzzjbslPHb2JW1G3UGUFs89Oj+b+3iZoU2xITGcd7JCJBY3tsRFCpmp+bOtI3Jb+ETeLeEfLJ4AyMMcIV6/W7OBf/d6FGhrO3H/Oxhd3HZV4qBjYefTWr1PYchTkYVCvUxWgPjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZfc6R8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZfc6R8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3221F000E9;
	Wed, 26 Aug 2026 01:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787707076;
	bh=OboyFfebPJ+XhrNR0C8nsxs14ZVxMwyCuR/wLWcr8TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZfc6R8Xg/XslIHOQjaYpniBCVquKkDdW7RopJ+aNYypsZGPqJFaT9jEj6JUEBbQX
	 eOwbKhAp5bor/rcACXaTvLRZH9RXc0bU1gKzOhdMAV8aTx9b4iYHhjcRvxGk/ymqFn
	 nY165J0KqIg/r/T4v1SHXn2IbY5NFMrrnzBBSWe+PizTvMg2K3sUdyXHLfu7Qx1ilV
	 7QqmVckGPz+nbqz8F6z3FN6Ok5HyuScdY793dnAMAMOkE/hNwstdEn1EFCh7AJKupF
	 XIrf4gd6g/hoRVqjDMHdAUIRVCxUsaN/D07UKIGc5HsVzIClEqItBoW5C0Z2ei4czU
	 vHuqOkRidV4uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] ext4: move partial block zeroing earlier in ext4_zero_range()
Date: Tue, 25 Aug 2026 21:17:53 -0400
Message-ID: <20260826011754.959071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082452-contact-marsupial-dc79@gregkh>
References: <2026082452-contact-marsupial-dc79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit b16e9d27a643a3cf8907c994d25ed52717f36418 ]

In ext4_zero_range(), move the ext4_zero_partial_blocks() call, which
handles unaligned edges, into the same branch where the unaligned range
is preallocated, immediately after ext4_alloc_file_blocks(). This is
safe because there is no dependency between partial block handling and
the subsequent full block handling.

This change will be used by later patches that handle unaligned
FALLOC_FL_WRITE_ZEROES operations, which will need to check the partial
zeroed result.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-5-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: d19d239ada9b ("ext4: write back partial-zeroed edges in WRITE_ZEROES")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 125f628e738ab..27ca641e701b9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4734,10 +4734,16 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-	/* Preallocate the range including the unaligned edges */
+	/*
+	 * Preallocate the range including the unaligned edges, and zero
+	 * out partial blocks if they already contain data.
+	 */
 	if (!IS_ALIGNED(offset | end, blocksize)) {
 		ret = ext4_alloc_file_blocks(file, offset, len, new_size,
 					     flags);
+		if (!ret)
+			ret = ext4_zero_partial_blocks(inode, offset, len,
+						       &partial_zeroed);
 		if (ret)
 			return ret;
 	}
@@ -4770,10 +4776,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
 		return ret;
 
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(inode, offset, len, &partial_zeroed);
-	if (ret)
-		return ret;
 	if (((file->f_flags & O_SYNC) || IS_SYNC(inode)) && partial_zeroed) {
 		ret = filemap_write_and_wait_range(inode->i_mapping, offset,
 						   end - 1);
-- 
2.53.0

