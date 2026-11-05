Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889290;
	b=xdyQbNkj+goKze1Qvo46wbP0Zkw4TOx0qqIhEBkfmxZ7kRjCjre9oDm/Tf1KYMRYfent
	 DMqN9LE2d29iGkWfp/WskdcU2pHmcj+4LG9wNz5rD08eVRDj4WXOP4YkY50aERCN9Rw8U
	 E6BIZrhwX6RNRTkdWOytRJdJ/9Jloz8fqlE4+4symg+EZtH6vgqOM3Iv1UH3Xu4lxkW/+
	 vzLdP33/eWXH4Fe3asna6emNMQSwnpKUxUZiNCZkocy7VTZEWtPhitZ3UtkN7RbAgXiVx
	 o+eOkKcjG3TxRI0keUoHdW9WGkEEkcbwf7ImAqC5NfLw9s5zdEi6Rlj7XaKRhCz65PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=62EbqcPazohWksXCUZowHNS5I5/7C31pdH5kDZmM+88=;
	b=piJJwzKF+iSFyNR3/7MMiCG1kQu/VsFoWu50Pg/9XOW8xyPgB9yU2e4EMEHCkNhzEHZ9
	 qCkBj5rcLixCIxQkWoyDDTPMUG8NPJLzceh2mzi96CpqVRYLi1hj18sQ5efTwvWI+6A3/
	 s292Ce3dLVcI/3j19kaaMH5v53JLfZA3b0WBDOcnztwD41OuIkqEsxeSUcl22ogpi/Tl+
	 N4X27QPhFLF4Vh6i7HzdhbmKuFqNV9Ar61lXqaBPMsHvcDwytzafEpYLCNfry0n2hy5Jr
	 /j97gWG7PH6YYSm697tq1KNMFbA5I53ejsiOvOSs6suCeFcW6+HzS1GhmzXOQbNd0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmxmEOiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26917606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmxmEOiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B861F0093A;
	Thu,  5 Nov 2026 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889289;
	bh=62EbqcPazohWksXCUZowHNS5I5/7C31pdH5kDZmM+88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmxmEOiuE9i0lgrIKaHI6bQOLqGfI05DxDrJnkrCZJFzpTcdTUuuLJ+i8YOYKjjZ9
	 SUJCfto91WM+zYRE/68fsRNZuCmOjqthzGXiz16hpE0KEdZe/CB86M/QNOvJFOM/ni
	 9/xhXb40APfGmtBctfnQ83FYk9lU+C4qEXAK4KM+dPMnjfGVxoXFkTZ2JOSirxRMF8
	 7I3bfeUg0vYCsoSPNtlBoWmtUBYIm+ffKJhHEEwGsBjaIKLE6k9ZZt3W8tN/OW3ll/
	 e63s6J5fhhqnoGA9A7RjeR+KvRbC3o/5DRXOknRc6oscDIKlCDLsKTO9dsX+wNbPkW
	 ImZLIgJi5CBiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: allow softlimit with no hardlimit in quota scrub
Date: Thu,  5 Nov 2026 09:34:47 -0500
Message-ID: <20261105143436.1657649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-flammable-slimy-0f35@gregkh>
References: <2026110443-flammable-slimy-0f35@gregkh>
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

[ Upstream commit 342c2e00b3a99099a7088f7b8c8f075670c603a9 ]

LOLLM observes that the sysadmin can set a user's soft limit to a
nonzero value and the hard limit to zero, so those aren't corruptions.

Cc: stable@vger.kernel.org # v4.15
Fixes: c2fc338c87a31f ("xfs: scrub quota information")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: omitted the quota repair changes in xrep_quota_item() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/quota.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/quota.c b/fs/xfs/scrub/quota.c
index d6c1b00a4fc8c..201672fe29b5c 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -102,21 +102,21 @@ xchk_quota_item(
 	 * suspect, which is why we flag it for review.
 	 *
 	 * Complain about corruption if the soft limit is greater than
-	 * the hard limit.
+	 * the hard limit and there's a hard limit set.
 	 */
 	if (dq->q_blk.hardlimit > mp->m_sb.sb_dblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_blk.softlimit > dq->q_blk.hardlimit)
+	if (dq->q_blk.hardlimit && dq->q_blk.softlimit > dq->q_blk.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_ino.hardlimit > M_IGEO(mp)->maxicount)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_ino.softlimit > dq->q_ino.hardlimit)
+	if (dq->q_ino.hardlimit && dq->q_ino.softlimit > dq->q_ino.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_rtb.hardlimit > mp->m_sb.sb_rblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
+	if (dq->q_rtb.hardlimit && dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	/* Check the resource counts. */
-- 
2.53.0

