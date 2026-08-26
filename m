Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC923507B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705410; cv=none; b=qQdwGTHH4Q0kYuom9w6Xm6tHnaiP9BsAVCqtVYAt16Aswivp68J3+/8kFiyoTXlHxqrbiI2xIooEgJ0oe0ogtsGcTrpy09PMQ2laN1eefDYhFc2V3EBBNwv2nLkazr+3h9k1JtPt73AliXzNpEj8FgcnvsU4+iQAEpZSLHmDSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705410; c=relaxed/simple;
	bh=LxaUrjlftyQiBJAXMzYGZfXfyl/Kf1OnXZbtgwBzfFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOWMRkzb0FQy+U61IH7GAwrNPpXFGsmreUYAlRBb1e3CGO9k/Ze/WEeLgcZzUn/0SDOqoj6Pp69yL5OaXRxHW6iJ7Z3WKK+WVomKEb/dncOB8wTSBSHL2VE6N3JkvRVkN1+eWB07Srwkd4UAEe7O1U6tjtpEVG0RGg/VU1bYC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl+3/l2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl+3/l2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1401F00A3D;
	Wed, 26 Aug 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705408;
	bh=djTXQmUnYWJWZ12wMmZ6v9wjcK6r8D2M8wWo0XSXMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gl+3/l2uH/B8WD5x6FvcLMzcEMWAyS3eeKTp2Kz5+3Qv0Ugcs17aRHXx3vxl8sCL7
	 /Naj/t1XaidjCom+fgC6xEro4qyajvLgyNbdwy6N5809r/uOu6RVIlRn3nakirvTlm
	 HtZ7OVUzRGkzyX2sJO6c8j4ZZt4dM7O91YCX71d3cn1x80nlyFnv+9iNY9YJyttAI0
	 eT8vO2PC9tcHetYKbUs9T183nTiEbNh+3ufh5Ceay0ppbcYpqWzba14Znwal5iuLsU
	 CN46TLZEWV5b6FR5WiRAp6uL5kO+Ssfni1i8YH/supgD21KuRYxf9HWjWPuECsCwVc
	 gShwNABJhmzog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ext4: zero out whole block for clean edges in WRITE_ZEROES
Date: Tue, 25 Aug 2026 20:50:05 -0400
Message-ID: <20260826005005.830778-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826005005.830778-1-sashal@kernel.org>
References: <2026082417-smokiness-hacker-071d@gregkh>
 <20260826005005.830778-1-sashal@kernel.org>
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

