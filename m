Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622730;
	b=EQkWLmZ357sVv2C3cBpLis5V4j4a+hN2rig4BXTpz9zEicbadXasYlaAf526tLVkz35c
	 iHZ7oz/Uitq4AHKX2UHY7q51Y96rLLcNs+TTn2dIlGPcRfJOUC/YZcqt0R4TsFMQXo0an
	 99PSwSmUEtzjNXqg3XRVPhGK3kj9xoGhNsqE/qYX7Pg7HMr0x2F7mtHcVlp0brW8vKxeB
	 lkigWUvRvkVFwqouMR6UpZlKQawLFSKWjcMEKq+942whpWkXoUxGmANQG7a6Kkb7vzdzF
	 SMNJOVcOqVGxUVtu9t107H/xhRtDNBaucyO53qib+4xk2ULrKSYgArwpjAAFt326igA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2cOd+xJlutwOjtSPxu+5oZFY75gXTd78WY1kPRng22M=;
	b=2bhEBt9QyJe1s3YTMkhLaAc/j4WGis1z29YCoCba9Xio7ohZyIOdd5qSgNoTKsWRtzY2
	 NpFxSRQSLgBuVoL9KPFGRFkOTHZJL21FtNY4K7ZtloYGWhor/W1dc9YZrQ0Wm3PpFsVwL
	 QCIBKm2yxD4CYBRezsbdlH2i8m40yHIycm4PgXjOfOAt+N3U6tdNDKWHFddIiv4B9Pp4D
	 z7safK8UCp6EsTUmMI6ESD0UlGdK3daso24boun+eev8OcjrxMp3pIpVTx2qdB/bAVQI2
	 /z6+FdOpttB90nK4vM6RD0Abwj56j+r2GmY2VRsdy7B3A733Ig5A9rDNt5meSnwvoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdH7Vj22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48803606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdH7Vj22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575D31F000C0;
	Wed, 25 Nov 2026 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622730;
	bh=2cOd+xJlutwOjtSPxu+5oZFY75gXTd78WY1kPRng22M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdH7Vj22fP+Mb4IVSOkdHg3zltXeRGouuadZ2eQr31OfmkcbIsaIjue0R+eucU6id
	 9ZPh2ZPFUqGZVHJfxVT+LtLRdVG9Iw+HXsM7nUhupWp8GXB5NO9Ejs2qs7TOULRGV3
	 b+hhQcBe2OVvMJa3V8uU1pbWWQfrOY8SC8Nt1sWMUiU/hZDBBgY1g7Y+Vik2bab8vU
	 TEDWdNNlTiSJbyel/LbL832lo9p5j3nW+TXU8B05Rj7wYS13PgudkKPGErkSZLSN1P
	 A2/5YRFJtcQjkehTh7R2y7y2+6mUBnxN5netAnU/n1jZ5BsC9rYXhXFT69dcmthyfQ
	 1r8hgErcQKH/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] netfilter: nf_dup: preserve guard across NFQUEUE reinjection
Date: Wed, 25 Nov 2026 11:05:28 -0500
Message-ID: <20261125160509.666912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-deputy-ipad-7bcb@gregkh>
References: <2026112552-deputy-ipad-7bcb@gregkh>
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
[ sashal: Replaced the per-task in_nf_duplicate guard with the per-CPU nf_skb_duplicated, moved the nf_reinject() edits into nf_queue.c, and dropped the DEBUG_NET_WARN_ONCE assertion and its missing header. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 3e0b166747516..6ff855d21d563 100644
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
index 74d85f7a4f557..eec4a4bcf67f6 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -220,6 +220,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = this_cpu_read(nf_skb_duplicated),
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
@@ -317,21 +318,26 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
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
@@ -354,9 +360,7 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -370,5 +374,8 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	__this_cpu_write(nf_skb_duplicated, old_in_nf_duplicate);
+	local_bh_enable();
 }
 EXPORT_SYMBOL(nf_reinject);
-- 
2.53.0

