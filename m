Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677945;
	b=dzjkpZylnApc0y0V+CFl6RYlXbyKuVh8ACWI8+xRKOVRVpsZD4HphkGftLLYzF/PyH2V
	 EfVXE65wxOqG9XtJbbBP9doIRj8FbcJqsR4ebuOPgZMjY6wchMdIkMvn8toCIad2Xu8x+
	 OFJePYDJGdvM2QvXeyKrglf5/L2jQ3sknxUy0OYRT7stIG1Ys0M/aXLHOfGMbcVIPqOqO
	 O/h7SBxITv+Lpdzjkw8kiANpFuv+CXoRlYTcKASD1gZLDV5s3Jqw4BQxcGc5EXdE67m8P
	 hzmLf8MphThVCq+k87M/HIFtNZ5/LiMkodo8wZX3al0WvRKd4kt6tCJXga97sW+t6fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677945;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a5D5hMs4CadcbFRHDeYx0Gtn1SAcU/iXoF87KytFFvk=;
	b=Bd07Ra4FEf66kbTU5tIvAhSvyujhpC5X8GNQQmQQX/I9E7b1uwG5Ky6KqWivfUBqKToA
	 lfyXlVf8QdeYLAPh/EnKPe7GXzhoLRfo4KvzKiRfwuKjhq/oDaVK1yzSkl5yIxdEisC9Y
	 J+sSCSna4yNlKqBhCpUI2S1qwmRwmSsGcDO+AmV5J8zxLSWk6H74ihGuxHTcEidCEs00S
	 5Wojs4pAHQHq+9nRRWpwSjzKsfzl+bjG6PLVEUaD53OmUUJRoHDJ9w/FirJmixYsPYUbR
	 rr+lE0Au58LKW7wPG1wF6xho521KFLvQDxThtQh+7zKlWUhRWCrJgHBPyDvOa0/CMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f98SPToi;
	arc=none smtp.remote-ip=203.205.221.221
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D65606A31D;
	Thu, 22 Oct 2026 14:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f98SPToi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792677939; bh=a5D5hMs4CadcbFRHDeYx0Gtn1SAcU/iXoF87KytFFvk=;
	h=From:To:Cc:Subject:Date;
	b=f98SPToiuLh2NWQ8JAUHUpcKhwCTKzIZ+qmyUqnVorNqDiGexHEhp+ZBazDDGvdxS
	 RK5yhb60QplTEzbgC/RrfaWYCCQMzmHSAvo0B6LBhRXz/9sNushjKouUqGzkWxAWgC
	 bycbCywY3QRIWyNcNwZvuIeqQbFj6H5b8xFGG6Jw=
