Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7413F7A9A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533542; cv=none; b=lCG+TNkUjW+Avyd+KOxNZY/O9Mfs99y9DnnQmI6fyt6UPblJamI/4vBQ0OvqBZIrvGG5YR6GcE3QJRPUCquHCmeQkVUB75P6dVaWfjMSEfS3WUU/t6+hM5lvsOlNN3A5t2NCbkSy3bU0RSJpc7b0FChfFw7Y/Y5I56rIXBdw294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533542; c=relaxed/simple;
	bh=XaUFxH/JVp86j1pek35gr0z2e1YtcpAhHNBasYo5YRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ovNRlPTGUzgf9uJrBz/Y1UAAJeMfCXiCKFhUEuxJtKf6XMrRcRPUs6GbeDo8xzR6zSG1bRf2i2fOV3eqaoXXCK0CfkaYaUWGXydNpF+TvzRODJR59hQguKtywvmxH765OHz1Hexxdo8CoxlvdS/Eft+wAcfCw3COFCCI05jAmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lTw0QZh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lTw0QZh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE49D1F000E9;
	Mon, 15 Jun 2026 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533540;
	bh=oQiCJeRrzQD5UkLqfUB9RGIBZL/JkEm7jQBMb4CYi5g=;
	h=Subject:To:Cc:From:Date;
	b=lTw0QZh7xFRAzJN4AbkFKCsD2VfcyLY3b3Qc+YFyEUmTUBliBaZ2YqzuoO+IOmtvT
	 UA2PmiqdRAzDTvrhgNN3g0wIcWU8nAlE7IrJF+6uCdG1OvBfwCB2whV++QoRS2RIZN
	 dt7z69d44VClYIqXnrQWq0uVgdSMqto8o/UGwyCo=
Subject: FAILED: patch "[PATCH] mptcp: fix missing wakeups in edge scenarios" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:23:49 +0200
Message-ID: <2026061549-throat-iodine-b864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9d8d28738f24b75616d6ca7a27cb4aed88520343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061549-throat-iodine-b864@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d8d28738f24b75616d6ca7a27cb4aed88520343 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 2 Jun 2026 22:14:08 +1000
Subject: [PATCH] mptcp: fix missing wakeups in edge scenarios

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b..5a20ab2789ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,6 +2276,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 	mptcp_data_unlock(sk);
+
+	if (enqueued && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
 	return enqueued;
 }
 

