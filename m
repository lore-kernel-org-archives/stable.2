Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AD305699
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257655; cv=none; b=bNrOdjO6I79tUsZRAKPvDxrW7yn4njaNwdFu78Omb1KGtTtAHM3mCwE2WRudiaV3njmkAT5OvI3CVzK9rSvnMksNkVi3nvIU8IMTo1eOxXpmJUEcWvAsR+t9N1Jv/uxetTbs2CUQNJqf2m929RcG/c8+89w9Pn1iTQykPl438Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257655; c=relaxed/simple;
	bh=XViOdXX0ciytSS1KgoYGFljV8PYMENTtMf4j9QFe7Ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NDoYw+1KxFVMSvaIshto3gYx1mcervlxzRuvX4Psz44+Y1qrhbxJX9xU3H9AAUroE2cnAjwUtH50696BqjFNS6N4K1SkoaRYaZ1GajKFUKvxoyIu9YV5nwdNQWKL0J/2+UQqgCbRwm5zhGVxYtPHTij3fzLt69IjRa6bdDvMBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEe9ENY3; arc=none smtp.client-ip=74.125.224.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEe9ENY3"
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-672e7c0d4d4so1870554d50.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257653; x=1790862453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sB4Dtj6n9lKc7hOiK2+Yd/RhFtCYkxmiDn4ArhaQY/w=;
        b=UEe9ENY3IBJKD05W0reGl7cvrOtdLVf5duRXanipPzMnM5RpmUWoxytM+G1zaLFsZH
         6apBixt7FjL3KkYeOU1RfkQ7A+5gh68PeddR4x3mqMXvYsQ1H/BtT4AF8p8bKUl6LH3R
         YUV9nqZcQGMhih5pR2g5/arDH5QBs5C6CEPs5VTyD44YFTk8NpA+YhFBt4GX84lgAB0K
         sTzfOazfNpI1zTQJ8dpxwBlk7p6DGWUoEXzF+KYUCmd78H0oQqYXw3k1MISscoAmebxN
         b9YghpIeiYT0WiE1Eeq4qH71jIHjWW3btepziSh5s1JMRZ5uMNhIzLZiPeEVxgeqeVwn
         WtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257653; x=1790862453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sB4Dtj6n9lKc7hOiK2+Yd/RhFtCYkxmiDn4ArhaQY/w=;
        b=hvGZZh6UoHVoOL5b4P+nFBpI0O+SIuUIehuqE0KuQra0benCvnpmlYwKvRGnjivzRJ
         kufPiJnr0VoDzm86aGf3E9ItmjMKlXdNprSlH+igGC8tuwDsW1TNcEq5F6GFSJeP8vD3
         o03y4mTOQLaDInynlqPodKL63ickH32bjQNFI0WTDfpjZJtIOk97W3Q60pi+Au/xu6sV
         kuwzDEnkqzo21Jk6OQFuLaP/N/gSCte1Kg4bTPmxi4kVBwctmC+7ndBOEB2giORsDeGO
         kVffPBOfhDJKjMeF7CxTRTJzKlB5X4zJyyHjCqKj6dxLfu1T2PpXgpXbCN4SUI2xItJB
         6gcQ==
X-Forwarded-Encrypted: i=1; AKwUvByEJ/zCjc2vd+ZULpdVVvivqAZuK1Pfa/HiIxLw0MDBNX1ozLuWxXA4jfVTfLgzNvE+iKw6ZTg=@vger.kernel.org
X-Gm-Message-State: AFuF++nTNFsQyulwYpoDG7DQM4Q8Xx6EJV0QGo0Z/zcxn4yct6+CeJLV
	MNgzaGdO04XmK2mVa+W8R2BpY3Ht3BzAD2ftnp/8rMtyu25DrgjO/gM0qRYHCAeomd+vhbqpTH1
	x6Vw8409sV6/0sQ==
X-Received: from qvc20.prod.google.com ([2002:a05:6214:8114:b0:914:1e09:3805])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:134c:b0:673:a6e4:cb7f with SMTP id 956f58d0204a3-673a6e4ceddmr410567d50.29.1790257652495;
 Thu, 24 Sep 2026 06:47:32 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:21 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/9] dlm: fix send buffer backpressure handling
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
Acked-by: Alexander Aring <aahringo@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.56.0.rc1.310.g51773c2048-goog

