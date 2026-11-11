Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372014;
	b=i8K7nHCU+Y9byPF6/NeUsAqLwTM9BVDfY2ESJOzkGfaP/jUIiGu3YnLMPhG4vGiMk5QX
	 TkBW77hl77ampHiwByNbwVTNTF0nYUD5670mK4WKYhvCzvJwEH11edt3EqZdNEHTQc/3b
	 5qtifbWonO1cjNLY/GOnKjHc+h2wy2eC/XAKx5KtKyDbjMs38hMd6qK6HyfeCHbHJn35p
	 fv1k4/jmqL9Ng4WMjW7g6KWokylyeMDWe6XjC9NyTOmj9cj/4z24HgE23G0ir0hKlt55a
	 rViFkQmKpvxLRGrUQd4/BsstUFigfqM128fsvjeOqEDYlGXGn7s5+AM9+d6uX3BYE4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uhhjq+aM4Y2+KreFbcZr12RPwg0HucYhVWn5cZ0B7MI=;
	b=PISZ7Dq3wUQORuaRB2pa6jk75elJhCeFn1Bfc3ByMFAmHQYtscv5OTBlU8tsiUd+wccs
	 PXr2jViNBZbNsXOs/do72XQnXNwOVPbq2Ni3lLfDQF4eVFig7z5WxAQVhNF1pWfd+/U+k
	 FSnXAGYS60LHXlNOqPST+tOVGwBca2Gseqef/pxy2bWjfGzwz1ASPzaLPf8eSs8oUo44m
	 1zgjNNT/2IMZTMr0EX5xrTitaXM61pnlXlTtXCF8/abkKcMMxaa4NLfpZYJQ4/cHCIA0T
	 FBxiYwCV8XGHHu0vIf2VJyloutb88HIWvLzPpTloKNAsLuCZX6KLt59SNIX6HPKRrEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0f+duFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0f+duFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE9B1F0089F;
	Wed, 11 Nov 2026 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372013;
	bh=uhhjq+aM4Y2+KreFbcZr12RPwg0HucYhVWn5cZ0B7MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0f+duFq6FbD/e8Bvy5oDIaIseEeID8VqhmM/d83MZ05I3stxbtwXD0gC3KOGUP7k
	 7pOxRm8NnephuifjPH6bi4gOGHSVxBcaJDQNSmklV1EDJsNc0cHHXZoJCKFVVTH/NR
	 rkkNKLTBiJ8KKmOc1WgCFknEiQxZBCjC0YPsh7Mpbn4sDYroDSZqYKtAcshfsdkbOm
	 uqDP/ZaO6TZOOqL0vVgt0P0utEk5EUDMUueMxF244MxbvkqgnnWQp1FQSIFXnD9trX
	 aIFyBFIplYb9DUE4QTJeQ2JhxRaH31FwfQFiX88GuAw5uGQv5pq7VEbxdv4VFmlE7q
	 2tNJDqBoxDXKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dlm: fix send buffer backpressure handling
Date: Tue, 10 Nov 2026 23:40:11 -0500
Message-ID: <20261111043958.1124343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061905-failed-5.10-e234d7625598@kernel.org>
References: <20261107061905-failed-5.10-e234d7625598@kernel.org>
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

From: Eric Dumazet <edumazet@kernel.org>

[ Upstream commit e234d7625598b2eaded84fa99f53c8062650828f ]

lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
but this bit has not been stored there for ten years.

Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
the bit from socket->flags to the RCU protected socket_wq->flags, where
it is reachable only through sk_set_bit() and sk_clear_bit(), and is
only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
sockets, which never have SOCK_FASYNC set, and never sets the bit
itself, so the test in send_to_sock() has been false ever since.

The consequence is that when sock_sendmsg() returns -EAGAIN because the
socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
increment sk_write_pending, and does not return DLM_IO_END to wait for
lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
process_send_sockets() immediately requeues the send work.  A connection
to a peer that is slow to drain thus keeps cycling through
sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
reports that space is available again.

Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
lowcomms_write_space() already clears.  This restores the semantics dlm
had before the bit moved.

Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
lowcomms_write_space(), for the same reason.

SCTP connections are deliberately left as they are.  SCTP does not set
SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
lowcomms_write_space() is thus never invoked for an SCTP connection, and
the test added here stays false, so send_to_sock() keeps returning
DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
returning DLM_IO_END would wait for a callback that never comes.

Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
Cc: stable@vger.kernel.org
Cc: David Teigland <teigland@redhat.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20260929071743.23624-2-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adapted the flag check to the existing kernel_sendpage() loop while retaining its -EAGAIN guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 68b765369c928..f3311621b67f7 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -421,10 +421,8 @@ static void lowcomms_write_space(struct sock *sk)
 
 	clear_bit(SOCK_NOSPACE, &con->sock->flags);
 
-	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
 		con->sock->sk->sk_write_pending--;
-		clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
-	}
 
 	queue_work(send_workqueue, &con->swork);
 out:
@@ -1435,7 +1433,7 @@ static void send_to_sock(struct connection *con)
 					      msg_flags);
 			if (ret == -EAGAIN || ret == 0) {
 				if (ret == -EAGAIN &&
-				    test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
+				    test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 				    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
 					/* Notify TCP that we're limited by the
 					 * application window size.
-- 
2.53.0

