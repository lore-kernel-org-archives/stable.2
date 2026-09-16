Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6E4AAC5A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576440; cv=none; b=PyL8gr8QFlMTUtnGOBukndGlB9w9p6pPoVpBAgogk/SxGBjz0PxH7vt+YV1kaQj3nDTcsn28G4aVu86VpMfQZ7bf9wPBN5yeZJ7fijytDqjOS9aslg2elxKvFcqEltHwUdI4hPcus9DuwLBmlDAmCxPAVV5eZVy7ELusYux/SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576440; c=relaxed/simple;
	bh=co29LAeZOGJkY5Dd3w3CrNom8xvVm5EhxCOFEqsI7bQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TxWG1Z0Bf6loX3UoJ400JKxmYJOM7U1/KshYFpuFL/Zm1qz2Bj4jhVbsPGOxUO93kJ+Jr83a8mn0KIlkbo6kaVZlMUHHmjaEEXvNC3TgOpauEjfkywzIfFpaYF8ENtGpoPY7mzMwBNSIu17PjucuSHCXkGS19IqnNNO+xDQlDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCu/4vcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCu/4vcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6AC1F000FF;
	Wed, 16 Sep 2026 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576438;
	bh=tseIaZSIVqizylW6vkU0KnmRCPA4l5mLJnVocYd8cag=;
	h=Subject:To:Cc:From:Date;
	b=TCu/4vcQonf2hvmpt7Kqpr/6geRYxTgnKaDHsX0nqowNvYqu/YaADYm1XSc8XyygC
	 OBQyouoLUFPYOWWa4Vp204mP6rRXSlNyn5xKTXE2BSSH/A2ix094PbltVd2mcRrwgZ
	 QkyVTuM41M5lncA+Fg3l1HhvVMVxqdmxvFbsH2Q0=
Subject: FAILED: patch "[PATCH] mptcp: do not reschedule the RTX timer for fallback sockets" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:29:14 +0100
Message-ID: <2026091614-winking-gigahertz-a159@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e2ab913f68c7d11e2561b8a8ad0b87ffefcad667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091614-winking-gigahertz-a159@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2ab913f68c7d11e2561b8a8ad0b87ffefcad667 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 8 Sep 2026 16:07:06 +0200
Subject: [PATCH] mptcp: do not reschedule the RTX timer for fallback sockets

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f08f71cdb1..be59651e708e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -95,6 +95,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);
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
+	if (!test_bit(MPTCP_RTX_ENABLED, &msk->flags))
 		return;
 
-	tout = mptcp_sk(sk)->timer_ival;
+	tout = msk->timer_ival;
 	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
@@ -3323,6 +3325,9 @@ void mptcp_set_state(struct sock *sk, int state)
 		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
 		 */
 		break;
+	case TCP_CLOSE:
+		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
+		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
@@ -4141,6 +4146,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -4288,6 +4294,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 87ccb84e9927..2b4c27426477 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
+#define MPTCP_RTX_ENABLED	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1

