Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75961E8826
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707078; cv=none; b=k4193xXGYow2rmuOPpSrcVKYttOhMeFVbM9UXgnh0O8TaCP/s6JFM8XNqHF2XuwhY2ZzL48Gty1xi4X2VrIZaCDnxJOjznnNSb5J+z2XUbgxXtiQQJosk5CaScOVda6Qs3TdKMsbQHDKxWts72pzTkGVIe3v2CxE6RPJrHeuNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707078; c=relaxed/simple;
	bh=aals59Uqw7a9P3z/N+kTSzrOjlRI4R68FhtlvfkAWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0kNjUrKJwBQrKaw0QmN0Jdsp7N29KwxPJdwm25jS7cNiZPFPTDdXLSzpi/RiF5bjCiNi+m41q9oIFgo3teMiUZPMut5DukjZTqLIhv/zDGF0lS3WNEjma7ghfp8s8FPuGOMBqyb9oTItsKtQG6v3RzhM8GrdtB0bdyen64nWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0709Q0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0709Q0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F121F00A3D;
	Wed, 26 Aug 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787707077;
	bh=e0+QbutN1CsnbrIHXqQ7oiGNCCMjfGYF5KEBU73MaQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0709Q0XdO3gNn8B/hlYF5tY64zWvKuuofuE+DJ75nTa4yH3Sq/UF9G/97G5xWadg
	 Ar+fgNC+qK+wY3LL644uZobAdaUga6iVYcGmXeUiGo0uvzhmT1Qnr74PlJfIIqsNg2
	 EDYyvSJwocyK6yRQqJw4Fxw3mJnbkibEPehg/XAq4TvBsEuhHrW7tqK9ezzOCLdO10
	 xe1Bm7IiokhmM1tLbeQJ2BLDC3EucY/hKe0lm9VeZMIlakJM6FmDOkfOzRigE6Gm8B
	 wsh6+oGtfWt9eT4lZTFh9KJCF8k11MB+MZDjIL2B9xw0+0ao2g5pZAro9VRHT96O4y
	 8WLhVhnfzy6Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ext4: write back partial-zeroed edges in WRITE_ZEROES
Date: Tue, 25 Aug 2026 21:17:54 -0400
Message-ID: <20260826011754.959071-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826011754.959071-1-sashal@kernel.org>
References: <2026082452-contact-marsupial-dc79@gregkh>
 <20260826011754.959071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit d19d239ada9b7c92d086a1f051b7566538ee0089 ]

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were partial-zeroed in dirty unwritten or delalloc state, the buffer
is left dirty while the underlying extent may not yet be converted to
written. As a result, a subsequent SYNC write to this range would still
trigger metadata changes, which violates the semantics of WRITE_ZEROES.

Fix this by calling filemap_write_and_wait_range() for partial-zeroed
edges to flush out the zeroed data and ensure the extent conversion
is complete.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-9-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 27ca641e701b9..4bbd5fb2e2045 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4776,7 +4776,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
 		return ret;
 
-	if (((file->f_flags & O_SYNC) || IS_SYNC(inode)) && partial_zeroed) {
+	/*
+	 * In FALLOC_FL_WRITE_ZEROES mode, edges that have been partially
+	 * zeroed must be written back to ensure the entire zeroed range
+	 * is converted to the written state. In SYNC mode, writeback is
+	 * also required to persist the zeroed data to disk.
+	 */
+	if (partial_zeroed &&
+	    ((mode & FALLOC_FL_WRITE_ZEROES) ||
+	     (file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ret = filemap_write_and_wait_range(inode->i_mapping, offset,
 						   end - 1);
 		if (ret)
-- 
2.53.0

