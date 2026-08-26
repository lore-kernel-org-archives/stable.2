Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430420C029
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707084; cv=none; b=jHdeEubuHfFzRFEplkdaS64mI5bC4iuL2g0eiSTjn6kUygkJOuozWVJdC5a4P0CjWRiN+8yVPOtyiSlB2D1ZrT0wabLMW0K/9y/39iACClukpg0/KJ3Ux4dBN7Dm0ULg3339jjr/DYye0uB/Z+Ha+w78S0zKKNCycewwCuN+38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707084; c=relaxed/simple;
	bh=LxaUrjlftyQiBJAXMzYGZfXfyl/Kf1OnXZbtgwBzfFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnbghNM1LBFQZs80THPtTUjFnG2Plwy/kcvnycqElIsO4bC9mJNIYiZPvRsLKf70b8UehIQA9BD6UmZz/gu9bvOBaO8QrvbUAKuIHQJqMyaeHL0jLU+a5CpqcNqZj/42tOhOXlHkjX2j0vTYVLxiTT1G6b695Fkz0+d91PkjuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq0dbOdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq0dbOdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA461F00A3F;
	Wed, 26 Aug 2026 01:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787707082;
	bh=djTXQmUnYWJWZ12wMmZ6v9wjcK6r8D2M8wWo0XSXMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kq0dbOdTMhjS1M3otj7KzcZUgc7QMJ3/cLr3LIX+viD8s0ZhWjQjBt12ZetMP+4bn
	 QRfbU7f1sjp8lIbCn574YwMF4V96SNDw3jX9/UiWkFWpGkwvXVsCXr++kntOBDNwAm
	 bGSh12IcZdz87lWrnzAFp2HN+qnzl/2uFLa46Ss/vj/SE5hHGGJ+tAbO97giLKbGbW
	 mlSQMoQaewtzUdw9mnMx5GFM/MrDfvcHl0ol/5cjiVg/HET1S0eUMpR2D/qTCzJysd
	 9l+J5/R7IHbCZthWIVgATXtW9TeJARkDz7MA81kyI/FaphkI0Lx1EVZalqhvcxaZNz
	 fWaxNaN/KjLZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ext4: zero out whole block for clean edges in WRITE_ZEROES
Date: Tue, 25 Aug 2026 21:17:59 -0400
Message-ID: <20260826011759.959801-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826011759.959801-1-sashal@kernel.org>
References: <2026082417-smokiness-hacker-071d@gregkh>
 <20260826011759.959801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit a5179156ac1d9a6646da42254e4c461e1fc20096 ]

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were already allocated, ext4_zero_partial_blocks() zeros them directly.
However, for unaligned edges whose underlying extent is a clean
unwritten extent or a hole, the extent type remains unwritten after
partial zeroing, which does not align with the semantics of
WRITE_ZEROES.

Therefore, when ext4_zero_partial_blocks() skips partial zeroing, it
indicates that the corresponding edges are clean unwritten extents or
holes. In this case, we need to expand the aligned allocation range
outward to cover such edges, so that ext4_alloc_file_blocks() can
correctly allocate blocks for the unaligned range. Edges that were
partial-zeroed (i.e., written or dirty) are left untouched.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-8-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c68feb1697090..934f99cce2c60 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4754,6 +4754,21 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	/* Zero range excluding the unaligned edges */
 	align_start = round_up(offset, blocksize);
 	align_end = round_down(end, blocksize);
+
+	/*
+	 * In WRITE_ZEROES mode, edges that were not partial-zeroed (clean
+	 * unwritten or hole) must be allocated and zeroed as whole blocks.
+	 * Expand the aligned range outward to cover them.
+	 */
+	if (mode & FALLOC_FL_WRITE_ZEROES) {
+		if (!IS_ALIGNED(offset, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_START))
+			align_start = round_down(offset, blocksize);
+		if (!IS_ALIGNED(end, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_END))
+			align_end = round_up(end, blocksize);
+	}
+
 	if (align_end > align_start) {
 		if (mode & FALLOC_FL_WRITE_ZEROES)
 			flags = EXT4_GET_BLOCKS_CREATE_ZERO | EXT4_EX_NOCACHE;
-- 
2.53.0

