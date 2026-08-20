Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77A40D59E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222560; cv=none; b=bl9twAxr5GyNCJBDtDu8tf0QL4R+qq3d9ODaHeWYVN+qWs3wVLAgq1Pz+wNl8OINkaee60dj8bmriTYsTH7XXkas+dAI+QHW5XLSIfFfzonghOsRx1jiw6MyC0sVBGGn/WwIWUIxmfARrBF2C7vupPem0awir3tKUslr430N4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222560; c=relaxed/simple;
	bh=WKnrc6qQSSD0e7wJafVTx7jJ/T/ADrLa0e/0MqJwmtk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kpPS/5yg6ZlkdgX+mV2/se/kqYC3NXwW5wFK9FpzGHYKKCpmH5KnwjOLGvTdBjsOl1ywSPxvenPgRABhh4vD8+JIjhhaDHFYyhSXyzgwuitqTJ30CXhGL5IqpOUaKHBBVG7eOWV+aWCCAJvlYY8Xxyl/EIX1vutaFAdnzNee3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ybAJK/Y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ybAJK/Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607901F000E9;
	Thu, 20 Aug 2026 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222558;
	bh=MI864ENCF1/ZZCjYf/4/K/tX2Eqm0MzUj2SKeGqe9HM=;
	h=Subject:To:Cc:From:Date;
	b=ybAJK/Y478vI0VML3W4b5AY95kwycqNnY5NmaLvM5+YdW/PCWSi94+zXJbm2HJ3YZ
	 7CgUKn+EL+vlT1vED7+0u58aZonyzyUhR9TmY8eEwoMoatPUYTkAa5+j9UjcVWcu3o
	 HiYJ8LjPtj6wXNS43GjTXJeBNwHK6ilMf7i+a3sg=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix data race in add_addr timer callback" failed to apply to 6.1-stable tree
To: luoqing@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:42:25 +0200
Message-ID: <2026082025-sitter-talisman-7358@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a7aad5b69d3bdaec20a3ed9284e184502450c0cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082025-sitter-talisman-7358@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7aad5b69d3bdaec20a3ed9284e184502450c0cd Mon Sep 17 00:00:00 2001
From: Qing Luo <luoqing@kylinos.cn>
Date: Mon, 3 Aug 2026 18:16:36 +0200
Subject: [PATCH] mptcp: pm: fix data race in add_addr timer callback

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

I discovered this issue while studying the code. AI tools helped me to
verify the issue can potentially happen under race conditions.

Use a local 'retransmit' flag set inside pm.lock to capture whether
retransmission is still possible when the lock is taken. This allows to
call mptcp_pm_subflow_established() accordingly, and not depending on
the situation that can be different when checked outside the pm.lock.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-4-b8f496d71664@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..c71dcf887683 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,7 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -412,14 +413,15 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (retransmit)
 		timeout <<= entry->retrans_times;
 	else
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:

