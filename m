Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048280;
	b=IxgYNaVXza9FjXX5X691Udqrb/LsJtotYbEbQ/Z3c40VjPFo7UUy1cAOkV0XXtFaaQ3R
	 DsD5qu15/E0tlTKBeiazEWcnwQFKPB07QPccNOCIqYo/BP+kutuL8TdldBxSRGma1Ost+
	 E/Fv4PxHihTmBLXMZIJQIQ+6kOdlsdNTPef5q+xIbTpznTwj6PZaG3+Yff7sfzs/V78YI
	 fwD6AvWQlhwkeO5v9RarpJlWJdrZfeJU1Kk3nvCxZifXGaRAprGN+J93TAd9Ee8090UNx
	 ukp1aNHPf1RIfebenniKqCxLRRoIK27JNgv7iyhBmKuXaa2vMUSgI2R/HyjysG6JrpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pElnO3z2wuOHoD7Ln3dqX3KX5P995BBlt3Vhhft2FlE=;
	b=kGw+JXQcPYH427RRARlE1q/xtrRZqJt5bm1dqDU9oPDlCjDAM9quem8JIBXgbRsk3qLj
	 iWX4q10DkOwyuq6ncc7cAXqj6tJD56h6u5cTpmeYk8FxduVoOqSlsc/zlbop5LOLmyXG9
	 4vz6yQzLDrsp4HkSjv6ivy/GFCyMAwY19dBsMOq/bjTmR7QNHRSpbzeBjWbaoH64S9jXg
	 slB+YR9EmZgvsrcVn5qS0XQHJfGkh2xzBk4cIpVuQNSLDA5q/76UEM3bWl2nsW2FK8g5y
	 NcjDyhduWmp8f4cuYMctKPkG5nWnVbZkgaI3fa0/nRWV/rczO4uq8vnO8X+ulf8P+iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVN5bunt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B448606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVN5bunt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4991F0089F;
	Sat,  7 Nov 2026 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048280;
	bh=pElnO3z2wuOHoD7Ln3dqX3KX5P995BBlt3Vhhft2FlE=;
	h=From:To:Cc:Subject:Date;
	b=VVN5buntvGt9ZmIr5STGbt+IxLk/1HeD8fSdKw7DKLWNnDv830su4K+BEtiNJG53x
	 Ue87FahQ9OtyPbNSlgPqNJ2xHBV9Hg1KREQZvr3b3oV9n9WROamHCn+oHHL92OkfXc
	 iyYNIN5yD55qEHuZRSV7hOCyolQtrDWbgv4hyYCYwsGZPjDpUo5Ub/KqGGGHdriCdm
	 w1vqTWoXPTE4mXb26So7ZPryjTupAxzbCyUBGGXqyYX39MYl39BdNWPD1bBy4if+HE
	 DzmNwAgFrUOyu8BWsaPloH50rHVlOh0+opyUb0s2PyuuL4GVO2rs2gJxczTV9SnqOv
	 JjUpYm1oIHHAw==
From: Sasha Levin <sashal@kernel.org>
To: edumazet@kernel.org,
	teigland@redhat.com,
	aahringo@redhat.com,
	kuniyu@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dlm: fix send buffer backpressure handling" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:37 -0500
Message-ID: <20261107054437-failed-6.1-e234d7625598@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e234d7625598b2eaded84fa99f53c8062650828f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054437-failed-6.1-e234d7625598@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e234d7625598b2eaded84fa99f53c8062650828f Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 29 Sep 2026 07:17:35 +0000
Subject: [PATCH] dlm: fix send buffer backpressure handling

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
---
 fs/dlm/lowcomms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7c17de4..abe9ae4c643fa 100644
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
2.53.0




