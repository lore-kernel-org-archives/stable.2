Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904208;
	b=aDnGPaks7jeGUv9mrYTBcHmhLd9I8JiGlKoYXhN10wHdviKctqG2In/yD1Clna87d4hV
	 5NR6if1g4ayrgUjB4khRSmSjLVO0Qn4aMWdOEPsMPCcjh+gL1JleD9pTaX5kFoAJV8bFh
	 a1bdk+Z/A+ni/nUOFyTRTwA0+Go7roWctyUmPp8eQ8fVWpMP5R1bGnidHm/PPYoszVef2
	 4Coo/MvxfRb0ew9n/TdQl2wHyeIgm++61mOZQh+0SMoN+Xy3m5+MqNdxNbIzf3pQWvvy4
	 VughNo7YWCi60JcwOJRAIU7l55v+humm85Sv9K74GnhpcQt6xjZ3Haapq9qzGAlRNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KTtZVJLvPYbjKxv6aqT8VlRff8I+Aa1z7epbxGcLsKQ=;
	b=iLqXULjn3NudO2m4lJE+P5+7lcO0yXP/2Q4WretOSXtisMAnJsV1NQOqFi7Y1p7+JdZA
	 zLWMFVIXlBkeWO/itB6AHw8JVi/GYAq5nRGEQ2YA8uUbDLvZ2cBwdKQNter/4ZEAtzcT6
	 gdtqa2noKQgmvMkTYWNB214A0Gq14S/2ATNJQXKAAr6dExjERUs2bieS9xyR2Nokg8lFY
	 7nml+ZM0bwU+hF0B/GaYBpA3bnrQqwbiXa0Q000dLhuZ2wjlr57Q7phhBPP0vk21PITXK
	 r54XC5hb/mOPWIeg4jHHfhb9jIT3Su6BX+fNoemkVcD1nr03U1kljtz1L7yaawpKZ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZc79HEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0678606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZc79HEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2CE1F000C1;
	Thu,  5 Nov 2026 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904207;
	bh=KTtZVJLvPYbjKxv6aqT8VlRff8I+Aa1z7epbxGcLsKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZc79HELA4l7JYeeWKDy+0SjRHf/uMGG4b2hdy1EZyR/pYT04IbwMDotMk2ws/yHM
	 YpmXqTHPsce2Ikd6vdokg19mAyqIl/UA+GIGR4fyrvbvb1fZ9U2KfxPsnsF7bIFi5c
	 EJWurVkNFHCGTdes87FF1o/tcs0HDz6uML3ybPREvxqN+MlHxB2R9z608pGC6Qb+nH
	 YZkjvB2Pp+m1gJgaOWHxXl71nFp6K1mVIpZ8Jz7304uFLvvD56nquXNbD8YuvXFCE5
	 IxSk1YRWPXHO1/OWX9g+rfyM90lWIbnHdPFTbCAHHQ3ANnkqQSeXTxAZ53lf1H+nTB
	 Qci5FinLP3AAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: rescan the AGs if incore delalloc counter is negative
Date: Thu,  5 Nov 2026 13:43:25 -0500
Message-ID: <20261105184235.2183764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110409-dental-lend-b1b3@gregkh>
References: <2026110409-dental-lend-b1b3@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 47b1e941bb55f735d82ba2649412260da78b98f8 ]

LOLLM complains that percpu_counter_sum can return a negative number but
we instead misinterpret that into a huge unsigned value and do bad
things to fdblocks.  It shouldn't do that, so let's add a retry loop and
an attempt to freeze the filesystem to (hopefully) zero out the incore
delalloc counter.  It probably won't work, but at least failing the
repair beats doing the wrong thing.

Cc: stable@vger.kernel.org # v5.2
Fixes: 75efa57d0bf5fc ("xfs: add online scrub for superblock counters")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: omitted the realtime extent counter changes in xchk_fscount_count_frextents() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index ec2064ed3c30f..de7151f55d0d6 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -157,7 +157,7 @@ xchk_fscount_aggregate_agcounts(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_perag	*pag;
-	uint64_t		delayed;
+	int64_t			delayed;
 	xfs_agnumber_t		agno;
 	int			tries = 8;
 	int			error = 0;
@@ -213,6 +213,11 @@ xchk_fscount_aggregate_agcounts(
 	 * of the computation.
 	 */
 	delayed = percpu_counter_sum(&mp->m_delalloc_blks);
+	if (delayed < 0) {
+		ASSERT(delayed >= 0);
+		xchk_set_incomplete(sc);
+		return -EFSCORRUPTED;
+	}
 	fsc->fdblocks -= delayed;
 
 	trace_xchk_fscounters_calc(mp, fsc->icount, fsc->ifree, fsc->fdblocks,
-- 
2.53.0

