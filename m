Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C774AB3B7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576929; cv=none; b=nyv7UxM7BO+4J3qzxWt4WMERpc8d6EL3rHUPJPaRbNIXpLu4yHlofb1eFVBtzESpV/wjTmsYXj5Gld5fEdC5DbD31T4KEa6flzZQjNegEt6JqGdMr8VRPzM/SYHhP4ZLhOksZZdP1qlL4x+0Wg0WbNgZlaj1Znb6n6pQ5vPtqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576929; c=relaxed/simple;
	bh=QVs9tgQNAZY8mAI7lTXMcZv5t5TQyR+tlKpLDd86yRw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U7swQO93WzUgj+cAzi9ldXw+3kgNsRn0r9JBPqnZVjzXwbP4nWj+r4hQHkzXDckMpjPucyl/HeeovpvlGc9okFPIVNxt0c4kLb5Hcv8e5lkX6kSHY+taba2isJs+ofJjXoohM5oS1qp6JAgoxoLeJScWw4b6pSBfxktzgux7Djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPZzR+OR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPZzR+OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F71F0089A;
	Wed, 16 Sep 2026 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576923;
	bh=qH8T8zL8x2AUUFmdmZop+OssqjCUL9VOrV5aeYSRQy8=;
	h=Subject:To:Cc:From:Date;
	b=UPZzR+ORH5t+mVXcMpmSss86VE/PN4S1AhcI5CUroN9FV9Xm+U7LLC4YSePJnxlD0
	 yY97cagBHvlNpQCT/rGfyZMCn0IG+EREoFixzd8W/8WsfJ4d4+RgXl7+dMxJWgwxkH
	 43fxB0NsQtI/fOTTqKhjCE6vx02ohaYmGX8iFToI=
Subject: FAILED: patch "[PATCH] mptcp: prevent race between disconnect() and rtx" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:34:21 +0100
Message-ID: <2026091621-borough-happiness-9e59@gregkh>
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
git cherry-pick -x 85c580b0d8590520ae00a15c29e9fb9c99427a3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091621-borough-happiness-9e59@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85c580b0d8590520ae00a15c29e9fb9c99427a3e Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 8 Sep 2026 16:07:11 +0200
Subject: [PATCH] mptcp: prevent race between disconnect() and rtx

Sashiko noted that the two event can race, leading to inconsistent
status. Prevent the race using the synchronous timer stop operation.

Cc: stable@vger.kernel.org
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be59651e708e..d611af2eb74f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3588,6 +3588,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3600,8 +3601,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = icsk->icsk_rto_min;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	mptcp_pm_connection_closed(msk);
 

