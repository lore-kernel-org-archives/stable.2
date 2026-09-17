Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FB2D0602
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617869; cv=none; b=nviRpJPf1Re/EY9XCqujfcl5N3eEMxiKUSlIn4mnTgq9s6/6+urtXLB1z4zOq1TQzeqKtbLB3iFErKqsSFkxcgZhnPYkY9pckFiA5Vtm/gXpRNssD0XIyLnb1ISKIGnfPfKErGlg1KYqDvVKQpovEPntQ+7qX32hZ6Q7eFGwX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617869; c=relaxed/simple;
	bh=WURv0mrHiwoERJccbYCnYKcBOc5amizpheMfMS4CnlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noJBXnuYH2y6leL7tjrNP/eopTBVNlYZoY4gq1iHwKNNWVUt7bGjYQ76qXnYQA0ds1srXzio3b3Yh7F8kGdukv0Dga4wCq8bDMGQ5MgZlaLFO8NX/3G6cCVK017k6g2qkloSr3nbeG0n6uZXAmzXhTyJOWPb6QNbap5q+J3OJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEvM5zzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEvM5zzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D131F000FF;
	Thu, 17 Sep 2026 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617867;
	bh=U72o2ZsRpoD43+uzm+tXDZoYLmPWsbXa4/3T33CV8KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEvM5zzViecVUKKNBMcuBzcjRHCXhOZh7G7DpyIaNB/Offta0QiwChsfAawHzaKLN
	 AgbVRztGfISnocfqFB47+GVIu83H0NBcKfRnRCKruKUkGL7sxCuWnPD3o2DLNxTTRb
	 e8qnfwZvPIx4C1FphfYkVKjvyOc06v7xjTuMt55FlIbcKnBlp/XDq+D7AqamsYjBRj
	 CRoJgXr2xu7AlhgaKyDXaHR423t87y2BshCuSgT+MjzCiSu9p89fW+PUxEaUMUkzXb
	 CMReyCVMrsE7S04YjDqpG6NZ2JgBJdu1v8+8+3SP8gq+afJ6GafS9IkAtRFLVq+HMi
	 8E0rLS9xCnj6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: do not reschedule the RTX timer for fallback sockets
Date: Thu, 17 Sep 2026 00:04:25 -0400
Message-ID: <20260917040425.4162844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091614-winking-gigahertz-a159@gregkh>
References: <2026091614-winking-gigahertz-a159@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit e2ab913f68c7d11e2561b8a8ad0b87ffefcad667 ]

On fallback socket the retrans timer is a quite convoluted no-op, but
currently nothing prevents the MPTCP core to keep rescheduling it.

Additionally gate RTX timer reset to the msk not being fallen back to
TCP yet. To avoid adding multiple tests in fast-path, use a new flags
bit for such condition.

The RTX enable bit is clear at close time and set before the msk could
start retransmitting, with a couple of caveats:

- passive sockets inherit the bit from the listener msk; set the bit on
  such socket to avoid flipping it in the fast-path, even if the
  listener will obviously never retransmit.

- while fastopening (MPTFO), mptcp_sendmsg_fastopen still ends-up
  calling mptcp_connect via tcp_sendmsg_fastopen ->
  __inet_stream_connect(ssk->sk_socket), and the first subflow's
  sk_socket points to the msk one.

Fixes: b51f9b80c032 ("mptcp: introduce MPTCP retransmission timer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ changed MPTCP_RTX_ENABLED from bit 4 to unused bit 6 to avoid conflicting with MPTCP_FALLBACK_DONE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 12 +++++++++---
 net/mptcp/protocol.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 127438ef120e6..8de25a4571201 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -977,13 +977,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	unsigned long tout;
 
-	/* prevent rescheduling on close */
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+	/* Prevent rescheduling on close and in case of fallback. */
+	if (!test_bit(MPTCP_RTX_ENABLED, &msk->flags))
 		return;
 
-	tout = mptcp_sk(sk)->timer_ival;
+	tout = msk->timer_ival;
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 
@@ -3064,6 +3065,9 @@ void mptcp_set_state(struct sock *sk, int state)
 		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
 		 */
 		break;
+	case TCP_CLOSE:
+		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
+		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
@@ -3897,6 +3901,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -4040,6 +4045,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af00d64e61f4b..511f2adf19fd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_RTX		2
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_RTX_ENABLED	6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -1133,6 +1134,7 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
 }
-- 
2.53.0

