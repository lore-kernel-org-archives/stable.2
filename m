Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273369;
	b=0n0Gabd0jbXWegTn9YyOhoOGCcfoeYZFTp9PHG7KY/AorJsvU8q1ML5VJn5FUv714Akt
	 yONZi9/Q4Wp/Yn35c0UMZ1MiQPFeH/KzV5v6u5ChD6/A7WsjkxCzsNxqj8PgwBhBm12Cm
	 CPtqC9QVbndT1u+R2UFSeHjpNVum7igkigUU2IBYKyLywfh0U22DaapFDKCmPD16FlNM4
	 j+/qDaWqZ5IW2+nKFv6ji1D3eQGPuXCuhThjXOQDXJV5Ey9L7tvJnrN5Hkv33KH9Fxg8p
	 bi4DmhNPu2gu0VT0KggXJk7jSjdkRZPjxb++RbP0lAaxze8m5hJnUd5NGZWa3RbxPwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9+nV0DByAoHJaum/+GKfbS8otCnqVqYoaV/2Pba+ODk=;
	b=xguSQBa8CoLpnd3G/vOUqvCGLrO1gw4sLQOzfwbIK8cYYcRnWPOecbqr3WulUghDiODj
	 CVYou+LbWNy7bG+0/+feS8zZOiEfHKjA8YRoMSg3KEIZ2/wguwj3GSZrxo8PqmaklXlS8
	 8/2oMtsaRgzzBKcUNj4b1wAw1pVr9S1NdCTdlpVZzAuuZNhtqdR462cTt28yyHbX9CoxF
	 Ccf7dMAhAaixHenmAwfuNx0uAfj7eA1xf+jBlERBuRDFukIgdJKOdBXnHQnkjzbfsKpyq
	 rjt2PjgWaGrUiXYUKFOBGX+c5v07jSjV38mPbFcKaIRRQsbp/r0yIt/EIGEZo9jU4TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex53Yq6w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA7606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex53Yq6w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027D1F0089F;
	Tue, 10 Nov 2026 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273369;
	bh=9+nV0DByAoHJaum/+GKfbS8otCnqVqYoaV/2Pba+ODk=;
	h=From:To:Cc:Subject:Date;
	b=Ex53Yq6wR99jx2+2Qqouk4ssFYmf9YaPUPxoHzsTxv+AlWtmybV1f176ZWOOlc43S
	 5AjG0XHXPwzXZG1A2C7m2LxKbCc1/4A5pP1iIZ8vjOncSim7WSgupNIueb5loEaz/6
	 qqJ7aFLbMj7q8afWJyo1RDn9FtCsgQ6M0XFD6BKDCdnJr0U3KeCq4sFUIcZGGB/INP
	 oEiYYEQmBcKc1LRTlEmXnmJjP+jndFSw0oDmW9pt3Ufh75F64hjRm1cYU2PSoAOY5L
	 lDICD4jSpWwdY9Cv4gAqridzqG7uuOoZHY/DoMZzL7zwoL3z8lcUDGpuS+DFj9c5uc
	 Ryu24Cl08U/kQ==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	dgc@kernel.org,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: don't skip free extents of the longest length in a whole-AG FITRIM" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:06 -0500
Message-ID: <20261109201606-failed-6.1-5745f4f10a1a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201606-failed-6.1-5745f4f10a1a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Mon, 26 Oct 2026 10:54:06 +0900
Subject: [PATCH] xfs: don't skip free extents of the longest length in a
 whole-AG FITRIM

Since commit a66d636385d6 ("xfs: fix fstrim offset calculations"), the
by-length walk of an AG in FITRIM starts with
xfs_alloc_lookup_ge(cur, 0, pagf_longest) and walks down. The lookup
lands on the longest free extent with the lowest block number. The
other free extents of that length sort after it and are never
discarded.

Start every by-length batch with xfs_alloc_lookup_le() at restart_bno.

Suggested-by: Dave Chinner <dgc@kernel.org>
Link: https://lore.kernel.org/r/ZgiJWxVcVwag0fIP@dread.disaster.area
Cc: stable@vger.kernel.org
Fixes: a66d636385d6 ("xfs: fix fstrim offset calculations")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_discard.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 8120f136af931..cdf660344c281 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -200,12 +200,12 @@ xfs_trim_gather_extents(
 		error = xfs_alloc_lookup_le(cur, tcur->start, 0, &i);
 		if (!error && !i)
 			error = xfs_alloc_lookup_ge(cur, tcur->start, 0, &i);
-	} else if (tcur->restart_bno == NULLAGBLOCK) {
-		/* first time through a by-len starts with max length */
-		cur = xfs_cntbt_init_cursor(mp, tp, agbp, pag);
-		error = xfs_alloc_lookup_ge(cur, 0, tcur->count, &i);
 	} else {
-		/* nth time through a by-len starts where we left off */
+		/*
+		 * A by-len walk starts at the last record of the longest
+		 * length (restart_bno is NULLAGBLOCK until the first batch
+		 * ends) and then where the previous batch stopped.
+		 */
 		cur = xfs_cntbt_init_cursor(mp, tp, agbp, pag);
 		error = xfs_alloc_lookup_le(cur, tcur->restart_bno,
 					    tcur->count, &i);
-- 
2.53.0