Received: from kernel-lab.tail5e91bb.ts.net ([2408:8352:460:ee50:a639:b3ff:fe5f:1b0f])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 165BE656; Thu, 22 Oct 2026 22:05:37 +0800
X-QQ-mid: xmsmtpt1792677937t2jg0qgk8
Message-ID: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com>
X-QQ-XMAILINFO: MGiPAdtq5twnAdiQdq/iW5VIflC6PxBOMxyoW8ydpzKhN4/FZKDysUhpIqiMSn
	 HNnI3/XO7mzkzlwLE5KnderNdrB9YL+nef3wq40N7mvBcwsdsheLJ7E+UCCZv9u7QJqbplVQVN8T
	 Pt1oTSATtLQnlKOORVDqgn9XVLYCqaR5GxJDp0e1zlqH9j3z9ZqXK7ZxeZlwSHBe/1UcxPP1WXvQ
	 4kYh0t0ZntRx6XsOy+Iv6KTixx7bzZX1+AcwkX4MW3alrqzVVUZW9XsPgwswG9b9qkMUDtFd5csd
	 En3qtXlQYTcwpk8rCGB6Uqdq1J6DI+cdZIJkfb/oH6V8VWjwsYdMT5f+5h8ZIk3ueDEBsEQsciEg
	 voLJNxNklpFesWlsUYCWaxjER36gMLoZZ8iSU/engHGY3bg1xdMRQYFDOYfADVKcL0TuiI3KXfLK
	 9hWgXzKI3fpdLBHU3+glka4vMu0x70waEu4aNkFxIDt+zL9wBlEd0yCAXjcRvx7T8x8yF/jSoDAl
	 RAdK0OeE3K5cNRRrq7TWDTw+0RwHkmFEwMImrxC3zMPdmIpWz92Uic0OSA8iVzkPdA6CpqFBkQrS
	 vDYq8g5KeLTW8eRtRRntbCV+bG7ffDGqyhfIWx6Rn9rU9Fogm0bChfabk/Ik4Q5HQwWPFIY/2nuR
	 ngy4jYyDmwCbD3vU6f8qSjMbo6Z3wkruGtHEJqOJ6/0iUWtvlk7ePluqZlB499ccfTklO8e59452
	 WX2RNEDiO3BwKTwzJlLDzgC4GgyDx5dCwZaJJRyei0e7fslY4m+GwFHg2JtwP2hAeDbn93voHkYL
	 SnJQnQYhTPXBpMZzdGmEyW1Gcq8UWGWH442ykeGOW0lE6LsbhJlP/VI7TB/IRmf+gsJserA4fBxW
	 EScsqgACK04bjU9DM6Vutu20Fp7CG18HTxaLDcSaeQK6a4pW5lNmcnPyl2NJLEP/6kj8GC2ysKDU
	 Fpiy3aVz6GMlLngSI/rSaptTKeySvTB4BEKVWicWtK5x/Kx3bS7S8ip3hP1HBKZABIoxfRI1uQkl
	 kfmLH/ux3Ss3ja8pFFX0lapuNTtf8BiSt2LCJ63DSYb0zrFdTWuBVzQpMgXWhc7G5HGQxsLKFRsE
	 UtaQ43
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yingjie Wang <1075151112@qq.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] af_unix: order MSG_PEEK references against garbage collection
Date: Thu, 22 Oct 2026 22:05:36 +0800
X-OQ-MSGID: <20261022140536.715328-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

Commit e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
made unix_peek_fpl() invalidate unix_peek_seq when gc_in_progress is
set.

scm_fp_dup() increments the received files' reference counts before
unix_peek_fpl() checks that flag, while unix_gc() sets the flag before
reading the same reference counts. The reference-count operations and
flag accesses are relaxed. spin_lock() provides acquire ordering, but
does not order the earlier flag store against the later file_count()
loads.

On weakly ordered machines, GC can therefore miss the reference acquired
by MSG_PEEK while MSG_PEEK misses gc_in_progress. unix_peek_seq then
remains unchanged, allowing GC to classify an SCC as dead and purge a
live receive queue.

Add smp_mb__after_atomic() after scm_fp_dup()'s reference increments and
smp_mb__after_spinlock() before GC samples the reference counts. This
ensures that either GC observes the new reference or MSG_PEEK observes
the active GC and invalidates the seqcount.

LKMM admits the stale/stale outcome without these barriers and forbids it
with them. An explicit AArch64 model gives the same result. The original
workqueue layout in that commit also lacked the PEEK-side ordering, so the
incomplete handshake dates to e5b31d988a41.

Fixes: e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 net/unix/garbage.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index da774f56ca648..c3ed00f52b04e 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -329,6 +329,14 @@ void unix_peek_fpl(struct scm_fp_list *fpl)
 	if (!fpl || !fpl->count_unix)
 		return;
 
+	/*
+	 * Pair with smp_mb__after_spinlock() in unix_gc(). get_file() in
+	 * scm_fp_dup() increments an atomic reference count, so this ensures
+	 * that either GC sees the new references or this thread sees
+	 * gc_in_progress and invalidates unix_peek_seq.
+	 */
+	smp_mb__after_atomic();
+
 	if (!READ_ONCE(gc_in_progress))
 		return;
 
@@ -614,6 +622,12 @@ static void unix_gc(struct work_struct *work)
 	WRITE_ONCE(gc_in_progress, true);
 
 	spin_lock(&unix_gc_lock);
+	/*
+	 * Pair with smp_mb__after_atomic() in unix_peek_fpl() to ensure that
+	 * either the file-count reads below see MSG_PEEK's increments or
+	 * MSG_PEEK sees gc_in_progress.
+	 */
+	smp_mb__after_spinlock();
 
 	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
 		spin_unlock(&unix_gc_lock);

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.43.0

