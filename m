Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81B24886E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309403; cv=none; b=PjtZAOCLkw4eeO17iVgtCwOGPJ4gQt1FsQQcN0iuZqYagy0vovemYLb0eotFpqtmhcbPdBxJkPAxgzu1F3Ros0kH+Pq3YkSHuPtlo/2i3dEbiFwO/3cXDDjjAMPzqoAJLffLpWqeUgFPsjQVkL37eXWLiZgby96vzfygRhdMEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309403; c=relaxed/simple;
	bh=vKHHLXRuU7XIozzHh5oPY8hhm4KT1TrWow4mN9qipqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSwituRghQ8B3h7b69EjCEm8cY41V4W17clajUY/C306wFv7yC3Wh9i/EpwJN1LOJrgy31nMgVmuUPZ4MtUW2x6+V4izdulyCNw/Sk4iTZtHKCvzB2Vyu/RW7HzApHup4aKA6yvSy6oz7cZ4EI2BX78lSudTaHRWpbhHqsh6xwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYIn+gyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYIn+gyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1901F0089B;
	Tue,  6 Oct 2026 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309402;
	bh=vgqQqMzUMlW6UUEfS0aOeJhqe4ngn51tbLnpBJU8Q+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYIn+gyhZD8rFuhA/NhAa7ZzaO6NjcBIWY2qHzjwA2Fa3ZNT1sXVdXNeeIYlbZH/l
	 qIvZ/BtQek3hV6o5Bu+hdiSipjnLKPjL8HKgQhWUdujtYTt4qbzZP0Qb9wS5HS6XRN
	 5UQ4jBFk8kHzGyLPvU0xvm7ehtFp65fQZgzLj3UUOjm52jyXhgs6JzBHi43C/9DlCu
	 DfO11/M6mBKOF/0Yrv+UUkQGuKA5LQLV6q9sG38ztj02tyvx3Ey2vV/qTf6xWNKrBC
	 1D3VZ3RCT4hwjI8XR8BiWoVpdRfjumdnwJRO+iQvyAAT9fYbDdQYw/Q43XqhzL8hxK
	 AbZWBkEty9KZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Tue,  6 Oct 2026 13:56:38 -0400
Message-ID: <20261006175531.919188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100504-reverend-stooge-1b02@gregkh>
References: <2026100504-reverend-stooge-1b02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e ]

Tearing down an RX BA session can leave the session timer queued on a
freed tid_rx. Later timer-wheel processing and the timer callback itself
then run against freed memory.

An RX BAR handler can dereference tid_rx under RCU before teardown
unpublishes it and stay in its read-side critical section while teardown
deletes the session timer. The stale handler can then rearm the timer
after timer_delete_sync() returns and before the RCU callback frees
tid_rx.

Use timer_shutdown_sync() so rearm attempts become ineffective once
teardown starts. Keep reorder_timer unchanged: teardown marks the session
removed under reorder_lock and its release path checks that state before
rearming. session_timer has no equivalent guard because
ieee80211_rx_h_ctrl() rearms it before taking reorder_lock.

Fixes: a87f736d942c ("mac80211: use RCU for RX aggregation")
Cc: stable@kernel.org # 5.15+
Assisted-by: LLM sparse kasan
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Adapted the replacement to the existing del_timer_sync() call instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index fe7eab4b681b0..05815bf30c220 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -103,7 +103,7 @@ void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	del_timer_sync(&tid_rx->session_timer);
+	timer_shutdown_sync(&tid_rx->session_timer);
 
 	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
 	spin_lock_bh(&tid_rx->reorder_lock);
-- 
2.53.0

