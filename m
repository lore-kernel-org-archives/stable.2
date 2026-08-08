Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE43002A0
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187559; cv=none; b=kzS89OwITArh8zBqIissYSBjfxjVn1vWg/2336RH3s5u6ocGf3MO/HWdOF3Zit8a4IhZas5gTQzWAYHxvuHGaky2eR322dWYqkpDlJWTnYejY3ehMTGJP74dmSMY8rkpJZg64vm0aM9SMZuC4VA3QHh05IJXWbwuI1w6ZX5Y1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187559; c=relaxed/simple;
	bh=BtS3uKZBKHknX0/WPR9EXLV3HeiMU48x4zBtlr0HzqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlzGLpJA7nnhub2V0wImoTSuf37Or8OLTzMAxeMW/gso6fTTB8qsplLslicoOKIrjIvHDoqkNHHcQ1IO/I7Yjw0L00x39LNAvcq+vxXfeR9j/DpFa1BoYD3Bgix/UGm2NXFVhT6UNtOgmv66fIRBt6bJnTGWY0cGC4Ti3yS1Alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiR1mZCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiR1mZCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFB1F00A3A;
	Sat,  8 Aug 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187557;
	bh=3iYuR5jlxQ9V3U2uOB5AnSbpKQ+rorBbvh1598dwD78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IiR1mZCWQ6J9cOjhHfG48c3V5E/KBnER2qsa/al66jQXuRPeHsU7cZiUM1saIZyDA
	 zZXqVAyfCJu3fd79ZVIJCfCKZycSCaryPy4Lcfd2LZOYF2jgKOdKnHzIK8dO/pV868
	 BsOMlnsZ0j4QUG7IMFmAWzV3JkDXHBMsFUFLWILiqL6JniU5L+LfIdMN+rnIqjrgSz
	 HNeV9Ifw/4zY2pyBfwkSPOVKh4lyobNEuwnXJE2d6uECC9q38xh/1Ngk87l3Roeu+4
	 hKuOveiJ2KaNFJyrE9gth3ObAglxmbOleD15aTQ7AtRmueMkJPD3Axb/yohFTnVivX
	 P7Umdscv7N8Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iomap: hold state_lock over call to ifs_set_range_uptodate()
Date: Sat,  8 Aug 2026 07:12:32 -0400
Message-ID: <20260808111233.93672-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072923-divinely-glorifier-714d@gregkh>
References: <2026072923-divinely-glorifier-714d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 279d5fc3227f04ef2c6125e5c440e7952173a89a ]

Patch series "Add folio_end_read", v2.

The core of this patchset is the new folio_end_read() call which
filesystems can use when finishing a page cache read instead of separate
calls to mark the folio uptodate and unlock it.  As an illustration of its
use, I converted ext4, iomap & mpage; more can be converted.

I think that's useful by itself, but the interesting optimisation is that
we can implement that with a single XOR instruction that sets the uptodate
bit, clears the lock bit, tests the waiter bit and provides a write memory
barrier.  That removes one memory barrier and one atomic instruction from
each page read, which seems worth doing.  That's in patch 15.

The last two patches could be a separate series, but basically we can do
the same thing with the writeback flag that we do with the unlock flag;
clear it and test the waiters bit at the same time.

This patch (of 17):

This is really preparation for the next patch, but it lets us call
folio_mark_uptodate() in just one place instead of two.

Link: https://lkml.kernel.org/r/20231004165317.1061855-1-willy@infradead.org
Link: https://lkml.kernel.org/r/20231004165317.1061855-2-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9c7d8f7c8994 ("iomap: fix out-of-bounds bitmap_set() with zero-length range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bc7d176c4cf13..03e3a6417596d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -57,30 +57,32 @@ static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
 	return test_bit(block, ifs->state);
 }
 
-static void ifs_set_range_uptodate(struct folio *folio,
+static bool ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int first_blk = off >> inode->i_blkbits;
 	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
 	unsigned int nr_blks = last_blk - first_blk + 1;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
-	if (ifs_is_fully_uptodate(folio, ifs))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
+	return ifs_is_fully_uptodate(folio, ifs);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
+	unsigned long flags;
+	bool uptodate = true;
 
-	if (ifs)
-		ifs_set_range_uptodate(folio, ifs, off, len);
-	else
+	if (ifs) {
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	if (uptodate)
 		folio_mark_uptodate(folio);
 }
 
-- 
2.53.0

