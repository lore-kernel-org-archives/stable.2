Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542493;
	b=WQfwvLd81yVfJNEpejQguyFd++F7QKfaVT6OCLQgk0Dr2bkXQDGW9psBPEw0HpClKimV
	 Us1/TOrPloTiG7yCRl/YAdH/hSxQDynpWYTPWC+yvy1OE91urKYeoea5Gf7rRZr2fiquR
	 b8rUZzojNcxWi/febpSuGlL7G9gmLbT+Nk2VK520iuXZUR66bra8j/xaVPBvtBUqjwzN1
	 SIpUa/qA19vBqMkZMzXMvmXf8sbYbjl4vD5AL71Az1fsox1/UPgdlJnPW7b3K1kUrfA2n
	 quoHE702zpE6gBoE6L24AgJjiHn9Y+Jl/qsdQ1249Ehf88jcpocTgh1eJBQS82EmhCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=alZdrRPNtEhiG3jf3Gi1283VADCUxUc8EAWwUbYNi9U=;
	b=ZMQlePech1g8Raic/06+txrgJX9IYD1VUS12kS1tX8ws0XToxA6X9bNgbAFoFUH6AAAx
	 ckBspQ2ajUKsb6TIo9ms/N2+HzaIJzd1HxcJumr2/HFG8JtRaR+kitjNtyZqGh2v/or64
	 o3VXxg2pEpJ0UikHmWjuv2+oeHDJhDvEqjG7ZtzcUHIQmRu8R4nmerUgd1tuckebeXkHL
	 FKk/OZHy3geuYb9ovISsbkucJVkiKr5FgsPiI56WWzmLlzBJ3wHyU5xuA5uNIGhHFDgql
	 LuJwE3nRvWJLRHfZIcZBHTP49GLImmRzdG0qZBjFCksxgT1CoHSyfPDCAlXGTjvmKGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnEarmVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD0606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnEarmVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF01F000C0;
	Tue, 24 Nov 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542493;
	bh=alZdrRPNtEhiG3jf3Gi1283VADCUxUc8EAWwUbYNi9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnEarmVskIDgkcrexBqme30EHHSq+u3itnbrczoU+vuIDVFh5zqZ4RvaHOLzn4gZU
	 aKkqjH5FceWO019IGRvIwcpX8yN4GsgfuA/WvTl1EpfrwQ5dgEcERrrwR79Ro+PHRF
	 vUDGxf5yK/pLG+aKaGVfZIzeeLhJVIkkdWnSipi0Kg7cEoML//1JzS8g2lE0JHY9gx
	 CO1bPgGsUgwry6sbh3OnvZVRxL1+yMpkHB+z15g3UKcPSb1wYXGkCip8ggBnCgWqZx
	 twEvrt11JwlPMUefqs7O4Qo9PFQDPhdvbQVjMFcRcdH+54RqFtt9yL7r+bhbgGQn7M
	 7PvxhTg3siKCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Xiaojia <huangxiaojia2@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] epoll: Remove ep_scan_ready_list() in comments
Date: Tue, 24 Nov 2026 12:48:08 -0500
Message-ID: <20261124174758.2019784-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124174758.2019784-1-sashal@kernel.org>
References: <2026112424-culpable-woof-b14f@gregkh>
 <20261124174758.2019784-1-sashal@kernel.org>
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

From: Huang Xiaojia <huangxiaojia2@huawei.com>

[ Upstream commit e6f7958042a7b1dc9a4dfc19fca74217bc0c4865 ]

Since commit 443f1a042233 ("lift the calls of ep_send_events_proc()
into the callers"), ep_scan_ready_list() has been removed.
But there are still several in comments. All of them should
be replaced with other caller functions.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
Link: https://lore.kernel.org/r/20240206014353.4191262-1-huangxiaojia2@huawei.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 9f4413e522fa ("eventpoll: wake the next waiter when a woken waiter is killed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9e47e1dd66c50..03b4fe6cae6f8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -206,7 +206,7 @@ struct eventpoll {
 	 */
 	struct epitem *ovflist;
 
-	/* wakeup_source used when ep_scan_ready_list is running */
+	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */
 	struct wakeup_source *ws;
 
 	/* The user that created the eventpoll descriptor */
@@ -1211,7 +1211,7 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * This callback takes a read lock in order not to contend with concurrent
  * events from another file descriptor, thus all modifications to ->rdllist
  * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_scan_ready_list(), which stops all list modifications and guarantees
+ * ep_start/done_scan(), which stops all list modifications and guarantees
  * that lists state is seen correctly.
  *
  * Another thing worth to mention is that ep_poll_callback() can be called
@@ -1821,7 +1821,7 @@ static int ep_send_events(struct eventpoll *ep,
 			 * availability. At this point, no one can insert
 			 * into ep->rdllist besides us. The epoll_ctl()
 			 * callers are locked out by
-			 * ep_scan_ready_list() holding "mtx" and the
+			 * ep_send_events() holding "mtx" and the
 			 * poll callback will queue them in ep->ovflist.
 			 */
 			list_add_tail(&epi->rdllink, &ep->rdllist);
@@ -1974,7 +1974,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		/*
-		 * Do the final check under the lock. ep_scan_ready_list()
+		 * Do the final check under the lock. ep_start/done_scan()
 		 * plays with two lists (->rdllist and ->ovflist) and there
 		 * is always a race when both lists are empty for short
 		 * period of time although events are pending, so lock is
-- 
2.53.0

