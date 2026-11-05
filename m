Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890926;
	b=uNBTlFsNVWpHl+plMgk6t+0AgQ+vO9UuO+h9URDu0jUe7iSbj4jKpcN98nnt7q4QMkRe
	 JNuPQxBhgQ0VsKKGDBdM5eSECkugprAbGm5U3y0C/+waqrwgSHJ3Y46wGIMmX1BqP2UTz
	 +kpwyLvi/XRKxWGcxuFnAJPTG4xsS+sSjCDJ8QnEjxIv9YOiHRVDPI4rh6r9XR6UQ+0bX
	 Dr+yiG4k9hqjEPHp2tDqwME5MYEJa5vo9EwSShFvKfHj3nOCKt6nsQ1IRUyGaVd83XxcT
	 J6nIwnL7HS89iT8kq33D071IvrtT3QdvYejgpTzX6eub8KNwM5JK5PARu4M1HJwUBLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6kFjY9EhpADRATLaEQRH5aI1pY9SsSTjKpZGroszLvc=;
	b=h3W0XdTdJEoXtphDaTzJp3Sp1vbnCOUP6NAq2+R+S6ZI3E1smDyATspKO8MEWaAAXQvX
	 XS28ZDG+dKgGKfHC7RYVQHnpoMBbNXhnMwdUFbe7l/F4QkS5BgIC5Im1714O7jQFAKPDe
	 SeLdE1KhtcbMXu3qBcwFS4Fb532ekbt7fOTs3klgVebnrLT4BtWQvsnALhiKwP+V/3Tsi
	 GIb842fx5dI4V+TtZVvN6E7NTBvlJvec/59oJ0FyofZanXvIVp2sRH6VA7uKf6H4btT1H
	 ldIImchNyka6EhwxHdLum83coph+wwwFSuKXGzG6KbZJBRGRYSH3o36EYXukq14lj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX9XUrGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47282606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX9XUrGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4649C1F000C1;
	Thu,  5 Nov 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890925;
	bh=6kFjY9EhpADRATLaEQRH5aI1pY9SsSTjKpZGroszLvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IX9XUrGPND0j6dmS1ylzFeOaZ4fLOydoBO4Eg/I1pP5lVlXAkAbrFA+mht+OCExoD
	 jb8lUDsqI7HPa0dRU0gwBnWZmMVMHYsxNMFE74uzjipCTMO0gnCJBebr7W+GCQe7nP
	 HzHbO7DtfYql+fHz/VWOJKCEwnLu510ZHXZtbK9mnSJLF7P56ZfOLyKnXs+NoOgvbt
	 qt8LOa26zAPPQK9fJJ3QJR9OMvm/XomYkBgqbz4EC0/t+qUN/5HBw8s5cKrKnsnZsS
	 Jp+yhqvScqQ5rLDJrqTeSjOdfKYv+a41tkz7ANfvIwWTmQtKjzV74Ve+OdZH5Y9Xyf
	 BXKA+14MDuPbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: don't queue rmap update twice when reaping a fork
Date: Thu,  5 Nov 2026 10:02:03 -0500
Message-ID: <20261105150117.1846224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-depravity-unflawed-a6ca@gregkh>
References: <2026110457-depravity-unflawed-a6ca@gregkh>
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

[ Upstream commit 219ff8a734d8438e24eb346a847c9b1ad9b7ab5d ]

LOLLM noticed that xrep_reap_bmapi_iter calls xfs_bmap_unmap_extent and
xfs_rmap_unmap_extent to remove a mapping from a file fork and its
reverse mapping.  However, xfs_bmap_del_extent_real also queues a
deferred rmap removal log item, which means that we incorrectly queue
two rmap removal operations.  Fix that by removing the extra call and
updating the comment to mention this subtlety that I forgot, having
written the code. :P

Cc: stable@vger.kernel.org # v6.10
Fixes: 5befb047b9f4de ("xfs: add the ability to reap entire inode forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Adapted rs->ip and rs->whichfork references to direct ip and whichfork arguments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/reap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 4ce345ae4565e..0c827798ade67 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -905,12 +905,12 @@ xrep_reap_bmapi_iter(
 		/*
 		 * Schedule removal of the mapping from the fork.  We use
 		 * deferred log intents in this function to control the exact
-		 * sequence of metadata updates.
+		 * sequence of metadata updates.  The BUI queues a RUI to
+		 * remove the reverse mapping.
 		 */
 		xfs_bmap_unmap_extent(sc->tp, ip, whichfork, imap);
 		xfs_trans_mod_dquot_byino(sc->tp, ip, XFS_TRANS_DQ_BCOUNT,
 				-(int64_t)imap->br_blockcount);
-		xfs_rmap_unmap_extent(sc->tp, ip, whichfork, imap);
 		return 0;
 	}
 
-- 
2.53.0

