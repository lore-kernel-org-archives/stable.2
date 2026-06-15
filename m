Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D43F6C3B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533512; cv=none; b=FNlezTR5KOL/IT1uujOG7MG3/LEVb8T2ce/153gC5/KpRawL039/2g7FrNmtvRAO2YdemYaqWbmIBX5x79QYtllPu4Xp7++zInAt0kV9XWZO9Gaxnjpizc9NnamnWtNRbEt2T1x37pAvbPpuN7pK+ObiOFaS+TsfEKIayuuiU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533512; c=relaxed/simple;
	bh=bKs0JCNw/uEU5uqrPV6f1HdH6NBoaqT/UEt7+L1p53E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=foJoUz9bqquGFBTqfB9m3dvyKF4vh81fYHATzmS5rnbjE6dD+q4/yaHXZxFwHWXQSXoBnruuP4g1FfSftzKFihR+TkrEW6o8ghpXaNJ2oklPkkYtywMh9l4paXaCmL/1qV2b78NG11r90Dr30dRDNAzM/Q5smvIs1uvB3BaguWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nltR7YkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nltR7YkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CA1F00AC4;
	Mon, 15 Jun 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533510;
	bh=NuM0TKBWX9PmBEI4yP0xCwITcaWn1L4osGSQJvoryTg=;
	h=Subject:To:Cc:From:Date;
	b=nltR7YkLYDqtXYkgNRus+zxSiBdBSS4IMO4+UH3dV98N8npTuWAvnvu5CZC7+KhTQ
	 RqDd359jTPP2/3MtUyQRjELqYm22Ousj+q4HC51GGu1ktFxBoKn0dPtPudaLLZ24R9
	 L9HQczVlgvEwfnBnlx9lI1TJjkXAEdjtJdHm9iDg=
Subject: FAILED: patch "[PATCH] mptcp: fix missing wakeups in edge scenarios" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:23:39 +0200
Message-ID: <2026061539-dreadlock-pacifier-9f96@gregkh>
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
git cherry-pick -x 9d8d28738f24b75616d6ca7a27cb4aed88520343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061539-dreadlock-pacifier-9f96@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 

