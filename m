Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898823;
	b=dvWgHHdGRTSanxHhhergCSMvSNMmhB2Xp+7q6nX8UqqswYz3ISkLcBhYrbyWjC4326P9
	 NgGNZXEoNEosXbQEAtYQ2BFPqWsiuUSgNjdA9uUmv8mUta/Q+fAIvJIUgVimDdteaVSOL
	 CIleIOqbM/FQAy4SIL4NnW2OLqQJAR+24ecXwn5sW0sT9suYtZcMbsQIVyuZh9E90QjRw
	 iVwPCNMT4clVtQH0h9JBem0N0HZvAcsSO8xpAyVHqd9JkCjVJn2Q7OIepm2HV4UvuNa9W
	 SUjylGbm6VoxThvT7hB8r9E1F2dY2B5uTN93+JrDmHENg1IGx49a0WLLXsGlzX17soQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uSd8lb68lTkjumS5CZ+WBV+dKSkHOHHX8kv6vBxrzBM=;
	b=mjFEVvFvycO3KjTiMCrqNLx9fjBTot+kWMGjUyfOMAbSSFGeJRxcaqMvmrgtiZUwwi5i
	 LCN5Kvr60BkTZ3vigD8KRUXdVA0aJbOTiVaBySq8sM5czwePZIt657m1baLGzn/UkSzKQ
	 krvq1uJQlTwVnxtkekkIhGpWktAAoR0Sindlsua25iqGIrfRxiUb8SFagIBnAkrRSqrE8
	 OqxyyJKb8zjQlGv1hekv2Ya3JGydPXZF4tUuk/woWaDwWSi8YDVH3MAgLtbKZyGKhd0gq
	 si8ky5k7xyGKJlYdOkPqcId5Gu9qGQKtqKXQIjh5bpB0AFtVbQCzLvg7GvGo5PExjJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHu0rxgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E050606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHu0rxgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EDD1F00919;
	Thu,  5 Nov 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898823;
	bh=uSd8lb68lTkjumS5CZ+WBV+dKSkHOHHX8kv6vBxrzBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHu0rxgv+ODpHKyw5NWOABwtB2n+JI0SkZJ6ZE/S5kCojfAWbKZfklv3hEZR0iMFZ
	 Uo9GNbDzsLKOudWIWQl7amM6c7jl6Cgx2hK+NYSJafhpzRNCusFfIMGZidk4XiJUwR
	 dGWk3SbuDz5zCL1MpPB5BbC0lginbmmVWTDhsadVtjo5GEptzqHJ2KIxXjcGId4kpn
	 t8Zf/AqlrIxcDzh31ifmKJG6cei71S4gbwS+AD2p16IvE+Kxf8nNQjmQGMXQy0GkoQ
	 ZS+BUR8BPYZcmxZDDmIBrodX6vDeqZH7cm8hknvYi/SQD3Q1M/qqlo9QzWS/P0G1m6
	 eClCGC45mb/vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: rescan the AGs if incore delalloc counter is negative
Date: Thu,  5 Nov 2026 12:13:41 -0500
Message-ID: <20261105171317.2074528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110409-willow-coastline-1f7d@gregkh>
References: <2026110409-willow-coastline-1f7d@gregkh>
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
[ sashal: omitted the realtime extent counter validation changes in xchk_fscount_count_frextents() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 037541339d80a..f17912a9cda8d 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -173,7 +173,7 @@ xchk_fscount_aggregate_agcounts(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_perag	*pag;
-	uint64_t		delayed;
+	int64_t			delayed;
 	xfs_agnumber_t		agno;
 	int			tries = 8;
 	int			error = 0;
@@ -233,6 +233,11 @@ xchk_fscount_aggregate_agcounts(
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

