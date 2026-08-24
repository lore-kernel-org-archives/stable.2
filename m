Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2446D09D;
	Mon, 24 Aug 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590127; cv=none; b=Blhy4xtlBLy/YLcMb8t5zCR/LPz6u65+PLDDpeC/bpMUNEl/8ZM+VBjuk6s8gWJZx6IKV1X+xcsX0Ynh9r1sXiqrmLX15WB2LnQh5ljFPYHK3A6yVf5pp6c0lHF3+cPvDuKPnNIq+1jryzZAolZC8Gh+gN/JVd0jxA242j9YTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590127; c=relaxed/simple;
	bh=lGgTHG2ZKEPZWmH7Q6U/4MSgDPOsDPE5Cb4PbcyuAZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOKNovjFoSaHW7c/rTXDir2D2DJ98LeuOp8JFJjbgz7Ufheyp3sY1JQStyG7PNd2jVI0tJDarCcJLaIgVA7QB4Ad+2oO4G5bvQ2mp5Euwh44pvd0LFz3JF5w95Mfpe88STQWfpynUuE1Hr4bWQ+fIl5lxfvoh95DeVYNT9FWdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOTcdwTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOTcdwTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26EC1F00A3A;
	Mon, 24 Aug 2026 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590125;
	bh=/OB3yD8YAWHEh42zk3dmZQtCDJh8aZqs6rUdBIApURs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aOTcdwTBm2O4d8Gh0CpHK5KlkCrjxHBAJO022aPHlJ+bwkPlPhqZSO6T2PkeOLFMp
	 sJ8wjxCHc2bftd/LK4G7HvUyUKmvos5Q6sST/J94+aXEYWC/1mxCNC3i9dMuln68XF
	 n1deSidvlIzaNlY2NNF8CHPBSCl9WBO+RE38uvBT5wleWMWztGD+9UaoV1lzjF8hvo
	 IMUU+XpQdp+9DTywh2p3nF6XITZiDMop6xs6KexxS4lcE2jYc5lwu0tlKrjvX7VVpr
	 N4+Vhmo0nAei9w4Cu8HJXtsJUN/6JRSdyiZ3TMwxD3/u55JBpIH/PxdwENJwNSImS5
	 x0rV/3wXZDxmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:21 +0200
Subject: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for
 fallback sockets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=li4fJ4c7IBN9TnNAIhpMPUAd5KkV635EL4tWRzXLfIY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Su9Fey4MNhUtZHnVcLzT+/l2TZWz98Llpjp/lA/f2
 cOZUL+zo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLnwxgZzk+XWnH38rNf/r7t
 P4NWTk72uMFZWnxQOnVzTHNrZKXTZUaGP073XNeGzHPkS6+cdqNyxp76D9lptXrL7N9eezPX8+V
 RbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

On fallback socket the retrans timer is a quite convoluted no-op, but
currently nothing prevents the MPTCP core to keep rescheduling it.

Additionally gate RTX timer reset to the msk not being fallen back to
TCP yet. To avoid adding multiple tests in fast-path, use a new flags
bit for such condition.

Fixes: b51f9b80c032 ("mptcp: introduce MPTCP retransmission timer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 11 ++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a7..23dde0b7144b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -95,6 +95,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	set_bit(MPTCP_RTX_DISABLED, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
@@ -1084,13 +1085,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
 
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	unsigned long tout;
 
-	/* prevent rescheduling on close */
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+	/* Prevent rescheduling on close and in case of fallback. */
+	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
 		return;
 
-	tout = mptcp_sk(sk)->timer_ival;
+	tout = msk->timer_ival;
 	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
@@ -3324,6 +3326,9 @@ void mptcp_set_state(struct sock *sk, int state)
 		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
 		 */
 		break;
+	case TCP_CLOSE:
+		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
+		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 06a107d4e839..6c00a80344f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
+#define MPTCP_RTX_DISABLED	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1

-- 
2.53.0

