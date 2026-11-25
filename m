Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622942;
	b=Tok3j7QqbcJ+M4+MtNrlemd/EU96qJ2fFdl5x4/UJmywuvU3AuOIv5WxAwn3MkQdxqkQ
	 1xLJVp2ffG3jMsp8GgUY03V7skMxI5tl7TSzC1f9Wtzikyl3fNUvN7uFQgt+jAt5ASZdj
	 E/WAcLwL6WLK6ISManUPHHtFDqOJJ51vj3lgQetMnnPMGLfV3PdZjKMZgeNvfJf+WWr/D
	 GTFjQzpa6xDhmwhA+qr0R8KMJb3xAo022M+OimbQhva+UBl8a6Z3VUhf6z01H3UgwmrOt
	 Xhr2GH6Otc9f9+C4uWjznweCyX16sY2dCfjrCByaez0j+KEYMwBm4+rHalHTrVYwCvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FmTV3z4mPbFhOVvlM1wN8UjFlY2sdQ+9fgYKjo5gGRA=;
	b=vpWHxmuspPzyi4oBmIY8M4iS0JEA4g4wP5HDjojcvf/K3dosH3DgCOKOYPSW77bdMY4Y
	 YXgNDVjeh0oNHYCkA+tIzF5UDFXES6dMEEmHuf8oe+cBvvO8Va0a4KkWMjBTZRWCcNURu
	 H+HDh/tuGS5W/2a1wbhO3mllaLZgeTiNFF+sAt/V8iBR6Puzk18lpI1seXwwUAEvmjv7R
	 bsPWJpm1ePDgSC2UsfSUNXdVkVcghYO89/3LE4R9mxhU7yswFBfujVaRQtdgEGn6buqIr
	 47DC778f5h3vBc+ePnafwgBAN5RiRmVpEOnbzhqyNo92gcV2bnp8O1Tdg9s6e1HlJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WB13bW2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67869606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WB13bW2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE421F000D1;
	Wed, 25 Nov 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622941;
	bh=FmTV3z4mPbFhOVvlM1wN8UjFlY2sdQ+9fgYKjo5gGRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WB13bW2yKCgXfYGDRUllCqECRBDjIuJ8jzSIdDJ9Uv5bxsVTwlD40rOjEBa9kH0EE
	 z9mveryW0SmjOCjVRRrVvLJHRy8aqQLXEFbmOnUjJ33zK/rhxhX1j+DGaNtLnHXWnI
	 H8Wau4eGIAFsZvh3sI0ZhMtKKrFKm6HsO/j1weC3e1CCh5OmEIHFo4JcNTIzgb+Vik
	 c3I8q+3kQHEtTAQbPatGNVKSprSZ/Q9tSswChUeva9ruzEBO6T36ZBQTXDBmtvzBtD
	 z+zBCjjOx0JGO9EOXyicFwpXs7rxtlH3xw18JUgxDPiTgNHdFhPJBokLOq6D/GfHRP
	 zqvhnylw34wSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] netfilter: nf_dup: preserve guard across NFQUEUE reinjection
Date: Wed, 25 Nov 2026 11:08:59 -0500
Message-ID: <20261125160836.698569-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112553-fidelity-fetch-aa1e@gregkh>
References: <2026112553-fidelity-fetch-aa1e@gregkh>
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
[ sashal: adapted the guard from the task-local current->in_nf_duplicate to the per-CPU nf_skb_duplicated, and moved the nf_reinject() changes into nf_queue.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 2637d1512929a..3a538ab462de1 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -21,6 +21,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	u16			size; /* sizeof(entry) + saved route keys */
 
 	/* extra space to store route keys */
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 47ed9a353107a..637d1c84d3e58 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -223,6 +223,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = this_cpu_read(nf_skb_duplicated),
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
@@ -320,21 +321,26 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
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
@@ -357,9 +363,7 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -373,5 +377,8 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	__this_cpu_write(nf_skb_duplicated, old_in_nf_duplicate);
+	local_bh_enable();
 }
 EXPORT_SYMBOL(nf_reinject);
-- 
2.53.0

