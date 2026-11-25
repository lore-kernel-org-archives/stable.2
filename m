Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622412;
	b=VhJmzUAy7JRi98HhSxopm/IburZuA/BXUQPxSqUK78hoHmq5utEJSpTqoSkA/06jZ4lp
	 Htk0CscDz8yJbcyhM09JWr50V3hI4Omda92FZ37FPqBmNF3Zf9UG9G7iKxi8ngODieIFE
	 jFnmwCAcma3Gh6PqLw8yIXfevi9LLjnXrDppvKYxY6IBi1cK/Y0igQB3H1lF2yee+h+xk
	 igcSH/2tPPE6xXOcaPrOo7uFqhFl+40rVFshME2s+HTtt7+ub5EZ8/Sb1QU2014k1g1jz
	 u37PyPQVhWjNOKP4s3kuiZUOBrklnws2OFaoqYgWlwM2GWyFCas67ppK2LgQ8KEAhPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YhXJS5gyozZVPKyMsAvvSK19t/5oYBPdTvAYWjK5YyQ=;
	b=MNT+oHfSp55iVLGzuzVxEOjN6XFNSdYMoxtEyYPFVtl7QvxsZvbiDhhcYsE00LJevhKd
	 /YmPcN77/1zucM11PJhCMrRLVxfx/62qBXWosQKUvvyfA+ZHCOXrRfrsW/Vb+jGODIyIb
	 fVGAxHoMKknNMtviW/TV1vTpTmF9IzxIms3q3AdzEPiAf2LzCIYc20qnX7zPGFFJzBBSy
	 8Y/0pcG9TfCbT6xtrTod7qlUGRzYuD7eatRGa7Xk6v9xKLsePHPIB1byLqla+rgUy7OQm
	 BIHbI8tEjGOvbS4Ocd8fA3M+3JnNP6Q5BBcZDpGO76ehzCgIyMWnYWdF8D1FXa2IkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK0zLXMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D4606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK0zLXMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D361C1F000ED;
	Wed, 25 Nov 2026 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622411;
	bh=YhXJS5gyozZVPKyMsAvvSK19t/5oYBPdTvAYWjK5YyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oK0zLXMi3e3T8yogKHBstxvBTEepfPKnCYcx6YBcjcmFXa6LprqvupUUgsY2YwfLo
	 TsHhplMM97XrGr2EGnWEVwxGZ71rmzXl81KEuU9CvrH8s9gzPKqd2Eakd/uXH4RqLD
	 RC0HiDqNH+J8dXvfQ5TCXNWQsruzhB0P+jwEHqqsynKsPAyG768Xo5lAGNl0a5M2/r
	 MyyUgQW+k3uNycf++fTAJwgGPBHWflipWetHNDdNL6cxZKKWqsnNeXmlf1h8LpVAHC
	 6ZWJlT+4mFK+P7mqe1pCXhjWdLahoQV5doOW4+rbT6W2CPQoABVtebk7b7GPdJgxyl
	 auNd/GPP+/qeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] netfilter: nf_dup: preserve guard across NFQUEUE reinjection
Date: Wed, 25 Nov 2026 11:00:09 -0500
Message-ID: <20261125155944.642713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-outrage-proton-1df4@gregkh>
References: <2026112552-outrage-proton-1df4@gregkh>
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
[ sashal: adapted to use the per-CPU nf_skb_duplicated guard instead of current->in_nf_duplicate, and moved the nf_reinject changes into nf_queue.c with its older WARN_ON_ONCE/kfree_skb code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 4cf158b5ea698..1aedf2967a56f 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -21,6 +21,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 2579f94e37444..7f3c24dccf015 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -218,6 +218,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = this_cpu_read(nf_skb_duplicated),
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
@@ -315,21 +316,26 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	const struct nf_hook_entry *hook_entry;
 	const struct nf_hook_entries *hooks;
 	struct sk_buff *skb = entry->skb;
+	bool old_in_nf_duplicate;
 	const struct net *net;
 	unsigned int i;
 	int err;
 	u8 pf;
 
+	local_bh_disable();
+	old_in_nf_duplicate = __this_cpu_read(nf_skb_duplicated);
+
 	net = entry->state.net;
 	pf = entry->state.pf;
 
+	__this_cpu_write(nf_skb_duplicated, entry->in_nf_duplicate);
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
 	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
 		kfree_skb(skb);
 		nf_queue_entry_free(entry);
-		return;
+		goto out;
 	}
 
 	hook_entry = &hooks->hooks[i];
@@ -352,9 +358,7 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -368,5 +372,8 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	__this_cpu_write(nf_skb_duplicated, old_in_nf_duplicate);
+	local_bh_enable();
 }
 EXPORT_SYMBOL(nf_reinject);
-- 
2.53.0

