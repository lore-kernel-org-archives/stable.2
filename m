Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465EA30DEA3
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617112; cv=none; b=g8TVyvZcZfuY2+5Zof3voXU3i5AIAwmxGC0o/2Y5qIvZFbOwnnM9Rxcw9VBllzMRR8YW/iAUMuP5QyFGiEQXj/m9FYasbhkm07TCtnUfu+2IjalIOdX3V8NKNohd/hB2lBZhmE7eQjrVLHXHWIu1mlnDQKFV8mEWrUZfFCJN0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617112; c=relaxed/simple;
	bh=T2Pvzdx7r2rrdkOLTr1LrEEUPAzgAGi1DiZn9SKHsmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO/jm1sQMMM8ZE6R7Jg1yv8kIQWKtrSFs0hlDNO+8CUoUtt1U0Fw8jPIFFDL4MlTxmBROcW1azC2yZjvi8k64LMEHVbWzPhnyxE3YwmD3KBDcXFMNB0w4F9629xlDDMLlQXfuiJ6qVvG8N/yMEQkAY1GRBnR4+yqPFPlSlTRNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNh+Jl5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNh+Jl5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAA91F00A3A;
	Tue, 16 Jun 2026 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617111;
	bh=o+xBi1vZOZA5lTHbKhDwF3qjNsUYnUvcqFe+4FTmJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNh+Jl5GUsz+HM6C70HLk3Bgx814xlbdI0TYNVELbjD98yPtWyfX9Etc4340uFFPm
	 9l4ehI/m63QgZWD0s3aDHBM34sxnfKLTHvRKqb7jnJdVmRHopWT5dEx3s/z3wdZ9kn
	 9h9GjKk49EA5YvI7DqAJTp2P4kcol61O7xYA9znohDM0h8lbmXnZUPl9TYcqrSajfY
	 jnRIMgu4i7UP3kAF4+yuKwmha3/tM/xYnGr5JBSHe1Vo0wU0jEIHYu/y24zS0FCx2E
	 lFlvgSHOv1mfjd9OSPvsshSOC5RJfkv7s/XiMF5nSFevbZoE6vNpYE6eVacR+m2Jmj
	 0TtDXST9FjyYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mptcp: add-addr: always drop other suboptions
Date: Tue, 16 Jun 2026 09:38:28 -0400
Message-ID: <20260616133828.3255825-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616133828.3255825-1-sashal@kernel.org>
References: <2026061515-snowsuit-tackling-58ce@gregkh>
 <20260616133828.3255825-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit bd34fa0257261b76964df1c98f44b3cb4ee14620 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c  | 31 ++++++++-----------------------
 net/mptcp/pm.c       | 15 ++++-----------
 net/mptcp/protocol.h |  7 +++----
 3 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eab815d42ac6ae..8e2539b20ba8ca 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -657,7 +657,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
@@ -668,42 +667,28 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
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
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->addr);
+	} else {
+		opts->ahmac = 0;
 	}
 	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 80de3e8df5cfcb..e4cf9d9cca1cda 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -335,10 +335,9 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 /* path manager helpers */
 
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
@@ -356,10 +355,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
@@ -377,9 +373,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
 		struct net *net = sock_net((struct sock *)msk);
 
-		if (!*drop_other_suboptions)
-			goto out_unlock;
-
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fb3e6ac71bd36f..3e175b917fbb83 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,10 +920,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
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
-- 
2.53.0

