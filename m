Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B27541E66
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080047; cv=none; b=ZPBV2+gxFRJVRtIpU3OxPWtZa4weVfG4DR/j6zuXTJXRUN9/yltcIrrE8jet04/K27O+3fdJnhwq5aBpw74Np4eTJneENkc316s0H+mgCfwX1QlpPcJpCgz3OPLPYFuKjbC1TyZZmHuAOEEMtD+hPdgT86aqCDHvRNm3DMQCeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080047; c=relaxed/simple;
	bh=NGNw34AC3ET6yQ4siYmRTxcAglXAdPlRAWh6v17waAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gmYSV6AAczZ003gXwNjM1sSvHyE0G9l5A0Hntb5qfDF41o7wCltlHh53vyzBjjxQ3ND9jbCtqHtsx2c8citFMXC6/NDL99Ck1UIR13+UZxW6EdHBJ1EfjtOlfOwvjR0AARZfn0d/hyrj2qulbcCUqF6I5FWxewDd8fyujpt4OHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxSdXdhh; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxSdXdhh"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a08ff8451so657980385a.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080044; x=1790684844; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kw/aCfaotQ4HaJ3qKwh3HQ7pvI0FmWtuR7ydB0XfF4I=;
        b=XxSdXdhhpigBDUe3TGWPQx2msxRPxR7t9YwkPguu5Owc81Idr1I0GM6HYJ5AZleya9
         PrwCYw/b78ydzHw7/2Fp9x7ZWf/bZhqvbXLdzKHBONPl5Or6OYWVDDeMwjlzXpCyXDhf
         CVvvBRx+o+KrlqoJNdvk86KmLZ8mLCfIYbm0B5oUzzePke0BGvzpaeuJxdRLqlPg8A/v
         dYtHOhAyZ9iZQU/m5UgtnYyN+lLhrB4HIdKZlDTH5+uUWBP7dwUikN/ji1Pulkuio5XO
         DXs0JSi/Zv5mGWNLVuaYPnGVUQRmbE8gKSS0V1zfO0uAhu/sM7/IM0ihujuFydNCCJm/
         f/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080044; x=1790684844;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kw/aCfaotQ4HaJ3qKwh3HQ7pvI0FmWtuR7ydB0XfF4I=;
        b=D4xnarrYGdetTgfesGt8oqHxIjLT5IqM4L6dKNBtwtD6jzjHuIQSFFik0g8yR8a68M
         cBnKfPFDu0ufADr2pI0Rfs8DIgC+kPBn9HDMAWVs2d/RQKbQpdj7m5XAu8RZU/PVhwMz
         I+yaZCzgte87Tiz+qzXcDp6yhvHwHjoode/j2cwxYwK7iC+QUFM/lsBMfLOxi73N8GhS
         wBa3cbb6VKU3lhNv3EbA0YGLi7iGV8WRqUUuSGKhCZdjn6MOVMjTlUSnMEHICyIpd+ks
         9WVuT9UbYc2d4q2CHE5ZyMJyeND5M6/3pt+NFBmOhU8bFFVDTb8NjG8bOseWopFWbMdd
         1MTw==
X-Forwarded-Encrypted: i=1; AKwUvBwoserzWoDKKEpqVESXhsga9DCUPN/rBFriPo/Hm/ayYQp6kwGcUesvvY8KrxHCwtweHTGDmts=@vger.kernel.org
X-Gm-Message-State: AFuF++mIpMbf0Lc+tCAMjwrQSBPQ6HNtIcW2v3QqvXYRCiXEWUzuxXw3
	SWLbV62jWY9BxslgNGLPqQeuvDgTQLgXA2D7t5FVMMzwwDuOF8QkzYV/W+tVLVJHx/XPwY1tche
	Dy6UzFl3NrcvJNA==
X-Received: from qkbi25.prod.google.com ([2002:a05:620a:5219:b0:93c:1df8:e256])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:458a:b0:93b:d79e:18f9 with SMTP id af79cd13be357-93c15e80bfemr540341385a.60.1790080043754;
 Tue, 22 Sep 2026 05:27:23 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:12 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-2-edumazet@google.com>
Subject: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"

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
Cc: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 fs/dlm/lowcomms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7c17de49c41f9fd02a1fae00bcc9e6af5b..abe9ae4c643fae061d2e168c03219a4f4e1bc007 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
 	clear_bit(SOCK_NOSPACE, &con->sock->flags);
 
 	spin_lock_bh(&con->writequeue_lock);
-	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
 		con->sock->sk->sk_write_pending--;
-		clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
-	}
 
 	lowcomms_queue_swork(con);
 	spin_unlock_bh(&con->writequeue_lock);
@@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
 	if (ret == -EAGAIN || ret == 0) {
 		lock_sock(con->sock->sk);
 		spin_lock_bh(&con->writequeue_lock);
-		if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
+		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
 			/* Notify TCP that we're limited by the
 			 * application window size.
-- 
2.55.0.1082.g2b9226bbc0-goog

