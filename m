Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF944442FBB;
	Tue, 21 Jul 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672115; cv=none; b=TBI18vAG2Uz1FsKlKuWPTvJBhuDrBo4X2+DwsB5x8BmFzkZ79YIWsC6P7NZTcndV1uIL8fhzEZ2I0bJrAFttiQ01POzOOK407w1EVWFmSPiJ9oad5rEG54ns/ncckEwyFK8tcypBHS3X24ZPJR1xNld+fq7W96Nj2Ns+eOToWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672115; c=relaxed/simple;
	bh=Hh/p/HQrYpss/cNZlPsOY5elFfI/RGjcLL6kRaGP9Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BH2sn8ru4YZu7pc6sUZdFAzUwFmpdlCHBe57gXw66CrWQOLvUHaVjeeedlZs1v95N5bYcRdrnQhn26dxtnUpQg/ZMcW9E4EkSCQhQY50ShiWvkmt4KrbYWXtAri41m71eG2K5MXFh/TaOkzDvpiGVPwqCqr2mo1kquEAAqI6CNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvSdE/Q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvSdE/Q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A27C1F00ACF;
	Tue, 21 Jul 2026 22:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672113;
	bh=ae4TnEnjRXKPyebXdwKey77J7n0LdGkmT+eRp+yVczk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kvSdE/Q0UXLke++yKv/arkXHmkZgrabKCetERpspki+9fyVNiMJz9B/uPhir3aHcN
	 AyFmYmfQKzDj1zzKAIjGzeCL6NCguNgn6VfeUhCz+DVwX9cRfElneTZO2O145/I0JC
	 w0XIBkPGUt8pWV17M9GcT3rn7cHq7N5GHq0oXD5b8xWXRs08PuZBwj63wuuuPrY3dE
	 2zWNL21QQgPhnwR8DQ8x31kX45dAzAOnqvtIQI0PQyEyZdooPzUlivAQyf7X4LIohZ
	 rthaZ1nSlqPm4oH6QWDrIYnalXv1UmIw1XGZsyjZ9gy6crtV80B34sVSJF3SMWMFq9
	 N1XTADAG9tEHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:14:40 +0200
Subject: [PATCH net 3/5] mptcp: fix stale skb->sk reference on subflow
 close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-3-6fb595bc86ef@kernel.org>
References: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mIspUK790P4bSDJmTLrkzE/XviU2aKy8rWd6/M7/pQM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi36dGZ9qcufuKe/PRFlP+iOMXxKeJ/48I9Ju5ouvL+
 xrLjVend5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEsoORYf/pPfcsVrtuWHW4
 5JTgLalYR2vJ10w7yh0de5fx9KRfKmNkOLW2lSMy476kfb3p24ZjX9YHMVne4rm4oeGhan0G2xY
 hdgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

The backlog list is updated by mptcp_data_ready() under
mptcp_data_lock(). The cleanup of backlog references to a closing
subflow, however, was performed in mptcp_close_ssk(), before
__mptcp_close_ssk() acquires the ssk lock, and while holding neither
the ssk lock nor mptcp_data_lock().

Because that traversal ran without mptcp_data_lock(), concurrent softirq
RX processing on another CPU (subflow_data_ready() -> mptcp_data_ready()
-> __mptcp_add_backlog(), under mptcp_data_lock()) could add a backlog
entry referencing the ssk while the cleanup loop was in progress. Such
an entry could be missed by the cleanup, or the concurrent list update
could corrupt the traversal, leaving skb->sk pointing at the ssk after
it is freed.

A later mptcp_backlog_purge() then dereferences the stale pointer,
triggering a warning in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
followed by a use-after-free in mptcp_backlog_purge().

Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
subflow->closing is set to 1 and while the ssk lock is still held,
serialized under mptcp_data_lock(). The cleanup runs only on the push
path (MPTCP_CF_PUSH), where backlog references accumulate; on other
teardown paths the caller already handles cleanup.

With subflow->closing set and mptcp_data_lock() held across the purge,
any concurrent mptcp_data_ready() either completes its enqueue before
the purge runs and is caught, or observes closing=1 and bails out. Once
mptcp_data_unlock() is reached, no new skb referencing the ssk can be
enqueued, so the cleanup is exhaustive.

Remove the unprotected traversal from mptcp_close_ssk() entirely.

Fixes: ee458a3f314e ("mptcp: introduce mptcp-level backlog")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b32f0cd262a7..ca644ec53eed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2545,6 +2545,22 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 	}
 }
 
+static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
+	mptcp_data_lock(sk);
+	list_for_each_entry(skb, &msk->backlog_list, list) {
+		if (skb->sk != ssk)
+			continue;
+
+		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+		skb->sk = NULL;
+	}
+	mptcp_data_unlock(sk);
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2568,6 +2584,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	if (flags & MPTCP_CF_PUSH)
+		mptcp_cleanup_ssk_backlog(sk, ssk);
+
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
 	 * the data allocated using such fragment will be freed.
@@ -2659,9 +2678,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct sk_buff *skb;
-
 	/* The first subflow can already be closed or disconnected */
 	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
@@ -2671,17 +2687,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
-	/* Remove any reference from the backlog to this ssk; backlog skbs consume
-	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
-	 */
-	list_for_each_entry(skb, &msk->backlog_list, list) {
-		if (skb->sk != ssk)
-			continue;
-
-		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
-		skb->sk = NULL;
-	}
-
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */

-- 
2.53.0

