Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622490;
	b=iDj6mFx/gX+ub8oqWwSyGBNQTfML5ugFdBhyyiWb0qBgq2PM1uZV4hhJjCV++B6hI1XJ
	 KEdrYYR83k8GV3uH9mKe7bRMQ1psUzYol6UmlsA86boUzAsekvzrLH4LMGV+mI7dwe/mF
	 1iyIcpSAsQwsPAhvTWNlcQqU1RoWSHtI2yg83fzAnSeYkPHGJXo4sFqtCrZSGVo6m3ruG
	 iJs8/S7aIt464lzPLpOgT7pVmmk7OdiaXIPRireUECXr4WlHoz5zbhBRVLTDZtAWnyrMd
	 ctEP4joEBdvgxqQhhrUvRexNq//B79+AGrlradZcdA/JLLkMX4oFT6snnceeg6rbPng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H4Zp2fQDgT90DM06NlRn0jpTg64cA1Ew4vwdM+v5GA0=;
	b=5Q8P/yV1lRolZTnV1fXqFMRRdLJgxkNRb9WoWZUKhqzm5Ee9pmewzxSpYjMwUw0W2eOb
	 GQ0P58Uz7EVX5fZKGor3CWa5IfTscrEadX3Wm0QOPx72PX4q6NenLphX4Tx8Ts+/qBOKX
	 5iDOWqgsx2NvMHDj2LJt0uMPquHAGEu1x5q8DIHPkacb+9CSnDWkvucPWOLPWBVhbyYgW
	 iSeHeZRcafgUNFZDwsh/zczU7/i11PeKI2AUxdEMUTekIx2YpGLoA02v+l8lKSUz+4qkC
	 MZ6lNNRm6/JSpMEy9cTKKrEs6CN2xUHxGWCqsUVbouMEqIm12l0AjuYZFub8Lx29Fhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FyTCLmA3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D430606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FyTCLmA3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6E41F000D0;
	Wed, 25 Nov 2026 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622489;
	bh=H4Zp2fQDgT90DM06NlRn0jpTg64cA1Ew4vwdM+v5GA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FyTCLmA3NlEPc590pZsH2EmjTzyFsQew8gYmYuef4ikDcuusGVGrMrj+P32l6E+eC
	 KY+nhakzej745ZtDfD+ifwYNLwhbDCFtAmcsSsnO323+/DGRa2hKtMAc2Rr48wvLE/
	 rXT1CeDJxGGSFW7TScJz9PgTp/Zu5MkB0mohzeSJMQOj6m6sUkoYyswKFtKSCJJO/p
	 xemfNzohakRFiFrxelIB/KgVEVDpHkiWHok6+wAVlWuUgNf3BwuIZdkwa0geRhhocb
	 PIl0Y3jvXnMHklPSeqGAbpymWcIZvEozhi62n1462OAZUpHAsfHg8oVaNSVoB1SHqN
	 caOAQqlfxKi0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] netfilter: nf_dup: preserve guard across NFQUEUE reinjection
Date: Wed, 25 Nov 2026 11:01:22 -0500
Message-ID: <20261125160115.575356-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125160115.575356-1-sashal@kernel.org>
References: <2026112501-gilled-capsize-0004@gregkh>
 <20261125160115.575356-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 82052e5b5ec36504fe1b9c3c28a711a78fcacf37 ]

NFQUEUE can suspend traversal of a duplicated packet while the task-local
duplication guard is set. The output call then returns and clears the guard
before a later verdict resumes hook traversal.

Save the guard in the queue entry and restore it while reinjection
continues hook traversal. Preserve and restore the verdict task's prior
state, including nested synchronous reinjection.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         |  1 +
 net/netfilter/nfnetlink_queue.c  | 17 ++++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index fc3e81c07364f..039622d489051 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -23,6 +23,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index c0c9ea5fc4e19..e25966a09fe31 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -218,6 +218,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = current->in_nf_duplicate,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5d10a85a2f73d..1d827858155f9 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -37,6 +37,7 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
+#include <net/net_debug.h>
 #include <net/netns/generic.h>
 
 #include <linux/atomic.h>
@@ -344,21 +345,30 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	const struct nf_hook_entry *hook_entry;
 	const struct nf_hook_entries *hooks;
 	struct sk_buff *skb = entry->skb;
+	bool old_in_nf_duplicate;
 	const struct net *net;
 	unsigned int i;
 	int err;
 	u8 pf;
 
+	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate &&
+			    !entry->in_nf_duplicate,
+			    "%s called with unexpected duplication guard",
+			    __func__);
+	local_bh_disable();
+	old_in_nf_duplicate = current->in_nf_duplicate;
+
 	net = entry->state.net;
 	pf = entry->state.pf;
 
+	current->in_nf_duplicate = entry->in_nf_duplicate;
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
 	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
-		return;
+		goto out;
 	}
 
 	hook_entry = &hooks->hooks[i];
@@ -381,9 +391,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -397,6 +405,9 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	current->in_nf_duplicate = old_in_nf_duplicate;
+	local_bh_enable();
 }
 
 /* return true if the entry has an unconfirmed conntrack attached that isn't owned by us
-- 
2.53.0

