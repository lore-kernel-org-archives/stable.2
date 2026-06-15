Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68163FBECE
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534601; cv=none; b=i+DpoSvXJThTkxqnkphea8d4vAdztX2mjac/Ub4CfMh7HR5Q7I4MGfTNfht7Zdtg74hGvA+/096QruWmPB4vZQv0h/ZDlvCS72SMVDDv7hloXHJEOQRO8yEh4eRQff0nc/RNIqEMFcaLPtuswtXhuNUNyoiKX9Dvmv9BGiyYvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534601; c=relaxed/simple;
	bh=uFvVAF9+fj+y5+x44nfjmv/D80proNC7WgXaAFsWvtg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hw43f6BB+VruOi6E+4QEBREEFD4GeciSBNAFnDJBx/Gb8QNC8KAAD+knrz34mSY8wps7tEL1COWBFsAzkw5iU5QnHk+cqjfQlFG189RlVbWD4/ZcUJ0aoTeaJwvDQMQIchop8MkrD8lttpEdzWLWcnqcNBWpYQoUJCKQYI4JfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYqT5KZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYqT5KZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46671F000E9;
	Mon, 15 Jun 2026 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534599;
	bh=Jpd8Z4meRpKkK2eEeMTRiCybZElPaX9ITE/AumrujUU=;
	h=Subject:To:Cc:From:Date;
	b=fYqT5KZoPRue+NIYbKibMLhqCeiqpMUU673r/KfabWUhW/pSMmvjAWqz0r/qsnq21
	 Rg0gMZVt776k7pWzXKgMVLvg0H0S4tHDgjR8Q44MmPxxDjwk/laTpJ+GuaCf51nBdY
	 LgqTod6rSth8NaeYxl+NGYTj5R/IplISN1visF5s=
Subject: FAILED: patch "[PATCH] mptcp: add-addr: always drop other suboptions" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:28:11 +0200
Message-ID: <2026061511-yearly-patronage-15bd@gregkh>
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
git cherry-pick -x bd34fa0257261b76964df1c98f44b3cb4ee14620
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061511-yearly-patronage-15bd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd34fa0257261b76964df1c98f44b3cb4ee14620 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 2 Jun 2026 22:14:18 +1000
Subject: [PATCH] mptcp: add-addr: always drop other suboptions

When an ADD_ADDR needs to be sent, it could be prepared if there is
enough remaining space and even if the packet is not a pure ACK. But it
would be dropped soon after.

Indeed, in mptcp_pm_add_addr_signal(), there is enough space to fit a
DSS of 20 octets and an ADD_ADDR echo containing an IPv4 address on 8
octets for example. In this case, the packet would be prepared, the
MPTCP_ADD_ADDR_ECHO bit would be removed from pm->addr_signal, but the
option would be silently dropped in mptcp_established_options_add_addr()
not to override DSS info in the union from 'struct mptcp_out_options',
and also because mptcp_write_options() will enforce mutually exclusion
with DSS.

Instead, don't even try to send an ADD_ADDR if it is not a pure ACK.
Retry for each new packet until a pure-ACK is emitted. That's fine to do
that, because each time an ADD_ADDR (echo) is scheduled, a pure ACK is
queued.

This also simplifies the code, and the skb checks can be done earlier,
before the lock.

Note: also, since commit 6d0060f600ad ("mptcp: Write MPTCP DSS headers
to outgoing data packets"), opts->ahmac would not have been set to 0
when other suboptions were not dropped, and when sending an ADD_ADDR
echo. That would have resulted in sending an ADD_ADDR using garbage
info, where there was not enough space, instead of an echo one without
the ADD_ADDR HMAC.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-11-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f9f587203c35..b3ea7854818f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -665,7 +665,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
@@ -676,36 +675,20 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
-		    &echo, &drop_other_suboptions))
+	    !skb || !skb_is_tcp_pure_ack(skb) ||
+	    !mptcp_pm_add_addr_signal(msk, opt_size, remaining, &addr, &echo))
 		return false;
 
-	/*
-	 * Later on, mptcp_write_options() will enforce mutually exclusion with
-	 * DSS, bail out if such option is set and we can't drop it.
-	 */
-	if (drop_other_suboptions)
-		remaining += opt_size;
-	else if (opts->suboptions & OPTION_MPTCP_DSS)
-		return false;
+	remaining += opt_size;
 
 	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
 	if (remaining < len)
 		return false;
 
 	*size = len;
-	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions\n");
-		opts->suboptions = 0;
-
-		/* note that e.g. DSS could have written into the memory
-		 * aliased by ahmac, we must reset the field here
-		 * to avoid appending the hmac even for ADD_ADDR echo
-		 * options
-		 */
-		opts->ahmac = 0;
-		*size -= opt_size;
-	}
+	pr_debug("drop other suboptions\n");
+	opts->suboptions = 0;
+	*size -= opt_size;
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
@@ -715,6 +698,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 						     &opts->addr);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
+		opts->ahmac = 0;
 	}
 	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..470501470fe5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -887,10 +887,9 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
+			      unsigned int remaining,
+			      struct mptcp_addr_info *addr, bool *echo)
 {
 	bool skip_add_addr = false;
 	int ret = false;
@@ -908,10 +907,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
-	if (skb && skb_is_tcp_pure_ack(skb)) {
-		remaining += opt_size;
-		*drop_other_suboptions = true;
-	}
+	remaining += opt_size;
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	if (*echo) {
@@ -929,9 +925,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
 		struct net *net = sock_net((struct sock *)msk);
 
-		if (!*drop_other_suboptions)
-			goto out_unlock;
-
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4f5aba24da7..b93b878478d2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1229,10 +1229,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
+			      unsigned int remaining,
+			      struct mptcp_addr_info *addr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

