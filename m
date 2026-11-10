Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273098;
	b=b9TeDLgywyS0VccjviIZhBVLJEBeY026ZiNDXZWgsGvRI3iqn0nhFORsEJzk3R5/s7cB
	 CKDGKtPAu2OdODU97JyOUlmzanrCK3fHl0rZLCuHl3cZ9UPJaPUgxooRwZRgCVYfeOO0d
	 YHM8oEYTapSeFKYy4w+jrK4zQoahqjUTBvO6J8YdkGv/3pRDN1KtcAbCE8tw6G8v2lM8B
	 2KH7BWVSokicbvvlI4lhRNhu5DgJhmQFzvb4odF4u4WNHSQC395AZMf7ugEj0jFCDS+g8
	 D8/50iA8ZEoWjqYUSys5X8b5rF73lJEjSuEc5ls1dw796YUOwYXielT7ccUdo3R5H2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IB04N2L6YfDTurFuUusKfw3fhyQ6oMFmijVoMdLAR0M=;
	b=WNVl6cBUzxK3OUTxV9MtiVC9Qx9QQkSmvzgx0JjiQJwPrXSS4b4UzWT+1lP0bWQ8OLz/
	 LAA3AmxbI3JHbdfqJvUuJdYR4uOo7k2JtmCb05mMrKEdyM2sXm9f3s1wdJauathKgeGVH
	 P7EXPBYnGH2XvTVECfJkMBnt6v8Gw1Kl6BwvjGc8JG0s0LNny/neSsQTa0GnunVyupRCR
	 ES9tU15YfbTO1JcrwGP6YHfpGtnm4ELUldagOUl/+NhSBs1cELj2vBJx8qUU3O83gnwFX
	 Tu4uJOqnGAJok6VM+H34z9S05L5xOZv1geGUfN2feNNrj1Rip4QjZg13VA07IsG8uzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4OdaO1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5883606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4OdaO1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F8A1F0089F;
	Tue, 10 Nov 2026 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273097;
	bh=IB04N2L6YfDTurFuUusKfw3fhyQ6oMFmijVoMdLAR0M=;
	h=From:To:Cc:Subject:Date;
	b=h4OdaO1onjX0Iez7RUYLkK887ME92bBwzk3QnLh5K/64kdd884EBsODmEwUtYLswA
	 1Rd/fXrPO510ogpWa1J/CJe8ANxPNHlpbh1LMBAsKoOA7Uv0ohAwNgU+A4AnPBhpOn
	 QlO1S4KkgTxmKzWPIrICXygC9fOS2+dqNPFBN3cClWk3F3f07Ff+7hC8hacqRyXO/9
	 ngkMLhV2yi6YXUxjIwPn50PkIJMoSJBmPmgGyjBHihC190UAj2pfoXWWyW6IXPJ4Ra
	 /BCndz/NbA7v7yWI47nuH9hNjAXlJ4dvQRLnqgyjFzUwQPy6POxdTLRH8DrlujQSit
	 C3Avt/7DkkJdA==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	dgc@kernel.org,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: don't skip free extents of the longest length in a whole-AG FITRIM" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:35 -0500
Message-ID: <20261109201135-failed-6.6-5745f4f10a1a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201135-failed-6.6-5745f4f10a1a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




