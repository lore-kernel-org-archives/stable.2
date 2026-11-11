Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371531;
	b=oL2EXZHIA0lFuAqzVZwHwR4/HxG8IF4cGakCc1spd+m7L0t5MbVINq4eDuA0XDEeoaIC
	 RiftRgByaTLx4YDi0MT5Od/+6QMotHpsaR+ZX6ZtlRHvQoVqckly0FVYGMWJTLRCu27Ko
	 Gv0sy6woYRUZChCj/MT5szJdrQvedRcM0HNs6qDmwZJOFNb8TcXnN/YvrCvN8o+dbxSgw
	 ywcfN/Jcl10V2h1WqwcVc+yZKjPkp0IpoQxmpgdgVLqjVzHSyBwB0pVzkHE8mel0TXXp+
	 2fiRqx2YXa+toyfxkIKVA2YJa6Ph6YnocjQ6mfjgHBMkFA1aE9s7y95UoYOR3aTIXwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PGOmZID1tJsuaCwPlZa97JVxdd2feOGBOsA+NQsqrBo=;
	b=guvjbltpGpHmfAkzfonzDpEJn+xNttqwhJ8rSWOLShm1cdd+ihWHoeZ2AmRCSZsgcuAp
	 K6maxuy+WQKFM8iZZkT7sTXHihzEpcqofKUxNEWYLfy0xtUqGN5rT4AYYKP/niSefnDmg
	 Uqevj9iFtWKbnO3cPsS3mlbiaNhbU1aLwDVT92oyJsSodiV+iVx217QiOfqWHQxugVzab
	 Cj9ra5HSHHgeDk1rz1RxNlGThoXkC8D1YLpQ5jyycP11BMtnQ1+paeimjLdsp5NjD/8Gf
	 9Ab2jxH3SXeEBpt3jZt5ulWTKZcwof4S9FpnQsio7LNCQPUrA/agPCtlKCzN1WGW4rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vkk2POMg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C7606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vkk2POMg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9711F0089F;
	Wed, 11 Nov 2026 04:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371530;
	bh=PGOmZID1tJsuaCwPlZa97JVxdd2feOGBOsA+NQsqrBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vkk2POMgYJ8LphEfgt9L7esKivqtLWOMIv8Iv+ym7ndt5JAWAwWEaJMXFjgBTPMIo
	 jp/PMrkdQW9NmCf1gcx/J22TibvhGSpTYmDLECOQ55lGslkutT2lzywvSvKomGNf/L
	 Bsy9VASNKMpT399emUDM4Jwp1v6zczwlvAkdzArCIx7sTa83dKiy5SDPucgUvDDI9z
	 Bggs94hI/OLZ+H5BL2HZyNoeVYDi2bEyOi5K2REkaKJ6T+BeKY2uy3mQqst0W8/bKM
	 PriWNjkbdkUKF//PPpQxC8raIaxNzuQ3qOvYUCBY0NOm+Nl2zkbNneV9lb0oEi76uW
	 Eb9tU79tUJ20A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dlm: fix send buffer backpressure handling
Date: Tue, 10 Nov 2026 23:32:08 -0500
Message-ID: <20261111043128.1115372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060227-failed-5.15-e234d7625598@kernel.org>
References: <20261107060227-failed-5.15-e234d7625598@kernel.org>
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
[ sashal: adjusted context around the existing ret == -EAGAIN guard in send_to_sock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 5b53425554077..80aae70431fea 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -518,10 +518,8 @@ static void lowcomms_write_space(struct sock *sk)
 
 	clear_bit(SOCK_NOSPACE, &con->sock->flags);
 
-	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
 		con->sock->sk->sk_write_pending--;
-		clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
-	}
 
 	queue_work(send_workqueue, &con->swork);
 out:
@@ -1417,7 +1415,7 @@ static void send_to_sock(struct connection *con)
 				      msg_flags);
 		if (ret == -EAGAIN || ret == 0) {
 			if (ret == -EAGAIN &&
-			    test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
+			    test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 			    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
 				/* Notify TCP that we're limited by the
 				 * application window size.
-- 
2.53.0

