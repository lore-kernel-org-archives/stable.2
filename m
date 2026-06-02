Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992583E3D9C;
	Tue,  2 Jun 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402535; cv=none; b=qabrrv52IFs8t+hs6ouz4s9mhWk/v9e4d8smQb7U3nOfOK/SoyhQWxnGGpup4edUWHTr8r1fZu7DYJ96GVCZ8tZQo2GGDz9RlZjhDvgXbpZBWk3ltwxxvJDI2fP38fs67m02ntb6t12F5YJrGg4Rh/eYj4EHM45KXi8FLqbFq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402535; c=relaxed/simple;
	bh=TDSlEQAI9aZlxLDOKTT6kcPR3WyjMWlmfwcB/s6gTuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofjhl7k6CL6ZgrHUBmX/ugC2ef29AzBOZh7l/Fkfo+WO6IrsNTZ9N2UfWz2KPGLS91ME9ie2ILxceLPyL2CdN9os644IEyOeMXgUta5A5X+4dUYjR65RkTqP+2/ZppGxaVguwY0AZ20uVh9j93ekvMVS9xDAKLpCDT7jtuDDaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWOJcseP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWOJcseP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972FA1F00898;
	Tue,  2 Jun 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402534;
	bh=7Ao7fz5le9HP7KQGswVTuk9qT9seYPLebT7V8Xvs21w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RWOJcsePeC8u1EeVDwb8O1Bsu7LbkIIsSbixSv1vIyNcucPemkZI4pIoJC4VFDWuO
	 69MvMD7TXrnEahO1cGnWGbx0TYvdHNougqzMy/PdScLIIRRD9bIQ8lKgzma7OQZJWf
	 RHgs6gAmNsqvIiagMWlctUsUIRFBgaWz+CdDDyAeSHXpf/BkESpsFosEExPRn8E/8a
	 AAY8ems3bPMHhCWu83mZpp5VOaJGw0G87bJCJiNCf0NLVcbl9KVpbw7LBq5Iyl3iUr
	 LwnjaOWXz2yLl8YfBTUV0Dkiv5lR671cj8c8kvsfUFRAyxDZm0+7kqBP7/5AYnoxDI
	 B363Jc5FPMRLA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:18 +1000
Subject: [PATCH net v2 11/11] mptcp: add-addr: always drop other suboptions
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-11-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6430; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TDSlEQAI9aZlxLDOKTT6kcPR3WyjMWlmfwcB/s6gTuY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksqWDt4HC5gmD0GfGLzgPVqwPwxcuwC+gOG
 AynpAuj02eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c8WpD/9/b//jt2DzgRXft7nDV/WuvXc7F9mMAzIBEbXaUmVBGfahY9Xn8R58arqAuMJErt2YYIt
 7Fo2EwR0I/Jh5hEavSez3PNP1D780a1a46lMdz9RLqBDZMM9GKGTzT7jK/tpk9PvyWX8bW8mV5Q
 xyYhBGsnO+v4ySzCHAUvhMdon1wLeCsdSMP8bw0cI6uFZmFCcntZMIvt8LmqcjH/w40V1r18Z/h
 Y/iYyeFR/VtwVbMhqHklQ0gWUZnOxURVR5s4IxgoORJUMy9mpdhnjxEUTn8oa57mfXNRj71kgLx
 o+jgWTyEt+Xh1nJKj2PDt8Glwz2r/Ffd+FBhl+imQQTQrhRn/bVipRLJa38LCBRpzrcZ4oC49Du
 krJhnU34iTOMGMtDSOvWubqjbuEccAkcq0wh9mFJj1nYMqPgKC+gaaon++Zr04MIlqXXe0oTJE+
 M61BK7Zd4FoRgR4YnkB7GNl5/+HNryhYnkm3+bWWXK0ZJOvWan81V59XOG5MlfKEX2r3Y5YwJjL
 QFRd1jk4ykgOkkXROmruDktXmd0LP+5McwqMkLDrw9sXNbNhpAa2Lgclieh4QDa/zyFHVe8D/on
 nDSvoAlpEh3ou6rBZX4dIwNcdrDvvWns6Hlm/1w2+pLs+YFRcRqbnaVQZOs7owZR8XVGZZDU0UF
 ANYgVL4tPVfCPYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
---
 net/mptcp/options.c  | 30 +++++++-----------------------
 net/mptcp/pm.c       | 15 ++++-----------
 net/mptcp/protocol.h |  7 +++----
 3 files changed, 14 insertions(+), 38 deletions(-)

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

-- 
2.53.0

