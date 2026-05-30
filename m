Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E29340DB0
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157366; cv=none; b=jvQkmbEJvHo1LjEYTo2W5uFaRZ8arszaVgD49IcBRakgMPa9PU+MApy6haGNQg3n43ZSZGiK7I+mOzwPFKbPXJ5ihmoudHLp/CmkX9p/mTNU8AZktC/BHZOXjmrTKO3NeXwaXRE0FTycfmkehTiPQdKqfU9rjmtWPmqlqDLYUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157366; c=relaxed/simple;
	bh=PoqE3bhu3LiEC11Y7pOQv6Ks7VyFJbuGAtFpJybx1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrosyKH2Jiol5IW7RPGIPNdm9YfXrhdNnbZNpqNRz8X7AvyB9oK1NUtrhCQL44lMP57LU7hXNVp+6CqgWLFucPcTS7r1tfEysVl2zegYomF63KcXxfYS6p8iFQvdo4U1eg7SCI6Ojc8a3Q5HNmfmmzvCjsVtBWin8c92VktIh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIdA3KcN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIdA3KcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BFA1F0089A;
	Sat, 30 May 2026 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157365;
	bh=pEkutluwdjOfAuk13ClX+HqkavHrs7fgwc0WCdNIpWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIdA3KcNvvgYtCYzGoZI930QvpZYgqturTSQ6vBIf7rVuxhJMbh50gKnhi37B8kRh
	 yZ7cjhQ/+Y6Ip4rLC/8TLQPraDnyDrx3DS7EOt705QWF7+Ru6o6xFmnSWTsbxyjIGF
	 n5wGp3DAnjAthR+pI34KmjV5ERyEhC7dXFIc8JsFTEzwNgH/t1rvFmeejlXEVDPafu
	 1U87YvSth+u9qPZ63AJD4xvshSCca5f05hT/Cz0X/1yV+WwNnyCCKrTvB8RbYVUgHE
	 BI+RcopTMc0h3ias+Lib75lOsrCvLaUOHfs6C+NI7Y7Dbza5xGHBiwaUjF5B58tLGV
	 /wfVBmSoradUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
Date: Sat, 30 May 2026 12:09:22 -0400
Message-ID: <20260530160922.2835319-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160922.2835319-1-sashal@kernel.org>
References: <2026052802-epidermis-spotter-7887@gregkh>
 <20260530160922.2835319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit be309f8eae8b474a4a617eaae01324da996fc719 ]

unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
holding any lock that prevents SKBs on that queue from being dequeued and
freed.
This has been the case since commit 79f632c71bea ("unix/stream: fix
peeking with an offset larger than data in queue").
The first consequence of this is that the pointer comparison
`tail != last` can be false even if `last` semantically refers to an
already-freed SKB while `tail` is a new SKB allocated at the same address;
which can cause unix_stream_data_wait() to wrongly keep blocking after new
data has arrived, but only in a weird scenario where a peeking recv() and
a normal recv() on the same socket are racing, which is probably not a
real problem.

But since commit 2b514574f7e8 ("net: af_unix: implement splice for stream
af_unix sockets"), `tail` is actually dereferenced, which can cause UAF in
the following race scenario (where test_setup() runs single-threaded,
and afterwards, test_thread1() and test_thread2() run concurrently in
two threads:
```
static int socks[2];
void test_setup(void) {
  socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
  send(socks[1], "A", 1, 0);
  int peekoff = 1;
  setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekoff));
}
void test_thread1(void) {
  char dummy;
  recv(socks[0], &dummy, 1, MSG_PEEK);
}
void test_thread2(void) {
  char dummy;
  recv(socks[0], &dummy, 1, 0);
  shutdown(socks[1], SHUT_WR);
}
```

when racing like this:
```
thread1                       thread2
unix_stream_read_generic
  mutex_lock(&u->iolock)
  skb_peek(&sk->sk_receive_queue)
  skb_peek_next(skb, &sk->sk_receive_queue)
  mutex_unlock(&u->iolock)
                              unix_stream_read_generic
                                unix_state_lock(sk)
                                skb_peek(&sk->sk_receive_queue)
                                unix_state_unlock(sk)
  unix_stream_data_wait
    unix_state_lock(sk)
    tail = skb_peek_tail(&sk->sk_receive_queue)
                                spin_lock(&sk->sk_receive_queue.lock)
                                __skb_unlink(skb, &sk->sk_receive_queue)
                                spin_unlock(&sk->sk_receive_queue.lock)
                                consume_skb(skb) [frees the SKB]
    `tail != last`: false
    `tail`: true
    `tail->len != last_len` ***UAF***
```

Fix the UAF by removing the read of tail->len; checking tail->len would
only make sense if SKBs in the receive queue of a UNIX socket could grow,
which can no longer happen.

Kuniyuki explained:

> When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> support") added sendpage() support, data could be appended to the last
> skb in the receiver's queue.
>
> That's why we needed to check if the length of the last skb was changed
> while waiting for new data in unix_stream_data_wait().
>
> However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> to a new skb.

That means this fix is not suitable for kernels before 6.5.

Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix sockets")
Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e434d38ec4d7c..b4321ae381fd4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2526,8 +2526,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
  *	Sleep until more data has arrived. But check for races..
  */
 static long unix_stream_data_wait(struct sock *sk, long timeo,
-				  struct sk_buff *last, unsigned int last_len,
-				  bool freezable)
+				  struct sk_buff *last, bool freezable)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
@@ -2540,7 +2539,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail != last ||
-		    (tail && tail->len != last_len) ||
 		    sk->sk_err ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
 		    signal_pending(current) ||
@@ -2720,7 +2718,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	int flags = state->flags;
 	bool check_creds = false;
 	struct scm_cookie scm;
-	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
 	int err = 0;
@@ -2767,7 +2764,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			goto unlock;
 		}
 		last = skb = skb_peek(&sk->sk_receive_queue);
-		last_len = last ? last->len : 0;
 
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2801,8 +2797,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			mutex_unlock(&u->iolock);
 
-			timeo = unix_stream_data_wait(sk, timeo, last,
-						      last_len, freezable);
+			timeo = unix_stream_data_wait(sk, timeo, last, freezable);
 
 			if (signal_pending(current)) {
 				err = sock_intr_errno(timeo);
@@ -2823,7 +2818,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		while (skip >= unix_skb_len(skb)) {
 			skip -= unix_skb_len(skb);
 			last = skb;
-			last_len = skb->len;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (!skb)
 				goto again;
@@ -2909,7 +2903,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			skip = 0;
 			last = skb;
-			last_len = skb->len;
 			unix_state_lock(sk);
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (skb)
-- 
2.53.0

