Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659F233923
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187560; cv=none; b=ivZBFN51pRnaz21TrgaNhJVvnJis1VVCAVFOdT1SospXP8exAGQ5+kZnocgM95eE3L9WR8PoNjld0pWYmhpgY4oyEk5Mb6qRwyBpotp/b9gf/+DUiHR+MAWFGPzUhiVcOArLl3cVNcxlMMaZjXduhtg1Nq4WBTDHMd3oqI3wN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187560; c=relaxed/simple;
	bh=4rlknMyK1LlQyVNn1iiIJlu4v5R7VKJxZCP7Xxkl+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilGLxO9X6BLvF8zHz62WYLtLZq2/vigGFfVG6xhf5XN1etD9rCkXJvBsOC9tu8X7yUY2eD0BuUTfp5lJvfjG+Poqgouuv35OPwwhe/GdPP511To2j0vQ/H/RmerwiOaiqYIqVD88fnAkyEqxaf1tFyLJizEt1tXhxv9ReTUb7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYufHyml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYufHyml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E321F00A3D;
	Sat,  8 Aug 2026 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187558;
	bh=TPUJgPA5yvu+9niqr4m14c8vOxcKoVga03kqHLGoDcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYufHymlcvpF1M0lrl6/T2YwKRNIdbHLBQAye+wf7+SgI+cL8tU9iaAGp4p1pl6MC
	 6jT8rZn+1R0O3n5nNL+qKkOxI+TB4mqcuI/y4RetFySxCyBr7S0pQMLVu0w0674QTE
	 Hb0LC8i5lwMfr5TOD9jDXLT0d8pEu+fB8TRAVCtWCXN+a0XikLOXp3VZhmkSShpR+6
	 JXBzzsPfVw3wcJ4DsQ1PC3cjveJZsSxMlV8BVhnTTyahMO/vzDWe5OcTTEUBYWTOdK
	 oZhUBf2MNItx7MtKNGiCvvpca5WxRie2NznKtVIlZT+f20iDW5yp4yiIO+CjjvIRhA
	 0vV1lxVymv4pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iomap: fix out-of-bounds bitmap_set() with zero-length range
Date: Sat,  8 Aug 2026 07:12:33 -0400
Message-ID: <20260808111233.93672-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808111233.93672-1-sashal@kernel.org>
References: <2026072923-divinely-glorifier-714d@gregkh>
 <20260808111233.93672-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 9c7d8f7c8994c790fca501dc45ce66e7356cbe05 ]

ifs_set_range_dirty() and ifs_set_range_uptodate() compute last_blk
as (off + len - 1) >> i_blkbits.  When off is 0 and len is 0, the
unsigned subtraction underflows to SIZE_MAX, producing a huge
last_blk and nr_blks value that causes bitmap_set() to write far
beyond the ifs->state allocation.

Regarding ifs_set_range_uptodate(), it is temporarily safe because len
cannot be passed in as 0. However, for ifs_set_range_dirty() this is
reachable from __iomap_write_end(): when copy_folio_from_iter_atomic()
returns 0 (e.g. user buffer fault) and the folio is already uptodate,
the guard at the top of __iomap_write_end() does not trigger because
!folio_test_uptodate() is false, and iomap_set_range_dirty() is called
with copied == 0.

Add a !len guard to both functions before the computation, so that a
zero-length range is a no-op.

Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improve performance")
Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20260714082325.325163-5-yi.zhang@huaweicloud.com
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 03e3a6417596d..549490acb229e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -61,11 +61,13 @@ static bool ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
-	unsigned int first_blk = off >> inode->i_blkbits;
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, last_blk;
 
-	bitmap_set(ifs->state, first_blk, nr_blks);
+	if (len) {
+		first_blk = off >> inode->i_blkbits;
+		last_blk = (off + len - 1) >> inode->i_blkbits;
+		bitmap_set(ifs->state, first_blk, last_blk - first_blk + 1);
+	}
 	return ifs_is_fully_uptodate(folio, ifs);
 }
 
@@ -127,13 +129,17 @@ static void ifs_set_range_dirty(struct folio *folio,
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
-	unsigned int first_blk = (off >> inode->i_blkbits);
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk, last_blk;
 	unsigned long flags;
 
+	if (!len)
+		return;
+
+	first_blk = off >> inode->i_blkbits;
+	last_blk = (off + len - 1) >> inode->i_blkbits;
 	spin_lock_irqsave(&ifs->state_lock, flags);
-	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
+	bitmap_set(ifs->state, first_blk + blks_per_folio,
+		   last_blk - first_blk + 1);
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 
-- 
2.53.0

