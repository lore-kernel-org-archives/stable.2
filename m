Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D8331A46
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617492; cv=none; b=CaRGvkZ9/+h1RIVLwNEwdlCsrYX96o7XXL6OIoqa96jIumaQVBLCN65UtxupzfNRphq62ZgrLbBhMSo7z0Tkfg7Vn/dEYaiOFqN5d/HuRUTDPb5kIJ6xCNC5RzcltwpmBsiyFAyY+oq5Lhwtq32PZzLQ8itzBs+7Fadnd0vT52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617492; c=relaxed/simple;
	bh=8hjHHW0Tb0KBmpG+D9bqhEZLo8cTdwUHd5HQODsWc+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9frnFm3s3+nbZKD3AImFU9DaMOdu81JfEYAG3zWjEbgUSvhOCE8cwTCLWyqUNkPgFZiyh2sInHORttzXcrwL8wMbfSuHBuzhhtd5xSTkvmoRqDdFKfu8Md1Hh2D2A+D2rkENI436HvzhkCXvfyLuRK8pEQSKca9qAX23PF/Nbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxuUb+zU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxuUb+zU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B41F00AC4;
	Tue, 16 Jun 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617490;
	bh=sRpGF9Tj+fE69lyzxnloBd8F9AYX1maGp2c6AtUhAvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxuUb+zUAuWgr10HvuLBxhkBHQS7CLbwqF+E1DVviq7Hu1GhQ3MAfFpz7n/iUY/Yc
	 vOJS7pwitnx5g/3IRCs6gLoppIqRa2vIuH5zXEc0SVTUVwdDv66sLa1Iq6x+C+wMOj
	 KovrN8sbBNKyUCte2fSFIG/0fcFDPCgw5+dgW+RcxP3Q32bSVGUL6iJ6XHMFUB4NXH
	 Rn6+3mSH08m7ki/gVhYtTL2G9GZcZNc3a4bca1dzXYMgOt4GF95oC7C6xF+mCF9S4B
	 +7wnWWqwNnoOUd2K0DuxNUDWzl9Nnc77lnqgQGQwTIzEoEIN9A4qs7GCVwLbArbutj
	 bCiq+K4EpglXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mptcp: add-addr: always drop other suboptions
Date: Tue, 16 Jun 2026 09:44:47 -0400
Message-ID: <20260616134447.3269618-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616134447.3269618-1-sashal@kernel.org>
References: <2026061517-grandpa-bondless-cbaa@gregkh>
 <20260616134447.3269618-1-sashal@kernel.org>
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
index 85fcc378c711f3..09d0a9f8f1d93e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -645,7 +645,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
@@ -656,42 +655,28 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
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
index 00fc7da99cbe49..2338dce25c5f38 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -265,10 +265,9 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
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
@@ -286,10 +285,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
@@ -307,9 +303,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
 		struct net *net = sock_net((struct sock *)msk);
 
-		if (!*drop_other_suboptions)
-			goto out_unlock;
-
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5492c67ecc9a75..c20d4b93f83980 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -829,10 +829,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
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

