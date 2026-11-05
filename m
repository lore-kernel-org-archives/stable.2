Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892980;
	b=haLUhTL0GFE/TMTWJ465Yx5qmpm6E1zX+Pwrkh75RtIQH4+sADyqM6F/2ddKpnPrz6PZ
	 t0q2bo1R28C8391n3S+jS3CnAkAFHIucmfN4cfUoVO2k55BsHb6b3FZ9s2S4b8l/Nygs2
	 mpozgTUeMr4V6S3ofRYruc1fiotmvqoGuO3v6nptYzCRsHOyGDgpMoc01Cva+jzA4hQ7R
	 26omwkH6yMxn34/LLBdTwAPGxIN8uAKyelQeZCMqYBxBvq3Gu7qNHfvfaoYJlAWqjlY2t
	 nEm1Yu5BouMVP+BWinIKUW+fHoYIS5kRnmC3Z+NtlaSGrCXIY4DOnV0KwDhQBREKV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XqWuqFxJJuaTDphEQWdyKM9oQxorSvnR4M7KJNBN9uI=;
	b=kj3cngstHTRox+9ugFz1OV/QL91mWMyJn2e/xN5rM7CceLooHPtwYAufRTpupg/rbrV7
	 aNEjeLt8kvoE/+G9+ieXyt+MKha6N5T1607EP4O8RdWLIjHK0MQbwOosDvruEUGNyh2p2
	 qS84d6X0132A0/Hf6/3SjxWEtqBpm0f0ZvNJTXi6/RKRF5L8v9CIseesOGKF5cfMTnzoo
	 Vj8kHInFq/QypPkIvzYxsanwUz6IIoJ7l79A04j2XGFzYvSIn8Mm763Np//AGME7ZJor+
	 f/ZQCu7NpMQTZc1ke3oLwn9D4AHl2e+Az40MZNbvU+FOW9gV/OYh5QtYvEuEdDj8AoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAxRL0Yc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2073606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAxRL0Yc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C991F000C1;
	Thu,  5 Nov 2026 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892979;
	bh=XqWuqFxJJuaTDphEQWdyKM9oQxorSvnR4M7KJNBN9uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FAxRL0Yc8tQdTOds+AG9lT/BYYukhqQ9dfduHFJP2RGQePndeEtqmkb/JBYM85UR4
	 KBhj5Ns0jkkEPWpYkGHNKXTkvbvEbYdE136YbWv1FvGhTmVqrF2BkWYhcX0awAI7Uf
	 0aMZ3k8qsC6b47P18zhmz0L7bQ2nC7yWASPZbKzBYK0HazIzOsIotKwuAG/1EQ/EYl
	 W6h5mlgRmMLsDQ3CGmzIJB5GYN04Q43KKUX2Idq85zjR2sGGDkSNiJXQ6c+C3mpdg2
	 nLQagJ4T4q4Ap6DRPZn6aTrf/BmLsptfHH06h4v1lziiF6bCYGaubLa3GxaCzfHt2E
	 KZa/MS1c0stPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: rescan the AGs if incore delalloc counter is negative
Date: Thu,  5 Nov 2026 10:36:17 -0500
Message-ID: <20261105153540.1979792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-android-scrambler-4ece@gregkh>
References: <2026110408-android-scrambler-4ece@gregkh>
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
[ sashal: omitted the changes to xchk_fscount_count_frextents() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 88d6961e38866..1f4170bab6908 100644
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

