Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392B4B8277
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576471; cv=none; b=T8/n00AgQnPNEo9WlSoD+q440gnZELcGj8jNRGK9/oATdp1YYnPvkDVmrW0Ylg+XT+8VEdUSShT9st4kRSVW3g+nfCTNOw6BNbShkI9DCdnT0IA4Y33JCRlRRB+T6S7r2/Uywek26oCNiXXNEtV1Ec9ZFdSvCsKi4kwlSE55SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576471; c=relaxed/simple;
	bh=qetj+lEXdSFYP8htO3EukF63qyEWaBa1gFBjbyxOXs0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lGgQ8GJOTeXyD+JfB2OJgM98WvxwbswIs/+eHlQKpoQI31M3THULEmW0qATb36K0w6cTjMN3jxevk5w4ZQOWs+5qZjn6FRUCECElNyyjqfYtpfimkdzEORgPBCadGxCw8Ak+tcap5Tl38GlBSLdaH//IJfj5MbZFYMfP1Edt85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRl5bnWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRl5bnWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6CE1F00893;
	Wed, 16 Sep 2026 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576468;
	bh=DzeLAGrdMudr5OcgTEVhuf0KzrdlzlL3flIbtFxyf6E=;
	h=Subject:To:Cc:From:Date;
	b=ZRl5bnWfqO79M0tQwKqoEze8dhNLfg9iWuYEOX+8Wr/AxZVpM8q0AC7o6H75fqGB2
	 x9m+yNjTwu5PDsCI+Rdaa+CuObFGyFBoE4qIMQqavBhYN9FoiurJKPjT4KZ8yveJMl
	 0oPBSigPNS7jNvH9z88C1fxe6W7uMTMEtBqmWXZg=
Subject: FAILED: patch "[PATCH] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0" failed to apply to 6.1-stable tree
To: kalpan.jani@mpiricsoftware.com,cuitao@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:31:04 +0100
Message-ID: <2026091604-overhung-liqueur-670b@gregkh>
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
git cherry-pick -x 2ac7d6e620764f1fc79eb4edd3610a7a661981ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091604-overhung-liqueur-670b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ac7d6e620764f1fc79eb4edd3610a7a661981ca Mon Sep 17 00:00:00 2001
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Date: Tue, 8 Sep 2026 16:07:09 +0200
Subject: [PATCH] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint. This happens because the id 0
removal path does not tear down pending announcements, unlike the non-zero
id path.

When the PM later reselects id 0 after adding another signal endpoint, it
finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
in mptcp_pm_announced_alloc().

Root cause: asymmetry between removal paths.
- Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
  mptcp_pm_remove_announced() to clean up.
- Id 0 path: mptcp_nl_remove_id_zero_address() skips cleanup entirely.

Fix by making the id 0 path symmetric: call mptcp_pm_announced_remove()
and decrement add_addr_signaled before queuing the RM_ADDR.

Subtle detail: signal endpoints are stored in anno_list with port 0, but
msk_local carries the connection's local port. In other words, entries
linked to ID0 paths should have port == 0. A follow-up patch will ensure
that. mptcp_pm_announced_remove() uses use_port=true for comparison. So
clear the port before the lookup.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Cc: stable@vger.kernel.org
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 424f1a7f9248..1a7750813235 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1137,6 +1137,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address. */
+		anno_addr = msk_local;
+		anno_addr.port = 0;
+		announced = mptcp_pm_announced_remove(msk, &anno_addr);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);

